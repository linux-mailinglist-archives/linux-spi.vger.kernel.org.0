Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2EA86B91
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 22:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390364AbfHHUd6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 16:33:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59174 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404800AbfHHUd6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 16:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Wzf+I9fcsxZuVaYRajx66L1PY3WCux2mFR6C4152LNM=; b=rzSrJ+LL0sL1
        P6O11YsZkVDbKRtuB09B8IAybDpOKC8o5SUQUDFcB+RLyR4rwJJ/N/60pG0RAtnC0/dhwsunZ2Ock
        7Ay7EWzrE2kRWW/mx26FUPj/ju13v/8e30dBhZwRCxpMqLb53d0ra80O+TTRiJ1sxgTR8CHmKWTnm
        Z89Yc=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvp6h-00043F-1u; Thu, 08 Aug 2019 20:33:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6CADD2742B42; Thu,  8 Aug 2019 21:33:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Rename of_spi_register_master() function" to the spi tree
In-Reply-To: <20190808150321.23319-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190808203354.6CADD2742B42@ypsilon.sirena.org.uk>
Date:   Thu,  8 Aug 2019 21:33:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Rename of_spi_register_master() function

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From 43004f31ebf2705905460a6d9a77da4182170c38 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Aug 2019 17:03:21 +0200
Subject: [PATCH] spi: Rename of_spi_register_master() function

Rename this function to of_spi_get_gpio_numbers() as this
is what the function does, it does not register a master,
it is called in the path of registering a master so the
name is logical in a convoluted way, but it is better to
follow Rusty Russell's ABI level no 7:
"The obvious use is (probably) the correct one"

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20190808150321.23319-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8e83c9567353..aef55acb5ccd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2235,7 +2235,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 EXPORT_SYMBOL_GPL(__spi_alloc_controller);
 
 #ifdef CONFIG_OF
-static int of_spi_register_master(struct spi_controller *ctlr)
+static int of_spi_get_gpio_numbers(struct spi_controller *ctlr)
 {
 	int nb, i, *cs;
 	struct device_node *np = ctlr->dev.of_node;
@@ -2268,7 +2268,7 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 	return 0;
 }
 #else
-static int of_spi_register_master(struct spi_controller *ctlr)
+static int of_spi_get_gpio_numbers(struct spi_controller *ctlr)
 {
 	return 0;
 }
@@ -2455,7 +2455,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			ctlr->mode_bits |= SPI_CS_HIGH;
 		} else {
 			/* Legacy code path for GPIOs from DT */
-			status = of_spi_register_master(ctlr);
+			status = of_spi_get_gpio_numbers(ctlr);
 			if (status)
 				return status;
 		}
-- 
2.20.1

