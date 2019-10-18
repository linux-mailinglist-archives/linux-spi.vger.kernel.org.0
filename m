Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B40DCD70
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 20:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505792AbfJRSII (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 14:08:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45252 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505748AbfJRSHP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 14:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IjM9rnCciu37JcXYzH1B1qjM5RpdtJn2Wft3KUK1jtg=; b=EFjwdPRvTLSf
        Py+AirepyhxYi4o3ssxIZZCC/VGIIaIAmq1xuoUV2AkxWt9YKgVnUEg15pd8YnvyBZsuzU5edw7Zu
        +KOvhJTIuCKV//WvqDGK26GbAjLEUkDAhLLpr8jgJfMa/h1EgAS8+qG5kOry/BjtEWDvVVP/pgl4A
        fkeIw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWea-0004Gw-7M; Fri, 18 Oct 2019 18:07:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BB5532743259; Fri, 18 Oct 2019 19:07:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Applied "spi: atmel: Improve CS0 case support on AT91RM9200" to the spi tree
In-Reply-To: <20191017141846.7523-8-gregory.clement@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180707.BB5532743259@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: atmel: Improve CS0 case support on AT91RM9200

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 9c86f12a36479dec06df3e4a4f31cecf8eba0222 Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 17 Oct 2019 16:18:46 +0200
Subject: [PATCH] spi: atmel: Improve CS0 case support on AT91RM9200

Thanks to the recent change in this driver, it is now possible to
prevent using the CS0 with GPIO during setup. It then allows to remove
the special handling of this case in the cs_activate() and
cs_deactivate() functions.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191017141846.7523-8-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ac5e2ddf9e1b..d88e2aa64839 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -371,7 +371,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << chip_select), mr);
-		if (spi->cs_gpiod && spi->chip_select != 0)
+		if (spi->cs_gpiod)
 			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
@@ -402,7 +402,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
-	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
+	else
 		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
@@ -1193,7 +1193,16 @@ static void initialize_native_cs_for_gpio(struct atmel_spi *as)
 	if (!master->cs_gpiods)
 		return; /* No CS GPIO */
 
-	for (i = 0; i < 4; i++)
+	/*
+	 * On the first version of the controller (AT91RM9200), CS0
+	 * can't be used associated with GPIO
+	 */
+	if (atmel_spi_is_v2(as))
+		i = 0;
+	else
+		i = 1;
+
+	for (; i < 4; i++)
 		if (master->cs_gpiods[i])
 			as->native_cs_free |= BIT(i);
 
-- 
2.20.1

