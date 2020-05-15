Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A501D556A
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEOQBC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgEOQBC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 12:01:02 -0400
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF969C061A0C
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 09:01:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id EF3FE101E6A91;
        Fri, 15 May 2020 18:00:59 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 4D49F6000CEE;
        Fri, 15 May 2020 18:00:59 +0200 (CEST)
X-Mailbox-Line: From 32f27f4d8242e4d75f9a53f7e8f1f77483b08669 Mon Sep 17 00:00:00 2001
Message-Id: <32f27f4d8242e4d75f9a53f7e8f1f77483b08669.1589557526.git.lukas@wunner.de>
In-Reply-To: <cover.1589557526.git.lukas@wunner.de>
References: <cover.1589557526.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 15 May 2020 17:58:03 +0200
Subject: [PATCH 3/5] spi: bcm2835aux: Fix controller unregister order
To:     Mark Brown <broonie@kernel.org>
Cc:     "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2835aux SPI driver uses devm_spi_register_master() on bind.
As a consequence, on unbind, __device_release_driver() first invokes
bcm2835aux_spi_remove() before unregistering the SPI controller via
devres_release_all().

This order is incorrect:  bcm2835aux_spi_remove() turns off the SPI
controller, including its interrupts and clock.  The SPI controller
is thus no longer usable.

When the SPI controller is subsequently unregistered, it unbinds all
its slave devices.  If their drivers need to access the SPI bus,
e.g. to quiesce their interrupts, unbinding will fail.

As a rule, devm_spi_register_master() must not be used if the
->remove() hook performs teardown steps which shall be performed
after unbinding of slaves.

Fix by using the non-devm variant spi_register_master().  Note that the
struct spi_master as well as the driver-private data are not freed until
after bcm2835aux_spi_remove() has finished, so accessing them is safe.

Fixes: 1ea29b39f4c8 ("spi: bcm2835aux: add bcm2835 auxiliary spi device driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.4+
Cc: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index a2162ff56a12..c331efd6e86b 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -569,7 +569,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = spi_register_master(master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
 		goto out_clk_disable;
@@ -593,6 +593,8 @@ static int bcm2835aux_spi_remove(struct platform_device *pdev)
 
 	bcm2835aux_debugfs_remove(bs);
 
+	spi_unregister_master(master);
+
 	bcm2835aux_spi_reset_hw(bs);
 
 	/* disable the HW block by releasing the clock */
-- 
2.26.2

