try { nu ($env.ZELLIX_MOD + "/init.nu") }

# Open helix, handling empty ZELLIX_OPEN case
if ($env.ZELLIX_OPEN == "") {
    hx
} else {
    hx ...($env.ZELLIX_OPEN | split row " ")
}

# Run exit code for the selected modules
try { nu ($env.ZELLIX_MOD + "/exit.nu") }

# Kill the session, closing other panes as soon as helix closes
zellij kill-session $env.ZELLIX_SESSION
