Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA746F24E
	for <lists+linux-spi@lfdr.de>; Thu,  9 Dec 2021 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbhLIRoh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Dec 2021 12:44:37 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:37447 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbhLIRod (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Dec 2021 12:44:33 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 31EE6240008;
        Thu,  9 Dec 2021 17:40:58 +0000 (UTC)
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
Subject: [PATCH v4 05/12] spi: spi-mem: Export the spi_mem_generic_supports_op() helper
Date:   Thu,  9 Dec 2021 18:40:39 +0100
Message-Id: <20211209174046.535229-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211209174046.535229-1-miquel.raynal@bootlin.com>
References: <20211209174046.535229-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The combination of checks against the number of supported operations is
going to increase exponentially each time we add a new parameter. So far
we only had a dtr parameter. Now we are introducing an ECC parameter. We
need to make this helper available for drivers with specific needs,
instead of creating another set of helpers each time we want to check
something new. In the future if we see that many different drivers use
the same parameter values, we might be tempted to create a specific
helper for that. But for now, let's just make the generic one available.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       |  7 ++++---
 include/linux/spi/spi-mem.h | 13 +++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9e06cd918273..48b55395178f 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -160,9 +160,9 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 	return true;
 }
 
-static bool spi_mem_generic_supports_op(struct spi_mem *mem,
-					const struct spi_mem_op *op,
-					bool dtr, bool ecc)
+bool spi_mem_generic_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op,
+				 bool dtr, bool ecc)
 {
 	if (!dtr) {
 		if (op->cmd.dtr || op->addr.dtr ||
@@ -183,6 +183,7 @@ static bool spi_mem_generic_supports_op(struct spi_mem *mem,
 
 	return spi_mem_check_buswidth(mem, op);
 }
+EXPORT_SYMBOL_GPL(spi_mem_generic_supports_op);
 
 bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op)
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 3be594be24c0..07f637cbe77d 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -320,6 +320,10 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
 
+bool spi_mem_generic_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op,
+				 bool dtr, bool ecc);
+
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op);
 
@@ -327,6 +331,7 @@ bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op);
 
 #else
+
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 				   const struct spi_mem_op *op,
@@ -342,6 +347,14 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 {
 }
 
+static inline
+bool spi_mem_generic_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op,
+				 bool dtr, bool ecc)
+{
+	return false;
+}
+
 static inline
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
-- 
2.27.0

