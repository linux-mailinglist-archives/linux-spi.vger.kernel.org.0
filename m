Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488791113F
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEBCTb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:19:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57330 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfEBCT2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=feyKP1du32lu5/MyQZS18HeItBqnrlQxBxyoBKEM4vw=; b=o7XMYTMHWz1G
        l6VKr+6EowJPK/aYtjvkDbM65ihBQyrnNUmzovRNCY2KGX7GWYpHTIrmzK+Nlcl/OYBbDjqw2S4AH
        l8g1p48G9daOvC/GS9efKGtTMFaRn/JKFhdMs9Ps1ba8Js/lLrXtr6fOxXCAQX1ZpxO1946QzYuOv
        TqNGQ=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JN-0005vL-Rg; Thu, 02 May 2019 02:19:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B4B5E441D3C; Thu,  2 May 2019 03:18:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: fix SCR (divisor) calculation" to the spi tree
In-Reply-To:  <1555054339-17096-1-git-send-email-f.suligoi@asem.it>
X-Patchwork-Hint: ignore
Message-Id: <20190502021858.B4B5E441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:58 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: fix SCR (divisor) calculation

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 29f2133717c527f492933b0622a4aafe0b3cbe9e Mon Sep 17 00:00:00 2001
From: Flavio Suligoi <f.suligoi@asem.it>
Date: Fri, 12 Apr 2019 09:32:19 +0200
Subject: [PATCH] spi: pxa2xx: fix SCR (divisor) calculation

Calculate the divisor for the SCR (Serial Clock Rate), avoiding
that the SSP transmission rate can be greater than the device rate.

When the division between the SSP clock and the device rate generates
a reminder, we have to increment by one the divisor.
In this way the resulting SSP clock will never be greater than the
device SPI max frequency.

For example, with:

 - ssp_clk  = 50 MHz
 - dev freq = 15 MHz

without this patch the SSP clock will be greater than 15 MHz:

 - 25 MHz for PXA25x_SSP and CE4100_SSP
 - 16,56 MHz for the others

Instead, with this patch, we have in both case an SSP clock of 12.5MHz,
so the max rate of the SPI device clock is respected.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b6ddba833d02..d2076f2f468f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -884,10 +884,14 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 
 	rate = min_t(int, ssp_clk, rate);
 
+	/*
+	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
+	 * that the SSP transmission rate can be greater than the device rate
+	 */
 	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
-		return (ssp_clk / (2 * rate) - 1) & 0xff;
+		return (DIV_ROUND_UP(ssp_clk, 2 * rate) - 1) & 0xff;
 	else
-		return (ssp_clk / rate - 1) & 0xfff;
+		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
 }
 
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
-- 
2.20.1

