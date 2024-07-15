Return-Path: <linux-spi+bounces-3858-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B710C9312D7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 13:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7399F284B57
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDC41891D7;
	Mon, 15 Jul 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bcFzJES1"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480E1891A5;
	Mon, 15 Jul 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042090; cv=none; b=DeyN1oefrP1m2mSGSCNZ+AsW7C2CEF0ZRUn4nTWYr4HNmDLHfrNICvIWRumRJouv/DDhcVgwC/IcKGrtN4zXK/2ix5ddne2DX6ELA2lIrE1pktXW/xp+fBqPW5uHukm9+VjEsXZJmo4Ef6k8LL/dktxp5a6DKlGdOjtoAMN8Nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042090; c=relaxed/simple;
	bh=NXNXL1xT5+UvrV3ibFpbe2K2Z+0D5MCmpxvqPM7gzmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZnYF/Fl1xjLR9EGB1H6/exP8/UhUN6TpGOEz5swVNdRtycEXx4VgfkNRlEbnzPp/h0Q1gF19xxBipzbxzYuq3T/Zt46YZmTB5KA+PLwwJWdWV+4hnZw+A+J2Vw+B9Kwn6K9KwRpyJtwxfrg7KqC3yKZUFZUs97NptY4uCF/Kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bcFzJES1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721042088; x=1752578088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXNXL1xT5+UvrV3ibFpbe2K2Z+0D5MCmpxvqPM7gzmU=;
  b=bcFzJES1PFi+05UvmZRKdAZRF2lr5hf27Dj3NRD8Mh03LXSDkfSuyN7L
   XGsooQKY10tcUCFTa0w8BhbIhXbknV+f8DI5EtB0aumcI/986fwFNcjJ2
   Io2Zr1juASjaUrcn3iqpx9enFHMCIkNrR7RP4bG7mvb51iSe0LAzg5FoH
   weRTxnAtar360C+pT3MPkk0FGVNOnBhoYzUSpRk0ftw6GmLGldnxHtMs7
   iVthrucs0E6dvlgMxWfjIBWUuVMxEU11lnrwdyCSZBthpe2l1WKBWtTIH
   t3tOaaVGzRdSbhtM9lCR9DlCrU+W4okVvj6pwU/XQqEQI4D+bYbcDSYxi
   w==;
X-CSE-ConnectionGUID: M47IHorFQcORQBAq4muecw==
X-CSE-MsgGUID: xWHl+s0hRa+Wqhj1MtjQ2g==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="196643520"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 04:14:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 04:14:36 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jul 2024 04:14:34 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Steve Wilkins
	<steve.wilkins@raymarine.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/6] spi: microchip-core: only disable SPI controller when register value change requires it
Date: Mon, 15 Jul 2024 12:13:54 +0100
Message-ID: <20240715-depict-twirl-7e592eeabaad@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715-retail-magnolia-bbd49a657a89@wendy>
References: <20240715-retail-magnolia-bbd49a657a89@wendy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6940; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NT4JUdvpl6iSpbilBTfZw/4jGaMmLjLauZJxF8XSE7Y=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlTWYoecnP7vsjasdutLzLxVZnsVoPPk++qcjqFGS1Xf6j8 bNfSjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk/nSG/5WL/pSftD0fbiX+oG/Haq a158N2hbYo/nc0Kp3oUB6/LpOR4eLZQ1qiN9tSI+f8ELjhaveBj91w2SXdlXeLJxo8Old2lBsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Steve Wilkins <steve.wilkins@raymarine.com>

Setting up many of the registers for a new SPI transfer involves
unconditionally disabling the SPI controller, writing the register
value and re-enabling the controller. This is being done for registers
even when the value is unchanged and is also done for registers that
don't require the controller to be disabled for the change to take
effect. Make an effort to detect changes to the register values, and
only disables the controller if the new register value is different
and disabling the controller is required. This stops the controller
being repeated disabled and the bus going tristate before every
transfer.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 79 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index b042160bd8811..24a728bde8fda 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -75,6 +75,7 @@
 
 #define REG_CONTROL		(0x00)
 #define REG_FRAME_SIZE		(0x04)
+#define  FRAME_SIZE_MASK	GENMASK(5, 0)
 #define REG_STATUS		(0x08)
 #define REG_INT_CLEAR		(0x0c)
 #define REG_RX_DATA		(0x10)
@@ -89,6 +90,7 @@
 #define REG_RIS			(0x24)
 #define REG_CONTROL2		(0x28)
 #define REG_COMMAND		(0x2c)
+#define  COMMAND_CLRFRAMECNT	BIT(4)
 #define REG_PKTSIZE		(0x30)
 #define REG_CMD_SIZE		(0x34)
 #define REG_HWSTATUS		(0x38)
@@ -149,62 +151,59 @@ static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi)
 
 static void mchp_corespi_enable_ints(struct mchp_corespi *spi)
 {
-	u32 control, mask = INT_ENABLE_MASK;
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
 
-	mchp_corespi_disable(spi);
-
-	control = mchp_corespi_read(spi, REG_CONTROL);
-
-	control |= mask;
-	mchp_corespi_write(spi, REG_CONTROL, control);
-
-	control |= CONTROL_ENABLE;
+	control |= INT_ENABLE_MASK;
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
 
 static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
 {
-	u32 control, mask = INT_ENABLE_MASK;
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
 
-	mchp_corespi_disable(spi);
-
-	control = mchp_corespi_read(spi, REG_CONTROL);
-	control &= ~mask;
-	mchp_corespi_write(spi, REG_CONTROL, control);
-
-	control |= CONTROL_ENABLE;
+	control &= ~INT_ENABLE_MASK;
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
 
 static inline void mchp_corespi_set_xfer_size(struct mchp_corespi *spi, int len)
 {
 	u32 control;
-	u16 lenpart;
+	u32 lenpart;
+	u32 frames = mchp_corespi_read(spi, REG_FRAMESUP);
 
 	/*
-	 * Disable the SPI controller. Writes to transfer length have
-	 * no effect when the controller is enabled.
+	 * Writing to FRAMECNT in REG_CONTROL will reset the frame count, taking
+	 * a shortcut requires an explicit clear.
 	 */
-	mchp_corespi_disable(spi);
+	if (frames == len) {
+		mchp_corespi_write(spi, REG_COMMAND, COMMAND_CLRFRAMECNT);
+		return;
+	}
 
 	/*
 	 * The lower 16 bits of the frame count are stored in the control reg
 	 * for legacy reasons, but the upper 16 written to a different register:
 	 * FRAMESUP. While both the upper and lower bits can be *READ* from the
-	 * FRAMESUP register, writing to the lower 16 bits is a NOP
+	 * FRAMESUP register, writing to the lower 16 bits is (supposedly) a NOP.
+	 *
+	 * The driver used to disable the controller while modifying the frame
+	 * count, and mask off the lower 16 bits of len while writing to
+	 * FRAMES_UP. When the driver was changed to disable the controller as
+	 * infrequently as possible, it was discovered that the logic of
+	 * lenpart = len & 0xffff_0000
+	 * write(REG_FRAMESUP, lenpart)
+	 * would actually write zeros into the lower 16 bits on an mpfs250t-es,
+	 * despite documentation stating these bits were read-only.
+	 * Writing len unmasked into FRAMES_UP ensures those bits aren't zeroed
+	 * on an mpfs250t-es and will be a NOP for the lower 16 bits on hardware
+	 * that matches the documentation.
 	 */
 	lenpart = len & 0xffff;
-
 	control = mchp_corespi_read(spi, REG_CONTROL);
 	control &= ~CONTROL_FRAMECNT_MASK;
 	control |= lenpart << CONTROL_FRAMECNT_SHIFT;
 	mchp_corespi_write(spi, REG_CONTROL, control);
-
-	lenpart = len & 0xffff0000;
-	mchp_corespi_write(spi, REG_FRAMESUP, lenpart);
-
-	control |= CONTROL_ENABLE;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mchp_corespi_write(spi, REG_FRAMESUP, len);
 }
 
 static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
@@ -227,17 +226,22 @@ static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
 
 static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
 {
+	u32 frame_size = mchp_corespi_read(spi, REG_FRAME_SIZE);
 	u32 control;
 
+	if ((frame_size & FRAME_SIZE_MASK) == bt)
+		return;
+
 	/*
 	 * Disable the SPI controller. Writes to the frame size have
 	 * no effect when the controller is enabled.
 	 */
-	mchp_corespi_disable(spi);
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	control &= ~CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
 
 	mchp_corespi_write(spi, REG_FRAME_SIZE, bt);
 
-	control = mchp_corespi_read(spi, REG_CONTROL);
 	control |= CONTROL_ENABLE;
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
@@ -334,8 +338,6 @@ static inline void mchp_corespi_set_clk_gen(struct mchp_corespi *spi)
 {
 	u32 control;
 
-	mchp_corespi_disable(spi);
-
 	control = mchp_corespi_read(spi, REG_CONTROL);
 	if (spi->clk_mode)
 		control |= CONTROL_CLKMODE;
@@ -344,12 +346,12 @@ static inline void mchp_corespi_set_clk_gen(struct mchp_corespi *spi)
 
 	mchp_corespi_write(spi, REG_CLK_GEN, spi->clk_gen);
 	mchp_corespi_write(spi, REG_CONTROL, control);
-	mchp_corespi_write(spi, REG_CONTROL, control | CONTROL_ENABLE);
 }
 
 static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int mode)
 {
-	u32 control, mode_val;
+	u32 mode_val;
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
 
 	switch (mode & SPI_MODE_X_MASK) {
 	case SPI_MODE_0:
@@ -367,12 +369,13 @@ static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int
 	}
 
 	/*
-	 * Disable the SPI controller. Writes to the frame size have
+	 * Disable the SPI controller. Writes to the frame protocol have
 	 * no effect when the controller is enabled.
 	 */
-	mchp_corespi_disable(spi);
 
-	control = mchp_corespi_read(spi, REG_CONTROL);
+	control &= ~CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+
 	control &= ~(SPI_MODE_X_MASK << MODE_X_MASK_SHIFT);
 	control |= mode_val;
 
-- 
2.43.2


