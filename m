Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87803477001
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhLPLRe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:34 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54505 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhLPLRe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:34 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4E0D0E000A;
        Thu, 16 Dec 2021 11:17:31 +0000 (UTC)
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
Subject: [PATCH v6 20/28] spi: spi-mem: Fill the spi-mem controller capabilities of all the drivers
Date:   Thu, 16 Dec 2021 12:16:46 +0100
Message-Id: <20211216111654.238086-21-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update all the spi controller drivers registering spi-mem operations to
provide a spi-mem capabilities structure.

For most of them, it is just a matter of referencing the newly created
spi_mem_no_caps empty structure. Only Cadence and Macronix SPI
controller drivers support DTR operations, so these two need to define
a non-empty set of capabilities.

Prevent any new controller to register a set of spi-mem operations
without a capabilities structure.

So far these capabilities are not used by the core, this is just a
preparation change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/atmel-quadspi.c       | 3 ++-
 drivers/spi/spi-bcm-qspi.c        | 1 +
 drivers/spi/spi-cadence-quadspi.c | 5 +++++
 drivers/spi/spi-dw-core.c         | 1 +
 drivers/spi/spi-fsl-qspi.c        | 1 +
 drivers/spi/spi-hisi-sfc-v3xx.c   | 1 +
 drivers/spi/spi-mem.c             | 3 +++
 drivers/spi/spi-mtk-nor.c         | 3 ++-
 drivers/spi/spi-mxic.c            | 5 +++++
 drivers/spi/spi-npcm-fiu.c        | 1 +
 drivers/spi/spi-nxp-fspi.c        | 1 +
 drivers/spi/spi-rockchip-sfc.c    | 1 +
 drivers/spi/spi-rpc-if.c          | 1 +
 drivers/spi/spi-stm32-qspi.c      | 1 +
 drivers/spi/spi-ti-qspi.c         | 1 +
 drivers/spi/spi-zynq-qspi.c       | 1 +
 drivers/spi/spi-zynqmp-gqspi.c    | 1 +
 drivers/spi/spi.c                 | 3 +++
 include/linux/spi/spi-mem.h       | 1 +
 19 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 95d4fa32c299..7d43ed8d124d 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -466,7 +466,8 @@ static const char *atmel_qspi_get_name(struct spi_mem *spimem)
 static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
 	.supports_op = atmel_qspi_supports_op,
 	.exec_op = atmel_qspi_exec_op,
-	.get_name = atmel_qspi_get_name
+	.get_name = atmel_qspi_get_name,
+	.caps = &spi_mem_no_caps,
 };
 
 static int atmel_qspi_setup(struct spi_device *spi)
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index a78e56f566dd..c43d46ea2534 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1258,6 +1258,7 @@ static void bcm_qspi_hw_uninit(struct bcm_qspi *qspi)
 
 static const struct spi_controller_mem_ops bcm_qspi_mem_ops = {
 	.exec_op = bcm_qspi_exec_mem_op,
+	.caps = &spi_mem_no_caps,
 };
 
 struct bcm_qspi_data {
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 101cc71bffa7..0622c7db52e6 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1388,10 +1388,15 @@ static const char *cqspi_get_name(struct spi_mem *mem)
 	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
 }
 
+const struct spi_controller_mem_caps cqspi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
+	.caps = &cqspi_mem_caps,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index a305074c482e..896e299a8c51 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -759,6 +759,7 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
 		dws->mem_ops.supports_op = dw_spi_supports_mem_op;
 		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
+		dws->mem_ops.caps = &spi_mem_no_caps;
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
 	}
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 9851551ebbe0..420d6d77c989 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -838,6 +838,7 @@ static const struct spi_controller_mem_ops fsl_qspi_mem_ops = {
 	.supports_op = fsl_qspi_supports_op,
 	.exec_op = fsl_qspi_exec_op,
 	.get_name = fsl_qspi_get_name,
+	.caps = &spi_mem_no_caps,
 };
 
 static int fsl_qspi_probe(struct platform_device *pdev)
diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index d3a23b1c2a4c..88eb061b7eb7 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -372,6 +372,7 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
 	.supports_op = hisi_sfc_v3xx_supports_op,
 	.exec_op = hisi_sfc_v3xx_exec_op,
+	.caps = &spi_mem_no_caps,
 };
 
 static irqreturn_t hisi_sfc_v3xx_isr(int irq, void *data)
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c4da0c9b05e9..bfd5c6b2db0a 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -160,6 +160,9 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 	return true;
 }
 
+const struct spi_controller_mem_caps spi_mem_no_caps = {};
+EXPORT_SYMBOL_GPL(spi_mem_no_caps);
+
 bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op)
 {
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 41e7b341d261..444b36d94c6d 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -740,7 +740,8 @@ static size_t mtk_max_msg_size(struct spi_device *spi)
 static const struct spi_controller_mem_ops mtk_nor_mem_ops = {
 	.adjust_op_size = mtk_nor_adjust_op_size,
 	.supports_op = mtk_nor_supports_op,
-	.exec_op = mtk_nor_exec_op
+	.exec_op = mtk_nor_exec_op,
+	.caps = &spi_mem_no_caps,
 };
 
 static const struct of_device_id mtk_nor_match[] = {
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 45889947afed..8f8530bd3779 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -443,9 +443,14 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	return ret;
 }
 
+const struct spi_controller_mem_caps mxic_spi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 	.supports_op = mxic_spi_mem_supports_op,
 	.exec_op = mxic_spi_mem_exec_op,
+	.caps = &mxic_spi_mem_caps,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index b62471ab6d7f..fc90180412e3 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -661,6 +661,7 @@ static const struct spi_controller_mem_ops npcm_fiu_mem_ops = {
 	.dirmap_create = npcm_fiu_dirmap_create,
 	.dirmap_read = npcm_fiu_direct_read,
 	.dirmap_write = npcm_fiu_direct_write,
+	.caps = &spi_mem_no_caps,
 };
 
 static const struct of_device_id npcm_fiu_dt_ids[] = {
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a66fa97046ee..bca0ccc20865 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1082,6 +1082,7 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 	.supports_op = nxp_fspi_supports_op,
 	.exec_op = nxp_fspi_exec_op,
 	.get_name = nxp_fspi_get_name,
+	.caps = &spi_mem_no_caps,
 };
 
 static int nxp_fspi_probe(struct platform_device *pdev)
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index a46b38544027..9f3f748fc724 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -533,6 +533,7 @@ static int rockchip_sfc_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *o
 static const struct spi_controller_mem_ops rockchip_sfc_mem_ops = {
 	.exec_op = rockchip_sfc_exec_mem_op,
 	.adjust_op_size = rockchip_sfc_adjust_op_size,
+	.caps = &spi_mem_no_caps,
 };
 
 static irqreturn_t rockchip_sfc_irq_handler(int irq, void *dev_id)
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index c53138ce0030..2317de928bbd 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -125,6 +125,7 @@ static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
 	.exec_op	= rpcif_spi_mem_exec_op,
 	.dirmap_create	= rpcif_spi_mem_dirmap_create,
 	.dirmap_read	= rpcif_spi_mem_dirmap_read,
+	.caps		= &spi_mem_no_caps,
 };
 
 static int rpcif_spi_probe(struct platform_device *pdev)
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 27f35aa2d746..163abc0eae05 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -677,6 +677,7 @@ static const struct spi_controller_mem_ops stm32_qspi_mem_ops = {
 	.dirmap_create	= stm32_qspi_dirmap_create,
 	.dirmap_read	= stm32_qspi_dirmap_read,
 	.poll_status	= stm32_qspi_poll_status,
+	.caps		= &spi_mem_no_caps,
 };
 
 static int stm32_qspi_probe(struct platform_device *pdev)
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index e06aafe169e0..062dd834d837 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -655,6 +655,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.exec_op = ti_qspi_exec_mem_op,
 	.adjust_op_size = ti_qspi_adjust_op_size,
+	.caps = &spi_mem_no_caps,
 };
 
 static int ti_qspi_start_transfer_one(struct spi_master *master,
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index cfa222c9bd5e..2f8b2bc94e63 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -615,6 +615,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 static const struct spi_controller_mem_ops zynq_qspi_mem_ops = {
 	.supports_op = zynq_qspi_supports_op,
 	.exec_op = zynq_qspi_exec_mem_op,
+	.caps = &spi_mem_no_caps,
 };
 
 /**
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 328b6559bb19..f7e53d4aabd2 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1082,6 +1082,7 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 
 static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 	.exec_op = zynqmp_qspi_exec_op,
+	.caps = &spi_mem_no_caps,
 };
 
 /**
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 57e2499ec1ed..58c5cb985431 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2747,6 +2747,9 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
 	if (ctlr->mem_ops) {
 		if (!ctlr->mem_ops->exec_op)
 			return -EINVAL;
+
+		if (!ctlr->mem_ops->caps)
+			return -EINVAL;
 	} else if (!ctlr->transfer && !ctlr->transfer_one &&
 		   !ctlr->transfer_one_message) {
 		return -EINVAL;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 42f3850610b5..5f728f3113bd 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -366,6 +366,7 @@ bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 
+const struct spi_controller_mem_caps spi_mem_no_caps;
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.27.0

