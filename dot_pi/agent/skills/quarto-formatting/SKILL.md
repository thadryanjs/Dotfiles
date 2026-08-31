---
description: "Formatting spec for Quarto manuscripts (.qmd)"
---

# Quarto Formatting

I am using Quarto (`.qmd`) to write reports. Quarto allows mixing markdown and executable code blocks. The formatting philosophy is to create a hyper-transparent report — a "math proof for code" — where every transformation is traceable and proven.

## Structure

- **Frontmatter**: YAML block at the top of the file. DO NOT delete this; it contains critical project metadata and rendering options.
- **Markdown**: Use for narrative, headers, and explanation.
- **Code Blocks**: Use standard Quarto syntax:
  ```
  ```{r}
  # Code goes here
  ```
  ```

## Style
- Put two spaces after each code chunk.
- Put one space after each markdown chunk.

## Code Checking & Transparency
The goal is absolute traceability. 

- **Demo Immediately**: Functions should be demonstrated right after they're defined.
- **Prove Everything**: Every time data is mutated, filtered, or transformed, show a "before and after" print (e.g., `head()` or `tail()`) so the change is visible.
- **Atomic Output**: One cell per print. If a cell prints something, end the cell there. This prevents a "wall of output" at the bottom and allows mapping output directly to the specific line of code that produced it.

Example workflow:
1. Code cell: Filter dataset.
2. Code cell: Print `head()` of filtered dataset.
3. Code cell: Next transformation.
4. Code cell: Print `head()` of result.

## Math Formulas

If the code is derived from a mathematical formula, the formula MUST be placed in a markdown block immediately above the code chunk.

Example:
```
### Submodel 1 Formula (Equation 7)
$$
\begin{aligned}
\max Z^- &=\sum_{s\in\mathcal{S}}\sum_{a\in\mathcal{A}(s)}\underline{r}(s,a)\;x^-(s,a)\\
\text{s.t.} \quad &\sum_{a\in\mathcal{A}(i)}x^-(i,a)
-\gamma\sum_{j\in\mathcal{S}}\sum_{a\in\mathcal{A}(j)}p'(i\mid j,a)\,x^-(j,a)
\le\alpha(i),\quad\forall i\in\mathcal{S},\\
&x^-(s,a)\ge 0,\quad\forall (s,a)\in\mathcal{K}
\end{aligned}
$$

```{r}
def build_submodel1(A_U, b_U, c_L):
    # implementation...
```
```

General rules:
- Every mutation/filter must have a before and after print.
- One cell per print.
- Math precedes implementation.
