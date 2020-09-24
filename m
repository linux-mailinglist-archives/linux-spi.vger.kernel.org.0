Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EAB2770E8
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgIXMZz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 08:25:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727267AbgIXMZz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:25:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3FA4F236B71038141A9E;
        Thu, 24 Sep 2020 20:25:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 20:25:46 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <john.garry@huawei.com>, <broonie@kernel.org>
CC:     <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <yangyicong@hisilicon.com>
Subject: [PATCH 4/4] spi: hisi-sfc-v3xx: add support for IRQ mode
Date:   Thu, 24 Sep 2020 20:24:30 +0800
Message-ID: <1600950270-52536-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600950270-52536-1-git-send-email-yangyicong@hisilicon.com>
References: <1600950270-52536-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The controller can work with interrupts, so add support for it.
Then we can work under IRQ mode or Poll mode now, if firmware
doesn't declare the IRQ support, it will fall back to Poll mode.

Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 131 +++++++++++++++++++++++++++++++++-------
 1 file changed, 109 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 4a241d7..46454dc 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -7,7 +7,9 @@
 
 #include <linux/acpi.h>
 #include <linux/bitops.h>
+#include <linux/completion.h>
 #include <linux/dmi.h>
+#include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -17,7 +19,9 @@
 
 #define HISI_SFC_V3XX_VERSION (0x1f8)
 
-#define HISI_SFC_V3XX_INT_STAT (0x120)
+#define HISI_SFC_V3XX_RAW_INT_STAT (0x120)
+#define HISI_SFC_V3XX_INT_STAT (0x124)
+#define HISI_SFC_V3XX_INT_MASK (0x128)
 #define HISI_SFC_V3XX_INT_CLR (0x12c)
 #define HISI_SFC_V3XX_CMD_CFG (0x300)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF 9
@@ -33,6 +37,7 @@
 
 /* Common definition of interrupt bit masks */
 #define HISI_SFC_V3XX_INT_MASK_ALL (0x1ff)	/* all the masks */
+#define HISI_SFC_V3XX_INT_MASK_CPLT BIT(0)	/* command execution complete */
 #define HISI_SFC_V3XX_INT_MASK_PP_ERR BIT(2)	/* page progrom error */
 #define HISI_SFC_V3XX_INT_MASK_IACCES BIT(5)	/* error visiting inaccessible/
 						 * protected address
@@ -69,8 +74,60 @@ struct hisi_sfc_v3xx_host {
 	struct device *dev;
 	void __iomem *regbase;
 	int max_cmd_dword;
+	struct completion *completion;
+	int irq;
 };
 
+static void hisi_sfc_v3xx_disable_int(struct hisi_sfc_v3xx_host *host)
+{
+	writel(0, host->regbase + HISI_SFC_V3XX_INT_MASK);
+}
+
+static void hisi_sfc_v3xx_enable_int(struct hisi_sfc_v3xx_host *host)
+{
+	writel(HISI_SFC_V3XX_INT_MASK_ALL, host->regbase + HISI_SFC_V3XX_INT_MASK);
+}
+
+static void hisi_sfc_v3xx_clear_int(struct hisi_sfc_v3xx_host *host)
+{
+	writel(HISI_SFC_V3XX_INT_MASK_ALL, host->regbase + HISI_SFC_V3XX_INT_CLR);
+}
+
+/*
+ * The interrupt status register indicates whether an error occurs
+ * after per operation. Check it, and clear the interrupts for
+ * next time judgement.
+ */
+static int hisi_sfc_v3xx_handle_completion(struct hisi_sfc_v3xx_host *host)
+{
+	u32 reg;
+
+	reg = readl(host->regbase + HISI_SFC_V3XX_RAW_INT_STAT);
+	hisi_sfc_v3xx_clear_int(host);
+
+	if (reg & HISI_SFC_V3XX_INT_MASK_IACCES) {
+		dev_err(host->dev, "fail to access protected address\n");
+		return -EIO;
+	}
+
+	if (reg & HISI_SFC_V3XX_INT_MASK_PP_ERR) {
+		dev_err(host->dev, "page program operation failed\n");
+		return -EIO;
+	}
+
+	/*
+	 * The other bits of the interrupt registers is not currently
+	 * used and probably not be triggered in this driver. When it
+	 * happens, we regard it as an unsupported error here.
+	 */
+	if (!(reg & HISI_SFC_V3XX_INT_MASK_CPLT)) {
+		dev_err(host->dev, "unsupported error occured, status=0x%x\n", reg);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 #define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
 #define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10
 
@@ -250,9 +307,14 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 					 const struct spi_mem_op *op,
 					 u8 chip_select)
 {
-	u32 int_stat;
+	DECLARE_COMPLETION_ONSTACK(done);
 	int ret;
 
+	if (host->irq) {
+		host->completion = &done;
+		hisi_sfc_v3xx_enable_int(host);
+	}
+
 	if (op->data.dir == SPI_MEM_DATA_OUT)
 		hisi_sfc_v3xx_write_databuf(host, op->data.buf.out, op->data.nbytes);
 
@@ -260,28 +322,21 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 	if (ret)
 		return ret;
 
-	ret = hisi_sfc_v3xx_wait_cmd_idle(host);
-	if (ret)
-		return ret;
-
-	/*
-	 * The interrupt status register indicates whether an error occurs
-	 * after per operation. Check it, and clear the interrupts for
-	 * next time judgement.
-	 */
-	int_stat = readl(host->regbase + HISI_SFC_V3XX_INT_STAT);
-	writel(HISI_SFC_V3XX_INT_MASK_ALL,
-	       host->regbase + HISI_SFC_V3XX_INT_CLR);
+	if (host->irq) {
+		ret = wait_for_completion_timeout(host->completion,
+						  usecs_to_jiffies(HISI_SFC_V3XX_WAIT_TIMEOUT_US));
+		if (!ret)
+			ret = -ETIMEDOUT;
+		else
+			ret = 0;
 
-	if (int_stat & HISI_SFC_V3XX_INT_MASK_IACCES) {
-		dev_err(host->dev, "fail to access protected address\n");
-		return -EIO;
+		hisi_sfc_v3xx_disable_int(host);
+		host->completion = NULL;
+	} else {
+		ret = hisi_sfc_v3xx_wait_cmd_idle(host);
 	}
-
-	if (int_stat & HISI_SFC_V3XX_INT_MASK_PP_ERR) {
-		dev_err(host->dev, "page program operation failed\n");
+	if (hisi_sfc_v3xx_handle_completion(host) || ret)
 		return -EIO;
-	}
 
 	if (op->data.dir == SPI_MEM_DATA_IN)
 		hisi_sfc_v3xx_read_databuf(host, op->data.buf.in, op->data.nbytes);
@@ -307,6 +362,17 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 	.exec_op = hisi_sfc_v3xx_exec_op,
 };
 
+static irqreturn_t hisi_sfc_v3xx_isr(int irq, void *data)
+{
+	struct hisi_sfc_v3xx_host *host = data;
+
+	hisi_sfc_v3xx_disable_int(host);
+
+	complete(host->completion);
+
+	return IRQ_HANDLED;
+}
+
 static int hisi_sfc_v3xx_buswidth_override_bits;
 
 /*
@@ -373,6 +439,26 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
+	host->irq = platform_get_irq_optional(pdev, 0);
+	if (host->irq == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_put_master;
+	}
+
+	hisi_sfc_v3xx_disable_int(host);
+
+	if (host->irq > 0) {
+		ret = devm_request_irq(dev, host->irq, hisi_sfc_v3xx_isr, 0,
+				       "hisi-sfc-v3xx", host);
+
+		if (ret) {
+			dev_err(dev, "failed to request irq%d, ret = %d\n", host->irq, ret);
+			host->irq = 0;
+		}
+	} else {
+		host->irq = 0;
+	}
+
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->mem_ops = &hisi_sfc_v3xx_mem_ops;
@@ -392,7 +478,8 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put_master;
 
-	dev_info(&pdev->dev, "hw version 0x%x\n", version);
+	dev_info(&pdev->dev, "hw version 0x%x, %s mode.\n",
+		 version, host->irq ? "irq" : "polling");
 
 	return 0;
 
-- 
2.8.1

