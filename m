Return-Path: <linux-spi+bounces-8804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B40AEB488
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBD216EBE5
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525A2D4B47;
	Fri, 27 Jun 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgjSxoY7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB72D12FF
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019739; cv=none; b=MivGYdNbCJuFpA2tjReIszfP9qewZ2QTCMn7rGknU7bz4c9XMrxARJV/dS8Jo6ufdSKuDPgTQA23xNX/0zSvhlj3mIG4oBdQ+M2wjPJJqbgHpwWGeCp+xyip/nk9DnNcSMwnUHXq3LqAwvkiu3DbfuYyCJblXKdORZxYTZpwvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019739; c=relaxed/simple;
	bh=tnlV1BTcXX8TkRVCvUT7BEAqgsHtSlAw6diYlslpUgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJ90C2o3fyOricwewg63wG8v5QqMvZ9WRM6mFZst6oN9oxNCc40hQKFkBL0xojFySryWv/T7csumWOGrAgB+M7IAQxMQob1Btwcflt8/Mpc3hgV4iUSon+dQdCPyra7bLuHE8qSxPF6paGmdsOSfHWaWBwaUa04E9AoA3qA/9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CgjSxoY7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453749af004so11021115e9.1
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751019735; x=1751624535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMKMNWSy8hAGvbCZFBJvEFBm5RGHszf1PCWsZo/9xEE=;
        b=CgjSxoY73zn4hUYrqNPWWHQ/Zaz1RTMWgQya7lTTNFVEA7I5gxHGWDXlfY+uQZbHu6
         HMnZm83sUVR+vCqxte0MdcQGlbm3isWNeZkAwk6s+7YapjNKKWWH1dHPd0ifKQqCD/MM
         f0R/TcQ5q2xlDQVjEWvqLYHzkacKD0HUKlYqsMJDpxa9Iqk1ajJou/WbMD0InraH75yl
         z9r7/AfR16why1n3qTpftmOy3ZWuADaONoAH8ktkqyrjg+h1uMl8kn2UEOCg8lMgsl+A
         JqPXE0oUuQOo/BTOhpR+amBk0q00L6nYsnPUk2zd7eayp1/6nTIZrQUzJoBsstpA2wgZ
         bm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019735; x=1751624535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMKMNWSy8hAGvbCZFBJvEFBm5RGHszf1PCWsZo/9xEE=;
        b=Q7a5RJgn+oXygI98oulOAtVhgF1vuknJEPMj4q2oAEBVI2+0gMk2rlWMAEbhBLQXFM
         o8AbzeoUHhBDE4folsyaqKNCXBRRTirNzjG2R1PQhh3QNiWJv9jldArFaoNLH1b/M0Gl
         YVgs9+HAOM5bX9UYEtI/wKO7kBMwy+5SlEZFmOIOdG/5qAowrfGopObsi/6cW/sI0exq
         Pw2X2K9YPWebDnRctSgFjRs7Mdk7WqIWNCG+e4GggAjwDaYKq/KQ3ndCTRzyGsHAV2VL
         YqG00laAtthFSxwu9YRAeWvfdk4EJQP37Bpvb5cXsTf0xr2lo/5/MsBOXWDXJUvP/bnA
         B/nw==
X-Gm-Message-State: AOJu0Yy9b5VkXAS5MLC7myx1we1Mfy0uCcA+NCfmRHXY/ZHhsEfKjeLP
	ea8ZMLrR0/391dzzrziODJDguTieHFHC0R6kVaGjCvV9FWY158LQVB2mqR1X+O6fuRg=
X-Gm-Gg: ASbGncsVJthOHgjid/9siCNYdNQFhogGV/Ds12sTsgibdDFErLDQf6RY5nEk288qXrG
	RLaSjs7Y6HUZ3S5qC4MohbNLwjp4PZ6+7sRbLfYjk854quOH8z+qxLyh03ABwz5k+fLwG2q0Bg3
	Gz8c9YwT3FFSKu8nxGv/MO4KdRDyx49Ld/+1tO1DCOqskKOE/eET6o85tldq5nn6F5/u+z/aBOM
	MqKfOk/q09Jw1c0zMSzkcg9pYZtAcnr/UEQG2obY4hnuPR1pXbnaBRABwCR6u1pue3zeo5JYvbo
	4WEPgfXsGsKFpJ89OoZKezsgVgS5OuKuAbUnTlKyfa5iugLgV+iInxPRrrox4lHgt7hXv6g=
X-Google-Smtp-Source: AGHT+IFsKSW3JYeHrMvdSGefKS0adTCUH7itGRvgFnkdhGDlbVeAt6e7x+C9SF55foHinQ7yjVA6ng==
X-Received: by 2002:a05:600c:4752:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-4538ee27811mr36353175e9.10.1751019735290;
        Fri, 27 Jun 2025 03:22:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm47250955e9.13.2025.06.27.03.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 27 Jun 2025 11:21:42 +0100
Subject: [PATCH v4 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-james-nxp-spi-dma-v4-6-178dba20c120@linaro.org>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
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
 drivers/spi/spi-fsl-dspi.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 46d3cae9efed..2c2a263c5276 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -478,6 +478,17 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
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
@@ -566,6 +577,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	struct device *dev = &dspi->pdev->dev;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
+	u32 spi_sr;
 	int i;
 
 	for (i = 0; i < dspi->words_in_flight; i++)
@@ -614,7 +626,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	if (spi_controller_is_target(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
-		return 0;
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		return dspi_fifo_error(dspi, spi_sr);
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
@@ -1067,6 +1080,9 @@ static void dspi_poll(struct fsl_dspi *dspi)
 			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 			regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
+			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
+			if (dspi->cur_msg->status)
+				return;
 			if (spi_sr & SPI_SR_CMDTCF)
 				break;
 		}
@@ -1085,6 +1101,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	int status;
 	u32 spi_sr;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
@@ -1093,6 +1110,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
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
 	dspi_rxtx(dspi);
 
 	if (!dspi->len) {

-- 
2.34.1


