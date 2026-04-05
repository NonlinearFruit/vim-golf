export def get-latest-challenge [] {
  http get http://feeds.vimgolf.com/latest-challenges
  | get content.content.0
  | where tag == item
  | get 0.content
  | where tag == link
  | get 0.content.0.content
  | parse 'https://www.vimgolf.com/challenges/{challenge_id}'
  | get 0.challenge_id
  | download-challenge $in
}

export def download-challenge [challenge_id] {
  {
    id: $challenge_id
  }
  | merge (download-challenge-title-and-description $in.id)
  | merge (download-challenge-input-and-output $in.id)
  | insert frontmatter (create-frontmatter $in)
  | tee { print $"Downloaded: ($in.title)" }
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
    best: ($in | query web -q '.grid_5 > .clearfix > div > b > a' | flatten | into int | math min)
    url: $'https://www.vimgolf.com/challenges/($challenge_id)'
  }
}

def create-frontmatter [challenge] {
  $challenge
  | select id title url best
}

def save-challenge [challenge] {
  const path_to_repo = [(path self) .. ..] | path join | path expand
  let challenge_dir = $challenge.title | str downcase | str replace --all -r '\s' '-'
  let challenge_path = [$path_to_repo $challenge_dir] | path join
  mkdir $challenge_path

  $challenge.input
  | save -f ([$challenge_path input.txt] | path join)
  $challenge.output
  | save -f ([$challenge_path output.txt] | path join)

  [
    "<!--"
    ($challenge.frontmatter | to yaml)
    "-->"
    $"# [($challenge.title)]\(($challenge.url))"
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
