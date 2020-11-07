Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075BF2AA3CA
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKGIPt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIPt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736948; x=1636272948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcASeM+Wtk8HLIa8mlPAWKhoAQBw/Y524saF5tWi1U0=;
  b=AjTeXa+hOeM5zlAoEwwTQT0ZZHYi2EKeDEXVWlwzhSe113j3c4/IsR8w
   mn81Wu7f0U84ZKirzRmTCSmRyldWZDkZYCvhs1cx306XC0WU5vfEuGojE
   zujQGcqU4Yz8nNZCbjJ9Qd/z1RGG38OtIpAp0r5m3EKsTAfi+iOoFDAQe
   veWb0QxkbRYymFfwapQ+iCj02DdxqgaCWwWupBHhrPeTYYrSuXi/WD7BQ
   rHJBQ9ljM7hqDd/gcXkjHNdTEFGO/dRPcGohXyq/kdC8SCNDsduFwXU7F
   idQqBLTWcjGDUPnLHS34TYEwRP4mifXRgmW0f78koyNdMLbe7SpJN8Gw6
   w==;
IronPort-SDR: 4m7MhEduGzBVHFgonWOiM0vtnYPlsvnBT4OXstDdOT/8IotQXSL//bGsg3IZQXdHUmEjKFtg+Q
 Zn/XXe5vkPu+UQfgTlFo6gMpyxASudQcxzPDUWQMJk0L5WpHtxSWkmP1uI0j4HDCVw6ulPa5RY
 JkT0aGldl2w80UKNJHqHYVAAi5j5Nn1/N178eS0MEQuko1RENsms+nCGIZh9Dac0VkXlhZ2heI
 b5ML/Pqc+QO69iRkf3Hfy0YCGXh+5bOAHiTlVGgoGkUbYpVn6gFNGOSt5UTmUIGfDIY+W+FtYz
 D1U=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564447"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:47 +0800
IronPort-SDR: ulBWsi6dnQ6pnBnQF1cPz/d/i1XlL/i98o3uuy8TOigwXR2hyCiL/No59Enazawdy4LdZUQ3Ek
 gIz+hg/Xi3qGrIWLPk0IS2Tuxl9OdbqGAA+NnbzmxribWMz7BzwHM0UKpCn6XhEqJpUplhX6rH
 LyYFgnGGXvzd9ireZ5BieuqEdcBj0AyUkmGqjlB2Msyur4S1MLlyJuK00pjdlgXJ/z6FBBtN3J
 fsquCo3vrsvmYwfMPRdYZ40kl0IWaNfbZSqHUlavQYRd10SvOV6rTGRqluQNVitPJjMW22izwA
 v5FHSyeLZLV9r1gXUfjRWVtQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:39 -0800
IronPort-SDR: igjqg1cSP52ZuedqtoN6ujsIzT9RexGlMkyG+AAxCpr6vZgKN6eg+4D1HP7uq2DBJZIQb1qu+A
 U15gDOBX/8gXnCBsvOiEODtsdwNTYWtCBaukEwb4mTb0lxBQ7DvJWllrCQklxg7w1alb1wL+t2
 dqVtdpjw76y4niAMm0PjLZDfGJgzBQGd2qRQ8DykV7xcXHBuj2J2c0tIQHElyGmJ+Lry+5OBzZ
 8F65Bjpyl/a6KRysexy3MhSoLsp758Ut6BGsG8uaBz/J1G7zs8O4Lt3u84E7Z9Y0bQBnFB+5A6
 db0=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:46 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 32/32] riscv: Update Kendryte K210 defconfig
Date:   Sat,  7 Nov 2020 17:14:20 +0900
Message-Id: <20201107081420.60325-33-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update the k210 nommu default configuration nommu_k210_defconfig to
include device drivers for reset, reboot, I2C, gpio, LEDs and SD card
support. The boot options are modified to mount the file system on the
first partition of the SD card as the root file system.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/configs/nommu_k210_defconfig | 45 +++++++++++++++++++------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index cd1df62b13c7..dda0f437de21 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -1,13 +1,6 @@
 # CONFIG_CPU_ISOLATION is not set
-CONFIG_LOG_BUF_SHIFT=15
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_FORCE=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
-# CONFIG_RD_XZ is not set
-# CONFIG_RD_LZO is not set
-# CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
@@ -25,22 +18,26 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLOB=y
-# CONFIG_SLAB_MERGE_DEFAULT is not set
 # CONFIG_MMU is not set
 CONFIG_SOC_KENDRYTE=y
 CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_CMDLINE="earlycon console=ttySIF0"
+CONFIG_CMDLINE="earlycon console=ttySIF0 rootdelay=2 root=/dev/mmcblk0p1 rw"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_JUMP_LABEL=y
-# CONFIG_BLOCK is not set
+# CONFIG_SECCOMP is not set
+# CONFIG_STACKPROTECTOR_STRONG is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_MQ_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_KYBER is not set
 CONFIG_BINFMT_FLAT=y
 # CONFIG_COREDUMP is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_ALLOW_DEV_COREDUMP is not set
+# CONFIG_BLK_DEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -48,16 +45,42 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_LDISC_AUTOLOAD is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_DEVMEM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_SPI=y
+# CONFIG_SPI_MEM is not set
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_GPIO_CDEV_V1 is not set
+CONFIG_GPIO_DWAPB=y
+CONFIG_GPIO_SIFIVE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+# CONFIG_PWRSEQ_EMMC is not set
+# CONFIG_PWRSEQ_SIMPLE is not set
+CONFIG_MMC_SPI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_USER=y
 # CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_LSM="[]"
 CONFIG_PRINTK_TIME=y
+# CONFIG_SYMBOLIC_ERRNAME is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_MISC is not set
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
-- 
2.28.0

