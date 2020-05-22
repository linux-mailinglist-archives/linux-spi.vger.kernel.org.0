Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697DD1DE3EC
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgEVKOw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 06:14:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59996 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbgEVKOs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 06:14:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MAEZ15038173;
        Fri, 22 May 2020 05:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590142476;
        bh=70FeLQTtJkyVxVIkf8YVfc8xOxYWAvnHPgHRRqee0UU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KQLsWfIP34S0daoWMOfBTQeaHgWJstoC5RMXDXIIe3R7z3ehdQrkozInyZDfgR+PV
         6uaz8xMtaiLg04ov0/0XWHXvZ1K0nM12nvVu2wts3GlZ4HjA8ig618CA1THTHmC7gd
         4bN/EigVprGbSLVOsKKH0C1jyaCpDWKKS/M8QnRA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04MAEZIg085584
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 05:14:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 05:14:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 05:14:35 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MAD1aI041179;
        Fri, 22 May 2020 05:14:30 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v7 17/20] mtd: spi-nor: core: disable Octal DTR mode on suspend.
Date:   Fri, 22 May 2020 15:42:58 +0530
Message-ID: <20200522101301.26909-18-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522101301.26909-1-p.yadav@ti.com>
References: <20200522101301.26909-1-p.yadav@ti.com>
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
 drivers/mtd/spi-nor/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 68559386f6f8..63ab588299f4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3239,6 +3239,23 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
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
@@ -3432,6 +3449,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	mtd->size = nor->params->size;
 	mtd->_erase = spi_nor_erase;
 	mtd->_read = spi_nor_read;
+	mtd->_suspend = spi_nor_suspend;
 	mtd->_resume = spi_nor_resume;
 
 	if (nor->params->locking_ops) {
-- 
2.26.2

