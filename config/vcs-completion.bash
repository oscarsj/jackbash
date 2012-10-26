# set colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Reads the hg summary line by line, outputs the working branch
# revision number and notifies if there's untracked files or changes
# Inspired by Steve Losh's implementation: 
# http://stevelosh.com/blog/2009/03/mercurial-bash-prompts/
# gsub(/ */,"",pieces[split($3,pieces
vcs_summary() {
  hg summary 2> /dev/null | \
    awk 'BEGIN {RS=""; FS="\n"} {
      gsub(/ */,"",$3)
      printf ("(\033[0;37m"pieces[split($3,pieces,":")],$0); 
      printf ("\033[37;0m·r" substr(pieces[split($1,pieces,":")-1],2),$0);
      if(match($4, "modified"))
        printf ("\033[0;32m!",$0);
      else if (match($4, "unknown") && !match($4, "modified"))
        printf ("\033[0;32m?",$0);
      printf ("\033[37;0m) ",$0)
    }'
}
