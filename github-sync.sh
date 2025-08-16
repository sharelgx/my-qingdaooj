#!/bin/bash

# QingdaoOJ 二次开发 + GitHub 同步脚本

set -e

function init_github() {
  echo "初始化 GitHub 仓库..."
  
  # 检查是否提供了GitHub用户名
  if [ -z "$1" ]; then
    echo "错误: 请提供GitHub用户名"
    echo "用法: $0 init-github <GitHub用户名>"
    exit 1
  fi
  
  GITHUB_USERNAME=$1
  
  # 初始化Git仓库
  git init
  git remote remove origin 2>/dev/null || true
  
  # 添加远程仓库
  echo "添加远程仓库..."
  git remote add origin "git@github.com:${GITHUB_USERNAME}/my-qingdaooj.git"
  git remote add upstream "https://github.com/QingdaoU/OnlineJudgeDeploy.git"
  
  # 拉取上游仓库
  echo "拉取上游仓库..."
  git fetch upstream
  
  # 设置主分支
  git branch -M main
  
  # 提交所有文件
  echo "提交所有文件..."
  git add .
  git commit -m "初始化 QingdaoOJ 二次开发版本"
  
  # 推送到个人仓库
  echo "推送到个人仓库..."
  git push -u origin main
  
  echo "GitHub仓库初始化完成!"
}

function push_code() {
  echo "推送代码到GitHub..."
  
  # 提交所有更改
  git add .
  git commit -m "更新: 二次开发功能"
  
  # 推送到个人仓库
  git push origin main
  
  echo "代码推送完成!"
}

function sync_upstream() {
  echo "同步官方更新..."
  
  # 拉取上游仓库
  git fetch upstream
  
  # 合并上游更改
  git merge upstream/main
  
  # 推送到个人仓库
  git push origin main
  
  echo "同步完成!"
}

# 主函数
function main() {
  cd /home/sharelgx/QingdaoOJDeploy
  
  case "$1" in
    init-github)
      init_github "$2"
      ;;
    push-code)
      push_code
      ;;
    sync-upstream)
      sync_upstream
      ;;
    *)
      echo "用法: $0 {init-github <GitHub用户名>|push-code|sync-upstream}"
      exit 1
      ;;
  esac
}

# 执行主函数
main "$@"