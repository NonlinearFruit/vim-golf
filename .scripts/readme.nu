export def update [] {
$"
<div align=\"center\">

  <img src=\"nvim-golf.svg\" alt=\"nvim golf icon\" width=\"400\" height=\"400\"/>

  (badges)

</div>

## Scores

(table-of-scores)

## How To \(local)

```sh
./toolkit.nu get-latest-challenge
git add -A
./toolkit.nu try-challenge # select challenge, select mode
./toolkit.nu run-challenge # select challenge, select mode
./toolkit.nu update-readme
git add -A
git commit -m \"Solve $PUZZLE in $MODE mode\"
```

# How To \(vimgolf.com)

```sh
podman run --rm -it -e key=$VIMGOLF_KEY ghcr.io/filbranden/vimgolf $CHALLENGE_ID
```

## Help

(help-docs)
"
  | save -f README.md
}

def badges [] {
  [
    [label      message        display        alt                                link];
    [vimgolf    nonlinearfruit green?logo=vim "NonlinearFruit's vimgolf profile" https://www.vimgolf.com/38899/NonlinearFruit]
    [challenges (challenges)   yellow         "Number of solved challenges"      null]
    [best       (avg-best)     blue           "Average best score"               null]
    [ex         (avg-ex)       teal           "Average ex score"                 null]
    [lua        (avg-lua)      orange         "Average lua score"                null]
    [normal     (avg-normal)   purple         "Average normal score"             null]
    [missing    (missing)      red            "Number of solutions missing"      null]
  ]
  | each {|badge|
    $"<img alt=\"($badge.alt)\" src=\"https://img.shields.io/badge/($badge.label)-($badge.message)-($badge.display)\">"
    | if $badge.link? != null {
      $"<a href=\"($badge.link)\">($in)</a>"
    } else {
      $"<a href=\"\">($in)</a>"
    }
  }
  | to text
}

def challenges [] {
  ls | where type == dir | length
}

def avg-best [] {
  ls
  | where type == dir
  | get name
  | each { get-frontmatter $in }
  | get best
  | math avg
  | math round --precision 1
}

def avg-ex [] {
  ls */ex-mode.vim
  | get size
  | each { $in / 1B }
  | math avg
  | math round --precision 1
}

def avg-lua [] {
  ls */lua-mode.lua
  | get size
  | each { $in / 1B }
  | math avg
  | math round --precision 1
}

def avg-normal [] {
  ls */normal-mode.txt
  | get size
  | each { $in / 1B }
  | math avg
  | math round --precision 1
}

def missing [] {
  ls */*-mode.*
  | length
  | ((challenges) * 3) - $in
}

def table-of-scores [] {
  ls */*-mode.*
  | rename --column { size: score }
  | insert challenge { get name | path dirname }
  | insert mode { get name | path parse | get stem | str replace '-mode' '' }
  | group-by challenge
  | transpose challenge data
  | each {|group|
    $group.data
    | reduce --fold { challenge: $group.challenge } {|soln, acc|
      $acc | insert $soln.mode $soln.score
    }
  }
  | insert frontmatter { get-frontmatter $in.challenge }
  | default '' ex
  | default '' normal
  | default '' lua
  | each {|x|
    $"| (row-title $x) | (top-score $x) | (as-hyperlink $x ex) | (as-hyperlink $x lua) | (as-hyperlink $x normal) |"
  }
  | prepend ["|challenge|best|ex|lua|normal|" "|---|---|---|---|---|"]
  | str join (char newline)
}

def get-frontmatter [challenge_dir] {
  [ $challenge_dir README.md ]
  | path join
  | open --raw $in
  | if $in =~ "^<!--" {
    str replace --multiline --regex '<!--\s+((.|\n)*)-->(.|\n)*' "$1"
    | from yaml
  } else {
    {}
  }
  | insert directory $challenge_dir
}

def row-title [x] {
  $x.frontmatter?
  | $"[($in.title?)]\(($in.directory?))"
}

def top-score [x] {
  $x.frontmatter?
  | get best?
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
