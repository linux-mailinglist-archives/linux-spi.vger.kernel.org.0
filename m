Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78C3F8071
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2019 20:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfKKTtN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Nov 2019 14:49:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfKKTtM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Nov 2019 14:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lAT65ifMWfky+c92ejg83wuMl1JVQi2OgDRynoizhsg=; b=O5VhAetM/UtC
        IvsTpQYg0QhkzwLoA3a/mhCR1M9YtzImtpUdwI3ZkELZH/FLwo/y5jUESbwMJf7N8Sd2TPTAihs26
        H854gi13jIpcshX/MWt+LEa5Dxw292VYwCNrGAIR6RqDd0skPAm/nwd36MZBJ5r2Ggh9d6GRxSyhA
        O4ZqI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUFgT-0005Nf-E1; Mon, 11 Nov 2019 19:49:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D98532742C8A; Mon, 11 Nov 2019 19:49:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>, "Cc:"@sirena.co.uk,
        "Cc:"@sirena.co.uk, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>
Subject: Applied "spi: nxp-fspi: Use devm API to fix missed unregistration of controller" to the spi tree
In-Reply-To: <20191109075517.29988-1-hslester96@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191111194908.D98532742C8A@ypsilon.sirena.org.uk>
Date:   Mon, 11 Nov 2019 19:49:08 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: nxp-fspi: Use devm API to fix missed unregistration of controller

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

From 69c23dbf5f695c219008257b3bd86cff63edbe0b Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, 9 Nov 2019 15:55:17 +0800
Subject: [PATCH] spi: nxp-fspi: Use devm API to fix missed unregistration of
 controller

This driver forgets to unregister controller when remove.
Use devm API to unregister it automatically to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191109075517.29988-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 501b923f2c27..c36bb1bb464e 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1027,7 +1027,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.20.1

