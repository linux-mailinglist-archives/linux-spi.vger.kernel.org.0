Return-Path: <linux-spi+bounces-8253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F61AC0EF2
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A49A188BFBC
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B483B28EA6D;
	Thu, 22 May 2025 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sj7pAaf6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E228E5F1
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925577; cv=none; b=QukVoabm/YfKDftSi8xPXAkoABH5S57OG0s3MD56dbiUEHL+HKGepy6B7Cs14/SSNYlVoE2DaICPUyYwzv3PjKr6zl8MATNPh3pBDXLn01lSR1Gjulmsjwf+NwqMAvCBCkYyVarKRpSqKVpmK2tliNRUjq2hoyvYZC0XH3CsAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925577; c=relaxed/simple;
	bh=elThI93HwB4PxLZjW2S1nGNED80rFcrhaDTiQgygkCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgUScVd6hafeIAsz2iPM3MNM0RduYJcQGDI52jxtM4O4qf6uzHxi3VAbt5XwMnF+6rARUJLDIZesPWKIY8ijoenQ1FlFstP0Q1xsenrkC9cbs+JsGeeX9sWdawCkWpf4+BcnkZUJAR7HAylihLgmPWDWhDSb7cVb+DE5gupahUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sj7pAaf6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so62419665e9.1
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925574; x=1748530374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQcMbg+mj75exB6fMqaj4+6mofUOuhQ1ONizqDxy1LQ=;
        b=Sj7pAaf6CjWXFhuohXHo/iest4HI0rE3o6T+j5or0vQhuf1CWfHunZEBcrhJC4zRYu
         PmZK5EIjK6Ey1+G5V6OepQ2KichrrD+MUtKKrV6HPQ1UNBXq702OgiHMhetQYWAs6wC2
         5ao5z+lsyykvyVq9DgcegaUwEpe37pR/ZA8x7No9VODQZlgIGbhdk//HRleapUk28x3/
         qhaXFOW8kYyc2hX/Su5ZwWV4CtJRuFiS5Sm8IxfIPe1mpn4F5bIWF+zmaBsAFdHUSS4y
         GEDV/pJag4bvsnOLLY/mqGOnU+UijJbjSPUwdZrweMeSiosKy7BcTTMpAimvAmfl84Nh
         D/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925574; x=1748530374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQcMbg+mj75exB6fMqaj4+6mofUOuhQ1ONizqDxy1LQ=;
        b=WcK6k/CvSj1Pq8VnagNdMxeml5ya1c2DWMP+/A77o1wyP8dcN5uOW3DCgpJxZEv+Ro
         ntq01oOUzDSieFuBxBXOEAWy3imm/FmqBW/usuHnD+Gp5YDgoH1xO3BM3hckSythCUai
         eq/tnddPdWMT//tQB1Z8S89THz+gkIDZLvj7UytUGvXU4zvy9B+RIjDJiT4glXs1Pej0
         Py/i1X9FkOJObpIkNXsl9Rl+aaJxM51l17bVcx84g/UlvNgrJIhSPOlXkx5uNBkmXoH5
         J7h8KWl9knguukG7YceLbFW+3mkovLPhS3PL3RzKtnxwS4gfJbAht64ngryKcI7odHSE
         32Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV5PS6zzavPWMX3i4Ga968seBF+O995UUgwnk8fjgo7shze6Lr6s0/gNZ6VP7JkSvI7z2echNjhS2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OL90WPsShxDjXFhAbZ9nz5g3awYbs1OS50E2QjhOEu/Un9BO
	0Q+Hfs0tIjfYjGDoH93xoPK4ybHS+H7se2xnxCbm5I7je7e/KgNA71jeZvZxTfrhA+4=
X-Gm-Gg: ASbGncueBt2pq+IL2t5Su6JQA6JKprIlkeS7SWUbbJgB7C4GDzZxZcfzEi8Q9cz1V23
	VtfMEHJZY0W4ePMxdCze6xTgQqqeF4LkqMT7aHA8Emz1SSK3tpODDf5kyGVq8yySDLyvG7wIspF
	bSYbrhdI1gi25UlFcfpkZiXnjweJ1Ak1hTn875v0emAgOaPF+Fo+43cGktLAPL87o4WL3Q86kpp
	fsdXC2cOm2g2om3Cq8y5g/hI4YHRSwPrCiwyCAjU9JWDmBKZqfKUAiey61tuYsadCaVdPfgvfO/
	wurUqIZnP9elVbgb5bEQR8Nqh3JkvFZPzCTrGQnwBGCgn4PSZtPN41nicuQtxJu3to1LmCE=
X-Google-Smtp-Source: AGHT+IFcpjDviXjWNB7+EBIbhpiq2tpPR7sQlo7rFyrWtoBHLAjxGUQNW2PIVbs7fj19J7u5oXlJ7g==
X-Received: by 2002:a05:600c:a40a:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-442f84c2092mr260241495e9.3.1747925573711;
        Thu, 22 May 2025 07:52:53 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:52:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 22 May 2025 15:51:38 +0100
Subject: [PATCH v2 09/14] spi: spi-fsl-dspi: Use DMA for S32G controller in
 target mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-james-nxp-spi-v2-9-bea884630cfb@linaro.org>
References: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
In-Reply-To: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chao Fu <B44548@freescale.com>, 
 Xiubo Li <Li.Xiubo@freescale.com>, Lukasz Majewski <lukma@denx.de>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

Switch to DMA for target mode otherwise the controller is too slow to
feed TX FIFO and UNDERFLOW occurs frequently. DMA can work only with 8
and 16 bits per word. 32bits per word is not supported, this is a
hardware limitation, so we keep the controller mode in TCFQ mode.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 24a51267cb4d..db5a2ed66f68 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -139,6 +139,7 @@ enum {
 	MCF5441X,
 	VF610,
 	S32G,
+	S32G_TARGET,
 };
 
 static const struct regmap_range dspi_yes_ranges[] = {
@@ -183,6 +184,7 @@ static const struct regmap_access_table dspi_volatile_table = {
 
 enum {
 	DSPI_REGMAP,
+	S32G_DSPI_REGMAP,
 	DSPI_XSPI_REGMAP,
 	S32G_DSPI_XSPI_REGMAP,
 	DSPI_PUSHR,
@@ -198,6 +200,15 @@ static const struct regmap_config dspi_regmap_config[] = {
 		.rd_table	= &dspi_access_table,
 		.wr_table	= &dspi_access_table,
 	},
+	[S32G_DSPI_REGMAP] = {
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+		.max_register	= SPI_RXFR4,
+		.volatile_table	= &dspi_volatile_table,
+		.wr_table	= &s32g_dspi_access_table,
+		.rd_table	= &s32g_dspi_access_table,
+	},
 	[DSPI_XSPI_REGMAP] = {
 		.reg_bits	= 32,
 		.val_bits	= 32,
@@ -296,6 +307,12 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size	  = 5,
 		.regmap		  = &dspi_regmap_config[S32G_DSPI_XSPI_REGMAP],
 	},
+	[S32G_TARGET] = {
+		.trans_mode	  = DSPI_DMA_MODE,
+		.max_clock_factor = 1,
+		.fifo_size	  = 5,
+		.regmap		  = &dspi_regmap_config[S32G_DSPI_REGMAP],
+	},
 };
 
 struct fsl_dspi_dma {
@@ -351,6 +368,12 @@ struct fsl_dspi {
 	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
 
+static bool is_s32g_dspi(struct fsl_dspi *data)
+{
+	return data->devtype_data == &devtype_data[S32G] ||
+	       data->devtype_data == &devtype_data[S32G_TARGET];
+}
+
 static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
 {
 	switch (dspi->oper_word_size) {
@@ -1426,6 +1449,9 @@ static int dspi_probe(struct platform_device *pdev)
 		dspi->pushr_tx = 0;
 	}
 
+	if (spi_controller_is_target(ctlr) && is_s32g_dspi(dspi))
+		dspi->devtype_data = &devtype_data[S32G_TARGET];
+
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else

-- 
2.34.1


