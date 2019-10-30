Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E2E9D44
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 15:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJ3OQk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 10:16:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJ3OQk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=arqxMi88MBiSEInSEZEypfHhNxzzThSdI00pF4lUVT0=; b=EavzXq5gngeu
        zTsIBhIXrSwyqEUuwZlO8REZkRW+pdRZp0jwSRa60GcMsEa7DFYyYdVYmvv/n3D9M5zVdiuf/ZswI
        tFtACuUAE0U3MZa0eKXFXpUdm/3tCviTjlsef1tDe4eSj2ISkouLpHKlbEAQb6v6NYfomtDmFJ0SJ
        rc+kM=;
Received: from [195.11.164.221] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iPom4-0005Cz-HP; Wed, 30 Oct 2019 14:16:36 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3015CD020A7; Wed, 30 Oct 2019 14:16:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: Drop GPIO header" to the spi tree
In-Reply-To: <20191030073418.23717-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20191030141636.3015CD020A7@fitzroy.sirena.org.uk>
Date:   Wed, 30 Oct 2019 14:16:36 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw: Drop GPIO header

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

From 26fa680ba9a13d6b05df201b3dfd946a7d915644 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 Oct 2019 08:34:18 +0100
Subject: [PATCH] spi: dw: Drop GPIO header

The DW driver does not use the legacy GPIO header so drop
it from the spi-dw.h include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191030073418.23717-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index c9c15881e982..38c7de1f0aa9 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -4,7 +4,6 @@
 
 #include <linux/io.h>
 #include <linux/scatterlist.h>
-#include <linux/gpio.h>
 
 /* Register offsets */
 #define DW_SPI_CTRL0			0x00
-- 
2.20.1

