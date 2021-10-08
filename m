Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E100426EA3
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJHQYm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 12:24:42 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60925 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhJHQYl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 12:24:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DF421240012;
        Fri,  8 Oct 2021 16:22:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaimeliao@mxic.com.tw,
        juliensu@mxic.com.tw,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [RFC PATCH 05/10] mtd: nand: ecc: Add infrastructure to support hardware engines
Date:   Fri,  8 Oct 2021 18:22:23 +0200
Message-Id: <20211008162228.1753083-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the necessary helpers to register/unregister hardware ECC engines
that will be called from ECC engine drivers.

Also add helpers to get the right engine from the user
perspective. Keep a reference of the in use ECC engine in order to
prevent modules to be unloaded. Put the reference when the engine gets
retired.

A static list of hardware (only) ECC engines is setup to keep track of
the registered engines.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/core.c  | 10 +++--
 drivers/mtd/nand/ecc.c   | 89 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/nand.h | 11 +++++
 3 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index df9646685c91..5628bd410f7e 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -232,7 +232,9 @@ static int nanddev_get_ecc_engine(struct nand_device *nand)
 		nand->ecc.engine = nand_ecc_get_on_die_hw_engine(nand);
 		break;
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
-		pr_err("On-host hardware ECC engines not supported yet\n");
+		nand->ecc.engine = nand_ecc_get_on_host_hw_engine(nand);
+		if (PTR_ERR(nand->ecc.engine) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		break;
 	default:
 		pr_err("Missing ECC engine type\n");
@@ -252,7 +254,7 @@ static int nanddev_put_ecc_engine(struct nand_device *nand)
 {
 	switch (nand->ecc.ctx.conf.engine_type) {
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
-		pr_err("On-host hardware ECC engines not supported yet\n");
+		nand_ecc_put_on_host_hw_engine(nand);
 		break;
 	case NAND_ECC_ENGINE_TYPE_NONE:
 	case NAND_ECC_ENGINE_TYPE_SOFT:
@@ -297,7 +299,9 @@ int nanddev_ecc_engine_init(struct nand_device *nand)
 	/* Look for the ECC engine to use */
 	ret = nanddev_get_ecc_engine(nand);
 	if (ret) {
-		pr_err("No ECC engine found\n");
+		if (ret != -EPROBE_DEFER)
+			pr_err("No ECC engine found\n");
+
 		return ret;
 	}
 
diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
index 6c43dfda01d4..3aa56c990d11 100644
--- a/drivers/mtd/nand/ecc.c
+++ b/drivers/mtd/nand/ecc.c
@@ -96,6 +96,12 @@
 #include <linux/module.h>
 #include <linux/mtd/nand.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+static LIST_HEAD(on_host_hw_engines);
+static DEFINE_MUTEX(on_host_hw_engines_mutex);
 
 /**
  * nand_ecc_init_ctx - Init the ECC engine context
@@ -611,6 +617,89 @@ struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand)
 }
 EXPORT_SYMBOL(nand_ecc_get_on_die_hw_engine);
 
+int nand_ecc_register_on_host_hw_engine(struct nand_ecc_engine *engine)
+{
+	struct nand_ecc_engine *item;
+
+	if (!engine)
+		return -ENOTSUPP;
+
+	/* Prevent multiple registrations of one engine */
+	list_for_each_entry(item, &on_host_hw_engines, node)
+		if (item == engine)
+			return 0;
+
+	mutex_lock(&on_host_hw_engines_mutex);
+	list_add_tail(&engine->node, &on_host_hw_engines);
+	mutex_unlock(&on_host_hw_engines_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(nand_ecc_register_on_host_hw_engine);
+
+int nand_ecc_unregister_on_host_hw_engine(struct nand_ecc_engine *engine)
+{
+	if (!engine)
+		return -ENOTSUPP;
+
+	mutex_lock(&on_host_hw_engines_mutex);
+	list_del(&engine->node);
+	mutex_unlock(&on_host_hw_engines_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(nand_ecc_unregister_on_host_hw_engine);
+
+struct nand_ecc_engine *nand_ecc_match_on_host_hw_engine(struct device *dev)
+{
+	struct nand_ecc_engine *item;
+
+	list_for_each_entry(item, &on_host_hw_engines, node)
+		if (item->dev == dev)
+			return item;
+
+	return NULL;
+}
+EXPORT_SYMBOL(nand_ecc_match_on_host_hw_engine);
+
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand)
+{
+	struct nand_ecc_engine *engine = NULL;
+	struct device *dev = &nand->mtd.dev;
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	if (list_empty(&on_host_hw_engines))
+		return NULL;
+
+	/* Check for an explicit nand-ecc-engine property */
+	np = of_parse_phandle(dev->of_node, "nand-ecc-engine", 0);
+	if (np) {
+		pdev = of_find_device_by_node(np);
+		if (!pdev)
+			return ERR_PTR(-EPROBE_DEFER);
+
+		engine = nand_ecc_match_on_host_hw_engine(&pdev->dev);
+		platform_device_put(pdev);
+		of_node_put(np);
+
+		if (!engine)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (engine)
+		get_device(engine->dev);
+
+	return engine;
+}
+EXPORT_SYMBOL(nand_ecc_get_on_host_hw_engine);
+
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand)
+{
+	put_device(nand->ecc.engine->dev);
+}
+EXPORT_SYMBOL(nand_ecc_put_on_host_hw_engine);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("Generic ECC engine");
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 32fc7edf65b3..5ffd3e359515 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -265,10 +265,16 @@ struct nand_ecc_engine_ops {
 
 /**
  * struct nand_ecc_engine - ECC engine abstraction for NAND devices
+ * @dev: Host device
+ * @node: Private field for registration time
  * @ops: ECC engine operations
+ * @priv: Private data
  */
 struct nand_ecc_engine {
+	struct device *dev;
+	struct list_head node;
 	struct nand_ecc_engine_ops *ops;
+	void *priv;
 };
 
 void of_get_nand_ecc_user_config(struct nand_device *nand);
@@ -279,8 +285,13 @@ int nand_ecc_prepare_io_req(struct nand_device *nand,
 int nand_ecc_finish_io_req(struct nand_device *nand,
 			   struct nand_page_io_req *req);
 bool nand_ecc_is_strong_enough(struct nand_device *nand);
+int nand_ecc_register_on_host_hw_engine(struct nand_ecc_engine *engine);
+int nand_ecc_unregister_on_host_hw_engine(struct nand_ecc_engine *engine);
 struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand);
 struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_match_on_host_hw_engine(struct device *dev);
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand);
 
 #if IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING)
 struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void);
-- 
2.27.0

