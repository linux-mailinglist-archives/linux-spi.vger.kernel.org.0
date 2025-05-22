Return-Path: <linux-spi+bounces-8245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36DAC0ECF
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF117F881
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0C23A57F;
	Thu, 22 May 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNSBDOs+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186728CF5E
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925564; cv=none; b=hLOLUzD1SdxicT8q73rwf45T27LnILuEKzbDmddghVimnOeZxh44q0UNRWxMU4qH2rDnm79Zim7vg6dOTNPjGBu2pVNv3B0HyEK0aGaJO5ib9ZM1HSxbvAuX/e9hZiCyJNLjlyhJ9GrUY+IRUtHQ1TIPe0lpxfyN+GDNZda8Fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925564; c=relaxed/simple;
	bh=yddrBEmi1RYqf8QMPGgBcWKQg/oZLwzcf2KAxCgTLyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSCym6glQ93US04WCJ4HL9VFCdYIJkF9URUxVQ0g2rRF4YKRac3l5bnukcyd8Bv9U70E5nOFAlemfgxSbhXQzoYGP8V6/QK5j94FuleywcrHfEUnPm5A2DiCVN1GjoAUF3ZeBSd/lYwIVEC8eqVJzP3KJqkxGCVSgevi2YAxKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iNSBDOs+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ede096d73so60189935e9.2
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925561; x=1748530361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX8Np3nsOAVhGpGTczqX2XujPUCRtkdhb7ZQQUV9YcY=;
        b=iNSBDOs+MMhuiLuDAcRdu9I+vI7gHLrc9jXE+Dt9dNoNgHG75a2KmijfrlXHp+g3ee
         +F3X2zb10n4dp81Ubp12RctJPondXf1OJfpJDkOxWnY6AIi7SY+8SIm8rADC7pYXeEVg
         ecicqkTPEoc8vXOHsrPJiac+Q90nyhieAdLJz5hVXulBrGEMvJ5PejeLylIzLelPaIAH
         EP+qGdTiRnB8kzpIn+I7wUN3Vgbw65gpkb88b8P3umP+AOMLUdhDRXZbopebyaLyI6oj
         GJda2rjaus+SS+0rKkostd2tdluXWJVJzaqOC8SXffZIY5y1uF4btCke8iwQylPVBqCr
         arBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925561; x=1748530361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX8Np3nsOAVhGpGTczqX2XujPUCRtkdhb7ZQQUV9YcY=;
        b=qf6sH6ici2K9Ab3bsXjKu+9GLpKyPYMnOYmGOm2QSnOvIWL5VjDf16xu9xsca9dlVB
         siXbvcB5Zs5E6cBFa0tqZB9y7rYth8LmPD2CbOWIhiGpe7JStZv8g1lQ+xVGcFYEGAC/
         8WcuJzE+i//wQOCQxiifxdn858RBbKJflou6ZAlDZZqgnyo0FNJuUe/yd75rLhkuZdJH
         DIvviRilZRxN/B+6PGgZujwE8cSrF2m6bxFL+rysGjfgnRPBxxTqq1AawmSVs5Urmmtk
         87w5vaHjxbcysTNzvEQvK+iqNCeNXIuSU/t43OLzaTekhCGtLXZpIn17Cl+KXmbBo62u
         ZElQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIGKB/V5pABRdfAQI03VxB9b0aVvKU4puVGmp9DKri2zahw8t+gshB+Zfb6sMxO2qpgr5ksGLg5hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt/1m1YvrreRf62I2YcOa9uFRNiDBepLHnOZu61XYaKiBl8Lf
	Qi+afVdgHdUeRqVFomJ0N2GvjtAQPkl6kRDYg6OZr2fGPmxBlV/wxFx/Z6JWGcizD+I=
X-Gm-Gg: ASbGncvEIE/KZNwvrh1qWYLnF3zLiTO1sCDmS8iWl5C4QShMFivNNPmkHfPkxEgdAtS
	ABieMhuOqKPmng5hhftJRcVAqWgt09mTTlLIyn5ojsWDxf0jNldIORmwoFUaO7wBlmudnTAFJ+g
	NdEcZQO7Y51vAgz4NoBYaydcU6XYNLNlrz+lpDVlohs9kxVfOnxj4V7/d/RIX0lmOTaWnGsl1kT
	mgYX5t2787cm2PnC3tuGrT1f429WeO59iTXhONwDSX4nsfj5j9wTIxrYt/j0hQ+7wJFOUugbk7T
	DgZ7lE5lJXH8HLQHcm0E4Roeh3ISNBCppwozkVWWW4XN2B3S26Yya9IJ0HmU
X-Google-Smtp-Source: AGHT+IHkwaJ6gHJgvWiPzVxDv2dV6i3HHkhWCA1c5/mCAe/0o4MB5fUJzCgJeRD5hGESr2V3uBRYRg==
X-Received: by 2002:a05:600c:4ed2:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442fd67504emr191953925e9.28.1747925560426;
        Thu, 22 May 2025 07:52:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:52:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 22 May 2025 15:51:30 +0100
Subject: [PATCH v2 01/14] spi: spi-fsl-dspi: restrict register range for
 regmap access
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-james-nxp-spi-v2-1-bea884630cfb@linaro.org>
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
 Xulin Sun <xulin.sun@windriver.com>, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

DSPI registers are NOT continuous, some registers are reserved and
accessing them from userspace will trigger external abort, add regmap
register access table to avoid below abort.

  For example on S32G:

  # cat /sys/kernel/debug/regmap/401d8000.spi/registers

  Internal error: synchronous external abort: 96000210 1 PREEMPT SMP
  ...
  Call trace:
  regmap_mmio_read32le+0x24/0x48
  regmap_mmio_read+0x48/0x70
  _regmap_bus_reg_read+0x38/0x48
  _regmap_read+0x68/0x1b0
  regmap_read+0x50/0x78
  regmap_read_debugfs+0x120/0x338

Fixes: 1acbdeb92c87 ("spi/fsl-dspi: Convert to use regmap and add big-endian support")
Co-developed-by: Xulin Sun <xulin.sun@windriver.com>
Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 067c954cb6ea..effb460d436d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
-// Copyright 2020 NXP
+// Copyright 2020-2025 NXP
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
@@ -1167,6 +1167,20 @@ static int dspi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
+static const struct regmap_range dspi_yes_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_MCR),
+	regmap_reg_range(SPI_TCR, SPI_CTAR(3)),
+	regmap_reg_range(SPI_SR, SPI_TXFR3),
+	regmap_reg_range(SPI_RXFR0, SPI_RXFR3),
+	regmap_reg_range(SPI_CTARE(0), SPI_CTARE(3)),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
+static const struct regmap_access_table dspi_access_table = {
+	.yes_ranges	= dspi_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(dspi_yes_ranges),
+};
+
 static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
@@ -1184,6 +1198,8 @@ static const struct regmap_config dspi_regmap_config = {
 	.reg_stride	= 4,
 	.max_register	= 0x88,
 	.volatile_table	= &dspi_volatile_table,
+	.rd_table	= &dspi_access_table,
+	.wr_table	= &dspi_access_table,
 };
 
 static const struct regmap_range dspi_xspi_volatile_ranges[] = {
@@ -1205,6 +1221,8 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 		.reg_stride	= 4,
 		.max_register	= 0x13c,
 		.volatile_table	= &dspi_xspi_volatile_table,
+		.rd_table	= &dspi_access_table,
+		.wr_table	= &dspi_access_table,
 	},
 	{
 		.name		= "pushr",

-- 
2.34.1


