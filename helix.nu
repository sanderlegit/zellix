try { nu ($env.ZELLIX_MOD + "/init.nu") }

# Open helix at the given filepath.
# Split strings on " " to pass multiple args
hx ...($env.ZELLIX_OPEN | split row " ")

# Run exit code for the selected modules
# This is a try block because exit.nu shouldn't be required
try { nu ($env.ZELLIX_MOD + "/exit.nu") }

# Kill the session, closing other panes as soon as helix closes
zellij kill-session $env.ZELLIX_SESSION
