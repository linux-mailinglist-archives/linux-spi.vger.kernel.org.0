Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D865D185911
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 03:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgCOCbO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 22:31:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36138 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgCOCbO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 22:31:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so14311144wme.1;
        Sat, 14 Mar 2020 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBLq+DVYQxDs8a8x/M0DoStKIVGMho+f5uexM3U5eEY=;
        b=leXggBwfI+U1mWn9FkJboIpHLw2O7MMsTzSZS+64xWyOc7KeCL+60U99o9EA1ZOS9r
         TSj5FrW+W2yycJdhgWvH4125L3H0s/YQOe5JR6a41E5kljCBg30DaO+etyRBRehHO3gd
         aFaIVKIIsufg/vipykTMARGle92PNXW8R5Rjkk3iS/AflBqQbQaE6kufHBiBF2qdgjP0
         8OFPu5rOdlRXq32GBpkAf5UQsHkGkGtsZBh8QjzR9XkprPDk0SvN6iRJK3DVjH/XXOms
         syZsOcE5IDKrwzFjiIsscgk1ZehZ40F0cy2NaJwgijxv/ipEyv/hvXAy8F7tVjl/XawB
         siEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBLq+DVYQxDs8a8x/M0DoStKIVGMho+f5uexM3U5eEY=;
        b=swWVusZ62otMBbZ1yb4vHuQeaD2bPde30rXin/qDolaVTW0X18u6E/VIgAVlmDSYJh
         f71jnbtfgTHN5O8lZVIBkLjTwtNsn/BgIGT8gzGXWJ+UL8pbqvvacdLBCmTzzPIaQRHL
         ca8LG8MydcTp/HMFKgmAgy9vOj2Bi95Crh/pTSAkn3SxBfNwOydxspabqrOtHimRuMxd
         2I2Uwb+/7NnBsnQ+JkCl10xBYSKmwL0v5h8ck+XNrjutYxJsCnM1z0Pph+VVU/BFS7Xh
         e1WnJmG54+rULx3ddh6yvMn9nVu2coo6eu8avoxND5K9bT9J1VQmuqZdpL0WJeWDZBJY
         d5rw==
X-Gm-Message-State: ANhLgQ3Sod/D/fyzkbx7azSTWanVEzeImgRwC76ZKs7HixZpx7XZAGbC
        ZgL/QHgCOlCACKrPTITnuPzb8dQVnW0=
X-Google-Smtp-Source: ADFU+vvfxGr4VcbjzdQ9Qc5anz+ZVnL17sKm3kWOf89+oaVzDiigT8qEB6jG10BXVSEFtxosOh6erQ==
X-Received: by 2002:a1c:a502:: with SMTP id o2mr17828001wme.94.1584225850211;
        Sat, 14 Mar 2020 15:44:10 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:09 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 10/12] spi: spi-fsl-dspi: Add support for LS1028A
Date:   Sun, 15 Mar 2020 00:43:38 +0200
Message-Id: <20200314224340.1544-11-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
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
Changes in v4:
None.

Changes in v3:
Removed the dma_bufsize variable (obsoleted by 03/12).

Changes in v2:
Switch to DSPI_XSPI_MODE.

 drivers/spi/spi-fsl-dspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 86255d38ffcf..b6d7e6f383ec 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -124,6 +124,7 @@ struct fsl_dspi_devtype_data {
 enum {
 	LS1021A,
 	LS1012A,
+	LS1028A,
 	LS1043A,
 	LS1046A,
 	LS2080A,
@@ -151,6 +152,11 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
 	},
+	[LS1028A] = {
+		.trans_mode		= DSPI_XSPI_MODE,
+		.max_clock_factor	= 8,
+		.fifo_size		= 4,
+	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
@@ -1059,6 +1065,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
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

