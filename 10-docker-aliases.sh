## Docker container aliases

#alias dockerps='docker ps -a --format "table {{.Image}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Mounts}}"'
alias dockerps='docker ps -a --format "table {{.Image}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}"'