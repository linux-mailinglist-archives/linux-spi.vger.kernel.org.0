Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD9483E3B
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 09:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiADIgi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 03:36:38 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42969 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiADIgi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 03:36:38 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 852B21C0004;
        Tue,  4 Jan 2022 08:36:35 +0000 (UTC)
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
Subject: [PATCH v9 01/13] spi: spi-mem: Introduce a capability structure
Date:   Tue,  4 Jan 2022 09:36:19 +0100
Message-Id: <20220104083631.40776-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220104083631.40776-1-miquel.raynal@bootlin.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
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
index 8371bca13729..7ec6450142e0 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,7 @@ struct software_node;
 struct spi_controller;
 struct spi_transfer;
 struct spi_controller_mem_ops;
+struct spi_controller_mem_caps;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -419,6 +420,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @mem_ops: optimized/dedicated operations for interactions with SPI memory.
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
+ * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
  * @cs_gpios: LEGACY: array of GPIO descs to use as chip select lines; one per
@@ -640,6 +642,7 @@ struct spi_controller {
 
 	/* Optimized handlers for SPI memory-like operations. */
 	const struct spi_controller_mem_ops *mem_ops;
+	const struct spi_controller_mem_caps *mem_caps;
 
 	/* gpio chip select */
 	int			*cs_gpios;
-- 
2.27.0

