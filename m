Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B30406A99
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhIJLQ4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 07:16:56 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13540 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232654AbhIJLQx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 07:16:53 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18AAjKfX026567;
        Fri, 10 Sep 2021 06:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Xfex8YHlPo46AjebMXoKuGTxrNazIIhns13rHyXgSlE=;
 b=Xk36HUXRbzI91qNMjg99sYITsee82glPaicTprOgynGskrXjXym8PesfUDzEgDkre8ZQ
 ZYLqGvz3eEkTkgOKukeZ4JFhEOhCS82FnhztJrAucu1BEjzFGHxJYOSAZqiGUpCj4Hf8
 hM10wi8WkOMyHbXAMl0d0pUsN3BucBs78xpE0RjHpz5uVECoSkgRLEBj8M/EXGxxeQqI
 RZyHbI+DsJRKJoxdHI8cRG+4nEyZeP+z4OQrpkXjKgMp/Ot3JUE+TDD4NnfFfK+HAlwo
 alL1h4rKvZaVF1T1IeaB1Vr5IV66QG1fc5lHIFCp/gcpRxdeHu68SeLadm4/v+6BGpax lQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3aytvr10en-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 06:15:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 12:15:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 12:15:37 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 651EA2A9;
        Fri, 10 Sep 2021 11:15:37 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 3/4] spi: amd: Remove unneeded variable
Date:   Fri, 10 Sep 2021 12:15:28 +0100
Message-ID: <20210910111529.12539-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
References: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pDiOlt3sz99tZcobM7biu0VdPVeDx3jt
X-Proofpoint-ORIG-GUID: pDiOlt3sz99tZcobM7biu0VdPVeDx3jt
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove internal cs from amd_spi

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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

