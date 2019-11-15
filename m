Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2356FDA5A
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKOKEG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 05:04:06 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:20688 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOKEG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 05:04:06 -0500
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id xAF9005D047026
        for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2019 17:00:00 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id xAF8wWGu046218;
        Fri, 15 Nov 2019 16:58:33 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com,
        bbrezillon@kernel.org, tudor.ambarus@microchip.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 1/4] spi: spi-mem: Add support for Octal 8D-8D-8D mode
Date:   Fri, 15 Nov 2019 16:58:05 +0800
Message-Id: <1573808288-19365-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com xAF8wWGu046218
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

According to JESD216C SPI NORs are using 2 bytes opcodes
when operated in OPI (Octal Peripheral Interface).

To add extension command, command bytes number and
Double Transfer Rate(DTR) fields to the spi_mem_op struct.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/spi/spi-mem.c       |  8 +++++++-
 include/linux/spi/spi-mem.h | 13 +++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9f0fa9f..eb33dd85 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -154,6 +154,12 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 				   op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
 
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+
+	if (op->cmd.nbytes != 1)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
@@ -168,7 +174,7 @@ static bool spi_mem_buswidth_is_valid(u8 buswidth)
 
 static int spi_mem_check_op(const struct spi_mem_op *op)
 {
-	if (!op->cmd.buswidth)
+	if (!op->cmd.buswidth || op->cmd.nbytes < 1 || op->cmd.nbytes > 2)
 		return -EINVAL;
 
 	if ((op->addr.nbytes && !op->addr.buswidth) ||
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index af9ff2f..bf54079 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -17,6 +17,7 @@
 	{							\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
+		.nbytes = 1,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
@@ -69,11 +70,15 @@ enum spi_mem_data_dir {
 
 /**
  * struct spi_mem_op - describes a SPI memory operation
+ * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid)
  * @cmd.buswidth: number of IO lines used to transmit the command
+ * @cmd.dtr: set true to transfer opcode in double transfer rate mode
  * @cmd.opcode: operation opcode
+ * @cmd.ext_opcode: extension operation opcode
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: set true to transfer address bytes in double transfer rate mode
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
@@ -81,34 +86,42 @@ enum spi_mem_data_dir {
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
+ * @dummy.dtr: set true to transfer dummy bytes in double transfer rate mode
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
  *		 operation does not involve transferring data
+ * @data.dtr: set true to transfer data bytes in double transfer rate mode
  * @data.buf.in: input buffer (must be DMA-able)
  * @data.buf.out: output buffer (must be DMA-able)
  */
 struct spi_mem_op {
 	struct {
+		u8 nbytes;
 		u8 buswidth;
+		bool dtr;
 		u8 opcode;
+		u8 ext_opcode;
 	} cmd;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
+		bool dtr;
 		u64 val;
 	} addr;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
+		bool dtr;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
+		bool dtr;
 		union {
 			void *in;
 			const void *out;
-- 
1.9.1

