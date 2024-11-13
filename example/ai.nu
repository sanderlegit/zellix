export def init-ai [] {}

def --wrapped main [...args] {
  zellij run -c -f -- aichat ...$args
}
