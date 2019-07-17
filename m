Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489B86C0B1
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2019 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGQR6X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jul 2019 13:58:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQR6X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jul 2019 13:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=D/zbFrOzyCwGCJW08ztoVg22SqJnjWI3tzlg/Z8Cj80=; b=ZXpITInP+oKZ
        nwLPZLUo2oDn5HHztOFfD10XFEyT+Qb6vNNVgtJukQSOa5dc9MR+STqdoorAaJOgISJ+ISS1ywvnh
        GNyuqM6JU8vxzrLAK1JHFtaEWyQ35SAUVKd76Dr3ppRQNQEX0+3EKeFJkfKh3OTGRxW0IludROcQ8
        ZAhwI=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hnoC4-0001lq-HS; Wed, 17 Jul 2019 17:58:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 346612742C25; Wed, 17 Jul 2019 18:58:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Add SPI_MASTER_GPIO_SS flag" to the spi tree
In-Reply-To: <20190716204651.7743-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190717175819.346612742C25@ypsilon.sirena.org.uk>
Date:   Wed, 17 Jul 2019 18:58:19 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: gpio: Add SPI_MASTER_GPIO_SS flag

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

From 2922d1cc1696200a3e1fd6d82a7798fcd2cadf12 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Jul 2019 22:46:51 +0200
Subject: [PATCH] spi: gpio: Add SPI_MASTER_GPIO_SS flag

The GPIO SPI master has some code in its local CS
callback to set the initial sck GPIO value. This was
lost in the commit converting it to use SPI core
GPIO handling as this callback isn't called if the
internal GPIO handling is active.

Add the special SPI_MASTER_GPIO_SS to ascertain it
gets called anyway so we get the initial SCK setting
right. There is some platform provided GPIO handling
there as well but this will be skipped as the cs_gpios
will be NULL.

My test targets seem not to care about the initial
SCK value so I am uncertain if this is a regression,
but to preserve the previous semantic we better do
this.

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Fixes: 249e2632dcd0 ("spi: gpio: Don't request CS GPIO in DT use-case")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20190716204651.7743-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index eca9d52ecf65..9eb82150666e 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -410,6 +410,12 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	bb = &spi_gpio->bitbang;
 	bb->master = master;
+	/*
+	 * There is some additional business, apart from driving the CS GPIO
+	 * line, that we need to do on selection. This makes the local
+	 * callback for chipselect always get called.
+	 */
+	master->flags |= SPI_MASTER_GPIO_SS;
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-- 
2.20.1

