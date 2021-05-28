Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688133943FF
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhE1OSn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 10:18:43 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56069 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235999AbhE1OSl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 10:18:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SE8M54030904;
        Fri, 28 May 2021 16:16:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=e2cWYJoOM9ZBMvGbPSWfnuuYTOko3MHHZmgI0RkE1mk=;
 b=YoP/+4tehpzuKz1U1l0yEb3hbVIo85uwdU4WK1nkc4/0EqTAae4FL7JqAmWfLHsNRs/w
 0lmNhU7tGwAKmr1mYOd1b85geK9eRzIImrUc1nZJyzZwCdKyNeM25nZxsVJSGOQkDGYz
 CH0OdBkCm4j9LOtQarlu8Oe/+lZe9BbUwrBT+kQtIEbV9KUKJocRVJAQo7rliHD+HPwb
 iG2NNQpujqGjd6I8KRA5XxRdr+08cbF4R5GKCGzAe7LDTmfwFz2GD2LVVhNrYyWbpNuq
 CNNu0V0dAsTbnjsFzyqoY7BsokODOyA6MQtiHrIh+bg1XlKSwffhFibLWlY0GCrfnsN8 zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38tsq0jxba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 16:16:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D15BC100034;
        Fri, 28 May 2021 16:16:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0EE4231DC0;
        Fri, 28 May 2021 16:16:53 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May 2021 16:16:53
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
        <linux-kernel@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
CC:     <patrice.chotard@foss.st.com>, <christophe.kerello@foss.st.com>
Subject: [PATCH v4 3/3] mtd: spinand: add SPI-NAND MTD resume handler
Date:   Fri, 28 May 2021 16:16:39 +0200
Message-ID: <20210528141639.3194-4-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528141639.3194-1-patrice.chotard@foss.st.com>
References: <20210528141639.3194-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

After power up, all SPI NAND's blocks are locked. Only read operations
are allowed, write and erase operations are forbidden.
The SPI NAND framework unlocks all the blocks during its initialization.

During a standby low power, the memory is powered down, losing its
configuration.
During the resume, the QSPI driver state is restored but the SPI NAND
framework does not reconfigured the memory.

This patch adds SPI-NAND MTD PM handlers for resume ops.
SPI NAND resume op re-initializes SPI NAND flash to its probed state.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v4:
  - Call spinand_init_flash() helper in spinand_mtd_resume()

Changes in v3:
  - Add spinand_read_cfg() call to repopulate cache

Changes in v2:
  - Add helper spinand_block_unlock().
  - Add spinand_ecc_enable() call.
  - Remove some dev_err().
  - Fix commit's title and message.

 drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 58945f0ae839..e108e6176f64 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1121,6 +1121,26 @@ static int spinand_init_flash(struct spinand_device *spinand)
 	return ret;
 }
 
+static void spinand_mtd_resume(struct mtd_info *mtd)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	ret = spinand_reset_op(spinand);
+	if (ret)
+		return;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return;
+
+	ret = spinand_init_flash(spinand);
+	if (ret)
+		return;
+
+	spinand_ecc_enable(spinand, false);
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
@@ -1191,6 +1211,7 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
+	mtd->_resume = spinand_mtd_resume;
 
 	if (nand->ecc.engine) {
 		ret = mtd_ooblayout_count_freebytes(mtd);
-- 
2.17.1

