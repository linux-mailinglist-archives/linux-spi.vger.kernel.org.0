Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF5375B95
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 21:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhEFTTw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 15:19:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54840 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhEFTTu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 15:19:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 146JIin4080687;
        Thu, 6 May 2021 14:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620328724;
        bh=YxdJ0KAQlULOSarEjigNBSaxhdxJcUTtoguFX6Vi1xY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=c0F6JEgYXJkRjwu7ik8WAAmdjETo8cyZg6E2rPbXz4todjem5H3ZMkHJA2074o2hA
         Vg7ZT17zUeG7y2fIiIa0CmTakPwb2PV+pvned4HzXfiih4AMU80HWcYb8wkC3F0CNK
         DIKxLTcYj++aPsPN8Nz8468m/erZn/hFfMsePglk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 146JIiDv097500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 May 2021 14:18:44 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 6 May
 2021 14:18:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 6 May 2021 14:18:43 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 146JIUNF026052;
        Thu, 6 May 2021 14:18:41 -0500
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
Subject: [PATCH 3/6] mtd: spi-nor: micron-st: write 2 bytes when disabling Octal DTR mode
Date:   Fri, 7 May 2021 00:48:26 +0530
Message-ID: <20210506191829.8271-4-p.yadav@ti.com>
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

