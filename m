Return-Path: <linux-spi+bounces-9218-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7395B15886
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 07:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E079C165317
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D91DED52;
	Wed, 30 Jul 2025 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WSrBcbjT"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB514F90;
	Wed, 30 Jul 2025 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853942; cv=none; b=X55sgps0ohkfJSUV3TAinUzWofEk+vkxX63zSOS3qDeSFZH4qusPzf1jcSNdJPJ1QvSiDaYbpVbECeglgC1pWePBK6JAxp6mzC8trpn4WxUaeDW0fFCYuQwHpA4k/xATjnw+HNCVGRL3o8qL2FDsqvzoJpBAM+w6QrutEzlPmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853942; c=relaxed/simple;
	bh=aaF4RzhnHIcEcpz1/fOfbiJA8IKYcLEpZOP28Wzp2/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IX6xuH8Qew1GRkvY0W2tK6bOan3oSn5DYXMyei+LDsNVoau/t9g0ml5PJ8RsmLYVqVnH+6Hi1Yl/79JKHMRMbYod98nCjjZzMKSJK9/yn1yZ/vUu7Dt1MCPRcLJw2/dTJXUjoE0eUQSMmuBttLZshSJ2x1MMTUFxaffEYDKL2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WSrBcbjT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753853940; x=1785389940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aaF4RzhnHIcEcpz1/fOfbiJA8IKYcLEpZOP28Wzp2/8=;
  b=WSrBcbjTetUB0nKI4ihV8Wpbp+cfgH2odLSevds27LJ9t3nALK/iS9G2
   EDdAGMSjlF0IcP9zAWIlAAkZFHHkjgLNKGszk2jYquVgk2v3Go6D0Mds+
   /RruQ9CTPvnW7PPpAvamoGA/GTzh47GStJc5uAsdoYCKgVjsTyJrz9vzG
   Xqq3AZiGuOmPq/FhGo8Zs2+pfG/hi7nCEMlNfOc+tp7MwiL8sqhUJS1N1
   537UnRo0Vsy4a+FRFPxbuhGymIYSIx9HgLstcMsKZGdNIyeqmCmshaFvF
   vqknerCirqd8gbdqLbFNS/X7FXnxu76y9ID/vZAlGewMebId3A3bSSRjH
   A==;
X-CSE-ConnectionGUID: c14mdGTVRrKVZSCWv/A+CA==
X-CSE-MsgGUID: zJX4AgxoSUGlowh+GfPKcg==
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="45191583"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2025 22:38:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 29 Jul 2025 22:38:55 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 29 Jul 2025 22:38:51 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <ryan.wanner@microchip.com>, <broonie@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH 3/3] spi: atmel: Add support for handling GCLK as a clock source
Date: Wed, 30 Jul 2025 11:08:47 +0530
Message-ID: <20250730053847.262330-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The SPI peripheral clock is typically used to derive the serial
clock (SPCK) via the FLEX_SPI_CSRx.SCBR field. However, on platforms
like the SAM9X7 SoC, where the peripheral clock can reach up to 266 MHz,
this may exceed the SCBR limit, causing SPI transfers to fail.
This patch adds support for using the SPI Generic Clock (GCLK) as an
alternative and more flexible clock source for SPCK generation.
The FLEX_SPI_MR.BRSRCCLK bit is updated accordingly to select between the
peripheral clock and GCLK.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/spi/spi-atmel.c | 64 +++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 409f544d8983..89977bff76d2 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -256,6 +256,7 @@ struct atmel_spi {
 	void __iomem		*regs;
 	int			irq;
 	struct clk		*clk;
+	struct clk		*gclk;
 	struct platform_device	*pdev;
 	unsigned long		spi_clk;
 
@@ -1480,6 +1481,8 @@ static void atmel_get_caps(struct atmel_spi *as)
 
 static void atmel_spi_init(struct atmel_spi *as)
 {
+	u32 mr = 0;
+
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 
@@ -1487,12 +1490,17 @@ static void atmel_spi_init(struct atmel_spi *as)
 	if (as->fifo_size)
 		spi_writel(as, CR, SPI_BIT(FIFOEN));
 
-	if (as->caps.has_wdrbt) {
-		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
-				| SPI_BIT(MSTR));
-	} else {
-		spi_writel(as, MR, SPI_BIT(MSTR) | SPI_BIT(MODFDIS));
-	}
+	/*
+	 * If GCLK is selected as the source clock for the bit rate generation
+	 * Enable the BRSRCCLK/FDIV/DIV32 bit
+	 */
+	if (as->gclk)
+		mr |= SPI_BIT(FDIV);
+
+	if (as->caps.has_wdrbt)
+		mr |= SPI_BIT(WDRBT);
+
+	spi_writel(as, MR, mr | SPI_BIT(MODFDIS) | SPI_BIT(MSTR));
 
 	if (as->use_pdc)
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
@@ -1555,6 +1563,11 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	as->phybase = regs->start;
 	as->irq = irq;
 	as->clk = clk;
+	as->gclk = devm_clk_get_optional(&pdev->dev, "spi_gclk");
+	if (IS_ERR(as->gclk)) {
+		ret = PTR_ERR(as->gclk);
+		goto out_unmap_regs;
+	}
 
 	init_completion(&as->xfer_completion);
 
@@ -1615,7 +1628,19 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_free_irq;
 
-	as->spi_clk = clk_get_rate(clk);
+	/*
+	 * In cases where the peripheral clock is higher,the FLEX_SPI_CSRx.SCBR
+	 * exceeds the threshold (SCBR ≤ 255), the GCLK is used as the source clock
+	 * for the SPCK (SPI Serial Clock) bit rate generation
+	 */
+	if (as->gclk) {
+		ret = clk_prepare_enable(as->gclk);
+		if (ret)
+			goto out_disable_clk;
+		as->spi_clk = clk_get_rate(as->gclk);
+	} else {
+		as->spi_clk = clk_get_rate(clk);
+	}
 
 	as->fifo_size = 0;
 	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
@@ -1650,6 +1675,8 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
+	clk_disable_unprepare(as->gclk);
+out_disable_clk:
 	clk_disable_unprepare(clk);
 out_free_irq:
 out_unmap_regs:
@@ -1685,6 +1712,8 @@ static void atmel_spi_remove(struct platform_device *pdev)
 	spin_unlock_irq(&as->lock);
 
 	clk_disable_unprepare(as->clk);
+	if (as->gclk)
+		clk_disable_unprepare(as->gclk);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1696,6 +1725,8 @@ static int atmel_spi_runtime_suspend(struct device *dev)
 	struct atmel_spi *as = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(as->clk);
+	if (as->gclk)
+		clk_disable_unprepare(as->gclk);
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -1705,10 +1736,20 @@ static int atmel_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct atmel_spi *as = spi_controller_get_devdata(host);
+	int ret;
 
 	pinctrl_pm_select_default_state(dev);
 
-	return clk_prepare_enable(as->clk);
+	ret = clk_prepare_enable(as->clk);
+	if (ret)
+		return ret;
+	if (as->gclk) {
+		ret = clk_prepare_enable(as->gclk);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int atmel_spi_suspend(struct device *dev)
@@ -1736,10 +1777,17 @@ static int atmel_spi_resume(struct device *dev)
 	ret = clk_prepare_enable(as->clk);
 	if (ret)
 		return ret;
+	if (as->gclk) {
+		ret = clk_prepare_enable(as->gclk);
+		if (ret)
+			return ret;
+	}
 
 	atmel_spi_init(as);
 
 	clk_disable_unprepare(as->clk);
+	if (as->gclk)
+		clk_disable_unprepare(as->gclk);
 
 	if (!pm_runtime_suspended(dev)) {
 		ret = atmel_spi_runtime_resume(dev);
-- 
2.25.1


