Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B94337D69
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCKTMw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:12:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44262 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhCKTMs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:12:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCVCb072885;
        Thu, 11 Mar 2021 13:12:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615489951;
        bh=D5mUrZ0LNwosvF5ATru7HapQyEd98umXGOgLCaoP3sw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uuc5i95sn4KgiTb/lI14qNmWTK3ywbnDfpsffrVSKfIeXKzkU3D8y9QeVH9OfS0Vj
         45Ka76C5qkhfyRgWs0H2yvHUmd9qQP4+LXNL9vRPA5CnVZvhIIaIxf7SYw52NtPQkb
         hdeyZ0IB9CAoeSAcNYOMdL1CitHsRnkRkoH+YEGo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BJCVUV110439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 13:12:31 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 13:12:31 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 13:12:31 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCHvT080816;
        Thu, 11 Mar 2021 13:12:27 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH 2/6] mtd: spi-nor: core: consolidate read op creation
Date:   Fri, 12 Mar 2021 00:42:12 +0530
Message-ID: <20210311191216.7363-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311191216.7363-1-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently the spi_mem_op to read from the flash is used in two places:
spi_nor_create_read_dirmap() and spi_nor_spimem_read_data(). In a later
commit this number will increase to three. Instead of repeating the same
code thrice, add a function that returns a template of the read op. The
callers can then fill in the details like address, data length, data
buffer location.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 62 ++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4a315cb1c4db..88888df009f0 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -183,6 +183,33 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 	return nor->controller_ops->erase(nor, offs);
 }
 
+/**
+ * spi_nor_spimem_get_read_op() - return a template for the spi_mem_op used for
+ *                                reading data from the flash via spi-mem.
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: A template of the 'struct spi_mem_op' for used for reading data from
+ * the flash. The caller is expected to fill in the address, data length, and
+ * the data buffer.
+ */
+static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
+			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DATA_IN(1, NULL, 0));
+
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
+
+	return op;
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -196,21 +223,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 					size_t len, u8 *buf)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-			   SPI_MEM_OP_ADDR(nor->addr_width, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-			   SPI_MEM_OP_DATA_IN(len, buf, 0));
+	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
 	bool usebouncebuf;
 	ssize_t nbytes;
 	int error;
 
-	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
+	op.addr.val = from;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -3581,28 +3601,10 @@ EXPORT_SYMBOL_GPL(spi_nor_scan);
 static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
-		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
-				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.op_tmpl = spi_nor_spimem_get_read_op(nor),
 		.offset = 0,
 		.length = nor->mtd.size,
 	};
-	struct spi_mem_op *op = &info.op_tmpl;
-
-	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
-	/*
-	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
-	 * of data bytes is non-zero, the data buswidth won't be set here. So,
-	 * do it explicitly.
-	 */
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
-- 
2.30.0

