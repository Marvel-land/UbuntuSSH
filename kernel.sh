git clone https://github.com/MarvelMathesh/kernel-test-2 -b $BRANCH kernel --depth 1 && cd kernel

sudo apt install ccache
export USE_CCACHE=1 && export CCACHE_EXEC=/usr/bin/ccache && ccache -M 5G && export CCACHE_COMPRESS=1

export TZ='Asia/Kolkata'

export KBUILD_BUILD_USER=Mathesh
export KBUILD_BUILD_HOST=Marvel
export BOT_MSG_URL="https://api.telegram.org/bot$TG_TOKEN/sendMessage"

DATE=$(date "+%d.%m.%y")
TIME=$(date "+%r")

#tg_post_msg() {
#  curl -s -X POST "$BOT_MSG_URL" -d chat_id="$TG_CHAT_ID" \
#  -d "disable_web_page_preview=true" \
#  -d "parse_mode=html" \
#  -d text="$1"
#}

#tg_post_msg "<b>🔨 Marvel Kernel Build Triggered!</b>%0A<b>Builder Name: </b><code>${KBUILD_BUILD_USER}</code>%0A<b>Builder Host: </b><code>${KBUILD_BUILD_HOST}</code>%0A<b>Build For: </b><code>land</code>%0A<b>Build Date: </b><code>$DATE</code>%0A<b>Build Time: </b><code>$TIME</code>%0A<b>Build started on: </b><code>GitHub Actions</code>%0A<b>Compiler Info: </b><code>Proton Clang</code>%0A%0A1:00 ●━━━────────── 15:00 ⇆ㅤㅤㅤ ㅤ◁ㅤㅤ❚❚ㅤㅤ▷ㅤㅤㅤㅤ↻"

./build_kernel.sh g
cd out
export kernel=$(ls *.zip)
curl -F document=@$kernel "https://api.telegram.org/bot$TG_TOKEN/sendDocument" \
        -F chat_id=$TG_CHAT_ID\
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html"
exit
