#!/bin/bash

# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Vim if not already installed
if ! command_exists vim; then
    echo "Vim is not installed. Installing Vim..."
    sudo dnf install vim -y
    echo "Vim has been installed."
fi

# Install Git if not already installed
if ! command_exists git; then
    echo "Git is not installed. Installing Git..."
    sudo dnf install git -y
    echo "Git has been installed."
fi

# Clone the indentLine repository and generate helptags
if command_exists git; then
    git clone https://github.com/Yggdroot/indentLine.git ~/.vim/pack/vendor/start/indentLine
    vim -u NONE -c "helptags  ~/.vim/pack/vendor/start/indentLine/doc" -c "q"
    echo "indentLine plugin has been installed and helptags generated."
fi

# Append the line 'let g:indentLine_char = '┊'' to .vimrc if it exists
if [ -f ~/.vimrc ]; then
    echo "Appending 'let g:indentLine_char = '┊'' to existing .vimrc."
    echo "let g:indentLine_char = '┊'" >> ~/.vimrc
else
    # Create the .vimrc file with 'set number' and the indentLine character
    echo "Creating a new .vimrc file with 'set number' and 'let g:indentLine_char = '┊''."
    echo "set number" > ~/.vimrc
    echo "let g:indentLine_char = '┊'" >> ~/.vimrc
fi

echo "Script execution complete."

