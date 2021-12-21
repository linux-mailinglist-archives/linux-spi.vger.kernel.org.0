Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAA47C550
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbhLURsx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 12:48:53 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33383 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhLURsw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 12:48:52 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8305C200006;
        Tue, 21 Dec 2021 17:48:50 +0000 (UTC)
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
Subject: [PATCH v8 02/14] spi: spi-mem: Introduce a capability structure
Date:   Tue, 21 Dec 2021 18:48:32 +0100
Message-Id: <20211221174844.56385-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211221174844.56385-1-miquel.raynal@bootlin.com>
References: <20211221174844.56385-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Create a spi_controller_mem_caps structure and put it within the
spi_controller_mem_ops structure as these are highly related. So far the
only field in this structure is the support for dtr operations, but soon
we will add another parameter.

Also create a helper to parse the capabilities and check if the
requested capability has been set or not.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..045ecb7c6f50 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -220,6 +220,17 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 	return mem->drvpriv;
 }
 
+/**
+ * struct spi_controller_mem_caps - SPI memory controller capabilities
+ * @dtr: Supports DTR operations
+ */
+struct spi_controller_mem_caps {
+	bool dtr;
+};
+
+#define spi_mem_controller_is_capable(ctlr, cap)		\
+	((ctlr)->mem_ops->caps && (ctlr)->mem_ops->caps->cap)	\
+
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
@@ -253,6 +264,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @caps: controller capabilities for the handling of the above operations.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -283,6 +295,7 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	const struct spi_controller_mem_caps *caps;
 };
 
 /**
-- 
2.27.0

