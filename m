Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15E21B7E15
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgDXSpH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 14:45:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44024 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgDXSpG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Apr 2020 14:45:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OIipPx102796;
        Fri, 24 Apr 2020 13:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587753891;
        bh=+jepDXSfYfhqn1Grk7ZhPEamfAFpPI5NMwOs7iuBpr4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rCsMxsNTogOLSAmuC3KzHXPYtHRWez+H9s6RMpUkhyNwVNXnnWbHhWFzswPe57wXj
         mqF0NXwRfcAl+9aMa8eRaJ4UpZkMnkBtTuMR5BBELU9ItsIeziOvmkHJ52H6t+6d+x
         edf9YDIPwj7ojvb3fz6iEBzs0qInp0R/TWaoy4t4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OIipLr065197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 13:44:51 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 13:44:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 13:44:51 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiAaF047967;
        Fri, 24 Apr 2020 13:44:47 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v4 09/16] mtd: spi-nor: use dummy cycle and address width info from SFDP
Date:   Sat, 25 Apr 2020 00:14:03 +0530
Message-ID: <20200424184410.8578-10-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200424184410.8578-1-p.yadav@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The xSPI Profile 1.0 table specifies how many dummy cycles and address
bytes are needed for the Read Status Register command in octal DTR mode.
Use that information to send the correct Read SR command.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9c92fc897fb4..3d181c7deda7 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -357,6 +357,8 @@ int spi_nor_write_disable(struct spi_nor *nor)
 static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
+	u8 addr_bytes = nor->params->rdsr_addr_nbytes;
+	u8 dummy = nor->params->rdsr_dummy;
 
 	if (nor->spimem) {
 		struct spi_mem_op op =
@@ -365,10 +367,21 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr, 1));
 
+		if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
+			op.addr.nbytes = addr_bytes;
+			op.addr.val = 0;
+			op.dummy.nbytes = dummy;
+		}
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
-						    sr, 1);
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
+							    sr, 1);
 	}
 
 	if (ret)
@@ -388,6 +401,8 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 {
 	int ret;
+	u8 addr_bytes = nor->params->rdsr_addr_nbytes;
+	u8 dummy = nor->params->rdsr_dummy;
 
 	if (nor->spimem) {
 		struct spi_mem_op op =
@@ -396,6 +411,12 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, fsr, 1));
 
+		if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
+			op.addr.nbytes = addr_bytes;
+			op.addr.val = 0;
+			op.dummy.nbytes = dummy;
+		}
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-- 
2.25.0

