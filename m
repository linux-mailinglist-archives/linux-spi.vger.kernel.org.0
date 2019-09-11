Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD45AFAF7
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfIKK7Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:59:16 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:59879 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfIKK7Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:59:16 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 89F5610190FA9;
        Wed, 11 Sep 2019 12:59:14 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 475516124A1A;
        Wed, 11 Sep 2019 12:59:14 +0200 (CEST)
X-Mailbox-Line: From 78648f80f67d97bb7beecc1b9be6b6e4a45bc1d8 Mon Sep 17 00:00:00 2001
Message-Id: <78648f80f67d97bb7beecc1b9be6b6e4a45bc1d8.1568187525.git.lukas@wunner.de>
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 08/10] dmaengine: bcm2835: Document struct bcm2835_dmadev
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the BCM2835 DMA driver's device data structure so that upcoming
commits may add further members with proper kerneldoc.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Kauer <florian.kauer@koalo.de>
---
 drivers/dma/bcm2835-dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index a65514fcb7f2..14358faf3bff 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -37,6 +37,12 @@
 #define BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED 14
 #define BCM2835_DMA_CHAN_NAME_SIZE 8
 
+/**
+ * struct bcm2835_dmadev - BCM2835 DMA controller
+ * @ddev: DMA device
+ * @base: base address of register map
+ * @dma_parms: DMA parameters (to convey 1 GByte max segment size to clients)
+ */
 struct bcm2835_dmadev {
 	struct dma_device ddev;
 	void __iomem *base;
-- 
2.23.0

