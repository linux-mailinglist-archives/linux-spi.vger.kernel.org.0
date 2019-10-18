Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 821ECDCD77
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505745AbfJRSHN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 14:07:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45072 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505723AbfJRSHM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 14:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=M0UtU+P76tl6I2am1+6jBwzAm5xDDtoU2k1GZJCX7To=; b=azqjrrAseLwD
        FH25w6rk3SvM79q5WQcFnMd54zSIBaoSVYVMaeUyfY4UcvJlOUDfeU0kaPN/BAnpBoG24n1p6/5qy
        iASsW4d3nzMCdtSGFgeIa3oZbWlIqKj6B70XJp6eqs5vUZjC325KhOkxT//hJfmlmalTSjEHtm83n
        ZXzl4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeb-0004H6-1h; Fri, 18 Oct 2019 18:07:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7D0022743276; Fri, 18 Oct 2019 19:07:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Applied "spi: rspi: Use platform_get_irq_byname_optional() for optional irqs" to the spi tree
In-Reply-To: <20191016143101.28738-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20191018180708.7D0022743276@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:08 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: rspi: Use platform_get_irq_byname_optional() for optional irqs

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

From 2de860b4a7a0bd5a4b5bd3bff0e6a615495df4ba Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 16 Oct 2019 16:31:01 +0200
Subject: [PATCH] spi: rspi: Use platform_get_irq_byname_optional() for
 optional irqs

As platform_get_irq_byname() now prints an error when the interrupt
does not exist, scary warnings may be printed for optional interrupts:

    renesas_spi e6b10000.spi: IRQ rx not found
    renesas_spi e6b10000.spi: IRQ mux not found

Fix this by calling platform_get_irq_byname_optional() instead.
Remove the no longer needed printing of platform_get_irq errors, as the
remaining calls to platform_get_irq() and platform_get_irq_byname() take
care of that.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20191016143101.28738-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 15f5723d9f95..7222c7689c3c 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1257,9 +1257,9 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
-	ret = platform_get_irq_byname(pdev, "rx");
+	ret = platform_get_irq_byname_optional(pdev, "rx");
 	if (ret < 0) {
-		ret = platform_get_irq_byname(pdev, "mux");
+		ret = platform_get_irq_byname_optional(pdev, "mux");
 		if (ret < 0)
 			ret = platform_get_irq(pdev, 0);
 		if (ret >= 0)
@@ -1270,10 +1270,6 @@ static int rspi_probe(struct platform_device *pdev)
 		if (ret >= 0)
 			rspi->tx_irq = ret;
 	}
-	if (ret < 0) {
-		dev_err(&pdev->dev, "platform_get_irq error\n");
-		goto error2;
-	}
 
 	if (rspi->rx_irq == rspi->tx_irq) {
 		/* Single multiplexed interrupt */
-- 
2.20.1

