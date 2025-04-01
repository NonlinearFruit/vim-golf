
Using vim golf to grow nvim skills

## Scores

|challenge|ex|lua|normal|
|---|---|---|---|
| [Case matching substitution](https://www.vimgolf.com/challenges/9v006661427f00000000027a) | [183 B](case-matching-substitution/ex-mode.txt) |  |  |
| [Change class fields from camel case to snake case](https://www.vimgolf.com/challenges/9v0067056336000000000514) | [24 B](change-class-fields-from-camel-case-to-snake-case/ex-mode.txt) |  | [31 B](change-class-fields-from-camel-case-to-snake-case/normal-mode.txt) |
| [Change class fields from snake case to camel case](https://www.vimgolf.com/challenges/9v006705493c000000000513) | [19 B](change-class-fields-from-snake-case-to-camel-case/ex-mode.txt) |  | [15 B](change-class-fields-from-snake-case-to-camel-case/normal-mode.txt) |
| [Circle of fifths with sharps]() | [122 B](circle-of-fifths-with-sharps/ex-mode.txt) |  |  |
| [Reordering properties](https://www.vimgolf.com/challenges/9v0067a47b9200000000069f) | [84 B](reordering-properties/ex-mode.txt) | [393 B](reordering-properties/lua-mode.lua) |  |
| [replace-markdown-sections-with-numbering](https://www.vimgolf.com/challenges/9v00671803aa000000000555) |  | [517 B](replace-markdown-sections-with-numbering/lua-mode.lua) | [67 B](replace-markdown-sections-with-numbering/normal-mode.txt) |
| [Sort and Tag](https://www.vimgolf.com/challenges/9v006763eed900000000067e) |  | [625 B](sort-and-tag/lua-mode.lua) | [64 B](sort-and-tag/normal-mode.txt) |
| [YAML to dotenv](https://www.vimgolf.com/challenges/9v00674f1bfb00000000063d) | [22 B](yaml-to-dotenv/ex-mode.txt) | [69 B](yaml-to-dotenv/lua-mode.lua) | [45 B](yaml-to-dotenv/normal-mode.txt) |

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
    

