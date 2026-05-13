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
  | str replace "-mode" ""

  let input_file = $my_challenge | path join input.txt
  ^git restore $input_file

  match $my_mode {
    ex => { run-ex-mode $my_challenge },
    normal => { run-normal-mode $my_challenge }
    lua => { run-lua-mode $my_challenge }
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

export def try-challenge [
  --challenge = ""
  --mode = ""
] {
  let my_challenge = if $challenge != "" { $challenge } else {
    ls
    | where type == dir
    | get name
    | str join (char newline)
    | ^fzf --prompt="Try Challenge: " --reverse --height=20%
  }

  let my_mode = if $mode != "" { $mode } else {
    modes
    | str join (char newline)
    | ^fzf --prompt="With Mode: " --reverse --height=20%
  }

  match $mode {
    ex => { try-ex-mode $challenge },
    lua => { try-lua-mode $challenge }
    normal => { try-normal-mode $challenge }
  }
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

def run-lua-mode [challenge] {
  ^nvim ($challenge | path join input.txt) -l ($challenge | path join lua-mode.lua)
  | complete
  | if $in.exit_code != 0 {
    print "WARN: nvim exited with error"
  }
}

def try-ex-mode [challenge] {
  ^nvim -e -W ($challenge | path join ex-mode.vim) ($challenge | path join input.txt)
}

def try-lua-mode [challenge] {
  ^nvim ($challenge | path join lua-mode.lua)
}

def try-normal-mode [challenge] {
  ^nvim -W ($challenge | path join normal-mode.txt) ($challenge | path join input.txt)
}

def modes [] {
  [
    ex
    normal
    lua
  ]
}
