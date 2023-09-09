#!/bin/bash

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
sed -i 's/plugins=(git)/plugins=(\n    zsh-autosuggestions\n    zsh-syntax-highlighting\n)/' ~/.zshrc
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="ys"/' ~/.zshrc
sed -i 's/^# DISABLE_MAGIC_FUNCTIONS="true"/DISABLE_MAGIC_FUNCTIONS="true"/' ~/.zshrc

# 6. 提示用户
rm -rf /root/setup_zsh_part1.sh
echo -e "\033[34mzsh 已经全部配置完成，请手动执行source ~/.zshrc并重新进入终端\033[0m"
