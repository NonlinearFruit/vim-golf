
<div align="center">

  <img src="nvim-golf.svg" alt="nvim golf icon" width="400" height="400"/>

  <a href="https://www.vimgolf.com/38899/NonlinearFruit"><img alt="NonlinearFruit's vimgolf profile" src="https://img.shields.io/badge/vimgolf-nonlinearfruit-green?logo=vim"></a>
<a href=""><img alt="Number of solved challenges" src="https://img.shields.io/badge/challenges-16-yellow"></a>
<a href=""><img alt="Average best score" src="https://img.shields.io/badge/best-21.2-blue"></a>
<a href=""><img alt="Average ex score" src="https://img.shields.io/badge/ex-65.5-teal"></a>
<a href=""><img alt="Average lua score" src="https://img.shields.io/badge/lua-285.4-orange"></a>
<a href=""><img alt="Average normal score" src="https://img.shields.io/badge/normal-53.3-purple"></a>
<a href=""><img alt="Number of solutions missing" src="https://img.shields.io/badge/missing-3-red"></a>


</div>

## Scores

|challenge|best|ex|lua|normal|
|---|---|---|---|---|
| [Case matching substitution](case-matching-substitution) | 31 | [149 B](case-matching-substitution/ex-mode.vim) | [322 B](case-matching-substitution/lua-mode.lua) | [235 B](case-matching-substitution/normal-mode.txt) |
| [Change class fields from camel case to snake case](change-class-fields-from-camel-case-to-snake-case) | 18 | [19 B](change-class-fields-from-camel-case-to-snake-case/ex-mode.vim) | [492 B](change-class-fields-from-camel-case-to-snake-case/lua-mode.lua) | [20 B](change-class-fields-from-camel-case-to-snake-case/normal-mode.txt) |
| [Change class fields from snake case to camel case](change-class-fields-from-snake-case-to-camel-case) | 13 | [19 B](change-class-fields-from-snake-case-to-camel-case/ex-mode.vim) | [322 B](change-class-fields-from-snake-case-to-camel-case/lua-mode.lua) | [13 B](change-class-fields-from-snake-case-to-camel-case/normal-mode.txt) |
| [Checkerboard case pattern](checkerboard-case-pattern) | 15 | [31 B](checkerboard-case-pattern/ex-mode.vim) | [100 B](checkerboard-case-pattern/lua-mode.lua) | [28 B](checkerboard-case-pattern/normal-mode.txt) |
| [Circle of fifths with sharps](circle-of-fifths-with-sharps) | 24 | [107 B](circle-of-fifths-with-sharps/ex-mode.vim) | [406 B](circle-of-fifths-with-sharps/lua-mode.lua) | [46 B](circle-of-fifths-with-sharps/normal-mode.txt) |
| [Flip All Bits](flip-all-bits) | 29 | [33 B](flip-all-bits/ex-mode.vim) |  |  |
| [From brakets to parens](from-brakets-to-parens) | 24 | [35 B](from-brakets-to-parens/ex-mode.vim) | [342 B](from-brakets-to-parens/lua-mode.lua) | [47 B](from-brakets-to-parens/normal-mode.txt) |
| [Reordering properties](reordering-properties) | 24 | [84 B](reordering-properties/ex-mode.vim) | [393 B](reordering-properties/lua-mode.lua) | [85 B](reordering-properties/normal-mode.txt) |
| [Replace markdown sections with numbering](replace-markdown-sections-with-numbering) | 29 | [90 B](replace-markdown-sections-with-numbering/ex-mode.vim) | [517 B](replace-markdown-sections-with-numbering/lua-mode.lua) | [55 B](replace-markdown-sections-with-numbering/normal-mode.txt) |
| [Rural Post](rural-post) | 9 | [9 B](rural-post/ex-mode.vim) | [204 B](rural-post/lua-mode.lua) | [10 B](rural-post/normal-mode.txt) |
| [Simple text editing with Vim](simple-text-editing-with-vim) | 13 | [12 B](simple-text-editing-with-vim/ex-mode.vim) | [145 B](simple-text-editing-with-vim/lua-mode.lua) | [15 B](simple-text-editing-with-vim/normal-mode.txt) |
| [snowflake fractal](snowflake-fractal) | 26 | [269 B](snowflake-fractal/ex-mode.vim) | [336 B](snowflake-fractal/lua-mode.lua) | [53 B](snowflake-fractal/normal-mode.txt) |
| [Sort and Tag](sort-and-tag) | 36 | [83 B](sort-and-tag/ex-mode.vim) | [129 B](sort-and-tag/lua-mode.lua) | [64 B](sort-and-tag/normal-mode.txt) |
| [Whitespace, empty lines and tabs](whitespace,-empty-lines-and-tabs) | 16 | [29 B](whitespace,-empty-lines-and-tabs/ex-mode.vim) |  | [35 B](whitespace,-empty-lines-and-tabs/normal-mode.txt) |
| [YAML to dotenv](yaml-to-dotenv) | 16 | [22 B](yaml-to-dotenv/ex-mode.vim) | [69 B](yaml-to-dotenv/lua-mode.lua) | [45 B](yaml-to-dotenv/normal-mode.txt) |
| [π](π) | 16 | [57 B](π/ex-mode.vim) | [218 B](π/lua-mode.lua) | [48 B](π/normal-mode.txt) |

## How To (local)

```sh
./toolkit.nu get-latest-challenge
git add -A
./toolkit.nu try-challenge # select challenge, select mode
./toolkit.nu run-challenge # select challenge, select mode
./toolkit.nu update-readme
git add -A
git commit -m "Solve $PUZZLE in $MODE mode"
```

# How To (vimgolf.com)

```sh
podman run --rm -it -e key=$VIMGOLF_KEY ghcr.io/filbranden/vimgolf $CHALLENGE_ID
```

## Help


<details><summary>toolkit download-challenge</summary>

```
Usage:
  > toolkit download-challenge <challenge_id> 

Flags:
  -h, --help: Display the help message for this command

Parameters:
  challenge_id <any>

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```
</details>
    

<details><summary>toolkit get-latest-challenge</summary>

```
Usage:
  > toolkit get-latest-challenge 

Flags:
  -h, --help: Display the help message for this command

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```
</details>
    

<details><summary>toolkit random-challenge</summary>

```
Usage:
  > toolkit random-challenge 

Flags:
  -h, --help: Display the help message for this command

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```
</details>
    

<details><summary>toolkit run-challenge</summary>

```
Usage:
  > toolkit run-challenge {flags} 

Flags:
  -h, --help: Display the help message for this command
  -c, --challenge <string> (default: '')
  -m, --mode <string> (default: '')

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```
</details>
    

<details><summary>toolkit try-challenge</summary>

```
Usage:
  > toolkit try-challenge 

Flags:
  -h, --help: Display the help message for this command

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```
</details>
    

<details><summary>toolkit update-readme</summary>

```
Usage:
  > toolkit update-readme 

Flags:
  -h, --help: Display the help message for this command

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```
</details>
    

