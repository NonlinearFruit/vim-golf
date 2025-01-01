Using vim golf to grow nvim skills

## How To

```sh
nu toolkit.nu get-latest-challenge
git add -A
vim -w puzzle-folder/normal-mode.txt puzzle-folder/input.txt
nu toolkit.nu run-challenge # select challenge, select mode
git add -A
git commit -m 'Solve $PUZZLE'
```

## Ideas

- Generate the readme
  - Name of problem
  - Link to folder
  - Link to vim golf problem
  - Help docs for toolkit
  - For each mode:
      - Name of mode
      - Number of bytes in file
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

- How to verify solutions in pipeline?
