#!/bin/bash

# 1. 更新软件包列表
sudo apt update

# 2. 检查并安装默认包
check_and_install() {
    for cmd in "$@"; do
        if ! command -v $cmd &> /dev/null; then
            echo "$cmd 未安装，正在为你安装..."
            sudo apt install -y $cmd
            # 如果是zsh，还要修改默认shell
            if [ "$cmd" = "zsh" ]; then
                chsh -s $(which zsh)
            fi
        else
            echo "$cmd 已经安装."
        fi
    done
}
commands=("zsh" "git" "sudo" "jq")
check_and_install "${commands[@]}"

# 3. 安装oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "正在安装oh-my-zsh..."
    echo -e "\033[31m请运行以下命令以继续安装：\033[0m"
    echo -e "\033[32mwget https://raw.githubusercontent.com/Atroc-X/Fool./main/setup_zsh_part2.sh && chmod +x setup_zsh_part2.sh && ./setup_zsh_part2.sh && rm -rf setup_zsh_part2.sh\033[0m"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh已经安装."
fi
