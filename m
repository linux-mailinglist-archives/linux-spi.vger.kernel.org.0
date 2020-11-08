Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF72AADF6
	for <lists+linux-spi@lfdr.de>; Sun,  8 Nov 2020 23:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgKHWtg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 8 Nov 2020 17:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgKHWtg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 8 Nov 2020 17:49:36 -0500
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Nov 2020 14:49:36 PST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F73C0613CF
        for <linux-spi@vger.kernel.org>; Sun,  8 Nov 2020 14:49:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id B8E5F1031E7E4;
        Sun,  8 Nov 2020 23:43:54 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 73406603DAD2;
        Sun,  8 Nov 2020 23:43:54 +0100 (CET)
X-Mailbox-Line: From fbe8768c30dc829e2d77eabe7be062ca22f84024 Mon Sep 17 00:00:00 2001
Message-Id: <fbe8768c30dc829e2d77eabe7be062ca22f84024.1604874488.git.lukas@wunner.de>
In-Reply-To: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 8 Nov 2020 23:41:00 +0100
Subject: [PATCH] spi: st-ssc4: Fix unbalanced pm_runtime_disable() in probe
 error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to devm_platform_ioremap_resource(), irq_of_parse_and_map()
or devm_request_irq() fail on probe of the ST SSC4 SPI driver, the
runtime PM disable depth is incremented even though it was not
decremented before.  Fix it.

Fixes: cd050abeba2a ("spi: st-ssc4: add missed pm_runtime_disable")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.5+
Cc: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-st-ssc4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 77d26d64541a..6c44dda9ee8c 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -375,13 +375,14 @@ static int spi_st_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register master\n");
-		goto clk_disable;
+		goto rpm_disable;
 	}
 
 	return 0;
 
-clk_disable:
+rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+clk_disable:
 	clk_disable_unprepare(spi_st->clk);
 put_master:
 	spi_master_put(master);
-- 
2.28.0

