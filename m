Return-Path: <linux-spi+bounces-9932-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FABB48328
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7625F7A6B4E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 04:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A7223DF1;
	Mon,  8 Sep 2025 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xjQcn7g8"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513922069A;
	Mon,  8 Sep 2025 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304896; cv=none; b=TUQOO1ISCbLpwIJ6EwhgEHaaI0t6CvpNutmr4SjVnZjNHs/lvTd/XyCzkWLTqlDai0x6fQZbvvtR2M87qBHZ6n+msD4ckjYfqa5TlfV7kHUWyAlP+RJTvJH9tLjyGHpJXtGf7QTfUovMXajQ2EZWTONb+CdefgOvlVzoPxwn6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304896; c=relaxed/simple;
	bh=cKX3n6rWGFJTfk7tDF/mwopWyS5qJib2v8JtC7r6+18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aERrCaf5ike5Ge/bW7Z021bXw5dBMqY6PUqRLvOxMXVtKaGGSbT6QNoomZZmam8xUbezLAaLP74kganuUU2osfrIN10cEBWjyIet3pcBpy9kwQjQU7DQAT1LxEG8NdWS9qywmgRhg66gSnsEIli/A49XYEb+oC0KnhjcZAtiBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xjQcn7g8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757304895; x=1788840895;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cKX3n6rWGFJTfk7tDF/mwopWyS5qJib2v8JtC7r6+18=;
  b=xjQcn7g8y+TiUtBchPgaKeXZppqtyllKS3Vkq1P5ouCRUHMTezsB+eVD
   xSbPGsGpPy8fV+skBTKW0Uaz5EMuwoqtxXMTmA510MkU5gVepxH9hrEEh
   QcB3HeyfsN/Kmtwx2Gx+fA/93L04AT18P4ZaATr+8BRMZPajmW505hRiR
   D1IroV+9Z8CyddVVz1lng/pLuANsknxsbDD6vz1mj0vdwCU47auJlTSyA
   GBJq7/8RpIoX8GSp1V+dMYMUh+NXcC1aqMQQBY+qGwp6VJc2Nkm/UKgDm
   cPOBdNa9AUh5XY3LdznLUWxDOvihKEPVbHKOyitOtYz7KA+uHFw/lf4FK
   g==;
X-CSE-ConnectionGUID: YPpoJm/ATHeRsyPuBZAjnw==
X-CSE-MsgGUID: ABxv/VRIQNGiwnMqtgYHlw==
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="213580666"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2025 21:14:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 7 Sep 2025 21:14:44 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 7 Sep 2025 21:14:38 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 8 Sep 2025 09:44:18 +0530
Subject: [PATCH v2 3/5] spi: atmel-quadspi: add padcalib, 2xgclk, and dllon
 capabilities
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-microchip-qspi-v2-3-8f3d69fdd5c9@microchip.com>
References: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
In-Reply-To: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>, Varshini Rajendran
	<varshini.rajendran@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757304860; l=5762;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=5JBcqmcHgI/B+uULblX7KzhNUtP6rsZ4FszumigJ6xc=;
 b=eDwA/G/s0MdJlnAvlkj5O80FXqbNtSMaSe1UnaeJtbM1KyglVumruMOULgRuHGGecX8U2zFzN
 1pEZ6m9vY0RCYR8hDGVZQ+6Fz+ipFSYL/aoGzaEBkI6ZGlmeCCAv+yo
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

From: Varshini Rajendran <varshini.rajendran@microchip.com>

Introduce capability flags for SoC-specific variations of the QuadSPI
controller:

  - has_padcalib: controller supports pad calibration
  - has_2xgclk: requires GCLK at half the data rate (2x clocking)
  - has_dllon: controller supports DLL clock

Set `has_padcalib` for Octal controllers that provide pad calibration
support. Use `has_2xgclk` for controllers that require the GCLK to run
at twice the data rate. Differentiate SoC integration variants with the
`has_dllon` flag and set it as needed.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 92 +++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 4e9bfd26aa80..83cea5faff78 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -262,6 +262,9 @@ struct atmel_qspi_caps {
 	bool has_ricr;
 	bool octal;
 	bool has_dma;
+	bool has_2xgclk;
+	bool has_padcalib;
+	bool has_dllon;
 };
 
 struct atmel_qspi_ops;
@@ -1027,13 +1030,25 @@ static int atmel_qspi_set_pad_calibration(struct atmel_qspi *aq)
 			 aq, QSPI_PCALCFG);
 
 	/* DLL On + start calibration. */
-	atmel_qspi_write(QSPI_CR_DLLON | QSPI_CR_STPCAL, aq, QSPI_CR);
+	if (aq->caps->has_dllon)
+		atmel_qspi_write(QSPI_CR_DLLON | QSPI_CR_STPCAL, aq, QSPI_CR);
+	/* If there is no DLL support only start calibration. */
+	else
+		atmel_qspi_write(QSPI_CR_STPCAL, aq, QSPI_CR);
 
-	/* Check synchronization status before updating configuration. */
-	ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
-				  (val & QSPI_SR2_DLOCK) &&
-				  !(val & QSPI_SR2_CALBSY), 40,
-				  ATMEL_QSPI_TIMEOUT);
+	/*
+	 * Check DLL clock lock and synchronization status before updating
+	 * configuration.
+	 */
+	if (aq->caps->has_dllon)
+		ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
+					  (val & QSPI_SR2_DLOCK) &&
+					  !(val & QSPI_SR2_CALBSY), 40,
+					  ATMEL_QSPI_TIMEOUT);
+	else
+		ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
+					  !(val & QSPI_SR2_CALBSY), 40,
+					  ATMEL_QSPI_TIMEOUT);
 
 	/* Refresh analogic blocks every 1 ms.*/
 	atmel_qspi_write(FIELD_PREP(QSPI_REFRESH_DELAY_COUNTER,
@@ -1049,23 +1064,28 @@ static int atmel_qspi_set_gclk(struct atmel_qspi *aq)
 	int ret;
 
 	/* Disable DLL before setting GCLK */
-	status = atmel_qspi_read(aq, QSPI_SR2);
-	if (status & QSPI_SR2_DLOCK) {
-		atmel_qspi_write(QSPI_CR_DLLOFF, aq, QSPI_CR);
+	if (aq->caps->has_dllon) {
+		status = atmel_qspi_read(aq, QSPI_SR2);
+		if (status & QSPI_SR2_DLOCK) {
+			atmel_qspi_write(QSPI_CR_DLLOFF, aq, QSPI_CR);
+			ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+						 !(val & QSPI_SR2_DLOCK), 40,
+						 ATMEL_QSPI_TIMEOUT);
+			if (ret)
+				return ret;
+		}
 
-		ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
-					 !(val & QSPI_SR2_DLOCK), 40,
-					 ATMEL_QSPI_TIMEOUT);
-		if (ret)
-			return ret;
+		if (aq->target_max_speed_hz > QSPI_DLLCFG_THRESHOLD_FREQ)
+			atmel_qspi_write(QSPI_DLLCFG_RANGE, aq, QSPI_DLLCFG);
+		else
+			atmel_qspi_write(0, aq, QSPI_DLLCFG);
 	}
 
-	if (aq->target_max_speed_hz > QSPI_DLLCFG_THRESHOLD_FREQ)
-		atmel_qspi_write(QSPI_DLLCFG_RANGE, aq, QSPI_DLLCFG);
+	if (aq->caps->has_2xgclk)
+		ret = clk_set_rate(aq->gclk, 2 * aq->target_max_speed_hz);
 	else
-		atmel_qspi_write(0, aq, QSPI_DLLCFG);
+		ret = clk_set_rate(aq->gclk, aq->target_max_speed_hz);
 
-	ret = clk_set_rate(aq->gclk, aq->target_max_speed_hz);
 	if (ret) {
 		dev_err(&aq->pdev->dev, "Failed to set generic clock rate.\n");
 		return ret;
@@ -1088,11 +1108,16 @@ static int atmel_qspi_sama7g5_init(struct atmel_qspi *aq)
 	if (ret)
 		return ret;
 
-	if (aq->caps->octal) {
+	/*
+	 * Check if the SoC supports pad calibration in Octal SPI mode.
+	 * Proceed only if both the capabilities are true.
+	 */
+	if (aq->caps->octal && aq->caps->has_padcalib) {
 		ret = atmel_qspi_set_pad_calibration(aq);
 		if (ret)
 			return ret;
-	} else {
+	/* Start DLL on only if the SoC supports the same */
+	} else if (aq->caps->has_dllon) {
 		atmel_qspi_write(QSPI_CR_DLLON, aq, QSPI_CR);
 		ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
 					  (val & QSPI_SR2_DLOCK), 40,
@@ -1458,19 +1483,19 @@ static int atmel_qspi_sama7g5_suspend(struct atmel_qspi *aq)
 
 	clk_disable_unprepare(aq->gclk);
 
-	atmel_qspi_write(QSPI_CR_DLLOFF, aq, QSPI_CR);
-	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
-				 !(val & QSPI_SR2_DLOCK), 40,
-				 ATMEL_QSPI_TIMEOUT);
-	if (ret)
-		return ret;
-
-	ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
-				  !(val & QSPI_SR2_CALBSY), 40,
-				  ATMEL_QSPI_TIMEOUT);
-	if (ret)
-		return ret;
+	if (aq->caps->has_dllon) {
+		atmel_qspi_write(QSPI_CR_DLLOFF, aq, QSPI_CR);
+		ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+					 !(val & QSPI_SR2_DLOCK), 40,
+					 ATMEL_QSPI_TIMEOUT);
+		if (ret)
+			return ret;
+	}
 
+	if (aq->caps->has_padcalib)
+		return readl_poll_timeout(aq->regs + QSPI_SR2, val,
+					  !(val & QSPI_SR2_CALBSY), 40,
+					  ATMEL_QSPI_TIMEOUT);
 	return 0;
 }
 
@@ -1607,12 +1632,15 @@ static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
 	.has_gclk = true,
 	.octal = true,
 	.has_dma = true,
+	.has_padcalib = true,
+	.has_dllon = true,
 };
 
 static const struct atmel_qspi_caps atmel_sama7g5_qspi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ,
 	.has_gclk = true,
 	.has_dma = true,
+	.has_dllon = true,
 };
 
 static const struct of_device_id atmel_qspi_dt_ids[] = {

-- 
2.43.0


