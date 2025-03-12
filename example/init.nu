use yazi.nu *
use broot.nu *
use fzf.nu *
use ai.nu *
use makefile.nu *
use bacon.nu *

# Use this file to initialize any plugins and systems you need!
# 
# The main use of this should be to
# create files that would be used for config/data.
def main [] {
  init-yazi
  init-ai
  init-makefile
  init-bacon
  init-broot
}
