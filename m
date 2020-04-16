Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC28E1ABB58
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502095AbgDPIeV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 04:34:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50600 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502388AbgDPId7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 04:33:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F2744200C15;
        Thu, 16 Apr 2020 10:33:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EFA9200C00;
        Thu, 16 Apr 2020 10:33:14 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2A0E740307;
        Thu, 16 Apr 2020 16:33:10 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     broonie@kernel.org, boris.brezillon@collabora.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <Ashish.kumar@nxp.com>
Subject: [PATCH] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times AHB buffer size
Date:   Thu, 16 Apr 2020 14:03:04 +0530
Message-Id: <1587025984-5696-1-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Reduce devm_ioremap size to (4 * AHB_BUFER_SIZE) rather than mapping
complete QSPI-Memmory as driver is now independent of flash size.
Flash of any size can be accessed.

Issue was reported on platform where devm_ioremap failure is observed
with size > 256M.
Error log on LS1021ATWR :
 fsl-quadspi 1550000.spi: ioremap failed for resource [mem 0x40000000-0x7fffffff]
 fsl-quadspi 1550000.spi: Freescale QuadSPI probe failed
 fsl-quadspi: probe of 1550000.spi failed with error -12

This change was also suggested previously:
https://patchwork.kernel.org/patch/10508753/#22166385

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <Ashish.kumar@nxp.com>
---
 drivers/spi/spi-fsl-qspi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 63c9f7e..a41ce81 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -859,14 +859,15 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					"QuadSPI-memory");
-	q->ahb_addr = devm_ioremap_resource(dev, res);
+	q->memmap_phy = res->start;
+	/* Since there are 4 CS max MAP required is 4 time ahb_buf_size */
+	q->ahb_addr = devm_ioremap(dev, q->memmap_phy,
+				   (q->devtype_data->ahb_buf_size * 4));
 	if (IS_ERR(q->ahb_addr)) {
 		ret = PTR_ERR(q->ahb_addr);
 		goto err_put_ctrl;
 	}
 
-	q->memmap_phy = res->start;
-
 	/* find the clocks */
 	q->clk_en = devm_clk_get(dev, "qspi_en");
 	if (IS_ERR(q->clk_en)) {
@@ -939,6 +940,9 @@ static int fsl_qspi_remove(struct platform_device *pdev)
 
 	mutex_destroy(&q->lock);
 
+	if (q->ahb_addr)
+		devm_iounmap(q->dev, q->ahb_addr);
+
 	return 0;
 }
 
-- 
2.7.4

