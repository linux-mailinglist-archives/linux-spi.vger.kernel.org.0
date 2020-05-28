Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75601E5A14
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgE1H7m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 03:59:42 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:31410 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgE1H7m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 03:59:42 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04S7wMHi030973;
        Thu, 28 May 2020 15:58:30 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 09/14] mtd: spi-nor: core: add configuration register 2 read & write support
Date:   Thu, 28 May 2020 15:58:11 +0800
Message-Id: <1590652696-8844-10-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04S7wMHi030973
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
index 642e3c0..117d117 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -347,6 +347,84 @@ int spi_nor_write_disable(struct spi_nor *nor)
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
index 101726c..91bc69a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -438,6 +438,8 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 			     const enum spi_nor_protocol proto);
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
+int spi_nor_read_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
+int spi_nor_write_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
-- 
1.9.1

