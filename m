Return-Path: <linux-spi+bounces-8298-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFBAC3E2A
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 12:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4AC16E9B5
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC01DF987;
	Mon, 26 May 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="npd5rTTO"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A31F2C58;
	Mon, 26 May 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256800; cv=none; b=jf8bosrVUGFioVkz2+6Vo2ZD1CN2ngNLh5Nsu5AqW2PIE8fW9R+OPQagP1kFKPRROC2aHXAnirGgJwnqry5L8g4EPRJ3Bpl8QjfrRKw6aRmNorJUbsFfcNCcydeCx6g1GCuA+F5qahlZORw2WQ+Gpwa3wYZkbo+X6moN+ZZalx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256800; c=relaxed/simple;
	bh=WLKM1lsIY+1Am20lyCuFsPPqSoIW9AVqjjqK8uiQasI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jm4viEBsTGLmySXPYIK+4eYRf/XXRn0eAjuly+V4VPv1f/je5tILbMk2/ETlz8fXxtfZvfc4ySbsqdCbqb2jvlAVCZYbixYTxNdMCjJNGYYEuaybnBPrTHpm8JZYFAliDrUx/3tYhzyuNBPvhI6T1eqSKPQD7iRufDbiAT7oNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=npd5rTTO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748256798; x=1779792798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WLKM1lsIY+1Am20lyCuFsPPqSoIW9AVqjjqK8uiQasI=;
  b=npd5rTTOi7WFARHrhu33sRwWlqtWEq0RMYttxgyV/NArVgv9ARHhK00I
   +Idn3hAAUgvt+fwg+0tUzoPU9jkPhrMlib+jpH478gMVCzx9JDOmh++dG
   4thOF9XDiiHi+WNIoYe7CJuqIg6B6RVZQ6vhW4Jwf6ZhXUtKnO8Y8INty
   uC333UTM3z16C2QwAcDlb+EnrR1bxrhMmX29XnevD1ofc9+lJmdosMwe+
   9D8A+xq1Nc4p0KKdmtlL+em3j7PIpNRlhBz+DpC6Mwm3fOFCwqQYXz3Qm
   SuSIgLa3ygQd49hAdMdjIfpcWQdrVqnDMYkeN+uLVEvLN2sZlTKxFmkmu
   w==;
X-CSE-ConnectionGUID: 2vE0bmw2Q+S5uRXMsSlSIg==
X-CSE-MsgGUID: YxTr3YiZRrO253hlhgRwyg==
X-IronPort-AV: E=Sophos;i="6.15,315,1739862000"; 
   d="scan'208";a="41615861"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2025 03:53:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 26 May 2025 03:53:11 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 26 May 2025 03:53:09 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 for-next] spi: spi-pci1xxxx: Add support for 25MHz Clock frequency in C0
Date: Mon, 26 May 2025 16:19:08 +0530
Message-ID: <20250526104908.404564-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support for 25MHz clock frequency. Support for this frequency
is added in C0.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 330078b1d50f..e9153570e9e9 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -23,6 +23,7 @@
 #define	SYS_FREQ_DEFAULT		(62500000)
 
 #define	PCI1XXXX_SPI_MAX_CLOCK_HZ	(30000000)
+#define	PCI1XXXX_SPI_CLK_25MHZ		(25000000)
 #define	PCI1XXXX_SPI_CLK_20MHZ		(20000000)
 #define	PCI1XXXX_SPI_CLK_15MHZ		(15000000)
 #define	PCI1XXXX_SPI_CLK_12MHZ		(12000000)
@@ -318,12 +319,14 @@ static void pci1xxxx_spi_set_cs(struct spi_device *spi, bool enable)
 	writel(regval, par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 }
 
-static u8 pci1xxxx_get_clock_div(u32 hz)
+static u8 pci1xxxx_get_clock_div(struct pci1xxxx_spi *par, u32 hz)
 {
 	u8 val = 0;
 
 	if (hz >= PCI1XXXX_SPI_MAX_CLOCK_HZ)
 		val = 2;
+	else if (par->dev_rev >= 0xC0 && hz >= PCI1XXXX_SPI_CLK_25MHZ)
+		val = 1;
 	else if ((hz < PCI1XXXX_SPI_MAX_CLOCK_HZ) && (hz >= PCI1XXXX_SPI_CLK_20MHZ))
 		val = 3;
 	else if ((hz < PCI1XXXX_SPI_CLK_20MHZ) && (hz >= PCI1XXXX_SPI_CLK_15MHZ))
@@ -423,7 +426,7 @@ static int pci1xxxx_spi_transfer_with_io(struct spi_controller *spi_ctlr,
 
 	p->spi_xfer_in_progress = true;
 	p->bytes_recvd = 0;
-	clkdiv = pci1xxxx_get_clock_div(xfer->speed_hz);
+	clkdiv = pci1xxxx_get_clock_div(par, xfer->speed_hz);
 	tx_buf = xfer->tx_buf;
 	rx_buf = xfer->rx_buf;
 	transfer_len = xfer->len;
@@ -492,7 +495,7 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	}
 	p->xfer = xfer;
 	p->mode = spi->mode;
-	p->clkdiv = pci1xxxx_get_clock_div(xfer->speed_hz);
+	p->clkdiv = pci1xxxx_get_clock_div(par, xfer->speed_hz);
 	p->bytes_recvd = 0;
 	p->rx_buf = xfer->rx_buf;
 	regval = readl(par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
-- 
2.25.1


