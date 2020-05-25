Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC61E0E60
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbgEYM0M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390505AbgEYM0L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 08:26:11 -0400
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072DFC061A0E
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2020 05:26:11 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D671710189BE0;
        Mon, 25 May 2020 14:26:09 +0200 (CEST)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 90CAC6029C6E;
        Mon, 25 May 2020 14:26:09 +0200 (CEST)
X-Mailbox-Line: From 3fff8cb8ae44a9893840d0688be15bb88c090a14 Mon Sep 17 00:00:00 2001
Message-Id: <3fff8cb8ae44a9893840d0688be15bb88c090a14.1590408496.git.lukas@wunner.de>
In-Reply-To: <cover.1590408496.git.lukas@wunner.de>
References: <cover.1590408496.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 25 May 2020 14:25:01 +0200
Subject: [PATCH 1/3] spi: dw: Fix controller unregister order
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Designware SPI driver uses devm_spi_register_controller() on bind.
As a consequence, on unbind, __device_release_driver() first invokes
dw_spi_remove_host() before unregistering the SPI controller via
devres_release_all().

This order is incorrect:  dw_spi_remove_host() shuts down the chip,
rendering the SPI bus inaccessible even though the SPI controller is
still registered.  When the SPI controller is subsequently unregistered,
it unbinds all its slave devices.  Because their drivers cannot access
the SPI bus, e.g. to quiesce interrupts, the slave devices may be left
in an improper state.

As a rule, devm_spi_register_controller() must not be used if the
->remove() hook performs teardown steps which shall be performed after
unregistering the controller and specifically after unbinding of slaves.

Fix by reverting to the non-devm variant of spi_register_controller().

An alternative approach would be to use device-managed functions for all
steps in dw_spi_remove_host(), e.g. by calling devm_add_action_or_reset()
on probe.  However that approach would add more LoC to the driver and
it wouldn't lend itself as well to backporting to stable.

Fixes: 04f421e7b0b1 ("spi: dw: use managed resources")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.14+
Cc: Baruch Siach <baruch@tkos.co.il>
---
 drivers/spi/spi-dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 1edb8cdd11ee..9d6904d30104 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -520,7 +520,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
-	ret = devm_spi_register_controller(dev, master);
+	ret = spi_register_controller(master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
 		goto err_dma_exit;
@@ -544,6 +544,8 @@ void dw_spi_remove_host(struct dw_spi *dws)
 {
 	dw_spi_debugfs_remove(dws);
 
+	spi_unregister_controller(dws->master);
+
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 
-- 
2.25.0

