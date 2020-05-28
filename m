Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6887B1E5A13
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgE1H7k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 03:59:40 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:31277 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgE1H7V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 03:59:21 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04S7wMHb030973;
        Thu, 28 May 2020 15:58:24 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 02/14] spi: spi-mem: allow specifying a command's extension
Date:   Thu, 28 May 2020 15:58:04 +0800
Message-Id: <1590652696-8844-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04S7wMHb030973
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
the "command extension". There can be 3 types of extensions in xSPI:
repeat, invert, and hex. When the extension type is "repeat", the same
opcode is sent twice. When it is "invert", the second byte is the
inverse of the opcode. When it is "hex" an additional opcode byte based
is sent with the command whose value can be anything.

So, make opcode a 16-bit value and add a 'nbytes', similar to how
multiple address widths are handled.

Some places use sizeof(op->cmd.opcode). Replace them with op->cmd.nbytes

The spi-mxic and spi-zynq-qspi drivers directly use op->cmd.opcode as a
buffer. Now that opcode is a 2-byte field, this can result in different
behaviour depending on if the machine is little endian or big endian.
Extract the opcode in a local 1-byte variable and use that as the buffer
instead. Both these drivers would reject multi-byte opcodes in their
supports_op() hook anyway, so we only need to worry about single-byte
opcodes for now.

The above two changes are put in this commit to keep the series
bisectable.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c       | 13 +++++++------
 drivers/spi/spi-mtk-nor.c   |  4 ++--
 drivers/spi/spi-zynq-qspi.c | 11 ++++++-----
 include/linux/spi/spi-mem.h |  6 +++++-
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index d8905e0..a0366ff 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -157,6 +157,9 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
 		return false;
 
+	if (op->cmd.nbytes != 1)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
@@ -171,7 +174,7 @@ static bool spi_mem_buswidth_is_valid(u8 buswidth)
 
 static int spi_mem_check_op(const struct spi_mem_op *op)
 {
-	if (!op->cmd.buswidth)
+	if (!op->cmd.buswidth || !op->cmd.nbytes)
 		return -EINVAL;
 
 	if ((op->addr.nbytes && !op->addr.buswidth) ||
@@ -307,8 +310,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 			return ret;
 	}
 
-	tmpbufsize = sizeof(op->cmd.opcode) + op->addr.nbytes +
-		     op->dummy.nbytes;
+	tmpbufsize = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 
 	/*
 	 * Allocate a buffer to transmit the CMD, ADDR cycles with kmalloc() so
@@ -323,7 +325,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	tmpbuf[0] = op->cmd.opcode;
 	xfers[xferpos].tx_buf = tmpbuf;
-	xfers[xferpos].len = sizeof(op->cmd.opcode);
+	xfers[xferpos].len = op->cmd.nbytes;
 	xfers[xferpos].tx_nbits = op->cmd.buswidth;
 	spi_message_add_tail(&xfers[xferpos], &msg);
 	xferpos++;
@@ -425,8 +427,7 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
 	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
-		len = sizeof(op->cmd.opcode) + op->addr.nbytes +
-		      op->dummy.nbytes;
+		len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 
 		if (len > spi_max_transfer_size(mem->spi))
 			return -EINVAL;
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index c15a991..d1f4cfc 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -195,7 +195,7 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 		}
 	}
 
-	len = MTK_NOR_PRG_MAX_SIZE - sizeof(op->cmd.opcode) - op->addr.nbytes -
+	len = MTK_NOR_PRG_MAX_SIZE - op->cmd.nbytes - op->addr.nbytes -
 	      op->dummy.nbytes;
 	if (op->data.nbytes > len)
 		op->data.nbytes = len;
@@ -219,7 +219,7 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 			       (op->dummy.buswidth == 0) &&
 			       (op->data.buswidth == 1);
 	}
-	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
+	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 	if ((len > MTK_NOR_PRG_MAX_SIZE) ||
 	    ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
 		return false;
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 1764115..bbf3d90 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -527,20 +527,21 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
 	int err = 0, i;
 	u8 *tmpbuf;
+	u8 opcode = op->cmd.opcode;
 
 	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
-		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		opcode, op->cmd.buswidth, op->addr.buswidth,
 		op->dummy.buswidth, op->data.buswidth);
 
 	zynq_qspi_chipselect(mem->spi, true);
 	zynq_qspi_config_op(xqspi, mem->spi);
 
-	if (op->cmd.opcode) {
+	if (op->cmd.nbytes) {
 		reinit_completion(&xqspi->data_completion);
-		xqspi->txbuf = (u8 *)&op->cmd.opcode;
+		xqspi->txbuf = &opcode;
 		xqspi->rxbuf = NULL;
-		xqspi->tx_bytes = sizeof(op->cmd.opcode);
-		xqspi->rx_bytes = sizeof(op->cmd.opcode);
+		xqspi->tx_bytes = op->cmd.nbytes;
+		xqspi->rx_bytes = op->cmd.nbytes;
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index e3dcb95..159463c 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -17,6 +17,7 @@
 	{							\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
+		.nbytes = 1,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
@@ -69,6 +70,8 @@ enum spi_mem_data_dir {
 
 /**
  * struct spi_mem_op - describes a SPI memory operation
+ * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
+ *		sent MSB-first.
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
  * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
@@ -94,9 +97,10 @@ enum spi_mem_data_dir {
  */
 struct spi_mem_op {
 	struct {
+		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
-		u8 opcode;
+		u16 opcode;
 	} cmd;
 
 	struct {
-- 
1.9.1

