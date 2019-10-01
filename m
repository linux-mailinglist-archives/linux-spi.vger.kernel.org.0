Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED63C3F21
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfJAR5H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 13:57:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52242 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbfJAR5G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 13:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ydTzYwPN1LXMjjPJ7b39sDMpZbOH1uZOzxTXj8qrwN4=; b=rpUYwfekKtMq
        bb1sHDj1njHv275FzUzVsi/5msGsb2fzgXdJDFXrq420TmxZ1awmPLyk73lc0lYM3fp6mOzWVWQYd
        ZBElS4IuwYgDr0OcaCu2Uq9fVM9cELMi59MfiPEXstAav398uTU06kw361Wrx720x2sJEnQsVnV5Z
        VYxtI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFMOT-0005v7-T2; Tue, 01 Oct 2019 17:57:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 638832742A30; Tue,  1 Oct 2019 18:57:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     "Cc:"@sirena.co.uk, "Cc:"@sirena.co.uk, emamd001@umn.edu,
        kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        smccaman@umn.edu
Subject: Applied "spi: lpspi: fix memory leak in fsl_lpspi_probe" to the spi tree
In-Reply-To: <20190930034602.1467-1-navid.emamdoost@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001175701.638832742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 18:57:01 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: lpspi: fix memory leak in fsl_lpspi_probe

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

From 057b8945f78f76d0b04eeb5c27cd9225e5e7ad86 Mon Sep 17 00:00:00 2001
From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Sun, 29 Sep 2019 22:46:01 -0500
Subject: [PATCH] spi: lpspi: fix memory leak in fsl_lpspi_probe

In fsl_lpspi_probe an SPI controller is allocated either via
spi_alloc_slave or spi_alloc_master. In all but one error cases this
controller is put by going to error handling code. This commit fixes the
case when pm_runtime_get_sync fails and it should go to the error
handling path.

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Link: https://lore.kernel.org/r/20190930034602.1467-1-navid.emamdoost@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d08e9324140e..3528ed5eea9b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -938,7 +938,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(fsl_lpspi->dev);
 	if (ret < 0) {
 		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
-		return ret;
+		goto out_controller_put;
 	}
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
-- 
2.20.1

