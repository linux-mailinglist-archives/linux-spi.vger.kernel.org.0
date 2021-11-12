Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622A244EE2E
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 21:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhKLU6N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 15:58:13 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:58656 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbhKLU6L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 15:58:11 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] spi: dw: Add Synopsys Component version reading and parsing
Date:   Fri, 12 Nov 2021 23:49:27 +0300
Message-ID: <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Each Synopsys DWC SSI controller is equipped with a Synopsys Component
version register, which encodes a version ID of an IP-core the
controller has been synthesized from. That can be useful in future for the
version-based conditional features implementation in the driver.

Note the component version is encoded as an ASCII string so we need to
convert it from the string to a normal unsigned integer to be easily used
then in the driver statements.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 18 ++++++++++++++++++
 drivers/spi/spi-dw.h      |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index b4cbcd38eaba..1766a29ca790 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -823,6 +823,24 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
 	dw_spi_reset_chip(dws);
 
+	/*
+	 * Retrieve the Synopsys component version if it hasn't been specified
+	 * by the platform. Note the CoreKit version ID is encoded as a 4bytes
+	 * ASCII string enclosed with '*' symbol.
+	 */
+	if (!dws->ver) {
+		u32 comp;
+
+		comp = dw_readl(dws, DW_SPI_VERSION);
+		dws->ver = (DW_SPI_GET_BYTE(comp, 3) - '0') * 100;
+		dws->ver += (DW_SPI_GET_BYTE(comp, 2) - '0') * 10;
+		dws->ver += (DW_SPI_GET_BYTE(comp, 1) - '0');
+
+		dev_dbg(dev, "Synopsys DWC%sSSI v%u.%02u\n",
+			(dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB ",
+			dws->ver / 100, dws->ver % 100);
+	}
+
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 634085eadad1..d06857d8d173 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -149,6 +149,7 @@ struct dw_spi {
 	u32			max_mem_freq;	/* max mem-ops bus freq */
 	u32			max_freq;	/* max bus freq supported */
 
+	u32			ver;		/* Synopsys component version */
 	u32			caps;		/* DW SPI capabilities */
 
 	u32			reg_io_width;	/* DR I/O width in bytes */
-- 
2.33.0

