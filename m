Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D361F6079
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFKD24 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:28:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:28223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgFKD24 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:28:56 -0400
IronPort-SDR: yAVWG6uArEIqEXLfhdj+AZBwJExnH3JVYYdCAQ+6MLhY91lMvLeM29unytQB5Rm6n9TDWfRRVX
 6saXOFV3/bFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 20:28:55 -0700
IronPort-SDR: I3vKDi+zTPZ1IpJs8Ckbjzt0b9akZsbOPFzfT92EYJ0PtSu318RnKiOrUev50fBgtVUPF6bKgf
 UCH7R4emsgqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="260587353"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2020 20:28:53 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH 2/6] spi: altera: add SPI core parameters support via platform data.
Date:   Thu, 11 Jun 2020 11:25:07 +0800
Message-Id: <1591845911-10197-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch introduced SPI core parameters in platform data, it
allows passing these SPI core parameters via platform data.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/spi/spi-altera.c   | 25 ++++++++++++++++++++++---
 include/linux/spi/altera.h | 24 ++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/spi/altera.h

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index d5fa0c5..e6e6708 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spi/altera.h>
 #include <linux/spi/spi.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -40,6 +41,8 @@
 #define ALTERA_SPI_CONTROL_IE_MSK	0x100
 #define ALTERA_SPI_CONTROL_SSO_MSK	0x400
 
+#define ALTERA_SPI_MAX_CS		32
+
 struct altera_spi {
 	void __iomem *base;
 	int irq;
@@ -182,6 +185,7 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 
 static int altera_spi_probe(struct platform_device *pdev)
 {
+	struct altera_spi_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct altera_spi *hw;
 	struct spi_master *master;
 	int err = -ENODEV;
@@ -192,9 +196,24 @@ static int altera_spi_probe(struct platform_device *pdev)
 
 	/* setup the master state. */
 	master->bus_num = pdev->id;
-	master->num_chipselect = 16;
-	master->mode_bits = SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+
+	if (pdata) {
+		if (pdata->num_chipselect > ALTERA_SPI_MAX_CS) {
+			dev_err(&pdev->dev,
+				"Invalid number of chipselect: %hu\n",
+				pdata->num_chipselect);
+			return -EINVAL;
+		}
+
+		master->num_chipselect = pdata->num_chipselect;
+		master->mode_bits = pdata->mode_bits;
+		master->bits_per_word_mask = pdata->bits_per_word_mask;
+	} else {
+		master->num_chipselect = 16;
+		master->mode_bits = SPI_CS_HIGH;
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+	}
+
 	master->dev.of_node = pdev->dev.of_node;
 	master->transfer_one = altera_spi_txrx;
 	master->set_cs = altera_spi_set_cs;
diff --git a/include/linux/spi/altera.h b/include/linux/spi/altera.h
new file mode 100644
index 0000000..344a3fc
--- /dev/null
+++ b/include/linux/spi/altera.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header File for Altera SPI Driver.
+ */
+#ifndef __LINUX_SPI_ALTERA_H
+#define __LINUX_SPI_ALTERA_H
+
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+/**
+ * struct altera_spi_platform_data - Platform data of the Altera SPI driver
+ * @mode_bits:		Mode bits of SPI master.
+ * @num_chipselect:	Number of chipselects.
+ * @bits_per_word_mask:	bitmask of supported bits_per_word for transfers.
+ */
+struct altera_spi_platform_data {
+	u16				mode_bits;
+	u16				num_chipselect;
+	u32				bits_per_word_mask;
+};
+
+#endif /* __LINUX_SPI_ALTERA_H */
-- 
2.7.4

