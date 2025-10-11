export def get-latest-challenge [] {
  http get http://feeds.vimgolf.com/latest-challenges
  | get content.content.0
  | where tag == item
  | get 0.content
  | {
    title: ($in | where tag == title | get 0.content.0.content)
    id: ($in | where tag == link | get 0.content.0.content | parse 'https://www.vimgolf.com/challenges/{challenge_id}' | get 0.challenge_id)
    description: ($in | where tag == description | get 0.content.0.content)
  }
  | merge (download-challenge-input-and-output $in.id)
  | tee { print $"Downloaded: ($in.title)" }
  | save-challenge $in
  | ignore
}

export def download-challenge [challenge_id] {
  {
    id: $challenge_id
  }
  | merge (download-challenge-title-and-description $in.id)
  | merge (download-challenge-input-and-output $in.id)
  | save-challenge $in
}

export def random-challenge [] {
  list-all-challenges
  | shuffle
  | first
  | insert url https://www.vimgolf.com/challenges/($in.id)
}

def list-all-challenges [] {
  if not (challenge-cache-exists) {
    mkdir ("~/.cache/vim-golf" | path expand)
    list-all-challenges-from-website
    | save-to-challenge-cache
  }
  load-from-challenge-cache
}

def list-all-challenges-from-website [] {
  plugin use query
  generate {|page|
    http get https://www.vimgolf.com/?page=($page)
    | query web --query 'h5' --as-html
    | parse --regex '.*/challenges/(?<id>[^"]+)">(?<title>[^<]+)</a> - (?<entries>\d+) entries.*'
    | if ($in | is-empty) {
      {}
    } else {
      { out: $in next: ($page + 1) }
    }
  } 1
  | flatten
}

def challenge-cache-exists [] {
  "~/.cache/vim-golf/challenges.json"
  | path exists
}

def save-to-challenge-cache [] {
  to json
  | save "~/.cache/vim-golf/challenges.json" -f
}

def load-from-challenge-cache [] {
  open ("~/.cache/vim-golf/challenges.json" | path expand)
}

def download-challenge-input-and-output [challenge_id] {
  http get $"https://vimgolf.com/challenges/($challenge_id).json"
  | {
    input: $in.in.data
    output: $in.out.data
  }
}

def download-challenge-title-and-description [challenge_id] {
  http get $'https://www.vimgolf.com/challenges/($challenge_id)' -H { Accept: text/html }
  | {
    title: ($in | query web --query '#content h3 b' | flatten | first)
    description: ($in | query web --query '#content p' | flatten | first)
  }
}

def save-challenge [challenge] {
  let challenge_path = $challenge.title | str downcase | str replace --all -r '\s' '-'
  mkdir $challenge_path

  $challenge.input
  | save -f ([$challenge_path input.txt] | path join)
  $challenge.output
  | save -f ([$challenge_path output.txt] | path join)

  [
    $"# [($challenge.title)]\(https://www.vimgolf.com/challenges/($challenge.id))"
    $challenge.description
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
