Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB891F6074
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFKD26 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:28:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:28223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgFKD26 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:28:58 -0400
IronPort-SDR: ZMf0c3i+/FVFmC/H3yGBHfRPTNEasHUcM41IeihDRJdQZFqLzaBLq+Sm8miTqhlkqrM2rZRirS
 x9JssBAAPiRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 20:28:58 -0700
IronPort-SDR: qler2OkVMHhjYOmbdsMSaMzd3jHEPQfEhKiD0ryoIRgmdsgzhkxLI59jNSCRDJqgsC4byTfBWs
 QPHa780vbyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="260587360"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2020 20:28:56 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH 3/6] spi: altera: add platform data for slave information.
Date:   Thu, 11 Jun 2020 11:25:08 +0800
Message-Id: <1591845911-10197-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch introduces platform data for slave information, it allows
spi-altera to add new spi devices once master registration is done.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/spi/spi-altera.c   | 11 +++++++++++
 include/linux/spi/altera.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index e6e6708..aa9d1a2 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -189,6 +189,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 	struct altera_spi *hw;
 	struct spi_master *master;
 	int err = -ENODEV;
+	u16 i;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct altera_spi));
 	if (!master)
@@ -244,6 +245,16 @@ static int altera_spi_probe(struct platform_device *pdev)
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err)
 		goto exit;
+
+	if (pdata) {
+		for (i = 0; i < pdata->num_devices; i++) {
+			if (!spi_new_device(master, pdata->devices + i))
+				dev_warn(&pdev->dev,
+					 "unable to create SPI device: %s\n",
+					 pdata->devices[i].modalias);
+		}
+	}
+
 	dev_info(&pdev->dev, "base %p, irq %d\n", hw->base, hw->irq);
 
 	return 0;
diff --git a/include/linux/spi/altera.h b/include/linux/spi/altera.h
index 344a3fc..2d42641 100644
--- a/include/linux/spi/altera.h
+++ b/include/linux/spi/altera.h
@@ -14,11 +14,16 @@
  * @mode_bits:		Mode bits of SPI master.
  * @num_chipselect:	Number of chipselects.
  * @bits_per_word_mask:	bitmask of supported bits_per_word for transfers.
+ * @num_devices:	Number of devices that shall be added when the driver
+ *			is probed.
+ * @devices:		The devices to add.
  */
 struct altera_spi_platform_data {
 	u16				mode_bits;
 	u16				num_chipselect;
 	u32				bits_per_word_mask;
+	u16				num_devices;
+	struct spi_board_info		*devices;
 };
 
 #endif /* __LINUX_SPI_ALTERA_H */
-- 
2.7.4

