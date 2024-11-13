# Open Helix!
hx

# Run exit code for the selected modules
# This is a try block because exit.nu shouldn't be required
try { nu ($env.ZELLIX_MOD + "/exit.nu") | ignore }

# Kill the session, closing other panes as soon as helix closes
zellij kill-session $env.ZELLIX_SESSION
