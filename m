Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC65C3F1C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfJAR5F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 13:57:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52168 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbfJAR5E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 13:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5evgdi+hKJNNIVg+JL95Ig6MYbcR//o/SL1HYubNOpE=; b=mB3/bkwuwbZW
        FTzCeQuKI6lIgjo2NTA4xUpnS3NVBjPxS5tZ2QBhJQ8M9r9DY7SeYEevamR2tHiIhtuvvjrxQxbPo
        gD5z/ax9hkzCOnoI1+1++8i8I43zWDUqlj8EjXa9o4EwRV8nSV1F/vVSVitsaMCT1gGNNX+AG5fhw
        IXotI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFMOT-0005v3-FA; Tue, 01 Oct 2019 17:57:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EB5F227429C0; Tue,  1 Oct 2019 18:57:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "SPI: designware: pci: Switch over to MSI interrupts" to the spi tree
In-Reply-To: <20191001081405.764161-1-felipe.balbi@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001175700.EB5F227429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 18:57:00 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   SPI: designware: pci: Switch over to MSI interrupts

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 8f5c285f3ef5ab3c7cf5288d63bdaa3549be2118 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@linux.intel.com>
Date: Tue, 1 Oct 2019 11:14:05 +0300
Subject: [PATCH] SPI: designware: pci: Switch over to MSI interrupts

Some devices support MSI interrupts. Let's at least try to use them in
platforms that provide MSI capability.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Link: https://lore.kernel.org/r/20191001081405.764161-1-felipe.balbi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

