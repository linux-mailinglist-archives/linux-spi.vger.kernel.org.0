Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994D03943FA
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhE1OSi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 10:18:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:30828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235690AbhE1OSh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 10:18:37 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SE8SMl001078;
        Fri, 28 May 2021 16:16:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Y7cT7lR60/u2v1bJVpqCfbs2Y7uM07+3yB1me2zWmVI=;
 b=fBYBqhUOgdLJ+K4TgFlh8h2q/aMiq8Wy0HBr+edSwp36H0jEZNjkUMFByjOw0DfTqwfZ
 jT1Ylz3GMgbb+GZ34ZJMcUHj6n8996s4tCy78IQnAXI9nZV1wS5ubOnI82LrKp5utvjH
 65guM6ucEAxIpuTT974pCMSpwGFzBzwxirmTrn/Pjn1w8D9ttPrH2mIwrd2WdJIrNfca
 NsTAlc5Nk/xG4L0oXyRaLaFVvmcBJMYgX0lgApQFoInyTlufrvX+ags/AoKlIE6UgV1v
 oV9dYDBWyuJkTolsEn93PGYnTh+1FeJFaSWrBNS2ZWd8/D9Yft8BcWCcndbO4SaOX7n4 xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38u03c0mjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 16:16:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70AE8100034;
        Fri, 28 May 2021 16:16:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 619A2231DC0;
        Fri, 28 May 2021 16:16:52 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May 2021 16:16:52
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
Subject: [PATCH v4 1/3] mtd: spinand: Add spinand_init_flash() helper
Date:   Fri, 28 May 2021 16:16:37 +0200
Message-ID: <20210528141639.3194-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528141639.3194-1-patrice.chotard@foss.st.com>
References: <20210528141639.3194-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add spinand_init_flash() helper which implements
all needed init for future SPI-NAND resume ops.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/mtd/nand/spi/core.c | 66 +++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17f63f95f4a2..1f39a38fbf69 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1074,12 +1074,51 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct device *dev = &spinand->spimem->spi->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+		"Failed to initialize the SPI NAND chip (err = %d)\n",
+		ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1112,22 +1151,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
 		dev_err(dev,
@@ -1136,17 +1163,6 @@ static int spinand_init(struct spinand_device *spinand)
 		goto err_manuf_cleanup;
 	}
 
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
-- 
2.17.1

