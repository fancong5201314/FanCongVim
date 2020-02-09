#!/bin/bash

#################################################################################
# Copyright (C) 2018 All rights reserved. 
# 文件名称：install.sh
# 创 建 者：樊聪
# 邮    箱：fancong20@163.com
# 创建日期：2018年09月25日 星期二
# 描    述：
#  
# 更新日志：
#  
#################################################################################

#备份OS中vim的配置   
function bakup_vimconfig()
{
	echo "Bakup your vimconfig file..."
	rm   -rf $HOME/.bakvim
	mkdir $HOME/.bakvim
	cp 	  $HOME/.vim  $HOME/.bakvim -a 
	cp 	  $HOME/.vimrc $HOME/.bakvim 
	cp 	  $HOME/.bashrc $HOME/.bakvim 
}

#配置vim
function config_vim()
{
	echo "Config your vim now !"
	rm -rf $HOME/.vim 
	cp -rf ./.vim  $HOME -a 
	cp -rf ./.vimrc $HOME 
	cp -rf ./.bashrc $HOME

	#生成tags文件 
	echo "Make tags in /usr/include"
	cd /usr/include
	sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p --fields=+iaS --extra=+q
}

echo -e "\e[1;31m1. First install vim\e[0m"
sudo apt-get install vim

echo -e "\e[1;31m2. Second install exuberant-ctags\e[0m"
sudo apt-get install exuberant-ctags

echo -e "\e[1;31m3. Last config vim\e[0m"
bakup_vimconfig
config_vim
