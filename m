Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D846F24A
	for <lists+linux-spi@lfdr.de>; Thu,  9 Dec 2021 18:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbhLIRog (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Dec 2021 12:44:36 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:33369 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbhLIRoa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Dec 2021 12:44:30 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D7C76240003;
        Thu,  9 Dec 2021 17:40:54 +0000 (UTC)
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
Subject: [PATCH v4 03/12] spi: spi-mem: Create a helper to gather all the supports_op checks
Date:   Thu,  9 Dec 2021 18:40:37 +0100
Message-Id: <20211209174046.535229-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211209174046.535229-1-miquel.raynal@bootlin.com>
References: <20211209174046.535229-1-miquel.raynal@bootlin.com>
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
checks in a single generic function. This new helper will be called by
the exported functions, directly used by the different drivers.

Then, in a second time, we will add an ECC check and allow this new
helper to be directly used to avoid increasing dramatically the number
of new helpers needed to cover the {dtr-on/dtr-off, ecc-on/ecc-off}
situations, and perhaps others too. It will always be possible to create
abstraction helpers in the future if a particular combination is
regularly used.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 37f4443ce9a0..013efaaaac75 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -160,26 +160,36 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 	return true;
 }
 
+static bool spi_mem_generic_supports_op(struct spi_mem *mem,
+					const struct spi_mem_op *op,
+					bool dtr)
+{
+	if (!dtr) {
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
-
-	return spi_mem_check_buswidth(mem, op);
+	return spi_mem_generic_supports_op(mem, op, true);
 }
 EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
 
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
-
-	if (op->cmd.nbytes != 1)
-		return false;
-
-	return spi_mem_check_buswidth(mem, op);
+	return spi_mem_generic_supports_op(mem, op, false);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 
-- 
2.27.0

