# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

if [ -f /home/n1amr/.local/bin/my.bashrc ]; then
  . /home/n1amr/.local/bin/my.bashrc
fi

