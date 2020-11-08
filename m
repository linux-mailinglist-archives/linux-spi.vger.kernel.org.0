Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984A02AADFF
	for <lists+linux-spi@lfdr.de>; Sun,  8 Nov 2020 23:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgKHWtv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 8 Nov 2020 17:49:51 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:35611 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgKHWtv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 8 Nov 2020 17:49:51 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2020 17:49:50 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 9D536103D9C62;
        Sun,  8 Nov 2020 23:41:04 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 0BE2E603DAD2;
        Sun,  8 Nov 2020 23:41:05 +0100 (CET)
X-Mailbox-Line: From dd060534490eca5e946eb9165916542b01a9358d Mon Sep 17 00:00:00 2001
Message-Id: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 8 Nov 2020 23:41:00 +0100
Subject: [PATCH] spi: davinci: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

davinci_spi_remove() accesses the driver's private data after it's been
freed with spi_master_put().

Fix by moving the spi_master_put() to the end of the function.

Fixes: fe5fd2540947 ("spi: davinci: Use dma_request_chan() for requesting DMA channel")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.7+
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 818f2b22875d..7453a1dbbc06 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -1040,13 +1040,13 @@ static int davinci_spi_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&dspi->bitbang);
 
 	clk_disable_unprepare(dspi->clk);
-	spi_master_put(master);
 
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
 	}
 
+	spi_master_put(master);
 	return 0;
 }
 
-- 
2.28.0

