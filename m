Return-Path: <linux-spi+bounces-1287-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D988516AA
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 15:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4721C21B71
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4664CE1C;
	Mon, 12 Feb 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuY2YUav"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F747A55
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746647; cv=none; b=DrxyjVrKQwWi/z8CMvHwkby9nvWjRmzwotKjq/upDVqfz4zn9Wd16rjFYPwcRyIQOBFtsTkgbD6yHtimO5yrgXTV4dCXxsoKzah2smaC7GFrndBm3ujfv4IyJUZ1BYKd1pnVS5u/L1axXZS9G0rLtm6YEhuJf1oSvjzYDWUNOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746647; c=relaxed/simple;
	bh=pegTZjNjfe1Wbb5e6OU29cRVZe82uU+/2BAqjXckSEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEBcpA0kIXL2gQRn5pBYfxLqJ4Mb/8r/hpGfaXKKXen4WJAE0cWl3ixwuH4mc6Lzgqs+I0VE77Zt6kIfUnt1daY1I+JLAa1tT9AnK6RcQe84KFcUa6ct1hjOh/KAXVGMPven2E6xCKyV922ma1qJDqqpvWGip3FVsFDi7np50zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BuY2YUav; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41102f140b4so3627135e9.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 06:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746643; x=1708351443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udqvUgYDVsS9rVyQP0088IyPNE/Fw+GtB3VqDzBbwLA=;
        b=BuY2YUavn0QdFUlyv/NC03J0dWJ8zDYWckkFVYCCBdrpSyaZk9j2JLM91pEYhw4QKq
         K9q7pCmVFDtl4RDEJKVX+kNrH4nafxNa+ymD0Qc0WWTQpZGEl/p9VXbBjA5dy5kUMHc9
         Pd+NvDImOf+FNyIceU+/9ksljDfhMspcxYfdbJdVdxmsKOgQkMIK4/QJTT9yv5P8nAh3
         2Tz6OB9PunktWvgx3ylMyxA09T+UAh2FcN8CTswxT94EV/d+6dTtM3uaZbGAZjGLb4wn
         nk69R/mp1LoosQeZ99jIR20V2Xt94sw6FSOCR+L1yVbbG9RhvSGK87qOBxFK1sJu+f6F
         firg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746643; x=1708351443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udqvUgYDVsS9rVyQP0088IyPNE/Fw+GtB3VqDzBbwLA=;
        b=tTJVC4ehesopZnmee7QBxbXAIBm/kkG0gsFCMnEbAnGDx5EbQJguJYUAxrBa9PISSr
         5iG07ODzrUXpbQaiKouXu26jl9TKCkedPj79G1nCrMvsN4zThcOcN0kPmW/5zlJOJt9r
         MxFay4t/DXl0cSMQVfe8w08sdOrU496gYIkD+0EeM+AWDseuklz6f66qkuxddQTNGiKN
         SxpN74DORVAGQ931ssZ5MJPl/AbMhP96/XyjZzzu9pZhlvP3ZthN394A+kdjtAm5KSdE
         FS+PEy2YNDy38lKOAGIbYGfwqndtIVTyEsqUPzWomnYxuGK1FU5SFURFo/RAiDnmzkWk
         BnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiIbo5tjQEtKwvbuyChsJ48O8yn9CSTJUZLkIsDmfLlwMxwEiJ/9OjLj1sWTSDLPI5uBJAdUVHAglkpHDOyw80lu634DFDvt1r
X-Gm-Message-State: AOJu0Yw8YMbOoiAgcsWkYyOvuVdINyGdfqBnGWnhYt9CEzHYZzQxUQiG
	xFR3B5LaJKtwA0fQz5WSUSCE/+sNu6fIBklm7SJCOPcV/6vw/p7YrFgBN6W4gmI=
X-Google-Smtp-Source: AGHT+IEMMXdQKxatWK2R327HKNfL/Cp2DJjyblrjh7fUvinXXRtyMqvzQzj5/zw2ViY7B2zXs0pB9Q==
X-Received: by 2002:a5d:6292:0:b0:33b:4d13:3e91 with SMTP id k18-20020a5d6292000000b0033b4d133e91mr5115418wru.45.1707746643714;
        Mon, 12 Feb 2024 06:04:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2FhREuqbwRuKYJtya56ItSOC6CnVut+FGmVLLbrqotPpbXmQHGTs5li1wMy72vy87GpOFDt/vM4h/0TG3lOnc7SphXQnclCfqwX80p7gYrVyCZ9Xan+uONbq7HmMJnZILbB5EXb1FVo8CPDM/LBURBIySit05Fd4mtcRa+L6W5Uglc1Wr5r0bimOQGsLjLD7wkwNnbPcC4ILqKyAAPpJRkrJvpeH0V8xl38NIeJ3Gaz/iV3K4NdLbG+Z5pgA2aNH4c4GoE1+ieHikc1xIEss66dx7xn1hX5fWrHXT6Hoga6C+VDtSnG+yWEBwD1dxyEBLZ9dVLgjAN+Iyjl6Z81NTigF3gJUjjfcsdkVmSXpixgkORDZadXuPX9V8I67s8XL8zE3flMSasYWl7BIaMlxmd10j49UfBtUjDLu2DvL1wR4qRwAnTNvEGlpR8S7L3mHzC4AE+ofPHLSLx02qo1GuO737X20uG1S87fDbC6TeBw4f292opM/mwG7g3FHxR/qT/O2udQLk0TMBkMHAfPX2Jor9ig8+MHRh5kGkupMNltjn15zOJhk9e4nJJv+809lN1gPAdVhzR06krkILexHpjwrc8/Shm5XElDF+vkLAAnSg0ys=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:04:02 -0800 (PST)
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
Subject: [PATCH v2 11/12] spi: s3c64xx: switch gs101 to new port config data
Date: Mon, 12 Feb 2024 14:03:30 +0000
Message-ID: <20240212140331.915498-12-tudor.ambarus@linaro.org>
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

Drop the fifo_lvl_mask and rx_lvl_offset and switch to the new port
config data.

Advantages of the change:
- drop dependency on the OF alias ID.
- FIFO depth is inferred from the compatible. GS101 integrates 16 SPI
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


