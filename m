Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221ABE0B42
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 20:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfJVSQA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 14:16:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJVSQA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 14:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Yv5Rf6773kgbuxkZQgRTlciGCWHnegrhIPS59yOD8K8=; b=dfy/t5v+imJ9
        eLBHv+YLZgqe/Syw30NGbBrkyfsmcOIGZHNEcuedray4XEsB5/8gfeLMxZjrddSujIOMdn6xd02Ae
        T7+sG1ZodPDVDXaWi8vLYuIkFK7X9ZbSepPxFEr8RSUkcfDt5B0JhcPRzpyzOpGckrUMt7924ys8T
        daQoM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMyhG-0007Cl-6d; Tue, 22 Oct 2019 18:15:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AE4E32743267; Tue, 22 Oct 2019 19:15:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Raymond Tan <raymond.tan@intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw-pci: Add runtime power management support" to the spi tree
In-Reply-To: <20191018132131.31608-2-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191022181553.AE4E32743267@ypsilon.sirena.org.uk>
Date:   Tue, 22 Oct 2019 19:15:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw-pci: Add runtime power management support

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

From c8169580e924a1d2821e0a2e228c674e0eaa091f Mon Sep 17 00:00:00 2001
From: Raymond Tan <raymond.tan@intel.com>
Date: Fri, 18 Oct 2019 16:21:30 +0300
Subject: [PATCH] spi: dw-pci: Add runtime power management support

Implement pm_runtime hooks at pci driver.

Signed-off-by: Raymond Tan <raymond.tan@intel.com>
[jarkko.nikula@linux.intel.com: Forward ported on top of
commit 1e6959832510 ("spi: dw: Add basic runtime PM support")]
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20191018132131.31608-2-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 7ab53f4d04b9..1cddecea2715 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -7,6 +7,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
@@ -101,6 +102,11 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev_info(&pdev->dev, "found PCI SPI controller(ID: %04x:%04x)\n",
 		pdev->vendor, pdev->device);
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 }
 
@@ -108,6 +114,9 @@ static void spi_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_spi *dws = pci_get_drvdata(pdev);
 
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
 	dw_spi_remove_host(dws);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.20.1

