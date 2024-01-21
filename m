Return-Path: <linux-spi+bounces-533-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE54833567
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jan 2024 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B5EB22D32
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jan 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139910942;
	Sat, 20 Jan 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iULDNPe1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19700101FB
	for <linux-spi@vger.kernel.org>; Sat, 20 Jan 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705770006; cv=none; b=AfsBLEbf48ay0ZE1qrPni16FIb9k3B7qwoPc2vrtKQLzSUG7vI2qrH+x9wpgm+mo2DEvucGiI41hmcJpafz92vH3yDkilb2J/CKwmMRqMSgRjjCH45pCjY5OTWcyuBOmbncOwMAIFSf4eAIpECBP1hKHQPGtYP0nWfEFC+CXMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705770006; c=relaxed/simple;
	bh=iiYRqIr14spdDtRX8XbPLGlK7am6yak5pNR2mkT4XUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZVFhL5rD4pOmEGIqXKBdAOZjAsryTZ3+SzqDJ74jP/Bzg3kzC1uIc3kTklA153YPZJ9DXaDt4ao3W2QU2/jujzsoWG5taiqNWamnu7EePx3bJZ5CVrbNmf7OzF+AGad7dU247qjI9qAyp5YKNKhhQL9gxI4t5GZ+BzUrhAgvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iULDNPe1; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21428d99395so229444fac.1
        for <linux-spi@vger.kernel.org>; Sat, 20 Jan 2024 09:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705770004; x=1706374804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glGHg+SzqygO0Y5IbZ+h4Ne6PeGtd0PUMlqRFswKyG8=;
        b=iULDNPe1KwXosNx7GG+sE9gchJN4Tucx3edG8AsXHe42g1JaHZarZwEQb/6FXwiRLY
         AzQYRoTt/qH5PY+K3KPiJGC981ai6rkP0t7Z8MGFxPDJHvPHD0Y7jbendx24Fn3ucZfe
         y+iv2NPYHXQutuz6sEd14aH994sdeH37D/DRIFm3nNT/wvUrP1hYEP4lRi7IqinBVMNl
         KI3Q9Kd9SiYIfVTornSqB0+psWTtvkCLFcjTtKlGEwmnxMNZspU/drpCLWI9figQpbCJ
         slhZqvL9+S+E8BJUue0SYkVtb3cxe/2Nb+mnkm1JDsII2aJCUuE7GR+25h2e8AXqsdX2
         fxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705770004; x=1706374804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glGHg+SzqygO0Y5IbZ+h4Ne6PeGtd0PUMlqRFswKyG8=;
        b=gOuMuIl4XBhMM6y+8TQ3/V1U6osRx6HRU/XHGS8ikvr6K3y4c7AeZGjZeGIgIPHSzQ
         aOLG1MDd3I17TT9Sc4ToxzqkGV2oSmQDUPDSdWmrQPWUBygYzlCr0GnSmqrHBYPg6Bw/
         avIdoRpvWyxCC99l2lfTUvVlZKNBKZnOvj4De5YqPe07ujZxSQTkdneYnPcXQcFSDdgR
         Ymx1Y7JVgnjhXgJn4vmEK+sX4LVFIil4JW6Kc+b3jcqY2B8pPYwAp6UHvW8AqHn/a24+
         ye8EZIDTHnDE4q1oUAfUsN7e2+GC0y5rTos7SKhWvbp9zCdKpZSdxIJjD4n/mUVXQnvr
         zN7w==
X-Gm-Message-State: AOJu0YwCCs16jI84EzKStFeMTJ5kZ8r7ijGn0qiazsg5QeX/I4qUWsdQ
	XQTIOvfUsz/AkKy177+L8pp9jkhkXQuE6US7dkdy2pqJQdA9zBN3g3pO71tGKxs=
X-Google-Smtp-Source: AGHT+IFx52Mqg9UvAhyMZxSqoBm68J0eDSmn8idCjQbLNMt+HPNn3t9uPTN0PRxOWKxUjhl+YxVwhg==
X-Received: by 2002:a05:6870:304a:b0:204:f46f:4ec9 with SMTP id u10-20020a056870304a00b00204f46f4ec9mr1191429oau.46.1705770002445;
        Sat, 20 Jan 2024 09:00:02 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id dt5-20020a0568705a8500b002142f74c5edsm236389oab.14.2024.01.20.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 09:00:01 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro
Date: Sat, 20 Jan 2024 11:00:01 -0600
Message-Id: <20240120170001.3356-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code by extracting all cases of FIFO depth calculation into
a dedicated macro. No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f7d623ad6ac3..7f7eb8f742e4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -109,6 +109,7 @@
 #define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
 #define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
 					FIFO_LVL_MASK(i))
+#define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
 
 #define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
 #define S3C64XX_SPI_TRAILCNT_OFF	19
@@ -406,7 +407,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
-		return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
+		return xfer->len > FIFO_DEPTH(sdd);
 	} else {
 		return false;
 	}
@@ -495,9 +496,7 @@ static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 	void __iomem *regs = sdd->regs;
 	unsigned long val = 1;
 	u32 status;
-
-	/* max fifo depth available */
-	u32 max_fifo = (FIFO_LVL_MASK(sdd) >> 1) + 1;
+	u32 max_fifo = FIFO_DEPTH(sdd);
 
 	if (timeout_ms)
 		val = msecs_to_loops(timeout_ms);
@@ -604,7 +603,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	 * For any size less than the fifo size the below code is
 	 * executed atleast once.
 	 */
-	loops = xfer->len / ((FIFO_LVL_MASK(sdd) >> 1) + 1);
+	loops = xfer->len / FIFO_DEPTH(sdd);
 	buf = xfer->rx_buf;
 	do {
 		/* wait for data to be received in the fifo */
@@ -741,7 +740,7 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 				    struct spi_transfer *xfer)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
-	const unsigned int fifo_len = (FIFO_LVL_MASK(sdd) >> 1) + 1;
+	const unsigned int fifo_len = FIFO_DEPTH(sdd);
 	const void *tx_buf = NULL;
 	void *rx_buf = NULL;
 	int target_len = 0, origin_len = 0;
@@ -1280,7 +1279,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
 					sdd->port_id, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
-					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1);
+					mem_res, FIFO_DEPTH(sdd));
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
2.39.2


