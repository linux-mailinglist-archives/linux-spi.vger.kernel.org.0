Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1648D3765FB
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhEGNT1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 09:19:27 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:55546 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235909AbhEGNT0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 09:19:26 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147DGNw0023853;
        Fri, 7 May 2021 15:18:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=2VbaSQPKll45bb5e+nOLyoc5u0h4ohc9JIgkDyyn1+g=;
 b=a+LCm4edN9xxIkKKwKCS8ESJ22G477AXAryOAOzgXIAufLzTqdUW4VVuv+mmKoMoUTgo
 Vv6kSXimcwKhzG6wE2ujG9c59m38L2fFrte5MlbznnIbBLVqnwkXuDum+RwqnjDCKVWq
 ds9NJ87ZOVfrSfs51LzRFmJftVT2jhyMfKGN1D32dx7Fl65WAusuXAVZiCKcX9+iZPZF
 HoVIeqJo5xKZHJS8kixc86k94ax7owSleEEZT7wVviVkPmuZj9d0DxJdGnrvVRijcbKt
 Zux7aJ+X6ZGSu2m2lIpFUPbXvpBzi5VRno3ReJTjbKeuUtekF4MJfUIwzvMVbalgKipB Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38cspsc394-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 15:18:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74114100039;
        Fri,  7 May 2021 15:18:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 650C4221F78;
        Fri,  7 May 2021 15:18:14 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May 2021 15:18:14
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
Subject: [PATCH v2 2/3] mtd: spinand: use the spi-mem poll status APIs
Date:   Fri, 7 May 2021 15:17:55 +0200
Message-ID: <20210507131756.17028-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507131756.17028-1-patrice.chotard@foss.st.com>
References: <20210507131756.17028-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Make use of spi-mem poll status APIs to let advanced controllers
optimize wait operations.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v2:
  - non-offload case is now managed by spi_mem_poll_status()

 drivers/mtd/nand/spi/core.c | 17 +++++++++--------
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17f63f95f4a2..56f81c7a73a6 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -475,18 +475,19 @@ static int spinand_erase_op(struct spinand_device *spinand,
 
 static int spinand_wait(struct spinand_device *spinand, u8 *s)
 {
-	unsigned long timeo =  jiffies + msecs_to_jiffies(400);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(REG_STATUS,
+						      spinand->scratchbuf);
 	u8 status;
 	int ret;
 
-	do {
-		ret = spinand_read_status(spinand, &status);
-		if (ret)
-			return ret;
+	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
+				  SPINAND_STATUS_TIMEOUT_MS);
+	if (ret)
+		return ret;
 
-		if (!(status & STATUS_BUSY))
-			goto out;
-	} while (time_before(jiffies, timeo));
+	status = *spinand->scratchbuf;
+	if (!(status & STATUS_BUSY))
+		goto out;
 
 	/*
 	 * Extra read, just in case the STATUS_READY bit has changed
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6bb92f26833e..28ee481d96eb 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -170,6 +170,7 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+#define SPINAND_STATUS_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.17.1

