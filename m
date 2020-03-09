Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53E717EADE
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCIVJF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:09:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgCIVIu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 17:08:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so9250243wrd.0;
        Mon, 09 Mar 2020 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zJ+BhiqzAPedLjVQEzNhhBhXg2/bvt9dVT7qP5vBemU=;
        b=ZiEzEQt6vNy+N4xNVB0KXZJU7owNHZYL5iP87LNrU8MvE1L93LDbVteZFUUFkz5kSE
         QfocY0uE0Q7u06YabklbBZ9GbcSv3TvMKqFJP2/KYqEbBVYXr/Yy02UoCdZBWpOkYemt
         vnyLnrqf3oellAbEestRNziCKKocxorHa43xDD6OsRe+T0wAmQB2Iri72glzamGxu9uU
         C7nTePcqtuE+UC11YZx0n+ydax2oWM0gH6Wv7N3++3zCEmMirLpaKtnS4MCGvj6lpDbD
         LTlDv4z7181BIL9A7znAy0fX9/4ZD93+gv50RInZ/kmFCLEmdiga/orVpklqT45rW91T
         J6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zJ+BhiqzAPedLjVQEzNhhBhXg2/bvt9dVT7qP5vBemU=;
        b=j78tEXQJ9QdgRkgF0FIeIQvNk4jwrUEWfmpr9KQuDkas9B3K7/32ybA/Dn2OqhmoWn
         7u8FY2HPHsT59lTxZaqEqPXqBJP7vTe+YhpTL/S+iptZmrqu3UT81Lc04W6O8/YtMn+C
         TNgt64yE61epSS7j+KG37d2BUzZtmzEKzZ2dk5eSqqPipghsnKtEVGuP9arJOIicXCZC
         K8uDfNgsoArxfhaOwb0DsPQJTktwwSCLwnNpQgGVlJ3LKwKgpQv4g8BVHT/YoazIixxG
         Lvnprz8zm3U6I74hL5KYVX4lpI7+NAz5LjpuzbBVk5YT6dkZOjuqPt+BxmI7uIfg3Mij
         NKgg==
X-Gm-Message-State: ANhLgQ1kyat/b5lpEsgzO9CxqK0BlTbpZFfP80J+IOVYmf63mhwp76fY
        l4B/vzTB0omntn0waT+M3oE=
X-Google-Smtp-Source: ADFU+vv04R9WwYrPLPQl3d9L/uANpvTzTdjm3jAsbSVEfMlurizTxdPXVYyjejTHnjhKeW0qne7jJw==
X-Received: by 2002:a5d:61c9:: with SMTP id q9mr10749218wrv.164.1583788128740;
        Mon, 09 Mar 2020 14:08:48 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j205sm1016275wma.42.2020.03.09.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:08:48 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v2 4/6] spi: spi-fsl-dspi: Add support for LS1028A
Date:   Mon,  9 Mar 2020 23:07:53 +0200
Message-Id: <20200309210755.6759-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
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
Changes in v2:
Switch to DSPI_XSPI_MODE.

 drivers/spi/spi-fsl-dspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 43d2d9fc8b92..cf8a141bbaf2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -125,6 +125,7 @@ struct fsl_dspi_devtype_data {
 enum {
 	LS1021A,
 	LS1012A,
+	LS1028A,
 	LS1043A,
 	LS1046A,
 	LS2080A,
@@ -153,6 +154,12 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
 	},
+	[LS1028A] = {
+		.trans_mode		= DSPI_XSPI_MODE,
+		.dma_bufsize		= 8,
+		.max_clock_factor	= 8,
+		.fifo_size		= 4,
+	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
@@ -1100,6 +1107,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
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

