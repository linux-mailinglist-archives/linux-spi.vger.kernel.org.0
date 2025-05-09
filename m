Return-Path: <linux-spi+bounces-8021-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCAAB1199
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD724E647A
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282DA291877;
	Fri,  9 May 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcmkc4NY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A60291161
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788831; cv=none; b=raoux0cnpUa035ffnd+cuamGeARxGF06+CPV/65jzGso2up9rZvUyT0trIGj5K1E7qlTcWMF7P6UdFr4tIj/9XLqfd0BZ2nvfKhLRXVcf2UQIuxmdgXteN6NlWQC4PlTRWiERtnN/xsTZRU52Dq6IXw9If4jFQ+vpZOQdWmqomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788831; c=relaxed/simple;
	bh=S/bLVRCZo0bzcqIxKXf/hzh5QW5OR0CMl07vRP4K15U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4bq2vece91K+obNO3oSccAJUmLB3kJ4H14QuBlj7w4f3jTVL36LY+KnsBoyYD2Ws7N6m5E4XLx46td+qzVnLiJLCkry1veSKQT9o7riCyyoVj03lsUoy4fUfxCVBoO+n+wceOxRlYXNnA6V9Q2BW89aRIjBvLJVzKJNg88Jzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fcmkc4NY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf257158fso13094105e9.2
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788827; x=1747393627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEyehrM+Fx4o61r/yR0u4BgsTY9lmtx/SKx/NBJ8aCc=;
        b=fcmkc4NY3e06M3r35eJcaaQJvrglBrg2+8r5I4v18Qq1gGy52ko2ucK/R26ePMG9dU
         vq1sWhdRdgnILOA2bcPC6tONNH8hsZu0Xw5WOZhKbZK0KJES76T4Cv+R/MXPd52SXh8G
         zjhVE1s83JZfCXIEnAYo33slZ6GMqnjsk8YInsjZJEcvNVmWCrT1uklRkEuzmsvn1F5M
         t+aYIAGgDTBOeU62TTcF1ebW9NNm0owXqioMS91rO2FlldYXsGitBj3YCJFQ6lB27SXR
         Zsf3scFjYvik8nIu9PQndeNVMJQMc18QJFT5LSsPSmEgwWF9L0t7tZDbsboakbNYtuIm
         wnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788827; x=1747393627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEyehrM+Fx4o61r/yR0u4BgsTY9lmtx/SKx/NBJ8aCc=;
        b=QWMR0IJO/aTVF/T0ufigNr2n9m3WT9WNN6844jbUm+y61xGvFKIhCSzjSeDu/sG/MN
         PkirRTq1KZVo/5drC7BQolfsj1/jNKXsm+nlDdwH7ujHf8XyFveQBZnshEr60poGxkT0
         OF2BTrWxa15K1hzOvG6edyzojppc3Qax7hASlhObFmkD7SoM1xrjX81SnVFOcE86bbEC
         Beo3N1VM5LhnOTO7mktd8w7nHXl3ZCaR+cnMlc1IawPQMneKqR/BgEqDafVKSxH+tLto
         Yj68w6lnyZ/3ESIkszUzkuUBqtbljw87hjcb5wUiJWRAbUPpVGqG0LO6WDfw7wFRTtHP
         XE/Q==
X-Gm-Message-State: AOJu0Yxex7syyg5mp4ezW8IZrCEbtKd/nMoJUxrnSjq4WFpLQieGeoFX
	XkBF6uwQ37mY8fZRc+/JIrTjt9QCODNS8Tw7JhxNW9kshnJdw/IutA3ANHIgTbk=
X-Gm-Gg: ASbGnctXUDspGu46CKpwGIXchb7Q2/5RuL/dU3RWdcDt4YuXdQ49HDGUOeBPG5uGW+V
	UdQW5Tb+99JInGFUW5GphQMqAoYxKZIYiHGcUmcjFf345he/fb+dj0riPvUzTqc1sZsHVgvAOzc
	eCAHqG32e35lc32QQtvviaj/iW4N+KgTkUab/QGg/3K3q0vom3Mh8E38YEPrV+8kQf9VH/y6Nf3
	uKeIAmlRXtvgVesuf3q1/PXDSNGod3Xh4b2LXBnaSR9d6WJnF5zOy5PuLk/7FWlaWAFYrVSIIjG
	63Eh4z7uStayBo6ysRqZZ8pK+LJi1djeYR8+6lyCTNuTGcc=
X-Google-Smtp-Source: AGHT+IEQntKAHHe5FBbl7TvKgw8FWGCOZDWYXdtRsViQGulRTo3e/GMO/aV0MJn1nNmDeMFHI32nUQ==
X-Received: by 2002:a05:6000:2506:b0:3a0:a0e5:d28b with SMTP id ffacd0b85a97d-3a1f6421ecemr2453655f8f.3.1746788827070;
        Fri, 09 May 2025 04:07:07 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:06 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:56 +0100
Subject: [PATCH 09/14] spi: spi-fsl-dspi: Reinitialize DSPI regs after
 resuming for S32G
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-9-32bfcd2fea11@linaro.org>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
In-Reply-To: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org, 
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

After resuming, DSPI registers (MCR and SR) need to be reinitialized for
S32G platforms.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 73 +++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 50cec3b94322..0613642d769d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1258,6 +1258,39 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
 
+static int dspi_init(struct fsl_dspi *dspi)
+{
+	unsigned int mcr;
+
+	/* Set idle states for all chip select signals to high */
+	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->max_native_cs - 1, 0));
+
+	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
+		mcr |= SPI_MCR_XSPI;
+	if (!spi_controller_is_target(dspi->ctlr))
+		mcr |= SPI_MCR_HOST;
+
+	regmap_write(dspi->regmap, SPI_MCR, mcr);
+	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+
+	switch (dspi->devtype_data->trans_mode) {
+	case DSPI_XSPI_MODE:
+		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_CMDTCFE);
+		break;
+	case DSPI_DMA_MODE:
+		regmap_write(dspi->regmap, SPI_RSER,
+			     SPI_RSER_TFFFE | SPI_RSER_TFFFD |
+			     SPI_RSER_RFDFE | SPI_RSER_RFDFD);
+		break;
+	default:
+		dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
+			dspi->devtype_data->trans_mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int dspi_suspend(struct device *dev)
 {
@@ -1284,6 +1317,13 @@ static int dspi_resume(struct device *dev)
 	if (ret)
 		return ret;
 	spi_controller_resume(dspi->ctlr);
+
+	ret = dspi_init(dspi);
+	if (ret) {
+		dev_err(dev, "failed to initialize dspi during resume\n");
+		return ret;
+	}
+
 	if (dspi->irq)
 		enable_irq(dspi->irq);
 
@@ -1293,39 +1333,6 @@ static int dspi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
-static int dspi_init(struct fsl_dspi *dspi)
-{
-	unsigned int mcr;
-
-	/* Set idle states for all chip select signals to high */
-	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->max_native_cs - 1, 0));
-
-	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-		mcr |= SPI_MCR_XSPI;
-	if (!spi_controller_is_target(dspi->ctlr))
-		mcr |= SPI_MCR_HOST;
-
-	regmap_write(dspi->regmap, SPI_MCR, mcr);
-	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
-
-	switch (dspi->devtype_data->trans_mode) {
-	case DSPI_XSPI_MODE:
-		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_CMDTCFE);
-		break;
-	case DSPI_DMA_MODE:
-		regmap_write(dspi->regmap, SPI_RSER,
-			     SPI_RSER_TFFFE | SPI_RSER_TFFFD |
-			     SPI_RSER_RFDFE | SPI_RSER_RFDFD);
-		break;
-	default:
-		dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-			dspi->devtype_data->trans_mode);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int dspi_target_abort(struct spi_controller *host)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(host);

-- 
2.34.1


