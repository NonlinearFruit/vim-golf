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

export def get-latest-challenge [] {
  use .scripts/vimgolf.nu
  vimgolf get-latest-challenge
}

export def download-challenge [challenge_id] {
  use .scripts/vimgolf.nu
  vimgolf download-challenge $challenge_id
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
  use .scripts/readme.nu
  readme update
}

def modes [] {
  [
    ex
    normal
    lua
    insert
  ]
}
