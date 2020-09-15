Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77F269B02
	for <lists+linux-spi@lfdr.de>; Tue, 15 Sep 2020 03:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgIOBZW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 21:25:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbgIOBZW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 21:25:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2241AC5E87EC4329AD58;
        Tue, 15 Sep 2020 09:25:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 09:25:10 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <linux-spi@vger.kernel.org>, <linuxarm@huawei.com>
CC:     <broonie@kernel.org>, <felipe.balbi@linux.intel.com>,
        <huangdaode@huawei.com>
Subject: [PATCH] spi: dw-pci: free previously allocated IRQs if desc->setup() fails
Date:   Tue, 15 Sep 2020 09:22:49 +0800
Message-ID: <1600132969-53037-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Free previously allocated IRQs when return an error code of desc->setup()
which is not always successful. And simplify the code by adding a goto
label.

Fixes: 8f5c285f3ef5 ("SPI: designware: pci: Switch over to MSI interrupts")
CC: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-dw-pci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 2ea7380..271839a 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -127,18 +127,16 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (desc->setup) {
 			ret = desc->setup(dws);
 			if (ret)
-				return ret;
+				goto err_free_irq_vectors;
 		}
 	} else {
-		pci_free_irq_vectors(pdev);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_free_irq_vectors;
 	}
 
 	ret = dw_spi_add_host(&pdev->dev, dws);
-	if (ret) {
-		pci_free_irq_vectors(pdev);
-		return ret;
-	}
+	if (ret)
+		goto err_free_irq_vectors;
 
 	/* PCI hook and SPI hook use the same drv data */
 	pci_set_drvdata(pdev, dws);
@@ -152,6 +150,10 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pm_runtime_allow(&pdev->dev);
 
 	return 0;
+
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
+	return ret;
 }
 
 static void spi_pci_remove(struct pci_dev *pdev)
-- 
2.7.4

