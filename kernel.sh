git clone $KT_LINK -b $KT_BRANCH --depth=1 --single-branch
cd *
wget https://raw.githubusercontent.com/MarvelMathesh/Kernel-Builder-Cirrus-CI/holland2/build-kernel.sh

sudo apt install ccache
export USE_CCACHE=1 && export CCACHE_EXEC=/usr/bin/ccache && ccache -M 5G && export CCACHE_COMPRESS=1

export TZ='Asia/Kolkata'

export KBUILD_BUILD_USER=Mathesh
export KBUILD_BUILD_HOST=Marvel

bash build-kernel.sh
cd AnyKernel3
export kernel=$(ls *.zip)
curl -F document=@$kernel "https://api.telegram.org/bot$TG_TOKEN/sendDocument" \
        -F chat_id=$TG_CHAT_ID\
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html"
exit
