
Using vim golf to grow nvim skills

## Scores

|challenge|ex|lua|normal|
|---|---|---|---|
| [Case matching substitution](case-matching-substitution) | [157 B](case-matching-substitution/ex-mode.vim) | [626 B](case-matching-substitution/lua-mode.lua) | [235 B](case-matching-substitution/normal-mode.txt) |
| [Change class fields from camel case to snake case](change-class-fields-from-camel-case-to-snake-case) | [24 B](change-class-fields-from-camel-case-to-snake-case/ex-mode.vim) | [492 B](change-class-fields-from-camel-case-to-snake-case/lua-mode.lua) | [31 B](change-class-fields-from-camel-case-to-snake-case/normal-mode.txt) |
| [Change class fields from snake case to camel case](change-class-fields-from-snake-case-to-camel-case) | [19 B](change-class-fields-from-snake-case-to-camel-case/ex-mode.vim) | [322 B](change-class-fields-from-snake-case-to-camel-case/lua-mode.lua) | [15 B](change-class-fields-from-snake-case-to-camel-case/normal-mode.txt) |
| [Circle of fifths with sharps](circle-of-fifths-with-sharps) | [122 B](circle-of-fifths-with-sharps/ex-mode.vim) | [406 B](circle-of-fifths-with-sharps/lua-mode.lua) | [46 B](circle-of-fifths-with-sharps/normal-mode.txt) |
| [From brakets to parens](from-brakets-to-parens) | [35 B](from-brakets-to-parens/ex-mode.vim) | [342 B](from-brakets-to-parens/lua-mode.lua) | [47 B](from-brakets-to-parens/normal-mode.txt) |
| [Reordering properties](reordering-properties) | [84 B](reordering-properties/ex-mode.vim) | [393 B](reordering-properties/lua-mode.lua) | [85 B](reordering-properties/normal-mode.txt) |
| [replace-markdown-sections-with-numbering](replace-markdown-sections-with-numbering) | [90 B](replace-markdown-sections-with-numbering/ex-mode.vim) | [517 B](replace-markdown-sections-with-numbering/lua-mode.lua) | [55 B](replace-markdown-sections-with-numbering/normal-mode.txt) |
| [Sort and Tag](sort-and-tag) | [124 B](sort-and-tag/ex-mode.vim) | [625 B](sort-and-tag/lua-mode.lua) | [64 B](sort-and-tag/normal-mode.txt) |
| [YAML to dotenv](yaml-to-dotenv) | [22 B](yaml-to-dotenv/ex-mode.vim) | [69 B](yaml-to-dotenv/lua-mode.lua) | [45 B](yaml-to-dotenv/normal-mode.txt) |
| [π](π) | [57 B](π/ex-mode.vim) | [218 B](π/lua-mode.lua) |  |

## How To

```sh
./toolkit.nu get-latest-challenge
git add -A
./toolkit.nu try-challenge # select challenge, select mode
./toolkit.nu run-challenge # select challenge, select mode
./toolkit.nu update-readme
git add -A
git commit -m "Solve $PUZZLE in $MODE mode"
```

## Help


<details><summary>toolkit download-challenge</summary>

```
Usage:
  > download-challenge <title> <challenge_id> <description> 

Flags:
  -h, --help: Display the help message for this command

Parameters:
  title <any>
  challenge_id <any>
  description <any>

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
  > get-latest-challenge 

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
  > run-challenge {flags} 

Flags:
  --challenge <string> (default: '')
  --mode <string> (default: '')
  -h, --help: Display the help message for this command

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
  > try-challenge 

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
  > update-readme 

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
    

