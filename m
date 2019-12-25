Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C503512A517
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 01:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLYAJ2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Dec 2019 19:09:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfLYAJ0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Dec 2019 19:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XHO12lr1qLB4FKdbh6ys7+jy8rW61hg1/mw41eet/vI=; b=Mtpl63TU2Fv6
        qcc+jUPgG3t3sObYqw3qJntc+jQ4uZINU2M1k868I2OCc5Pud3blFUcYCeHQIkBzsOsgptBIZ54Cj
        ZWXWfzCq8Qz+RUCkV5eUOepHvLvxwtoNAl0nxJRNCa3qrtS83ZQXcggQNxHstk4cbci6icVmJdT6e
        x6aVo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuEp-0007N2-Fd; Wed, 25 Dec 2019 00:09:19 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 00AA5D01963; Wed, 25 Dec 2019 00:09:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Applied "spi: uniphier: Change argument of irq functions to private structure" to the spi tree
In-Reply-To: <1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <applied-1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:09:18 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: uniphier: Change argument of irq functions to private structure

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 9859db51387df8a7e8564a211158ff8bf263b0a8 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 24 Dec 2019 09:58:24 +0900
Subject: [PATCH] spi: uniphier: Change argument of irq functions to private
 structure

This changes each argument of functions uniphier_irq_{enable,disable}()
to uniphier_spi_priv because these functions are used not only for
spi_device but also for the entire controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 47cde1864630..a44a1a5fb7b0 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -93,9 +93,9 @@ static inline unsigned int bytes_per_word(unsigned int bits)
 	return bits <= 8 ? 1 : (bits <= 16 ? 2 : 4);
 }
 
-static inline void uniphier_spi_irq_enable(struct spi_device *spi, u32 mask)
+static inline void uniphier_spi_irq_enable(struct uniphier_spi_priv *priv,
+					   u32 mask)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
 	u32 val;
 
 	val = readl(priv->base + SSI_IE);
@@ -103,9 +103,9 @@ static inline void uniphier_spi_irq_enable(struct spi_device *spi, u32 mask)
 	writel(val, priv->base + SSI_IE);
 }
 
-static inline void uniphier_spi_irq_disable(struct spi_device *spi, u32 mask)
+static inline void uniphier_spi_irq_disable(struct uniphier_spi_priv *priv,
+					    u32 mask)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
 	u32 val;
 
 	val = readl(priv->base + SSI_IE);
@@ -339,12 +339,12 @@ static int uniphier_spi_transfer_one_irq(struct spi_master *master,
 
 	uniphier_spi_fill_tx_fifo(priv);
 
-	uniphier_spi_irq_enable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
+	uniphier_spi_irq_enable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
 
 	time_left = wait_for_completion_timeout(&priv->xfer_done,
 					msecs_to_jiffies(SSI_TIMEOUT_MS));
 
-	uniphier_spi_irq_disable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
+	uniphier_spi_irq_disable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
 
 	if (!time_left) {
 		dev_err(dev, "transfer timeout.\n");
-- 
2.20.1

