Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DEA67E9
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfICL55 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 07:57:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfICL54 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 07:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1sZR0jM6bSKmi2RDe14AoOgOh3ZcP38nZLHlmDYc7z8=; b=msNKnC9/TNrR
        UlW226Cz+yKvUAC86LEjs3KYAnXCDCXeYLouIltTnS/EVUrdG3b+QMX+SP/GllbYwrlxRZ7yMNn1T
        k59Q8GzHYkbfLm9mKpgYmZabOYarOdIducgyDlrzo+Me4GUvQ10unTQsWn/1P0ERCft8G5eX8ScpN
        Dh9k4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i57RV-0008Ly-Cv; Tue, 03 Sep 2019 11:57:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D6F002742D39; Tue,  3 Sep 2019 12:57:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, hayashibara.keiji@socionext.com,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, masami.hiramatsu@linaro.org,
        yamada.masahiro@socionext.com
Subject: Applied "spi: uniphier: introduce polling mode" to the spi tree
In-Reply-To: <1567488661-11428-4-git-send-email-hayashibara.keiji@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190903115748.D6F002742D39@ypsilon.sirena.org.uk>
Date:   Tue,  3 Sep 2019 12:57:48 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: uniphier: introduce polling mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 37ffab81709805c674f164948e03ba0d3fe371b6 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Tue, 3 Sep 2019 14:31:01 +0900
Subject: [PATCH] spi: uniphier: introduce polling mode

Introduce new polling mode for short size transfer. Either the estimated
transfer time is estimated to exceed 200us, or polling loop actually exceeds
200us, it switches to irq mode.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Link: https://lore.kernel.org/r/1567488661-11428-4-git-send-email-hayashibara.keiji@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 81 +++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 226f8508bff2..938f8873e63f 100644
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
 
@@ -289,21 +291,23 @@ static void uniphier_spi_recv(struct uniphier_spi_priv *priv)
 
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
 
@@ -322,20 +326,14 @@ static void uniphier_spi_set_cs(struct spi_device *spi, bool enable)
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
@@ -355,6 +353,59 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
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
2.20.1

