Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAC1E76C5
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgE2HhM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 03:37:12 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:24787 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgE2HhM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 03:37:12 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04T7aHq1067318;
        Fri, 29 May 2020 15:36:21 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 5/7] mtd: spi-nor: core: execute command sequences to change octal DTR mode
Date:   Fri, 29 May 2020 15:36:13 +0800
Message-Id: <1590737775-4798-6-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04T7aHq1067318
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Execute command sequences to change octal DTR mode.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index fed6236..c8cd0c6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -347,6 +347,77 @@ int spi_nor_write_cr2(struct spi_nor *nor, u32 addr, u8 *cr2)
 }
 
 /**
+ * spi_nor_cmd_seq_octal_dtr() - command sequences to change to octal DTR mode
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	enable Octal DTR.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_cmd_seq_octal_dtr(struct spi_nor *nor, bool enable)
+{
+	struct spi_nor_flash_parameter *p = nor->params;
+	struct cmd_seq_octal_dtr *cs = p->cmd_seq;
+	int i, ret;
+	struct spi_mem_op op;
+
+	if (!nor->spimem || !p->cmd_seq[0].len)
+		return -ENOTSUPP;
+
+	if (!enable)
+		return 0;
+
+	for (i = 0; i < CMD_SEQ_NUM; i++) {
+		switch (p->cmd_seq[i].len) {
+		case 1:
+			op = (struct spi_mem_op)
+				SPI_MEM_OP(SPI_MEM_OP_CMD(cs[i].opcode, 1),
+					   SPI_MEM_OP_NO_ADDR,
+					   SPI_MEM_OP_NO_DUMMY,
+					   SPI_MEM_OP_NO_DATA);
+
+			ret = spi_mem_exec_op(nor->spimem, &op);
+			if (ret)
+				return ret;
+			break;
+
+		case 3:
+			op = (struct spi_mem_op)
+				SPI_MEM_OP(SPI_MEM_OP_CMD(cs[i].opcode, 1),
+					   SPI_MEM_OP_ADDR(1, cs[i].addr, 1),
+					   SPI_MEM_OP_NO_DUMMY,
+					   SPI_MEM_OP_DATA_OUT(1,
+							       &cs[i].data, 1));
+
+			ret = spi_mem_exec_op(nor->spimem, &op);
+			if (ret)
+				return ret;
+			break;
+
+		case 6:
+			op = (struct spi_mem_op)
+				SPI_MEM_OP(SPI_MEM_OP_CMD(cs[i].opcode, 1),
+					   SPI_MEM_OP_ADDR(4, cs[i].addr, 1),
+					   SPI_MEM_OP_NO_DUMMY,
+					   SPI_MEM_OP_DATA_OUT(1,
+							       &cs[i].data, 1));
+
+			ret = spi_mem_exec_op(nor->spimem, &op);
+			if (ret)
+				return ret;
+			break;
+
+		default:
+			dev_err(nor->dev,
+				"Error %d sequences to Octal DTR\n",
+				p->cmd_seq[i].len);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/**
  * spi_nor_read_sr() - Read the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  * @sr:		pointer to a DMA-able buffer where the value of the
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 0eb07ca..e4cf20a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -436,6 +436,7 @@ struct spi_nor_manufacturer {
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_read_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
 int spi_nor_write_cr2(struct spi_nor *nor, u32 addr, u8 *cr2);
+int spi_nor_cmd_seq_octal_dtr(struct spi_nor *nor, bool enable);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
-- 
1.9.1

