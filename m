Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96523387562
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbhERJnt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 05:43:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28226 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242608AbhERJns (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 05:43:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14I9ftj3002253;
        Tue, 18 May 2021 11:42:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=4HoG+z1yNsklnJ8rWxCMVJvcO7V/MllQemPej9i9gvE=;
 b=JZZn8cGOvtocFsS78d6nWlLgiHP5YQlknaS0+5ZetibNnv5/1yvOakF6eYeV0xvKuW1v
 lpRtcfmteMEYXD9RuNZn0LYvMJHxO8j88eeUTRdCOpyiVcYkG4z6EG0FsOq3dPf+EQto
 4GuHSitrKWXiRBMKbql8foTRcypdVcjGUTpMeOK6n91CmFbADCBYBAs6YgcGSdGQnCQp
 b8UxWu83FJtLI6vZtYKYIsQ47HwqxMDo9D3AC+z9QGf4xCnD16elDZN7kFmJkK1Ty5i+
 JPUWliYrL46FFGUZybM4ukUZKnWYWKA9pf2E4zSmegc65u2aTixdKLKUGfQZeUr9bzcf BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38km706pwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 11:42:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72D44100038;
        Tue, 18 May 2021 11:42:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62F0D21CA64;
        Tue, 18 May 2021 11:42:13 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 11:42:12
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
Subject: [PATCH v3 2/3] mtd: spinand: use the spi-mem poll status APIs
Date:   Tue, 18 May 2021 11:39:50 +0200
Message-ID: <20210518093951.23136-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518093951.23136-1-patrice.chotard@foss.st.com>
References: <20210518093951.23136-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_04:2021-05-17,2021-05-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Make use of spi-mem poll status APIs to let advanced controllers
optimize wait operations.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v3:
  - Add initial_delay_us and polling_delay_us parameters to spinand_wait()
  - Add SPINAND_READ/WRITE/ERASE/RESET_INITIAL_DELAY_US and
    SPINAND_READ/WRITE/ERASE/RESET_POLL_DELAY_US defines.

Changes in v2:
  - non-offload case is now managed by spi_mem_poll_status()

 drivers/mtd/nand/spi/core.c | 45 ++++++++++++++++++++++++++-----------
 include/linux/mtd/spinand.h | 11 ++++++++-
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17f63f95f4a2..ef2a692ab5b6 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -473,20 +473,26 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
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
+				  initial_delay_us,
+				  poll_delay_us,
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
@@ -526,7 +532,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -549,7 +558,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -585,7 +597,10 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
 		return -EIO;
 
@@ -768,7 +783,11 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
+
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6bb92f26833e..180c1fa64e62 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -169,7 +169,16 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN		4
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+#define SPINAND_STATUS_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.17.1

