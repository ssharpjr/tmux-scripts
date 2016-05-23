tmux new -s Development -d \; \
splitw -h -p 50 'cd /home/ssharp/dev/django/superlists && workon tdd_test' \; \
splitw -v -p 50 'cd /home/ssharp/dev/django/superlists && workon tdd_dev' \; \
selectp -t 1 \; \
attach -t Development
