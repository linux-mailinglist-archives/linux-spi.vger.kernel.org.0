Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2E3F5C45
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhHXKlv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54182 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236383AbhHXKlt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O9oMhV012561;
        Tue, 24 Aug 2021 05:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=xsX6p9puSfXRorYbQx0X/dwTanfMPZQ43pueV+mZkqs=;
 b=FQzs8GNjLTzhMll0Ty+JbUZY35uvmNDXQkwgge/EXzrsvhCNygsd/6eYpPwRsrVWtyqI
 MNd7LJlUxSVwFORB4vyZ5/n+yUNSFJDm9iydGhsSyB4lRVPVHm6LJT7UwdFbVjtr9WDb
 OnF48WrvI9pkiWMjIGJpaPFcm/tJaLBXO/+2S+//CJ9KnEU2Y0qb8AgEV5wxisUaP/Oi
 Uw8KaMTfY7FMib1qaBdUGR0rcJugFZITnqufP2ZrBgiZOYII9U1o+0tndkNVOlkONtcG
 huTTDrKY+gB4+qSoTdL6RPe28xEefvCbGhgZY6JpEMxaUuSan9KaH4HMLHNTjzPvkwM2 Fg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3amxg601k1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:41:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:41:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:41:00 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5B1D846E;
        Tue, 24 Aug 2021 10:41:00 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 7/9] spi: amd: Check for idle bus before execute opcode
Date:   Tue, 24 Aug 2021 11:40:39 +0100
Message-ID: <20210824104041.708945-8-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2S-f3Ix36nQZ-BZ9nG-nXue5ZByLN4mp
X-Proofpoint-ORIG-GUID: 2S-f3Ix36nQZ-BZ9nG-nXue5ZByLN4mp
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check if the bus is not in use before starting the transfer
Also wait after so the READ bytes in the FIFO are ready to
be copied

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index ebbc64a9fa7b..75390fcb0481 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -110,11 +110,17 @@ static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 				 !(val & AMD_SPI_BUSY), 10, 100000);
 }
 
-static void amd_spi_execute_opcode(struct amd_spi *amd_spi)
+static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
 {
+	int ret = amd_spi_busy_wait(amd_spi);
+
+	if (ret)
+		return ret;
+
 	/* Set ExecuteOpCode bit in the CTRL0 register */
 	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD, AMD_SPI_EXEC_CMD);
-	amd_spi_busy_wait(amd_spi);
+
+	return amd_spi_busy_wait(amd_spi);
 }
 
 static int amd_spi_master_setup(struct spi_device *spi)
-- 
2.33.0

