Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5B4038D9
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349310AbhIHLgN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:13 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36016 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348768AbhIHLgH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:07 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18858Mnv005982;
        Wed, 8 Sep 2021 06:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=einaWie+AkqgLoHIE/9XECHZY7I9IDne9pKF3qRvuHQ=;
 b=e6zQKP1mOp2GBSwoY+5Ke7PUbBN+9MzdIbvQevY1R4J/SO8+3+SISMeImmU8cs6cc4q9
 ZyWj2tO3gvdIA0jJGXJU36WfIZUES6HM+Zx3XCQVq5be2u5+06+uins7XVQ7ChXRxzOo
 ou0yKNpJr4UCTKooZz6jtTA91uIKQ7PJN5or50IHIwgHc493qE8o3/QylDFCxDbSMSVK
 WY2q28JxjZbermM22qPTHf1Ct414Ns86Qvw7d8nIteVWcWRLktguxTGo0R25ObFAxybF
 W/TXS++H+Jl16aCQPbRPzKi3sB6eZXWaDFw1rkOVJtR4N8eRiG6BFVjTC38UzYL65+sF aA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:55 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E9AA72BA;
        Wed,  8 Sep 2021 11:34:54 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 05/10] spi: amd: Refactor amd_spi_busy_wait
Date:   Wed, 8 Sep 2021 12:34:46 +0100
Message-ID: <20210908113450.788452-6-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: M1lruVQ2W344bY55HRkaLApiS2eU-jrh
X-Proofpoint-ORIG-GUID: M1lruVQ2W344bY55HRkaLApiS2eU-jrh
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use amd_spi_readreg32 to read 32 bits registers

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
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

