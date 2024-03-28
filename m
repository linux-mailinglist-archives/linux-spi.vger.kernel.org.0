Return-Path: <linux-spi+bounces-2088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CC890C03
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 21:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E35B22C5F
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E213A888;
	Thu, 28 Mar 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qCzEOCiM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254B12F5A4
	for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659170; cv=none; b=ePbNYjOFh40iiNj73kGQyaLNojPFq9GlwkHYHfzxXxofIpiK5gDbjEgRx3Md20Vntr57Znshi/OOf5LsalwmOOvkQ0AHw00Pgz4RgJCrorFZ4us/Que9PoQE0z/VsPc+5GSaVzQtPOy3OZM+PrK8J3O+xSUflpD7pI4edThL1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659170; c=relaxed/simple;
	bh=/oZlhHR3Fe5C5+nFubO4bjXi7uClg732tgrtOLEBKSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlT6an8xjv2z+qb6xloZdW6F0rhdrgigsiVJGkJhXr7lXKV2Wu+JOGE/vZ14yd5qNEb+WEJ7g8f9VMkEPxM8R2V94STO8P/9EUA39HvxjBrLjzLncGs1tTSOBjfPYC2g7W2kxT39oe9FWVjhWI1+Rs03tleTKC2f6eHEzqgssqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qCzEOCiM; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e6b582d266so756675a34.3
        for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711659168; x=1712263968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBEq55br988pgVGk8t6++pKUK9LVnHaNQ5jojqkYPqA=;
        b=qCzEOCiMFCPRDDnLJ0xH3XL3pAoBdCT8YRwycZCPi0XlcopTyJMR9lXBD/NRE2/DNp
         pzonrdwhbopYayQsYL+Ma9E0xEfbC1eGUmr/d7LmmX7GTiHKbqcaXmwNWgEU+LeKP3oc
         b8c4paFZJ7zPt2h3AQbFYE7yr99wDpUcRl3m1FPSWZgm63ZafjY+WX7JOKCHPka5L2rX
         I4yUEfuHJst+h7rEQLtHM67VYvXNlSz3Txp9NNGkBgz4n8/rVs8stSzKkOS1Mo8lOM+3
         fItX5n+iii5L1DyUepxeYLNH3vw+4J/YRyg0RLb2V+g6oQMjh6Kr6LvUXuQoF7uv6LQp
         6ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659168; x=1712263968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBEq55br988pgVGk8t6++pKUK9LVnHaNQ5jojqkYPqA=;
        b=SzD4FiB+18/zOldwBcHJ9fvN6ZSCkW9pkEOrHiYeJBtdQwzP5737LlIFqGzwZYkLBK
         gWsMuwiPgF1aKWP9Qd/xXOINn2xdCiayDL4crlNFfHc6jUb6aeIFDxl4L7Y9U5Qc7tkL
         oriXIjn8luX5aCuiGnA6YBCjRmhAg5Yjz3DilLaG9t0w4ZIIGFh4XgQVrOHfSg9zDVcM
         Y1V5xljh79q8XZLDKT6bTF2L6rOVU6qynuSMKKB/0RvJ5fQqxPvFv5P+lhuIP0nXrkrZ
         e3tiwmj/PFiEC2Xg6PGbvnI5OFY7s9VJ/gmsgBLCdyTz2jOD9YPgKoqA+oSA7O3Zq8sv
         TtvA==
X-Forwarded-Encrypted: i=1; AJvYcCWOVf1qM79uijlVQ7fuNGK+O/mgdHGf7TAI/t0qurY/zzgjc3CHDhO3LLU09jbrNPIaPu4RtMrd5OfP9ffV6fI1ZNIPIwiDzHFR
X-Gm-Message-State: AOJu0YxhL+P0DJl1sbpJjuNfnmO8q7/rNj8eh+jWJY8B6t7S3t2GXFxf
	ugsixPyekKm4cD5KjlOwZfEVuTEhvf2z75waJF1SjlUCMc40uAagtf5E7Ltm7+k=
X-Google-Smtp-Source: AGHT+IEmEL1r8wlWIJURkQSMYpFviTs6Wn7DnMl5Mnb79+gecW5uwLdfX23dBt2/jeBx2wmULPT0ww==
X-Received: by 2002:a9d:7dd0:0:b0:6e6:7b61:1dd6 with SMTP id k16-20020a9d7dd0000000b006e67b611dd6mr381215otn.1.1711659168438;
        Thu, 28 Mar 2024 13:52:48 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id g16-20020a9d6c50000000b006e7011fea78sm293335otq.41.2024.03.28.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:52:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: fsl: remove is_dma_mapped checks
Date: Thu, 28 Mar 2024 15:51:46 -0500
Message-ID: <20240328-spi-more-tx-rx-buf-cleanup-v1-2-9ec1ceedf08c@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
References: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

There are no more peripheral drivers that set t->tx_dma or t->rx_dma.
Therefore, is_dma_mapped is always false and can be removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-fsl-cpm.c | 14 ++++----------
 drivers/spi/spi-fsl-cpm.h |  5 ++---
 drivers/spi/spi-fsl-spi.c |  7 +++----
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 47c7a5c6257f..e335132080bf 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -98,19 +98,13 @@ static void fsl_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi)
 	mpc8xxx_spi_write_reg(&reg_base->command, SPCOM_STR);
 }
 
-int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
-		     struct spi_transfer *t, bool is_dma_mapped)
+int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t)
 {
 	struct device *dev = mspi->dev;
 	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 
-	if (is_dma_mapped) {
-		mspi->map_tx_dma = 0;
-		mspi->map_rx_dma = 0;
-	} else {
-		mspi->map_tx_dma = 1;
-		mspi->map_rx_dma = 1;
-	}
+	mspi->map_tx_dma = 1;
+	mspi->map_rx_dma = 1;
 
 	if (!t->tx_buf) {
 		mspi->tx_dma = mspi->dma_dummy_tx;
@@ -147,7 +141,7 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 			return -ENOMEM;
 		}
 	} else if (t->tx_buf) {
-		mspi->tx_dma = t->tx_dma;
+		mspi->tx_dma = 0;
 	}
 
 	if (mspi->map_rx_dma) {
diff --git a/drivers/spi/spi-fsl-cpm.h b/drivers/spi/spi-fsl-cpm.h
index 160f999708b6..e012abba055f 100644
--- a/drivers/spi/spi-fsl-cpm.h
+++ b/drivers/spi/spi-fsl-cpm.h
@@ -20,7 +20,7 @@
 #ifdef CONFIG_FSL_SOC
 extern void fsl_spi_cpm_reinit_txrx(struct mpc8xxx_spi *mspi);
 extern int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
-			    struct spi_transfer *t, bool is_dma_mapped);
+			    struct spi_transfer *t);
 extern void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi);
 extern void fsl_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events);
 extern int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi);
@@ -28,8 +28,7 @@ extern void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi);
 #else
 static inline void fsl_spi_cpm_reinit_txrx(struct mpc8xxx_spi *mspi) { }
 static inline int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
-				   struct spi_transfer *t,
-				   bool is_dma_mapped) { return 0; }
+				   struct spi_transfer *t) { return 0; }
 static inline void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi) { }
 static inline void fsl_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events) { }
 static inline int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi) { return 0; }
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 97faf984801f..997e07c0a24a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -249,8 +249,7 @@ static int fsl_spi_cpu_bufs(struct mpc8xxx_spi *mspi,
 	return 0;
 }
 
-static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
-			    bool is_dma_mapped)
+static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(spi->controller);
 	struct fsl_spi_reg __iomem *reg_base;
@@ -274,7 +273,7 @@ static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 	reinit_completion(&mpc8xxx_spi->done);
 
 	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
-		ret = fsl_spi_cpm_bufs(mpc8xxx_spi, t, is_dma_mapped);
+		ret = fsl_spi_cpm_bufs(mpc8xxx_spi, t);
 	else
 		ret = fsl_spi_cpu_bufs(mpc8xxx_spi, t, len);
 	if (ret)
@@ -353,7 +352,7 @@ static int fsl_spi_transfer_one(struct spi_controller *controller,
 	if (status < 0)
 		return status;
 	if (t->len)
-		status = fsl_spi_bufs(spi, t, !!t->tx_dma || !!t->rx_dma);
+		status = fsl_spi_bufs(spi, t);
 	if (status > 0)
 		return -EMSGSIZE;
 

-- 
2.43.2


