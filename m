Return-Path: <linux-spi+bounces-8257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12CAC0EFD
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0399E3613
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221D28D85C;
	Thu, 22 May 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6diGKi8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEA28F504
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925585; cv=none; b=SGMaQSf885DHh7+hgo70l9rhwJT73TvWfPLyKohDFNJwsadWkzQcjl1ddMBkGBmXOM6Q6nIeo8Zs7RFnqROGoKhv+NSe8uivzHRYwld+JxzZqnXGI/8XRViIviZNG76R51adRkCgE2Z9+1PLQCo9EERSEuWM+BnrdfkyLGXCqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925585; c=relaxed/simple;
	bh=92hGTnTOgw+qrBuRhXzTVXcHw+H/usL3iGRcHSlTmfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCkPtdSe45ZaTyJdnkAQvNWY3+MlhV5EzsbY9kouH0mmoppqgMKJXarbbucXDJey4WhO5Lm7fyJo/OA1n2/sOq/pvR/YBkhh49w79On+kh5kASJA4YhlB25MricuokuV64c4vQT4VdNtkKAacS/PTShTPFRzkF1x676xcEwXbnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o6diGKi8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so62420565e9.1
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925580; x=1748530380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJIIfru2scNsoUvLKp5rkkh2CkzNDRkWDJuYnMI9SSw=;
        b=o6diGKi8Ues8vrSxkxvVypH7D4tr/deJt06TtSd2ZHOjkRdYI1BWAKixLvKADAWWr3
         ddELtzXA3XVEknj94GYevKcK7DITSaT9+8Oxdy6WlAUSUp+EcFozYc6ZHUFf2gd5cwus
         0tBZBVyf42NGQbNvQX74IJGb2aSrTU6xl1uT+9KqVO9IqOCTmPReuUdljdUnAomHm3+4
         2OfTp7vB/rQKYSofaGe+XRzPvse3wVwnc79zKCx8ckrpZ2IX+QMs4kkZHQy9EtXM60Wv
         1ZUh/5WmkSMEJt2Wl1r+d5m9DGuioR6Y7AUsxFZTSJhzmTXCKFQliBT0zToO2EYIAH/g
         OkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925580; x=1748530380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJIIfru2scNsoUvLKp5rkkh2CkzNDRkWDJuYnMI9SSw=;
        b=pmGCsVo9UxZBe0Qls6XC0v+/G9XGICS3iVn/iqJav3pN9MU/zL6aX6wNpBrIgIfcov
         A4R9cxZU7Gsopf68qbJTRYH24N0cq+HqZI56CPV45ymTakEidEGEQeWuv820AQux/lGf
         4bomy/YnQxUZekLFx+tRF6PEI5glHs37NJdYvzTmnFKuKEnXQVMKc+Uy69l/5Bmw0peo
         OOQCBA4wYAa5Xih0HIiRNywxLx6KYfTscQnsnEZnNDLMT6Tn09ahrvLtawZnRBqDqz5R
         Aq4AEmBBqKkcLnP+N9zvDnTbpJDPowtru3wJ01uMPvTdOYYGdYbhiA4i3MiVzwXIyTyp
         HcSA==
X-Forwarded-Encrypted: i=1; AJvYcCWj/qoZ+A9IGzLgUiVAbbOjguQm+NRuYsWlt+eH0hqxC46hLll+LqEkgZVSID19dg9sHmj/08CDi5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZDItQwVGGWS1mOO0Zk6M7SeWMvWSsGqwifG+6OwDB0QDVxiR
	DqFbC5163VkJucT+EeMQaLrGCVoQ7lp6Y8na3+WOi3nwxuJ7ivlqXtt1efltUrQPFuM=
X-Gm-Gg: ASbGncv+rrQwZqCF8fl3SXFSvYtkmqoV8Ezj5v/IqoHDz0D6EqhyUlJ3vZZl5plz0SX
	Rrxu2Vr5fZoHoLsMrk5VASitlk+1YYo9hOFzonubrFq+yZLU/vb/xwNmL7/eQ4ApKGQftC9MNDz
	UMc4T/31XHMiS2vLVgZsdlt1owVXLp0qD5JJEYvhI80vjfNOgV90WC5acjiWFblLvI5LyTJKEzX
	+rjfaSRhUGDKvq0QpyfpDjLkJBXbCmlX615nWPPNM1Ig4lvcqbBVuSRWDh4YuDz+TWEVzO/L0Dg
	z5Y05uPhlACAJdzv+EGh5HTFW0rr6vXEDZB2fB3vPm3o+vkAn1ae6GKKESdw
X-Google-Smtp-Source: AGHT+IGKSX/g08qT9uRPihxiVfgN5hqQC7JQm68hkcjFhtYvodzbfGfpy0Z0MOE5bK4aqE+Du9TaVA==
X-Received: by 2002:a05:600c:46c7:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-442fd93d0a1mr262843345e9.3.1747925580466;
        Thu, 22 May 2025 07:53:00 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:53:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 22 May 2025 15:51:42 +0100
Subject: [PATCH v2 13/14] spi: spi-fsl-dspi: Enable support for S32G
 platforms
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-james-nxp-spi-v2-13-bea884630cfb@linaro.org>
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
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, Dan Nica <dan.nica@nxp.com>, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>

Add compatible for S32G platforms, allowing DSPI to be used.

Add a depends for ARCH_NXP which can replace LAYERSCAPE and also
includes the new ARCH_S32 for S32G. Similarly, ARCH_MXC can replace
SOC_VF610 || SOC_LS1021A which should avoid updating this for every new
sub-platform in the future.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Dan Nica <dan.nica@nxp.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/Kconfig        | 4 ++--
 drivers/spi/spi-fsl-dspi.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ed38f6d41f47..ff26be07226b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -647,10 +647,10 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
-	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || M5441x || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_NXP || M54541x || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
-	  mode. VF610, LS1021A and ColdFire platforms uses the controller.
+	  mode. S32, VF610, LS1021A and ColdFire platforms uses the controller.
 
 config SPI_FSL_ESPI
 	tristate "Freescale eSPI controller"
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 01af641fa757..04c88d090c4d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1316,6 +1316,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
 	}, {
 		.compatible = "fsl,lx2160a-dspi",
 		.data = &devtype_data[LX2160A],
+	}, {
+		.compatible = "nxp,s32g2-dspi",
+		.data = &devtype_data[S32G],
 	},
 	{ /* sentinel */ }
 };

-- 
2.34.1


