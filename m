Return-Path: <linux-spi+bounces-1388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E73857668
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EF71F25AF2
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C565179B1;
	Fri, 16 Feb 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyheOQWB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408114F90
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067166; cv=none; b=tGPq2Z7V6Eyrgm0RV7ZCpvpUUzhiCPzYpVhGOym6HwPACaOHZ+6llYSF9pO/r9O2g4Ste0VHRFpFNmJOClK2q25+Dp4/16OiK58CrKf3TV9p64PrWeCDxCYTDDCCfxXrrOAqsz1IL/+ir/+QJJJqvpTjLumrln+2ZT3PIBHy3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067166; c=relaxed/simple;
	bh=j0nPcAKBIfiAaqRrXOTee0upW9M87c2NHV1FB9E0X78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHOXKN/uTbuQDy6VqdicbbwxU3sz8esnFtZ/EYanE4bkM/2iXtlnOGCm7xE0JZFypoFo4GKfi5Myqi4DE1W96KK93RJBOdDuqpB4b1oFTqnH/1l1l0yUx2R0I+5apS9f/wA/xMkBkrGbhasvRNukVWFftUHaEN3mNkivPMXGWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyheOQWB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394ca0c874so289643f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 23:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067162; x=1708671962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p90PTqn06M2OMVgm04TULcXmimQydfdnY35+RdZcOWs=;
        b=jyheOQWBhYBltRpfJAltKTyD+75SlqAnZdWcGqnEWZnI4pgemEFsv2ZuqHhHtSsxR6
         hOKfuI7xtiZIcHkbxw6T93wyEzpqtGhHGnEYAIkAD29yJ16Bi9+iCJgoP/QLdPzPXRai
         IsUGP+wB4sj8MxsLRhlF5orXA7zDAkMf4lhRNZYypSPFzC1l18ojgTjE8fuake/Xrp+G
         5non7D5nZeoy4TBrDA0uVliMVuDU0VPoTfhA9JGEWLaNgMNmcW7ej3YrskXK767jJh23
         EwXQyC4iwTWSsC6phwZXzRkNsNYrIh3qte9fpunRqxCbdNUOJubwCaO13zkca/yrgTr0
         EOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067162; x=1708671962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p90PTqn06M2OMVgm04TULcXmimQydfdnY35+RdZcOWs=;
        b=AYFo0HXwSi3E3lKMsXsjmqi16vBKLSfANk5abNfiheyeqpJxCXJxIc5y+C1C+Pm2E2
         9DoWg2gvm4YKwjdnC7FTfNq3HZf8qV8TVmrHJZQnNAWlsbNajNsE3XovBkcMV+Hi6LKK
         PnHtDu4WjCxUhm5TX2gJwPOZha/zVSg3yEXvshg2vXe7YJ6Q0ItKS9mEZ0ng2UL0qAtq
         v+Sfc0qfiwNGAJ7+rhc3bosaHPEAy68Cf0uJnAMAKPGZ1angq464skv1eXQaMTBykOHw
         Y9ula4EuLXvA01iRfQZ2yDmM++yLJUPA4Td5mwuMRJPMkIOw6hU2W348O2qPvcph74FR
         6nqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3qsoQ4GiUpS4NJ6PfoeyGYaPitJY8hAaRWDQYXqp4Wi8Xw3V2Zoh+VaBwcoWD5q1GQJZa/PitwSF7U34+GYAkwH0kVSA2r74r
X-Gm-Message-State: AOJu0YwA37yyfAO1a3hNhp07Jz3pnC3SAO+UErVGGDPa4FiVgbZnHqnZ
	b/OBMivDagcOXxtqJRWeQ9UfbTmRCzAkloJGzX6V8VbfHFeopo9alxRa77vgn70=
X-Google-Smtp-Source: AGHT+IG4+uGvpIqZ1aoI4VNdHnbSSWd0SkN4/PXR8IOyj/QC3/8qFgf74/atQruM1VkXcpFlMB56hg==
X-Received: by 2002:adf:e450:0:b0:33b:5725:e516 with SMTP id t16-20020adfe450000000b0033b5725e516mr2789183wrm.51.1708067162492;
        Thu, 15 Feb 2024 23:06:02 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:01 -0800 (PST)
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 03/12] spi: s3c64xx: allow full FIFO masks
Date: Fri, 16 Feb 2024 07:05:46 +0000
Message-ID: <20240216070555.2483977-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
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
2.44.0.rc0.258.g7320e95886-goog


