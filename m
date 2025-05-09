Return-Path: <linux-spi+bounces-8014-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544BAB1189
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7409E4723
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E022728FABC;
	Fri,  9 May 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bA2PtdQe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116A28F958
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788821; cv=none; b=peIN+mMvWUz1nsFL8kD9CAdAAvmKDElP/CmVEhOwhWdOg9TvRr8L5GPJzNy9/rVx3/5OnGHL6FzZgsg8kBiSIpIxlRBunKN0BvIYKxhmnKRCPfPjg95mlu8VTpdc0OVq3RxyXxmZD+wLlY6U/PJf5Z7kqwzDGQVkPmxsEUWVrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788821; c=relaxed/simple;
	bh=lNzAOm2fsnFGf82dcqxl1YBX/mz6uR9h5/TJgWh82NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmQIY8Z9tfg9Uh3+lcI767KzNAMP6gvyqz0XctSSvWsx2JAmLGLMiGszya9qEzshASNcrMf46EU01YWNpPTeSHYoiCzO80UspvFPSY50I3ZGWB0B8QqnDZkyfwWwbxaw8FGGPbz+aSVl2ZT113qiIYfIea34oppTeygZsUx84Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bA2PtdQe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so1726558f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788817; x=1747393617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+3jb/fX+IugayjdNWEytVWeF5yooMmRjS6ouVsYvEU=;
        b=bA2PtdQeVxJdFWl6Ek4y4qB9rQ8yAYJTIWzbu6cUYgSQ+dQDGP58p6R+9nQRusPq7m
         +MnGkujJLu45OkTrpWF2vkWnZhHdGk+gLGdzJtnbVXOmHnU9jAaVwUwdbaoJT7g9L5R3
         xykWYQPvEr1l4TRBIvazL+EGgNS3cbFNMNGh9b6q2ZuPU1WHcCL29fKG37V19n+oWDJh
         o5f36b1A4lrcr6vvc5tC6U7BZrNNd/LbmdwuTUSoC6EmrV4047cLnsYpP4F5w4B2MPau
         rCqCVgxBjXF5eiMj2/tQ1V/r6uejsJLQdbgWeKs5tGZNhK3BgSsVL2kBkr/EEfua760u
         5zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788817; x=1747393617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+3jb/fX+IugayjdNWEytVWeF5yooMmRjS6ouVsYvEU=;
        b=Tdv/6X5s5nIe7SmiSM77QsihSHwrtLxW0BVU462/gv5fsK4xf3q39tG9w6mIUW5BBY
         ZDKoCoq7zTYRS84tWFUoc/UE76UPqqyHOLhfB2Orf1IQ2yjmGQAGrAPsNirsPABCx5hE
         n958Ag13hysCyuzNzDJEd+qByjsDJtaYhPKv8Y5ho8vryjdqhFVR/+ogystfy6SysjLR
         7fAxb2m4KDjrR/ds+XP/pXuH/mzT4a0V3oBV9BRWVi5qshC0zDwHxmH2oneN6tL9vnag
         FK6BROACyKCf/JH2xXn/NGGamPbWy1lB1Mb/Gbx09wmyo2uEPeAuqJltRIHcjk6X9nG+
         AkJQ==
X-Gm-Message-State: AOJu0YwFpCDZxGTWlQJ/0mnmGNKBA51cZZs3uQoUt9F3feLjf7US0gCj
	9B58eBydSTbWB+Jq8NMsvpTUxgZrx7/AQa8l+a96XIZu7AVuh/s6oElLHoLLStc=
X-Gm-Gg: ASbGnctBvS7BVT0tANIOftiUAEUW5Ggi3bimeX3gZsXQrFcyZhB3QdMXqjLUnnN4bNY
	cJkYCGGNrQJMSxFoioW+o7GFWtKmBTn6RB5Yph+sjZSaW4meAr08s/RnuBvLMzF3bFDLYTMbk88
	Fbnk+t6nps7Y/TBFc3Z7fY+H19Gp6IYGj2sGcnp8bjZLTnRsBY8KJGCWwWeeW3vFlYffJ0UVcKB
	7+kXeSZLLvNp1EnBqBbL3D7heSfBUbOQumYzALPwicnPszMNQoP91Do4EtDVG2EcnwOMRSHrQ4d
	wT9nFhgJyLR0aEY2HP4OEzjMxnkeMjMHLMOrqrks0xR39/XadGB4/HWl1g==
X-Google-Smtp-Source: AGHT+IFC6m07o95wlBL8z66ZHFQZFey0yAwlkLMNz025uhOiNU0gJ9upByEMU9FvrvfyyVzrnKIsgw==
X-Received: by 2002:a05:6000:4287:b0:3a0:8c45:d41b with SMTP id ffacd0b85a97d-3a1f6457726mr2691256f8f.20.1746788817253;
        Fri, 09 May 2025 04:06:57 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:06:56 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:49 +0100
Subject: [PATCH 02/14] spi: spi-fsl-dspi: Re-use one volatile regmap for
 both device types
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-2-32bfcd2fea11@linaro.org>
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

max_register overrides anything in the volatile ranges, so we can get
away with sharing the same one for both types. In a later commit we'll
add more devices and also read/write ranges which also override volatile
ranges so this avoids adding even more duplication.

No functional changes.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 31ea8ce81e98..cb0e55a49eea 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -141,6 +141,7 @@ static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
 	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
+	regmap_reg_range(SPI_SREX, SPI_SREX)
 };
 
 static const struct regmap_access_table dspi_volatile_table = {
@@ -148,18 +149,6 @@ static const struct regmap_access_table dspi_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(dspi_volatile_ranges),
 };
 
-static const struct regmap_range dspi_xspi_volatile_ranges[] = {
-	regmap_reg_range(SPI_MCR, SPI_TCR),
-	regmap_reg_range(SPI_SR, SPI_SR),
-	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
-	regmap_reg_range(SPI_SREX, SPI_SREX),
-};
-
-static const struct regmap_access_table dspi_xspi_volatile_table = {
-	.yes_ranges	= dspi_xspi_volatile_ranges,
-	.n_yes_ranges	= ARRAY_SIZE(dspi_xspi_volatile_ranges),
-};
-
 enum {
 	DSPI_REGMAP,
 	DSPI_XSPI_REGMAP,
@@ -179,7 +168,7 @@ static const struct regmap_config dspi_regmap_config[] = {
 		.val_bits	= 32,
 		.reg_stride	= 4,
 		.max_register	= 0x13c,
-		.volatile_table	= &dspi_xspi_volatile_table
+		.volatile_table	= &dspi_volatile_table
 	},
 	[DSPI_PUSHR] = {
 		.name		= "pushr",

-- 
2.34.1


