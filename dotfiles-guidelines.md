
- These are managed with chezmoi, so this dir isn't ~ but that's intentional
- pi modifies the config when it updates, so we deal with this:

```
~:) chezmoi apply
.pi/agent/settings.json has changed since chezmoi last wrote it?
.pi/agent/trust.json has changed since chezmoi last wrote it?
thadryan@darlene:~/Vaults/Projects/Dotfiles(main)
~:)
```
    - As far as I can tell this is harmless because it doesn't inform anything
    - The dot_pi version is always right in terms of configuration and skills
- I usually us pi and but sometimes use opencode (opencode is my models so my main work account isn't dinged for personal stuff). This means:
    - Models in opencode should match pi (not usually the other way around)
    - Skills in pi should be ported to opencode

