Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3343943FE
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhE1OSm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 10:18:42 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39976 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235925AbhE1OSl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 10:18:41 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SE7dKS005246;
        Fri, 28 May 2021 16:16:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=O7SCszC+8JoCvxo63ZnsVlh61ucCKXaspUu7IkWDxIg=;
 b=h/CyfbVGdaqiN6xZPxLC0Qo0ZhYJXVklFEQRmicMIqgYNAp0TDRoZUqQnJOo0u21PghP
 Q+NNfhWZCxUW7YaHcqvb1h12HNcEOxlIoub3oUzYxE1djJt5BazviOTNv1HrgHhR0Ai2
 mArVL+wbCflb+Vm4lcGLe0/8qMxwBGxGMs2lrxx4rMbqEf/tdpagKcKYiHSfF3KDRhFR
 N9cFt/IgGK3mPDrAoNCXKfZZpDDdqzbdl6b2tzPSeMLxDcX6yB/P9VAJ1kdhgtb3tDgK
 eWHZCH4fBcGeZiRrNqBqLyrn8G54r2PVukdfHEC/GNVHvEiKTqg4pEElNbAF9vdhxVOC bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38tj2rmvr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 16:16:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 493A010002A;
        Fri, 28 May 2021 16:16:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 39FB8231DC0;
        Fri, 28 May 2021 16:16:53 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH v4 2/3] mtd: spinand: add spinand_read_cfg() helper
Date:   Fri, 28 May 2021 16:16:38 +0200
Message-ID: <20210528141639.3194-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528141639.3194-1-patrice.chotard@foss.st.com>
References: <20210528141639.3194-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Put REG_CFG reading code in spinand_read_cfg().
This function will be needed by the future SPI-NAND resume ops.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v4:
  - None

 drivers/mtd/nand/spi/core.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 1f39a38fbf69..58945f0ae839 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -138,20 +138,13 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct device *dev = &spinand->spimem->spi->dev;
+
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
@@ -170,6 +163,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
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
+	return spinand_read_cfg(spinand);
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
-- 
2.17.1

