!f() {
  if [ -n \"$1\" -a -z \"$2\" ]; then 
    git checkout "`revisionid-to-diffid.sh --tag \"$@\"`";
  else
    git checkout \"$@\";
  fi && git submodule update --init --recursive; 
}

f
