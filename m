Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BB18579D
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 02:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgCOBmc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 21:42:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34612 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCOBmc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 21:42:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id x3so10629079wmj.1;
        Sat, 14 Mar 2020 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCcq62XmObdxi4G8Ng0Ls4FTL8TP/twoB+5fYYk3P6A=;
        b=VMu2JY0xNk+X8BsL7I8b+jBKfBHYjMxqc6uwmMI6yJo8U29URiGKImDk8/8QpAmQFG
         099ywS5MIjGP2Gz7Yd3HTrYZc5NVPgAc/FPMBTGowafNdRpR0c/v6sB0n9sQEejRX1A9
         HmgxOUBA2BOknB4Rg88nlq11SsZJGNzgXDUepGmRmM7WjqkPx5bixo3NtUPQDRP7D8Vd
         b/yawaVyTpVVugTD36GJcfncluBps/JIyz+RIAjqfT64hF0vn9gjwKHu30FLvTe1CA3F
         yDYxe0tmgHU8qhS5YZ4AcR0oYpnd7nVI1gQaLl7fZKAiW9zJSyxLBhU4gbllyOej6r8F
         Q5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SCcq62XmObdxi4G8Ng0Ls4FTL8TP/twoB+5fYYk3P6A=;
        b=V1EHZI9YvdOCwmipwxr6DLOXXhYc15OWuAIDkFvESOgb369658H3eOINoco2T347Qn
         /xQb2tsgzWRyJ0p00bD0PoARrObGMbB65UV2bHOECAMg5TQ8Q2pt9L9lli0fjIOPFuyN
         w5S6mFqLpRyeDr8+CTifuupt91z3T51qMf2GJXRn/cFFYm7/2R3/eQpbM/35hcthgJ6J
         wdurIZELrI0/LhIUGRPEYLrwczZsJjqDyabw+eqFqKN0F6u4H0PsUy9HObQIlf5kaf+P
         HIPnnv/Cn08cRHoUZlxyGNHFfkpxWkAlX1bCT4D4hQSulynH3EFxg0a96iAoX6zEKjfF
         qwvQ==
X-Gm-Message-State: ANhLgQ1ha4a3RIiba0YScPvMNE5DXsJWjnxEtQgmdegSS0Jh2DsHtz6E
        Sz2In2p94Alyh5paaHTv4b88lRlybI8=
X-Google-Smtp-Source: ADFU+vtbU9ZG0AcQljb0XSyZcJgTeWtPD9mfx34wOnZw3pwoXdlDqQeUzcLLEmVa9U3XMxD+XdIl/A==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr17818569wma.98.1584225848847;
        Sat, 14 Mar 2020 15:44:08 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:08 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 09/12] spi: spi-fsl-dspi: Move invariant configs out of dspi_transfer_one_message
Date:   Sun, 15 Mar 2020 00:43:37 +0200
Message-Id: <20200314224340.1544-10-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
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
Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 55 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index eab4929330e1..86255d38ffcf 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -909,7 +909,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
-	enum dspi_trans_mode trans_mode;
 	struct spi_transfer *transfer;
 	int status = 0;
 
@@ -951,30 +950,11 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
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
@@ -984,11 +964,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
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
 
@@ -1179,7 +1160,7 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 	},
 };
 
-static void dspi_init(struct fsl_dspi *dspi)
+static int dspi_init(struct fsl_dspi *dspi)
 {
 	unsigned int mcr;
 
@@ -1193,6 +1174,26 @@ static void dspi_init(struct fsl_dspi *dspi)
 
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
@@ -1348,7 +1349,9 @@ static int dspi_probe(struct platform_device *pdev)
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

