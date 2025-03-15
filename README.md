Using vim golf to grow nvim skills

## How To

```sh
nu toolkit.nu get-latest-challenge
git add -A
nu toolkit.nu try-challenge # select challenge, select mode
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
  - [x] ex mode
  - [x] normal+visual mode
  - [ ] macro mode
  - [ ] insert mode (`vim -c 'startinsert' FILENAME`)
  - [ ] lua (`vim -c 'luafile lua-mode.txt' FILENAME`)

## Problems

- How to verify solutions in pipeline?
