Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9BC3309
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfJALlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41278 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbfJALlO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=s76vvuJytASWP0aoMu6n1w53rQCXKWbC2l3bEXVXrQ0=; b=FHJI43356iX2
        9a0FSPeuCCrjKpXgjSqLjYd6sCKOdZV9CKmILUhXGGb1MzoSbMEQJqK8HgjCRNG6mYgeyg33qmVYN
        oJpcUAyFMRL62OZXKL+xJXO7egAzpNMZVOHYTNTzzCD4Rh697u2sGg8kGrD/24cjDqgzDpYcd/ZJm
        kj68k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWh-0004Z0-He; Tue, 01 Oct 2019 11:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0FAEC2742A10; Tue,  1 Oct 2019 12:41:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Applied "spi: atmel: Remove AVR32 leftover" to the spi tree
In-Reply-To: <20190919154034.7489-1-gregory.clement@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114107.0FAEC2742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: atmel: Remove AVR32 leftover

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

From e61bb114d41ddf6ae5bf05a0109fc13116550c7d Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 19 Sep 2019 17:40:34 +0200
Subject: [PATCH] spi: atmel: Remove AVR32 leftover

AV32 support has been from the kernel a few release ago, but there was
still some specific macro for this architecture in this driver. Lets
remove it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20190919154034.7489-1-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index acf318e7330c..3ed5e663da6f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -222,37 +222,13 @@
 	  | SPI_BF(name, value))
 
 /* Register access macros */
-#ifdef CONFIG_AVR32
-#define spi_readl(port, reg) \
-	__raw_readl((port)->regs + SPI_##reg)
-#define spi_writel(port, reg, value) \
-	__raw_writel((value), (port)->regs + SPI_##reg)
-
-#define spi_readw(port, reg) \
-	__raw_readw((port)->regs + SPI_##reg)
-#define spi_writew(port, reg, value) \
-	__raw_writew((value), (port)->regs + SPI_##reg)
-
-#define spi_readb(port, reg) \
-	__raw_readb((port)->regs + SPI_##reg)
-#define spi_writeb(port, reg, value) \
-	__raw_writeb((value), (port)->regs + SPI_##reg)
-#else
 #define spi_readl(port, reg) \
 	readl_relaxed((port)->regs + SPI_##reg)
 #define spi_writel(port, reg, value) \
 	writel_relaxed((value), (port)->regs + SPI_##reg)
-
-#define spi_readw(port, reg) \
-	readw_relaxed((port)->regs + SPI_##reg)
 #define spi_writew(port, reg, value) \
 	writew_relaxed((value), (port)->regs + SPI_##reg)
 
-#define spi_readb(port, reg) \
-	readb_relaxed((port)->regs + SPI_##reg)
-#define spi_writeb(port, reg, value) \
-	writeb_relaxed((value), (port)->regs + SPI_##reg)
-#endif
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-- 
2.20.1

