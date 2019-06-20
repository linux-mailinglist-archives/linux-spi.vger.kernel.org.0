Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417084CEC1
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfFTNcl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 09:32:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59374 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfFTNcl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 09:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Dv9ZBE80g7Z3d10imVyCnlRbO2J+0mkQKX+QLqGV7YY=; b=p3r5yCvPJSwj
        +5y0GAkBB519r+d45x2QbdB5SHY1v/qA1HpDKwIzConMTN7PwHpm/i0GUDUgmArfUrqaDHh62/pTz
        4nIgWHayiuSiWsvdLX5oZgYbkfIzPhQNXRM5IdDepjLJQEI4K622CsihU+8uezq45XXzruIKt3Ry8
        NQmwk=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdxB7-0000kt-8y; Thu, 20 Jun 2019 13:32:37 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B1610440046; Thu, 20 Jun 2019 14:32:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     broonie@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Nicolas.Ferre@microchip.com,
        Tudor.Ambarus@microchip.com
Subject: Applied "spi: fix ctrl->num_chipselect constraint" to the spi tree
In-Reply-To: <20190619143820.4045-1-tudor.ambarus@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190620133236.B1610440046@finisterre.sirena.org.uk>
Date:   Thu, 20 Jun 2019 14:32:36 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: fix ctrl->num_chipselect constraint

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From f9481b08220d7dc1ff21e296a330ee8b721b44e4 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 19 Jun 2019 14:38:28 +0000
Subject: [PATCH] spi: fix ctrl->num_chipselect constraint

at91sam9g25ek showed the following error at probe:
atmel_spi f0000000.spi: Using dma0chan2 (tx) and dma0chan3 (rx)
for DMA transfers
atmel_spi: probe of f0000000.spi failed with error -22

Commit 0a919ae49223 ("spi: Don't call spi_get_gpio_descs() before device name is set")
moved the calling of spi_get_gpio_descs() after ctrl->dev is set,
but didn't move the !ctrl->num_chipselect check. When there are
chip selects in the device tree, the spi-atmel driver lets the
SPI core discover them when registering the SPI master.
The ctrl->num_chipselect is thus expected to be set by
spi_get_gpio_descs().

Move the !ctlr->num_chipselect after spi_get_gpio_descs() as it was
before the aforementioned commit. While touching this block, get rid
of the explicit comparison with 0 and update the commenting style.

Fixes: 0a919ae49223 ("spi: Don't call spi_get_gpio_descs() before device name is set")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a31e1e291335..80d2d14f6294 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2375,11 +2375,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
-	/* even if it's just one always-selected device, there must
-	 * be at least one chipselect
-	 */
-	if (ctlr->num_chipselect == 0)
-		return -EINVAL;
 	if (ctlr->bus_num >= 0) {
 		/* devices with a fixed bus num must check-in with the num */
 		mutex_lock(&board_lock);
@@ -2450,6 +2445,13 @@ int spi_register_controller(struct spi_controller *ctlr)
 		}
 	}
 
+	/*
+	 * Even if it's just one always-selected device, there must
+	 * be at least one chipselect.
+	 */
+	if (!ctlr->num_chipselect)
+		return -EINVAL;
+
 	status = device_add(&ctlr->dev);
 	if (status < 0) {
 		/* free bus id */
-- 
2.20.1

