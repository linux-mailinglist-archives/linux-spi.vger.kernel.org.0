Return-Path: <linux-spi+bounces-9775-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F39B3BA34
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568A5A01D9A
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B631812E;
	Fri, 29 Aug 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUGfsVar"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD92D640D
	for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468056; cv=none; b=QsCkZpBHzmS+eEcOcDpC8usWCfDD08aUeyO6tKgjZfEzCswPQkLLmT94P9aSyiKgWY+oCoRmKxV9hWnoJNZvW8AWDwElZ+DTPmUTlZSXPxrHgP/rZ3h/hX6Ajq36cydxGrQP1YEZoHVfth4P/pmZMurbIcDisPcxP7l4ZoXfFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468056; c=relaxed/simple;
	bh=S7x0ebfCt523Ls93oeQmD3KMYniINwdLaICZrUxIvQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwqHm5DHn9g6/T2K7HE8p9M91wmU+UI7JhMdlMifOSMwTUxlIIGYIn7+yfhu+xTF6WyGMC4xlVQ+U36YBSBwfqcs+te321fT1Q6ejZb3Y6X5BU6OQ9NlVAv331ysBTGNpJtVkCKESDl1LhOMOivyKe1OgxHIi2IDxb5RW34MQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dUGfsVar; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso1171724f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468051; x=1757072851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8Ff52Eurd3Sg0Fy6ii66kdfUaNx9pjdVhD8AWVlFlc=;
        b=dUGfsVarh9WwpLEtCnQNp794sxlag6qgqgHqnXkHFboB/1DW6OiE4mHoz+N6Wisc8x
         vns7E0MQN+Nq4kKR7aG8v9VvW2rsLrKMT8J+td7Suvu2bTQBfKb59pm5UpeVzLkx5bzD
         Q5Y4K04/IgNQbmnJ7vyzJs390gpumoLuxVx52e5G/EoRBNYeWSS6Vbcg4eh6iV2/zPd8
         W989N1IYKb8TkOaRKzCniYLE/Q6oPHnNwXQKZxo2JSxfSUmJVg3nwsqnQOrXlDngDXmP
         TYp5o/rbXw4XGQX+hSpupmfIfi1WhZKP6y7Uvy9zQO3JT6vC3LGqKpiOiByOCQb5EmGi
         PsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468051; x=1757072851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Ff52Eurd3Sg0Fy6ii66kdfUaNx9pjdVhD8AWVlFlc=;
        b=dD8xExPu7uNtJtsCyeKZlxurw351PQC95jme5zc+iUfBFY0wLWx6PbkUR9VZuCZH3+
         3mZQrg7crV09I9Zf3DxAr1Cp08cPytfXXvbKbEss700ec0xGYwW6iV8QuSLOmj3AuQqc
         7woRqKdRZqUOue+2X6kz1KIzxn0cwPOWO+eREynL/kl5fytMltM8i2/bNOsNq+upUTcB
         nPqbnyeE9R0EWuP4LQjQZceUSJ8cZJMvEaMMBQYm+qMBaqrKvleOXpEJfepnAPSdvHTo
         fUctpfDplNh1jk7Lef0ePknecaKNXoSxxDrq7sXNNcUmTVSdldyzZqR+iRQeLAYz5qrt
         iBzQ==
X-Gm-Message-State: AOJu0YznSrIzGPESfY3OnHvXxg9z2qR0Y42frayjncfsulWfyrDqVtVX
	gTOGUAhn6vzWLCuN7npygn2xYYlhkBCQCJGMRqdQzdWkJmpGT1leqqqBQset9q0oymg=
X-Gm-Gg: ASbGncvvvvsLNhHmzWbvdWv1ZYMSBTQc/cyG4XPPRYPxZz4MJe5r/hx41+bFJM30MDk
	Y46hQxtomT65HEYDp68dfKtETBZapK5Ahchm2uKfPpPkvNzqq+52tJyJ/EHvsc9p1aMGzkvyaJ9
	mYTTOBNtXdB3rmf0AU0qHddaVqoJ3O5Y1pOIYyRXvK8uHv2OdMcuF2GSYh0bCJWAtY+sxEIjiUQ
	LyW/3Azlz6tBWPjfMcP0ARH7EhaBZ+t1nZo9ACjsNLHf9Sy7hdgJ2wgUuwLXIsANBuuESuqMY4o
	RdGH4jkZqPqAy/T4OMjKzkbwgNhGrx5NM/M5yoq/P/mmoYMnxI0hJuhZfvq6hPg/P8qu+9ohgZt
	juK8AA3KXBxALPw/0kZKudek1PoAGvM091j0gGw7FZQbg8Svl08c0
X-Google-Smtp-Source: AGHT+IFz+p3bq6EKzPmfcfC5PMXg5Zav7B1eRrwjjM0k5SgBpuL4bFJbKjkKmesw/qpW53whi0+p4w==
X-Received: by 2002:a5d:64ea:0:b0:3ce:663a:c91f with SMTP id ffacd0b85a97d-3ce663accb0mr3601184f8f.42.1756468051335;
        Fri, 29 Aug 2025 04:47:31 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 29 Aug 2025 12:46:49 +0100
Subject: [PATCH v5 7/7] spi: spi-fsl-dspi: Report FIFO overflows as errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-james-nxp-spi-dma-v5-7-3246957a6ea9@linaro.org>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
In-Reply-To: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In target mode, the host sending more data than can be consumed would be
a common problem for any message exceeding the FIFO or DMA buffer size.
Cancel the whole message as soon as this condition is hit as the message
will be corrupted.

Only do this for target mode in a DMA transfer, it's not likely these
flags will be set in host mode so it's not worth adding extra checks. In
IRQ and polling modes we use the same transfer functions for hosts and
targets so the error flags always get checked. This is slightly
inconsistent but it's not worth doing the check conditionally because it
may catch some host programming errors in the future.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3b652d744492..8dcfd5ea4216 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -480,6 +480,17 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	dspi->dev_to_host(dspi, rxdata);
 }
 
+static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
+{
+	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
+		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
+				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
+				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
+		return -EIO;
+	}
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_DMA_ENGINE)
 
 /* Prepare one TX FIFO entry (txdata plus cmd) */
@@ -553,6 +564,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	struct device *dev = &dspi->pdev->dev;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
+	u32 spi_sr;
 	int i;
 
 	for (i = 0; i < dspi->words_in_flight; i++)
@@ -601,7 +613,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	if (spi_controller_is_target(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
-		return 0;
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		return dspi_fifo_error(dspi, spi_sr);
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
@@ -1071,6 +1084,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
 		for (tries = 1000; tries > 0; --tries) {
 			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 			regmap_write(dspi->regmap, SPI_SR, spi_sr);
+
+			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
+			if (dspi->cur_msg->status)
+				return;
 			if (spi_sr & SPI_SR_CMDTCF)
 				break;
 		}
@@ -1086,6 +1103,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	int status;
 	u32 spi_sr;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
@@ -1094,6 +1112,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
+	status = dspi_fifo_error(dspi, spi_sr);
+	if (status) {
+		if (dspi->cur_msg)
+			WRITE_ONCE(dspi->cur_msg->status, status);
+		complete(&dspi->xfer_done);
+		return IRQ_HANDLED;
+	}
+
 	if (dspi_rxtx(dspi) == false) {
 		if (dspi->cur_msg)
 			WRITE_ONCE(dspi->cur_msg->status, 0);

-- 
2.34.1


