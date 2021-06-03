#!/bin/sh


wget --no-cookie --no-check-certificate -q -c -P /tmp https://mirrors.tuna.tsinghua.edu.cn/lede/releases/21.02.0-rc1/packages/powerpc_8540/luci/luci-i18n-base-zh-cn_git-21.136.64332-53c572a_all.ipk
opkg install /tmp/luci-i18n-base-zh-cn_git-21.136.64332-53c572a_all.ipk
sed -i "s/lang 'auto'/lang 'zh_cn'/g" /etc/config/luci

if [ -n "$(ls -A "/etc/openwrt_gxqm" 2>/dev/null)" ]; then
  Opgxqm="$(awk 'NR==1' /etc/openwrt_gxqm)"
  sed -i '/DESCRIPTION/d' /etc/openwrt_release
  echo "DISTRIB_DESCRIPTION='"${Opgxqm}" @ ImmortalWrt 21.02-SNAPSHOT'" >> /etc/openwrt_release
  rm -rf /etc/openwrt_gxqm
fi
if [ -n "$(ls -A "/etc/closedhcp" 2>/dev/null)" ]; then
  sed -i "s/option start '100'/option ignore '1'/g" /etc/config/dhcp
  sed -i '/limit/d' /etc/config/dhcp
  sed -i '/leasetime/d' /etc/config/dhcp
  rm -rf /etc/closedhcp
fi
sed -i '/coremark.sh/d' /etc/crontabs/root
sed -i '/luciname/d' /usr/lib/lua/luci/version.lua
sed -i '/luciversion/d' /usr/lib/lua/luci/version.lua
rm -rf /etc/webweb.sh
