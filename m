Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46B41B956
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfEMPAE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 11:00:04 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:45449 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfEMPAE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 11:00:04 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 913AA102D3B92;
        Mon, 13 May 2019 16:50:40 +0200 (CEST)
Received: from localhost (p54917535.dip0.t-ipconnect.de [84.145.117.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 398686154089;
        Mon, 13 May 2019 16:50:40 +0200 (CEST)
X-Mailbox-Line: From 5c7b7ca7813564f062d9891847b510ce91067585 Mon Sep 17 00:00:00 2001
Message-Id: <5c7b7ca7813564f062d9891847b510ce91067585.1557758205.git.lukas@wunner.de>
In-Reply-To: <5622fbd8314cf518b9530745e49545bc6287015d.1557758205.git.lukas@wunner.de>
References: <5622fbd8314cf518b9530745e49545bc6287015d.1557758205.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 13 May 2019 16:48:39 +0200
Subject: [PATCH] spi: bcm2835: Drop assignment of dma_slave_config direction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Frank Pavlic <f.pavlic@kunbus.de>, Simon Han <z.han@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Vinod Koul <vkoul@kernel.org>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2835 SPI driver still sets the "direction" member in struct
dma_slave_config even though it was deprecated five years ago with
commit d9ff958bb34a ("dmaengine: Mark the struct dma_slave_config
direction field deprecated") and is no longer evaluated by the BCM2835
DMA driver since commit 00648f4d0f41 ("dmaengine: bcm2835: remove
dma_slave_config direction usage").

Drop the superfluous assignment.
No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/spi/spi-bcm2835.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 1c34a7bcdb7f..9c03da7c18dd 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -729,7 +729,6 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
 	}
 
 	/* configure DMAs */
-	slave_config.direction = DMA_MEM_TO_DEV;
 	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
@@ -737,7 +736,6 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
 	if (ret)
 		goto err_config;
 
-	slave_config.direction = DMA_DEV_TO_MEM;
 	slave_config.src_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-- 
2.20.1

