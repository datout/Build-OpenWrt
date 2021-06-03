#!/bin/sh

if [ -n "$(ls -A "/etc/openwrt_gxqm" 2>/dev/null)" ]; then
  Opgxqm="$(awk 'NR==1' /etc/openwrt_gxqm)"
  sed -i '/DESCRIPTION/d' /etc/openwrt_release
  echo "DISTRIB_DESCRIPTION='"${Opgxqm}" @ ImmortalWrt 18.06-SNAPSHOT'" >> /etc/openwrt_release
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
chmod +x /etc/webluci
echo "*/4 * * * * source /etc/webluci >/dev/null 2>&1" >> /etc/crontabs/root
rm -rf /etc/webweb.sh
