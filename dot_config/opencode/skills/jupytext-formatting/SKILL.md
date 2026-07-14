---
name: jupytertext-formatting
description: Make Python scripts that compile to jupyter notebooks
compatibility: opencode
---

I am using `jupytext` so I can write normal Python scripts and compile them to jupyter notebooks to read after for QC/reporting. The formatting is like this for code:

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

Note that because there is an initial comment, a level 2 header actually has 2 comment signs, and so on. If you forget to "close" the markdown portion, it will just be markdown text and the script will break so be careful of that.

When I say to add LaTeX, it needs to fit in that format. So it can't be:

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

Put two spaces after each chunk no matter what it is.
