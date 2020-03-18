Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE01892BE
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCRAR6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51302 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgCRARL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id c187so18176wme.1;
        Tue, 17 Mar 2020 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pE6LjR29iwQf7D7RlG7d25qJJWFx3m2e6HQhVoX16AY=;
        b=Oq350yYdRqcZoUIYFTMtYKriySyDk2r83F7XAZna+/BNzTaoUFmeBpLsVWHCK5O7fm
         2cwUAa3dCAZbr9rQK8gV7p7WRYwiGP5Osw39oImS3PEr4RL/AXeDf289CQNQ3fFP8CcN
         cD1N9KGwmhz+1067jVRAw1eHgwNbnZBwzxw0BWeV5/7sZ9CblzkwvkfEiqfyRddfVOmC
         ADv9QaYagVJyGvwp3pR5BHBlLQUMtK/61BD87Juhk8G9BKH9BTkG3WX5dws9VgXjyMxs
         tB7Fh6pSGDUBk8YV9/2FXaSb30XlpsvHm6xJTlXJldbBVsZlAiS1tF0lHBp15ScTuL8/
         odoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pE6LjR29iwQf7D7RlG7d25qJJWFx3m2e6HQhVoX16AY=;
        b=HMYMC2UueQkvQdK6P6xSVitfMm0jYytdI19V8eTu/jWbtUD/8Dc8z8TBs9+FReOhxq
         Yz9/yOMpwRjywHRcgCjWEAESt2uY4EuKoVlEtckO1d1F3a6I62QUzFAYaCsNrKIzCUsD
         A7Li+9TLyaDi6t7ciul5Of55ClbApgHYgJH9wxW7hmffJMw0tObfxo2l+ReGo1pwBAch
         02QF1+I/8SZ1nKuMmgfkUkChHDgJvn2Pwn/Q/rrXJOebhrGLewNSwOnUurqRBe+MWDk5
         TpFPUoq9iYegbCE4vutSYk5alCRQzcgrUU6iiTjpgrEjmLEgE5TMtwm7C2fn7GuAKxlM
         ssjg==
X-Gm-Message-State: ANhLgQ3jKN30Opb5CRZrm5k1aXMoexLFCNCjK2m24s6KzxeGpxJVs97J
        iiTkTP4tc2yfA3wSZNTqXYA=
X-Google-Smtp-Source: ADFU+vtZK5FtJiMPU4xFtis1grhOnhh8z5/n3TB5GJ3/bsDZWnoQsfVvYFUJLe8SFtyTi8q75VqjEg==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr1510919wmc.53.1584490629614;
        Tue, 17 Mar 2020 17:17:09 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:09 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 02/12] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
Date:   Wed, 18 Mar 2020 02:15:53 +0200
Message-Id: <20200318001603.9650-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In XSPI mode, the 32-bit PUSHR register can be written to separately:
the higher 16 bits are for commands and the lower 16 bits are for data.

This has nicely been hacked around, by defining a second regmap with a
width of 16 bits, and effectively splitting a 32-bit register into 2
16-bit ones, from the perspective of this regmap_pushr.

The problem is the assumption about the controller's endianness. If the
controller is little endian (such as anything post-LS1046A), then the
first 2 bytes, in the order imposed by memory layout, will actually hold
the TXDATA, and the last 2 bytes will hold the CMD.

So take the controller's endianness into account when performing split
writes to PUSHR. The obvious and simple solution would have been to call
regmap_get_val_endian(), but that is an internal regmap function and we
don't want to change regmap just for this. Therefore, we just re-read
the "big-endian" device tree property.

Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode registers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
None.

Changes in v4:
None.

Changes in v3:
None.

Changes in v2:
Parse "big-endian" device tree bindings instead of taking the decision
based on compatible SoC.

 drivers/spi/spi-fsl-dspi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ca35881881b..be717776dd98 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -103,10 +103,6 @@
 #define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
 #define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
 
-/* Register offsets for regmap_pushr */
-#define PUSHR_CMD			0x0
-#define PUSHR_TX			0x2
-
 #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
 
 struct chip_data {
@@ -240,6 +236,13 @@ struct fsl_dspi {
 
 	int					words_in_flight;
 
+	/*
+	 * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
+	 * individually (in XSPI mode)
+	 */
+	int					pushr_cmd;
+	int					pushr_tx;
+
 	void (*host_to_dev)(struct fsl_dspi *dspi, u32 *txdata);
 	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
@@ -673,12 +676,12 @@ static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
 	 */
 	if (dspi->len > dspi->oper_word_size)
 		cmd |= SPI_PUSHR_CMD_CONT;
-	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
+	regmap_write(dspi->regmap_pushr, dspi->pushr_cmd, cmd);
 }
 
 static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 {
-	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
+	regmap_write(dspi->regmap_pushr, dspi->pushr_tx, txdata);
 }
 
 static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
@@ -1259,6 +1262,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
+	bool big_endian;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
@@ -1284,6 +1288,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 		/* Only Coldfire uses platform data */
 		dspi->devtype_data = &devtype_data[MCF5441X];
+		big_endian = true;
 	} else {
 
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
@@ -1305,6 +1310,15 @@ static int dspi_probe(struct platform_device *pdev)
 			ret = -EFAULT;
 			goto out_ctlr_put;
 		}
+
+		big_endian = of_device_is_big_endian(np);
+	}
+	if (big_endian) {
+		dspi->pushr_cmd = 0;
+		dspi->pushr_tx = 2;
+	} else {
+		dspi->pushr_cmd = 2;
+		dspi->pushr_tx = 0;
 	}
 
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-- 
2.17.1

