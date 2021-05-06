Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB3375B93
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 21:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhEFTTu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 15:19:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47032 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhEFTTt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 15:19:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 146JIfJW095409;
        Thu, 6 May 2021 14:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620328721;
        bh=IiRBqB2ToyGAi8YKG7SNA23XBwysyJKFHiYBnMNbNv8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lH+f0ybvm8Yl0uNS+pMn+aGhmn5K0Q5Os19Kqxyg17bBirL+b+Yf3d4mLk3DdgGYw
         rsfLxygDABFDORL+M4QQU9fQWOWiF/sGig/UHX+Wj6ekKew82FKsQwYJOj8X9DR97i
         s/l1kd3yyj8X/YMZ336tDakp6E6FOORxOvu8kA8c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 146JIeHj122839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 May 2021 14:18:41 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 6 May
 2021 14:18:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 6 May 2021 14:18:40 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 146JIUNE026052;
        Thu, 6 May 2021 14:18:37 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 2/6] mtd: spi-nor: spansion: write 2 bytes when disabling Octal DTR mode
Date:   Fri, 7 May 2021 00:48:25 +0530
Message-ID: <20210506191829.8271-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506191829.8271-1-p.yadav@ti.com>
References: <20210506191829.8271-1-p.yadav@ti.com>
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

