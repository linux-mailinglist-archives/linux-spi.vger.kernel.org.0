Return-Path: <linux-spi+bounces-1279-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23F851689
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 15:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35046284CB5
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78633D55A;
	Mon, 12 Feb 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWAQxyB8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AD3D55F
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746631; cv=none; b=EUhSASqHvXlWA/G9ZYpzxCBu7G9WoHNk65GQ7GspxPP0xJqvu1eOcjPOhxxgW3Jpt7rvT1GPFs+4h5S7DPJbFG+Vq/lA4WwRDaJm83G954Qo8rjXZp+8aVRBbNkG1eZZZVKYcsWCaHRHVGU2rXfzb/tAudpLLGoYQKvcx12WERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746631; c=relaxed/simple;
	bh=fUPem54IQJpvSE3lBoujmHjP+dsjs6xGb0nQzuWM0nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9w9l48g7QpmbhE9DpDjEJ2PR/vYzJkzI5GZmUjp5P3oK9S+mj6cr1hsuyUSMPowbGdFCpGJbSd2HAAoOD9MHRAOTfKnRipOHl9oDXMGQMwCsk6vDO98IRWLP7Ns9XiqN9z5Z0LacstEy/QbOu6nUBkLVrAoBz38+B7r+mP88UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWAQxyB8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-410ee8ed659so3686375e9.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 06:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746628; x=1708351428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UCCMmhJgpPZWbOVTAspr0xjn11XvYuA37qXyTRrUkA=;
        b=XWAQxyB8YZuUpnlHm5u6rjWB1rnm9C9te+PKVHsIFSNCIf4aUlsE+dYtr/rKuqHK6+
         /Gj97/s2BMAnfhK/1xuQmLbkM6c6cBEn44/2Q8JTBCgBgCd9MM22rQi0faXO39wYcgPr
         /gEJ+zrtnxndyoDHbT0GiwJ3lBYKQaxxMza+q/nppMLFE+NRGmVekei3UMJFtkkCwTUr
         JQ/gvS+bo9LWWB2yqG9X/C79ApyLcA0rkQpJgThIhRXvYaJF6rMVuGhdQhPPzXjESPlJ
         2h0JyBmWKv9Vw1bs4jFpfCZxCXvjVVulSrczetM9O0Yz046EVDDo4ROCRWDc9ed4IVBo
         i58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746628; x=1708351428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UCCMmhJgpPZWbOVTAspr0xjn11XvYuA37qXyTRrUkA=;
        b=j3Q02ZsHLaLghjVFkylnJKwQjxLEA7XAHMDv5hdEJVpAO+CkxY2fbI5MdD8v2NMQOe
         Uh8h4Cr/Uk7Aoc6x+dtiiQbtLerT71KLZF25enWZK7oSETq/Hu1fJ0YTW++jg/iZI3y4
         By8ReYKoOJXyqyFb4YpsS3RK3P9E/vGABsX57yyYjboADOjpbiZ985eReLfogSi1RZAQ
         eRb65O4nOBX12m69a1Rs3tvMNkppK0ppstzccImctvHAyVHa7UHw/49oTCd5lCWot1gb
         hwrZ+skI6ZSmFaiegWLxJUUaTcicOxnZ9gd1WobuPKkM5UfMSwetJ7tDHPDRKPati0Oo
         aiUw==
X-Gm-Message-State: AOJu0YxdVbH+EG7YxoqZmKX8TQ2l61U3hN6MYF56s9udXzxb6JvPp8Ae
	eCFiAjRVJAQ8/BRjVOtvRLeznVSt9ezl1zFUo/6U+29+Ww9wU/iuIqdmwrsghW4=
X-Google-Smtp-Source: AGHT+IEbgvEBoNsAAurtTPnlKh4JR2ymVdbJyrcqUbYPKpD5rJLJU2A7G18SpNCuqft7xJ2hDbxuJA==
X-Received: by 2002:adf:f310:0:b0:33b:61fe:a82c with SMTP id i16-20020adff310000000b0033b61fea82cmr4826795wro.22.1707746628063;
        Mon, 12 Feb 2024 06:03:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuLucAHTrEw+q2t/r1JV8J5Ne2rVDTnTBWpBXSM//xeorclRlGyHik+CjdLQ+lA/2E90iDoAoJtwXTNht5wZa91kkgVUs5LNT747vZh5T8qUfBN3OUekLf2XaKSBHI9hXl1P/gLPf5rSIuKHE/fR1lJW+mKdVzo5nYN829ZClryn2TdsgC41oZzGqk7lH8+Qgu4z2FlMt5nK1AfEjLSyTg/DGlahPpE0EJAv3p2WaP8yrfHRzQ77PuloAZlz8ezS+PK5qiLWQm9PMz0pp2ju9Om0uE1HoHhvze2DpJPUFpeokYF88baooKjlYYHJkvIEpF66Pcejr8jx87p/gn0ch52PgF4w1TW8o8iN6XCnhScyPuIePsT/bUyh6hIqa+1UrUzlDB2okQlmi46s8H680dio62m8zm/QAUuj5ykx28LYrNm0jfrVUQFjS3isaCBqzybb+z+W159gszHEUoKTBQeNG0WUgAYaUXnOkZkAULTvUeD9mta29b3jKus30pw+QqkKGq4cI83YIwkr5i5/mSkE5DdZ+KF/dJLt/3CjXX1dWZKQTtkrbAfl22/tmgUNrlcjv2u43PGCEoqa50HM4L8DlSROR06m5Vr56xNmez+puEJqA=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:03:47 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 03/12] spi: s3c64xx: allow full FIFO masks
Date: Mon, 12 Feb 2024 14:03:22 +0000
Message-ID: <20240212140331.915498-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240212140331.915498-1-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is wrong because is using partial register field masks for the
SPI_STATUS.{RX, TX}_FIFO_LVL register fields.

We see s3c64xx_spi_port_config.fifo_lvl_mask with different values for
different instances of the same IP. Take s5pv210_spi_port_config for
example, it defines:
	.fifo_lvl_mask  = { 0x1ff, 0x7F },

fifo_lvl_mask is used to determine the FIFO depth of the instance of the
IP. In this case, the integrator uses a 256 bytes FIFO for the first SPI
instance of the IP, and a 64 bytes FIFO for the second instance. While
the first mask reflects the SPI_STATUS.{RX, TX}_FIFO_LVL register
fields, the second one is two bits short. Using partial field masks is
misleading and can hide problems of the driver's logic.

Allow platforms to specify the full FIFO mask, regardless of the FIFO
depth.

Introduce {rx, tx}_fifomask to represent the SPI_STATUS.{RX, TX}_FIFO_LVL
register fields. It's a shifted mask defining the field's length and
position. We'll be able to deprecate the use of @rx_lvl_offset, as the
shift value can be determined from the mask. The existing compatibles
shall start using {rx, tx}_fifomask so that they use the full field mask
and to avoid shifting the mask to position, and then shifting it back to
zero in the {TX, RX}_FIFO_LVL macros.

@rx_lvl_offset will be deprecated in a further patch, after we have the
infrastructure to deprecate @fifo_lvl_mask as well.

No functional change intended.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 40 +++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6ff3b25b6feb..338ca3f03ea5 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
+#include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -109,10 +110,10 @@
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT) &	\
-			   FIFO_LVL_MASK(i))
-#define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
-					FIFO_LVL_MASK(i))
+#define TX_FIFO_LVL(v, sdd)	(((v) & (sdd)->tx_fifomask) >>		\
+				 __ffs((sdd)->tx_fifomask))
+#define RX_FIFO_LVL(v, sdd)	(((v) & (sdd)->rx_fifomask) >>		\
+				 __ffs((sdd)->rx_fifomask))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
 
 #define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
@@ -136,6 +137,10 @@ struct s3c64xx_spi_dma_data {
  * struct s3c64xx_spi_port_config - SPI Controller hardware info
  * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
+ * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
+ * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
  * @clk_div: Internal clock divider
  * @quirks: Bitmask of known quirks
@@ -154,6 +159,8 @@ struct s3c64xx_spi_dma_data {
 struct s3c64xx_spi_port_config {
 	int	fifo_lvl_mask[MAX_SPI_PORTS];
 	int	rx_lvl_offset;
+	u32	rx_fifomask;
+	u32	tx_fifomask;
 	int	tx_st_done;
 	int	quirks;
 	int	clk_div;
@@ -184,6 +191,10 @@ struct s3c64xx_spi_port_config {
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
+ * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
+ * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
  */
 struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
@@ -203,6 +214,8 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	tx_dma;
 	const struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
+	u32				rx_fifomask;
+	u32				tx_fifomask;
 };
 
 static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
@@ -1183,6 +1196,23 @@ static inline const struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 	return (const struct s3c64xx_spi_port_config *)platform_get_device_id(pdev)->driver_data;
 }
 
+static void s3c64xx_spi_set_fifomask(struct s3c64xx_spi_driver_data *sdd)
+{
+	const struct s3c64xx_spi_port_config *port_conf = sdd->port_conf;
+
+	if (port_conf->rx_fifomask)
+		sdd->rx_fifomask = port_conf->rx_fifomask;
+	else
+		sdd->rx_fifomask = FIFO_LVL_MASK(sdd) <<
+			port_conf->rx_lvl_offset;
+
+	if (port_conf->tx_fifomask)
+		sdd->tx_fifomask = port_conf->tx_fifomask;
+	else
+		sdd->tx_fifomask = FIFO_LVL_MASK(sdd) <<
+			S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT;
+}
+
 static int s3c64xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*mem_res;
@@ -1231,6 +1261,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		sdd->port_id = pdev->id;
 	}
 
+	s3c64xx_spi_set_fifomask(sdd);
+
 	sdd->cur_bpw = 8;
 
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
-- 
2.43.0.687.g38aa6559b0-goog


