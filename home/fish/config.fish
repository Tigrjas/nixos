# ============================================================
# PATH
# ============================================================

# Personal scripts managed through Home Manager.
set -gx PATH $HOME/.local/bin $PATH


# ============================================================
# Environment
# ============================================================

set -gx EDITOR micro
set -gx VISUAL micro


# ============================================================
# Fish
# ============================================================

# Disable Fish's default greeting since Fastfetch provides the
# terminal greeting instead.
set -g fish_greeting


# ============================================================
# Git Abbreviations
#
# Fish abbreviations expand visibly before executing, which makes
# them nicer than aliases for commands I use frequently.
# ============================================================

abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gc 'git commit'
abbr -a gp 'git push'
abbr -a gl 'git log --oneline --graph --decorate'

# ============================================================
# Git Prompt
# ============================================================

set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showstashstate 1
set -g __fish_git_prompt_showupstream informative

set -g __fish_git_prompt_char_dirtystate '*'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_stagedstate '+'
set -g __fish_git_prompt_char_stashstate '$'

# ============================================================
# NixOS Abbreviations
# ============================================================

abbr -a nrs 'sudo nixos-rebuild switch --flake ~/nixos#nixos'
abbr -a nrt 'sudo nixos-rebuild test --flake ~/nixos#nixos'


# ============================================================
# Interactive Shell
# ============================================================

if status is-interactive
    fastfetch
end
