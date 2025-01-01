def --wrapped main [...rest] {
  nu -c $'use toolkit.nu; toolkit ($rest | str join " ")'
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

  open ($challenge | path join ex-mode.txt)
  | ^nvim -e -s ($challenge | path join input.txt)
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
