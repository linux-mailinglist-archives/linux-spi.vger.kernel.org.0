Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0136849DDA6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiA0JSS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jan 2022 04:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiA0JSR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jan 2022 04:18:17 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793FDC061714
        for <linux-spi@vger.kernel.org>; Thu, 27 Jan 2022 01:18:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BE2D6100002;
        Thu, 27 Jan 2022 09:18:12 +0000 (UTC)
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
Subject: [PATCH v10 01/13] spi: spi-mem: Introduce a capability structure
Date:   Thu, 27 Jan 2022 10:17:56 +0100
Message-Id: <20220127091808.1043392-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Create a spi_controller_mem_caps structure and put it within the
spi_controller structure close to the spi_controller_mem_ops
strucure. So far the only field in this structure is the support for dtr
operations, but soon we will add another parameter.

Also create a helper to parse the capabilities and check if the
requested capability has been set or not.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-2-miquel.raynal@bootlin.com
---
 include/linux/spi/spi-mem.h | 11 +++++++++++
 include/linux/spi/spi.h     |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..38e5d45c9842 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -285,6 +285,17 @@ struct spi_controller_mem_ops {
 			   unsigned long timeout_ms);
 };
 
+/**
+ * struct spi_controller_mem_caps - SPI memory controller capabilities
+ * @dtr: Supports DTR operations
+ */
+struct spi_controller_mem_caps {
+	bool dtr;
+};
+
+#define spi_mem_controller_is_capable(ctlr, cap)	\
+	((ctlr)->mem_caps && (ctlr)->mem_caps->cap)
+
 /**
  * struct spi_mem_driver - SPI memory driver
  * @spidrv: inherit from a SPI driver
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..cf99a1ee0e74 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,7 @@ struct ptp_system_timestamp;
 struct spi_controller;
 struct spi_transfer;
 struct spi_controller_mem_ops;
+struct spi_controller_mem_caps;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -415,6 +416,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @mem_ops: optimized/dedicated operations for interactions with SPI memory.
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
+ * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
  * @cs_gpios: LEGACY: array of GPIO descs to use as chip select lines; one per
@@ -639,6 +641,7 @@ struct spi_controller {
 
 	/* Optimized handlers for SPI memory-like operations. */
 	const struct spi_controller_mem_ops *mem_ops;
+	const struct spi_controller_mem_caps *mem_caps;
 
 	/* gpio chip select */
 	int			*cs_gpios;
-- 
2.27.0

