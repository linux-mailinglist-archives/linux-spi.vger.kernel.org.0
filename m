Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5018929D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCRARV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41400 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgCRARU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id f11so11315567wrp.8;
        Tue, 17 Mar 2020 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dbvFXr++MU/HIreOWScTU6cmRztuJ1BeSWU0vX/lVDQ=;
        b=dHeui0iFI86MShMTkkkK4yVQ4udUyV54/uCPA9EgN/FntTBiJX7K5n1WmXzwuAHiTb
         ia6L1qvLCph71EEc7P3YgRiwbdAygv6dD+q4NSoY744vx6nj0X7cgNwCocfm7is57jNV
         Vu5KCj49OtJGOZWR5/WhagN5ufcZ+yC6wFTOxp0/DnlW9y7VPGB9NvBdL6z0d62b1lB7
         Z+mgUD2IYjM6W6acMuR51So4538e3xWJ7e5W0BBvEpNMtQg+En3T42wiJFgOKC9Yen3S
         P16BYfpLtXGaTEyzJcj9A17gpIBMrH4DMNShV+lqOWIv5ookfWhXMex3MEQ7HCyuUmiL
         Q3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dbvFXr++MU/HIreOWScTU6cmRztuJ1BeSWU0vX/lVDQ=;
        b=Xdr1TT8Ct6ahw+qF7qpYTDcWvRnQpaGdeoU9Y24YqJjXuCIf1MzW9oFsvuIEpljXvy
         V8G3aOF9JTpTxGXoYSnZIHAoCpAO2uzzWODnbC85kAip4Oveobvmwmun1szz8L2QiQe9
         Jf06qaOHP3oTpJEHlsm5kzii2L2363zW87p+VJFzdfa4o1ekv86sg/pxTvtPSLr3fRRy
         LZ5iNMGfm7Yv0KjVIHVF8fmw8hHDJC8EHhGNXRUdW/xu2G9M9gP35uUQfopM9O0mAl65
         OVD5o05itf09y8osRCxOnpBaTCA1z4LRod9fftlAVHvqyZalFXQs/2IIAAAHMbw31UTf
         0Ytg==
X-Gm-Message-State: ANhLgQ0lO2bBik+T4sC3937+3zeCLfJ6Jd41fZvDED6u/j//ozrfWySi
        GCvAK9zwmaHAurBGWPeoMLM=
X-Google-Smtp-Source: ADFU+vsn9i0us/0rHexiF9zR35isGlBBbO5WaP4lsV3v8HW+nsk58CiPOoYGHF22BzU3fKDChWVczw==
X-Received: by 2002:adf:df04:: with SMTP id y4mr1595978wrl.318.1584490639120;
        Tue, 17 Mar 2020 17:17:19 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:18 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 09/12] spi: spi-fsl-dspi: Move invariant configs out of dspi_transfer_one_message
Date:   Wed, 18 Mar 2020 02:16:00 +0200
Message-Id: <20200318001603.9650-10-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The operating mode (DMA, XSPI, EOQ) is not going to change across the
lifetime of the device. So it makes no sense to keep writing to SPI_RSER
on each message. Move this configuration to dspi_init instead.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
None.

Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 55 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index fcc6f20b6631..5873752a091e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -900,7 +900,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
-	enum dspi_trans_mode trans_mode;
 	struct spi_transfer *transfer;
 	int status = 0;
 
@@ -942,30 +941,11 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
 
-		trans_mode = dspi->devtype_data->trans_mode;
-		switch (trans_mode) {
-		case DSPI_EOQ_MODE:
-			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-			dspi_fifo_write(dspi);
-			break;
-		case DSPI_XSPI_MODE:
-			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_CMDTCFE);
-			dspi_fifo_write(dspi);
-			break;
-		case DSPI_DMA_MODE:
-			regmap_write(dspi->regmap, SPI_RSER,
-				     SPI_RSER_TFFFE | SPI_RSER_TFFFD |
-				     SPI_RSER_RFDFE | SPI_RSER_RFDFD);
+		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
-			break;
-		default:
-			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-				trans_mode);
-			status = -EINVAL;
-			goto out;
-		}
+		} else {
+			dspi_fifo_write(dspi);
 
-		if (trans_mode != DSPI_DMA_MODE) {
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
 				reinit_completion(&dspi->xfer_done);
@@ -975,11 +955,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				} while (status == -EINPROGRESS);
 			}
 		}
+		if (status)
+			break;
 
 		spi_transfer_delay_exec(transfer);
 	}
 
-out:
 	message->status = status;
 	spi_finalize_current_message(ctlr);
 
@@ -1170,7 +1151,7 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 	},
 };
 
-static void dspi_init(struct fsl_dspi *dspi)
+static int dspi_init(struct fsl_dspi *dspi)
 {
 	unsigned int mcr;
 
@@ -1184,6 +1165,26 @@ static void dspi_init(struct fsl_dspi *dspi)
 
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+
+	switch (dspi->devtype_data->trans_mode) {
+	case DSPI_EOQ_MODE:
+		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
+		break;
+	case DSPI_XSPI_MODE:
+		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_CMDTCFE);
+		break;
+	case DSPI_DMA_MODE:
+		regmap_write(dspi->regmap, SPI_RSER,
+			     SPI_RSER_TFFFE | SPI_RSER_TFFFD |
+			     SPI_RSER_RFDFE | SPI_RSER_RFDFD);
+		break;
+	default:
+		dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
+			dspi->devtype_data->trans_mode);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int dspi_slave_abort(struct spi_master *master)
@@ -1339,7 +1340,9 @@ static int dspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_ctlr_put;
 
-	dspi_init(dspi);
+	ret = dspi_init(dspi);
+	if (ret)
+		goto out_clk_put;
 
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
-- 
2.17.1

