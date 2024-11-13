def setup-files [session] {
  let path = "/tmp/zellix/" + $session

  # Ensure the session folder actually got deleted
  try { rm -r $path }

  # Create the session folder.
  mkdir $path
}

def main [module_path, session?] {
  # Find the path of the zelix command.
  let path = $env.FILE_PWD
  $env.ZELLIX_PATH = $path

  # Set a default session if no session name was given.
  let session = match $session {
    null => (random chars --length 10) # Create a crazy, random set of characters to hopefully prevent overlaps,
    _ => $session
  }

  # Create useful environment variables for users.
  $env.ZELLIX_SESSION = $session
  $env.ZELLIX_TMP = "/tmp/zellix/" + $session
  $env.ZELLIX_MOD = $module_path

  # Set up the tmp folder for the zellix session.
  setup-files $session
  nu ($module_path + "/init.nu")

  # Set Layout And Config Paths for the zellij session
  let layout_path = $env.ZELLIX_PATH + "/layout.kdl"
  let config_path = $env.ZELLIX_PATH + "/zellij-config.kdl"

  # Create the zellij session
  zellij -s $session -l $layout_path -c $config_path

  # Delete The Session Folder
  rm -r $env.ZELLIX_TMP

  # Thank the user!
  print $"(ansi cb)Thank you for using Zellix!(ansi reset)"
}
