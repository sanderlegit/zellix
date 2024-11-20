export def init-makefile [] {}

def "main last" [] {
  zellij run -i -c -- fzf-make -r
}

def main [] {
  zellij run -i -c -- fzf-make
}
