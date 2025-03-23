#!/usr/bin/env nu

def --wrapped main [...rest] {
  const pathToSelf = path self
  let nameOfSelf = $pathToSelf | path parse | get stem
  if $rest in [ [-h] [--help] ] {
    nu -c $'use ($pathToSelf); scope modules | where name == ($nameOfSelf) | get 0.commands.name'
  } else {
    nu -c $'use ($pathToSelf); ($nameOfSelf) ($rest | str join (" "))'
  }
}

export def download-challenge [title challenge_id description] {
    let challenge_path = $title | str downcase | str replace --all -r '\s' '-'
    mkdir $challenge_path

    http get $"https://vimgolf.com/challenges/($challenge_id).json"
    | do {|response|
      $response.in.data
      | save -f ([$challenge_path input.txt] | path join)
      $response.out.data
      | save -f ([$challenge_path output.txt] | path join)
    } $in

    [
      $"# [($title)]\(https://www.vimgolf.com/challenges/($challenge_id))"
      $description
      "## Input"
      "```"
      (open ([$challenge_path input.txt] | path join))
      "```"
      "## Output"
      "```"
      (open ([$challenge_path output.txt] | path join))
      "```"
    ]
    | str join (char newline)
    | save -f ([$challenge_path README.md] | path join)
}

export def get-latest-challenge [] {
  http get http://feeds.vimgolf.com/latest-challenges
  | get content.content.0
  | where tag == item
  | get 0.content
  | {
    title: ($in | where tag == title | get 0.content.0.content)
    challenge_id: ($in | where tag == link | get 0.content.0.content | parse 'https://www.vimgolf.com/challenges/{challenge_id}' | get 0.challenge_id)
    description: ($in | where tag == description | get 0.content.0.content)
  }
  | do {|challenge|
    download-challenge $challenge.title $challenge.challenge_id $challenge.description
    print $"Downloaded: ($challenge.title)"
  } $in
  null
}

export def run-challenge [] {
  let challenge = ls
  | where type == dir
  | get name
  | str join (char newline)
  | ^fzf --prompt="Run Challenge: " --reverse --height=20%

  let mode = ls $challenge
  | where name =~ mode.txt
  | get name
  | path parse
  | get stem
  | str join (char newline)
  | ^fzf --prompt="With Mode: " --reverse --height=20%

  ^git restore ($challenge | path join input.txt)

  match $mode {
    ex-mode => { run-ex-mode $challenge },
    normal-mode => { run-normal-mode $challenge }
    insert-mode => { run-insert-mode $challenge }
  }

  ^git diff --exit-code --no-index ($challenge | path join input.txt) ($challenge | path join output.txt)
  | complete
  | if $in.exit_code == 0 {
    print $"($challenge): Succeed"
  } else {
    print $in.stdout
    print $"($challenge): Failed"
  }

  ^git restore ($challenge | path join input.txt)
}

def run-ex-mode [challenge] {
  open ($challenge | path join ex-mode.txt)
  | ^nvim -e -s ($challenge | path join input.txt)
}

def run-normal-mode [challenge] {
  ^nvim -s ($challenge | path join normal-mode.txt) ($challenge | path join input.txt)
}

def run-insert-mode [challenge] {
  print "TODO: Can't run insert mode yet"
  #^nvim -c 'startinsert' -s ($challenge | path join normal-mode.txt) ($challenge | path join input.txt)
}

export def try-challenge [] {
  let challenge = ls
  | where type == dir
  | get name
  | str join (char newline)
  | ^fzf --prompt="Try Challenge: " --reverse --height=20%

  let mode = modes
  | str join (char newline)
  | ^fzf --prompt="With Mode: " --reverse --height=20%

  match $mode {
    ex => { try-ex-mode $challenge },
    normal => { try-normal-mode $challenge }
    insert => { try-insert-mode $challenge }
  }
}

def try-ex-mode [challenge] {
  ^nvim -e -W ($challenge | path join ex-mode.txt) ($challenge | path join input.txt)
}

def try-normal-mode [challenge] {
  ^nvim -W ($challenge | path join normal-mode.txt) ($challenge | path join input.txt)
}

def try-insert-mode [challenge] {
  ^nvim -c 'startinsert' -W ($challenge | path join insert-mode.txt) ($challenge | path join input.txt)
}

export def update-readme [] {
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
  ls */*-mode.txt
  | rename --column { size: score }
  | insert challenge { get name | path parse | get parent }
  | insert mode { get name | path parse | get stem | str replace '-mode' '' }
  | group-by challenge
  | transpose challenge data
  | each {|it|
    $it.data
    | reduce --fold { challenge: $it.challenge } {|it, acc|
      $acc | insert $it.mode $it.score
    }
  }
  | default '' ex
  | default '' normal
  | each {|it|
    $"| (row-title $it) | (as-hyperlink $it ex) | (as-hyperlink $it normal) |"
  }
  | prepend ["|challenge|ex|normal|" "|---|---|---|"]
  | str join (char newline)
}

def row-title [it] {
  [ $it.challenge README.md ]
  | path join
  | open $in
  | lines
  | first
  | str replace "# " ""
}

def as-hyperlink [it mode] {
  [ $it.challenge $"($mode)-mode.txt" ] 
  | path join
  | $"[($it | get $mode)]\(($in))"
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

def modes [] {
  [
    ex
    normal
    insert
  ]
}
