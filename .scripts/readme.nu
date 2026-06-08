export def remake [] {
$"
<div align=\"center\">

  <img src=\"nvim-golf.svg\" alt=\"nvim golf icon\" width=\"400\" height=\"400\"/>

  (badges)

</div>

## Scores

(table-of-scores)

<details><summary>History</summary>

(graphs)

</details>

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
    [mine       (avg-mine)     cyan           "Average mine score"               null]
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

def avg-mine [] {
  use vimgolf.nu
  vimgolf list-played-challenges
  | get best-player-score
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
  use vimgolf.nu
  let submitted_challenges = vimgolf list-played-challenges
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
    $"| (row-title $x) | (top-score $x) | (submitted-score $x $submitted_challenges) | (as-hyperlink $x ex) | (as-hyperlink $x lua) | (as-hyperlink $x normal) |"
  }
  | prepend ["|challenge|best|mine|ex|lua|normal|" "|---|---|---|---|---|---|"]
  | str join (char newline)
}

export def get-frontmatter [challenge_dir] {
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

def submitted-score [x, submitted_challenges] {
  $submitted_challenges
  | where id == $x.frontmatter?.id?
  | get --optional 0.best-player-score
  | if $in != null {
    $"[($in)]\(https://www.vimgolf.com/challenges/($x.frontmatter?.id?)/user/NonlinearFruit)"
  } else ''
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

export def graphs [] {
  let commit_that_introduced_badges = '7b37ab8'
  ^git log --format=%H+%as $"($commit_that_introduced_badges).."
  | lines
  | each {|log|
    $log
    | split row '+'
    | let pair
    ^git show $"($pair.0):README.md"
    | lines
    | where $it =~ 'shields'
    | parse '{_}badge/{type}-{score}-{_}'
    | each { insert date $pair.1 }
  }
  | flatten
  | where type != vimgolf
  | group-by type --to-table
  | update items {
    group-by date --to-table
    | update items { get score | into int | math avg }
  }
  | each {|details|
    let file = mktemp
    $details
    | get items
    | each { $"($in.date) ($in.items)" }
    | to text
    | save -f $file

    ^gnuplot -e $"
      set title '($details.type)';
      set terminal dumb size 90 30;
      set ytics scale 0;
      set xtics scale 0;
      set offsets graph 0, 0, 5, 0;
      set xdata time;
      set timefmt '%Y-%m-%d';
      set yrange [0:*];
      plot '($file)' using 1:2 with lines title ''"
    | let graph

    rm $file

    $"```(char newline)($graph)(char newline)```"
  }
  | to text
}
