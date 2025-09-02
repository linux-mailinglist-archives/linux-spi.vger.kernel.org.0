Return-Path: <linux-spi+bounces-9856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF85B4010F
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 14:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928301B2297A
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1B2D4819;
	Tue,  2 Sep 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUb5ZQkM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6212853E0
	for <linux-spi@vger.kernel.org>; Tue,  2 Sep 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817170; cv=none; b=FD26D8zM4nLvZuxxVZ4DREuOvDkQok191hy1b7uW4GT7ra8EMHIsusD6bC8A8faEW98NypfwqgxoyUfNIf6slu+qHvJKoMk/PP2e18cP+LjF362PC44xFuU6I7TvD2sVO9Vm/fo6QBWhs/2h0DPVjAmsrWFmSQN4qjClod0In10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817170; c=relaxed/simple;
	bh=8/fgw25QdB1ZgzdAKtXHCLtofKXduBfFQhmuMPgookE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBVG812EhkazQ7SmH1PYbQ6MPMG4TxylYb+/Dmqjt0BaYoaupR2zE7Hh8FRE943Zku3zGyK76bd4kyJflLTyYz7qGqMFZx5QGt5l/jjpkc6gcG1OaDIj0ifhHFT+G3lrdiVEaxT2wvtKoQST6mzjJXkUvdarNHF/tO5b9PB4/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUb5ZQkM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so16386515e9.2
        for <linux-spi@vger.kernel.org>; Tue, 02 Sep 2025 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817167; x=1757421967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r9IPHLuMKz/CQAQPk4+OYtt68jBsvmpWFMRP88G9KI=;
        b=WUb5ZQkMRb/nX8f2m5X0PRpMMRJu8VSdeLcLLMx/sAKY6k1ta06F2t0JD/BF5X5zZ2
         G0E5SbmWYRUmCbccvh1ySU5zjVNWguy/FLBXXG+zF30OYYH+Ntcu7JlVUtBBcvzMiPje
         Hr5Rn9FIp+fvYb56Mh3kBYYCb5WYRSlc9dT3/vXv9cEDHCzbVckzygWGUPDDTzNtI8cW
         kBJ9xiIa7JBgTThsPu8R9V2zDHOkVY81xu3Kouvpy0OauU24eDPSmNQdvhUCOjcICzCJ
         WkGcM7fXtlpwJW1x/TKmFG1OUwV//a+zSXPXYb7ydsa7g1o0guSTYm+E0zvFs49Z3bXi
         5ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817167; x=1757421967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r9IPHLuMKz/CQAQPk4+OYtt68jBsvmpWFMRP88G9KI=;
        b=weeEo/jd5DrFMMltzBhOXj3IbrIioejh/naQshI10JV4Hn+NsBq3KGhk+hTNf841LI
         X2mFpp9NNUEDg8WQcdETLv76GLDcEGBIMwNvaBGi1w7CJ41D1dYHIVG6Y+/iasa6TzZu
         KOrreGX5YswJA4OFgYJ3mHLlsGqdDyKSXzvzO+edZcCoC6UGeD1UIPRtr7eI9nMRBOvi
         0jd+iIsY8hnC/2uT9u+0cEA6/4TKJL3KXhw6Gdei/PqVJCWqmc7Imc/8tCqoS57Mstl1
         zp5teo1x4ANJsNaR+D3LXAY02adiSjPsfanWVmY/bCEbyN5md4pl4i+L5e+kPMCHcOed
         Dd2Q==
X-Gm-Message-State: AOJu0YxQqfWsw9cxSaCTqWAxzwOho/Y1SxkprBdv1x/DEQVpuFoV4zyx
	4s8soQ+ZHC41Xzh+Y4q162+U+6bh6ZAEIPUiOMRPgSMsne5EM4guzl+ALHXrHyX/YSM=
X-Gm-Gg: ASbGncvNE+qBhe+2R5JAXovZbsPrJUmnYeocCXL7hPUpxeO/Qkc40bvXZY/nJTTx4Jh
	iMl4yE0ISJ8GvsRJSUuskRrMFl/RF/Uo+62bWRhrjL+dsV1kZFmjuxPmYaH8EywoFvxqX1Dl87H
	biV35pmdn/6XY6bRlGOQwhuMxCjZqRXzsWZusHvBtghSZa9bt5o6Il7euEet0pwIzE5vCkfNqtx
	PsOUD9YXiWAxags4frSjgCEwKvJBUgsLdb3zuaxJIrkACypt1edv8m1rs1Z1SaHWdVj4DI4EDmr
	ERilRt/Arob4a//V3FFEzK3RNSh+nTbqiImb5WiLjxJNBfcSBduFHIvxudTJWAq1f3MGNQ51Z+u
	HzIgwjtlzkzOAtMhXNxgWOXszEPA04fc=
X-Google-Smtp-Source: AGHT+IFiBte5oIm9wgYp4QL6sXIclbo20jvsZNvWU5oy5exkamtVaSde2J41wTdC4z94mkJWGbNsYw==
X-Received: by 2002:a05:6000:3112:b0:3d1:42dc:c710 with SMTP id ffacd0b85a97d-3d1dcb76607mr9142347f8f.16.1756817167187;
        Tue, 02 Sep 2025 05:46:07 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:06 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:53 +0100
Subject: [PATCH v6 1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-1-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
this isn't actually a status that is ever returned to the core layer but
some internal state. Use true/false return value on dspi_rxtx() for this
instead.

This will help separate internal vs external status for the later change
to store the external status directly in cur_msg->status.

No functional changes intended.

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4bd4377551b5..654905a358e8 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -986,36 +986,45 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
 				dspi->progress, !dspi->irq);
 }
 
-static int dspi_rxtx(struct fsl_dspi *dspi)
+/*
+ * Read the previous transfer from the FIFO and transmit the next one.
+ *
+ * Returns false if the buffer to be transmitted is empty, and true if there is
+ * still data to transmit.
+ */
+static bool dspi_rxtx(struct fsl_dspi *dspi)
 {
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
-		return 0;
+		return false;
 
 	dspi_fifo_write(dspi);
 
-	return -EINPROGRESS;
+	return true;
 }
 
 static int dspi_poll(struct fsl_dspi *dspi)
 {
-	int tries = 1000;
+	int tries;
+	int err = 0;
 	u32 spi_sr;
 
 	do {
-		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-		regmap_write(dspi->regmap, SPI_SR, spi_sr);
-
-		if (spi_sr & SPI_SR_CMDTCF)
+		for (tries = 1000; tries > 0; --tries) {
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+			regmap_write(dspi->regmap, SPI_SR, spi_sr);
+			if (spi_sr & SPI_SR_CMDTCF)
+				break;
+		}
+		if (!tries) {
+			err = -ETIMEDOUT;
 			break;
-	} while (--tries);
-
-	if (!tries)
-		return -ETIMEDOUT;
+		}
+	} while (dspi_rxtx(dspi));
 
-	return dspi_rxtx(dspi);
+	return err;
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
@@ -1029,7 +1038,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == 0)
+	if (dspi_rxtx(dspi) == false)
 		complete(&dspi->xfer_done);
 
 	return IRQ_HANDLED;
@@ -1137,9 +1146,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
 			} else {
-				do {
-					status = dspi_poll(dspi);
-				} while (status == -EINPROGRESS);
+				status = dspi_poll(dspi);
 			}
 		}
 		if (status)

-- 
2.34.1


