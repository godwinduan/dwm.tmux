#!/bin/sh

window_panes=
killlast=
#mfact=

newpane() {
  tmux \
    split-window -t :.0\; \
    swap-pane -s :.0 -t :.1\; \
    select-layout main-vertical\; \
    #resize-pane -t :.0 -x ${mfact}%
  return 0
}

newpanecurdir() {
  tmux \
    split-window -t :.0 -c "#{pane_current_path}"\; \
    swap-pane -s :.0 -t :.1\; \
    select-layout main-vertical\; \
    resize-pane -x 50%;
  return 0
}

killpane() {
  tmux kill-pane;
  return 0
}

swappane() {
  tmux swap-pane -t 0;
  return 0
}

nextpane() {
  tmux select-pane -t :.+
  return 0
}

prevpane() {
  tmux select-pane -t :.-
  return 0
}

rotateccw() {
  tmux rotate-window -U -t 0; 
  return 0
}

rotatecw() {
  tmux rotate-window -D -t 0; 
  return 0
}

zoom() {
  #tmux swap-pane -s :. -t :.0\; select-pane -t :.0
  tmux resize-pane -Z;
  return 0
}

layouttile() {
  tmux select-layout main-vertical\; #resize-pane -t :.0 -x ${mfact}%
  return 0
}

float() {
  tmux resize-pane -Z
  return 0
}

incmfact() {
  tmux resize-pane -R 2
  return 0
}

decmfact() {
  tmux resize-pane -L 2
  return 0
}

window() {
  window=$1
  tmux selectw -t $window
  return 0
}

if [ $# -lt 1 ]; then
  echo "dwm.tmux.sh [command]"
  exit
fi

command=$1;shift
args=$*
set -- $(echo $(tmux display -p "#{window_panes}\n#{killlast}\n#{mfact}"))
window_panes=$1
killlast=$2
mfact=$3

case $command in
  newpane) newpane;;
  newpanecurdir) newpanecurdir;;
  killpane) killpane;;
  swappane) swappane;;
  nextpane) nextpane;;
  prevpane) prevpane;;
  rotateccw) rotateccw;;
  rotatecw) rotatecw;;
  zoom) zoom;;
  layouttile) layouttile;;
  float) float;;
  incmfact) incmfact;;
  decmfact) decmfact;;
  window) window $args;;
  *) echo "unknown command"; exit 1;;
esac
