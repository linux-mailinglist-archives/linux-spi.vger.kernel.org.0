Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4456439336C
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhE0QP5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 12:15:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47556 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237219AbhE0QPA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 12:15:00 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RGCErn027551;
        Thu, 27 May 2021 18:13:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=lhIzyMB3zCeRcGYJfgFXnoCQIPHUSlhrp5nHGanC4TA=;
 b=eU0svrHAYFpVKvArcV6Up8RWPbB6JNsnCe5W0dmYmC3ouIhfvT/mFAuQJl1wB64lhnzQ
 opmNqVZ1wBo14ddEEk8Kcjeh2Z3aHiQ1vmNpKYjV2rRHTXLDfSSsBl9JLpC1QQOEBB/k
 pnCjdzXhObwW9hBFf3D/hNinVLqxJjQkcN/qBL1yA6cXwB90QhjuwLBYLOQbQtUHulPk
 WaGALKkDRH7ccnxVSy3iaqtdYcZCtRB9Mz9FGzE4FaB9m9zOGXTPcOszwepKull1IXrE
 tCUkBz6tuu7/Uru9Kmc7cSlazAbZb7m6AoHjaOQ06qdWgDsyo1qsnfarCzIHovcG/OnC 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t0fr4ypg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 18:13:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8D65100034;
        Thu, 27 May 2021 18:13:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C99ED236566;
        Thu, 27 May 2021 18:13:03 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May 2021 18:13:03
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
Subject: [PATCH v3 1/3] mtd: spinand: Add spinand_block_unlock() helper
Date:   Thu, 27 May 2021 18:12:50 +0200
Message-ID: <20210527161252.16620-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527161252.16620-1-patrice.chotard@foss.st.com>
References: <20210527161252.16620-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_09:2021-05-27,2021-05-27 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Put code responsible of block unlocking in spinand_block_unlock().
This function will be needed by the future SPI-NAND resume ops.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/mtd/nand/spi/core.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17f63f95f4a2..095742e5bc2b 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1074,12 +1074,30 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_block_unlock(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret = 0, i;
+
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			return ret;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			return ret;
+	}
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
@@ -1137,15 +1155,9 @@ static int spinand_init(struct spinand_device *spinand)
 	}
 
 	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
+	ret = spinand_block_unlock(spinand);
+	if (ret)
+		goto err_manuf_cleanup;
 
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
-- 
2.17.1

