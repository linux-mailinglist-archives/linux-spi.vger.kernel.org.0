Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE31D4038DB
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351494AbhIHLgO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:14 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:4132 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhIHLgH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:07 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18858Mnw005982;
        Wed, 8 Sep 2021 06:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=MoiIevtL85Y16R9q8xqo8FIaL+3c11Wqy6V7xvcx3nQ=;
 b=RR7nKv+N0pZPRY4vr5MJpZHzfMwzkS5Hyts8I0NJRNbjM00Zk4nJdh7ZcicvAuZ/kQnK
 YqSrt5NFewUQDRCLGQlf4kDOWiiaJbkCU7TNKeuLNlp81NFQfchQsK2anK4e6ZxwraSh
 hw2dVdj6XE/wKjCd+hPDxjrnZVa8cmE9m8yHBf9V737Y7YN777K18KP2okN6CWKYuCe9
 y6yUJ3DBYNQX4zm/RJkMZAWXUuFqehsX7sz++jMVK/mVqHHEmS0jXXOgZyvJ2nGLlPBn
 FDQOHDHuisvyJdNU4bxUf3iBi5wh2VwYvCfaC+APrPo+mnzHRfOKS7rLJYez2MdG2P55 VA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:55 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 85B752BA;
        Wed,  8 Sep 2021 11:34:55 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 07/10] spi: amd: Check for idle bus before execute opcode
Date:   Wed, 8 Sep 2021 12:34:48 +0100
Message-ID: <20210908113450.788452-8-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FpF_I13L5b940pH3xbIhmrQ2qs6bdQVV
X-Proofpoint-ORIG-GUID: FpF_I13L5b940pH3xbIhmrQ2qs6bdQVV
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check if the bus is not in use before starting the transfer

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 97838b57871c..99b2b0ccff08 100644
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
-- 
2.33.0

