Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E43985A5
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 11:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFBJv5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 05:51:57 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36784 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhFBJv4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 05:51:56 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1529mAhh022059;
        Wed, 2 Jun 2021 11:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=7fWOTJwsDbVNQK+G9/IwAvdbrfF1wUNnYys4ig4zEI4=;
 b=bC5MOJsDJLaKRd0SEdMksdj6kefDeIG9PXOGJ/mSf0/RDc7dl4uHPezuoRP2QgkAUU3c
 l0G3dT4QrOA9+42v0goPqrTC4Lluw9SDWSaDGzUtyQTwMFEKEaLB0+suj40h1KLsdKIs
 +TOmOO/WFDOs+KTkURT+h/UT9d8T0+MsYqkRUomlMINOeGPaXSRFqqxo1Ap/Lu9h0S0p
 n7ukdIVOqRzinoX1UK6f/eQMkxfCE3yfU5DDh7/wZnHNYLNN5S6UNIMtIHfoHj5WT9l9
 DkoIhLth6UuyTp8FZgkJ2LgyIggIqns5stNmNe2k07b6WtbORYiavj4AcPMQcFFFvJoH Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38x3gt4sja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 11:49:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73D98100034;
        Wed,  2 Jun 2021 11:49:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 66752216ED8;
        Wed,  2 Jun 2021 11:49:55 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun 2021 11:49:54
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
Subject: [PATCH v5 1/3] mtd: spinand: add spinand_read_cfg() helper
Date:   Wed, 2 Jun 2021 11:49:11 +0200
Message-ID: <20210602094913.26472-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602094913.26472-1-patrice.chotard@foss.st.com>
References: <20210602094913.26472-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_05:2021-06-02,2021-06-02 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Put REG_CFG reading code in spinand_read_cfg().
This function will be needed by the future SPI-NAND resume ops.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v5:
  - spinand_init_cfg_cache() only allocates spinand->cfg_cache array,
    spinand_read_cfg() is called directly in spinand_init().

 drivers/mtd/nand/spi/core.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17f63f95f4a2..ab0fff6feaa7 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -138,20 +138,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct device *dev = &spinand->spimem->spi->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kcalloc(dev,
-					  nand->memorg.ntargets,
-					  sizeof(*spinand->cfg_cache),
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -170,6 +162,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct device *dev = &spinand->spimem->spi->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1112,6 +1119,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		goto err_free_bufs;
+
 	ret = spinand_init_quad_enable(spinand);
 	if (ret)
 		goto err_free_bufs;
-- 
2.17.1

