#!/bin/bash

# 1. 检查系统是否有zsh
if ! command -v zsh &> /dev/null; then
    echo "zsh未安装，正在为你安装..."
    sudo apt update
    sudo apt install -y zsh
    chsh -s $(which zsh)
else
    echo "zsh已经安装."
fi

# 2. 检查系统是否有git
if ! command -v git &> /dev/null; then
    echo "git未安装，正在为你安装..."
    sudo apt update
    sudo apt install -y git
else
    echo "git已经安装."
fi

# 3. 安装oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "正在安装oh-my-zsh..."
    echo -e "\033[31m请运行以下命令以继续安装：\033[0m"
    echo "wget https://raw.githubusercontent.com/Atroc-X/Fool./main/setup_zsh_part2.sh && chmod +x setup_zsh_part2.sh && ./setup_zsh_part2.sh && rm -rf setup_zsh_part2.sh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh已经安装."
fi
