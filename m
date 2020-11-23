Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83392BFE3F
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 03:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgKWCtM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Nov 2020 21:49:12 -0500
Received: from inva021.nxp.com ([92.121.34.21]:48846 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKWCtM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 22 Nov 2020 21:49:12 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 504EE20023B;
        Mon, 23 Nov 2020 03:49:10 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D3B12000C5;
        Mon, 23 Nov 2020 03:49:07 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 28100402A2;
        Mon, 23 Nov 2020 03:49:03 +0100 (CET)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Han Xu <han.xu@nxp.com>, Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] spi: spi-nxp-fspi: fix fspi panic by unexpected interrupts
Date:   Mon, 23 Nov 2020 10:57:15 +0800
Message-Id: <20201123025715.14635-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Given the case that bootloader(such as UEFI)'s FSPI driver might not
handle all interrupts before loading kernel, those legacy interrupts
would assert immidiately once kernel's FSPI driver enable them. Further,
if it was FSPI_INTR_IPCMDDONE, the irq handler nxp_fspi_irq_handler()
would call complete(&f->c) to notify others. However, f->c might not be
initialized yet at that time, then cause kernel panic.

Of cause, we should fix this issue within bootloader. But it would be
better to have this pacth to make dirver more robust (by clearing all
interrupt status bits before enabling interrupts).

Suggested-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0d41406..ab90356 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1001,6 +1001,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nxp_fspi *f;
 	int ret;
+	u32 reg;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*f));
 	if (!ctlr)
@@ -1032,6 +1033,12 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		goto err_put_ctrl;
 	}
 
+	/* Clear potential interrupts */
+	reg = fspi_readl(f, f->iobase + FSPI_INTR);
+	if (reg)
+		fspi_writel(f, reg, f->iobase + FSPI_INTR);
+
+
 	/* find the resources - controller memory mapped space */
 	if (is_acpi_node(f->dev->fwnode))
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
2.7.4

