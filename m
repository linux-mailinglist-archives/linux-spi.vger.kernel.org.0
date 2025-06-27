Return-Path: <linux-spi+bounces-8800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67EBAEB480
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C3356331B
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5029A9C9;
	Fri, 27 Jun 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phiUVO/m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B87298CA4
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019735; cv=none; b=eRaW2uKPNVGIR9vNdx3plD3FZ+eaQfP8Oa3zugvs/rmWfTP317oB0ZUnJxEeJOLnmh7mLfQ3yyCgE19sUTGbaelZDEWcl/MbEyJcRRtHGPFaG+wwZDbTVPCx0RD/mPssU+qIWP52+9COjHbwdgt4+cfG3pB3gbQjaPzDP84s7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019735; c=relaxed/simple;
	bh=A0AE7vMjvLEfs1Y6oPJLVtlkIxVVKUGc/kFuse+plRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ke/fDQ/aahT8/CmwDysFtdYl4cAJf/7JvpktM8WF0hXEASp+4Ql69stGUpWFXfdhzP/e9a92iVXik9zIpnnx1K7ah1N8y5ub+2NqSztB6Px8MpCxm2p/T0Peaf4oaifOyBHgiOa1U8C7xPDQT9DGqeSg2AMgSkRmBAGxA/Nehzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=phiUVO/m; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso10954075e9.2
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751019732; x=1751624532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzTUwfC3xNjPw5feWhh4vjqhcP0iCwezFStPDEpH0fM=;
        b=phiUVO/mfjvLngwXHEQjbNPPbLaqLHwNoPocjA8cXkv8p29xGStvvwfp3jroMiwcCP
         tiNiPw8JXaCppJQgT6KwW3cVJ2aYlOE058HwYDiw4ykp/61JuorScgbUh9k6w3E6ua33
         teJW7gk2+2212L3ekH8QyaeWMdhzGyv7nu8lgnMIQnFJS8J5PkCt9Ln/XtY9fzi1paez
         GC7pPlSyA4nlR69vSaBeM0r7Zr/qpzft5NCQNKZ4kQCE9K+IAxwq0a9hG7fuyTJvNXAb
         d1/euX8nWNNDThMaX68Y71++qSv+INZpxx8CXAD7GC6UlNYaWjtMEjS/JpE6gEEBjHSE
         gMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019732; x=1751624532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzTUwfC3xNjPw5feWhh4vjqhcP0iCwezFStPDEpH0fM=;
        b=ccYdaVi7Aft8Pj5lbh/g2If1NRjD43iJ9RjPzxJjfaQzcC2O2FBoMbwcdsbL7DxKab
         WEMmcp7vdSyCPj2a2vKDWFAGSNmNLO0VTacKI30EsqX2NU6l3ElBuIsrp+VaswhJ1joH
         P8aLPklyC7ndKDLGoIycBKIg6uNEarEj2Af4ub7kBydbHHkBsANr76KKhVU4H4njxCch
         3JoMyfnAlwgGYx6ML1xJjOfZH+D4yDkthkF5KWAeefZ5ufVGRavErXllRcfGCcadkpO2
         BQMXgFPN3fC78aP64n9K/gTmvVRaUSr6hfzGm6R/KyRq0/2LUoYqxM23FjPfxtwCd4Yt
         /7aA==
X-Gm-Message-State: AOJu0YyltCGhOy/r3QwvP4MJeeiciCi3J8t8HXicOLcv0BJA3LYaVece
	iUfbEuO/gCMaqlFfgFw5u6J2vuWMn+osOKzAitTWR/nlA/t1lMjnoLNb7KLmLiYaUjw=
X-Gm-Gg: ASbGncvjZAgq9VB6FhLr54c9ewQEXlEb+EGoufpd2quFVOiBxxgU0WfTZbF3wN1kbvw
	w7pxGFhUCTghWa8OcxwZw+udFoCeqzrYm7ZlITWg8GTNkIG7p9odZ+YaMHk0/KtY+MM73hQfjOo
	62l4VtmaBMs2qXYoQW0g8wnyIm+EK4IdZo7JkcPuZj4w1iqqbcMbV9H4ZYxDxImFYvMpWNzzdaa
	HCf1G4hh1II3Qj/WPhPHi3FR3KNYNisnQbSAQE9gaUUyLbQQbZA2qnHNfv/bT7+ThMJW2awOgdd
	Md2gzVGSUliTrsxb2/+kgO4uYUo3n4XXIEB/71syP1G4lrco+raEubmQJXFDPu+oaz7vdsM=
X-Google-Smtp-Source: AGHT+IFUDK62yhJ0rt2DuWwPnjIXpTSxvzqvb1fP76J3ZPniobq8nM9uTfBlDj2J/p+KBtN2CEHUkw==
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr12054215e9.11.1751019731517;
        Fri, 27 Jun 2025 03:22:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm47250955e9.13.2025.06.27.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 27 Jun 2025 11:21:38 +0100
Subject: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
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
 drivers/spi/spi-fsl-dspi.c | 70 ++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4bd4377551b5..65567745fe9a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -591,11 +591,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static void dspi_setup_accel(struct fsl_dspi *dspi);
 
-static int dspi_dma_xfer(struct fsl_dspi *dspi)
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	struct device *dev = &dspi->pdev->dev;
-	int ret = 0;
 
 	/*
 	 * dspi->len gets decremented by dspi_pop_tx_pushr in
@@ -612,14 +611,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
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
@@ -986,36 +983,40 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
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
-	int tries = 1000;
+	int tries;
 	u32 spi_sr;
 
-	do {
-		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-		regmap_write(dspi->regmap, SPI_SR, spi_sr);
+	while (dspi->len) {
+		for (tries = 1000; tries > 0; --tries) {
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+			regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-		if (spi_sr & SPI_SR_CMDTCF)
-			break;
-	} while (--tries);
+			if (spi_sr & SPI_SR_CMDTCF)
+				break;
+		}
 
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
@@ -1029,8 +1030,13 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
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
@@ -1060,7 +1066,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	bool cs = false;
-	int status = 0;
 	u32 val = 0;
 	bool cs_change = false;
 
@@ -1120,7 +1125,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				       dspi->progress, !dspi->irq);
 
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-			status = dspi_dma_xfer(dspi);
+			dspi_dma_xfer(dspi);
 		} else {
 			/*
 			 * Reinitialize the completion before transferring data
@@ -1134,15 +1139,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
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
@@ -1151,7 +1153,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			dspi_deassert_cs(spi, &cs);
 	}
 
-	if (status || !cs_change) {
+	dspi->cur_msg = NULL;
+	if (message->status || !cs_change) {
 		/* Put DSPI in stop mode */
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_HALT, SPI_MCR_HALT);
@@ -1160,10 +1163,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
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


