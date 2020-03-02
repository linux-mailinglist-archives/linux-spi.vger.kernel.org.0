Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1D175152
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 01:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBAUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Mar 2020 19:20:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46425 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgCBAUO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Mar 2020 19:20:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so10260630wrp.13;
        Sun, 01 Mar 2020 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q/4hkXZDf7Y1E5NQ67SwQKMTujilQp/qfoqcDOmzaLU=;
        b=GNHTZs2ukLki4SQaZBCE/FutoDq8Fsii4TzuX4EujqDccxF0ZRgw445Zdr9QPhShfL
         C12xjV1YT2qaDiQXNBDfN9xWemQm336RFisfkdBm4Y/JwzJ8woxeaw/qoowoK6hj6A9J
         cDMQROwtd0CXcQw0MlULvGgdTg0UTJX0+qGPIu8ufwTV2xoUc8oj/1exzTFS3Lq+QwuY
         br8MFpHAWI5js4z5VC5kMVf0QWWjl9N+yctolxd+HuyLMCPYFDylxyvFJOGZm3ZJ/48W
         E04lSuWKhzYD9x5eizt7YPBTsnHgb+x1cMB0Zg/Kiy7m7e/XfONc2b2qOfOFF5PlsZnr
         MQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q/4hkXZDf7Y1E5NQ67SwQKMTujilQp/qfoqcDOmzaLU=;
        b=r1zUxAOTkLLQQ0cW7+Nsu5LU17DV6Z2AUjEn1Fb3ieS9FRyxCsO5OzWyE1a7fxYBNc
         FYIJ7QbpgiVkmHrz22/YCzFa2ERj1If/dPGYOTY8xMB/K5+Sg4qtisVYHXdXo6brf2Zq
         lsvWKvuayr3QYZzBYwx3vLQEfMJXWp+QqWMff75GABbTAJdhzxJKFLKycXqvXPDqcviz
         OjlQmSoPk39IQIv5cYM+kiV5LLETDnsjvIltnBra0XH+LoqeBAv7jjFVZM4QfHZ+kkRK
         vNPMPU5XTWO/jWERa1q2eFBhfw5omN6EDKRgsWaYz+U0t9qJcQIOT0yL14xgI1K3A1c8
         i4+w==
X-Gm-Message-State: APjAAAU/VgU/cxp5PqriAusN+64zdnmOpCCkhOGaS7f6tah0ABam9Pkd
        ++PXh8DV8WCbO0V5lxyew9OgksMc
X-Google-Smtp-Source: APXvYqxlhEO85aDLHrHAVDprxv1+3m5IUtOFLygycpVgyj4wi+Amnfr1rKl4h7KNy/bEnhX7rrExXw==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr19159284wro.357.1583108411767;
        Sun, 01 Mar 2020 16:20:11 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id k16sm25428417wrd.17.2020.03.01.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:20:11 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] spi: spi-fsl-dspi: Use specific compatible strings for all SoC instantiations
Date:   Mon,  2 Mar 2020 02:19:54 +0200
Message-Id: <20200302001958.11105-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Currently, the device tree bindings submitted in mainline for Layerscape
SoCs look like this:

LS1021A:
compatible = "fsl,ls1021a-v1.0-dspi";

LS1012A:
compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";

LS2085A:
compatible = "fsl,ls2085a-dspi";

LS2088A:
compatible = "fsl,ls2080a-dspi", "fsl,ls2085a-dspi";

LX2160A:
compatible = "fsl,lx2160a-dspi", "fsl,ls2085a-dspi";

LS1043A:
compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";

LS1046A:
compatible = "fsl,ls1021a-v1.0-dspi";

Due to a lack of a more specific compatible string, LS1012A, LS1043A and
LS1046A will fall under the LS1021A umbrella, and LS2088A and LX2160A
under the LS2085A umbrella.

They do work in those modes, but there are slight differences in the
hardware instantiations, mostly related to FIFO sizes (with the more
specific compatible strings, the FIFO size can be increased properly).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 108 +++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ec2dcb8c57a..021c658886d4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -133,27 +133,66 @@ struct fsl_dspi_devtype_data {
 	bool			xspi_mode;
 };
 
-static const struct fsl_dspi_devtype_data vf610_data = {
-	.trans_mode		= DSPI_DMA_MODE,
-	.max_clock_factor	= 2,
+enum {
+	LS1021A,
+	LS1012A,
+	LS1043A,
+	LS1046A,
+	LS2080A,
+	LS2085A,
+	LX2160A,
+	MCF5441X,
+	VF610,
 };
 
-static const struct fsl_dspi_devtype_data ls1021a_v1_data = {
-	.trans_mode		= DSPI_TCFQ_MODE,
-	.max_clock_factor	= 8,
-	.ptp_sts_supported	= true,
-	.xspi_mode		= true,
-};
-
-static const struct fsl_dspi_devtype_data ls2085a_data = {
-	.trans_mode		= DSPI_TCFQ_MODE,
-	.max_clock_factor	= 8,
-	.ptp_sts_supported	= true,
-};
-
-static const struct fsl_dspi_devtype_data coldfire_data = {
-	.trans_mode		= DSPI_EOQ_MODE,
-	.max_clock_factor	= 8,
+static const struct fsl_dspi_devtype_data devtype_data[] = {
+	[VF610] = {
+		.trans_mode		= DSPI_DMA_MODE,
+		.max_clock_factor	= 2,
+	},
+	[LS1021A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS1012A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS1043A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS1046A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS2080A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+	},
+	[LS2085A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+	},
+	[LX2160A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+	},
+	[MCF5441X] = {
+		.trans_mode		= DSPI_EOQ_MODE,
+		.max_clock_factor	= 8,
+	},
 };
 
 struct fsl_dspi_dma {
@@ -909,9 +948,31 @@ static void dspi_cleanup(struct spi_device *spi)
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {
-	{ .compatible = "fsl,vf610-dspi", .data = &vf610_data, },
-	{ .compatible = "fsl,ls1021a-v1.0-dspi", .data = &ls1021a_v1_data, },
-	{ .compatible = "fsl,ls2085a-dspi", .data = &ls2085a_data, },
+	{
+		.compatible = "fsl,vf610-dspi",
+		.data = &devtype_data[VF610],
+	}, {
+		.compatible = "fsl,ls1021a-v1.0-dspi",
+		.data = &devtype_data[LS1021A],
+	}, {
+		.compatible = "fsl,ls1012a-dspi",
+		.data = &devtype_data[LS1012A],
+	}, {
+		.compatible = "fsl,ls1043a-dspi",
+		.data = &devtype_data[LS1043A],
+	}, {
+		.compatible = "fsl,ls1046a-dspi",
+		.data = &devtype_data[LS1046A],
+	}, {
+		.compatible = "fsl,ls2080a-dspi",
+		.data = &devtype_data[LS2080A],
+	}, {
+		.compatible = "fsl,ls2085a-dspi",
+		.data = &devtype_data[LS2085A],
+	}, {
+		.compatible = "fsl,lx2160a-dspi",
+		.data = &devtype_data[LX2160A],
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
@@ -1064,7 +1125,8 @@ static int dspi_probe(struct platform_device *pdev)
 		ctlr->num_chipselect = pdata->cs_num;
 		ctlr->bus_num = pdata->bus_num;
 
-		dspi->devtype_data = &coldfire_data;
+		/* Only Coldfire uses platform data */
+		dspi->devtype_data = &devtype_data[MCF5441X];
 	} else {
 
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
-- 
2.17.1

