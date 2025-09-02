Return-Path: <linux-spi+bounces-9863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04FB4012E
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70E0540FEE
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637AE2DBF73;
	Tue,  2 Sep 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orTCVXt/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C882DC35C
	for <linux-spi@vger.kernel.org>; Tue,  2 Sep 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817180; cv=none; b=QaSdIw37kxKT46gBrQVRyKhNLoHSbQdOuZNeLJDcstjyEDzLmA3renjOoeSsX1jAQTPWp/61BdZSXTEelNaWBjPe2x80QdLwAWLTRm+dAtQapGEOUXJqduUFp7+oKEZ4+2hx25HjHXeCa2XHd/f1PgGtieSJnDH/BhOeYQwg6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817180; c=relaxed/simple;
	bh=fDy13d0jadoNgDpWip0eDAJ9ZTQEC7MeqwnmLrMOq3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e45YScplzRDwm4celNYvhEywEQv/pons0u7URF1OWhkWw7WWEufzL9ujLLJyrmxU8yH9EnOXr9anGXMaej703cY62rGfVRQAswhDceh8DF2cKD1CzCYvptIU0Kca6TcFIkXSg6uMKa4dkD4FF+FZSTCZ9TGpC3DtHILzqDgAXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=orTCVXt/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3cdfb1ff7aeso2639129f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 02 Sep 2025 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817173; x=1757421973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/upoONcJkK6CJjYHWkLIMw2CILsxwp/wVjDokkLyWs=;
        b=orTCVXt/bLmQ7sXY0Sj2MNp4u05xO8G1i1fmSxX/nrFZuCcI4eEjzu+RMDpyrK8dyi
         Sf0wLuaFSkbJOSUV83XCdvhRhOxS0HLspUF/rV8UZEWjbFSh620lSQdnqaiTwpRGXTNC
         zYwp667oEcsH4D3lly/alGcPCPayxUCd7gJW3EfvUYi3r0F8hdhT8NvVwDbs+7/HHVK3
         NaWFUuhvhf4lV6AtQVYVOk2Cpk+m/wK3atEzUlMTgqPM+y4OjxBe57Ldz+hW7OmXJkly
         fUR4K75lBbKT/WbgiIz7HB16CjJisO2GZvVfDpc/Sr20j7S2MUYO5HicGtc50g3rwqHY
         VbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817173; x=1757421973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/upoONcJkK6CJjYHWkLIMw2CILsxwp/wVjDokkLyWs=;
        b=ZXGhk45qdR0wxp0N2flwv02oGFO7RmueIgSZbvrQaneylll4jDt0kIPNJVBIjXOt8G
         Vp6e0nh4SO1unE4Cav+CwWF0Ov3W04NXgQQ+nnm8xjmTs1tILK9yVuyRj0av0f74aw1P
         TIDY2x0OX+nULiXYWMEnUAF+N+bMzeGimhSXjbhYpYo7SwsYqzLXNiK61G0XAZ7n1+9h
         i+1GHs6JJLl4FBXRgOMgvv1F7RtKGxE93ME9ZYAx31U3qnN3deELFgQq0G3B21tFZgze
         h5mvt+gBK7plPVXlq2mF16YDIRIaHgBbH/tanHjCY4f37tThRD/t7TBNzGnHhan6G8n7
         mG8w==
X-Gm-Message-State: AOJu0Yx/e65+4OYtvO7wDYBg0sTTVFjRS9seDYwggkZ3p9gF3RZwdeNP
	hebWfd1QF7oRP+RAUkavdFfRDs56cVUmYq4vcHbOiD4SGCTJ/sGhTKMbl0wcKPMOssY=
X-Gm-Gg: ASbGnctOapWQ8uoToGYDdqbwY283MvEoVvMswcVuLVGXzxngTS0GerROcb86lOlPykH
	EPTw3tqA5FC0CXKBKHcT30eVjTQ0/q/BqMBgvEWTQgze7+4Xq2RcqLwVdeTUxtJMAFAHeWUo3ST
	0jlwy+klK8rFxCISdKfKbezGe4k9ierCoNqHQFJ2pHrH3zpA7S41ju1Qi1UbKLCeNpetZdcAuqO
	AFgCAmBttthI2OovoZJaCg//scf1S1gKAOPwdfq4NBZsuhYnYzk4xiBFCnMk9URIF0oOOj5DF/O
	Xu1obCnAe4ue0pVjpI3uYQmfGzKlVv+90sHBPqtuFLebfugN9Gue4HmAyKo3Ii/ZLQX/fj+SeS4
	Q7hQlEY7rUPbj6FuVd8kALyGX/WIR9DxkTkI3qN/2uQ==
X-Google-Smtp-Source: AGHT+IG6jUoitTgiFTXdSrwMTL/OoQio/BlhVxzRStwKd/kUGsgb2XZinkbeZSLm7z/B6IiziT0tBQ==
X-Received: by 2002:a05:6000:1883:b0:3c0:7e30:a95f with SMTP id ffacd0b85a97d-3d1e0a94fbfmr9044471f8f.60.1756817173362;
        Tue, 02 Sep 2025 05:46:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:59 +0100
Subject: [PATCH v6 7/7] spi: spi-fsl-dspi: Report FIFO overflows as errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-7-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
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
index 3d29285c772c..83ea296597e9 100644
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
@@ -603,7 +615,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	if (spi_controller_is_target(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
-		return 0;
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		return dspi_fifo_error(dspi, spi_sr);
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
@@ -1073,6 +1086,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
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
@@ -1088,6 +1105,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	int status;
 	u32 spi_sr;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
@@ -1096,6 +1114,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
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


