---
description: "General code review pass. Flags correctness, clarity, and footgun issues — with extra scrutiny for code about to be launched on a long-running job."
---

# Code Review

Do a careful read of the code in scope. Your job is to find problems the author would want to know about before this code runs in anger — bugs, fragility, silent failures, and habits that will cost time later.

## How to report findings

Output a **single numbered list** of findings. One issue per item. No grouped bullets under a number. Number continuously across all sections so the user can say things like *"fix 3, skip 4, explain 7, show me a diff for 9"*.

Each item follows this shape:

```
N. [SECTION] [SEVERITY] One-line summary
   Where: path:line (or function/section name)
   Why it matters: one or two sentences
   Suggested fix: concrete change, or "needs discussion" if non-obvious
```

Severity tags: **BUG** (will produce wrong results or crash), **RISK** (likely to bite under some inputs / environments), **SMELL** (works but fragile or confusing), **NIT** (style, naming, minor clarity).

Order findings by severity, then by likely time-cost if missed. Put BUGs first. Do not pad — if there's nothing wrong in a section, don't invent something. If the whole file is clean, say so in one sentence and stop.

After the list, end with a one-line **Pre-flight verdict**: either *"Safe to launch"*, *"Launch after fixing [numbers]"*, or *"Do not launch — see [numbers]"*.

---

## What to look for

### Paths & files
- Relative paths that break depending on launch directory — prefer absolute paths or anchor to `__file__`
- Output directory doesn't exist (crash on first write) — `mkdir -p` or `os.makedirs(..., exist_ok=True)`
- Output directory exists and isn't empty — silent overwrite or append to stale results
- Input glob matches zero files → silent no-op loop
- Input glob matches more than intended (e.g. `*.txt` sweeping in `backup/*.txt`)
- Hardcoded paths from another machine or a previous experiment
- File extension assumptions (`.jpg` vs `.jpeg`, `.tar.gz` vs `.tgz`)
- Case-sensitivity differences (works on macOS, breaks on Linux)
- Trailing-slash inconsistencies in path joins

### Variables & references
- Undefined variables, especially ones only set inside an `if` branch
- Typos that silently create new variables instead of erroring (Python especially)
- Loop variable shadowing an outer variable
- Notebook-only variables that won't exist on a fresh kernel run
- Off-by-one in `range()`, slicing, or `enumerate` starts
- Mutable default arguments (`def f(x=[])`)
- Reusing the same list/dict reference when a copy was intended

### Control flow & data handling
- `try/except` swallowing the real error and continuing with bad data
- Bare `except:` or `except Exception:` hiding `KeyboardInterrupt`
- `continue` on error producing an empty output that's never noticed
- Accumulating into a collection that was never initialized outside the loop
- Writing inside the loop but opening the file in `"w"` mode each time (overwrites) — or the inverse
- Iterating over a dict/set and relying on order when you shouldn't
- Modifying a collection while iterating it

### I/O
- Opening files without `with` → leaked handles, lost buffered writes on crash
- No flush/close before a long blocking call → if it dies, output is empty
- CSV without headers, or headers written every iteration
- JSON dumps without `ensure_ascii=False` mangling unicode; default indent inflating file size
- Encoding not set explicitly (`utf-8` vs `utf-8-sig` vs `latin-1`)
- Reading huge files with `.read()` instead of streaming
- Pickle files depending on class definitions that have moved or been renamed

### Logic landmines
- Integer vs float division (`/` vs `//`)
- Comparing floats with `==`
- `None` slipping through where a number/string was expected
- Empty list/dict being falsy and triggering the wrong branch
- Sorting numeric strings lexicographically (`"10" < "2"`)
- Datetime tz-naive vs tz-aware mixed
- Random seed not set when reproducibility matters

### Clarity & maintenance (lighter touch — usually NIT)
- Functions doing two unrelated things
- Magic numbers without names
- Dead code or commented-out blocks
- Names that lie about what the thing does
- Duplicated logic that should be one function

---

## Extra scrutiny for long-running jobs

Apply this section **only if** the code looks like it will run for more than a few minutes (loops over large datasets, model training, batch API calls, data pipelines, scrapes). Flag these as **RISK** or **BUG** even when they'd be NIT-level in a short script — the cost of a silent failure 5 hours in is enormous.

- **No checkpointing.** One bad row kills hours of work. Should at minimum write partial results to disk periodically.
- **Checkpoints that overwrite each other.** If the latest checkpoint is corrupt, there's no fallback. Rotate or keep the last N.
- **Checkpoints written to volatile storage** (`/tmp`, ephemeral containers).
- **Resume logic** that re-processes finished items, or worse, skips items it shouldn't. Verify the "have I done this one?" check actually works.
- **No progress signal.** No `tqdm`, no periodic log line. You won't know if it's stuck.
- **No early validation.** The script does 30 minutes of setup before discovering input is malformed. Validate inputs and write a test output in the first 10 seconds.
- **Errors silently dropped per-item.** If 90% of items fail, the run should not look successful. Count failures and surface them.
- **Output written only at the end.** If it crashes at hour 5, you have nothing. Stream results to disk.
- **No flush on the log file.** Crash → empty log → no idea what happened.
- **Network/API calls without retry + backoff.** A single transient blip kills the run.
- **Rate limits not respected.** Hits the wall partway through and either crashes or gets the account throttled.
- **No estimate of total cost / time / API spend** before launch. Especially for paid API calls — back-of-envelope this before kicking off.
- **No dry-run mode.** No way to run end-to-end on 1–5 items to shake out the above in 30 seconds.
- **Non-deterministic ordering** combined with resume logic — items processed in different order on resume can corrupt outputs keyed by index.

### Pre-flight ritual
Strongly recommend running the full pipeline end-to-end on 1–5 items before the real launch. If the code doesn't support that easily, flag *that* as a finding.
