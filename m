Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6207249DDAA
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 10:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiA0JSX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jan 2022 04:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiA0JSW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jan 2022 04:18:22 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA4C061714
        for <linux-spi@vger.kernel.org>; Thu, 27 Jan 2022 01:18:22 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 79A97100009;
        Thu, 27 Jan 2022 09:18:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v10 05/13] spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
Date:   Thu, 27 Jan 2022 10:18:00 +0100
Message-Id: <20220127091808.1043392-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Now that spi_mem_default_supports_op() has access to the static
controller capabilities (relating to memory operations), and now that
these capabilities have been filled by the relevant controllers, there
is no need for a specific helper checking only DTR operations, so let's
just kill spi_mem_dtr_supports_op() and simply use
spi_mem_default_supports_op() instead.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-6-miquel.raynal@bootlin.com
---
 drivers/spi/spi-cadence-quadspi.c |  5 +----
 drivers/spi/spi-mem.c             | 10 ----------
 drivers/spi/spi-mxic.c            | 10 +---------
 include/linux/spi/spi-mem.h       | 11 -----------
 4 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 455b90d1feed..b0c9f62ccefb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1441,10 +1441,7 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	if (!(all_true || all_false))
 		return false;
 
-	if (all_true)
-		return spi_mem_dtr_supports_op(mem, op);
-	else
-		return spi_mem_default_supports_op(mem, op);
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 86e6597bc3dc..ed966d8129eb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -160,16 +160,6 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 	return true;
 }
 
-bool spi_mem_dtr_supports_op(struct spi_mem *mem,
-			     const struct spi_mem_op *op)
-{
-	if (op->cmd.nbytes != 2)
-		return false;
-
-	return spi_mem_check_buswidth(mem, op);
-}
-EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
-
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 9952fcdf3627..6bec0a7c77d3 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -335,8 +335,6 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
-	bool all_false;
-
 	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
 	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8)
 		return false;
@@ -348,13 +346,7 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes > 7)
 		return false;
 
-	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
-		    !op->data.dtr;
-
-	if (all_false)
-		return spi_mem_default_supports_op(mem, op);
-	else
-		return spi_mem_dtr_supports_op(mem, op);
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static int mxic_spi_mem_exec_op(struct spi_mem *mem,
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 38e5d45c9842..4a1bfe689872 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -330,10 +330,6 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op);
-
-bool spi_mem_dtr_supports_op(struct spi_mem *mem,
-			     const struct spi_mem_op *op);
-
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
@@ -356,13 +352,6 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 {
 	return false;
 }
-
-static inline
-bool spi_mem_dtr_supports_op(struct spi_mem *mem,
-			     const struct spi_mem_op *op)
-{
-	return false;
-}
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
-- 
2.27.0

