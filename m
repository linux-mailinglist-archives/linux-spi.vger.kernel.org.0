Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14F012A519
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 01:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfLYAJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Dec 2019 19:09:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33778 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfLYAJ0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Dec 2019 19:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GUJdf/ACw1h6vNsMgaiSztgePla3xUya9eRu6bc4itI=; b=KnnQl599gDI9
        T8itH2oIzonwBjm1/YrLKb7JJAvDvQd7JXcYwdPA7RxlZvOVSCyg6blvnycrW+wtMmsiwg9i26ck6
        kPy9A1BhFFh63ej535mU9DbkUq+veJF54d6TnvVgF4mkM8N5SzLTp4WfT1fHg5AJgRdjWscxBIjCQ
        +uPws=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuEp-0007N1-CE; Wed, 25 Dec 2019 00:09:19 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DB0FBD01957; Wed, 25 Dec 2019 00:09:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Applied "spi: uniphier: Add handle_err callback function" to the spi tree
In-Reply-To: <1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <applied-1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:09:18 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: uniphier: Add handle_err callback function

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

From 11299c5cd8868479e9acfc525ba3c2e882c7ba0c Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 24 Dec 2019 09:58:25 +0900
Subject: [PATCH] spi: uniphier: Add handle_err callback function

This adds master->handle_err() callback function to stop transfer due to
error. The function also resets FIFOs and disables interrupt.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index a44a1a5fb7b0..0b255597fdcb 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -425,6 +425,22 @@ static int uniphier_spi_unprepare_transfer_hardware(struct spi_master *master)
 	return 0;
 }
 
+static void uniphier_spi_handle_err(struct spi_master *master,
+				    struct spi_message *msg)
+{
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	u32 val;
+
+	/* stop running spi transfer */
+	writel(0, priv->base + SSI_CTL);
+
+	/* reset FIFOs */
+	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
+	writel(val, priv->base + SSI_FC);
+
+	uniphier_spi_irq_disable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
+}
+
 static irqreturn_t uniphier_spi_handler(int irq, void *dev_id)
 {
 	struct uniphier_spi_priv *priv = dev_id;
@@ -531,6 +547,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 				= uniphier_spi_prepare_transfer_hardware;
 	master->unprepare_transfer_hardware
 				= uniphier_spi_unprepare_transfer_hardware;
+	master->handle_err = uniphier_spi_handle_err;
 	master->num_chipselect = 1;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-- 
2.20.1

