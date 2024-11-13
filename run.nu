def run [] {
  let path = $env.FILE_PWD
  $env.ZELLIX_PATH = $path # Set For Child Processes To Use

  let layout_path = $path + "/layout.kdl"
  let config_path = $path + "/zellij-config.kdl"
  zellij -s "zellix" -l $layout_path -c $config_path

  print $"(ansi cb)Thank you for using Zellix!(ansi reset)"
}

def main [] {
  run
}
