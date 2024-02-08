Return-Path: <linux-spi+bounces-1209-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72B84E27C
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 14:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EEC1C23A70
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F68005A;
	Thu,  8 Feb 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUHc5/oq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F57D41A
	for <linux-spi@vger.kernel.org>; Thu,  8 Feb 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400268; cv=none; b=d7IqkyK7SHrabz6W+blVKw7bvBLVJmKjcZcUuz1+6x5aQKGIHEmdbR3/ynKN84tFfAjs3jL9L9fFptordTToDcMbW54pLCG3nAtC/hbof6SN7nTZpHyxsDL33EtRksoBxbfEMkQSIrNdOCAB5BKKJVPHdG+KMcE25YeKj03qpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400268; c=relaxed/simple;
	bh=2cLaT7PEBsclspzR4xlswlgWO289KYuc6LcLsObPHq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/X4Xs+bpGRe/PqpwWFciotW8qQnBXQurKI+Jy2MGnPJst/fBgSdsJzioeldST/mKBorkfYR5Y6i1bE8i8K7AMFjm/BaG+1Ly+5nxo51P4AJTbe198Cb9iqpAnwV4rrQ6OEbXngpjug1NytEiO7Hf2fgK7HM0/i1bx3WVKyrDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUHc5/oq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b58ca0b95so368771f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 08 Feb 2024 05:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400263; x=1708005063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm5OjWDCnevgUex+kbg78oFWzlDeXhj9v/6Ap/z4iAc=;
        b=WUHc5/oqJOlHox1OCKCNj+Dc+AkV2FfXt2dRfBnMzh0N+erlwppKgGjsXh3qSUOpq3
         mKJ4q8jCXpuiWw2DndysR4srnbHowsrby4cn0VomAHn8eBRl9AzvraNYljErZmiTU0GY
         6ucH76JDPm5XqnjYr72Fqbbg/JV7JcMzVNhybymuvYoal+wokKKT+7Ndcn6Ao2ucJREn
         9LXMaT6oyUT5uy2mQNJfoDG/Ca9E1rxRTFRodpaeCWnbKcqyntC0QOJHfJSYe3cauozk
         U/AuVfdaJdfUGJfJ4gG7s5sKIAkdGuCmMMFCD8E9c8LqmwDOKddx+T1wH/XMYyNalawK
         v7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400263; x=1708005063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm5OjWDCnevgUex+kbg78oFWzlDeXhj9v/6Ap/z4iAc=;
        b=Do3fY4wI0F6cb41s0tZsgUTr7kQ4DxexHnsPJeVqd9NmopH9rUqcYJJsWVJg8ynEX8
         PVpzQgexmlHYZvQqvn8gtN1peZ6C6q6esPuH5lIotWie50kQxRsabzVENsGmmUZjo2PF
         Dk97i3YqVM0oWm/QnVyNcrhgnxCsNDypWifbyyJf+K1yURbwB8Q93wwVWyVLNqZ4mnjn
         XrnLo6ZAhAw4+OHM3l24DQbz2ReEp6j8JOTykNAwqKDrgVHraqwXB06qV9DRJgJd8VdU
         LIkuvEGceMoOrLT3jnDvxV3jKQig8M82pHbZMdHDV5TeBolvIc2EWZAayLqVwuhAQ/P4
         8m+w==
X-Gm-Message-State: AOJu0YzeKAoSmO4W2jJ9pYn2AYSVRIgUGGMrmV4q83ZyJExoUH4KbePZ
	nIpnpw7oc93RTgUB6TNE6SrZ9xBM0cDBTfm7FjZxNtEfF9PeiWzBL9qdaFVXnxs=
X-Google-Smtp-Source: AGHT+IHkT2KabKwJqHn5D6S9UamMC+qKbPV38ucdmsL7XdSG4X7zy/LYHiL4yWGLYGV6qAaBZUH14g==
X-Received: by 2002:adf:f9cb:0:b0:33b:2477:b78f with SMTP id w11-20020adff9cb000000b0033b2477b78fmr6250799wrr.27.1707400262992;
        Thu, 08 Feb 2024 05:51:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0Hw2JdvA4cj5CQxt06n/bgZBtdy5/fKrK5V7+dfpbuRTlYAQ/SeFLCK5Z7S1F8BV57T3AzUSMnLiN5Qnj/elw/hENEJzlwiyDlgFhnF6/9GJvtqnZXD2MwqKppnnuNHYm5OJpxGNaqt4DknERSJ6Liguor6WeFi4bbBvuDkG5eanrwlARVmWtlM+l9tp+9SnaUGFLzFCaR47zyOVJuLS1rtZF0mZaIGtzoKjU/BxTsrsGAVpDXiGu0ZWnvm1mddSP1aU7+Pm6/eZ9v7fN/QoNbGKty7TxjAVQrahscohNko4mKnONh77y8GPIMO+WKiqn8naUJS2N0HHYEuoYGvxjMByLkz3TRyhI8kCybSuNcV1kHyU1yPFAsnFpyxDcadTJ89GkbLOdIkzaLOoXvSCL3tVsSk2no2RGe9CU/8LSiBr/02JdkQ8+CxekxVeffhu+vO2ydEota6tfZSW6U18TmdolOV8LAY4kZdF9PyztxU+VbRFSELt28k6SqVJ54IX3K36AE0R3vIFMsLZupS5OVc/KJlh9SMPLpevJEzOaZZLLXaXklEj9KkgN2kRTBQ4b5Zu8vxz3Vfh1Fzumu4gDUO+Ukx82QQnXJENhew==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0033b43a5f53csm3618820wrh.103.2024.02.08.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:02 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 10/12] spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
Date: Thu,  8 Feb 2024 13:50:43 +0000
Message-ID: <20240208135045.3728927-11-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deprecate fifo_lvl_mask, rx_lvl_offset and port_id. One shall use
{rx, tx}_fifomask instead. Add messages to each port configuration.

Suggested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d2d1c9767145..128f4a7c4bd9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -135,8 +135,8 @@ struct s3c64xx_spi_dma_data {
 
 /**
  * struct s3c64xx_spi_port_config - SPI Controller hardware info
- * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
- * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
+ * @fifo_lvl_mask: [DEPRECATED] use @{rx, tx}_fifomask instead.
+ * @rx_lvl_offset: [DEPRECATED] use @{rx,tx}_fifomask instead.
  * @fifo_depth: depth of the FIFO.
  * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
  *               length and position.
@@ -192,7 +192,7 @@ struct s3c64xx_spi_port_config {
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuration data
- * @port_id: Port identification number
+ * @port_id: [DEPRECATED] use @{rx,tx}_fifomask instead.
  * @fifo_depth: depth of the FIFO.
  * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
  *               length and position.
@@ -1508,7 +1508,9 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
 };
 
 static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.clk_div	= 2,
@@ -1516,14 +1518,18 @@ static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.clk_div	= 2,
 };
 
 static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1531,7 +1537,9 @@ static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1541,7 +1549,9 @@ static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1551,7 +1561,9 @@ static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1562,7 +1574,9 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
@@ -1573,8 +1587,10 @@ static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
 			    0x7f, 0x7f, 0x7f, 0x7f},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
@@ -1586,7 +1602,9 @@ static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1597,8 +1615,10 @@ static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
 			    0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
-- 
2.43.0.687.g38aa6559b0-goog


