Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D863F5C46
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhHXKlv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59432 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236388AbhHXKlt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O9oMhU012561;
        Tue, 24 Aug 2021 05:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Y1dzi87RQSLOVgc1XSY6AIdI/7WVI0LjnVnxGx7qTbo=;
 b=d9MB0pdnOlz72yZbtV5+qLWlb1Cdu51SBr5bTq6VSTQUxcVI92l9cSUbWYSCYuaKguaP
 WjOTLHk87twmjlKIfd4E+X5VgTbrKiCYMUXCnvqBKDAT3wlZNcMhct9245Zi6xNhh827
 xuBCPRkyd2DeQFR/bd2xSVo926UtLjyxADo9EAYejT/d5T/lIVtEdjHyk1kc17CkSsMA
 RvTYUjYvvkgDc/qMBg+Ya9RmB85mmtTEfPkaRlE2qSxMqIayH8U/njchntu4ie8o2DYf
 tPyzbhO+a3Dwu1+9B0MGc5GajR0sEiL/pHW7bxp8BnE3gD3eqMhnvjIEqxzyoekulk3q ig== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3amxg601k1-3
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1AC082A9;
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
Subject: [PATCH 6/9] spi: amd: Remove uneeded variable
Date:   Tue, 24 Aug 2021 11:40:38 +0100
Message-ID: <20210824104041.708945-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MrbsGSsAFNFFq7jPDiZPQknEJAAaDpae
X-Proofpoint-ORIG-GUID: MrbsGSsAFNFFq7jPDiZPQknEJAAaDpae
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
index 9476b283840b..ebbc64a9fa7b 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -39,7 +39,6 @@ struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	u32 rom_addr;
-	u8 chip_select;
 };
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
@@ -78,10 +77,9 @@ static inline void amd_spi_setclear_reg32(struct amd_spi *amd_spi, int idx, u32
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
@@ -196,8 +194,7 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	struct amd_spi *amd_spi = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
 
-	amd_spi->chip_select = spi->chip_select;
-	amd_spi_select_chip(amd_spi);
+	amd_spi_select_chip(amd_spi, spi->chip_select);
 
 	/*
 	 * Extract spi_transfers from the spi message and
-- 
2.33.0

