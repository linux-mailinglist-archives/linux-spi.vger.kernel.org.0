Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F5F0A75
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2019 00:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfKEXvg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Nov 2019 18:51:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54228 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfKEXvf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Nov 2019 18:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tVlrHW3fxmZOFe1bZ8yArR5FsQjL7KAM/zR3KFsCR/8=; b=G7FLr5ZElFSp
        gASTriQkirpXQY6ir9pDF/DT3hQ96HSwYAhwUXnibQ3eufee/lL+PAXA2eElW8HBO/3lACSIub007
        GBSWKBe10RPygw0UKuaBkYAnabI5kQ6hJzkE4udtgQxjgNGCjmgNUkSZodki/lD9GOPnov7znnw6q
        3fFN4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iS8bi-000839-3A; Tue, 05 Nov 2019 23:51:30 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9DAE12741915; Tue,  5 Nov 2019 23:51:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        trivial@kernel.org
Subject: Applied "spi: bcm2835: fix typo in comment" to the spi tree
In-Reply-To: <20191105214134.25142-1-chris.packham@alliedtelesis.co.nz>
X-Patchwork-Hint: ignore
Message-Id: <20191105235129.9DAE12741915@ypsilon.sirena.org.uk>
Date:   Tue,  5 Nov 2019 23:51:29 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: fix typo in comment

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

From c2f102f1e884fe1a6a54c36f232e560675657f12 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Wed, 6 Nov 2019 10:41:34 +1300
Subject: [PATCH] spi: bcm2835: fix typo in comment

GPIOS_OUT_LOW should be GPIOD_OUT_LOW.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20191105214134.25142-1-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b4070c0de3df..fb61a620effc 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1248,7 +1248,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	/*
 	 * Retrieve the corresponding GPIO line used for CS.
 	 * The inversion semantics will be handled by the GPIO core
-	 * code, so we pass GPIOS_OUT_LOW for "unasserted" and
+	 * code, so we pass GPIOD_OUT_LOW for "unasserted" and
 	 * the correct flag for inversion semantics. The SPI_CS_HIGH
 	 * on spi->mode cannot be checked for polarity in this case
 	 * as the flag use_gpio_descriptors enforces SPI_CS_HIGH.
-- 
2.20.1

