Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2670B63F64
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfGJClX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jul 2019 22:41:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51666 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfGJClW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Jul 2019 22:41:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 03AA01A0E4E;
        Wed, 10 Jul 2019 04:41:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 878951A00E6;
        Wed, 10 Jul 2019 04:41:16 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EE46B402D3;
        Wed, 10 Jul 2019 10:41:11 +0800 (SGT)
From:   han.xu@nxp.com
To:     han.xu@nxp.com, broonie@kernel.org, ashish.kumar@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB memory for FSPI
Date:   Wed, 10 Jul 2019 10:31:26 +0800
Message-Id: <20190710023128.13115-2-han.xu@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190710023128.13115-1-han.xu@nxp.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

dynamically alloc AHB memory for FSPI controller

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 8894f98cc99c..84edaca28e01 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -307,6 +307,7 @@
 
 #define POLL_TOUT		5000
 #define NXP_FSPI_MAX_CHIPSELECT		4
+#define NXP_FSPI_MIN_IOMAP	SZ_4M
 
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
@@ -329,6 +330,8 @@ struct nxp_fspi {
 	void __iomem *ahb_addr;
 	u32 memmap_phy;
 	u32 memmap_phy_size;
+	u32 memmap_start;
+	u32 memmap_len;
 	struct clk *clk, *clk_en;
 	struct device *dev;
 	struct completion c;
@@ -641,12 +644,34 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
 	f->selected = spi->chip_select;
 }
 
-static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
+static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
 {
+	u32 start = op->addr.val;
 	u32 len = op->data.nbytes;
 
+	/* if necessary, ioremap before AHB read */
+	if ((!f->ahb_addr) || start < f->memmap_start ||
+	    start + len > f->memmap_start + f->memmap_len) {
+		if (f->ahb_addr)
+			iounmap(f->ahb_addr);
+
+		f->memmap_start = start;
+		f->memmap_len = len > NXP_FSPI_MIN_IOMAP ?
+				len : NXP_FSPI_MIN_IOMAP;
+
+		f->ahb_addr = ioremap_wc(f->memmap_phy + f->memmap_start,
+					 f->memmap_len);
+		if (!f->ahb_addr) {
+			dev_err(f->dev, "failed to alloc memory\n");
+			return -ENOMEM;
+		}
+	}
+
 	/* Read out the data directly from the AHB buffer. */
-	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
+	memcpy_fromio(op->data.buf.in,
+		      (f->ahb_addr + start - f->memmap_start), len);
+
+	return 0;
 }
 
 static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
@@ -806,7 +831,7 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 */
 	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
 	    op->data.dir == SPI_MEM_DATA_IN) {
-		nxp_fspi_read_ahb(f, op);
+		err = nxp_fspi_read_ahb(f, op);
 	} else {
 		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
 			nxp_fspi_fill_txfifo(f, op);
@@ -976,11 +1001,6 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
-	f->ahb_addr = devm_ioremap_resource(dev, res);
-	if (IS_ERR(f->ahb_addr)) {
-		ret = PTR_ERR(f->ahb_addr);
-		goto err_put_ctrl;
-	}
 
 	/* assign memory mapped starting address and mapped size. */
 	f->memmap_phy = res->start;
@@ -1059,6 +1079,9 @@ static int nxp_fspi_remove(struct platform_device *pdev)
 
 	mutex_destroy(&f->lock);
 
+	if (f->ahb_addr)
+		iounmap(f->ahb_addr);
+
 	return 0;
 }
 
-- 
2.17.1

