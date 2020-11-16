Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460ED2B3EC8
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgKPIf2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:35:28 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:44467 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgKPIf2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:35:28 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 6E78710189A1B;
        Mon, 16 Nov 2020 09:35:26 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 278F76035EEE;
        Mon, 16 Nov 2020 09:35:26 +0100 (CET)
X-Mailbox-Line: From b43ec730d0991482d5c22cb0b63c68f2e04d5445 Mon Sep 17 00:00:00 2001
Message-Id: <b43ec730d0991482d5c22cb0b63c68f2e04d5445.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:04 +0100
Subject: [PATCH for-5.10] spi: pxa2xx: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pxa2xx_spi_remove() accesses the driver's private data after calling
spi_unregister_controller() even though that function releases the last
reference on the spi_controller and thereby frees the private data.

Fix by switching over to the new devm_spi_alloc_master/slave() helper
which keeps the private data accessible until the driver has unbound.

Fixes: 32e5b57232c0 ("spi: pxa2xx: Fix controller unregister order")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v2.6.17+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v2.6.17+: 32e5b57232c0: spi: pxa2xx: Fix controller unregister order
Cc: <stable@vger.kernel.org> # v2.6.17+
---
 drivers/spi/spi-pxa2xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 814268405ab0..d6b534d38e5d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1686,9 +1686,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	if (platform_info->is_slave)
-		controller = spi_alloc_slave(dev, sizeof(struct driver_data));
+		controller = devm_spi_alloc_slave(dev, sizeof(*drv_data));
 	else
-		controller = spi_alloc_master(dev, sizeof(struct driver_data));
+		controller = devm_spi_alloc_master(dev, sizeof(*drv_data));
 
 	if (!controller) {
 		dev_err(&pdev->dev, "cannot alloc spi_controller\n");
@@ -1911,7 +1911,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	free_irq(ssp->irq, drv_data);
 
 out_error_controller_alloc:
-	spi_controller_put(controller);
 	pxa_ssp_free(ssp);
 	return status;
 }
-- 
2.28.0

