Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01D5406A9B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhIJLQ4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 07:16:56 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:5536 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232746AbhIJLQx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 07:16:53 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18AAjKfY026567;
        Fri, 10 Sep 2021 06:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=O4jwH34gE1vbthRuJ40psmfZwxQx+zsgFe207ESh774=;
 b=QPXrPuiUlDvoHihx2M9v42d01b4HJhU8hTXozV2B39qhjclV4+Vrt9zQKKaAijTgpOUN
 ZE7wBi9IJ4J4/1uO7jWGLUfXJNnCHd5xGC9l/DlRfsJ4E+A0ywwCKXfEVmA1BiANZ18X
 6xB7fEMU/ERuqyPDE9ryIHl5NtLltQgubW1+yRe/S1HDgMoSuUnqxe4pfNY1nE5Jxmnb
 Y0aoN6g1MPo7lU8LgjtagDIplurYeN67yJaxel8Gwyb7DB7f1dq9yL3pk5vT5mkb+Hnj
 89AZQTcAePvkSoerMPDHZ/yBUb+XoUXw7r5UJGttvdjG/mAJWpHx8NKf2hX4HTCciqCJ Qg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3aytvr10en-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 06:15:41 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 12:15:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 12:15:37 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A3D41B10;
        Fri, 10 Sep 2021 11:15:37 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 4/4] spi: amd: Don't wait for a write-only transfer to finish
Date:   Fri, 10 Sep 2021 12:15:29 +0100
Message-ID: <20210910111529.12539-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
References: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4YlgfPDQG0V-4vKbZGORjENnLtMG4uq-
X-Proofpoint-ORIG-GUID: 4YlgfPDQG0V-4vKbZGORjENnLtMG4uq-
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Return from a write-only transfer without waiting for
it to finish
But wait before a new transfer as the previous may
still happening and also wait before reading the data
from the FIFO

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

Changes in v2:
Add wait before read data
New explanation

 drivers/spi/spi-amd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 97838b57871c..4b3ac7aceaf6 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -115,11 +115,18 @@ static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 	return 0;
 }
 
-static void amd_spi_execute_opcode(struct amd_spi *amd_spi)
+static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
 {
+	int ret;
+
+	ret = amd_spi_busy_wait(amd_spi);
+	if (ret)
+		return ret;
+
 	/* Set ExecuteOpCode bit in the CTRL0 register */
 	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD, AMD_SPI_EXEC_CMD);
-	amd_spi_busy_wait(amd_spi);
+
+	return 0;
 }
 
 static int amd_spi_master_setup(struct spi_device *spi)
@@ -178,6 +185,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 			amd_spi_clear_fifo_ptr(amd_spi);
 			/* Execute command */
 			amd_spi_execute_opcode(amd_spi);
+			amd_spi_busy_wait(amd_spi);
 			/* Read data from FIFO to receive buffer  */
 			for (i = 0; i < rx_len; i++)
 				buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
-- 
2.33.0

