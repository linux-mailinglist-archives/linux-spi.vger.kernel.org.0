Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64B5AFB04
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 13:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfIKLCG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 07:02:06 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:44303 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKLCG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 07:02:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 6D3BA101903B3;
        Wed, 11 Sep 2019 13:02:04 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 2E5C86124A1A;
        Wed, 11 Sep 2019 13:02:04 +0200 (CEST)
X-Mailbox-Line: From b2286c904408745192e4beb3de3c88f73e4a7210 Mon Sep 17 00:00:00 2001
Message-Id: <b2286c904408745192e4beb3de3c88f73e4a7210.1568187525.git.lukas@wunner.de>
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 09/10] dmaengine: bcm2835: Avoid accessing memory when
 copying zeroes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2835 DMA controller is capable of synthesizing zeroes instead of
copying them from a source address. The feature is enabled by setting
the SRC_IGNORE bit in the Transfer Information field of a Control Block:

"Do not perform source reads.
 In addition, destination writes will zero all the write strobes.
 This is used for fast cache fill operations."
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

The feature is only available on 8 of the 16 channels. The others are
so-called "lite" channels with a limited feature set and performance.

Enable the feature if a cyclic transaction copies from the zero page.
This reduces traffic on the memory bus.

A forthcoming use case is the BCM2835 SPI driver, which will cyclically
copy from the zero page to the TX FIFO. The idea to use SRC_IGNORE was
taken from an ancient GitHub conversation between Martin and Noralf:
https://github.com/msperl/spi-bcm2835/issues/13#issuecomment-98180451

Tested-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Kauer <florian.kauer@koalo.de>
---
 drivers/dma/bcm2835-dma.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 14358faf3bff..67100e4e1083 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -42,11 +42,14 @@
  * @ddev: DMA device
  * @base: base address of register map
  * @dma_parms: DMA parameters (to convey 1 GByte max segment size to clients)
+ * @zero_page: bus address of zero page (to detect transactions copying from
+ *	zero page and avoid accessing memory if so)
  */
 struct bcm2835_dmadev {
 	struct dma_device ddev;
 	void __iomem *base;
 	struct device_dma_parameters dma_parms;
+	dma_addr_t zero_page;
 };
 
 struct bcm2835_dma_cb {
@@ -693,6 +696,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	size_t period_len, enum dma_transfer_direction direction,
 	unsigned long flags)
 {
+	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
@@ -743,6 +747,10 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		dst = c->cfg.dst_addr;
 		src = buf_addr;
 		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
+
+		/* non-lite channels can write zeroes w/o accessing memory */
+		if (buf_addr == od->zero_page && !c->is_lite_channel)
+			info |= BCM2835_DMA_S_IGNORE;
 	}
 
 	/* calculate number of frames */
@@ -845,6 +853,9 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
 		list_del(&c->vc.chan.device_node);
 		tasklet_kill(&c->vc.task);
 	}
+
+	dma_unmap_page_attrs(od->ddev.dev, od->zero_page, PAGE_SIZE,
+			     DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
 }
 
 static const struct of_device_id bcm2835_dma_of_match[] = {
@@ -927,6 +938,14 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, od);
 
+	od->zero_page = dma_map_page_attrs(od->ddev.dev, ZERO_PAGE(0), 0,
+					   PAGE_SIZE, DMA_TO_DEVICE,
+					   DMA_ATTR_SKIP_CPU_SYNC);
+	if (dma_mapping_error(od->ddev.dev, od->zero_page)) {
+		dev_err(&pdev->dev, "Failed to map zero page\n");
+		return -ENOMEM;
+	}
+
 	/* Request DMA channel mask from device tree */
 	if (of_property_read_u32(pdev->dev.of_node,
 			"brcm,dma-channel-mask",
-- 
2.23.0

