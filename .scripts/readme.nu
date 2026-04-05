export def update [] {
$"
Using vim golf to grow nvim skills

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

def table-of-scores [] {
  ls */*-mode.*
  | rename --column { size: score }
  | insert challenge { get name | path parse | get parent }
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
  | open $in
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
