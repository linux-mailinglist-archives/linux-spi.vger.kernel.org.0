Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6FB4741AA
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 12:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhLNLly (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 06:41:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:52795 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhLNLlx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 06:41:53 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4381E240007;
        Tue, 14 Dec 2021 11:41:51 +0000 (UTC)
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
Subject: [PATCH v5 04/13] spi: spi-mem: Create a helper to gather all the supports_op checks
Date:   Tue, 14 Dec 2021 12:41:31 +0100
Message-Id: <20211214114140.54629-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211214114140.54629-1-miquel.raynal@bootlin.com>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

So far we check the support for:
- regular operations
- dtr operations
Soon, we will also need to check the support for ECC operations.

As the combinatorial will increase exponentially, let's gather all the
checks in a single generic function which takes a capabilities structure
as input. This new helper is supposed to be called by the currently
exported functions instead of repeating a similar implementation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 34 +++++++++++++++++++++++++---------
 include/linux/spi/spi-mem.h |  8 ++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 37f4443ce9a0..4c6944d7b174 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -160,26 +160,42 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 	return true;
 }
 
+static bool spi_mem_generic_supports_op(struct spi_mem *mem,
+					const struct spi_mem_op *op,
+					struct spi_mem_controller_caps *caps)
+{
+	if (!caps->dtr) {
+		if (op->cmd.dtr || op->addr.dtr ||
+		    op->dummy.dtr || op->data.dtr)
+			return false;
+
+		if (op->cmd.nbytes != 1)
+			return false;
+	} else {
+		if (op->cmd.nbytes != 2)
+			return false;
+	}
+
+	return spi_mem_check_buswidth(mem, op);
+}
+
 bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op)
 {
-	if (op->cmd.nbytes != 2)
-		return false;
+	struct spi_mem_controller_caps caps = {
+		.dtr = true,
+	};
 
-	return spi_mem_check_buswidth(mem, op);
+	return spi_mem_generic_supports_op(mem, op, &caps);
 }
 EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
 
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
+	struct spi_mem_controller_caps caps = {};
 
-	if (op->cmd.nbytes != 1)
-		return false;
-
-	return spi_mem_check_buswidth(mem, op);
+	return spi_mem_generic_supports_op(mem, op, &caps);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..f365efcfb719 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -220,6 +220,14 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 	return mem->drvpriv;
 }
 
+/**
+ * struct spi_mem_controller_caps - SPI memory controller capabilities
+ * @dtr: Supports DTR operations
+ */
+struct spi_mem_controller_caps {
+	bool dtr;
+};
+
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
-- 
2.27.0

