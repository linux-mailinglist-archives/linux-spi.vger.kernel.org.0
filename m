Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC54038DE
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351503AbhIHLgP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:15 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38896 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349238AbhIHLgH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:07 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188696pG006454;
        Wed, 8 Sep 2021 06:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=z8OR6d+ZMzv6Zm7tmMIKU13EYKzvNmgnXJ/B25RTzOk=;
 b=DNLvqfvMynC8Yj2v8smyE25GbZnd3Re+rARISrsB1HM4GoMmx6zTDIl8QrmXg8JYMy2F
 9DOjrQ2SXuQ14Jj3wRXuEs5tdpapQeSe0WttCxdV160n6gKGfZ23QjijD4B9krK4so24
 YHGmcuU7nEfR5hiA28VAlsvHasceRo2p8AhV+I+0Mk2Oxj7Vk7yJlbuJrCK3OoH1yC4f
 ngoVeILDEU016QDXueSw65sm3ehJXxeJfKH/ZhQqIsiwlYzm/JodvyGJu+xjdKsheXxR
 1CSl/njXBPuUDljLvXCMETV3YTOei3FYuifyOA+HxjokKfwKqPt7PKcjSLKvZBJJyeBL GA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:55 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 41BD1B2F;
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
Subject: [PATCH 06/10] spi: amd: Remove unneeded variable
Date:   Wed, 8 Sep 2021 12:34:47 +0100
Message-ID: <20210908113450.788452-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: O4Kyex8Q3BZgqyc2sCEEAWmHwQYZowpT
X-Proofpoint-ORIG-GUID: O4Kyex8Q3BZgqyc2sCEEAWmHwQYZowpT
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove internal cs from amd_spi

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index f2dd8d432aff..97838b57871c 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -38,7 +38,6 @@ struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	u32 rom_addr;
-	u8 chip_select;
 };
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
@@ -77,10 +76,9 @@ static inline void amd_spi_setclear_reg32(struct amd_spi *amd_spi, int idx, u32
 	amd_spi_writereg32(amd_spi, idx, tmp);
 }
 
-static void amd_spi_select_chip(struct amd_spi *amd_spi)
+static void amd_spi_select_chip(struct amd_spi *amd_spi, u8 cs)
 {
-	amd_spi_setclear_reg8(amd_spi, AMD_SPI_ALT_CS_REG, amd_spi->chip_select,
-			      AMD_SPI_ALT_CS_MASK);
+	amd_spi_setclear_reg8(amd_spi, AMD_SPI_ALT_CS_REG, cs, AMD_SPI_ALT_CS_MASK);
 }
 
 static void amd_spi_clear_fifo_ptr(struct amd_spi *amd_spi)
@@ -201,8 +199,7 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	struct amd_spi *amd_spi = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
 
-	amd_spi->chip_select = spi->chip_select;
-	amd_spi_select_chip(amd_spi);
+	amd_spi_select_chip(amd_spi, spi->chip_select);
 
 	/*
 	 * Extract spi_transfers from the spi message and
-- 
2.33.0

