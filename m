Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB48F1F1CA
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfEOLy6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 07:54:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54668 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfEOLSh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 07:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=M8HnZIujkbhUq3io3X6iAXWmi94TySFud4EIiWGqJiA=; b=H2GuoGcO74Lu
        HbUeqjeDHGSLXe0oswGV7vYGjaQImL8JXS0lItfw+VBcQ8cw/HrhncPolUDyP7mVeE8DCcWBXuDR6
        VzbzebuO7FA7g0AreMbueuGN3x9RFQCYR5tU9LdI/kHwfsTjyQ9atW0yeZ8W6tyMrBMqIOQCLJMHt
        eryCg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQrvX-0003c8-H8; Wed, 15 May 2019 11:18:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4C5A51126D70; Wed, 15 May 2019 12:18:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     broonie@kernel.org, jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        thierry.reding@gmail.com
Subject: Applied "spi: tegra114: add support for gpio based CS" to the spi tree
In-Reply-To: <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190515111824.4C5A51126D70@debutante.sirena.org.uk>
Date:   Wed, 15 May 2019 12:18:24 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: tegra114: add support for gpio based CS

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

From 63c1440596ff0a34efec491f41832c2c9ea01857 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 13 May 2019 22:03:52 -0700
Subject: [PATCH] spi: tegra114: add support for gpio based CS

This patch adds support for GPIO based CS control through SPI core
function spi_set_cs.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b1f31bb16659..f47417dd9edb 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -776,6 +776,10 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		} else
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
+		/* GPIO based chip select control */
+		if (spi->cs_gpiod)
+			gpiod_set_value(spi->cs_gpiod, 1);
+
 		command1 |= SPI_CS_SW_HW;
 		if (spi->mode & SPI_CS_HIGH)
 			command1 |= SPI_CS_SW_VAL;
@@ -864,6 +868,10 @@ static int tegra_spi_setup(struct spi_device *spi)
 	}
 
 	spin_lock_irqsave(&tspi->lock, flags);
+	/* GPIO based chip select control */
+	if (spi->cs_gpiod)
+		gpiod_set_value(spi->cs_gpiod, 0);
+
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
 		val &= ~SPI_CS_POL_INACTIVE(spi->chip_select);
@@ -893,6 +901,10 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
+	/* GPIO based chip select control */
+	if (spi->cs_gpiod)
+		gpiod_set_value(spi->cs_gpiod, 0);
+
 	if (cs_val)
 		tspi->command1_reg |= SPI_CS_SW_VAL;
 	else
@@ -1199,6 +1211,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
+	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-- 
2.20.1

