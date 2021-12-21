Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E147C555
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbhLURtA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 12:49:00 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:60161 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhLURtA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 12:49:00 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id ED180200003;
        Tue, 21 Dec 2021 17:48:57 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v8 07/14] spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
Date:   Tue, 21 Dec 2021 18:48:37 +0100
Message-Id: <20211221174844.56385-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211221174844.56385-1-miquel.raynal@bootlin.com>
References: <20211221174844.56385-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Soon the SPI-NAND core will need a way to request a SPI controller to
enable ECC support for a given operation. This is because of the
pipelined integration of certain ECC engines, which are directly managed
by the SPI controller itself.

Introduce a spi_mem_op additional field for this purpose: ecc.

So far this field is left unset and checked to be false by all
the SPI controller drivers in their ->supports_op() hook, as they all
call spi_mem_default_supports_op().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c       | 5 +++++
 include/linux/spi/spi-mem.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index ccc606f741ae..3ff39771cdd4 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -190,6 +190,11 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 			return false;
 	}
 
+	if (op->data.ecc) {
+		if (!spi_mem_controller_is_capable(ctlr, ecc))
+			return false;
+	}
+
 	return spi_mem_check_buswidth(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index d7787c8f3746..a8e8287fdbd0 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -89,6 +89,7 @@ enum spi_mem_data_dir {
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
  *		 operation does not involve transferring data
@@ -119,6 +120,7 @@ struct spi_mem_op {
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		union {
@@ -126,6 +128,7 @@ struct spi_mem_op {
 			const void *out;
 		} buf;
 	} data;
+
 };
 
 #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
@@ -223,9 +226,11 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 /**
  * struct spi_controller_mem_caps - SPI memory controller capabilities
  * @dtr: Supports DTR operations
+ * @ecc: Supports operations with error correction
  */
 struct spi_controller_mem_caps {
 	bool dtr;
+	bool ecc;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)		\
-- 
2.27.0

