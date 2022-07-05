#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 添加温度显示
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# Modify default IP
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# 修改输出文件名
sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=full-$(shell date +%Y%m%d)-$(VERSION_DIST_SANITIZED)/g' include/image.mk

# 修改系统版本号
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
sed -i "s/${orig_version}/${orig_version} ($(date +"%Y-%m-%d"))/g" zzz-default-settings
popd

# 修改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-infinityfreedom/g' feeds/luci/collections/luci/Makefile

# 修改连接数数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

#修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

#替换为 JerryKuKu 的 Argon
rm openwrt/package/lean/luci-theme-argon -rf

#删除 luci-app-qbittorrent  不知道为什么有他无法编译成功
#rm -rf package/lean/luci-app-qbittorrent
#rm -rf package/lean/qBittorrent

# themes添加（svn co 命令意思：指定版本如https://github）
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/souwei168/mypackages.git package/mypackages
git clone https://github.com/kiddin9/luci-app-dnsfilter.git package/luci-app-dnsfilter
#git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages

#添加额外非必须软件包
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/zzsj0928/luci-app-pushbot.git package/luci-app-pushbot
git clone https://github.com/pymumu/openwrt-smartdns package/smartdns
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

#新加入插件第二部分
pushd package/lean
git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner
git clone --depth=1 https://github.com/riverscn/openwrt-iptvhelper
git clone --depth=1 https://github.com/frainzy1477/luci-app-clash
#git clone --depth=1 https://github.com/jefferymvp/luci-app-koolproxyR
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust
git clone --depth=1 https://github.com/kuoruan/luci-app-kcptun
git clone --depth=1 https://github.com/jerrykuku/luci-app-ttnode
git clone --depth=1 https://github.com/jerrykuku/luci-app-jd-dailybonus
git clone --depth=1 https://github.com/vernesong/OpenClash
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome
git clone --depth=1 https://github.com/riverscn/openwrt-iptvhelper
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb
git clone --depth=1 https://github.com/tianiue/luci-app-bypass
git clone --depth=1 https://github.com/iwrt/luci-app-ikoolproxy
git clone --depth=1 https://github.com/yuos-bit/luci-app-openclash
#git clone --depth=1 https://github.com/hyy-666/luci-app-qBittorrent-enhanced
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff
git clone --depth=1 https://github.com/kenzok78/luci-app-netspeedtest
#git clone --depth=1 https://github.com/souwei168/luci-app-store
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
git clone --depth=1 https://github.com/hubbylei/luci-app-passwall
git clone --depth=1 https://github.com/nickilchen/luci-app-socat
git clone --depth=1 https://github.com/garypang13/luci-theme-edge
popd
