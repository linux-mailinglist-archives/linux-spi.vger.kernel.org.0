Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB4C2B3EF5
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKPIoD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKPIoD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:44:03 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C88C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 00:44:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 559C31018982B;
        Mon, 16 Nov 2020 09:44:02 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 120926035EEE;
        Mon, 16 Nov 2020 09:44:02 +0100 (CET)
X-Mailbox-Line: From 49102f5bbb3f1592d9cfd7b39ac5e131a031f950 Mon Sep 17 00:00:00 2001
Message-Id: <49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:09 +0100
Subject: [PATCH for-5.10] spi: gpio: Don't leak SPI master in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the call to devm_spi_register_master() fails on probe of the GPIO SPI
driver, the spi_master struct is erroneously not freed:

After allocating the spi_master, its reference count is 1.  The driver
unconditionally decrements the reference count on unbind using a devm
action.  Before calling devm_spi_register_master(), the driver
unconditionally increments the reference count because on success,
that function will decrement the reference count on unbind.  However on
failure, devm_spi_register_master() does *not* decrement the reference
count, so the spi_master is leaked.

The issue was introduced by commits 8b797490b4db ("spi: gpio: Make sure
spi_master_put() is called in every error path") and 79567c1a321e ("spi:
gpio: Use devm_spi_register_master()"), which sought to plug leaks
introduced by 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO
descriptors") but missed this remaining leak.

The situation was later aggravated by commit d3b0ffa1d75d ("spi: gpio:
prevent memory leak in spi_gpio_probe"), which introduced a
use-after-free because it releases a reference on the spi_master if
devm_add_action_or_reset() fails even though the function already
does that.

Fix by switching over to the new devm_spi_alloc_master() helper.

Fixes: 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO descriptors")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.17+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.1-: 8b797490b4db: spi: gpio: Make sure spi_master_put() is called in every error path
Cc: <stable@vger.kernel.org> # v5.1-: 45beec351998: spi: bitbang: Introduce spi_bitbang_init()
Cc: <stable@vger.kernel.org> # v5.1-: 79567c1a321e: spi: gpio: Use devm_spi_register_master()
Cc: <stable@vger.kernel.org> # v5.4-: d3b0ffa1d75d: spi: gpio: prevent memory leak in spi_gpio_probe
Cc: <stable@vger.kernel.org> # v4.17+
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-gpio.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 7ceb0ba27b75..0584f4d2fde2 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -350,11 +350,6 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 	return 0;
 }
 
-static void spi_gpio_put(void *data)
-{
-	spi_master_put(data);
-}
-
 static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
@@ -363,16 +358,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
 
-	master = spi_alloc_master(dev, sizeof(*spi_gpio));
+	master = devm_spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
 		return -ENOMEM;
 
-	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
-	if (status) {
-		spi_master_put(master);
-		return status;
-	}
-
 	if (pdev->dev.of_node)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
@@ -432,7 +421,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	return devm_spi_register_master(&pdev->dev, spi_master_get(master));
+	return devm_spi_register_master(&pdev->dev, master);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.28.0

