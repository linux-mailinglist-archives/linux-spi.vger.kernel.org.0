Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E162AF8BA
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 20:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgKKTKr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 14:10:47 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:34937 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKTKq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 14:10:46 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 5355B101E69A6;
        Wed, 11 Nov 2020 20:10:44 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 200DB60E6357;
        Wed, 11 Nov 2020 20:10:44 +0100 (CET)
X-Mailbox-Line: From b290b06357d0c0bdee9cecc539b840a90630f101 Mon Sep 17 00:00:00 2001
Message-Id: <b290b06357d0c0bdee9cecc539b840a90630f101.1605121038.git.lukas@wunner.de>
In-Reply-To: <cover.1605121038.git.lukas@wunner.de>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
        <cover.1605121038.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Nov 2020 20:07:30 +0100
Subject: [PATCH 3/4] spi: bcm2835aux: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

bcm2835aux_spi_remove() accesses the driver's private data after calling
spi_unregister_master() even though that function releases the last
reference on the spi_master and thereby frees the private data.

Fix by switching over to the new devm_spi_alloc_master() helper which
keeps the private data accessible until the driver has unbound.

Fixes: b9dd3f6d4172 ("spi: bcm2835aux: Fix controller unregister order")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.4+: 123456789abc: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.4+: b9dd3f6d4172: spi: bcm2835aux: Fix controller unregister order
Cc: <stable@vger.kernel.org> # v4.4+
---
 drivers/spi/spi-bcm2835aux.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 03b034c15d2b..fd58547110e6 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -494,7 +494,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	unsigned long clk_hz;
 	int err;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!master)
 		return -ENOMEM;
 
@@ -524,29 +524,24 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 
 	/* the main area */
 	bs->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(bs->regs)) {
-		err = PTR_ERR(bs->regs);
-		goto out_master_put;
-	}
+	if (IS_ERR(bs->regs))
+		return PTR_ERR(bs->regs);
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
-		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
-		goto out_master_put;
+		return PTR_ERR(bs->clk);
 	}
 
 	bs->irq = platform_get_irq(pdev, 0);
-	if (bs->irq <= 0) {
-		err = bs->irq ? bs->irq : -ENODEV;
-		goto out_master_put;
-	}
+	if (bs->irq <= 0)
+		return bs->irq ? bs->irq : -ENODEV;
 
 	/* this also enables the HW block */
 	err = clk_prepare_enable(bs->clk);
 	if (err) {
 		dev_err(&pdev->dev, "could not prepare clock: %d\n", err);
-		goto out_master_put;
+		return err;
 	}
 
 	/* just checking if the clock returns a sane value */
@@ -581,8 +576,6 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
-out_master_put:
-	spi_master_put(master);
 	return err;
 }
 
-- 
2.28.0

