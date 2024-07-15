Return-Path: <linux-spi+bounces-3853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E11931012
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3EA1F221BA
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A7185E5D;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taBt2Lw4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA7185E49;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032803; cv=none; b=lbMyOFBZAhBe6pR8Eeg2BU7D6fRTF4VrBmD9M5xw/KWR3CUSnk+eA2R0w9m6ZbbX+5/5NMm2p8FneZ6LNB0g3B0nCFJXuAJnNBE1zuOrTLwgSwgJOw6eSKX/DHQNN/8GkKMnXBqrQL/wH7OUPkyLW+HXmoUB6yN+7D8B3p26+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032803; c=relaxed/simple;
	bh=IEwtVJw5ttf8Nxs4WzZVqlVnj9yFb3V7VA/7YFn/vKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5rVZznH2lKmIWucfPncOOjCPjgSu/oi0xNP38UPAXHcJw0uA6wiJY0UsEZoFox9GNnQp4kGIJvpVUvSryKQ3dyvkRipesSIgC0tlaYVud3MeuIrKz+M6bZYHtvcIIt/CKqPSy+jThPRsI59+YsAhbjKp7QuW09TKiOipMfZCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taBt2Lw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0CACC4DDF9;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032803;
	bh=IEwtVJw5ttf8Nxs4WzZVqlVnj9yFb3V7VA/7YFn/vKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=taBt2Lw45IVjBORwgAbF6iKn4/eSdfoFpfKoFfMJ/SOpVGOsaBFqwamS6E/206QaD
	 KIRxoyThvTqbHMQsmjVw6OpvvvGLJ2VO8iX37mA3odYqtm2mfSRe+WZ4IfEHHwWY13
	 N0FzfHwVi1lkRum+h4jSeAFEJaABPZ0ggzhpUHZiSsJCiT2rgbVNLdC0jowc85EaAU
	 hOfVSKewBMp1MS9zebWuWeoBPUFJz+N9OyXJDSs61GZLm22AL1oH15T2CbRWaDJ6cY
	 X4k/mRc/7Zs0xKcCGO86ucXJPllzbUWWs8kaVAAdUE3pXjz4bWzoPojnSlVZSzTtbh
	 8QFO2IeI9WoEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E35C3DA4D;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:19 +0300
Subject: [PATCH v11 15/38] spi: ep93xx: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-15-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=4901;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=Bt1o2cb87iUEqTTj1qSqH0uuj7VeyHE3n45reTOPXeo=;
 b=d7c3woyS8gs8Tvw4ci2a7XzOMinkmEZ1DXwN7eqjVP972Ci+QgpoE087TcLApra+L32ncRD42NiY
 yROq94vXA8c6Fzzi9yChP5t7PtsuTX7PTsZVRQG4A5eai8rwd/8N
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

- add OF ID match table
- add device tree DMA request, so we can probe defer, in case DMA is not
  ready yet
- drop DMA platform code

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 66 +++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index a1d60e51c053..ffbe0d522bce 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -18,18 +18,18 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/scatterlist.h>
 #include <linux/spi/spi.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
-#include <linux/platform_data/spi-ep93xx.h>
-
 #define SSPCR0			0x0000
 #define SSPCR0_SPO		BIT(6)
 #define SSPCR0_SPH		BIT(7)
@@ -92,8 +92,6 @@ struct ep93xx_spi {
 	size_t				fifo_level;
 	struct dma_chan			*dma_rx;
 	struct dma_chan			*dma_tx;
-	struct ep93xx_dma_data		dma_rx_data;
-	struct ep93xx_dma_data		dma_tx_data;
 	struct sg_table			rx_sgt;
 	struct sg_table			tx_sgt;
 	void				*zeropage;
@@ -575,46 +573,23 @@ static int ep93xx_spi_unprepare_hardware(struct spi_controller *host)
 	return 0;
 }
 
-static bool ep93xx_spi_dma_filter(struct dma_chan *chan, void *filter_param)
+static int ep93xx_spi_setup_dma(struct device *dev, struct ep93xx_spi *espi)
 {
-	if (ep93xx_dma_chan_is_m2p(chan))
-		return false;
-
-	chan->private = filter_param;
-	return true;
-}
-
-static int ep93xx_spi_setup_dma(struct ep93xx_spi *espi)
-{
-	dma_cap_mask_t mask;
 	int ret;
 
 	espi->zeropage = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!espi->zeropage)
 		return -ENOMEM;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	espi->dma_rx_data.port = EP93XX_DMA_SSP;
-	espi->dma_rx_data.direction = DMA_DEV_TO_MEM;
-	espi->dma_rx_data.name = "ep93xx-spi-rx";
-
-	espi->dma_rx = dma_request_channel(mask, ep93xx_spi_dma_filter,
-					   &espi->dma_rx_data);
-	if (!espi->dma_rx) {
-		ret = -ENODEV;
+	espi->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(espi->dma_rx)) {
+		ret = dev_err_probe(dev, PTR_ERR(espi->dma_rx), "rx DMA setup failed");
 		goto fail_free_page;
 	}
 
-	espi->dma_tx_data.port = EP93XX_DMA_SSP;
-	espi->dma_tx_data.direction = DMA_MEM_TO_DEV;
-	espi->dma_tx_data.name = "ep93xx-spi-tx";
-
-	espi->dma_tx = dma_request_channel(mask, ep93xx_spi_dma_filter,
-					   &espi->dma_tx_data);
-	if (!espi->dma_tx) {
-		ret = -ENODEV;
+	espi->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(espi->dma_tx)) {
+		ret = dev_err_probe(dev, PTR_ERR(espi->dma_tx), "tx DMA setup failed");
 		goto fail_release_rx;
 	}
 
@@ -647,18 +622,11 @@ static void ep93xx_spi_release_dma(struct ep93xx_spi *espi)
 static int ep93xx_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *host;
-	struct ep93xx_spi_info *info;
 	struct ep93xx_spi *espi;
 	struct resource *res;
 	int irq;
 	int error;
 
-	info = dev_get_platdata(&pdev->dev);
-	if (!info) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -EINVAL;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -713,12 +681,17 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 		goto fail_release_host;
 	}
 
-	if (info->use_dma && ep93xx_spi_setup_dma(espi))
+	error = ep93xx_spi_setup_dma(&pdev->dev, espi);
+	if (error == -EPROBE_DEFER)
+		goto fail_release_host;
+
+	if (error)
 		dev_warn(&pdev->dev, "DMA setup failed. Falling back to PIO\n");
 
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
+	device_set_node(&host->dev, dev_fwnode(&pdev->dev));
 	error = devm_spi_register_controller(&pdev->dev, host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI host\n");
@@ -746,9 +719,16 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
 	ep93xx_spi_release_dma(espi);
 }
 
+static const struct of_device_id ep93xx_spi_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_spi_of_ids);
+
 static struct platform_driver ep93xx_spi_driver = {
 	.driver		= {
 		.name	= "ep93xx-spi",
+		.of_match_table = ep93xx_spi_of_ids,
 	},
 	.probe		= ep93xx_spi_probe,
 	.remove_new	= ep93xx_spi_remove,

-- 
2.43.2



