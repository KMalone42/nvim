#!/usr/bin/env bash

rsync -a --delete ./nvim/ ~/.config/nvim/
chown $USER:users --recursive ~/.config/nvim/
