#!/usr/bin/env nu

# This script acts as a file picker using Yazi for Helix within Zellij.
# - If files are selected, it sends an ":open <files>" command to Helix.
# - If Yazi errors or is quit without selecting files, it exits 0 and does nothing

# Arguments:
#   buffer_path: string? - Optional path (file or directory) provided by the caller (e.g., Helix buffer name via Zellij).
#                          Used to determine the starting directory for Yazi. If null or omitted, uses PWD.
def main [buffer_path: string] {

    # --- 1. Determine Starting Directory for Yazi ---
    let start_dir = if $buffer_path == null or ($buffer_path == "[scratch]") { # <-- Correct check for null/empty/scratch
        # If no path provided, or it's a scratch buffer, use the current working directory
        $env.PWD
        print $"Start dir was scratch or empty $(buffer_path)"
        sleep 1sec
    } else {
        # Try to resolve the buffer path relative to PWD
        # Use path expand for robustness (handles ~, .., .)
        let full_path = ($env.PWD | path join $buffer_path) | path expand --no-symlink

        # # Check if the resolved path exists
        if not ($full_path | path exists) {
            # Fallback to PWD if buffer_path doesn't exist
            print $"Warning: Buffer path '($buffer_path)' resolved to '($full_path)' which does not exist. Starting Yazi in ($env.PWD)." stderr
            $env.PWD
            # Wait so error stays visible
            sleep 1sec
        } else {
            $full_path 
        }
    }

    # Variable to store selected paths later
    mut selected_paths = []

    try {
        # --chooser-file=/dev/stdout: Selected files are printed to stdout.
        # $start_dir: The directory where Yazi should open.
        # Capture stdout (selected files) into $yazi_output
        let yazi_output = ^yazi --chooser-file=/dev/stdout $start_dir

        # Process the output if Yazi succeeded
        # Join all selected paths (drag in yazi with v)
        $selected_paths = ($yazi_output | lines | str trim | where {|it| not ($it | is-empty) })
    } catch { |err|
        # Log the error from Yazi
        print $"Error running Yazi: ($err)" stderr
        # Wait so error stays visible
        sleep 5sec
    } 
    if ($selected_paths | is-empty) {
        # Exit the script cleanly after attempting explorer action
        exit 0
    } else {
        # Join the list of selected file paths into a single string for Helix
        let command_str = ($selected_paths | str join " ")

        # Prepare the Helix command
        let run = ":open " + $command_str

        # Send commands to Helix via Zellij
        zellij action toggle-floating-panes # Ensure Helix pane is focused (adjust if needed)
        zellij action write 27              # Send Esc to enter Normal mode
        zellij action write-chars $run      # Type the :open command
        zellij action write 13              # Send Enter to execute
    }
}
