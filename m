Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBAE1B7240
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 12:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgDXKne (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 06:43:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:54501 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgDXKnd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 06:43:33 -0400
IronPort-SDR: tRR8oNGNPruI9ica38lPNORZtfJi+vwlzNeCzoqtiPu/DrviI2yH4PkkIeezhpi5QL/SNWNmkn
 zSsN4zunMOJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 03:43:32 -0700
IronPort-SDR: qH+g6aud2kSY1yU53VAt1ke6qVjY8cWTVhupc5SVjH37+rB75skLOFbepHF+kIN/f9nH8yGVZB
 jN2me8jxPCcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="274560638"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 24 Apr 2020 03:43:29 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and transfers
Date:   Fri, 24 Apr 2020 18:42:30 +0800
Message-Id: <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Synchronize tx, rx and error interrupts by registering to the
same interrupt handler. Interrupt handler will recognize and process
the appropriate interrupt on the basis of interrupt status register.
Also, establish synchronization between the interrupt handler and
transfer operation by taking the locks and registering the interrupt
handler as thread IRQ which avoids the bottom half.
Fixes the wrongly populated interrupt register offsets too.

Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
Fixes: ad2fca0721d1 ("spi: lantiq-ssc: add LTQ_ prefix to defines")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 89 ++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 1fd7ee53d451..b67f5925bcb0 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -13,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
-#include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
@@ -50,8 +50,8 @@
 #define LTQ_SPI_RXCNT		0x84
 #define LTQ_SPI_DMACON		0xec
 #define LTQ_SPI_IRNEN		0xf4
-#define LTQ_SPI_IRNICR		0xf8
-#define LTQ_SPI_IRNCR		0xfc
+#define LTQ_SPI_IRNCR		0xf8
+#define LTQ_SPI_IRNICR		0xfc
 
 #define LTQ_SPI_CLC_SMC_S	16	/* Clock divider for sleep mode */
 #define LTQ_SPI_CLC_SMC_M	(0xFF << LTQ_SPI_CLC_SMC_S)
@@ -171,9 +171,7 @@ struct lantiq_ssc_spi {
 	struct clk			*fpi_clk;
 	const struct lantiq_ssc_hwcfg	*hwcfg;
 
-	spinlock_t			lock;
-	struct workqueue_struct		*wq;
-	struct work_struct		work;
+	struct mutex			lock;
 
 	const u8			*tx;
 	u8				*rx;
@@ -186,6 +184,8 @@ struct lantiq_ssc_spi {
 	unsigned int			base_cs;
 };
 
+static void lantiq_ssc_busy_wait(struct lantiq_ssc_spi *spi);
+
 static u32 lantiq_ssc_readl(const struct lantiq_ssc_spi *spi, u32 reg)
 {
 	return __raw_readl(spi->regbase + reg);
@@ -464,8 +464,6 @@ static int lantiq_ssc_unprepare_message(struct spi_master *master,
 {
 	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
 
-	flush_workqueue(spi->wq);
-
 	/* Disable transmitter and receiver while idle */
 	lantiq_ssc_maskl(spi, 0, LTQ_SPI_CON_TXOFF | LTQ_SPI_CON_RXOFF,
 			 LTQ_SPI_CON);
@@ -610,10 +608,8 @@ static void rx_request(struct lantiq_ssc_spi *spi)
 	lantiq_ssc_writel(spi, rxreq, LTQ_SPI_RXREQ);
 }
 
-static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
+static irqreturn_t lantiq_ssc_xmit_interrupt(struct lantiq_ssc_spi *spi)
 {
-	struct lantiq_ssc_spi *spi = data;
-
 	if (spi->tx) {
 		if (spi->rx && spi->rx_todo)
 			rx_fifo_read_full_duplex(spi);
@@ -638,19 +634,15 @@ static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 
 completed:
-	queue_work(spi->wq, &spi->work);
+	lantiq_ssc_busy_wait(spi);
 
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
+static irqreturn_t lantiq_ssc_err_interrupt(struct lantiq_ssc_spi *spi)
 {
-	struct lantiq_ssc_spi *spi = data;
 	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
 
-	if (!(stat & LTQ_SPI_STAT_ERRORS))
-		return IRQ_NONE;
-
 	if (stat & LTQ_SPI_STAT_RUE)
 		dev_err(spi->dev, "receive underflow error\n");
 	if (stat & LTQ_SPI_STAT_TUE)
@@ -670,17 +662,39 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 	/* set bad status so it can be retried */
 	if (spi->master->cur_msg)
 		spi->master->cur_msg->status = -EIO;
-	queue_work(spi->wq, &spi->work);
+
+	spi_finalize_current_transfer(spi->master);
 
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t lantiq_ssc_isr(int irq, void *data)
+{
+	struct lantiq_ssc_spi *spi = data;
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
+	irqreturn_t ret = IRQ_NONE;
+	u32 val;
+
+	mutex_lock(&spi->lock);
+	val = lantiq_ssc_readl(spi, LTQ_SPI_IRNCR);
+	lantiq_ssc_maskl(spi, val, 0, LTQ_SPI_IRNEN);
+
+	if (val & LTQ_SPI_IRNEN_E)
+		ret = lantiq_ssc_err_interrupt(spi);
+
+	if ((val & hwcfg->irnen_t) || (val & hwcfg->irnen_r))
+		ret = lantiq_ssc_xmit_interrupt(spi);
+
+	lantiq_ssc_maskl(spi, 0, val, LTQ_SPI_IRNEN);
+	mutex_unlock(&spi->lock);
+
+	return ret;
+}
+
 static int transfer_start(struct lantiq_ssc_spi *spi, struct spi_device *spidev,
 			  struct spi_transfer *t)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&spi->lock, flags);
+	mutex_lock(&spi->lock);
 
 	spi->tx = t->tx_buf;
 	spi->rx = t->rx_buf;
@@ -700,7 +714,7 @@ static int transfer_start(struct lantiq_ssc_spi *spi, struct spi_device *spidev,
 			rx_request(spi);
 	}
 
-	spin_unlock_irqrestore(&spi->lock, flags);
+	mutex_unlock(&spi->lock);
 
 	return t->len;
 }
@@ -712,14 +726,11 @@ static int transfer_start(struct lantiq_ssc_spi *spi, struct spi_device *spidev,
  * write the last word to the wire, not when it is finished. Do busy
  * waiting till it finishes.
  */
-static void lantiq_ssc_bussy_work(struct work_struct *work)
+static void lantiq_ssc_busy_wait(struct lantiq_ssc_spi *spi)
 {
-	struct lantiq_ssc_spi *spi;
 	unsigned long long timeout = 8LL * 1000LL;
 	unsigned long end;
 
-	spi = container_of(work, typeof(*spi), work);
-
 	do_div(timeout, spi->speed_hz);
 	timeout += timeout + 100; /* some tolerance */
 
@@ -838,18 +849,18 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	err = devm_request_irq(dev, rx_irq, lantiq_ssc_xmit_interrupt,
-			       0, LTQ_SPI_RX_IRQ_NAME, spi);
+	err = devm_request_threaded_irq(dev, rx_irq, NULL, lantiq_ssc_isr,
+					IRQF_ONESHOT, LTQ_SPI_RX_IRQ_NAME, spi);
 	if (err)
 		goto err_master_put;
 
-	err = devm_request_irq(dev, tx_irq, lantiq_ssc_xmit_interrupt,
-			       0, LTQ_SPI_TX_IRQ_NAME, spi);
+	err = devm_request_threaded_irq(dev, tx_irq, NULL, lantiq_ssc_isr,
+					IRQF_ONESHOT, LTQ_SPI_TX_IRQ_NAME, spi);
 	if (err)
 		goto err_master_put;
 
-	err = devm_request_irq(dev, err_irq, lantiq_ssc_err_interrupt,
-			       0, LTQ_SPI_ERR_IRQ_NAME, spi);
+	err = devm_request_threaded_irq(dev, err_irq, NULL, lantiq_ssc_isr,
+					IRQF_ONESHOT, LTQ_SPI_ERR_IRQ_NAME, spi);
 	if (err)
 		goto err_master_put;
 
@@ -882,7 +893,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	spi->base_cs = 1;
 	of_property_read_u32(pdev->dev.of_node, "base-cs", &spi->base_cs);
 
-	spin_lock_init(&spi->lock);
+	mutex_init(&spi->lock);
 	spi->bits_per_word = 8;
 	spi->speed_hz = 0;
 
@@ -899,13 +910,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 8) |
 				     SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 
-	spi->wq = alloc_ordered_workqueue(dev_name(dev), 0);
-	if (!spi->wq) {
-		err = -ENOMEM;
-		goto err_clk_put;
-	}
-	INIT_WORK(&spi->work, lantiq_ssc_bussy_work);
-
 	id = lantiq_ssc_readl(spi, LTQ_SPI_ID);
 	spi->tx_fifo_size = (id & LTQ_SPI_ID_TXFS_M) >> LTQ_SPI_ID_TXFS_S;
 	spi->rx_fifo_size = (id & LTQ_SPI_ID_RXFS_M) >> LTQ_SPI_ID_RXFS_S;
@@ -921,13 +925,11 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	err = devm_spi_register_master(dev, master);
 	if (err) {
 		dev_err(dev, "failed to register spi_master\n");
-		goto err_wq_destroy;
+		goto err_clk_put;
 	}
 
 	return 0;
 
-err_wq_destroy:
-	destroy_workqueue(spi->wq);
 err_clk_put:
 	clk_put(spi->fpi_clk);
 err_clk_disable:
@@ -948,7 +950,6 @@ static int lantiq_ssc_remove(struct platform_device *pdev)
 	tx_fifo_flush(spi);
 	hw_enter_config_mode(spi);
 
-	destroy_workqueue(spi->wq);
 	clk_disable_unprepare(spi->spi_clk);
 	clk_put(spi->fpi_clk);
 
-- 
2.11.0

