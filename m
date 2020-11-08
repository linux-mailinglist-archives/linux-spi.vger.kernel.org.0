Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8923A2AADF7
	for <lists+linux-spi@lfdr.de>; Sun,  8 Nov 2020 23:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKHWtg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 8 Nov 2020 17:49:36 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:59501 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgKHWtg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 8 Nov 2020 17:49:36 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2020 17:49:35 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 6957610315740;
        Sun,  8 Nov 2020 23:43:29 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 108A3603DAD2;
        Sun,  8 Nov 2020 23:43:29 +0100 (CET)
X-Mailbox-Line: From 9624250e3a7aa61274b38219a62375bac1def637 Mon Sep 17 00:00:00 2001
Message-Id: <9624250e3a7aa61274b38219a62375bac1def637.1604874488.git.lukas@wunner.de>
In-Reply-To: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 8 Nov 2020 23:41:00 +0100
Subject: [PATCH] spi: pic32: Don't leak DMA channels in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        "Purna Chandra Mandal" <purna.mandal@microchip.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to devm_request_irq() or devm_spi_register_master() fail
on probe of the PIC32 SPI driver, the DMA channels requested by
pic32_spi_dma_prep() are erroneously not released.  Plug the leak.

Fixes: 1bcb9f8ceb67 ("spi: spi-pic32: Add PIC32 SPI master driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.7+
Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
---
 drivers/spi/spi-pic32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 156961b4ca86..104bde153efd 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -839,6 +839,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	return 0;
 
 err_bailout:
+	pic32_spi_dma_unprep(pic32s);
 	clk_disable_unprepare(pic32s->clk);
 err_master:
 	spi_master_put(master);
-- 
2.28.0

