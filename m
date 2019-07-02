Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5FC5D006
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGBNFA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 09:05:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfGBNFA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 09:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BPr3nHgDkJabZQpNeFPyVaYtXwYdLgSYfw/6Y47f8UA=; b=HrpSg/hCtUbF
        p5Z82UJulJodOaZaJMGYG0HgpBqDpvEGPl+tijC9o/z2PMDJdO6o3jIry10n+Qb8Je8IPHGTnEmU2
        GNH7I6gYzXc4kK6P8zqdsuIqh2g/IzMapRSPrhCR6RNvzwV6pXcAGW0LhAJICT4rwGB5znC05vEAa
        LG6C4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISt-0002Oh-I3; Tue, 02 Jul 2019 13:04:55 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D8CBD44004C; Tue,  2 Jul 2019 14:04:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Set minimum transfer speed" to the spi tree
In-Reply-To: <20190628140717.7552-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190702130454.D8CBD44004C@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Set minimum transfer speed

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

From 23cdddb21f41e6092643fb8403f992f99ade33be Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Fri, 28 Jun 2019 17:07:17 +0300
Subject: [PATCH] spi: pxa2xx: Set minimum transfer speed

It is possible to request a transfer with a speed lower than supported
by the HW. This causes silent divider calculation underflow in
ssp_get_clk_div() which leads to a frequency higher than requested. Up to
maximum speed of the controller.

Set the minimum supported transfer speed and let the SPI core to
validate no transfers have speed lower than supported.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index af3f37ba82c8..259c20f7a542 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1704,6 +1704,16 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		goto out_error_dma_irq_alloc;
 
 	controller->max_speed_hz = clk_get_rate(ssp->clk);
+	/*
+	 * Set minimum speed for all other platforms than Intel Quark which is
+	 * able do under 1 Hz transfers.
+	 */
+	if (!pxa25x_ssp_comp(drv_data))
+		controller->min_speed_hz =
+			DIV_ROUND_UP(controller->max_speed_hz, 4096);
+	else if (!is_quark_x1000_ssp(drv_data))
+		controller->min_speed_hz =
+			DIV_ROUND_UP(controller->max_speed_hz, 512);
 
 	/* Load default SSP configuration */
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
-- 
2.20.1

