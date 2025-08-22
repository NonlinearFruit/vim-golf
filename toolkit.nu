#!/usr/bin/env nu

def --wrapped main [...rest] {
  const pathToSelf = path self
  let nameOfSelf = $pathToSelf | path parse | get stem
  if $rest in [ [-h] [--help] ] {
    ^$nu.current-exe -c $'use ($pathToSelf); scope modules | where name == ($nameOfSelf) | get 0.commands.name'
  } else {
    ^$nu.current-exe -c $'use ($pathToSelf); ($nameOfSelf) ($rest | str join (" "))'
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

export def run-challenge [
  --challenge = ""
  --mode = ""
] {
  let my_challenge = if $challenge != "" { $challenge } else {
    ls
    | where type == dir
    | get name
    | str join (char newline)
    | ^fzf --prompt="Run Challenge: " --reverse --height=20%
  }

  let my_mode = if $mode != "" { $mode } else {
    ls $my_challenge
    | where name =~ '-mode\.'
    | get name
    | path parse
    | get stem
    | str join (char newline)
    | ^fzf --prompt="With Mode: " --reverse --height=20%
  }

  let input_file = $my_challenge | path join input.txt
  ^git restore $input_file

  match $my_mode {
    ex-mode => { run-ex-mode $my_challenge },
    normal-mode => { run-normal-mode $my_challenge }
    insert-mode => { run-insert-mode $my_challenge }
    lua-mode => { run-lua-mode $my_challenge }
    _ => { print "Not a valid mode"; exit 1 }
  }

  ^git diff --text --exit-code --no-index $input_file ($my_challenge | path join output.txt)
  | complete
  | if $in.exit_code == 0 {
    print $"($my_challenge): Succeed"
  } else {
    print $in.stdout
    print $"($my_challenge): Failed"
  }

  ^git restore $input_file
}

def run-ex-mode [challenge] {
  open ($challenge | path join ex-mode.vim)
  | ^nvim -e -s ($challenge | path join input.txt)
  | complete
  | if $in.exit_code != 0 {
    print "WARN: nvim exited with error"
  }
}

def run-normal-mode [challenge] {
  ^nvim --clean -s ($challenge | path join normal-mode.txt) ($challenge | path join input.txt)
  | complete
  | if $in.exit_code != 0 {
    print "WARN: nvim exited with error"
  }
}

def run-insert-mode [challenge] {
  print "No insert mode support"
}

def run-lua-mode [challenge] {
  ^nvim ($challenge | path join input.txt) -l ($challenge | path join lua-mode.lua)
  | complete
  | if $in.exit_code != 0 {
    print "WARN: nvim exited with error"
  }
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
    lua => { try-lua-mode $challenge }
    insert => { try-insert-mode $challenge }
    normal => { try-normal-mode $challenge }
  }
}

def try-ex-mode [challenge] {
  ^nvim -e -W ($challenge | path join ex-mode.vim) ($challenge | path join input.txt)
}

def try-lua-mode [challenge] {
  ^nvim ($challenge | path join lua-mode.lua)
}

def try-insert-mode [challenge] {
  ^nvim --clean -c 'startinsert' -W ($challenge | path join insert-mode.txt) ($challenge | path join input.txt)
}

def try-normal-mode [challenge] {
  ^nvim -W ($challenge | path join normal-mode.txt) ($challenge | path join input.txt)
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
  ls */*-mode.*
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
  | default '' lua
  | each {|it|
    $"| (row-title $it) | (as-hyperlink $it ex) | (as-hyperlink $it lua) | (as-hyperlink $it normal) |"
  }
  | prepend ["|challenge|ex|lua|normal|" "|---|---|---|---|"]
  | str join (char newline)
}

def row-title [it] {
  [ $it.challenge README.md ]
  | path join
  | open $in
  | lines
  | first
  | str replace --regex '# \[(.*)\].*' "$1"
  | $"[($in)]\(($it.challenge))"
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

def modes [] {
  [
    ex
    normal
    lua
    insert
  ]
}
