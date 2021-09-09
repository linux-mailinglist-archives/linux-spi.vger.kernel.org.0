Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0194048F6
	for <lists+linux-spi@lfdr.de>; Thu,  9 Sep 2021 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhIILLY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Sep 2021 07:11:24 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:19056 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234932AbhIILLX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Sep 2021 07:11:23 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1895CKhb012432;
        Thu, 9 Sep 2021 06:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=b4lv3VySvMZBsmWHH8FJBjD9cy6eaPIRwRdSaXk8zrI=;
 b=RlFR1aGqYRBHyvpzBuGunFOKTjHhtVadvc3Bey6G5KENEJYKn9RTWEIz9ozNOvRZDtMa
 bO/KjGA3xXrpBoB10PboEhOhJNpiU5H7A/tdp/qB49/6zP20uaRS1jN2bSzMpoNxyggO
 avWzk+oCBmk+HbUfB6WZjKVIyj7rg9pgUCNfhCXK/SGjQcUHpCeuQiLOV52nfQSxRRT/
 Ll7iV2qeaDHuughs99Uyi/ze1Mni5VXnJPVyFigfDyWt2RUFzpZP8y5/M/xMFS/RSKaH
 NysHpnpNlc1Hq6O7FEegwse6kKn9+AwLlmtppPahkl7BhgtsVb47QKT6FSJoMSr4JpgB FQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3ay8n60e5d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Sep 2021 06:10:11 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 9 Sep
 2021 12:10:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 9 Sep 2021 12:10:08 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 81F93B2F;
        Thu,  9 Sep 2021 11:10:08 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 4/4] spi: amd: Check for idle bus before execute opcode
Date:   Thu, 9 Sep 2021 12:10:05 +0100
Message-ID: <20210909111005.304101-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
References: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LHnOknpLOPQwKaWdrwgOMLHszyLqAocX
X-Proofpoint-GUID: LHnOknpLOPQwKaWdrwgOMLHszyLqAocX
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check if the bus is not in use before starting the
transfer

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

