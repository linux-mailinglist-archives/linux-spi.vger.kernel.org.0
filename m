Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A462D0BEE
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLGIpX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLGIpX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:45:23 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E35C0613D0
        for <linux-spi@vger.kernel.org>; Mon,  7 Dec 2020 00:44:43 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9A16930000CF4;
        Mon,  7 Dec 2020 09:44:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 18AF710DB; Mon,  7 Dec 2020 09:44:42 +0100 (CET)
Message-Id: <1d58367d74d55741e0c2730a51a2b65012c8ab33.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:15 +0100
Subject: [PATCH 15/17] spi: ar934x: Don't leak SPI master in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the call to devm_spi_register_controller() fails on probe of the
Qualcomm Atheros AR934x/QCA95xx SPI driver, the spi_controller struct is
erroneously not freed.  Fix by switching over to the new
devm_spi_alloc_master() helper.

Moreover, the controller's clock is enabled on probe but not disabled if
any of the subsequent probe steps fail.

Finally, there's an ordering issue in ar934x_spi_remove() wherein the
clock is disabled even though the controller is not yet unregistered.
It is unregistered after ar934x_spi_remove() by the devres framework.
As long as it is not unregistered, SPI transfers may still be ongoing
and disabling the clock may break them.  It is not possible to use
devm_spi_register_controller() in this case, so move to the non-devm
variant.

All of these bugs have existed since the driver was first introduced,
so it seems fair to fix them together in a single commit.

Fixes: 047980c582af ("spi: add driver for ar934x spi controller")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.7+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.7+
Cc: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/spi/spi-ar934x.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index d08dec09d423..def32e0aaefe 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -176,10 +176,11 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_info(&pdev->dev, "failed to allocate spi controller\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_clk_disable;
 	}
 
 	/* disable flash mapping and expose spi controller registers */
@@ -202,7 +203,13 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 	sp->clk_freq = clk_get_rate(clk);
 	sp->ctlr = ctlr;
 
-	return devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
+	if (!ret)
+		return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 
 static int ar934x_spi_remove(struct platform_device *pdev)
@@ -213,6 +220,7 @@ static int ar934x_spi_remove(struct platform_device *pdev)
 	ctlr = dev_get_drvdata(&pdev->dev);
 	sp = spi_controller_get_devdata(ctlr);
 
+	spi_unregister_controller(ctlr);
 	clk_disable_unprepare(sp->clk);
 
 	return 0;
-- 
2.29.2

