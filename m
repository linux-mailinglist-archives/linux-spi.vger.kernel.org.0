Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26AFA6093
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfICFbN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 01:31:13 -0400
Received: from mx.socionext.com ([202.248.49.38]:49356 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfICFbM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Sep 2019 01:31:12 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Sep 2019 14:31:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 64817605F8;
        Tue,  3 Sep 2019 14:31:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 3 Sep 2019 14:31:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 41A2A1A0E9F;
        Tue,  3 Sep 2019 14:31:05 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 21B151204B3;
        Tue,  3 Sep 2019 14:31:05 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 3/3] spi: uniphier: introduce polling mode
Date:   Tue,  3 Sep 2019 14:31:01 +0900
Message-Id: <1567488661-11428-4-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce new polling mode for short size transfer. Either the estimated
transfer time is estimated to exceed 200us, or polling loop actually exceeds
200us, it switches to irq mode.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 81 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index d40ad93..6b83b25 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -16,6 +17,7 @@
 #include <asm/unaligned.h>
 
 #define SSI_TIMEOUT_MS		2000
+#define SSI_POLL_TIMEOUT_US	200
 #define SSI_MAX_CLK_DIVIDER	254
 #define SSI_MIN_CLK_DIVIDER	4
 
@@ -290,21 +292,23 @@ static void uniphier_spi_recv(struct uniphier_spi_priv *priv)
 
 static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
 {
-	unsigned int tx_count;
+	unsigned int fifo_threshold, fill_bytes;
 	u32 val;
 
-	tx_count = DIV_ROUND_UP(priv->tx_bytes,
+	fifo_threshold = DIV_ROUND_UP(priv->rx_bytes,
 				bytes_per_word(priv->bits_per_word));
-	tx_count = min(tx_count, SSI_FIFO_DEPTH);
+	fifo_threshold = min(fifo_threshold, SSI_FIFO_DEPTH);
+
+	fill_bytes = fifo_threshold - (priv->rx_bytes - priv->tx_bytes);
 
 	/* set fifo threshold */
 	val = readl(priv->base + SSI_FC);
 	val &= ~(SSI_FC_TXFTH_MASK | SSI_FC_RXFTH_MASK);
-	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, tx_count);
-	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, tx_count);
+	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, fifo_threshold);
+	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, fifo_threshold);
 	writel(val, priv->base + SSI_FC);
 
-	while (tx_count--)
+	while (fill_bytes--)
 		uniphier_spi_send(priv);
 }
 
@@ -323,20 +327,14 @@ static void uniphier_spi_set_cs(struct spi_device *spi, bool enable)
 	writel(val, priv->base + SSI_FPS);
 }
 
-static int uniphier_spi_transfer_one(struct spi_master *master,
-				     struct spi_device *spi,
-				     struct spi_transfer *t)
+static int uniphier_spi_transfer_one_irq(struct spi_master *master,
+					 struct spi_device *spi,
+					 struct spi_transfer *t)
 {
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
 	struct device *dev = master->dev.parent;
 	unsigned long time_left;
 
-	/* Terminate and return success for 0 byte length transfer */
-	if (!t->len)
-		return 0;
-
-	uniphier_spi_setup_transfer(spi, t);
-
 	reinit_completion(&priv->xfer_done);
 
 	uniphier_spi_fill_tx_fifo(priv);
@@ -356,6 +354,59 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 	return priv->error;
 }
 
+static int uniphier_spi_transfer_one_poll(struct spi_master *master,
+					  struct spi_device *spi,
+					  struct spi_transfer *t)
+{
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	int loop = SSI_POLL_TIMEOUT_US * 10;
+
+	while (priv->tx_bytes) {
+		uniphier_spi_fill_tx_fifo(priv);
+
+		while ((priv->rx_bytes - priv->tx_bytes) > 0) {
+			while (!(readl(priv->base + SSI_SR) & SSI_SR_RNE)
+								&& loop--)
+				ndelay(100);
+
+			if (loop == -1)
+				goto irq_transfer;
+
+			uniphier_spi_recv(priv);
+		}
+	}
+
+	return 0;
+
+irq_transfer:
+	return uniphier_spi_transfer_one_irq(master, spi, t);
+}
+
+static int uniphier_spi_transfer_one(struct spi_master *master,
+				     struct spi_device *spi,
+				     struct spi_transfer *t)
+{
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	unsigned long threshold;
+
+	/* Terminate and return success for 0 byte length transfer */
+	if (!t->len)
+		return 0;
+
+	uniphier_spi_setup_transfer(spi, t);
+
+	/*
+	 * If the transfer operation will take longer than
+	 * SSI_POLL_TIMEOUT_US, it should use irq.
+	 */
+	threshold = DIV_ROUND_UP(SSI_POLL_TIMEOUT_US * priv->speed_hz,
+					USEC_PER_SEC * BITS_PER_BYTE);
+	if (t->len > threshold)
+		return uniphier_spi_transfer_one_irq(master, spi, t);
+	else
+		return uniphier_spi_transfer_one_poll(master, spi, t);
+}
+
 static int uniphier_spi_prepare_transfer_hardware(struct spi_master *master)
 {
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
-- 
2.7.4

