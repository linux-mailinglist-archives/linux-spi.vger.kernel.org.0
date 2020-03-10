Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2617FD31
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgCJN0c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 09:26:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgCJMzz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:55:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id f7so1219834wml.4;
        Tue, 10 Mar 2020 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eye51bfkE9/qV/EV2Y4EKj2/U4peXuQX7hjQlFVP8Oc=;
        b=IzLPpzYROiHhqizrer4yzVs+NhyJRM3OrGMd2nr3JMXkBFlCWpqBEM/NjgC35RRxOe
         MKvG5Wbcxj7ZA7MHhamgUq5z/5VINRyPSXXqSQ38H0gWHkGmYgxPDXtLF8I4mcKep8dM
         B6/6Y2/L+GVdt7/FJnfT4dsMGa3JLzuJdP/PN061yQ/CjiwJJ+yvxvrsMaYk2K915GKX
         KUK0vgDduRS2th2VT1Yy/LDsY01alAYe2+9xh79JsEbbNay9FMKag4OGv/ZIJBNVJcEh
         Y0/IBVoj4GI5cIWsPJ9zsgxsZhH5GGfiABFpYPsx7LnYiB2+miwt2g7n3tEz6XULc2VX
         3hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eye51bfkE9/qV/EV2Y4EKj2/U4peXuQX7hjQlFVP8Oc=;
        b=hOOWBv/eeFHz7+MbA7Ac65xq7Rq9IaTf2DLbFq2NpOZgHwc974PgQHDBHGfe5SpDBb
         hriQduIj5GOpalZmxzGLWrhPiYprN+YuB9O8oyjyMAd9U7X3p3F7hgok2LDQHcaSzL78
         FizDiFOEP83qv1z5xXbSA1UqHjdE+doNryj0QPaLhxQZIQDcbBFtjwirsJgrEWPBr0Oe
         YvQXX/BTgztr0/4Q9AGkJUXkp5wUwyWXLxsrHXdOiNXMpBM0H49HbYjfaDKkJCb8144O
         gtnM922VDzoErHDmzCit2hiOdAR6BirV2ttnqjTOvLg3HMPjANh3iia5tANfsPFMCK0F
         ZWbw==
X-Gm-Message-State: ANhLgQ3pO3Yw5K+G9dmcrqv3hoxTU+KXraNoXU/u50x/rvvBu2BMB8Hy
        wsKfMOefZnnk3XVVrWQ0H90=
X-Google-Smtp-Source: ADFU+vvcibH0v44wC4R/rVbSFYvl3jAX8Vjyn9/Mv0Oj0BQz4tQHmJiyGvTC0W+B1mpgdTjTF9Mwbw==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr1957163wmf.50.1583844954158;
        Tue, 10 Mar 2020 05:55:54 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:55:53 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 3/7] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
Date:   Tue, 10 Mar 2020 14:55:38 +0200
Message-Id: <20200310125542.5939-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
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
Changes in v3:
None.

Changes in v2:
Parse "big-endian" device tree bindings instead of taking the decision
based on compatible SoC.

 drivers/spi/spi-fsl-dspi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f2ba0731aebe..c59b68592283 100644
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
@@ -670,12 +673,12 @@ static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
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
@@ -1269,6 +1272,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
+	bool big_endian;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
@@ -1294,6 +1298,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 		/* Only Coldfire uses platform data */
 		dspi->devtype_data = &devtype_data[MCF5441X];
+		big_endian = true;
 	} else {
 
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
@@ -1315,6 +1320,15 @@ static int dspi_probe(struct platform_device *pdev)
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

