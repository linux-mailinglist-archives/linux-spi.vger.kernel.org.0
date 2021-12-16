Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E0476FF7
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhLPLRZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:25 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47673 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhLPLRZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:25 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9BEEFE0006;
        Thu, 16 Dec 2021 11:17:22 +0000 (UTC)
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
Subject: [PATCH v6 15/28] mtd: nand: ecc: Provide a helper to retrieve a pilelined engine device
Date:   Thu, 16 Dec 2021 12:16:41 +0100
Message-Id: <20211216111654.238086-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In a pipelined engine situation, we might either have the host which
internally has support for error correction, or have it using an
external hardware block for this purpose. In the former case, the host
is also the ECC engine. In the latter case, it is not. In order to get
the right pointers on the right devices (for example: in order to devm_*
allocate variables), let's introduce this helper which can safely be
called by pipelined ECC engines in order to retrieve the right device
structure.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc.c   | 31 +++++++++++++++++++++++++++++++
 include/linux/mtd/nand.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
index 078f5ec38de3..5250764cedee 100644
--- a/drivers/mtd/nand/ecc.c
+++ b/drivers/mtd/nand/ecc.c
@@ -699,6 +699,37 @@ void nand_ecc_put_on_host_hw_engine(struct nand_device *nand)
 }
 EXPORT_SYMBOL(nand_ecc_put_on_host_hw_engine);
 
+/*
+ * In the case of a pipelined engine, the device registering the ECC
+ * engine is not necessarily the ECC engine itself but may be a host controller.
+ * It is then useful to provide a helper to retrieve the right device object
+ * which actually represents the ECC engine.
+ */
+struct device *nand_ecc_get_engine_dev(struct device *host)
+{
+	struct platform_device *ecc_pdev;
+	struct device_node *np;
+
+	/*
+	 * If the device node contains this property, it means we need to follow
+	 * it in order to get the right ECC engine device we are looking for.
+	 */
+	np = of_parse_phandle(host->of_node, "nand-ecc-engine", 0);
+	if (!np)
+		return host;
+
+	ecc_pdev = of_find_device_by_node(np);
+	if (!ecc_pdev) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	platform_device_put(ecc_pdev);
+	of_node_put(np);
+
+	return &ecc_pdev->dev;
+}
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("Generic ECC engine");
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index b617efa0a881..615b3e3a3920 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -309,6 +309,7 @@ struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand);
 struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand);
 struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand);
 void nand_ecc_put_on_host_hw_engine(struct nand_device *nand);
+struct device *nand_ecc_get_engine_dev(struct device *host);
 
 #if IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING)
 struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void);
-- 
2.27.0

