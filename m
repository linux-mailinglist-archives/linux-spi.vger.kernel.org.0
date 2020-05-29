Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C341E76CA
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgE2HhP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 03:37:15 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:24803 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgE2HhO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 03:37:14 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04T7aHq0067318;
        Fri, 29 May 2020 15:36:21 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 4/7] mtd: spi-nor: core: add configuration register 2 read & write support
Date:   Fri, 29 May 2020 15:36:12 +0800
Message-Id: <1590737775-4798-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04T7aHq0067318
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Configuration register 2 is to set the device operation condition like
STR or DTR mode at address offset 0 and DQS mode at address offset 0x200.

Each device has various address offset for it's specific operatoin
setting.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h |  2 ++
 2 files changed, 80 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3799417..fed6236 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -269,6 +269,84 @@ int spi_nor_write_disable(struct spi_nor *nor)
 }
 
 /**
+ * spi_nor_read_cr2() - Read the Configuration Register 2.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @addr:	offset address to read.
+ * @cr2:	pointer to a DMA-able buffer where the value of the
+ *              Configuration Register 2  will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_read_cr2(struct spi_nor *nor, u32 addr, u8 *cr2)
+{
+	int ret;
+	u8 cmd = nor->params->rd_reg_cmd;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
+				   SPI_MEM_OP_ADDR(4, addr, 1),
+				   SPI_MEM_OP_DUMMY(4, 1),
+				   SPI_MEM_OP_DATA_IN(1, cr2, 1));
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->read_reg(nor, cmd, cr2, 1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d reading CR2\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_write_cr2() - Write the Configuration Register 2.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @addr:	offset address to write.
+ * @cr2:	pointer to a DMA-able buffer where the value of the
+ *              Configuratin Register 2 will be read.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_write_cr2(struct spi_nor *nor, u32 addr, u8 *cr2)
+{
+	int ret;
+	u8 cmd = nor->params->wr_reg_cmd;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
+				   SPI_MEM_OP_ADDR(4, addr, 1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, cr2, 1));
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		if (spi_nor_protocol_is_dtr(nor->reg_proto))
+			ret = -ENOTSUPP;
+		else
+			ret = nor->controller_ops->write_reg(nor, cmd, cr2, 1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d write CFG Reg 2\n", ret);
+
+	return ret;
+}
+
+/**
  * spi_nor_read_sr() - Read the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  * @sr:		pointer to a DMA-able buffer where the value of the
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 8de7f53..0eb07ca 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -434,6 +434,8 @@ struct spi_nor_manufacturer {
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
+int spi_nor_read_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
+int spi_nor_write_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
-- 
1.9.1

