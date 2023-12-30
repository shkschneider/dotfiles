#!/usr/bin/env bash

echo "$(grep ^NAME /etc/os-release | head -1 | cut -d= -f2 | tr -d '"') $(grep ^VERSION /etc/os-release | head -1 | cut -d= -f2 | tr -d '"')"
echo "$(uname --operating-system) $(uname --kernel-name --kernel-release | cut -d'-' -f1)"

# EOF
