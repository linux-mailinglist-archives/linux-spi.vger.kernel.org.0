Return-Path: <linux-spi+bounces-1208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721184E278
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 14:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7851BB259A4
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD2B7FBA6;
	Thu,  8 Feb 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMYBUom7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CB7EEE9
	for <linux-spi@vger.kernel.org>; Thu,  8 Feb 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400267; cv=none; b=re0FWZGhoq0W9QRiEZLkJu0kHH5llREDi7h1APt5uFf1eK0H+ArQYZCIjJXHurkmC0WgerSBnwi+34LWb4krIp0C66fGNVG0gXB9XbhEvbEl2xdOB+PIJcBXzOQzwWKOLTP0H+l/c1LXsUAw63j09SGcTt0MzUteqrxpPmJZEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400267; c=relaxed/simple;
	bh=UVGOYDiT6aMSoOrpWNK8lEomU8ZSAo6fBEOYuQCfL5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7VtcW0g5O88u32RQo6Ki1lEK2MemgABWTh/T1XcLlFljJuD89UVqDpIx8cwc6SWPSEOfXivrORFCutk4AIiW2+MYEx9/HcM3i2Aqgc0GulV0keleLvTEVK5ST6aELyQuji45wXJ6jV4jTLCy4gQVKX1xeHp+bYQRQaGR+KATM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TMYBUom7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fe3141e1cso17394415e9.0
        for <linux-spi@vger.kernel.org>; Thu, 08 Feb 2024 05:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400264; x=1708005064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br70UdzJ66zrd4gMWvBDaI29gJMy6u4vau427MAZ/bI=;
        b=TMYBUom7fVa4uz1y67EnszomiX8+rnF5piftL5ZqGtK6xW+lS4HVongICjRHU6ddu7
         ONNVMO3R7ZD1B+IykK+4tFdpNtzzo2gfPn/PSI70ulQ+yNoGn1Bl9sbf9LuUJ/nsqCkJ
         GI6Px/4+JcottZb47VtYVP4aXtSbaIjKxOXWT+bxflaOuUIxikJ7T4pjxWP7vLBYjBHx
         OPZJcaTqxw5mQbB2y257zGBkcU7JwQApx1y7hHFZ9sq7oXnca+AWbivsiDtFrXnH36IU
         UpwvU7W+1ukqXbfSupSPbLnbnhF16uEBqOVj0krsM9RDgDQKUGPInWtAIvBLr79oFaLg
         FVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400264; x=1708005064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Br70UdzJ66zrd4gMWvBDaI29gJMy6u4vau427MAZ/bI=;
        b=rMLV8fCjRXAJPv95pg0uBABLEAXBp0Ld+lcQo1kADwBAoWpK1Vwl4u+52TLiNp7PwJ
         Ooqd7/ITPXHnpgWpqwn2qKfC/wR0eoTXhp1z682jEuJyFMAx4MR8JngsfQ+y2xks+ooq
         U8yvDgwRVY7oec1/s1A2S/y2FJYwktbEJaVa7163TkmcfdTEkTJ527CYac0AoGSW6tLI
         6g9C9uJGIQEvpP8MaI48l4UryNQ+o489faQYkXRaBrJepJUEXSnMMOnL00VpHdw6zLfv
         5W7s5G+sJIG1UxC44iFPX0b8R28hkc4xoVEtvfhfkO0k0phv6qk93iiETWijcx3NtC4b
         W+8w==
X-Forwarded-Encrypted: i=1; AJvYcCWcKWfiYkI/h8BshW7UM9v/h0jVn8YoFAn7CQ3RKkYZQUYNdLvNhq9ApOehIFlas7tvW21WKoo/WQAlxMn0CSKWzH+g8sKR9Wz8
X-Gm-Message-State: AOJu0Yy9Xc8Ubn5dDijiKW+KK03T58WE1lxI7V/cueNCXwe8D7aRA7XM
	XcwPBlRFjj3lUGSS4vXrK0CSm8q03DAF+UfOmdFi5IUcOddq6ptimuLEydNllLE=
X-Google-Smtp-Source: AGHT+IHoiwZ75rbSUYPkSVVnWg3bVehsTfNSdcru75lmli0z44n0i+zEWSdfSEtZnU1oq4XLSpha/A==
X-Received: by 2002:a05:6000:1803:b0:33b:14b9:8203 with SMTP id m3-20020a056000180300b0033b14b98203mr5525367wrh.7.1707400264074;
        Thu, 08 Feb 2024 05:51:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhlfoQeoy06xi/jXJ8x87lBasC1aZvmzmQpMyNU5Vni9dFCgHs0R4bksr8I4BSIx91Cb5UQOnXS04JlFkwNagPYkNxC/8Kc8J/oHfR3AnFGx5dxqxsikpaas5icnKOdA75TNjBVXO3aEvi08N33/nhtpC9yyq6V15Z01ZXAGkdxMJWvpF1vKO4kX5ZVj8g3dY59ZvGZy0Ovhj28h5knNKvtZaK+5+cgLiUIPlAK65oBMIU1/17uFd7hiXgiDWVxT2Phky5q3eqt6YKz0JH+NFDcSbT00UF7rRPQ+p5UfKSSFR4LPI3bKdH3uUoqHMe4XqJGXPIDZ7VsXdCpXlsAvOR/sbYfx8LXAgDBFj0Rs5CD/leWJpMWhqGir0n2ZLTHWdtDg+oCg9++fV9sa91DvHuI4Y87cNW8lQ4maPQsF4KMpuID05lkfsP+FD5K560reAXGVvYG8chHQ+CkIIAF/nXuyTcDdd14z4vSypsnNxe2XYbGfKqq+Fq5wDjjo3NqMaLwAMbtWV493ZLcsBahjcI9He36ORmehPEAg4NW9UCIx2WQpUNKZjCirJvytCUxZ4MeJJ4sR1f7wzqabTPIH4hVM76V7EMrJXoQJgjSg==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0033b43a5f53csm3618820wrh.103.2024.02.08.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:03 -0800 (PST)
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
Subject: [PATCH 11/12] spi: s3c64xx: switch gs101 to new port config data
Date: Thu,  8 Feb 2024 13:50:44 +0000
Message-ID: <20240208135045.3728927-12-tudor.ambarus@linaro.org>
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

Drop the fifo_lvl_mask and rx_lvl_offset and switch to the new port
config data.

Advantages of the change:
- drop dependency on the OF alias ID.
- FIFO depth is inferred from the compatible. Exynos850 integrates 3 SPI
  IPs, all with 64 bytes FIFO depths.
- use full mask for SPI_STATUS.{RX, TX}_FIFO_LVL fields. Using partial
  masks is misleading and can hide problems of the driver logic.

S3C64XX_SPI_ST_TX_FIFO_RDY_V2 was defined based on the USI's
SPI_VERSION.USI_IP_VERSION register field, which has value 2 at reset.

MAX_SPI_PORTS is updated to reflect the maximum number of ports for the
rest of the compatibles.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 128f4a7c4bd9..784786407d2e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -20,7 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
-#define MAX_SPI_PORTS		16
+#define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -79,6 +79,8 @@
 #define S3C64XX_SPI_INT_RX_FIFORDY_EN		(1<<1)
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)
 
+#define S3C64XX_SPI_ST_RX_FIFO_RDY_V2		GENMASK(23, 15)
+#define S3C64XX_SPI_ST_TX_FIFO_RDY_V2		GENMASK(14, 6)
 #define S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT	6
 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
 #define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
@@ -1615,11 +1617,9 @@ static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
-	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
-	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
-			    0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
-	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
-	.rx_lvl_offset	= 15,
+	.fifo_depth	= 64,
+	.rx_fifomask	= S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
+	.tx_fifomask	= S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
 	.high_speed	= true,
-- 
2.43.0.687.g38aa6559b0-goog


