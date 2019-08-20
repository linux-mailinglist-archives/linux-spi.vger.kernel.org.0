Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AE95F9E
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfHTNOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:30 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:34419 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfHTNO3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:29 -0400
Received: by mail-wr1-f97.google.com with SMTP id s18so12376341wrn.1
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=l0DxKrx0/IputRk8veRqmiM9Kjp17scTU7E7vNHMac4=;
        b=CPf4hjLaQi6qlsxvNfiZ/bH+tPt2O+UDh700KaH9kcyk+kWOcIZ1Ee99rGTCTVQZwM
         Le7eKaUpuhAji9Sl4/2PVEuWWzsZVxsi9M9Ouc8TILTZrg4OKJqQpKKlVrHcEXuI4CBi
         nBocxcqXEnYSB1bC+oHsehIwrZ+N84EOKWmanR+LXQf+dhw73+nGmRFIAgwJcklWLSAY
         PinJ6qtZ2MfTOdtq8nBCci/CiNzaKJwlE6eRgIwHzoVg44AZlRqcCvfPlog8GfjBaYqp
         pP6McVyU4Re/zAbGvGDHBF58lvWjCAKfJdQgoBiGJWh5MC1tqlSCZ9cGkbmlQDdbneOs
         vY+A==
X-Gm-Message-State: APjAAAWMzr5UJWxOF980nxReliALtbpfgS7msS58A1BmU6/3RQAr9bMZ
        gfZTPjP7QtCoafA6XfHsnyYcYa7T9+PEqmShDi8SRnBViaEit/Y1XBeNrkhP7EMr/g==
X-Google-Smtp-Source: APXvYqxLwjo2HuD0LGkMZbZd9RkrcY9df6vR/NkS6MFrql1GkdrsA5gNK0YhyIvbD0AHyanXE8jIOtspSO5K
X-Received: by 2002:a5d:6446:: with SMTP id d6mr33144150wrw.159.1566306866942;
        Tue, 20 Aug 2019 06:14:26 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id l2sm355857wrm.9.2019.08.20.06.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:26 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xy-0002Lg-Mh; Tue, 20 Aug 2019 13:14:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1BDA72742ABD; Tue, 20 Aug 2019 14:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Move dspi_interrupt above dspi_transfer_one_message" to the spi tree
In-Reply-To: <20190818180115.31114-13-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131426.1BDA72742ABD@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:26 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Move dspi_interrupt above dspi_transfer_one_message

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a63af99f0d0d1c0992736f1aaf9e3b42bee0e2b8 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:13 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Move dspi_interrupt above
 dspi_transfer_one_message

The two functions are loosely coupled through dspi->waitq, but
logically, dspi_transfer_one_message depends on dspi_interrupt in order
to complete. Move its definition above it so the I/O functions are
grouped closer together.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-13-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 114 ++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6128c695d06f..790cb02fc181 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -647,6 +647,63 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 		dspi_push_rx(dspi, fifo_read(dspi));
 }
 
+static irqreturn_t dspi_interrupt(int irq, void *dev_id)
+{
+	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	struct spi_message *msg = dspi->cur_msg;
+	enum dspi_trans_mode trans_mode;
+	u32 spi_sr, spi_tcr;
+	u16 spi_tcnt;
+
+	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+	regmap_write(dspi->regmap, SPI_SR, spi_sr);
+
+
+	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
+		/* Get transfer counter (in number of SPI transfers). It was
+		 * reset to 0 when transfer(s) were started.
+		 */
+		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
+		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
+		/* Update total number of bytes that were transferred */
+		msg->actual_length += spi_tcnt * dspi->bytes_per_word;
+
+		trans_mode = dspi->devtype_data->trans_mode;
+		switch (trans_mode) {
+		case DSPI_EOQ_MODE:
+			dspi_eoq_read(dspi);
+			break;
+		case DSPI_TCFQ_MODE:
+			dspi_tcfq_read(dspi);
+			break;
+		default:
+			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
+				trans_mode);
+				return IRQ_HANDLED;
+		}
+
+		if (!dspi->len) {
+			dspi->waitflags = 1;
+			wake_up_interruptible(&dspi->waitq);
+		} else {
+			switch (trans_mode) {
+			case DSPI_EOQ_MODE:
+				dspi_eoq_write(dspi);
+				break;
+			case DSPI_TCFQ_MODE:
+				dspi_tcfq_write(dspi);
+				break;
+			default:
+				dev_err(&dspi->pdev->dev,
+					"unsupported trans_mode %u\n",
+					trans_mode);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				     struct spi_message *message)
 {
@@ -825,63 +882,6 @@ static void dspi_cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static irqreturn_t dspi_interrupt(int irq, void *dev_id)
-{
-	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
-	struct spi_message *msg = dspi->cur_msg;
-	enum dspi_trans_mode trans_mode;
-	u32 spi_sr, spi_tcr;
-	u16 spi_tcnt;
-
-	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-	regmap_write(dspi->regmap, SPI_SR, spi_sr);
-
-
-	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
-		/* Get transfer counter (in number of SPI transfers). It was
-		 * reset to 0 when transfer(s) were started.
-		 */
-		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
-		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
-		/* Update total number of bytes that were transferred */
-		msg->actual_length += spi_tcnt * dspi->bytes_per_word;
-
-		trans_mode = dspi->devtype_data->trans_mode;
-		switch (trans_mode) {
-		case DSPI_EOQ_MODE:
-			dspi_eoq_read(dspi);
-			break;
-		case DSPI_TCFQ_MODE:
-			dspi_tcfq_read(dspi);
-			break;
-		default:
-			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-				trans_mode);
-				return IRQ_HANDLED;
-		}
-
-		if (!dspi->len) {
-			dspi->waitflags = 1;
-			wake_up_interruptible(&dspi->waitq);
-		} else {
-			switch (trans_mode) {
-			case DSPI_EOQ_MODE:
-				dspi_eoq_write(dspi);
-				break;
-			case DSPI_TCFQ_MODE:
-				dspi_tcfq_write(dspi);
-				break;
-			default:
-				dev_err(&dspi->pdev->dev,
-					"unsupported trans_mode %u\n",
-					trans_mode);
-			}
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
 static const struct of_device_id fsl_dspi_dt_ids[] = {
 	{ .compatible = "fsl,vf610-dspi", .data = &vf610_data, },
 	{ .compatible = "fsl,ls1021a-v1.0-dspi", .data = &ls1021a_v1_data, },
-- 
2.20.1

