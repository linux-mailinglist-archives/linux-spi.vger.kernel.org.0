Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE14741AC
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 12:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhLNLl4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 06:41:56 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42629 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhLNLl4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 06:41:56 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2A9D3240009;
        Tue, 14 Dec 2021 11:41:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 05/13] spi: spi-mem: Export the spi_mem_generic_supports_op() helper
Date:   Tue, 14 Dec 2021 12:41:32 +0100
Message-Id: <20211214114140.54629-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211214114140.54629-1-miquel.raynal@bootlin.com>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
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
instead of creating yet another set of helpers each time we want to
check something new. In the future if we see that many different drivers
use the same parameter values, we might be tempted to create a specific
helper for that. But for now, let's just make the generic one
available.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       |  7 ++++---
 include/linux/spi/spi-mem.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 4c6944d7b174..df2ec2c8ce31 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -160,9 +160,9 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 	return true;
 }
 
-static bool spi_mem_generic_supports_op(struct spi_mem *mem,
-					const struct spi_mem_op *op,
-					struct spi_mem_controller_caps *caps)
+bool spi_mem_generic_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op,
+				 struct spi_mem_controller_caps *caps)
 {
 	if (!caps->dtr) {
 		if (op->cmd.dtr || op->addr.dtr ||
@@ -178,6 +178,7 @@ static bool spi_mem_generic_supports_op(struct spi_mem *mem,
 
 	return spi_mem_check_buswidth(mem, op);
 }
+EXPORT_SYMBOL_GPL(spi_mem_generic_supports_op);
 
 bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op)
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f365efcfb719..a17dd5035530 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -325,6 +325,10 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
 
+bool spi_mem_generic_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op,
+				 struct spi_mem_controller_caps *caps);
+
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op);
 
@@ -347,6 +351,14 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 {
 }
 
+static inline
+bool spi_mem_generic_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op,
+				 struct spi_mem_controller_caps *caps)
+{
+	return false;
+}
+
 static inline
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
-- 
2.27.0

