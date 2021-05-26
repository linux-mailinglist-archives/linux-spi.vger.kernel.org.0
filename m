Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED0391C07
	for <lists+linux-spi@lfdr.de>; Wed, 26 May 2021 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhEZPcX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 May 2021 11:32:23 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58452 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232692AbhEZPcW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 May 2021 11:32:22 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QFRH2U024026;
        Wed, 26 May 2021 17:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=8aMVxx7/anGHC80AZ2C2O3wr2dBJMnXa01oHuLKGtjk=;
 b=Ievr84DvLzxiIUVDTC0Xbw3dZyNF/XTGfN/PWm9L/aGyG9vkGOzcygECR9/G920bHazJ
 bU/ts5sT14Q4B4NN9odIwfVsDNKUQrfcjAkkg1KWi5bx+CpVbbJbynIEtXcLtXdK6uks
 Yhft4ADY1shXCJlx0UOfzwvwUnWf2BmDcYwM5XUIf5pnzFNU9p3yapLd/xERaxCOzu9I
 r4a1Zf/xmbmFa+ZEITJfVAZWjZedsId+v0nVWXiZlr0be/L8E8MWVfl8WAwI/tS9tP5h
 aZUymn3+XeYEKQMu+wMsOgvoDJb+NSwgFVQ1uNl1/dsDPu/9XVqfLKHkjmybXXSdLram ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38skxvht99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 17:30:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5318F10002A;
        Wed, 26 May 2021 17:30:32 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag2node6.st.com [10.75.127.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 292AF231DC0;
        Wed, 26 May 2021 17:30:32 +0200 (CEST)
Received: from localhost (10.75.127.51) by GPXDAG2NODE6.st.com (10.75.127.70)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May 2021 17:30:31
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, <christophe.kerello@foss.st.com>
Subject: mtd: spinand: add spi nand mtd resume handler
Date:   Wed, 26 May 2021 17:30:16 +0200
Message-ID: <20210526153016.32653-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To GPXDAG2NODE6.st.com
 (10.75.127.70)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_10:2021-05-26,2021-05-26 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Christophe Kerello <christophe.kerello@foss.st.com>

After power up, all SPI NAND's blocks are locked. Only read operations
are allowed, write and erase operations are forbidden.
The SPI NAND framework unlocks all the blocks during its initialization.

During a standby low power, the memory is powered down, losing its
configuration.
During the resume, the QSPI driver state is restored but the SPI NAND
framework does not reconfigured the memory.

This patch adds spi nand mtd PM handlers for resume ops.
SPI NAND resume op re-initializes SPI NAND flash to its probed state.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/mtd/nand/spi/core.c | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17f63f95f4a2..6abaf874eb3f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1074,6 +1074,61 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
+static void spinand_mtd_resume(struct mtd_info *mtd)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct device *dev = &spinand->spimem->spi->dev;
+	int ret, i;
+
+	ret = spinand_reset_op(spinand);
+	if (ret)
+		return;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the quad part (err = %d)\n",
+			ret);
+		return;
+	}
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret) {
+		dev_err(dev,
+			"Failed to updtae the OTP (err = %d)\n",
+			ret);
+		return;
+	}
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret) {
+			dev_err(dev,
+				"Failed to select the target (err = %d)\n",
+				ret);
+			return;
+		}
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret) {
+			dev_err(dev,
+				"Failed to unlock block (err = %d)\n",
+				ret);
+			return;
+		}
+	}
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
@@ -1167,6 +1222,7 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
+	mtd->_resume = spinand_mtd_resume;
 
 	if (nand->ecc.engine) {
 		ret = mtd_ooblayout_count_freebytes(mtd);
-- 
2.17.1

