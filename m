Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D61C37D6
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEDLR7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 07:17:59 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:45283 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDLR7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 May 2020 07:17:59 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2020 07:17:58 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id B181810044AA5;
        Mon,  4 May 2020 13:17:57 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 7FDA060F2900;
        Mon,  4 May 2020 13:17:57 +0200 (CEST)
X-Mailbox-Line: From 5e53ccdf1eecd4e015dba99d0d77389107f8a2e3 Mon Sep 17 00:00:00 2001
Message-Id: <5e53ccdf1eecd4e015dba99d0d77389107f8a2e3.1588590210.git.lukas@wunner.de>
In-Reply-To: <cover.1588590210.git.lukas@wunner.de>
References: <cover.1588590210.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 4 May 2020 13:12:04 +0200
Subject: [PATCH 4/5] spi: amd: Fix refcount underflow on remove
To:     Mark Brown <broonie@kernel.org>,
        "Sanjay R Mehta" <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The AMD SPI driver calls spi_master_put() in its ->remove() hook even
though the preceding call to spi_unregister_master() already drops a
ref, thus leading to a refcount underflow.  Drop the superfluous call
to spi_master_put().

This only leaves the call to spi_unregister_master() in the ->remove()
hook, so it's safe to change the ->probe() hook to use the devm version
of spi_register_master() and drop the ->remove() hook altogether.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi-amd.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index d3e3516ef957..00f2f3405e08 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -282,7 +282,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	master->transfer_one_message = amd_spi_master_transfer;
 
 	/* Register the controller with SPI framework */
-	err = spi_register_master(master);
+	err = devm_spi_register_master(dev, master);
 	if (err) {
 		dev_err(dev, "error %d registering SPI controller\n", err);
 		goto err_free_master;
@@ -296,16 +296,6 @@ static int amd_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int amd_spi_remove(struct platform_device *pdev)
-{
-	struct amd_spi *amd_spi = platform_get_drvdata(pdev);
-
-	spi_unregister_master(amd_spi->master);
-	spi_master_put(amd_spi->master);
-
-	return 0;
-}
-
 static const struct acpi_device_id spi_acpi_match[] = {
 	{ "AMDI0061", 0 },
 	{},
@@ -318,7 +308,6 @@ static struct platform_driver amd_spi_driver = {
 		.acpi_match_table = ACPI_PTR(spi_acpi_match),
 	},
 	.probe = amd_spi_probe,
-	.remove = amd_spi_remove,
 };
 
 module_platform_driver(amd_spi_driver);
-- 
2.26.2

