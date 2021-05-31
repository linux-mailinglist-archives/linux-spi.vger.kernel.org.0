Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63C63967B0
	for <lists+linux-spi@lfdr.de>; Mon, 31 May 2021 20:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhEaSUI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 May 2021 14:20:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59200 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhEaSUE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 May 2021 14:20:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VII83s078813;
        Mon, 31 May 2021 13:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622485088;
        bh=moH2ZY+xmI5k70xNoKzxtoVfAjiFgQzTAD/mpB3NYvw=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=PfRJmqmAUyqOuPK2Jt1RKEtjynUr3xOi3nROnR0HbgKbfM9XICfYv8yQ8gvV76PYi
         +3i8bj0pCJD9hoGwGoQVr+6tKhAPqWKWiL6yPeMibtRqmJQNvMwpxaYvY8SJPq+gCt
         QNr1PkLmA6sXlOnfdukvcFAmBe9oJ2gnEz4/EMI8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VII8Yo027498
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 13:18:08 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 13:18:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 13:18:08 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VIHwdH118543;
        Mon, 31 May 2021 13:18:05 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 2/6] mtd: spi-nor: spansion: write 2 bytes when disabling Octal DTR mode
Date:   Mon, 31 May 2021 23:47:53 +0530
Message-ID: <20210531181757.19458-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210531181757.19458-1-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Octal DTR configuration is stored in the CFR5V register. This
register is 1 byte wide. But 1 byte long transactions are not allowed in
8D-8D-8D mode. Since the next byte address does not contain any
register, it is safe to write any value to it. Write a 0 to it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

 drivers/mtd/spi-nor/spansion.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index ee82dcd75310..e6bf5c9eee6a 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -65,10 +65,18 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	if (ret)
 		return ret;
 
-	if (enable)
-		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
-	else
-		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
+	if (enable) {
+		buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
+	} else {
+		/*
+		 * The register is 1-byte wide, but 1-byte transactions are not
+		 * allowed in 8D-8D-8D mode. Since there is no register at the
+		 * next location, just initialize the value to 0 and let the
+		 * transaction go on.
+		 */
+		buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
+		buf[1] = 0;
+	}
 
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
@@ -76,7 +84,7 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
 					   SPINOR_REG_CYPRESS_CFR5V,
 					   1),
 			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
 
 	if (!enable)
 		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
-- 
2.30.0

