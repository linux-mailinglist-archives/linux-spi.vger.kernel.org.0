Return-Path: <linux-spi+bounces-9570-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE32B2EC03
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 05:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE68A20806
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7461217F35;
	Thu, 21 Aug 2025 03:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLcGmS7H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C293214204;
	Thu, 21 Aug 2025 03:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747338; cv=none; b=P78MBd1/S1WFAFiKpNIcLiubnEQk0qM6zzdm1O5pojqMwmF/DkCVdVxYvOgLfFSTLgdmbvuZtvLnodZYEg9ahkWb8xdr6qDqVbE3iprelG1mfMYV9tIooqM2dRW+K4T+J4OfkImxv/VMp65/22dvycoL+GBOugsKTe1ZFDkw06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747338; c=relaxed/simple;
	bh=oljhjadL/Buna9k+WRKs4g8qPWTUw7dpVhvCw03v08g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdxCdMGgRKUw9ydN34/wML1o9azokV7Q5c2dxgS8WfIinPfbqk1SP9WrDigk0p2R5FkKc6eOnbJECocf1Fk7Ahd2ynbT16MN04ZOBd4xSxBJzFJfjrpnQue6pzvM9BMCnyMlhw/iKAiKN82RSYHJqbO/gKiQcdpUv6S0gLlFP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLcGmS7H; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so426304b3a.3;
        Wed, 20 Aug 2025 20:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747336; x=1756352136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymfisBflbqft/TxLVjjjf4WbXXR7TyRwORuuchlD424=;
        b=OLcGmS7Hw1CzbPRqWboqqjjdbVFGAxi3b44GjHNglP+qe/GcCoLV/GniTKNALmY8Af
         WV6i4s5QtQ1/lghmPLfbnZh3gclZ9r4A+qFa7PxtYOBw0TO7ZdNj0Pyf8K4NeDHagzAj
         RoHVB7OHsqcqmwu7LWKHk9N0xzGQwvbNU8M9v72z3ol9FGISKalBaCOB4nIAefMmKGtq
         sccY5uiMc79wgMF5/9EdUrotKLcfkcNB/79gpv/hQvJ057om/9FDrcbC1IBcv+L8hjJL
         AX21ulwUOHcjQ1c9vADwRRkNjwlJ0tPjidt/hPmTQAHyObFsKGcPhXpZw7e3fIaT1daM
         jewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747336; x=1756352136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymfisBflbqft/TxLVjjjf4WbXXR7TyRwORuuchlD424=;
        b=oks4ONfDcj4ACQi+7pEBEIBSP64YMiDphVv5KLmZ7bkSfOfR2p4tH7nmtmYkzt2nMX
         cMAGg+twfebgW4LyxBjQev+2AoDphrFtH6eVFk+IJWNYkHrMH9fy+1mg7qr9Av9U8kU/
         iT4v4/J7OyoTSWo81rh3nvNdSEcUI5HBAKNd21yIvAeDXPYbRE3OwTE1yMDtvMnSBzkH
         OQjnJZowLQq8+D51PwiJbx0Mmxup5Y53UhNrNegwED3koEGwrOuYqGKsZkv0++Q2MmdO
         fg/5rzFDkwtPvcZLMhLEhbXZ0Q4PPJXQSrdG6I15OYrQTitRMulpbz6V4TeQdhbsnVQA
         L4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXKj3AhpZaKW13tM/CRA3MOkzjQ80JqvNMs2bF2BbvXYHFGev4pGpqDf7eZmkPLw0vdKxw6mRlChfEruZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdr60sP9S0Y7OBg8vvw+kzhuZPyXj5r3Y4qiALN5TJp9IAS5gH
	EXbb/hwICgB6nuZsgk0pmnU5p87UsMsm3FrrpokjSUk2oH+HXjixHj8zo4LIIg==
X-Gm-Gg: ASbGncu+2jT2hO/nSWUa18YAWX+O2UjwmgH5DPRi5N8/ygrJL3J53kpKwKKypC+0VS0
	ssfn/tP5irOQ78uC4tLnR3SZF7YkdVJLSdbkEXlSBQz+zLdjEPneFG4j/LHrLAgO+a4of8uSLfI
	vI37zYzgbgpyybzFqL/LuvCnADAgJd1oKwAmvJCnumaGP9olvKIdIjLg/OaRQc09s9bCsGTmvcD
	Qj5iIo2SC3d0GjtevMhWjAfV0Ez4+Ceg8tjiUyP1tXDL1JEEQMuOJFldAhEKe8t15b3HOb7qAp+
	FnZzAwlwG+vwsVxdDmIcF9qzm9p6PnFwsv3yOPHgbGuSiE1qLqB0ejpQahzns2DycdOrFB8tB3B
	8nCte
X-Google-Smtp-Source: AGHT+IFD9R7PCO+Oz0qUeBhyM0TKCnroRDC8Ee3gpNqV+UVwBwq14pP2Palir5VUy+LHWrBvYulOHQ==
X-Received: by 2002:a05:6a00:ccc:b0:76b:dcc6:8138 with SMTP id d2e1a72fcca58-76ea3267e92mr946036b3a.22.1755747336190;
        Wed, 20 Aug 2025 20:35:36 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8ab7b100sm4449019b3a.40.2025.08.20.20.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:35:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: rb4xx: add COMPILE_TEST support
Date: Wed, 20 Aug 2025 20:35:34 -0700
Message-ID: <20250821033534.638157-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy macros from ath79 SPI driver to allow compilation on all platforms
and remove ath79 specific header.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/Kconfig     |  2 +-
 drivers/spi/spi-rb4xx.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c564..2c1e60ae1680 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -916,7 +916,7 @@ config SPI_ROCKCHIP_SFC
 
 config SPI_RB4XX
 	tristate "Mikrotik RB4XX SPI master"
-	depends on SPI_MASTER && ATH79
+	depends on SPI_MASTER && ATH79 || COMPILE_TEST
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index e71d3805b150..417823e907f8 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -16,7 +16,16 @@
 #include <linux/spi/spi.h>
 #include <linux/of.h>
 
-#include <asm/mach-ath79/ar71xx_regs.h>
+#define AR71XX_SPI_REG_FS		0x00	/* Function Select */
+#define AR71XX_SPI_REG_CTRL		0x04	/* SPI Control */
+#define AR71XX_SPI_REG_IOC		0x08	/* SPI I/O Control */
+#define AR71XX_SPI_REG_RDS		0x0c	/* Read Data Shift */
+
+#define AR71XX_SPI_FS_GPIO		BIT(0)	/* Enable GPIO mode */
+
+#define AR71XX_SPI_IOC_DO		BIT(0)	/* Data Out pin */
+#define AR71XX_SPI_IOC_CLK		BIT(8)	/* CLK pin */
+#define AR71XX_SPI_IOC_CS(n)		BIT(16 + (n))
 
 struct rb4xx_spi {
 	void __iomem *base;
@@ -63,7 +72,7 @@ static inline void do_spi_clk_two(struct rb4xx_spi *rbspi, u32 spi_ioc,
 	if (value & BIT(1))
 		regval |= AR71XX_SPI_IOC_DO;
 	if (value & BIT(0))
-		regval |= AR71XX_SPI_IOC_CS2;
+		regval |= AR71XX_SPI_IOC_CS(2);
 
 	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval);
 	rb4xx_write(rbspi, AR71XX_SPI_REG_IOC, regval | AR71XX_SPI_IOC_CLK);
@@ -89,7 +98,7 @@ static void rb4xx_set_cs(struct spi_device *spi, bool enable)
 	 */
 	if (enable)
 		rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
-			    AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
+			    AR71XX_SPI_IOC_CS(0) | AR71XX_SPI_IOC_CS(1));
 }
 
 static int rb4xx_transfer_one(struct spi_controller *host,
@@ -109,10 +118,10 @@ static int rb4xx_transfer_one(struct spi_controller *host,
 	 */
 	if (spi_get_chipselect(spi, 0) == 2)
 		/* MMC */
-		spi_ioc = AR71XX_SPI_IOC_CS0;
+		spi_ioc = AR71XX_SPI_IOC_CS(0);
 	else
 		/* Boot flash and CPLD */
-		spi_ioc = AR71XX_SPI_IOC_CS1;
+		spi_ioc = AR71XX_SPI_IOC_CS(1);
 
 	tx_buf = t->tx_buf;
 	rx_buf = t->rx_buf;
-- 
2.50.1


