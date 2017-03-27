stty -ixon

test -s ~/.alias && . ~/.alias || true
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
export PATH=$PATH:/home/cyc/bin:/usr/local/sbin:/usr/sbin

export NO_AWT_MITSHM=true
export CSHEDIT=vim
if [ "$TMUX" = "" ]
then
    export TERM=xterm-256color
fi

autoload -Uz promptinit                                                                                                                                      
autoload -U colors && colors                                                                                                                                 
promptinit                                                                                                                                                   
                                                                                                                                                             
autoload -U select-word-style                                                                                                                                
select-word-style bash                                                                                                                                      

#Keep 1000 lines of history within the shell and save it to ~/.zsh_history: 
HISTSIZE=10000                                                               
SAVEHIST=10000                                                               
HISTFILE=~/.zsh_history                                                      

source ~/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
# Load the theme.
antigen theme gnzh
# Tell antigen that you're done.
antigen apply
#RPROMPT="%{$fg[cyan]%}[%* on %D]%{$reset_color%}"                                                                                                            

alias ls='ls --color=auto'                                                   
alias la='ls -A'                                                             
alias l='ls -lah'                                                   
alias grep='grep --color -n'                                             
alias df='df -h'
alias ssh='TERM=xterm ssh'

# Use modern completion system                                                                        
autoload -Uz compinit                                                                                 
compinit                                                                                              

#zstyle ':completion:*' auto-description 'specify: %d'                                                 
#zstyle ':completion:*' completer _expand _complete _correct _approximate                              
#zstyle ':completion:*' format 'Completing %d'                                                         
#zstyle ':completion:*' group-name ''                                                                  
#zstyle ':completion:*' menu select                                                                    
#eval "$(dircolors -b)"                                                                                
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}                                         
#zstyle ':completion:*' list-colors ''                                                                 
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s            
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*' 
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s                    
#zstyle ':completion:*' use-compctl false                                                            
#
#
#
#
#bindkey "^[[3~" delete-char
#bindkey "^[[2~" quoted-insert
#
#bindkey "^[[F" end-of-line
#bindkey "^[[H" beginning-of-line
#bindkey "^[[1~" beginning-of-line
#bindkey "^[[4~" end-of-line
#
#bindkey "^[[5~" history-search-backward
#bindkey "^[[6~" history-search-forward
