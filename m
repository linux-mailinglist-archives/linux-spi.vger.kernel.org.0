Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6472AADF1
	for <lists+linux-spi@lfdr.de>; Sun,  8 Nov 2020 23:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgKHWtR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 8 Nov 2020 17:49:17 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:37643 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgKHWtP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 8 Nov 2020 17:49:15 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2020 17:49:15 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id C05C1101E6A9D;
        Sun,  8 Nov 2020 23:41:46 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 86759603DAD2;
        Sun,  8 Nov 2020 23:41:46 +0100 (CET)
X-Mailbox-Line: From ab3c0b18bd820501a12c85e440006e09ec0e275f Mon Sep 17 00:00:00 2001
Message-Id: <ab3c0b18bd820501a12c85e440006e09ec0e275f.1604874488.git.lukas@wunner.de>
In-Reply-To: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 8 Nov 2020 23:41:00 +0100
Subject: [PATCH] spi: lpspi: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Normally the last reference on an spi_controller is released by
spi_unregister_controller().  In the case of the i.MX lpspi driver,
the spi_controller is registered with devm_spi_register_controller(),
so spi_unregister_controller() is invoked automatically after the driver
has unbound.

However the driver already releases the last reference in
fsl_lpspi_remove() through a gratuitous call to spi_master_put(),
causing a use-after-free when spi_unregister_controller() is
subsequently invoked by the devres framework.

Fix by dropping the superfluous spi_master_put().

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.2+
Cc: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 986b9793fd3c..a2886ee44e4c 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -938,9 +938,6 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 				spi_controller_get_devdata(controller);
 
 	pm_runtime_disable(fsl_lpspi->dev);
-
-	spi_master_put(controller);
-
 	return 0;
 }
 
-- 
2.28.0

