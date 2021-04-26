Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62C36B50D
	for <lists+linux-spi@lfdr.de>; Mon, 26 Apr 2021 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhDZOkc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 10:40:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24066 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233691AbhDZOkc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 10:40:32 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QEcGPU015802;
        Mon, 26 Apr 2021 16:39:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=lFJy9ccCm1PICKyVeTRoH866ML1NyAIfvIYxbbK1sKg=;
 b=e/XRIiBreWYUI3DY1MdI//XwCqziOHyve4kXKeACbb4ubERoBOwejjF1fQb9vMJEEf2p
 Jsjz77/9Kx+a4haGwWvYjXC865uDISp5GJK63aywDn0TosIvYLwIpZ/Wz04gVT4wELJE
 2avt+QPLxVRqanSvBzwfuEfdBCytEZFwWiEsnNEMqauCj9BQgSs/S+T17a/UrpDLIjmi
 4jmSkVasbYBhKAdn8ZBmT11bZ7zm2BituAr/ygCwakevQwGBMQOGxBKaDvcaxiWAgRou
 OhC1U0JOPH2LyENfhm0qNRP9PKc1R0cvu+bqK32vhuqtpa1BjKOBknCYNPdc9KsgRV4p Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 385b0xx7d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 16:39:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 730F8100038;
        Mon, 26 Apr 2021 16:39:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 643002178E6;
        Mon, 26 Apr 2021 16:39:39 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 16:39:39
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
Subject: [PATCH 2/3] mtd: spinand: use the spi-mem poll status APIs
Date:   Mon, 26 Apr 2021 16:39:33 +0200
Message-ID: <20210426143934.25275-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210426143934.25275-1-patrice.chotard@foss.st.com>
References: <20210426143934.25275-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_07:2021-04-26,2021-04-26 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Christophe Kerello <christophe.kerello@foss.st.com>

Make use of spi-mem poll status APIs to let advanced controllers
optimize wait operations

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++----
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17f63f95f4a2..916f435257bd 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -475,18 +475,32 @@ static int spinand_erase_op(struct spinand_device *spinand,
 
 static int spinand_wait(struct spinand_device *spinand, u8 *s)
 {
-	unsigned long timeo =  jiffies + msecs_to_jiffies(400);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(REG_STATUS,
+						      spinand->scratchbuf);
+	unsigned long timeo =  jiffies + msecs_to_jiffies(SPINAND_STATUS_TIMEOUT_MS);
 	u8 status;
 	int ret;
 
-	do {
-		ret = spinand_read_status(spinand, &status);
+	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
+				  SPINAND_STATUS_TIMEOUT_MS);
+	if (ret != -EOPNOTSUPP) {
 		if (ret)
 			return ret;
 
+		status = *spinand->scratchbuf;
+
 		if (!(status & STATUS_BUSY))
 			goto out;
-	} while (time_before(jiffies, timeo));
+	} else {
+		do {
+			ret = spinand_read_status(spinand, &status);
+			if (ret)
+				return ret;
+
+			if (!(status & STATUS_BUSY))
+				goto out;
+		} while (time_before(jiffies, timeo));
+	}
 
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

