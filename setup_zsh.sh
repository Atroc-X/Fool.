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
    yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh已经安装."
fi

# 4. 安装zsh-autosuggestions和zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions已经安装."
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting已经安装."
fi

# 5. 修改.zshrc 文件
sed -i '/^plugins=(/,/)/c\plugins=(\n    zsh-autosuggestions\n    zsh-syntax-highlighting\n)' ~/.zshrc
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="ys"/' ~/.zshrc
sed -i 's/^# DISABLE_MAGIC_FUNCTIONS="true"/DISABLE_MAGIC_FUNCTIONS="true"/' ~/.zshrc

# 6. 运行source ~/.zshrc (注意：在脚本中执行source对当前shell无效，用户可能需要手动执行此命令或重新打开终端)
echo "zsh 已经全部配置完成，请手动执行source ~/.zshrc并重新进入终端"
