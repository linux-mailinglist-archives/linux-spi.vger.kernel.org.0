Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95E5C2EAE
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfJAIOJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 04:14:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:64493 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfJAIOJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Oct 2019 04:14:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 01:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205021987"
Received: from pipin.fi.intel.com ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2019 01:14:07 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH] SPI: designware: pci: Switch over to MSI interrupts
Date:   Tue,  1 Oct 2019 11:14:05 +0300
Message-Id: <20191001081405.764161-1-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some devices support MSI interrupts. Let's at least try to use them in
platforms that provide MSI capability.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/spi/spi-dw-pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 140644913e6c..7ab53f4d04b9 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -57,13 +57,18 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Get basic io resource and map it */
 	dws->paddr = pci_resource_start(pdev, pci_bar);
+	pci_set_master(pdev);
 
 	ret = pcim_iomap_regions(pdev, 1 << pci_bar, pci_name(pdev));
 	if (ret)
 		return ret;
 
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
 	dws->regs = pcim_iomap_table(pdev)[pci_bar];
-	dws->irq = pdev->irq;
+	dws->irq = pci_irq_vector(pdev, 0);
 
 	/*
 	 * Specific handling for platforms, like dma setup,
@@ -80,12 +85,15 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				return ret;
 		}
 	} else {
+		pci_free_irq_vectors(pdev);
 		return -ENODEV;
 	}
 
 	ret = dw_spi_add_host(&pdev->dev, dws);
-	if (ret)
+	if (ret) {
+		pci_free_irq_vectors(pdev);
 		return ret;
+	}
 
 	/* PCI hook and SPI hook use the same drv data */
 	pci_set_drvdata(pdev, dws);
@@ -101,6 +109,7 @@ static void spi_pci_remove(struct pci_dev *pdev)
 	struct dw_spi *dws = pci_get_drvdata(pdev);
 
 	dw_spi_remove_host(dws);
+	pci_free_irq_vectors(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.23.0

