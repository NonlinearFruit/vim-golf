export def update [] {
$"
Using vim golf to grow nvim skills

## Scores

(table-of-scores)

## How To

```sh
./toolkit.nu get-latest-challenge
git add -A
./toolkit.nu try-challenge # select challenge, select mode
./toolkit.nu run-challenge # select challenge, select mode
./toolkit.nu update-readme
git add -A
git commit -m \"Solve $PUZZLE in $MODE mode\"
```

## Help

(help-docs)
"
  | save -f README.md
}

def table-of-scores [] {
  ls */*-mode.*
  | rename --column { size: score }
  | insert challenge { get name | path parse | get parent }
  | insert mode { get name | path parse | get stem | str replace '-mode' '' }
  | group-by challenge
  | transpose challenge data
  | each {|x|
    $x.data
    | reduce --fold { challenge: $x.challenge } {|y, acc|
      $acc | insert $y.mode $y.score
    }
  }
  | default '' ex
  | default '' normal
  | default '' lua
  | each {|x|
    $"| (row-title $x) | (top-score $x) | (as-hyperlink $x ex) | (as-hyperlink $x lua) | (as-hyperlink $x normal) |"
  }
  | prepend ["|challenge|best|ex|lua|normal|" "|---|---|---|---|---|"]
  | str join (char newline)
}

def row-title [x] {
  [ $x.challenge README.md ]
  | path join
  | open $in
  | lines
  | first
  | str replace --regex '# \[(.*)\].*' "$1"
  | $"[($in)]\(($x.challenge))"
}

def top-score [x] {
  plugin use query
  print $x.challenge
  [ $x.challenge README.md ]
  | path join
  | open $in
  | lines
  | first
  | str replace --regex '# \[.*\]\((.*)\)' "$1"
  | $"($in).html"
  | http get $in
  | query web -q '.grid_5 > .clearfix > div > b > a'
  | flatten
  | into int
  | math min
}

def as-hyperlink [record mode] {
  ls $record.challenge
  | get name
  | where $it =~ $'($mode)-mode\.'
  | if ($in | is-empty) {
    ""
  } else {
    first
    | $"[($record | get $mode)]\(($in))"
  }
}

def help-docs [] {
  scope modules
  | where name == toolkit
  | get commands.0.name
  | each {|cmd|
    ^nu -c $"use toolkit.nu; toolkit ($cmd) -h"
    | str trim
    | $"
<details><summary>toolkit ($cmd)</summary>

```
($in)
```
</details>
    "
  }
  | to text
  | ansi strip
}
