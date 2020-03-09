Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99F17E2E1
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCIO5A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 10:57:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43784 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgCIO4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 10:56:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so11565216wrf.10;
        Mon, 09 Mar 2020 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9It42JoL20skqRkI5j9y4r/Giqz57EYyG+vfEpvMVp8=;
        b=PlXgD85Ips+3IYQFRe324ZfVwf0gmTHyhfToMz4I2XBE79G/29A6iucOTz2SHS0gm0
         yLe0LzSt4IisYWaMan7+8+DY6ub+iUAmQkjXDTnC+H6wh13E0beXrCCEN+2b5Q15EkIK
         77swfxg9GTs8W4wxyTOTeUIjvmAbZX4NvBm+CbOi7eeIFXuX4DhxvnN6vATDDIu9Zkpi
         QeCWD9BTP0vQrcDbGjkakk5N4fdtEGMmmXkxrUMTIlxPMFIVhfG58pouB72395Izy+x/
         u2s5Jc80iA3mXmoTWJTGb7YWdIhPhcQxTv2Q8KUH1JVSJxJqBeUCRHfJMcqfqh8F5Zhr
         q1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9It42JoL20skqRkI5j9y4r/Giqz57EYyG+vfEpvMVp8=;
        b=HjSA2C5xpgH3iEU9V3G5X8q2lPLc5mVeu3rjjtElQI0YX2h3hq6L/XwwwRX7lRnBtv
         qg8hWuR7r4COerCutu1hWkRT2dEMPZNOwMTKRWa6OBYDSOXqrENVJMDNsyNCymAfb5HU
         01qJA8hyODIBPmZL4xYt6LzmKmkzqG99sHXMvX7XH6cEgZ2ycUFcjDE7KfN16qiAE33R
         /zYeGLTxp/B3L4QbtxpTehFSAglfrBlg7aGD+XjtKvdjvAbBeCe9hl9fo6DMIAERwuE5
         hzxiqIY1XdUCCBc9SvB4hvd9pqNgH5sJBAAqDXtCRwTqHSKT+Ox8S446jJnkuX0R2Qo0
         YAag==
X-Gm-Message-State: ANhLgQ0D0wJ2/a2G1gbzCBE2TOSohwlKI7k2L3nuA1Qfaunjl4n7B6hJ
        zQnnLgGUb14zT2G+dazf4VU=
X-Google-Smtp-Source: ADFU+vsqx4YoYfIDRSPmImTqY1TPy1OnrqlfsuDCaS2OIhXGDbuCyb5JSwnmPp8Is5TD/eq9fATseA==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr23096451wrq.153.1583765804461;
        Mon, 09 Mar 2020 07:56:44 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id w22sm26905374wmk.34.2020.03.09.07.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:43 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH 4/6] spi: spi-fsl-dspi: Add support for LS1028A
Date:   Mon,  9 Mar 2020 16:56:22 +0200
Message-Id: <20200309145624.10026-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is similar to the DSPI instantiation on LS1028A, except that:
 - The A-011218 erratum has been fixed, so DMA works
 - The endianness is different, which has implications on XSPI mode

Some benchmarking with the following command:

spidev_test --device /dev/spidev2.0 --bpw 8 --size 256 --cpha --iter 10000000 --speed 20000000

shows that in DMA mode, it can achieve around 2400 kbps, and in XSPI
mode, the same command goes up to 4700 kbps. This is somewhat to be
expected, since the DMA buffer size is extremely small at 8 bytes, the
winner becomes whomever can prepare the buffers for transmission
quicker, and DMA mode has higher overhead there. So XSPI FIFO mode has
been chosen as the operating mode for this chip.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5624b9ee77db..264d184e7296 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -131,6 +131,7 @@ struct fsl_dspi_devtype_data {
 enum {
 	LS1021A,
 	LS1012A,
+	LS1028A,
 	LS1043A,
 	LS1046A,
 	LS2080A,
@@ -163,6 +164,14 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.pushr_cmd		= 0,
 		.pushr_tx		= 2,
 	},
+	[LS1028A] = {
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
+		.max_clock_factor	= 8,
+		.fifo_size		= 4,
+		.pushr_cmd		= 2,
+		.pushr_tx		= 0,
+	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
@@ -1113,6 +1122,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
 	}, {
 		.compatible = "fsl,ls1012a-dspi",
 		.data = &devtype_data[LS1012A],
+	}, {
+		.compatible = "fsl,ls1028a-dspi",
+		.data = &devtype_data[LS1028A],
 	}, {
 		.compatible = "fsl,ls1043a-dspi",
 		.data = &devtype_data[LS1043A],
-- 
2.17.1

