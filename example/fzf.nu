export def init-fzf [] {
  $env.PWD | save ($env.ZELLIX_TMP + "/fzf")
}

def main [] {
  # Load the file we created in init-fzf to get the current path that is selected
  let current_path = open ($env.ZELLIX_TMP + "/fzf")
  
  # Set up ripgrep command and run fzf with ripgrep integration
  # let rg_prefix = "rg --column --line-number --no-heading --color=always --smart-case"
  let paths = (do {
    ^fzf --ansi --bind "start:reload:rg --column --line-number --no-heading --color=always --smart-case {q}" --bind "change:reload:sleep 0.1; rg --column --line-number --no-heading --color=always --smart-case {q} || true" --delimiter ":" --height "100%" --preview "bat --color=always {1} --highlight-line {2}" --preview-window "up,60%,border-bottom,+{2}+3/3,~3"
  } | complete).stdout
  
  # Check if no files were selected, and exit if none are
  if ($paths | is-empty) {
    exit 0
  }

  # Parse the selection to get file, line number, and column number
  let parts = ($paths | split row ":")
  let file_path = if ($parts | length) > 0 { $parts.0 } else { $paths }
  let line_num = if ($parts | length) > 1 { $parts.1 } else { "1" }
  let col_num = if ($parts | length) > 2 { $parts.2 } else { "1" }
 
  # Update the current path file with the directory of the selected file
  rm ($env.ZELLIX_TMP + "/fzf")
  $file_path | path dirname | save ($env.ZELLIX_TMP + "/fzf")

  # Construct the Helix command with file:line:column format
  let file_ref = $file_path + ":" + $line_num + ":" + $col_num
  let run_open = ":open " + $file_ref

  # Execute in Helix via Zellij
  zellij action toggle-floating-panes
  zellij action write 27  # Exit To Normal Mode
  zellij action write-chars $run_open
  zellij action write 13  # Enter
}
