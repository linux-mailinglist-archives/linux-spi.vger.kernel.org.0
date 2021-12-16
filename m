Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36951477007
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhLPLRj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:39 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36863 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhLPLRh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:37 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8EB73E000F;
        Thu, 16 Dec 2021 11:17:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 22/28] spi: spi-mem: Add an ecc_en parameter to the spi_mem_op structure
Date:   Thu, 16 Dec 2021 12:16:48 +0100
Message-Id: <20211216111654.238086-23-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
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
call spi_mem_default_supports_op().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 5 +++++
 include/linux/spi/spi-mem.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index aae1bc655299..e1c912c811a0 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -181,6 +181,11 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 			return false;
 	}
 
+	if (op->ecc_en) {
+		if (!ctlr->mem_ops->caps->ecc)
+			return false;
+	}
+
 	return spi_mem_check_buswidth(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index b413c8667af7..4fee978dc1b9 100644
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
 
 /**
-- 
2.27.0

