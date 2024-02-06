Return-Path: <linux-spi+bounces-1070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6884B05F
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 09:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD2289D06
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38712D17D;
	Tue,  6 Feb 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmTkSa0k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FD12C7EB
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209572; cv=none; b=FRNGzQKXZF/CKlm5SLzmN25MjClwogwiB1ZlXvQSy4xFES8vrXC4zVsi9GDKZEjX1UcWDNr1bZl11qJMW4ogkhcPwcTcpZGBTquiF7kkpBRPfNSgWCU8MsGTa/tozHQZ7gVJjur6jev0BnOsZpvEEuxOFm7hD9JK2J1ruq1F0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209572; c=relaxed/simple;
	bh=GhmkaEMenRMgjxqbjfNuTR/ttv0MtGO/bHcCsohkOTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClMLdlvlRrYDnaIsOJO5SP9zUxndZKRKcBD7YgZw4mt4TMxwj4HOhChv+WE/tmgB/Y9ausepaiLqBTe6Lj0oqd7JZhfBcQNsEZMAVy6PypNKHS5yOroQeYISqul9TqJ1NQNAtYLBM9kCiGsTHmSTAh14C05r2N/qLJ49rNSJy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LmTkSa0k; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b40208735so1055335f8f.3
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 00:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707209569; x=1707814369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pplEDheF5LYrTZCBre+JeM++nHr5MatV98+DyJwfv+Y=;
        b=LmTkSa0kdCb0rXywXHJH8kvXXAc361jj4XiR987bQFq5MDdINakeN0/DHx7uEpVPQW
         rMVV4lCVFDs4lbiBCOSAy37AM+9Ocg41gln8NZG8hCYqUaom44j+DlTKe8bR8YapjIcg
         AnRoRCcIBgBRL7Z8P0CKrxGr2czPulhJ1KvfpfByJaStEp8N3S1t7Ev83Ewau7cUT3Hx
         FFEdPZUNshPB4qnjkz9ROXlMk6+0tVlmALSTlKRtYfR9ZWdlWV3vi+Q6Yet5VT6H6sRJ
         hs98AhCkU5US+6gQe8kEXybfUz9t3wfJKKZgzCRUjCIviEoYejxHTq6fffo0Oyy3tXYz
         Ko0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209569; x=1707814369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pplEDheF5LYrTZCBre+JeM++nHr5MatV98+DyJwfv+Y=;
        b=Ul17rW2A7tL7tULcSseMR4298KlBJaEKWdlAXsMiYoZ4bAI8yH3p311JjBNKZLJv1H
         0QqGfoHs4C6umxNNGPLdw9EAzVtYTpJWQzTyB/eAIvD8df2l761aVZYvv01dNLOZqx2n
         9mCAR3VEIdZXqeogTcPgzjUvYGTmVvuXL8Xm0wJn6OX6LNc4y1+js/Qto0zQHevPqU2O
         rETyiZWagsQUkctXjtmkaGxab+9e7a4HQlu541dZRr4hcGA0rewtH6m1iH/fscSC2Fzo
         +Q1p4GpeEyA7kDHvidcwXoWCe2adRS6SSAPsbqt20GtsFjbA+B1n4637KAkAlWWEMEkL
         sRQw==
X-Gm-Message-State: AOJu0YwCeakabLTXKnoIoW9qZLY/OBxqW1BE0Qg4DqZKU2lsAzehIctI
	2TbDE/R8hBKmWQOCsHeS89n274SpOoztoAT1vmmkR4n5C20EofPLZiT6RiVoaeY=
X-Google-Smtp-Source: AGHT+IFtpM7RtrErOcc4nsWZ8tHQygBsiwmCq/p182xd0tFgmQxVJRAFvpfZWnODY+HCwC3s3/vNzA==
X-Received: by 2002:a5d:44c9:0:b0:33b:2d58:c070 with SMTP id z9-20020a5d44c9000000b0033b2d58c070mr751663wrr.20.1707209568960;
        Tue, 06 Feb 2024 00:52:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7cNb4TASYY90l9fH/FJ+y6UWMCAOwhFd4AbWO5Bf6cKW4UVx/GGbpxR5BVhv8wIkTDoM1ypQByhk+cfQQuIMwaKKeW1c6rx22gq+Z/n+D1g5V5tkVKqLWX9uAUT/Ug6nn4yLMgjhSdot+kxcZuWrnp7lgech706d8HpLEJRlAhRWAiWsj7aZTAScWliYoF78mCmdsTdxbaCz2Ub3+bbs3su1HqTCWL8XaOg6uAzIAE5G9esHau3XK6RBMwCX8VkRyqC+hzZjU/7nA8N782er/6pE7R6b4Wz1o71178U/jmcZCSQKg2EKpoR8PjuHmGiXmuBRXJxoFmX6IQ/kCv37Rq9hjXfLXGBQB3+qW3zmONY1nQNv/ryg00YhlKaHCJ5MucWFaP6/4g9ZVPzIyFw/FmRiu8ncswVCK5gvosjgrmx8YOCutFJTQtvK1SrCNPGR89eYX6SMs8re0Pt5fkwUjeRdP7qnT+lbhxAZhlk5Eusmtd5CwnB3IayUVRTT+91/2YEt0jHodPpQmJrlEJcuNMGKZ6T6AfEkvs4Xgibj+WuKWe7yuDFDUOX0+fJiRatznv/ysEbxoBocUxUbHV9EkzQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c078a00b0040fe078fb03sm1221591wmo.32.2024.02.06.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 00:52:47 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
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
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 3/4] spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
Date: Tue,  6 Feb 2024 08:52:37 +0000
Message-ID: <20240206085238.1208256-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow SoCs that require 32 bits register accesses to write data in
chunks of 8 or 16 bits. One SoC that requires 32 bit register accesses
is the google gs101. The operation is rare, thus open code it in the
driver rather than making it generic (through asm-generic/io.h)

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 70 +++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c15ca6a910dc..cb45ad615f3d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -142,6 +142,7 @@ struct s3c64xx_spi_dma_data {
  *	prescaler unit.
  * @clk_ioclk: True if clock is present on this device
  * @has_loopback: True if loopback mode can be supported
+ * @use_32bit_io: True if the SoC allows just 32-bit register accesses.
  *
  * The Samsung s3c64xx SPI controller are used on various Samsung SoC's but
  * differ in some aspects such as the size of the fifo and spi bus clock
@@ -158,6 +159,7 @@ struct s3c64xx_spi_port_config {
 	bool	clk_from_cmu;
 	bool	clk_ioclk;
 	bool	has_loopback;
+	bool	use_32bit_io;
 };
 
 /**
@@ -412,6 +414,59 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 	return false;
 }
 
+static void s3c64xx_iowrite8_32_rep(volatile void __iomem *addr,
+				    const void *buffer, unsigned int count)
+{
+	if (count) {
+		const u8 *buf = buffer;
+
+		do {
+			__raw_writel(*buf++, addr);
+		} while (--count);
+	}
+}
+
+static void s3c64xx_iowrite16_32_rep(volatile void __iomem *addr,
+				     const void *buffer, unsigned int count)
+{
+	if (count) {
+		const u16 *buf = buffer;
+
+		do {
+			__raw_writel(*buf++, addr);
+		} while (--count);
+	}
+}
+
+static void s3c64xx_iowrite_rep(const struct s3c64xx_spi_driver_data *sdd,
+				struct spi_transfer *xfer)
+{
+	void __iomem *regs = sdd->regs;
+
+	switch (sdd->cur_bpw) {
+	case 32:
+		iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
+			      xfer->tx_buf, xfer->len / 4);
+		break;
+	case 16:
+		if (sdd->port_conf->use_32bit_io)
+			s3c64xx_iowrite16_32_rep(regs + S3C64XX_SPI_TX_DATA,
+						 xfer->tx_buf, xfer->len / 2);
+		else
+			iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
+				      xfer->tx_buf, xfer->len / 2);
+		break;
+	default:
+		if (sdd->port_conf->use_32bit_io)
+			s3c64xx_iowrite8_32_rep(regs + S3C64XX_SPI_TX_DATA,
+						xfer->tx_buf, xfer->len);
+		else
+			iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
+				     xfer->tx_buf, xfer->len);
+		break;
+	}
+}
+
 static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				    struct spi_transfer *xfer, int dma_mode)
 {
@@ -445,20 +500,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
 			ret = s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
-			switch (sdd->cur_bpw) {
-			case 32:
-				iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
-					xfer->tx_buf, xfer->len / 4);
-				break;
-			case 16:
-				iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
-					xfer->tx_buf, xfer->len / 2);
-				break;
-			default:
-				iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
-					xfer->tx_buf, xfer->len);
-				break;
-			}
+			s3c64xx_iowrite_rep(sdd, xfer);
 		}
 	}
 
-- 
2.43.0.594.gd9cf4e227d-goog


