Return-Path: <linux-spi+bounces-6266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F25A0721E
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 10:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6949E3A0431
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06DE21576E;
	Thu,  9 Jan 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="J+deoTkV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC71214810;
	Thu,  9 Jan 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416134; cv=none; b=WIkncy27b+La51Mwrss/0Q6AYQ+uTzFRVwzfrGIJ/sbqUzvUNoYqysdOqpmCS8dOswhqjjXnouGLvtc7hCBnJT13NKKUf4FyKjOJ7Z2cNEHITMvjGd1Qm5SXtQEuRUooEwg4yqqq3W3xnEU5yuc7WJF5KJSavW+sxw406IWRzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416134; c=relaxed/simple;
	bh=jRYDn2/gjOcfqscs+3SDDpOyOU8T8oLhpxMeGlF8/24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DVsgjC/L5gmPaZvZozT1ek/z7B5KSGpytH/n7mDsQusORQqSsr2TLb4kk2vHjDA+lY08ARV7/mRlSsGEV/Qyct6px9AkNOZTogYSu5ij51r5cjX+CvTOXMbDniRTktIFlr7XY0eJA18V+zgEW+sStPfzzza1LdSc6v4S8fZlNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=J+deoTkV; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FD2C14857F3;
	Thu,  9 Jan 2025 10:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1736416129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7TZamC5jqbPwUAUS+MKA70f2+K98eLzYXWD6fdZQDpA=;
	b=J+deoTkV8b27+mFiKj2IYxUxqcpiwT6YubqHNlIlvAVGGUMTMvmHf0PTCkYPDtHVYPCo8c
	F7nbkzJ3WXRw7/DmDgCb/Xk4rC3Clx6lgSHit+5s3sEQuj9WnqqfJXT1hETHQxqxYknGgx
	vvPly6oYrSqShL0ICqnTiF0+agnTtSGIEcKE3Ot/Tsrhgd/rDb1e/jmLLcAiWsKm4uDadA
	Z//QYc9mWFNHCgx0eg+2htU4FVYnJr5G/N5YlxozHrOW4XOzKbdMC/yHl16IrBQbh75rE/
	5wOeSbMNfE0r8VEfwggwGgjywcQ2fk57Nwo4Xc+XGq9g7D1ng3sADWvfv3sZmw==
From: Alexander Dahl <ada@thorsis.com>
To: linux-spi@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: atmel-quadspi: Update to current device naming terminology
Date: Thu,  9 Jan 2025 10:48:43 +0100
Message-Id: <20250109094843.36014-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

For v6.9 the spi subsystem changed the terminology to host and target
devices, see commit 99769a52464d ("spi: Update the "master/slave"
terminology in documentation") for reference.  Support for SAMA7G5 was
forward ported recently from an old vendor branch before that
terminology change, so naming for the new struct member is adapted to
follow the current scheme.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 890def915286..f5ca7e34e058 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -280,7 +280,7 @@ struct atmel_qspi {
 	u32			irq_mask;
 	u32			mr;
 	u32			scr;
-	u32			slave_max_speed_hz;
+	u32			target_max_speed_hz;
 	struct completion	cmd_completion;
 	struct completion	dma_completion;
 	dma_addr_t		mmap_phys_base;
@@ -1057,7 +1057,7 @@ static int atmel_qspi_set_pad_calibration(struct atmel_qspi *aq)
 
 	/* Refresh analogic blocks every 1 ms.*/
 	atmel_qspi_write(FIELD_PREP(QSPI_REFRESH_DELAY_COUNTER,
-				    aq->slave_max_speed_hz / 1000),
+				    aq->target_max_speed_hz / 1000),
 			 aq, QSPI_REFRESH);
 
 	return ret;
@@ -1080,12 +1080,12 @@ static int atmel_qspi_set_gclk(struct atmel_qspi *aq)
 			return ret;
 	}
 
-	if (aq->slave_max_speed_hz > QSPI_DLLCFG_THRESHOLD_FREQ)
+	if (aq->target_max_speed_hz > QSPI_DLLCFG_THRESHOLD_FREQ)
 		atmel_qspi_write(QSPI_DLLCFG_RANGE, aq, QSPI_DLLCFG);
 	else
 		atmel_qspi_write(0, aq, QSPI_DLLCFG);
 
-	ret = clk_set_rate(aq->gclk, aq->slave_max_speed_hz);
+	ret = clk_set_rate(aq->gclk, aq->target_max_speed_hz);
 	if (ret) {
 		dev_err(&aq->pdev->dev, "Failed to set generic clock rate.\n");
 		return ret;
@@ -1149,8 +1149,8 @@ static int atmel_qspi_sama7g5_setup(struct spi_device *spi)
 {
 	struct atmel_qspi *aq = spi_controller_get_devdata(spi->controller);
 
-	/* The controller can communicate with a single slave. */
-	aq->slave_max_speed_hz = spi->max_speed_hz;
+	/* The controller can communicate with a single peripheral device (target). */
+	aq->target_max_speed_hz = spi->max_speed_hz;
 
 	return atmel_qspi_sama7g5_init(aq);
 }
-- 
2.39.5


