Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D729217EACD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgCIVIt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:08:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40842 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVIs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 17:08:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id p2so12242660wrw.7;
        Mon, 09 Mar 2020 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzyAiqo4rFDPCZ0tgI6VRMILwWz+jZH78kexviER6Rk=;
        b=XEjDDu7cGa+PfMYkKG7e3ZzBQx83G9i/1pY8jzvtASfMqVQHe8L/iQM+9lkxSGbCuG
         C6FMqn+c6zOIOPWEduxT6u3b4780kfZBkxBG8VrbrpIbiDJgUVqMTqx1gl6YK1dIspOH
         BAxjJCmRx0uav71mBPwEO3iYK5ezP7EsQg+DHLDqTHz8pYYSwUQbSiJxLrTXaMec3N0Z
         frrBqcxs+xoaY2mVXdYctkPg0iUpjdYjOUe7vdgOh/RYS/lSh4Yw23TzknOgFYfsOPN9
         8J3URcvX2ktGTMrqK0tRbeVrEuN1sz8GHkKrQ1pQ4PqD0yrWu5RBMunc/gjjh+yjI9Nv
         IR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GzyAiqo4rFDPCZ0tgI6VRMILwWz+jZH78kexviER6Rk=;
        b=A/FGAo2kX8fC8J/WNnH2f0eKeArRkdEA5spS9GBYxqMJ1m80KoRUkpJTu5Rlsymoge
         bAJC6E9f1LfSG0svNZSCe9poyRbhhzt1Ga4Qnew1pcWHesmT/xQAJ7NtkOv4/oiySRNI
         MrNQR8DwrQP7oAYbLFYpKjQj+2xd77OI4cVD40cm+pwkVbypriocSLqLJJjmF9oPPYRP
         5BkDzIccTWeZInc1vfizgKDFqCriXgPlS01KndZRbcTZqGTiZhpui9d8tZZe/KHYAW3N
         OhSc12ftNOV/NA7J4mAP5LsBi6q92jQuGuu59wFGrk3TGFGFts0YQqrVcZUAC65c4tNa
         tvcA==
X-Gm-Message-State: ANhLgQ1C4XnX92VpBEXFALd9EUi5EyWVaXxMmr9aF8HrMywFieK8ISDL
        xBGljA+FK9pCukeGMkCSvDg=
X-Google-Smtp-Source: ADFU+vuM3Rjr1Ncf4MMecDXYLwy+kESuLdkVVfVLus90/bUuAkgv1pfn1b+W8RekoJuB1121gqdk5A==
X-Received: by 2002:a5d:4902:: with SMTP id x2mr24327896wrq.301.1583788126003;
        Mon, 09 Mar 2020 14:08:46 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j205sm1016275wma.42.2020.03.09.14.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:08:45 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v2 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
Date:   Mon,  9 Mar 2020 23:07:51 +0200
Message-Id: <20200309210755.6759-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
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
Changes in v2:
Parse "big-endian" device tree bindings instead of taking the decision
based on compatible SoC.

 drivers/spi/spi-fsl-dspi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0ce26c1cbf62..0483abd403a4 100644
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
@@ -1256,6 +1259,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
+	bool big_endian;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
@@ -1281,6 +1285,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 		/* Only Coldfire uses platform data */
 		dspi->devtype_data = &devtype_data[MCF5441X];
+		big_endian = true;
 	} else {
 
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
@@ -1302,6 +1307,15 @@ static int dspi_probe(struct platform_device *pdev)
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

