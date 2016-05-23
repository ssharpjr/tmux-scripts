tmux new -s matrix -d 'cmatrix -a -u 1 -C green' \; \
splitw -h -p 50 'cmatrix -a -u 1 -C blue' \; \
selectp -t 1 \; \
splitw -h -p 50 'cmatrix -a -u 1 -C cyan' \; \
selectp -t 0 \; \
splitw -h -p 50 'cmatrix -a -u 1 -C red' \; \
attach -t matrix

