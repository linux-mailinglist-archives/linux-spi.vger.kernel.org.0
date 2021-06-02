Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E33985AB
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhFBJwE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 05:52:04 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:28168 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231180AbhFBJwA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 05:52:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1529n5Jp004208;
        Wed, 2 Jun 2021 11:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=+JE4eDYsaaeQPfaLLpxMMJhdocMLBplab8kjM60wCU0=;
 b=gP6SV2WWMmq8O5HCkpo/QrVJ+c31OYK7gAqlB5zxL46QHGtw7BOQPA0DKnbqec19oh++
 L2i3b0WcQXyK1hAB8ypogESY61Cf+upd6E6k7EcLP6J78c93HOA+9t2qVd5gc4p61zcw
 V+vr/+YIOnTCda4W8+/iU2yner0KuXJOS2cDeQLUfShVd0IVSM4dBUJEYCX6nlU34yW1
 bWLrzVqHoOFo4ZGdUTswg4twtJiZPXOC5UMxRU5kmKo/eAtiwKzTj3YoLwuSYfAsLp0O
 tqb7M3a6iA/dzPShSTs6XqUJYLYE8bNV6xufnfbvNu8oepEZMqnPnv4A2GO3kwBMRr8A Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38x3gxmkpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 11:49:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 163E4100038;
        Wed,  2 Jun 2021 11:49:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08076216ED9;
        Wed,  2 Jun 2021 11:49:56 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun 2021 11:49:55
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
Subject: [PATCH v5 2/3] mtd: spinand: Add spinand_init_flash() helper
Date:   Wed, 2 Jun 2021 11:49:12 +0200
Message-ID: <20210602094913.26472-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602094913.26472-1-patrice.chotard@foss.st.com>
References: <20210602094913.26472-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_05:2021-06-02,2021-06-02 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add spinand_init_flash() helper which implement
all needed init for future SPI-NAND resume ops.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v5:
  - Add spinand_read_cfg() call in spinand_init_flash()

Changes in v4:
  - None

 drivers/mtd/nand/spi/core.c | 74 ++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ab0fff6feaa7..12dfa75eec28 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1081,12 +1081,55 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct device *dev = &spinand->spimem->spi->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
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
@@ -1119,26 +1162,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_read_cfg(spinand);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_init_quad_enable(spinand);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
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
@@ -1147,17 +1174,6 @@ static int spinand_init(struct spinand_device *spinand)
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

