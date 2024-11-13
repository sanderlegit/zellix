let paths = yazi --chooser-file=/dev/stdout

let command = ($paths | each {|line| $line | split row "\n"})

if (($command | length) == 0) {
  exit 0
}

let command_str = $command | str join " "

let run = ":open " + $command_str

zellij action toggle-floating-panes # Select Helix
zellij action write 27 # Exit To Normal Mode
zellij action write-chars $run # Write actual Command
zellij action write 13 # Press Enter to run the command
