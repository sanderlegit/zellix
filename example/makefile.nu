export def init-makefile [] {}

def "handle" [] {
  fzf-make
  print "Press <Any> To Continue!"
  input -n 1 -s
}

def "main last" [] {
  zellij run -i -c -- fzf-make -r
}

def "main wait" [] {
  zellij run -i -c -- handle
}

def main [] {
  zellij run -i -c -- fzf-make
}
