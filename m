Return-Path: <linux-spi+bounces-9373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD36FB226E8
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36F0169B74
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F391684B4;
	Tue, 12 Aug 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEpJtqoM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53105B661
	for <linux-spi@vger.kernel.org>; Tue, 12 Aug 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001886; cv=none; b=ULh7s9SrudRQSnp1Y8YCT7BguE6WAWuAvT82hhWH5dkXCSruX2jrza7KIOthUBqtnxuz21+VG2ERVoHSQRYnREt7nFLa7tCHm8FUMslUnuqszhYso5bB0hFHmvtE1GxH5abVqhSU9/nrULf+QS5GL7NCTJp1HwcGgeaSUt8n9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001886; c=relaxed/simple;
	bh=xl4GplHPpkZcA8o6A+J4MPU3+phbuzIxpqWmrkD9pcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=To0Yuvad/AndDzK+RHDulStY3ca1TK9yMPyBzFYrqDL2eviLoaILUQk8gft0RTIaGKDW+HIF2cqMLuqZqEg94ZJNwQ7SRZlvJhtq321S6Y04UX6F+dLpo1I/n/wos7JbXgjpvJ6FObvufTb2UsHWNT0wuazgqLCZbwe3Jsg77DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEpJtqoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FE3C4CEF0;
	Tue, 12 Aug 2025 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755001885;
	bh=xl4GplHPpkZcA8o6A+J4MPU3+phbuzIxpqWmrkD9pcY=;
	h=Subject:From:Date:To:From;
	b=sEpJtqoMvaqGqgaJqHHW9/8KLq5lNaA0ivFD4oACDfw0EaVCM7IFGajA65Lzmnpjg
	 0qBJwLoberw6Fm0IKvxruoW5K+ezqha1jDEzcXyy94nwap+gyX5SjflDwdR1oixZre
	 6p/L1hi47Pic7dY6UJZD2Q4tH6MA2cirLprNNrIvxipFnM8Ujs9nhebhAaYn78MX1F
	 SZLbY7gp7Zg/YD9or7k9OQgm4+vqMvUkixNwRqffZ+ehv3k8rgAfzSQTorX1SGS/Wx
	 kTmv+K4UJSUPlJVldEdoGgQsRmkRvqNpJZWuFcdEVdCB2WhEfha/ezrVxtCNwS1Nfo
	 MK0gR/p3TPQGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE8BE383BF51;
	Tue, 12 Aug 2025 12:31:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175500189754.2536290.408836636872330410.git-patchwork-summary@kernel.org>
Date: Tue, 12 Aug 2025 12:31:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/3] spi: atmel: simplify MR register update in cs_activate()
  Submitter: Manikandan Muralidharan <manikandan.m@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=986992
  Lore link: https://lore.kernel.org/r/20250730101015.323964-1-manikandan.m@microchip.com
    Patches: [v2,1/3] spi: atmel: simplify MR register update in cs_activate()
             [v2,2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
             [v2,3/3] spi: atmel: Add support for handling GCLK as a clock source

Series: spi: atmel: Add GCLK support and simplify MR update
  Submitter: Manikandan Muralidharan <manikandan.m@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=988416
  Lore link: https://lore.kernel.org/r/20250805102510.36507-1-manikandan.m@microchip.com
    Patches: [v3,1/3] spi: atmel: simplify MR register update in cs_activate()
             [v3,2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
             [v3,3/3] spi: atmel: Add support for handling GCLK as a clock source

Series: locking/mutex: Mark devm_mutex_init() as __must_check
  Submitter: Thomas Weißschuh <linux@weissschuh.net>
  Committer: Boqun Feng <boqun.feng@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=973065
  Lore link: https://lore.kernel.org/r/20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net
    Patches: [v7,1/3] spi: spi-nxp-fspi: check return value of devm_mutex_init()
             [v7,2/3] leds: lp8860: Check return value of devm_mutex_init()
             [v7,3/3] locking/mutex: Mark devm_mutex_init() as __must_check

Series: Enhance Winbond SPI NAND support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=973420
  Lore link: https://lore.kernel.org/r/20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com
    Patches: [1/8] spi: spi-mem: Use picoseconds for calculating the op durations
             [3/8] mtd: spinand: Fix macro alignment
             [4/8] mtd: spinand: Add a frequency field to all READ_FROM_CACHE variants
             [5/8] mtd: spinand: Add a ->configure_chip() hook
             [6/8] mtd: spinand: winbond: Enable high-speed modes on w25n0xjw
             [7/8] mtd: spinand: winbond: Enable high-speed modes on w35n0xjw
             [8/8] mtd: spinand: winbond: Add comment about the maximum frequency

Series: PM: domains: Detach on device_unbind_cleanup()
  Submitter: Claudiu <claudiu.beznea@tuxon.dev>
  Committer: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=978583
  Lore link: https://lore.kernel.org/r/20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com
    Patches: [v5,1/3] PM: domains: Add flags to specify power on attach/detach
             [v5,2/3] PM: domains: Detach on device_unbind_cleanup()
             [v5,3/3] driver core: platform: Drop dev_pm_domain_detach() call

Series: clk: clk-axi-clkgen: improvements and some fixes
  Submitter: Nuno Sá <nuno.sa@analog.com>
  Committer: Stephen Boyd <sboyd@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=976698
  Lore link: https://lore.kernel.org/r/20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com
    Patches: [RESEND,v7,1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
             [RESEND,v7,2/7] clk: clk-axi-clkgen: make sure to include mod_devicetable.h
             [RESEND,v7,4/7] include: adi-axi-common: add new helper macros
             [RESEND,v7,5/7] clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
             [RESEND,v7,6/7] clk: clk-axi-clkgen move to min/max()
             [RESEND,v7,7/7] clk: clk-axi-clkgen: fix coding style issues

Series: iio: adc: ad7173: add SPI offload support
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Jonathan Cameron <Jonathan.Cameron@huawei.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977925
  Lore link: https://lore.kernel.org/r/20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com
    Patches: [v3,01/12] iio: adc: ad_sigma_delta: don't overallocate scan buffer
             [v3,02/12] iio: adc: ad_sigma_delta: sort includes
             [v3,03/12] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
             [v3,04/12] iio: adc: ad_sigma_delta: use sizeof() in ALIGN()
             [v3,05/12] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
             [v3,06/12] iio: adc: ad_sigma_delta: audit included headers
             [v3,07/12] iio: adc: ad_sigma_delta: refactor setting read address
             [v3,08/12] iio: adc: ad_sigma_delta: use spi_optimize_message()
             [v3,11/12] iio: adc: ad_sigma_delta: add SPI offload support

Patch: [v2] spi: spi-qpic-snand: avoid double assignment in qcom_spi_probe()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=989406
  Lore link: https://lore.kernel.org/r/20250808-qpic-snand-double-assign-fix-v2-1-1a3d0ed0d404@gmail.com

Series: MIPS: some compilation fixes for the Lantiq platform
  Submitter: Shiji Yang <yangshiji66@outlook.com>
  Committer: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=973484
  Lore link: https://lore.kernel.org/r/OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com
    Patches: [01/16] MIPS: lantiq: xway: mark ltq_ar9_sys_hz() as static
             [02/16] MIPS: lantiq: xway: mark dma_init() as static
             [03/16] MIPS: lantiq: xway: mark dcdc_init() as static
             [04/16] MIPS: lantiq: irq: fix misc missing-prototypes warnings
             [05/16] MIPS: lantiq: xway: add prototype for ltq_get_cp1_base()
             [06/16] MIPS: pci: lantiq: marks pcibios_init() as static
             [07/16] MIPS: lantiq: falcon: fix misc missing-prototypes warnings
             [08/16] MIPS: lantiq: falcon: sysctrl: remove unused falcon_trigger_hrst()
             [09/16] MIPS: lantiq: falcon: sysctrl: add missing header prom.h
             [10/16] MIPS: lantiq: falcon: sysctrl: fix request memory check logic
             [11/16] MIPS: lantiq: xway: gptu: mark gptu_init() as static
             [15/16] pinctrl: falcon: mark pinctrl_falcon_init() as static

Patch: spi: sunplus: sp7021: Clean up coding style
  Submitter: Darshan Rathod <rathod.darshan.0896@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=986420
  Lore link: https://lore.kernel.org/r/20250728124104.6370-1-rathod.darshan.0896@gmail.com

Patch: dpll: Make ZL3073X invisible
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Jakub Kicinski <kuba@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=987019
  Lore link: https://lore.kernel.org/r/97804163aeb262f0e0706d00c29d9bb751844454.1753874405.git.geert+renesas@glider.be

Patch: [v2] spi: nxp-fspi: Remove error print for devm_add_action_or_reset()
  Submitter: Waqar Hameed <waqar.hameed@axis.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=988396
  Lore link: https://lore.kernel.org/r/pndqzxqkt8u.a.out@axis.com

Series: spi: sh-msiof: Transfer size improvements and I2S reuse
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=963630
  Lore link: https://lore.kernel.org/r/cover.1747401908.git.geert+renesas@glider.be
    Patches: [v2,01/22] spi: sh-msiof: Drop comma after OF match table sentinel
             [v2,22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>

Series: arm64: dts: rockchip: Add spi nodes for RK3528
  Submitter: Chukun Pan <amadeus@jmu.edu.cn>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=964517
  Lore link: https://lore.kernel.org/r/20250520100102.1226725-1-amadeus@jmu.edu.cn
    Patches: [1/2] spi: dt-bindings: Add rk3528-spi compatible
             [2/2] arm64: dts: rockchip: Add spi nodes for RK3528

Series: arm64: lan969x: Add support for Microchip LAN969x SoC
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=978329
  Lore link: https://lore.kernel.org/r/20250702183856.1727275-1-robert.marko@sartura.hr
    Patches: [v8,01/10] arm64: Add config for Microchip SoC platforms
             [v8,08/10] dma: xdmac: make it selectable for ARCH_MICROCHIP


Total patches: 56

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



