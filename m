Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBBBDE9C9
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2019 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfJUKgo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Oct 2019 06:36:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:61641 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbfJUKg3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Oct 2019 06:36:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 03:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="191069664"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2019 03:36:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E63CF1A1; Mon, 21 Oct 2019 13:36:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: pxa2xx: Introduce temporary variables to increase readability
Date:   Mon, 21 Oct 2019 13:36:24 +0300
Message-Id: <20191021103625.4250-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The current conditional for PCI ID matching is hard to read.
Introduce couple of temporary variables to increase readability
of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0390053ed8f5..02daba3dbd0d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1516,13 +1516,14 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct pxa2xx_spi_controller *pdata;
 	struct ssp_device *ssp;
 	struct resource *res;
+	struct device *parent = pdev->dev.parent;
+	struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
 	const struct pci_device_id *pcidev_id = NULL;
 	enum pxa_ssp_type type;
 	const void *match;
 
-	if (dev_is_pci(pdev->dev.parent))
-		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
-					 to_pci_dev(pdev->dev.parent));
+	if (pcidev)
+		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match)
@@ -1549,8 +1550,8 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 #ifdef CONFIG_PCI
 	if (pcidev_id) {
-		pdata->tx_param = pdev->dev.parent;
-		pdata->rx_param = pdev->dev.parent;
+		pdata->tx_param = parent;
+		pdata->rx_param = parent;
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
 #endif
-- 
2.23.0

