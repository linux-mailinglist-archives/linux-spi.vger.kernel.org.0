Return-Path: <linux-spi+bounces-4843-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAA97B956
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B411C216C4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2C176248;
	Wed, 18 Sep 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="dk7LwF9D"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560E139CF2;
	Wed, 18 Sep 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648082; cv=none; b=flEUKjeR91EsgXmRRUypivi+IJtxM6qHHM8lPWDyHQnBL348gQu3lBCd55XFD7P8N1T7q/eTqnzOj0uypmPLRPnPbuSLR5c9nEzSf2BZ7ZBHh6izhSGmEXTEGspFTkXJmqifE+Kw/2uC6TuqONbIK15eUQc+2FizOqC3Bjmue74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648082; c=relaxed/simple;
	bh=YDJEDjP5ML9dEHjjw6qy/cu/d/6fLY1bxqqv6m1F/RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwi95oWYNCb7w6tP7fe4x/e2hcZOTvT35f9AXwir7h7negveoe+9VkTrNUFVkEdOSqbYWNntb87sy42mZe+P+xKV2CtRL2Ub/yJuwJZ/T2NlLramlhDpR5kGPYVpZg+B7gUAK8L1RrESUmnY07P2I+P6Pp3nrKKZpdulThqKouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=dk7LwF9D; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C78EF1489A60;
	Wed, 18 Sep 2024 10:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726648071; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Fd9MZJW39GZ0U1THm5QHsetjgQiXtpRyDomdZPTupuU=;
	b=dk7LwF9DSYE7xave5W/n+H5SIMVuGICtr+qc4rtx/NLM0JLCq6ZrUYfMTbnuNWXyokJPUv
	VlPn33ttvt28BulJTWW2RqrGf5CJX8Ii/LbN0rgccWw032TVFmE/hYbtYxQTswVbTrpsvq
	g/lX+2mjKjvxyTH2qFGgHEuZ6/cDflOHVxM8UZtYbVz+hkFXuPKG8g7b5MC78Nnxzyae0l
	taRFZSls04jQs+Pzk3pim8W95G8WICxntM6RYajOSSdEioce8IQZSKL1eCdQXtRnPOt043
	1NnYWUORnCbWZxXRGuOls6Pc2KKJcH/vLhgDZUvFAxpB9ff5N6uUkjMz+Om31Q==
From: Alexander Dahl <ada@thorsis.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] spi: atmel-quadspi: Add cs_hold and cs_inactive setting support
Date: Wed, 18 Sep 2024 10:27:44 +0200
Message-Id: <20240918082744.379610-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918082744.379610-1-ada@thorsis.com>
References: <20240918082744.379610-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

spi-cs-inactive-delay-ns in dts is cs_inactive in spi core, and it maps
to DLYCS (Minimum Inactive QCS Delay) in QSPI Mode Register (QSPI_MR).

spi-cs-hold-delay-ns in dts is cs_hold in spi core, and it maps to
DLYBCT (Delay Between Consecutive Transfers) in QSPI_MR.  That one can
be set to other values than 0 only if the chip is not in Serial Memory
Mode (SMM), it must be written to '0' however when in SMM.

Tested on SAM9X60 based board with FPGA implementing custom SPI Memory
protocol.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fcd57cf1f2cf..d46e2ca76330 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -516,21 +516,45 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
 	struct spi_controller *ctrl = spi->controller;
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	unsigned long clk_rate;
+	u32 cs_inactive;
 	u32 cs_setup;
+	u32 cs_hold;
 	int delay;
 	int ret;
 
-	delay = spi_delay_to_ns(&spi->cs_setup, NULL);
-	if (delay <= 0)
-		return delay;
-
 	clk_rate = clk_get_rate(aq->pclk);
 	if (!clk_rate)
 		return -EINVAL;
 
+	/* hold */
+	delay = spi_delay_to_ns(&spi->cs_hold, NULL);
+	if (aq->mr & QSPI_MR_SMM) {
+		if (delay > 0)
+			dev_warn(&aq->pdev->dev,
+				 "Ignoring cs_hold, must be 0 in Serial Memory Mode.\n");
+		cs_hold = 0;
+	} else {
+		delay = spi_delay_to_ns(&spi->cs_hold, NULL);
+		if (delay < 0)
+			return delay;
+
+		cs_hold = DIV_ROUND_UP((delay * DIV_ROUND_UP(clk_rate, 1000000)), 32000);
+	}
+
+	/* setup */
+	delay = spi_delay_to_ns(&spi->cs_setup, NULL);
+	if (delay < 0)
+		return delay;
+
 	cs_setup = DIV_ROUND_UP((delay * DIV_ROUND_UP(clk_rate, 1000000)),
 				1000);
 
+	/* inactive */
+	delay = spi_delay_to_ns(&spi->cs_inactive, NULL);
+	if (delay < 0)
+		return delay;
+	cs_inactive = DIV_ROUND_UP((delay * DIV_ROUND_UP(clk_rate, 1000000)), 1000);
+
 	ret = pm_runtime_resume_and_get(ctrl->dev.parent);
 	if (ret < 0)
 		return ret;
@@ -539,6 +563,10 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
 	aq->scr |= QSPI_SCR_DLYBS(cs_setup);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
+	aq->mr &= ~(QSPI_MR_DLYBCT_MASK | QSPI_MR_DLYCS_MASK);
+	aq->mr |= QSPI_MR_DLYBCT(cs_hold) | QSPI_MR_DLYCS(cs_inactive);
+	atmel_qspi_write(aq->mr, aq, QSPI_MR);
+
 	pm_runtime_mark_last_busy(ctrl->dev.parent);
 	pm_runtime_put_autosuspend(ctrl->dev.parent);
 
-- 
2.39.5


