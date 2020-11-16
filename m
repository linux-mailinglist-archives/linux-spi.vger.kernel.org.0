Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19882B3EF0
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKPIme (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKPIme (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:42:34 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31427C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 00:42:34 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D8C19101903D8;
        Mon, 16 Nov 2020 09:42:31 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 853976035EEE;
        Mon, 16 Nov 2020 09:42:32 +0100 (CET)
X-Mailbox-Line: From 800f7035a29c1ae65386f2e17a2b5ef9d2b39268 Mon Sep 17 00:00:00 2001
Message-Id: <800f7035a29c1ae65386f2e17a2b5ef9d2b39268.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:07 +0100
Subject: [PATCH for-5.10] spi: mt7621: Don't leak SPI master in probe error
 path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Roese <sr@denx.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to device_reset() or devm_spi_register_controller() fail on
probe of the MediaTek MT7621 SPI driver, the spi_controller struct is
erroneously not freed.  Fix by switching over to the new
devm_spi_alloc_master() helper.

Moreover, the SYS clock is enabled on probe but not disabled if any of
the subsequent probe steps fails.

Finally, there's an ordering issue in mt7621_spi_remove() wherein
the spi_controller is unregistered after disabling the SYS clock.
The correct order is to call spi_unregister_controller() *before* this
teardown step because bus accesses may still be ongoing until that
function returns.

All of these bugs have existed since the driver was first introduced,
so it seems fair to fix them together in a single commit.

Fixes: 1ab7f2a43558 ("staging: mt7621-spi: add mt7621 support")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.17+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.17+
---
 drivers/spi/spi-mt7621.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 2c3b7a2a1ec7..d7cda66c4b26 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -350,10 +350,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*rs));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rs));
 	if (!master) {
 		dev_info(&pdev->dev, "master allocation failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_clk_disable;
 	}
 
 	master->mode_bits = SPI_LSB_FIRST;
@@ -377,10 +378,18 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	ret = device_reset(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "SPI reset failed!\n");
-		return ret;
+		goto err_clk_disable;
 	}
 
-	return devm_spi_register_controller(&pdev->dev, master);
+	ret = spi_register_controller(master);
+	if (ret)
+		goto err_clk_disable;
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 
 static int mt7621_spi_remove(struct platform_device *pdev)
@@ -391,6 +400,7 @@ static int mt7621_spi_remove(struct platform_device *pdev)
 	master = dev_get_drvdata(&pdev->dev);
 	rs = spi_controller_get_devdata(master);
 
+	spi_unregister_controller(master);
 	clk_disable_unprepare(rs->clk);
 
 	return 0;
-- 
2.28.0

