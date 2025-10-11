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

export def random-challenge [] {
  use .scripts/vimgolf.nu
  vimgolf random-challenge
}

export def run-challenge [
  --challenge = ""
  --mode = ""
] {
  use .scripts/challenge.nu
  challenge run-challenge --challenge $challenge --mode $mode
}

export def try-challenge [] {
  use .scripts/challenge.nu
  challenge try-challenge
}

export def update-readme [] {
  use .scripts/readme.nu
  readme update
}
