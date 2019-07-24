Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842C3737B2
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2019 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGXTSl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jul 2019 15:18:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGXTSH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Jul 2019 15:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zLOyjuMGLnZd3b5xW00mz+HMld+XrRBlTLTieGu4vyw=; b=tsNLOsuRwjgi
        qNH52NAUZSpkDKc1q6m53Zz+mLddr7qhVvPMIQ/InszAffGBTrDIQQpnutj82V399SnYfj1S3xWRl
        ICzdufECff83TpPEyc172roOAPgGj14PjXDNDtOm/zQMf/+4StjwhAvgNs5spWUGuWDOdHICCRT+q
        oK4+Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqMm5-00005G-78; Wed, 24 Jul 2019 19:18:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id ADA792742BAC; Wed, 24 Jul 2019 20:18:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     "Cc:"@sirena.org.uk, "Cc:"@sirena.org.uk,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw-pci: Use dev_get_drvdata" to the spi tree
In-Reply-To: <20190724122331.21856-1-hslester96@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190724191804.ADA792742BAC@ypsilon.sirena.org.uk>
Date:   Wed, 24 Jul 2019 20:18:04 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw-pci: Use dev_get_drvdata

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

From 2a3b6f7b02cd141c990c6f5aed41070b5b7f4a7d Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 20:23:31 +0800
Subject: [PATCH] spi: dw-pci: Use dev_get_drvdata

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20190724122331.21856-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 9651679ee7f7..c1e2401cace0 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -98,16 +98,14 @@ static void spi_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int spi_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_suspend_host(dws);
 }
 
 static int spi_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_resume_host(dws);
 }
-- 
2.20.1

