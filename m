Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE911D999D
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgESO2S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 10:28:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59218 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgESO2S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 10:28:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04JES3kH075360;
        Tue, 19 May 2020 09:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589898483;
        bh=ZfUbh82N6QxYzzf9GICZYBFd0OVcUih5gJ0g44AGOsU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wzwkFkO6GSt+aVHpELAqfFDjKKTrIhPqxIIz8ukKSEojI64RHuUegq6Inp9vwkfvr
         wiA+ojwUBtJQBE2mEeVekMnEV7RGuezf1LRJOddDdCI73Db3CjqWS+ioYobEhAReXh
         ZbiTKhqoy9QiSo9l8GYfRkNWAPXAmXhF4flUc5iI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04JES3qK082704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 09:28:03 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 09:28:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 09:28:03 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JEQgjX008313;
        Tue, 19 May 2020 09:27:58 -0500
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
Subject: [PATCH v5 15/19] mtd: spi-nor: core: perform a Soft Reset on shutdown
Date:   Tue, 19 May 2020 19:56:37 +0530
Message-ID: <20200519142642.24131-16-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200519142642.24131-1-p.yadav@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Perform a Soft Reset on shutdown on flashes that support it so that the
flash can be reset to its initial state and any configurations made by
spi-nor (given that they're only done in volatile registers) will be
reset. This will hand back the flash in pristine state for any further
operations on it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 42 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a94376344be5..68559386f6f8 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -40,6 +40,9 @@
 
 #define SPI_NOR_MAX_ADDR_WIDTH	4
 
+#define SPI_NOR_SRST_SLEEP_MIN 200
+#define SPI_NOR_SRST_SLEEP_MAX 400
+
 /**
  * spi_nor_get_cmd_ext() - Get the command opcode extension based on the
  *			   extension type.
@@ -3201,6 +3204,41 @@ static int spi_nor_init(struct spi_nor *nor)
 	return 0;
 }
 
+static void spi_nor_soft_reset(struct spi_nor *nor)
+{
+	struct spi_mem_op op;
+	int ret;
+
+	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 8),
+			SPI_MEM_OP_NO_DUMMY,
+			SPI_MEM_OP_NO_ADDR,
+			SPI_MEM_OP_NO_DATA);
+	spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret) {
+		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		return;
+	}
+
+	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRST, 8),
+			SPI_MEM_OP_NO_DUMMY,
+			SPI_MEM_OP_NO_ADDR,
+			SPI_MEM_OP_NO_DATA);
+	spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret) {
+		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		return;
+	}
+
+	/*
+	 * Software Reset is not instant, and the delay varies from flash to
+	 * flash. Looking at a few flashes, most range somewhere below 100
+	 * microseconds. So, sleep for a range of 200-400 us.
+	 */
+	usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
+}
+
 /* mtd resume handler */
 static void spi_nor_resume(struct mtd_info *mtd)
 {
@@ -3220,6 +3258,10 @@ void spi_nor_restore(struct spi_nor *nor)
 	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET)
 		nor->params->set_4byte_addr_mode(nor, false);
+
+	if (nor->info->flags & SPI_NOR_OCTAL_DTR_READ &&
+	    nor->flags & SNOR_F_SOFT_RESET)
+		spi_nor_soft_reset(nor);
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d251a5d02be2..06884a188315 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -51,6 +51,8 @@
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
+#define SPINOR_OP_SRSTEN	0x66	/* Software Reset Enable */
+#define SPINOR_OP_SRST		0x99	/* Software Reset */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
-- 
2.26.2

