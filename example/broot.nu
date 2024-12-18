export def init-broot [] {
  $env.PWD | save ($env.ZELLIX_TMP + "/broot")
}

def main [] {
  # Load the file we created in init-broot to get the current path that is selected.
  let current_path = open ($env.ZELLIX_TMP + "/broot")

  # Open broot at the current path, and print the selected files to stdout.
  let paths = broot

  # Split the files by rows.
  let command = ($paths | each {|line| $line | split row "\n"})

  # Check if no files were selected, and exit if none are.
  if ($command | get 0 | str trim | is-empty) {
    exit 0
  }

  # Write the first file in the selection to the current path file..
  rm ($env.ZELLIX_TMP + "/broot")
  $command | get 0 | save ($env.ZELLIX_TMP + "/broot")

  # Join the list of filepaths we had above to support writing the paths to helix.
  let command_str = $command | str join " "

  # Set up the string for the actual command.
  let run = ":open " + $command_str

  zellij action toggle-floating-panes # Select Helix In The System
  zellij action write 27 # Exit To Normal Mode
  zellij action write-chars $run # Write actual Command
  zellij action write 13 # Press Enter to run the command
}
