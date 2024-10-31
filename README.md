Using vim golf to grow nvim skills

## How To

```sh
nu toolkit.nu get-latest-challenge
git add -A
vim -w puzzle-folder/normal-mode.txt puzzle-folder/input.txt
git diff --no-index puzzle-folder/input.txt puzzle-folder/output.txt
git restore .
git add -A
git commit -m 'Solve something something puzzle'
```

## Ideas

- Generate the readme
- Possible solution constraints
  - ex mode
  - normal+visual mode
  - macro mode
  - insert mode
  - lua
- Expand to other editors
  - Helix
  - kakoune

## Problems

- How to verify solutions?
  - Is it possible to execute these scripts and compare the output?
    - <https://stackoverflow.com/a/9445742/4769802>
  - Is it possible to automate this with nushell?
