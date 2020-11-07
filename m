Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC92AA349
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgKGIO0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgKGIOZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736864; x=1636272864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CIehosSpng4DyAquHyB4Y6WpSVlIJ5/AjtGn+kccXDI=;
  b=IoXsSln92WX6IpoE0visDLEKXjHSu0kbLTPbtVngU2ufyF1aYWLHfv/z
   U2i3LPLBBzhQkgyITw39zAtGsfzbGF34mLp5FXJ6wz6jP9EGOcjeHwWQG
   8ka4U0GYfadUIF+D7qo79XmxJF8zAmOtho2XITuWll2Ag3DGu7Z8OOYWo
   pMbjjvEr/1E/80NvtU0FsTlEkY+wvJPH2TFQQnRQHqICkc+APRxt6+uD4
   Z9MiatYh04xJWnb8Mp2wPEBPTQh4SpKIU69BEzRDM3TXvyD/LU0ZHLXDM
   736d+uyAvAr46NlTO8jW/PIe6ZkJdjaq1sV+cS1xeZGJNplS8sXQ71cJS
   w==;
IronPort-SDR: kW2M0dMfF8XeL+9PzfucphPItWvuIv+kZP4bCbc2HYXPP5A4ZMGRGsw+tImA22FyG6wHCakRaC
 2tIwCYPVMasbWxJMgKeXQxIFmTIHlucPQsMNKJbrcWLaVoTtJS2aQsE+e1f7yvBU8HunbFs9Ei
 71uxZQNaLSTmx6KfInLdOgG5o2cbi52yAAMI1rQn6XjSplnG54e5W/ELO/m0rd+a0IhmxlJ7/d
 /blNrFPYmx7I4y1D8lXh300DxJUi+ckHiz6F6EsjdRreLlj2PGUAm69MmfGmtDDcX7zm5nJq43
 Ub8=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564355"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:23 +0800
IronPort-SDR: cjp5d4R/IuwuhG1YaZM0NxY04sPAE5RIzVwWYXYVdJcVclOag3374CnXHrVIWqwDaqe8YbEQ4e
 b9zPi1G9Ty74uwp3Zwytmg8sBKDS+7sK1WMxx4D0g2EIggD25SahHWkrZbzayr3sGknCWjtOlw
 w7PyTRJpHOPoWk4cmQX8ilI+dnnqhDomwGypkbjQK1BjetFD5NyJyWRU7mpzP8Eg/Nw+nUccyL
 gmBBj6Ru/8IY7uXE8FdSX1E+jobVKlY+Cvhy33V+cZQMyYli4375NOhpadDt0k3zs2ryK6pTZB
 6MLoDDAtyu9arCjeBnysYz3d
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:15 -0800
IronPort-SDR: IYBenekZp641K4uUSLnTntq/QmL9U+tad/k9+rebpUtmkzEqyYbiP1i0clI357NWAhWipnz/Ml
 PrK+FRsvwtgz0Wwj8knbVbVB9aL/n5DIVrOooypmIHS+KkWOUKHVhdyrAfhVUhRZm1Tn4u6b99
 M+ZkYsxfQ42BV9WAEl6ql4PmDJFCo6VVhkWim0cgC8V7BOhKHsCBi/JQAz0o/iLSnLz3J9jLk7
 lpPEZ+Jqv3chtdliwZYtLVj7luRvgnLTalyim8JrnDG8xelRQZwuE99CM+pLm/D3Wtir/F6jGc
 o1o=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:22 -0800
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
Subject: [PATCH 00/32] RISC-V Kendryte K210 support improvments
Date:   Sat,  7 Nov 2020 17:13:48 +0900
Message-Id: <20201107081420.60325-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series of patches improves support for boards based on the Kendryte
K210 RISC-V dual core SoC. Minimal support for this SoC is already
included in the kernel. These patches complete it, enabling support for
most peripherals present on the SoC, as well as introducing device trees
for the various boards available on the market today from SiPeed and
Kendryte.

The first patch of this series is a fix of the device tree parsing code.
Without this fix, a warning is generated when parsing Designware gpio
controller nodes.

The following 6 patches are fixes and improvements to the Designware SPI
driver to enable support for the MMC-spi slot found on all K210 boards.

Pathes 8 to 13 are various fixes for riscv arch code and riscv
dependent devices. Of not here is patch 11 which fix system call
execution in the no MMU case, and patch 13 which simplifies DTB builtin
handling.

The following patches 14 to 25 implement and document idevice tree
mapping of several drivers for the K210 SoC: clock driver, reset
controller and pin function management (pinctrl).

Patches 26 to 31 update the existing K210 device tree and device new
device tree files for several K210 based boards: the MAIX Bit,
MAIXSUINO, MAIX Dock and MAIX Go boards from SiPeed and the KD233
development board from Kendryte.

Finally the last patch updates the k210 nommu defconfig to include
the newly implemented drivers.

A lot of the work on the device tree and on the K210 drivers come from
the work of Sean Anderson for the U-Boot project support of the K210
SoC. Sean also helped with debugging the idriver for the DesignWare SPIi
controller of the SoC.

A tree with all patches applied is available here:
https://github.com/damien-lemoal/linux (use the latest k210-sysctl-vXX
branch). A demonstration of this series used on a SiPeed MAIX Dock
board together with an I2C servo controller can be seen here:
https://damien-lemoal.github.io/linux-robot-arm/#example

This tree was used to build userspace busybox environment image that is
then copied onto SD card with ext2:
https://github.com/damien-lemoal/buildroot
Of note is that running this userspace environment requires a revert of
commit 2217b982624680d19a80ebb4600d05c8586c4f96 introduced during the
5.9 development cycle. Without this revert, execution of the init
process fails. A problem with the riscv port of elf2flt is suspected but
not confirmed. I am now starting to investigate this problem.

Reviews and comments are as always much welcome.


Damien Le Moal (32):
  of: Fix property supplier parsing
  spi: dw: Add support for 32-bits ctrlr0 layout
  spi: dw: Fix driving MOSI low while recieving
  spi: dw: Introduce polling device tree property
  spi: dw: Introduce DW_SPI_CAP_POLL_NODELAY
  spi: dw: Add support for the Kendryte K210 SoC
  dt-bindings: Update DW SPI device tree bindings
  riscv: Fix kernel time_init()
  riscv: Fix SiFive gpio probe
  riscv: Fix sifive serial driver
  riscv: Enable interrupts during syscalls with M-Mode
  riscv: Automatically select sysctl config options
  riscv: Fix builtin DTB handling
  dt-bindings: Define all Kendryte K210 clock IDs
  dt-bindings: Define Kendryte K210 sysctl registers
  dt-bindings: Define Kendryte K210 pin functions
  dt-bindings: Define Kendryte K210 reset signals
  riscv: Add Kendryte K210 SoC clock driver
  riscv: Add Kendryte K210 SoC reset controller
  riscv: Add Kendryte K210 FPIOA pinctrl driver
  dt-bindings: Add Kendryte and Canaan vendor prefix
  dt-binding: Document kendryte,k210-sysctl bindings
  dt-binding: Document kendryte,k210-clk bindings
  dt-bindings: Document kendryte,k210-fpioa bindings
  dt-bindings: Document kendryte,k210-rst bindings
  riscv: Update Kendryte K210 device tree
  riscv: Add SiPeed MAIX BiT board device tree
  riscv: Add SiPeed MAIX DOCK board device tree
  riscv: Add SiPeed MAIX GO board device tree
  riscv: Add SiPeed MAIXDUINO board device tree
  riscv: Add Kendryte KD233 board device tree
  riscv: Update Kendryte K210 defconfig

 .../bindings/clock/kendryte,k210-clk.yaml     |  70 ++
 .../bindings/mfd/kendryte,k210-sysctl.yaml    |  65 ++
 .../bindings/pinctrl/kendryte,k210-fpioa.yaml | 106 ++
 .../bindings/reset/kendryte,k210-rst.yaml     |  78 ++
 .../bindings/spi/snps,dw-apb-ssi.yaml         |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 arch/riscv/Kconfig.socs                       |  29 +-
 arch/riscv/boot/dts/kendryte/Makefile         |   5 +-
 arch/riscv/boot/dts/kendryte/k210.dts         |  23 -
 arch/riscv/boot/dts/kendryte/k210.dtsi        | 564 +++++++++-
 arch/riscv/boot/dts/kendryte/k210_generic.dts |  46 +
 arch/riscv/boot/dts/kendryte/k210_kd233.dts   | 177 ++++
 .../riscv/boot/dts/kendryte/k210_maix_bit.dts | 226 ++++
 .../boot/dts/kendryte/k210_maix_dock.dts      | 229 ++++
 arch/riscv/boot/dts/kendryte/k210_maix_go.dts | 237 +++++
 .../boot/dts/kendryte/k210_maixduino.dts      | 203 ++++
 arch/riscv/configs/nommu_k210_defconfig       |  45 +-
 arch/riscv/include/asm/soc.h                  |  38 -
 arch/riscv/kernel/entry.S                     |   9 +
 arch/riscv/kernel/soc.c                       |  27 -
 arch/riscv/kernel/time.c                      |   3 +
 arch/riscv/mm/init.c                          |   6 +-
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-k210.c                        | 962 +++++++++++++++++
 drivers/gpio/gpio-sifive.c                    |   2 +-
 drivers/of/property.c                         |  17 +-
 drivers/pinctrl/Kconfig                       |  15 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-k210.c                | 999 ++++++++++++++++++
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-k210.c                    | 186 ++++
 drivers/soc/Kconfig                           |   2 +-
 drivers/soc/kendryte/Kconfig                  |  19 +-
 drivers/soc/kendryte/Makefile                 |   2 +-
 drivers/soc/kendryte/k210-sysctl.c            | 253 +----
 drivers/spi/spi-dw-core.c                     |  22 +-
 drivers/spi/spi-dw-mmio.c                     |  20 +-
 drivers/spi/spi-dw.h                          |  10 +
 drivers/tty/serial/sifive.c                   |   1 +
 include/dt-bindings/clock/k210-clk.h          |  61 +-
 include/dt-bindings/mfd/k210-sysctl.h         |  41 +
 include/dt-bindings/pinctrl/k210-pinctrl.h    | 277 +++++
 include/dt-bindings/reset/k210-rst.h          |  42 +
 include/soc/kendryte/k210-sysctl.h            |  11 +
 46 files changed, 4770 insertions(+), 388 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
 delete mode 100644 arch/riscv/boot/dts/kendryte/k210.dts
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_generic.dts
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_kd233.dts
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_maix_bit.dts
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_maix_dock.dts
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_maix_go.dts
 create mode 100644 arch/riscv/boot/dts/kendryte/k210_maixduino.dts
 create mode 100644 drivers/clk/clk-k210.c
 create mode 100644 drivers/pinctrl/pinctrl-k210.c
 create mode 100644 drivers/reset/reset-k210.c
 create mode 100644 include/dt-bindings/mfd/k210-sysctl.h
 create mode 100644 include/dt-bindings/pinctrl/k210-pinctrl.h
 create mode 100644 include/dt-bindings/reset/k210-rst.h
 create mode 100644 include/soc/kendryte/k210-sysctl.h

-- 
2.28.0

