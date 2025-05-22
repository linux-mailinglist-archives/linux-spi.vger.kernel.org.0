Return-Path: <linux-spi+bounces-8248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD9AC0EDC
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BB21C00BBF
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189128DEFD;
	Thu, 22 May 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWLSo5Ln"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E428DB4B
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925569; cv=none; b=mIeXD2btfSCXgyg6jKfDiTDG7AduEasZjiVinGRzt/DYKpr5WjTDA1x6XCHQGVQevywalCmmJO6qyYCEaS4dRB58s8O+JR/XUcQ3NdKfKXUAQUkBQ/mSh6l/EI6MHAesir8g7rdBq23WOq9uVfUtB+ovOj+Cdz9HiwnNVnOIheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925569; c=relaxed/simple;
	bh=vEU6OoOW4QiG7DnelFnexzER5F3I/xGLtYoU/uX9NAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=famZH7yIUaYweWur5jDfnQ72mJwX0QLkO1msjVnd98Uf2CVS1HS9c5O8JH0Clt8ACtUst20J+FsLLcGRdwHMz+3M+FxSmPfAF0LgGNxXdkI22RTq+CuSaVUh8ZN9Cm8a9qTnpPqKqN5e9k6a2hnk6S18XakE+kOcgaR5eLNAZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kWLSo5Ln; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf848528aso74011625e9.2
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925565; x=1748530365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NSuSoLSh+LHiSs84RzlVPklfrqct9bYGikZDMbgQUs=;
        b=kWLSo5LnbyKT5XEPMXRRF1qHee9/oE3Ni7mHdjgcNB1Ssow8B3b5BQeKSCSoVDj8YA
         Wqvd8Lg3o4DcgdpbGH2HLIgDlZF7t45TF04w+GpQFaFGDIfUrx/f/bvRKTMfIJAETPeD
         GE9p5PK6NxegObEd+1V0CnLN+TOCUh8ZYhuUjrfKuzSomfi0U94TfLcx/nhUoXelW+Uk
         xiZqC1wDFLUssmUrhc6VWp86rYQ7+6/dJdqNxrJgW8Owa6iRMc43NGQqeO/uxNR2MxLS
         q/h7sbnabBzRbHFZXQpJ0jEwZRE20Zs7S2+J8Si8T/E0UMSf14NwWKPd2lcoaG4Jf804
         l/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925565; x=1748530365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NSuSoLSh+LHiSs84RzlVPklfrqct9bYGikZDMbgQUs=;
        b=SH+tE+MBRQRe7t3A+R7fC5oJ3WJZ4kEz0HAz6QBXc2DNKifF97lzD0qC5mOcUuyDWs
         6R6fXycvLJkmz+BW/+cSmJbAtrKa0iSOw4VKw5iQzEffRvQdV5sjJ6XkWFsCsjXaLhrv
         h/Ooxgz0LoKyHq8NdvdKCHt4ETs3ctJrhmGo9554ObRuS8hUTK0Oycm9+HcDTE8wOaOY
         tzIlmxuermq5kbl8H36GPNMoX8wx3ChNpKn+xHJd2ketpnyXxH/qY61d/kDCVk5kXY/O
         QsHO/Nz+BOlhBL2nHHX4WvqvDfp2tgrk7sPksbxXS8oCprk9i1HlXMwsG03TGtQRyzdu
         G6cA==
X-Forwarded-Encrypted: i=1; AJvYcCXVILEdMWH3yP/zH0vgeiny+PUsM6tdwrlJ73a/C4ooFSWGxubwfCYspQp5RfbocFyMyY0kG1jm+Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMIMCIQd/m+ZnZCtQS4xA4ajK2Bj69ZlSzISErqkF9NYW2txhz
	S0hxbRjjBH4HBL0uPbUALcgGLzUqB+37KLvHkpJe9u9f2ZrTzmm7Y4+AGLavG66qKBU=
X-Gm-Gg: ASbGncsg1x5HfrLaT3ULqXoSxzMNHYMVXz9siDYmmYwjoHIsUo0p+z23nKptkkelADc
	g1XxyFO7C5I0kLbdAvb6uCgUBSYEnhe+kn+bRaaWewaKCCoenbPb7C5jZeMt28UTF9z2dD4lICC
	G8zfL50sW8hc9BM48DTMrdrOYhbbjuMvxpw87epzqb1hPSHp3RLmMM7MuoMkCTc2aHg6vUwFw8z
	owgrsaXnZATcS1TziIt5yQ0MV+9T6trBN6jzA+C6l0RXbAOV6zONXGO3oLJULTr5SiUV0PjcIuC
	WVNT08Qz+nSXvreR5ko/KX0IsbD+0g2n/18F6hjyKqgNW1Qme0mhekdG8wvF
X-Google-Smtp-Source: AGHT+IG7lHM8gO7TjtKSOgQg+mAp19Lx1pEqwgmpnkH4a719vOS4PONUqtAkN0R9pGn1dejyXRQUIQ==
X-Received: by 2002:a05:600c:870e:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-44b0c60f240mr12764035e9.17.1747925565562;
        Thu, 22 May 2025 07:52:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:52:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 22 May 2025 15:51:33 +0100
Subject: [PATCH v2 04/14] spi: spi-fsl-dspi: Re-use one volatile regmap for
 both device types
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-james-nxp-spi-v2-4-bea884630cfb@linaro.org>
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
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

max_register overrides anything in the volatile ranges, so we can get
away with sharing the same one for both types. In a later commit we'll
add more devices so this avoids adding even more duplication. Also
replace the max_register magic numbers with their register definitions
so it's clearer what's going on.

No functional changes.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 863781ba6c16..09b2b25ed274 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1209,6 +1209,7 @@ static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
 	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
 };
 
 static const struct regmap_access_table dspi_volatile_table = {
@@ -1220,31 +1221,19 @@ static const struct regmap_config dspi_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= 0x88,
+	.max_register	= SPI_RXFR3,
 	.volatile_table	= &dspi_volatile_table,
 	.rd_table	= &dspi_access_table,
 	.wr_table	= &dspi_access_table,
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
 static const struct regmap_config dspi_xspi_regmap_config[] = {
 	{
 		.reg_bits	= 32,
 		.val_bits	= 32,
 		.reg_stride	= 4,
-		.max_register	= 0x13c,
-		.volatile_table	= &dspi_xspi_volatile_table,
+		.max_register	= SPI_SREX,
+		.volatile_table	= &dspi_volatile_table,
 		.rd_table	= &dspi_access_table,
 		.wr_table	= &dspi_access_table,
 	},

-- 
2.34.1


