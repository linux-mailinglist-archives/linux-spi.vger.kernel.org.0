Return-Path: <linux-spi+bounces-11200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A880C5CA65
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB5144F3B36
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649CC3128D2;
	Fri, 14 Nov 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tNZmuUSI"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B031283B;
	Fri, 14 Nov 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116491; cv=none; b=UzeXIvPcmGymFzSfQlkIbcQgJWY6YaL1RxUaVMa0fos/2iExM/kuRsAdD4vHJHcdiy5XJxYXwLYwi6QxHrbulOnkzem7ATuUU/redZYtrv5yxw8XnYuBsawHmEeC7M/HwBTjwPchILswix9ae5OZMDSGdZEdgSOwETuEXw4z3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116491; c=relaxed/simple;
	bh=PurInxcZUIV2FZNa015nP4cEomUXY+aCCTx4mPamlFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n234kXYwCyBEmszyQ8zvT1s+l7eo3sWCGyy7Ii3PNxFPCpgXWWNP4gvAy0RZy2ANDoMifVFPX/zJePUXdnL3rOP+RLf6tifn6yLJeAbSL2Ymcj6lAqEWP6CZ6ysJJKq/kseVn8VUXkFjtkyBEjXhRKtn56aIsg4To5QODxQI71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tNZmuUSI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763116489; x=1794652489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PurInxcZUIV2FZNa015nP4cEomUXY+aCCTx4mPamlFs=;
  b=tNZmuUSI3jqjve59OZlcFb+N5lDm6NbxjaZoGCieQUq6lr0MF2MmylRO
   +PROj0Eg1XtSuIUzVOoGt08ICdKpE8OAloVFOvmVcgEsBeRZuJF+kszIU
   f5gMm+87qkkh7A4pzfkE+LnzJkVjixHQmh5hzbgK3r9zAc2EUcyp0UqwR
   /ypZxVix8H/w56gNNnldn9I2mV5+6y/m/CtsgqOkA46RULaQ/i+3MxJdU
   Cvadua5hMPPDXnT7l+metKWq4dXF0JQZxwJG0V4jq6CDH+SWE+ih/NPDa
   I3wa3fyCFWk0yzJku1qAXcFm6Mw21cOvxchYgdrM6TncOOysmh3wij5Cp
   A==;
X-CSE-ConnectionGUID: vmddLFM+TxWWaTCTVpQ/Sw==
X-CSE-MsgGUID: MwsESHdFT0G09sBEa3Lcrw==
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="49141519"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2025 03:34:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 14 Nov 2025 03:34:21 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 14 Nov 2025 03:34:19 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v4 1/3] spi: microchip: rename driver file and internal identifiers
Date: Fri, 14 Nov 2025 10:45:43 +0000
Message-ID: <20251114104545.284765-2-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114104545.284765-1-prajna.rajendrakumar@microchip.com>
References: <20251114104545.284765-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The spi-microchip-core.c driver provides support for the Microchip
PolarFire SoC (MPFS) "hard" SPI controller. It was originally named
"core" with the expectation that it might also cover Microchip's
CoreSPI "soft" IP, but that never materialized.

The CoreSPI IP cannot be supported by this driver because its register
layout differs substantially from the MPFS SPI controller. In practice
most of the code would need to be replaced to handle those differences
so keeping the drivers separate is the simpler approach.

The file and internal symbols are renamed to reflect MPFS support and
to free up "spi-microchip-core.c" for CoreSPI driver.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/Kconfig                           |  19 +-
 drivers/spi/Makefile                          |   2 +-
 .../spi/{spi-microchip-core.c => spi-mpfs.c}  | 207 +++++++++---------
 3 files changed, 115 insertions(+), 113 deletions(-)
 rename drivers/spi/{spi-microchip-core.c => spi-mpfs.c} (68%)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4d8f00c850c1..d53798036076 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -706,15 +706,6 @@ config SPI_MESON_SPIFC
 	  This enables master mode support for the SPIFC (SPI flash
 	  controller) available in Amlogic Meson SoCs.
 
-config SPI_MICROCHIP_CORE
-	tristate "Microchip FPGA SPI controllers"
-	depends on SPI_MASTER
-	help
-	  This enables the SPI driver for Microchip FPGA SPI controllers.
-	  Say Y or M here if you want to use the "hard" controllers on
-	  PolarFire SoC.
-	  If built as a module, it will be called spi-microchip-core.
-
 config SPI_MICROCHIP_CORE_QSPI
 	tristate "Microchip FPGA QSPI controllers"
 	depends on SPI_MASTER
@@ -871,6 +862,16 @@ config SPI_PL022
 	  controller. If you have an embedded system with an AMBA(R)
 	  bus and a PL022 controller, say Y or M here.
 
+config SPI_POLARFIRE_SOC
+
+	tristate "Microchip FPGA SPI controllers"
+	depends on SPI_MASTER && ARCH_MICROCHIP
+	help
+	  This enables the SPI driver for Microchip FPGA SPI controllers.
+	  Say Y or M here if you want to use the "hard" controllers on
+	  PolarFire SoC.
+	  If built as a module, it will be called spi-mpfs.
+
 config SPI_PPC4xx
 	tristate "PPC4xx SPI Controller"
 	depends on PPC32 && 4xx
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8ff74a13faaa..1f7c06a3091d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -86,7 +86,6 @@ obj-$(CONFIG_SPI_LOONGSON_PLATFORM)	+= spi-loongson-plat.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
-obj-$(CONFIG_SPI_MICROCHIP_CORE)	+= spi-microchip-core.o
 obj-$(CONFIG_SPI_MICROCHIP_CORE_QSPI)	+= spi-microchip-core-qspi.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
@@ -97,6 +96,7 @@ obj-$(CONFIG_SPI_MTK_NOR)		+= spi-mtk-nor.o
 obj-$(CONFIG_SPI_MTK_SNFI)		+= spi-mtk-snfi.o
 obj-$(CONFIG_SPI_MXIC)			+= spi-mxic.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
+obj-$(CONFIG_SPI_POLARFIRE_SOC)		+= spi-mpfs.o
 obj-$(CONFIG_SPI_WPCM_FIU)		+= spi-wpcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_FIU)		+= spi-npcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_PSPI)		+= spi-npcm-pspi.o
diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-mpfs.c
similarity index 68%
rename from drivers/spi/spi-microchip-core.c
rename to drivers/spi/spi-mpfs.c
index 9128b86c5366..9a14d1732a15 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-mpfs.c
@@ -99,7 +99,7 @@
 #define REG_CTRL2		(0x48)
 #define REG_FRAMESUP		(0x50)
 
-struct mchp_corespi {
+struct mpfs_spi {
 	void __iomem *regs;
 	struct clk *clk;
 	const u8 *tx_buf;
@@ -113,34 +113,34 @@ struct mchp_corespi {
 	int n_bytes;
 };
 
-static inline u32 mchp_corespi_read(struct mchp_corespi *spi, unsigned int reg)
+static inline u32 mpfs_spi_read(struct mpfs_spi *spi, unsigned int reg)
 {
 	return readl(spi->regs + reg);
 }
 
-static inline void mchp_corespi_write(struct mchp_corespi *spi, unsigned int reg, u32 val)
+static inline void mpfs_spi_write(struct mpfs_spi *spi, unsigned int reg, u32 val)
 {
 	writel(val, spi->regs + reg);
 }
 
-static inline void mchp_corespi_disable(struct mchp_corespi *spi)
+static inline void mpfs_spi_disable(struct mpfs_spi *spi)
 {
-	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+	u32 control = mpfs_spi_read(spi, REG_CONTROL);
 
 	control &= ~CONTROL_ENABLE;
 
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 }
 
-static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, int fifo_max)
+static inline void mpfs_spi_read_fifo(struct mpfs_spi *spi, int fifo_max)
 {
 	for (int i = 0; i < fifo_max; i++) {
 		u32 data;
 
-		while (mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)
+		while (mpfs_spi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)
 			;
 
-		data = mchp_corespi_read(spi, REG_RX_DATA);
+		data = mpfs_spi_read(spi, REG_RX_DATA);
 
 		spi->rx_len -= spi->n_bytes;
 
@@ -158,34 +158,34 @@ static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, int fifo_max
 	}
 }
 
-static void mchp_corespi_enable_ints(struct mchp_corespi *spi)
+static void mpfs_spi_enable_ints(struct mpfs_spi *spi)
 {
-	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+	u32 control = mpfs_spi_read(spi, REG_CONTROL);
 
 	control |= INT_ENABLE_MASK;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 }
 
-static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
+static void mpfs_spi_disable_ints(struct mpfs_spi *spi)
 {
-	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+	u32 control = mpfs_spi_read(spi, REG_CONTROL);
 
 	control &= ~INT_ENABLE_MASK;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 }
 
-static inline void mchp_corespi_set_xfer_size(struct mchp_corespi *spi, int len)
+static inline void mpfs_spi_set_xfer_size(struct mpfs_spi *spi, int len)
 {
 	u32 control;
 	u32 lenpart;
-	u32 frames = mchp_corespi_read(spi, REG_FRAMESUP);
+	u32 frames = mpfs_spi_read(spi, REG_FRAMESUP);
 
 	/*
 	 * Writing to FRAMECNT in REG_CONTROL will reset the frame count, taking
 	 * a shortcut requires an explicit clear.
 	 */
 	if (frames == len) {
-		mchp_corespi_write(spi, REG_COMMAND, COMMAND_CLRFRAMECNT);
+		mpfs_spi_write(spi, REG_COMMAND, COMMAND_CLRFRAMECNT);
 		return;
 	}
 
@@ -208,20 +208,20 @@ static inline void mchp_corespi_set_xfer_size(struct mchp_corespi *spi, int len)
 	 * that matches the documentation.
 	 */
 	lenpart = len & 0xffff;
-	control = mchp_corespi_read(spi, REG_CONTROL);
+	control = mpfs_spi_read(spi, REG_CONTROL);
 	control &= ~CONTROL_FRAMECNT_MASK;
 	control |= lenpart << CONTROL_FRAMECNT_SHIFT;
-	mchp_corespi_write(spi, REG_CONTROL, control);
-	mchp_corespi_write(spi, REG_FRAMESUP, len);
+	mpfs_spi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_FRAMESUP, len);
 }
 
-static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, int fifo_max)
+static inline void mpfs_spi_write_fifo(struct mpfs_spi *spi, int fifo_max)
 {
 	int i = 0;
 
-	mchp_corespi_set_xfer_size(spi, fifo_max);
+	mpfs_spi_set_xfer_size(spi, fifo_max);
 
-	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_TXFIFO_FULL)) {
+	while ((i < fifo_max) && !(mpfs_spi_read(spi, REG_STATUS) & STATUS_TXFIFO_FULL)) {
 		u32 word;
 
 		if (spi->n_bytes == 4)
@@ -231,7 +231,7 @@ static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, int fifo_ma
 		else
 			word = spi->tx_buf ? *spi->tx_buf : 0xaa;
 
-		mchp_corespi_write(spi, REG_TX_DATA, word);
+		mpfs_spi_write(spi, REG_TX_DATA, word);
 		if (spi->tx_buf)
 			spi->tx_buf += spi->n_bytes;
 		i++;
@@ -240,9 +240,9 @@ static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, int fifo_ma
 	spi->tx_len -= i * spi->n_bytes;
 }
 
-static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
+static inline void mpfs_spi_set_framesize(struct mpfs_spi *spi, int bt)
 {
-	u32 frame_size = mchp_corespi_read(spi, REG_FRAME_SIZE);
+	u32 frame_size = mpfs_spi_read(spi, REG_FRAME_SIZE);
 	u32 control;
 
 	if ((frame_size & FRAME_SIZE_MASK) == bt)
@@ -252,25 +252,25 @@ static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
 	 * Disable the SPI controller. Writes to the frame size have
 	 * no effect when the controller is enabled.
 	 */
-	control = mchp_corespi_read(spi, REG_CONTROL);
+	control = mpfs_spi_read(spi, REG_CONTROL);
 	control &= ~CONTROL_ENABLE;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 
-	mchp_corespi_write(spi, REG_FRAME_SIZE, bt);
+	mpfs_spi_write(spi, REG_FRAME_SIZE, bt);
 
 	control |= CONTROL_ENABLE;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 }
 
-static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
+static void mpfs_spi_set_cs(struct spi_device *spi, bool disable)
 {
 	u32 reg;
-	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
+	struct mpfs_spi *mspi = spi_controller_get_devdata(spi->controller);
 
-	reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
+	reg = mpfs_spi_read(mspi, REG_SLAVE_SELECT);
 	reg &= ~BIT(spi_get_chipselect(spi, 0));
 	reg |= !disable << spi_get_chipselect(spi, 0);
-	corespi->pending_slave_select = reg;
+	mspi->pending_slave_select = reg;
 
 	/*
 	 * Only deassert chip select immediately. Writing to some registers
@@ -281,12 +281,12 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 	 * doesn't see any spurious clock transitions whilst CS is enabled.
 	 */
 	if (((spi->mode & SPI_CS_HIGH) == 0) == disable)
-		mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
+		mpfs_spi_write(mspi, REG_SLAVE_SELECT, reg);
 }
 
-static int mchp_corespi_setup(struct spi_device *spi)
+static int mpfs_spi_setup(struct spi_device *spi)
 {
-	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
+	struct mpfs_spi *mspi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	if (spi_is_csgpiod(spi))
@@ -298,21 +298,21 @@ static int mchp_corespi_setup(struct spi_device *spi)
 	 * driving their select line low.
 	 */
 	if (spi->mode & SPI_CS_HIGH) {
-		reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
+		reg = mpfs_spi_read(mspi, REG_SLAVE_SELECT);
 		reg |= BIT(spi_get_chipselect(spi, 0));
-		corespi->pending_slave_select = reg;
-		mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
+		mspi->pending_slave_select = reg;
+		mpfs_spi_write(mspi, REG_SLAVE_SELECT, reg);
 	}
 	return 0;
 }
 
-static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *spi)
+static void mpfs_spi_init(struct spi_controller *host, struct mpfs_spi *spi)
 {
 	unsigned long clk_hz;
-	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+	u32 control = mpfs_spi_read(spi, REG_CONTROL);
 
 	control &= ~CONTROL_ENABLE;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 
 	control |= CONTROL_MASTER;
 	control &= ~CONTROL_MODE_MASK;
@@ -328,15 +328,15 @@ static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *
 	 */
 	control |= CONTROL_SPS | CONTROL_BIGFIFO;
 
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 
-	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
+	mpfs_spi_set_framesize(spi, DEFAULT_FRAMESIZE);
 
 	/* max. possible spi clock rate is the apb clock rate */
 	clk_hz = clk_get_rate(spi->clk);
 	host->max_speed_hz = clk_hz;
 
-	mchp_corespi_enable_ints(spi);
+	mpfs_spi_enable_ints(spi);
 
 	/*
 	 * It is required to enable direct mode, otherwise control over the chip
@@ -344,34 +344,34 @@ static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *
 	 * can deal with active high targets.
 	 */
 	spi->pending_slave_select = SSELOUT | SSEL_DIRECT;
-	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
+	mpfs_spi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
 
-	control = mchp_corespi_read(spi, REG_CONTROL);
+	control = mpfs_spi_read(spi, REG_CONTROL);
 
 	control &= ~CONTROL_RESET;
 	control |= CONTROL_ENABLE;
 
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 }
 
-static inline void mchp_corespi_set_clk_gen(struct mchp_corespi *spi)
+static inline void mpfs_spi_set_clk_gen(struct mpfs_spi *spi)
 {
 	u32 control;
 
-	control = mchp_corespi_read(spi, REG_CONTROL);
+	control = mpfs_spi_read(spi, REG_CONTROL);
 	if (spi->clk_mode)
 		control |= CONTROL_CLKMODE;
 	else
 		control &= ~CONTROL_CLKMODE;
 
-	mchp_corespi_write(spi, REG_CLK_GEN, spi->clk_gen);
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CLK_GEN, spi->clk_gen);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 }
 
-static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int mode)
+static inline void mpfs_spi_set_mode(struct mpfs_spi *spi, unsigned int mode)
 {
 	u32 mode_val;
-	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+	u32 control = mpfs_spi_read(spi, REG_CONTROL);
 
 	switch (mode & SPI_MODE_X_MASK) {
 	case SPI_MODE_0:
@@ -394,22 +394,22 @@ static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int
 	 */
 
 	control &= ~CONTROL_ENABLE;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 
 	control &= ~(SPI_MODE_X_MASK << MODE_X_MASK_SHIFT);
 	control |= mode_val;
 
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 
 	control |= CONTROL_ENABLE;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mpfs_spi_write(spi, REG_CONTROL, control);
 }
 
-static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
+static irqreturn_t mpfs_spi_interrupt(int irq, void *dev_id)
 {
 	struct spi_controller *host = dev_id;
-	struct mchp_corespi *spi = spi_controller_get_devdata(host);
-	u32 intfield = mchp_corespi_read(spi, REG_MIS) & 0xf;
+	struct mpfs_spi *spi = spi_controller_get_devdata(host);
+	u32 intfield = mpfs_spi_read(spi, REG_MIS) & 0xf;
 	bool finalise = false;
 
 	/* Interrupt line may be shared and not for us at all */
@@ -417,7 +417,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (intfield & INT_RX_CHANNEL_OVERFLOW) {
-		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
+		mpfs_spi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
 		finalise = true;
 		dev_err(&host->dev,
 			"%s: RX OVERFLOW: rxlen: %d, txlen: %d\n", __func__,
@@ -425,7 +425,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	}
 
 	if (intfield & INT_TX_CHANNEL_UNDERRUN) {
-		mchp_corespi_write(spi, REG_INT_CLEAR, INT_TX_CHANNEL_UNDERRUN);
+		mpfs_spi_write(spi, REG_INT_CLEAR, INT_TX_CHANNEL_UNDERRUN);
 		finalise = true;
 		dev_err(&host->dev,
 			"%s: TX UNDERFLOW: rxlen: %d, txlen: %d\n", __func__,
@@ -438,8 +438,8 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mchp_corespi_calculate_clkgen(struct mchp_corespi *spi,
-					 unsigned long target_hz)
+static int mpfs_spi_calculate_clkgen(struct mpfs_spi *spi,
+				     unsigned long target_hz)
 {
 	unsigned long clk_hz, spi_hz, clk_gen;
 
@@ -475,20 +475,20 @@ static int mchp_corespi_calculate_clkgen(struct mchp_corespi *spi,
 	return 0;
 }
 
-static int mchp_corespi_transfer_one(struct spi_controller *host,
-				     struct spi_device *spi_dev,
-				     struct spi_transfer *xfer)
+static int mpfs_spi_transfer_one(struct spi_controller *host,
+				 struct spi_device *spi_dev,
+				 struct spi_transfer *xfer)
 {
-	struct mchp_corespi *spi = spi_controller_get_devdata(host);
+	struct mpfs_spi *spi = spi_controller_get_devdata(host);
 	int ret;
 
-	ret = mchp_corespi_calculate_clkgen(spi, (unsigned long)xfer->speed_hz);
+	ret = mpfs_spi_calculate_clkgen(spi, (unsigned long)xfer->speed_hz);
 	if (ret) {
 		dev_err(&host->dev, "failed to set clk_gen for target %u Hz\n", xfer->speed_hz);
 		return ret;
 	}
 
-	mchp_corespi_set_clk_gen(spi);
+	mpfs_spi_set_clk_gen(spi);
 
 	spi->tx_buf = xfer->tx_buf;
 	spi->rx_buf = xfer->rx_buf;
@@ -496,45 +496,46 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 	spi->rx_len = xfer->len;
 	spi->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(xfer->bits_per_word, BITS_PER_BYTE));
 
-	mchp_corespi_set_framesize(spi, xfer->bits_per_word);
+	mpfs_spi_set_framesize(spi, xfer->bits_per_word);
 
-	mchp_corespi_write(spi, REG_COMMAND, COMMAND_RXFIFORST | COMMAND_TXFIFORST);
+	mpfs_spi_write(spi, REG_COMMAND, COMMAND_RXFIFORST | COMMAND_TXFIFORST);
 
-	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
+	mpfs_spi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
 
 	while (spi->tx_len) {
 		int fifo_max = DIV_ROUND_UP(min(spi->tx_len, FIFO_DEPTH), spi->n_bytes);
 
-		mchp_corespi_write_fifo(spi, fifo_max);
-		mchp_corespi_read_fifo(spi, fifo_max);
+		mpfs_spi_write_fifo(spi, fifo_max);
+		mpfs_spi_read_fifo(spi, fifo_max);
 	}
 
 	spi_finalize_current_transfer(host);
 	return 1;
 }
 
-static int mchp_corespi_prepare_message(struct spi_controller *host,
-					struct spi_message *msg)
+static int mpfs_spi_prepare_message(struct spi_controller *host,
+				    struct spi_message *msg)
 {
 	struct spi_device *spi_dev = msg->spi;
-	struct mchp_corespi *spi = spi_controller_get_devdata(host);
+	struct mpfs_spi *spi = spi_controller_get_devdata(host);
 
-	mchp_corespi_set_mode(spi, spi_dev->mode);
+	mpfs_spi_set_mode(spi, spi_dev->mode);
 
 	return 0;
 }
 
-static int mchp_corespi_probe(struct platform_device *pdev)
+static int mpfs_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *host;
-	struct mchp_corespi *spi;
+	struct mpfs_spi *spi;
 	struct resource *res;
 	u32 num_cs;
 	int ret = 0;
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (!host)
-		return -ENOMEM;
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "unable to allocate host for SPI controller\n");
 
 	platform_set_drvdata(pdev, host);
 
@@ -544,11 +545,11 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	host->num_chipselect = num_cs;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	host->use_gpio_descriptors = true;
-	host->setup = mchp_corespi_setup;
+	host->setup = mpfs_spi_setup;
 	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	host->transfer_one = mchp_corespi_transfer_one;
-	host->prepare_message = mchp_corespi_prepare_message;
-	host->set_cs = mchp_corespi_set_cs;
+	host->transfer_one = mpfs_spi_transfer_one;
+	host->prepare_message = mpfs_spi_prepare_message;
+	host->set_cs = mpfs_spi_set_cs;
 	host->dev.of_node = pdev->dev.of_node;
 
 	spi = spi_controller_get_devdata(host);
@@ -561,7 +562,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	if (spi->irq < 0)
 		return spi->irq;
 
-	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
+	ret = devm_request_irq(&pdev->dev, spi->irq, mpfs_spi_interrupt,
 			       IRQF_SHARED, dev_name(&pdev->dev), host);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
@@ -572,11 +573,11 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(spi->clk),
 				     "could not get clk\n");
 
-	mchp_corespi_init(host, spi);
+	mpfs_spi_init(host, spi);
 
 	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		mchp_corespi_disable(spi);
+		mpfs_spi_disable(spi);
 		return dev_err_probe(&pdev->dev, ret,
 				     "unable to register host for SPI controller\n");
 	}
@@ -586,13 +587,13 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void mchp_corespi_remove(struct platform_device *pdev)
+static void mpfs_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host  = platform_get_drvdata(pdev);
-	struct mchp_corespi *spi = spi_controller_get_devdata(host);
+	struct mpfs_spi *spi = spi_controller_get_devdata(host);
 
-	mchp_corespi_disable_ints(spi);
-	mchp_corespi_disable(spi);
+	mpfs_spi_disable_ints(spi);
+	mpfs_spi_disable(spi);
 }
 
 #define MICROCHIP_SPI_PM_OPS (NULL)
@@ -602,23 +603,23 @@ static void mchp_corespi_remove(struct platform_device *pdev)
  */
 
 #if defined(CONFIG_OF)
-static const struct of_device_id mchp_corespi_dt_ids[] = {
+static const struct of_device_id mpfs_spi_dt_ids[] = {
 	{ .compatible = "microchip,mpfs-spi" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, mchp_corespi_dt_ids);
+MODULE_DEVICE_TABLE(of, mpfs_spi_dt_ids);
 #endif
 
-static struct platform_driver mchp_corespi_driver = {
-	.probe = mchp_corespi_probe,
+static struct platform_driver mpfs_spi_driver = {
+	.probe = mpfs_spi_probe,
 	.driver = {
-		.name = "microchip-corespi",
+		.name = "microchip-spi",
 		.pm = MICROCHIP_SPI_PM_OPS,
-		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
+		.of_match_table = of_match_ptr(mpfs_spi_dt_ids),
 	},
-	.remove = mchp_corespi_remove,
+	.remove = mpfs_spi_remove,
 };
-module_platform_driver(mchp_corespi_driver);
+module_platform_driver(mpfs_spi_driver);
 MODULE_DESCRIPTION("Microchip coreSPI SPI controller driver");
 MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-- 
2.25.1


