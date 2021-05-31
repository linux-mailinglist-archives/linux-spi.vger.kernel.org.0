Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98AB3967AE
	for <lists+linux-spi@lfdr.de>; Mon, 31 May 2021 20:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhEaSUG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 May 2021 14:20:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59216 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhEaSUE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 May 2021 14:20:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VIIBe6078827;
        Mon, 31 May 2021 13:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622485091;
        bh=2P6h+Cn1wigbjU0SweqZ2o3rK+yNJ2zH7aHpS7XP2nM=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=AR2ISRJ1FM6/iAr8zkvIT2zp4KRfm4NpYiWXs8qABA5tLtucLsLZA4dvfV5cUmR+J
         fxa9d3rJZYE5ebIAhsIynCxT/h94PFKrooOsMT+ewZrmEz5V4XRGozvzh6tWGRROmL
         0NUSpzvyiB8knI/Dljb4ZhO6qtCJdm9wH6k3n19U=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VIIB5P104398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 13:18:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 13:18:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 13:18:11 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VIHwdI118543;
        Mon, 31 May 2021 13:18:08 -0500
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
Subject: [PATCH v2 3/6] mtd: spi-nor: micron-st: write 2 bytes when disabling Octal DTR mode
Date:   Mon, 31 May 2021 23:47:54 +0530
Message-ID: <20210531181757.19458-4-p.yadav@ti.com>
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

The Octal DTR configuration is stored in the CFR0V register. This
register is 1 byte wide. But 1 byte long transactions are not allowed in
8D-8D-8D mode. The next byte address contains the CFR1V register, which
contains the number of dummy cycles. This is very fortunate since the
enable path changes the value of this register. Reset the value to its
default when disabling Octal DTR mode. This way, both changes to the
flash state made when enabling can be reverted in one single
transaction.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

 drivers/mtd/spi-nor/micron-st.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c224e59820a1..e49bb2f142b3 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -13,6 +13,7 @@
 #define SPINOR_OP_MT_WR_ANY_REG	0x81	/* Write volatile register */
 #define SPINOR_REG_MT_CFR0V	0x00	/* For setting octal DTR mode */
 #define SPINOR_REG_MT_CFR1V	0x01	/* For setting dummy cycles */
+#define SPINOR_REG_MT_CFR1V_DEF	0x1f	/* Default dummy cycles */
 #define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
 #define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
 
@@ -48,17 +49,28 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	if (ret)
 		return ret;
 
-	if (enable)
-		*buf = SPINOR_MT_OCT_DTR;
-	else
-		*buf = SPINOR_MT_EXSPI;
+	if (enable) {
+		buf[0] = SPINOR_MT_OCT_DTR;
+	} else {
+		/*
+		 * The register is 1-byte wide, but 1-byte transactions are not
+		 * allowed in 8D-8D-8D mode. The next register is the dummy
+		 * cycle configuration register. Since the transaction needs to
+		 * be at least 2 bytes wide, set the next register to its
+		 * default value. This also makes sense because the value was
+		 * changed when enabling 8D-8D-8D mode, it should be reset when
+		 * disabling.
+		 */
+		buf[0] = SPINOR_MT_EXSPI;
+		buf[1] = SPINOR_REG_MT_CFR1V_DEF;
+	}
 
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
 			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
 					   SPINOR_REG_MT_CFR0V, 1),
 			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
 
 	if (!enable)
 		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
-- 
2.30.0

