Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D4EE113
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2019 14:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfKDN1Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Nov 2019 08:27:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58064 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDN1Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Nov 2019 08:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qRAzUev+rMHvML7RdvPeQ9Nk4I6D/EvxELQHAmiFmI0=; b=t6QsbpYGmCRe
        LXO45YwBKtOg9YypR8KqnxjFnpRA6VQ1yZZLwujiyc2I9B7rb8qmwqYn1lm/mtqr8fuQSvfOQzTXk
        WnwhKiW2+4lUJXlZcJao0yOsY4hbqPJcphbp3mGjsxnaOIM88DpcTRdhuFkq1W9OqmSFTHCRNqa4j
        zMQ5g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iRcO8-0002g1-94; Mon, 04 Nov 2019 13:27:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C2681274301E; Mon,  4 Nov 2019 13:27:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     "Cc:"@sirena.co.uk, "Cc:"@sirena.co.uk,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Applied "spi: sifive: disable clk when probe fails and remove" to the spi tree
In-Reply-To: <20191101121745.13413-1-hslester96@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191104132719.C2681274301E@ypsilon.sirena.org.uk>
Date:   Mon,  4 Nov 2019 13:27:19 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sifive: disable clk when probe fails and remove

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

From a725272bda77e61c1b4de85c7b0c875b2ea639b6 Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Fri, 1 Nov 2019 20:17:45 +0800
Subject: [PATCH] spi: sifive: disable clk when probe fails and remove

The driver forgets to disable and unprepare clk when probe fails and
remove.
Add the calls to fix the problem.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Link: https://lore.kernel.org/r/20191101121745.13413-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sifive.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 35254bdc42c4..f7c1e20432e0 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -357,14 +357,14 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	if (!cs_bits) {
 		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
 		ret = -EINVAL;
-		goto put_master;
+		goto disable_clk;
 	}
 
 	num_cs = ilog2(cs_bits) + 1;
 	if (num_cs > SIFIVE_SPI_MAX_CS) {
 		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
 		ret = -EINVAL;
-		goto put_master;
+		goto disable_clk;
 	}
 
 	/* Define our master */
@@ -393,7 +393,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), spi);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
-		goto put_master;
+		goto disable_clk;
 	}
 
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
@@ -402,11 +402,13 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
-		goto put_master;
+		goto disable_clk;
 	}
 
 	return 0;
 
+disable_clk:
+	clk_disable_unprepare(spi->clk);
 put_master:
 	spi_master_put(master);
 
@@ -420,6 +422,7 @@ static int sifive_spi_remove(struct platform_device *pdev)
 
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+	clk_disable_unprepare(spi->clk);
 
 	return 0;
 }
-- 
2.20.1

