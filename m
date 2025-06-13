Return-Path: <linux-spi+bounces-8493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4738AD87D6
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E88D3A6C7A
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D152C3253;
	Fri, 13 Jun 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JU3mZq8L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5112C158C
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806969; cv=none; b=fFeNDRSQYzxNTzLxEvMFERr9q1i3iP6Hr8ExgaKwQ+sRIX4c8vSyfppyVvj3BMroQ8MEVTlmWjs1/dWtlH3zfARIiEE0mhtEtPT0aXpYXodYg5627kR7I29cxlQGwntIUEDRovB1/nr5A3On3rpdWvogFhpX1MJ2Mg3brIGGkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806969; c=relaxed/simple;
	bh=IpiugmKeISWFulxh2X5eQ8UZ9sRsTCudX6TcsNfAcSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nb4KHe9fLfy257Vn3fG0ebwug3KbCyqW3GGQr5B3O+Fiz+ytmnYSZDJ/rrgjGMTbC7g+MELOMG+TKkaXiv5KD1ChVSMoFU0LU1XCy6jY7iLHKlHR4YsYB5HrlJaznBG3t6I/gKFK5qVJ8ZZXg24/CmVRa87qUkaj8IKfsHX3Jsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JU3mZq8L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a522224582so1079887f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749806966; x=1750411766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn5/JVKHTwCL3l+YfCzsIlgtnvvih6BSTZZfVhworAw=;
        b=JU3mZq8LAFl781Fsz93EhoT+SL+fKubYhBOgBE+ikmZV731+XuaBuCWGlOUfTYc2oF
         cx86O35Y5ufV45Y/m0aP94MHy5DHZB45zIJd15D8A4fciV4b/74FJ2FyEyAAVvPgj0xZ
         wcSVv8tUUh0BOpwW68ZhTqlvhUv8qFrXLCxL1JfR+Opxt7bHmg4964ZoZOm90NAGEw2y
         dovfC0xb+qxfwJit8B10n0bu1OU1nUwtesxd5eXbIonchZZ4HYae3dG9Jbk9qZfDeSkm
         dsSA2YWlenbWcSvMNo8q/JLeSL1U1KBzGJKTtsY2Mvpn+0r/GhYLQAMnTTzsVGq+9Qiq
         26KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806966; x=1750411766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fn5/JVKHTwCL3l+YfCzsIlgtnvvih6BSTZZfVhworAw=;
        b=gdYBuUOqDGk5lhfmLwo6RJwIsVo7WB9tzy69F+rjvxh1jKLOx/BeNm58Ajl3F0Qmgj
         IvzKVBm5dNHTUR9QvcMh8KMeytDntflPC3lENJ/dkcIRHURJEgsdkO7NSYtGGEfu4k6H
         vL+sogXD+I/ovNIoxYnQE76/uOUF2g9cmXS5dpQ8xIwcwaw/QSXNSRVQagxFY2O2PLP8
         1VIhMdtia1ppQRPfUbTxCmmc8HcPv/7gQpf8QIKkocP/4IoDc6WLmo1hDNI7lcErUgY8
         +OxGuI5wSKdH+ske6Dh9i73Y0d6y3RLTvxNCHMvH72c2UdTXUUYmgc74UvlkNvcpLv6r
         hK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX99R4UO24jNtGbDGW8TWBqMA1vn7cdjagLkFKKI18LZrAhhQ68jJrmTWwCEymO0hOkAQtj94tL0PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCsF4YAP+0VsHFtsrUjM0oasq6o0Oj6lPgN9en+iz97cow/de
	lHV/gEBauEyNgQsa7uNV3XTn0oYYGlyPnscjx+AOamdD2wNXZIgMNfMAe7S5FDvVFAo=
X-Gm-Gg: ASbGncvqvoFw61hrzzD7DdhM9udhHhKGKjRVJLovbnobcpICSLqQKKEQvbvHTkbZ0WV
	JowY+NwSZfdnER5k0Ur6TCAvZCflgeMG2HjTVF3NZfhnwS8+1zEMfB2yRQIIb7y7JnehjqQW8rk
	5JfqrxRlHCWAwriMDk2L1zN/qRqCGib+lbR4bTHjRsDkBZkaP4i0xSyGnnF8UgCnZY7C3pyLhOQ
	K5wnC4/I+NTurSmXWLUuRr+3nfS5m1G2BBoZGs/YSXoYpoJADY8zC1ylj9GeyHnRknZPpnfGPmy
	Y64ycw3+YJ91zknuHb4Ji9oDDTzKOBhmGYwl8cfuM7MJzcXvE9tJvmyoEgNG00HnwvrJR1mA/e6
	eWd3NDw==
X-Google-Smtp-Source: AGHT+IHTciO5qAtRfmmfRqhZoob18Wulxbnle++H7sYpmrlbCjBtBvPBK8JLtufPhbTAKQK+IlGULA==
X-Received: by 2002:a05:6000:26d3:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3a56875776bmr2282133f8f.34.1749806965768;
        Fri, 13 Jun 2025 02:29:25 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08a2bsm1805946f8f.62.2025.06.13.02.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:29:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 13 Jun 2025 10:28:59 +0100
Subject: [PATCH v2 4/5] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-james-nxp-spi-dma-v2-4-017eecf24aab@linaro.org>
References: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
In-Reply-To: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>, 
 Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This will allow us to return a status from the interrupt handler in a
later commit and avoids copying it at the end of
dspi_transfer_one_message(). For consistency make polling and DMA modes
use the same mechanism.

Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
this isn't actually a status that was ever returned to the core layer
but some internal state. Wherever that was used we can look at dspi->len
instead.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 68 ++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 48c2ebefcd4a..31432d533dea 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -636,12 +636,11 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static void dspi_setup_accel(struct fsl_dspi *dspi);
 
-static int dspi_dma_xfer(struct fsl_dspi *dspi)
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	int max_words = dspi_dma_max_datawords(dspi);
 	struct device *dev = &dspi->pdev->dev;
-	int ret = 0;
 
 	/*
 	 * dspi->len gets decremented by dspi_pop_tx_pushr in
@@ -658,14 +657,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
 
-		ret = dspi_next_xfer_dma_submit(dspi);
-		if (ret) {
+		message->status = dspi_next_xfer_dma_submit(dspi);
+		if (message->status) {
 			dev_err(dev, "DMA transfer failed\n");
 			break;
 		}
 	}
-
-	return ret;
 }
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
@@ -1035,36 +1032,40 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
 				dspi->progress, !dspi->irq);
 }
 
-static int dspi_rxtx(struct fsl_dspi *dspi)
+static void dspi_rxtx(struct fsl_dspi *dspi)
 {
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
-		return 0;
+		return;
 
 	dspi_fifo_write(dspi);
-
-	return -EINPROGRESS;
 }
 
-static int dspi_poll(struct fsl_dspi *dspi)
+static void dspi_poll(struct fsl_dspi *dspi)
 {
 	int tries = 1000;
 	u32 spi_sr;
 
-	do {
-		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-		regmap_write(dspi->regmap, SPI_SR, spi_sr);
+	while (dspi->len) {
+		do {
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+			regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-		if (spi_sr & SPI_SR_CMDTCF)
-			break;
-	} while (--tries);
+			if (spi_sr & SPI_SR_CMDTCF)
+				break;
+		} while (--tries);
 
-	if (!tries)
-		return -ETIMEDOUT;
+		if (!tries) {
+			dspi->cur_msg->status = -ETIMEDOUT;
+			return;
+		}
 
-	return dspi_rxtx(dspi);
+		dspi_rxtx(dspi);
+	}
+
+	dspi->cur_msg->status = 0;
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
@@ -1078,8 +1079,13 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == 0)
+	dspi_rxtx(dspi);
+
+	if (!dspi->len) {
+		if (dspi->cur_msg)
+			WRITE_ONCE(dspi->cur_msg->status, 0);
 		complete(&dspi->xfer_done);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1109,7 +1115,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	bool cs = false;
-	int status = 0;
 	u32 val = 0;
 	bool cs_change = false;
 
@@ -1169,7 +1174,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				       dspi->progress, !dspi->irq);
 
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-			status = dspi_dma_xfer(dspi);
+			dspi_dma_xfer(dspi);
 		} else {
 			/*
 			 * Reset completion counter to clear any extra
@@ -1182,15 +1187,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
 			dspi_fifo_write(dspi);
 
-			if (dspi->irq) {
+			if (dspi->irq)
 				wait_for_completion(&dspi->xfer_done);
-			} else {
-				do {
-					status = dspi_poll(dspi);
-				} while (status == -EINPROGRESS);
-			}
+			else
+				dspi_poll(dspi);
 		}
-		if (status)
+		if (READ_ONCE(message->status))
 			break;
 
 		spi_transfer_delay_exec(transfer);
@@ -1199,7 +1201,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			dspi_deassert_cs(spi, &cs);
 	}
 
-	if (status || !cs_change) {
+	dspi->cur_msg = NULL;
+	if (message->status || !cs_change) {
 		/* Put DSPI in stop mode */
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_HALT, SPI_MCR_HALT);
@@ -1208,10 +1211,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			;
 	}
 
-	message->status = status;
 	spi_finalize_current_message(ctlr);
 
-	return status;
+	return message->status;
 }
 
 static int dspi_set_mtf(struct fsl_dspi *dspi)

-- 
2.34.1


