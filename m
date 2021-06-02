Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D43985A8
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFBJv5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 05:51:57 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41119 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhFBJv4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 05:51:56 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1529n522004242;
        Wed, 2 Jun 2021 11:49:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=4MpjjPepkAf6oswplCRTLXvRI7dGZbjRiu8c2yrCFoo=;
 b=6OMaEyYdQGUVqMMvoySbAoiSw5GOCbJlRz3K01Ihz5pvTAK/3Gm1w3uCJZm7d84qV9NW
 RrsdOZCqLrMye1kLvnXuQZ+E8PjkXPohAKifMgD9WykSrHP5K7j50M8oHA7VsknQewny
 WqrFWbHuknFy1FEOlb/j4lJ358qHejQ81OVs6HGf0C1teDVA7UuBAQvJIP0zd65K4UGJ
 c9xS+5eiTz/RYG3C2YG4Q/H7PlCAQNgBaZzxoeoni8Fji6qYRWtlmGP1mT/uzFsPor8S
 yprbZszaxK5mUsWtlaa1l3S2NAwh3ZhhAd+j6vPWIBq9seH9RSNducWs+ZbKs8QMkNIm Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38x3gxmkpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 11:49:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC584100039;
        Wed,  2 Jun 2021 11:49:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BEF02216ED7;
        Wed,  2 Jun 2021 11:49:56 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun 2021 11:49:56
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
Subject: [PATCH v5 3/3] mtd: spinand: add SPI-NAND MTD resume handler
Date:   Wed, 2 Jun 2021 11:49:13 +0200
Message-ID: <20210602094913.26472-4-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602094913.26472-1-patrice.chotard@foss.st.com>
References: <20210602094913.26472-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_05:2021-06-02,2021-06-02 signatures=0
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
Changes in v5: 
  - Remove spinand_read_cfg() from spinand_mtd_resume() as it is now called in 
    spinand_init_flash()

Changes in v4:
  - Call spinand_init_flash() helper in spinand_mtd_resume()

Changes in v3:
  - Add spinand_read_cfg() call to repopulate cache

Changes in v2:
  - Add helper spinand_block_unlock().
  - Add spinand_ecc_enable() call.
  - Remove some dev_err().
  - Fix commit's title and message.

 drivers/mtd/nand/spi/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 12dfa75eec28..13fd2f74b4f1 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1124,6 +1124,22 @@ static int spinand_init_flash(struct spinand_device *spinand)
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
@@ -1194,6 +1210,7 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
+	mtd->_resume = spinand_mtd_resume;
 
 	if (nand->ecc.engine) {
 		ret = mtd_ooblayout_count_freebytes(mtd);
-- 
2.17.1

