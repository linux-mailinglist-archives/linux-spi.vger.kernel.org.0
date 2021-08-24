Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974973F5C43
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhHXKlt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:49 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:30498 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236359AbhHXKls (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:48 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O9oMhT012561;
        Tue, 24 Aug 2021 05:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=qTNtCFsoJx4pQk/E80WddwevLWPQ75vIkwtcIFWK1vI=;
 b=A15a+c82Zu9nIwie2EKtkXgZikaa2nLPRR3RDKWaxcdVmn7vqQFWKz2a1P4+vlzUeC/V
 W+9FsuOamsKBTgVbHb8ZzOEdi/7um1qB4slw2ciH5pamBFIVo5OrbpZrzmR+dyhNbmHW
 uCaNVbhTbE94oMAHqZTeIX73xj7QYJwdeoj9nF0nbAnqKJt3z0yMVW6xD+tihmHgNGpK
 Aj0bLVzSoLQOTdRqj/F+SVlkkYB83OgcbMyQe+JoKMFavixpf0AA+KYxfCJm1mA5lRTv
 0aKOuWcNHVSayBfMhN5nja3xPI5mA11Dlu30GmkF3p9owky81leTm18f65v+uhRO5xjV fw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3amxg601k1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:41:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:41:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:41:00 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CDE722BA;
        Tue, 24 Aug 2021 10:40:59 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 5/9] spi: amd: Refactor amd_spi_busy_wait to use readl_poll_timeout
Date:   Tue, 24 Aug 2021 11:40:37 +0100
Message-ID: <20210824104041.708945-6-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CRKyq3WinKHnFX2jdtYc09eFCfd5ZpSp
X-Proofpoint-ORIG-GUID: CRKyq3WinKHnFX2jdtYc09eFCfd5ZpSp
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This function can be replaced by readl_poll_timeout

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index f23467cf6acd..9476b283840b 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/iopoll.h>
 
 #define AMD_SPI_CTRL0_REG	0x00
 #define AMD_SPI_EXEC_CMD	BIT(16)
@@ -103,24 +104,12 @@ static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 	amd_spi_setclear_reg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
 }
 
-static inline int amd_spi_busy_wait(struct amd_spi *amd_spi)
+static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 {
-	bool spi_busy;
-	int timeout = 100000;
-
-	/* poll for SPI bus to become idle */
-	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
-	while (spi_busy) {
-		usleep_range(10, 20);
-		if (timeout-- < 0)
-			return -ETIMEDOUT;
-
-		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
-	}
+	u32 val;
 
-	return 0;
+	return readl_poll_timeout(amd_spi->io_remap_addr + AMD_SPI_CTRL0_REG, val,
+				 !(val & AMD_SPI_BUSY), 10, 100000);
 }
 
 static void amd_spi_execute_opcode(struct amd_spi *amd_spi)
-- 
2.33.0

