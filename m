Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7EFDD83
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 13:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKOMZc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 07:25:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfKOMZb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 07:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GpfP1U7W192FYFrLj/ElAhmi+JHAHHGx6gwL3GmkbA0=; b=fSsLK0/SsRku
        y6aDi7VwKtDjHY99W/szeZfmlc/ZR8EbrkSfDVQRJemwaVyDXuPSgRumw6HKRQcTQHF9L8gn1DMqs
        0pR2Z3tRFhBpjW17mvT1vdSuxn27Res0TnglFEoGxT0bAtvCFcioLs4b7O0Z2yTC7B8eWdiXcbyqb
        jjemY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaf7-0000Ma-6l; Fri, 15 Nov 2019 12:25:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A60F627415A7; Fri, 15 Nov 2019 12:25:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     agross@kernel.org, alexandre.belloni@bootlin.com, andi@etezian.org,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        jonathanh@nvidia.com, kgene@kernel.org, krzk@kernel.org,
        ldewangan@nvidia.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        radu_nicolae.pirea@upb.ro, s.hauer@pengutronix.de,
        shawnguo@kernel.org, thierry.reding@gmail.com, vkoul@kernel.org
Subject: Applied "spi: atmel: Use dma_request_chan() directly for channel request" to the spi tree
In-Reply-To: <20191113094256.1108-3-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122516.A60F627415A7@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:16 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: atmel: Use dma_request_chan() directly for channel request

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From bef1e0c8f74c87e7427cb98b2e76caf046c7b65a Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 13 Nov 2019 11:42:49 +0200
Subject: [PATCH] spi: atmel: Use dma_request_chan() directly for channel
 request

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20191113094256.1108-3-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d88e2aa64839..d692cc388126 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -512,7 +512,7 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
 		err = PTR_ERR(master->dma_tx);
 		if (err == -EPROBE_DEFER) {
-- 
2.20.1

