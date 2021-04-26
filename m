Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44936B510
	for <lists+linux-spi@lfdr.de>; Mon, 26 Apr 2021 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhDZOkf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 10:40:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49270 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233825AbhDZOkd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 10:40:33 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QEbOUt011724;
        Mon, 26 Apr 2021 16:39:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=bcdYYQwvr2r0d2E9osN7jHyNAUjPEwKXDZR3CqWi2xw=;
 b=ISikXhL9RptDDXeO6zGb0+38JoUcQtqrlJrDyPFnln/d8BLXOJy3ymTlHZ+hv2EQeV7o
 j9iifgH3LCw3yeadw3yuNmWZUE+/qWGB5yyIVK7Fr9GDce2NEs2hv/4KgOpjGgR1Wzqm
 RAjcT7K0MmDevUpqg6zVobxopfoMdLovtOkZEE0359HIajlsGfQlXD4VfF+HPO2m3H1a
 QMxqem3g8k9SsWZxx3FV8JnWbHDyno4yL6r/cps1QWfnVM8YJsaAw9os/yyVbAfTf6d6
 iDFWa5L6vT4JATRG7GgGg/5h6hCJhXkGRf0GZvEnGt5lGeCd0r7xc9TusG+mEuqeZOIh SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 385xu887wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 16:39:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09D6C10002A;
        Mon, 26 Apr 2021 16:39:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA6812178E6;
        Mon, 26 Apr 2021 16:39:39 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 16:39:39
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, <christophe.kerello@foss.st.com>
Subject: [PATCH 3/3] spi: stm32-qspi: add automatic poll status feature
Date:   Mon, 26 Apr 2021 16:39:34 +0200
Message-ID: <20210426143934.25275-4-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210426143934.25275-1-patrice.chotard@foss.st.com>
References: <20210426143934.25275-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_07:2021-04-26,2021-04-26 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Christophe Kerello <christophe.kerello@foss.st.com>

STM32 QSPI is able to automatically poll a specified register inside the
memory and relieve the CPU from this task.

As example, when erasing a large memory area, we got cpu load
equal to 50%. This patch allows to perform the same operation
with a cpu load around 2%.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 80 ++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 7e640ccc7e77..2f9e5941f14f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -36,6 +36,7 @@
 #define CR_FTIE			BIT(18)
 #define CR_SMIE			BIT(19)
 #define CR_TOIE			BIT(20)
+#define CR_APMS			BIT(22)
 #define CR_PRESC_MASK		GENMASK(31, 24)
 
 #define QSPI_DCR		0x04
@@ -53,6 +54,7 @@
 #define QSPI_FCR		0x0c
 #define FCR_CTEF		BIT(0)
 #define FCR_CTCF		BIT(1)
+#define FCR_CSMF		BIT(3)
 
 #define QSPI_DLR		0x10
 
@@ -107,6 +109,7 @@ struct stm32_qspi {
 	u32 clk_rate;
 	struct stm32_qspi_flash flash[STM32_QSPI_MAX_NORCHIP];
 	struct completion data_completion;
+	struct completion match_completion;
 	u32 fmode;
 
 	struct dma_chan *dma_chtx;
@@ -115,6 +118,7 @@ struct stm32_qspi {
 
 	u32 cr_reg;
 	u32 dcr_reg;
+	u16 status_timeout;
 
 	/*
 	 * to protect device configuration, could be different between
@@ -128,11 +132,20 @@ static irqreturn_t stm32_qspi_irq(int irq, void *dev_id)
 	struct stm32_qspi *qspi = (struct stm32_qspi *)dev_id;
 	u32 cr, sr;
 
+	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 	sr = readl_relaxed(qspi->io_base + QSPI_SR);
 
+	if (cr & CR_SMIE && sr & SR_SMF) {
+		/* disable irq */
+		cr &= ~CR_SMIE;
+		writel_relaxed(cr, qspi->io_base + QSPI_CR);
+		complete(&qspi->match_completion);
+
+		return IRQ_HANDLED;
+	}
+
 	if (sr & (SR_TEF | SR_TCF)) {
 		/* disable irq */
-		cr = readl_relaxed(qspi->io_base + QSPI_CR);
 		cr &= ~CR_TCIE & ~CR_TEIE;
 		writel_relaxed(cr, qspi->io_base + QSPI_CR);
 		complete(&qspi->data_completion);
@@ -319,6 +332,24 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 	return err;
 }
 
+static int stm32_qspi_wait_poll_status(struct stm32_qspi *qspi,
+				       const struct spi_mem_op *op)
+{
+	u32 cr;
+
+	reinit_completion(&qspi->match_completion);
+	cr = readl_relaxed(qspi->io_base + QSPI_CR);
+	writel_relaxed(cr | CR_SMIE, qspi->io_base + QSPI_CR);
+
+	if (!wait_for_completion_timeout(&qspi->match_completion,
+				msecs_to_jiffies(qspi->status_timeout)))
+		return -ETIMEDOUT;
+
+	writel_relaxed(FCR_CSMF, qspi->io_base + QSPI_FCR);
+
+	return 0;
+}
+
 static int stm32_qspi_get_mode(struct stm32_qspi *qspi, u8 buswidth)
 {
 	if (buswidth == 4)
@@ -332,7 +363,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
 	struct stm32_qspi_flash *flash = &qspi->flash[mem->spi->chip_select];
 	u32 ccr, cr;
-	int timeout, err = 0;
+	int timeout, err = 0, err_poll_status = 0;
 
 	dev_dbg(qspi->dev, "cmd:%#x mode:%d.%d.%d.%d addr:%#llx len:%#x\n",
 		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
@@ -378,6 +409,9 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->addr.nbytes && qspi->fmode != CCR_FMODE_MM)
 		writel_relaxed(op->addr.val, qspi->io_base + QSPI_AR);
 
+	if (qspi->fmode == CCR_FMODE_APM)
+		err_poll_status = stm32_qspi_wait_poll_status(qspi, op);
+
 	err = stm32_qspi_tx(qspi, op);
 
 	/*
@@ -387,7 +421,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 	 *  byte of device (device size - fifo size). like device size is not
 	 *  knows, the prefetching is always stop.
 	 */
-	if (err || qspi->fmode == CCR_FMODE_MM)
+	if (err || err_poll_status || qspi->fmode == CCR_FMODE_MM)
 		goto abort;
 
 	/* wait end of tx in indirect mode */
@@ -406,15 +440,43 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 						    cr, !(cr & CR_ABORT), 1,
 						    STM32_ABT_TIMEOUT_US);
 
-	writel_relaxed(FCR_CTCF, qspi->io_base + QSPI_FCR);
+	writel_relaxed(FCR_CTCF | FCR_CSMF, qspi->io_base + QSPI_FCR);
 
-	if (err || timeout)
-		dev_err(qspi->dev, "%s err:%d abort timeout:%d\n",
-			__func__, err, timeout);
+	if (err || err_poll_status || timeout)
+		dev_err(qspi->dev, "%s err:%d err_poll_status:%d abort timeout:%d\n",
+			__func__, err, err_poll_status, timeout);
 
 	return err;
 }
 
+static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *op,
+				  u8 mask, u8 match, u16 timeout_ms)
+{
+	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	int ret;
+
+	ret = pm_runtime_get_sync(qspi->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(qspi->dev);
+		return ret;
+	}
+
+	mutex_lock(&qspi->lock);
+
+	writel_relaxed(mask, qspi->io_base + QSPI_PSMKR);
+	writel_relaxed(match, qspi->io_base + QSPI_PSMAR);
+	qspi->fmode = CCR_FMODE_APM;
+	qspi->status_timeout = timeout_ms;
+
+	ret = stm32_qspi_send(mem, op);
+	mutex_unlock(&qspi->lock);
+
+	pm_runtime_mark_last_busy(qspi->dev);
+	pm_runtime_put_autosuspend(qspi->dev);
+
+	return ret;
+}
+
 static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
@@ -527,7 +589,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	flash->presc = presc;
 
 	mutex_lock(&qspi->lock);
-	qspi->cr_reg = 3 << CR_FTHRES_SHIFT | CR_SSHIFT | CR_EN;
+	qspi->cr_reg = CR_APMS | 3 << CR_FTHRES_SHIFT | CR_SSHIFT | CR_EN;
 	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 
 	/* set dcr fsize to max address */
@@ -607,6 +669,7 @@ static const struct spi_controller_mem_ops stm32_qspi_mem_ops = {
 	.exec_op	= stm32_qspi_exec_op,
 	.dirmap_create	= stm32_qspi_dirmap_create,
 	.dirmap_read	= stm32_qspi_dirmap_read,
+	.poll_status	= stm32_qspi_poll_status,
 };
 
 static int stm32_qspi_probe(struct platform_device *pdev)
@@ -661,6 +724,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&qspi->data_completion);
+	init_completion(&qspi->match_completion);
 
 	qspi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(qspi->clk)) {
-- 
2.17.1

