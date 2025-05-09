Return-Path: <linux-spi+bounces-8016-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3FDAB118E
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF061C071F8
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7722900BF;
	Fri,  9 May 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLxOoJY0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF028FAB6
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788825; cv=none; b=FSWWihlm6/gzGarC56R6jth08mfqKYUvPzgzWy3n6U+mwyE0XmFLDxzeWWf3I+lbCyfsfkVZ8k7sJ++hs3bJlsiLZuRGjC/mq4nbyF4UhPJ5S6RJX+AAvtOBo9kmI2WY9iXX2zvKIYpv8s02UkdSVyv3WMK/iCTkXtWz+rZr394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788825; c=relaxed/simple;
	bh=uxItPjqCvg33dWDIcD9DK2czP0Ojdua2Kzevid/t8oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDgsQbIoT2obqn1gfVnOVdgsrOWDrstuJUdKrBOnnSuTe8QyUI6ApjLvaZpQTc16cnPDhpMKYJGU1hBUggybnWA1dEYvPFfRsWPrnJoZ14ppUnCr4DDlVqsZLG7yNJgI1NwXimKpRTVuJKh2s6+ldYkFyPVyc9A9orxQQ1grUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLxOoJY0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a1b8e8b2b2so750909f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788820; x=1747393620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kS0UyNciGcvIX/4wvXI4EYR5mKVhADe3ICPtGq7iTLM=;
        b=yLxOoJY0kakGFf3Tbqab7ebI0WTY+HLH/HJfDcEI+TUUek4mMVsh/jSJGN9PFUEUUF
         s3kOQw6iyoFhfOJ5kYeR2aexcrTUlrT0w0HbUDmddkM/7eTgUApSJZjbPf5RR2orypnF
         kAmK+TfB5ube3MzOpc2zzE4xpHtWAuSSCVqwDkC/fomn5vrc0bidfP1UOZPmqSll3drq
         r4awOK9xjSD2qafyIgdL6gpTP8UZRHUdFbGa7RbotI6SogX+GleKVPjX9DOBzpBdXQzf
         qLARsBDmdHgBOPVktv3/+gxVupORUevQHsIrLZwqG70RKBhXSsEgVI545hSfsobYJ5cY
         Cs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788820; x=1747393620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS0UyNciGcvIX/4wvXI4EYR5mKVhADe3ICPtGq7iTLM=;
        b=lFY2KooFA9WYGrAOZmI7pAD1RgS1Z1B4CBQ8UVAKvPWVMvwHZZIq9mGM4NZSon7Ew9
         Jq+wF3BDN5thscujOrya9axXNJjlfi6YqiZh1Rv8VPNofPqfbr/drVPHPZL6gUknt7om
         uc6zFdxLlm4wOF+J8CkwTy9vBlxtb3CX03TT38PyiP1Ep88aEJ64fBjGQs2UnK78HO2S
         UpMz+uCg+eSfjGsh8Rz/qPMw3KejN6OxPPKUiz8FyR9Ejg0Vva+AoVZgHe61qXTS8K0Q
         7W2mgglZAuT+ggPqvQoM31JTXVY9ltUKk+597PLChcKJ/v/TRsqofB1r0eqTdR6WIoXJ
         Mkbw==
X-Gm-Message-State: AOJu0YyQXhbTOqz4nRRffaG8Om/tIPNBf+OK38ib3jsjymw1GQvnsrbI
	vTvT1x1UTI8HXmC6KBMG/favQ5eoxHf0JQMoUFYOvzJ5mPCyx45PS2J9HwDyRos=
X-Gm-Gg: ASbGncs1ADWwURtmBmIuaLUm2U1Tg+n5DlS6eqNl8vgiCdD9gexFrFlGVqF2o8ljycw
	bBG3WYpkF+gzZuV/kfzs4fP+rrwpriHYrUfIWRSOBBi4taoKvb5wsvSz7KltmwujqtjvAGiHE5z
	9Jfm6saIMbqPu6NRaV9OdxGxZI6NFXZmCqHaHmf9UYl2MD4eFjcl2nOzg/FK77iUDaYSCpH+oms
	PIFMzOxZDS9UZliEGzyE23rG6FonPDbSxmKaMo/msgKJnkPxjED7ojV7QwgKL78s4jMHjYCdy2V
	p8K71cTYGSQcX9g2kTqK+wnN9khTHe+tTIBq0bXLlYL++lBnO4X8En/R6g==
X-Google-Smtp-Source: AGHT+IEjLExiBo/pTRwIXb6nfVt9VVnMblJ/vXH80y5StmUX3A8QBF3za9FzG7eNZqTpd9SVfNtr1w==
X-Received: by 2002:a05:6000:2dc4:b0:39c:dfa:c3de with SMTP id ffacd0b85a97d-3a1f64a383dmr2369977f8f.47.1746788820116;
        Fri, 09 May 2025 04:07:00 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:06:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:51 +0100
Subject: [PATCH 04/14] spi: spi-fsl-dspi: Add config and regmaps for S32G
 platforms
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-4-32bfcd2fea11@linaro.org>
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

S32G adds SPI_{T,R}XFR4 and extends SPI_CTAR registers to 5. Add the
new regmaps, configs and bits.

dspi_volatile_ranges gets SPI_{T,R}XFR4 added which affects all
platforms, however they are further limited by dspi_yes_ranges.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 701cf56d28e7..df6f85122bfe 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -35,7 +35,7 @@
 #define SPI_TCR				0x08
 #define SPI_TCR_GET_TCNT(x)		(((x) & GENMASK(31, 16)) >> 16)
 
-#define SPI_CTAR(x)			(0x0c + (((x) & GENMASK(1, 0)) * 4))
+#define SPI_CTAR(x)			(0x0c + (((x) & GENMASK(2, 0)) * 4))
 #define SPI_CTAR_FMSZ(x)		(((x) << 27) & GENMASK(30, 27))
 #define SPI_CTAR_CPOL			BIT(26)
 #define SPI_CTAR_CPHA			BIT(25)
@@ -92,12 +92,14 @@
 #define SPI_TXFR1			0x40
 #define SPI_TXFR2			0x44
 #define SPI_TXFR3			0x48
+#define SPI_TXFR4			0x4C
 #define SPI_RXFR0			0x7c
 #define SPI_RXFR1			0x80
 #define SPI_RXFR2			0x84
 #define SPI_RXFR3			0x88
+#define SPI_RXFR4			0x8C
 
-#define SPI_CTARE(x)			(0x11c + (((x) & GENMASK(1, 0)) * 4))
+#define SPI_CTARE(x)			(0x11c + (((x) & GENMASK(2, 0)) * 4))
 #define SPI_CTARE_FMSZE(x)		(((x) & 0x1) << 16)
 #define SPI_CTARE_DTCP(x)		((x) & 0x7ff)
 
@@ -135,6 +137,7 @@ enum {
 	LX2160A,
 	MCF5441X,
 	VF610,
+	S32G
 };
 
 static const struct regmap_range dspi_yes_ranges[] = {
@@ -146,15 +149,29 @@ static const struct regmap_range dspi_yes_ranges[] = {
 	regmap_reg_range(SPI_SREX, SPI_SREX),
 };
 
+static const struct regmap_range s32g_dspi_yes_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_MCR),
+	regmap_reg_range(SPI_TCR, SPI_CTAR(5)),
+	regmap_reg_range(SPI_SR, SPI_TXFR4),
+	regmap_reg_range(SPI_RXFR0, SPI_RXFR4),
+	regmap_reg_range(SPI_CTARE(0), SPI_CTARE(5)),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
 static const struct regmap_access_table dspi_access_table = {
 	.yes_ranges	= dspi_yes_ranges,
 	.n_yes_ranges	= ARRAY_SIZE(dspi_yes_ranges),
 };
 
+static const struct regmap_access_table s32g_dspi_access_table = {
+	.yes_ranges	= s32g_dspi_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(s32g_dspi_yes_ranges),
+};
+
 static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
-	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
+	regmap_reg_range(SPI_PUSHR, SPI_RXFR4),
 	regmap_reg_range(SPI_SREX, SPI_SREX)
 };
 
@@ -166,6 +183,7 @@ static const struct regmap_access_table dspi_volatile_table = {
 enum {
 	DSPI_REGMAP,
 	DSPI_XSPI_REGMAP,
+	S32G_DSPI_XSPI_REGMAP,
 	DSPI_PUSHR
 };
 
@@ -188,6 +206,15 @@ static const struct regmap_config dspi_regmap_config[] = {
 		.wr_table	= &dspi_access_table,
 		.rd_table	= &dspi_access_table
 	},
+	[S32G_DSPI_XSPI_REGMAP] = {
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+		.max_register	= 0x13c,
+		.volatile_table	= &dspi_volatile_table,
+		.wr_table	= &s32g_dspi_access_table,
+		.rd_table	= &s32g_dspi_access_table,
+	},
 	[DSPI_PUSHR] = {
 		.name		= "pushr",
 		.reg_bits	= 16,
@@ -262,6 +289,12 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size		= 16,
 		.regmap			= &dspi_regmap_config[DSPI_REGMAP]
 	},
+	[S32G] = {
+		.trans_mode		= DSPI_XSPI_MODE,
+		.max_clock_factor	= 1,
+		.fifo_size		= 5,
+		.regmap			= &dspi_regmap_config[S32G_DSPI_XSPI_REGMAP]
+	}
 };
 
 struct fsl_dspi_dma {

-- 
2.34.1


