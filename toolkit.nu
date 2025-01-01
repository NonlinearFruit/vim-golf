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
    | to yaml
    | print

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
  | download-challenge $in.title $in.challenge_id $in.description
}

export def run-challenge [] {
 print "vim -e -s input.txt <ex-mode.txt; git diff --no-index input.txt output.txt && git restore input.txt"
}
