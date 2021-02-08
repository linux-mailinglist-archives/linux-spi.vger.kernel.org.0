Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576E43139BC
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 17:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhBHQk2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 11:40:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:10499 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhBHQkI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Feb 2021 11:40:08 -0500
IronPort-SDR: SiHSw9G8RGo58QINDyyRRzpq0nEgHib/SvgmetM5ZB7Q88tTXzc7CynSpPiIk5nmIBfR2nHzCi
 4bpKfpKbu7nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="160895247"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="160895247"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:38:19 -0800
IronPort-SDR: iJaR3OREElV383mgVYVCOBys+SCt5Gy3RMReQNWMWospPOYW1OQ0Sk7ujuG2WBVRe6UeTNY3Rc
 arBe0O8Q/F3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="411108099"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2021 08:38:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 453A2E7; Mon,  8 Feb 2021 18:38:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>
Subject: [PATCH v1 1/2] spi: pxa2xx: Fix the controller numbering for Wildcat Point
Date:   Mon,  8 Feb 2021 18:38:15 +0200
Message-Id: <20210208163816.22147-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Wildcat Point has two SPI controllers and added one is actually second one.
Fix the numbering by adding the description of the first one.

Fixes: caba248db286 ("spi: spi-pxa2xx-pci: Add ID and driver type for WildcatPoint PCH")
Cc: Leif Liddy <leif.liddy@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index f236e3034cf8..aafac128bb5f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -21,7 +21,8 @@ enum {
 	PORT_BSW1,
 	PORT_BSW2,
 	PORT_CE4100,
-	PORT_LPT,
+	PORT_LPT0,
+	PORT_LPT1,
 };
 
 struct pxa_spi_info {
@@ -57,8 +58,10 @@ static struct dw_dma_slave bsw1_rx_param = { .src_id = 7 };
 static struct dw_dma_slave bsw2_tx_param = { .dst_id = 8 };
 static struct dw_dma_slave bsw2_rx_param = { .src_id = 9 };
 
-static struct dw_dma_slave lpt_tx_param = { .dst_id = 0 };
-static struct dw_dma_slave lpt_rx_param = { .src_id = 1 };
+static struct dw_dma_slave lpt1_tx_param = { .dst_id = 0 };
+static struct dw_dma_slave lpt1_rx_param = { .src_id = 1 };
+static struct dw_dma_slave lpt0_tx_param = { .dst_id = 2 };
+static struct dw_dma_slave lpt0_rx_param = { .src_id = 3 };
 
 static bool lpss_dma_filter(struct dma_chan *chan, void *param)
 {
@@ -185,12 +188,19 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.num_chipselect = 1,
 		.max_clk_rate = 50000000,
 	},
-	[PORT_LPT] = {
+	[PORT_LPT0] = {
 		.type = LPSS_LPT_SSP,
 		.port_id = 0,
 		.setup = lpss_spi_setup,
-		.tx_param = &lpt_tx_param,
-		.rx_param = &lpt_rx_param,
+		.tx_param = &lpt0_tx_param,
+		.rx_param = &lpt0_rx_param,
+	},
+	[PORT_LPT1] = {
+		.type = LPSS_LPT_SSP,
+		.port_id = 1,
+		.setup = lpss_spi_setup,
+		.tx_param = &lpt1_tx_param,
+		.rx_param = &lpt1_rx_param,
 	},
 };
 
@@ -285,8 +295,9 @@ static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
 	{ PCI_VDEVICE(INTEL, 0x2290), PORT_BSW1 },
 	{ PCI_VDEVICE(INTEL, 0x22ac), PORT_BSW2 },
 	{ PCI_VDEVICE(INTEL, 0x2e6a), PORT_CE4100 },
-	{ PCI_VDEVICE(INTEL, 0x9ce6), PORT_LPT },
-	{ },
+	{ PCI_VDEVICE(INTEL, 0x9ce5), PORT_LPT0 },
+	{ PCI_VDEVICE(INTEL, 0x9ce6), PORT_LPT1 },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pxa2xx_spi_pci_devices);
 
-- 
2.30.0

