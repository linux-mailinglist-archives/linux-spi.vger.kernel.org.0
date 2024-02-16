Return-Path: <linux-spi+bounces-1396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCD085768A
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CE71C228CE
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00191C69C;
	Fri, 16 Feb 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffKFRJqw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C951B960
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067175; cv=none; b=VnQiCymSP0GsmngejtuecaCrKQLu3yFvnrxB2z+UJQOjI9udojV095yLeHcrwc6zQuWpMhcq7CF7iF5wsp3AJtLBp08YCyWJsMcXFFrycoyO+Md+gG3XFMkw/1JWFAU8jxFIxPOruaGKjnL7lth8Qvd2RTQhPTPw1JH8UBCpfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067175; c=relaxed/simple;
	bh=rEwrNRSJosIOETt0muN0AvqXSARw3AJvb0f7av+IGBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho9ytafFVWdoPwG/IrlmGc3uTh0VEt3MXGmoXKzulXqSvAxQHgkluiUHhCgifa5KNxuyrejhPFPO1wgw6gtLlig4nLra0MkfsIhiQzYcAasMxMylsq8NOmfggotDvON+FQUiKK0oiJ3SQgYFx6Vy8Amlzb827qfHAPGO0G2yQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffKFRJqw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33cddf4b4b5so1231413f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 23:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067172; x=1708671972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlEAGth0Co0Fd1/HqPxdx3qoYNRQ6mjC1NaX6yHqe58=;
        b=ffKFRJqwyvE1v+mM5CWK0Cr9akqi6NP9i0ksU9HtIZaftDCM6M63RKnzqp+O7HgObC
         bBF4b8sKlHHkL2ZxWwnFfz8PDqoc/2lKY4fhmL4kzzeFBlj59kJTRM1q3BEg7RY7xgkV
         /BFnhdnyaGdi+h3s7j00Zxg0Ex1ExzAXZYs2ZrZpPML8ZvxQWOhJwn4VoXnHX9NMUqyx
         1KVDpib/H7M1rFTE5l1BIoZwurMSN/UUGZ3neHjXHggxgETWAsiZ5QNVsyyfIotYnagm
         Ueil/uSQ76P48pUJqj5Mxi6lJKoX1opTHRIsYMxw6tPI2vjgwLCHQv8PHtoNOUd5/Ycw
         eK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067172; x=1708671972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlEAGth0Co0Fd1/HqPxdx3qoYNRQ6mjC1NaX6yHqe58=;
        b=DZCl/l63RlybLH6nZDS6Lkzd59ZFU8vl8ZFAzvfbahYOMN/igZ+KslcCwOi/773FpW
         q09uSNBhrJMuPlGPI/DeJLRtGZijtoNnho/b4kBGhp2bhmiSEekbIDGDq946TMZx2aJi
         EmVsGSErJaezgnJEcXkHmTxUQsXd2GVS6epxSJKoERbgQJaxMo5CLzYEAnylvcSWr+8j
         1JD6A/67vV25ezcvTrhM8O0O5R66EjmBV9wRD2i1cQhrAYCNSH+t9PNO3tWNyHlQ+RoH
         IvBuvaHoiHOyrvtVOzW5wFm+81YbKf/D9nvGZdXk81WcYBzjx4d9BBfqSwsYfi7srNYg
         kNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+kHsu2gmFwMzydAK20Uy1rq6JRjTMMM+608c/7vBmuDTe74xxyEizmlknZviWfLY+xcAM5Pnf2HVc/8TZ+OvlcOmkFw+A0W2c
X-Gm-Message-State: AOJu0YzoG82Peql6E8h7ki2tpWWaeNvRCr4gvKaDndsar+F58/9TMwB1
	DpXE0gRiii2URcrHm1MmQZBxSKQoU0a0V6QOUAGRkrH69S0MtCSJG9uNGvNxPzvKT09r48BkMdS
	Wk5U=
X-Google-Smtp-Source: AGHT+IGsrLV3+RiNvxI1/B9FQ/CQQICwL4VfbwMyZyOecZRcb4rbORmTFjVsORHRgY2cfPv7UUbymw==
X-Received: by 2002:a5d:414a:0:b0:33b:6d36:de48 with SMTP id c10-20020a5d414a000000b0033b6d36de48mr3298206wrq.26.1708067172176;
        Thu, 15 Feb 2024 23:06:12 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:11 -0800 (PST)
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
Subject: [PATCH v3 11/12] spi: s3c64xx: switch gs101 to new port config data
Date: Fri, 16 Feb 2024 07:05:54 +0000
Message-ID: <20240216070555.2483977-12-tudor.ambarus@linaro.org>
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
2.44.0.rc0.258.g7320e95886-goog


