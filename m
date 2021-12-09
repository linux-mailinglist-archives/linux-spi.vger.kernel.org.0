Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A951746F249
	for <lists+linux-spi@lfdr.de>; Thu,  9 Dec 2021 18:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhLIRof (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Dec 2021 12:44:35 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:53605 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbhLIRoc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Dec 2021 12:44:32 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CF0B424000C;
        Thu,  9 Dec 2021 17:40:56 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 04/12] spi: spi-mem: Add an ecc_en parameter to the spi_mem_op structure
Date:   Thu,  9 Dec 2021 18:40:38 +0100
Message-Id: <20211209174046.535229-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211209174046.535229-1-miquel.raynal@bootlin.com>
References: <20211209174046.535229-1-miquel.raynal@bootlin.com>
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

Introduce a spi_mem_op additional field for this purpose: ecc_en.

So far this field is left unset and checked to be false by all
the SPI controller drivers in their ->supports_op() hook, as they all
call spi_mem_default/dtr_supports_op().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 11 ++++++++---
 include/linux/spi/spi-mem.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 013efaaaac75..9e06cd918273 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -162,7 +162,7 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 
 static bool spi_mem_generic_supports_op(struct spi_mem *mem,
 					const struct spi_mem_op *op,
-					bool dtr)
+					bool dtr, bool ecc)
 {
 	if (!dtr) {
 		if (op->cmd.dtr || op->addr.dtr ||
@@ -176,20 +176,25 @@ static bool spi_mem_generic_supports_op(struct spi_mem *mem,
 			return false;
 	}
 
+	if (!ecc) {
+		if (op->ecc_en)
+			return false;
+	}
+
 	return spi_mem_check_buswidth(mem, op);
 }
 
 bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op)
 {
-	return spi_mem_generic_supports_op(mem, op, true);
+	return spi_mem_generic_supports_op(mem, op, true, false);
 }
 EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
 
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	return spi_mem_generic_supports_op(mem, op, false);
+	return spi_mem_generic_supports_op(mem, op, false, false);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..3be594be24c0 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -94,6 +94,7 @@ enum spi_mem_data_dir {
  *		 operation does not involve transferring data
  * @data.buf.in: input buffer (must be DMA-able)
  * @data.buf.out: output buffer (must be DMA-able)
+ * @ecc_en: error correction is required
  */
 struct spi_mem_op {
 	struct {
@@ -126,6 +127,8 @@ struct spi_mem_op {
 			const void *out;
 		} buf;
 	} data;
+
+	bool ecc_en;
 };
 
 #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
-- 
2.27.0

