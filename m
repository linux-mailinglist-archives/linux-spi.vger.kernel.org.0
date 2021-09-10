Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67374406A98
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhIJLQx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 07:16:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:24514 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232537AbhIJLQx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 07:16:53 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18AAjKfW026567;
        Fri, 10 Sep 2021 06:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=bVIj4GXKVthpSX7oxUMgi9cJsuplE1dKWilk/8GQ17U=;
 b=bVtLjt+rm4sVrGcVEF/khdzdu6rdfVASMaIQ8fWjpu4xtggNSKwS9pz00h7mnHXXKHIc
 k1Y/6xz1uC6/3c6KBkTeuHIlyzTDCqe9KCL5fneNM73G+Bm2n/GTLcurP/FRRATiVuLc
 /Pht58Z9oBHwe7CM2s8VPdQX+xj1GbQ9rIonCodo2GogCM+D9xsT0qk0B11NV/H/hdQE
 gosBSFfVIbXNcrXFQDsXTPmX3uqKklL13jbQ5vHwIBJL9FxIZ2zuhgvdzpjI6iBlkFfk
 tJVpw3IFGp1N/jHNRHuQ1gKO0srfp2SwHq0qRlJlNz96j3Lvis8M38Subk/+TsqO6iTu Aw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3aytvr10en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 06:15:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 12:15:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 12:15:37 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F662B2F;
        Fri, 10 Sep 2021 11:15:37 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 2/4] spi: amd: Refactor amd_spi_busy_wait
Date:   Fri, 10 Sep 2021 12:15:27 +0100
Message-ID: <20210910111529.12539-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
References: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XxShVLzGuMSMHScIAzmB5g70orpSvfX2
X-Proofpoint-ORIG-GUID: XxShVLzGuMSMHScIAzmB5g70orpSvfX2
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use amd_spi_readreg32 to read 32 bits registers

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index f23467cf6acd..f2dd8d432aff 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -103,21 +103,15 @@ static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 	amd_spi_setclear_reg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
 }
 
-static inline int amd_spi_busy_wait(struct amd_spi *amd_spi)
+static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 {
-	bool spi_busy;
 	int timeout = 100000;
 
 	/* poll for SPI bus to become idle */
-	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
-	while (spi_busy) {
+	while (amd_spi_readreg32(amd_spi, AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) {
 		usleep_range(10, 20);
 		if (timeout-- < 0)
 			return -ETIMEDOUT;
-
-		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
 	}
 
 	return 0;
-- 
2.33.0

