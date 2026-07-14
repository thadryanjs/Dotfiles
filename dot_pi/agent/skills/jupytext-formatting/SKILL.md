---
description: "Formatting spec for a tool to make Python scrupts into notebook"
---

# Jupytext Formatting

I am using `jupytext` so I can write normal Python scripts and compile them to jupyter notebooks to read after for QC/reporting. The formatting is like this for code:

## Example

```
# %% [code]
# print("Hello")
```
...and this for markdown:
```
# %% [markdown]
# # Level 1 Header
# Regular text
# ## Level 2 Header
# ...

# %% [code]
# back to code
```

Note that because there is an initial comment, a level 1 header actually has 2 comment signs, and so on. If you forget to "close" the markdown portion (ie, switch back to code by putting a code block), it will just continue to interpret it as markdown breaking the script by sticking markdown into a code file.


## Frontmatter

There will be a block like the following at the top of the notebook. Models delete it all the time - DO NOT DO THIS - it is there for a reason.

---
# ---
# jupyter:
#   jupytext:
#     cell_metadata_filter: title,-all
#     formats: ipynb,py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.18.1
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---
```

## Style
- Put two spaces after each code chunk
- Put one space after each markdown chunk


## Code Checking
Generally speaking, functions should be demonstrated right after they're defined.

```python
def build_submodel1(A_U, b_U, c_L):
    """Build SM1 arrays with explicit loops."""
    m, n = A_U.shape

    obj = np.zeros(n)
    for j in range(n):

    obj[j] = -float(c_L[j])
    A_ub = np.zeros((m, n))
    b_ub = np.zeros(m)
    for i in range(m):
        for j in range(n):
            A_ub[i, j] = float(A_U[i, j])
        b_ub[i] = float(b_U[i])

    bounds = []
    for _j in range(n):
        bounds.append((0.0, None))

    return obj, A_ub, b_ub, bounds

# %% [code]
# Small test data for inline demos
_A_L = np.array([[1.0, 1.6], [3.0, 2.0]])
_A_U = np.array([[1.1, 1.8], [4.0, 3.0]])
_b_L = np.array([11.6, 5.0])
_b_U = np.array([12.0, 7.0])
_c_L = np.array([3.0, 1.0])
_c_U = np.array([3.5, 1.2])

# test build_submodel1
build_submodel1(_A_U, _b_U, _c_L)
```

For code printing out multiple values, prefer f/multiline strings to repeated print calls, ie:

```
print(
    f"""Step 2: Stability Check
    Spectral radius rho = {rho:.4f}
    Stable (rho < 1)? {stable}
    Matches paper? {matches_paper}
"""
)
```

## Math Formulas

If the code is derived from a mathmatical formula, it should be put above the code chunk.

```
# ### Submodel 1 Formula (Equation 7)
# $
# \begin{aligned}
# \max Z^- &=\sum_{s\in\mathcal{S}}\sum_{a\in\mathcal{A}(s)}\underline{r}(s,a)\;x^-(s,a)\\
# \text{s.t.} \quad &\sum_{a\in\mathcal{A}(i)}x^-(i,a)
# -\gamma\sum_{j\in\mathcal{S}}\sum_{a\in\mathcal{A}(j)}p'(i\mid j,a)\,x^-(j,a)
# \le\alpha(i),\quad\forall i\in\mathcal{S},\\
# &x^-(s,a)\ge 0,\quad\forall (s,a)\in\mathcal{K}
# \end{aligned}
# $
def build_submodel1(A_U, b_U, c_L):
    """Build SM1 arrays with explicit loops."""
    m, n = A_U.shape

    obj = np.zeros(n)
    for j in range(n):
        obj[j] = -float(c_L[j])

    A_ub = np.zeros((m, n))
    b_ub = np.zeros(m)
    for i in range(m):
        for j in range(n):
            A_ub[i, j] = float(A_U[i, j])
        b_ub[i] = float(b_U[i])

    bounds = []
    for _j in range(n):
        bounds.append((0.0, None))

    return obj, A_ub, b_ub, bounds
```

Note that because jupytext uses comments to define none-code cells, for an expression like like this:

```
$$
x=1
$$
```
...it has to be:

```
# %% [markdown]
# $$
# x=1
# $$
```
