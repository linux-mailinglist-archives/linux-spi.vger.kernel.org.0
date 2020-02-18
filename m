Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963A91625F3
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 13:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgBRMNN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 07:13:13 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:55229 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgBRMNN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Feb 2020 07:13:13 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 07:13:11 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D20E610189C68;
        Tue, 18 Feb 2020 13:08:04 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 8507660EBB20;
        Tue, 18 Feb 2020 13:08:04 +0100 (CET)
X-Mailbox-Line: From fca3ba7cdc930cd36854666ceac4fbcf01b89028 Mon Sep 17 00:00:00 2001
Message-Id: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 18 Feb 2020 13:08:00 +0100
Subject: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, Simon Han <z.han@kunbus.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
amended of_spi_parse_dt() to always set SPI_CS_HIGH for SPI slaves whose
Chip Select is defined by a "cs-gpios" devicetree property.

This change broke userspace applications which issue an SPI_IOC_WR_MODE
ioctl() to an spidev:  Chip Select polarity will be incorrect unless the
application is changed to set SPI_CS_HIGH.  And once changed, it will be
incompatible with kernels not containing the commit.

Fix by setting SPI_CS_HIGH in spidev_ioctl() (under the same conditions
as in of_spi_parse_dt()).

Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Reported-by: Simon Han <z.han@kunbus.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.1+
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spidev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 1e217e3e9486..2ab6e782f14c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -396,6 +396,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		else
 			retval = get_user(tmp, (u32 __user *)arg);
 		if (retval == 0) {
+			struct spi_controller *ctlr = spi->controller;
 			u32	save = spi->mode;
 
 			if (tmp & ~SPI_MODE_MASK) {
@@ -403,6 +404,10 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				break;
 			}
 
+			if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
+			    ctlr->cs_gpiods[spi->chip_select])
+				tmp |= SPI_CS_HIGH;
+
 			tmp |= spi->mode & ~SPI_MODE_MASK;
 			spi->mode = (u16)tmp;
 			retval = spi_setup(spi);
-- 
2.24.0

