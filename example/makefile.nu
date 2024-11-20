export def init-makefile [] {}

def "main handle-inner" [] {
  try { fzf-make }
  print "Press <Any> To Continue!"
  input -n 1 -s
}

def "main wait" [] {
  zellij run -i -c -- nu $"($env.ZELLIX_MOD)/makefile.nu" handle-inner
}

def main [] {
  zellij run -i -c -- fzf-make
}
