#!/bin/bash
# 1. nvm 환경 로드
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 2. 노드 버전 선택 및 폴더 이동
nvm use 22
cd ~/projects/quartz

# 3. 쿼츠 동기화 실행
npx quartz sync
