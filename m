Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4B184B92
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCMPrr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 11:47:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55262 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgCMPrp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Mar 2020 11:47:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02DFlaou062943;
        Fri, 13 Mar 2020 10:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584114456;
        bh=GCR07WRKEb3uBFyLtrNoiwFaOeGSGBrdACJjmVEVr8A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uz6SfjQwP8ojPXmcP8GDbDcyESJzuWd+RuObBiPZou4jqyoe6he/rmCwDRY7z9juz
         kZ/FtamVNZBFSswi99raooX1kYdHCHOcKNw5g77nZC8T6FYfSRR8/P1qDoyLnl1Ozn
         PFPcI36zLqc0Z8lm5H8BkY+cyL2s/6EcbmVoYgWg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02DFla8g090945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 10:47:36 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 10:47:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 10:47:36 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02DFkkSP034352;
        Fri, 13 Mar 2020 10:47:32 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 11/12] mtd: spi-nor: Disable Octal DTR mode on suspend.
Date:   Fri, 13 Mar 2020 21:16:44 +0530
Message-ID: <20200313154645.29293-12-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200313154645.29293-1-p.yadav@ti.com>
References: <20200313154645.29293-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On resume, the init procedure will be run that will re-enable it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index fcc087ff5148..32f7ecbc38d4 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -5379,6 +5379,23 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 	usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
 }
 
+/* mtd suspend handler */
+static int spi_nor_suspend(struct mtd_info *mtd)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	struct device *dev = nor->dev;
+	int ret;
+
+	/* Disable octal DTR mode if we enabled it. */
+	ret = spi_nor_octal_dtr_enable(nor, false);
+	if (ret) {
+		dev_err(dev, "suspend() failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /* mtd resume handler */
 static void spi_nor_resume(struct mtd_info *mtd)
 {
@@ -5564,6 +5581,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	mtd->size = params->size;
 	mtd->_erase = spi_nor_erase;
 	mtd->_read = spi_nor_read;
+	mtd->_suspend = spi_nor_suspend;
 	mtd->_resume = spi_nor_resume;
 
 	if (nor->params.locking_ops) {
-- 
2.25.0

