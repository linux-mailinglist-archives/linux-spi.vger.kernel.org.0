Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409C7E9BEA
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfJ3M5s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 08:57:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49266 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJ3M5s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 08:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9UhwojAw/+wqFTpbXbU0DJEqsnjAQ7ZG3Uvf0BVZt3E=; b=QsmYvRKcPHC7
        4aR7Y9ID+EjBifWQ0r+KtBusKBo4ofi8pLEADdHp9L0dmZ9x8wP7IPCWcdz0OPm80SwRuXSculHJU
        fG+ipYfSpfgX+2xqp2FeoIq5d3efr6tedM6KgzvzDS4Yw23o1uEmi/edw+MgmxSxPXQ7jOAmRU196
        sPFTI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPnXj-00050L-DP; Wed, 30 Oct 2019 12:57:43 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E4DF027420F4; Wed, 30 Oct 2019 12:57:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Applied "spi: dw: Remove runtime PM enable/disable from common part of the driver" to the spi tree
In-Reply-To: <20191030113137.15459-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191030125742.E4DF027420F4@ypsilon.sirena.org.uk>
Date:   Wed, 30 Oct 2019 12:57:42 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw: Remove runtime PM enable/disable from common part of the driver

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

From 76f0030f367c61d4d1f4b1393ff3d9dc43d20c6a Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Wed, 30 Oct 2019 13:31:37 +0200
Subject: [PATCH] spi: dw: Remove runtime PM enable/disable from common part of
 the driver

Committed version of the commit b9fc2d207e54 ("spi: dw: Move runtime PM
enable/disable from common to platform driver part") does not include by
some reason changes to drivers/spi/spi-dw.c that were part of the original
patch sent to the mailing list.

Complete the code move by doing those changes now.

Fixes: b9fc2d207e54 ("spi: dw: Move runtime PM enable/disable from common to platform driver part")
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20191030113137.15459-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 54ed6eb3e252..466f5c67843b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
@@ -499,8 +498,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
-	pm_runtime_enable(dev);
-
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
@@ -529,7 +526,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, master);
 err_free_master:
-	pm_runtime_disable(dev);
 	spi_controller_put(master);
 	return ret;
 }
@@ -544,9 +540,6 @@ void dw_spi_remove_host(struct dw_spi *dws)
 
 	spi_shutdown_chip(dws);
 
-	if (dws->master)
-		pm_runtime_disable(&dws->master->dev);
-
 	free_irq(dws->irq, dws->master);
 }
 EXPORT_SYMBOL_GPL(dw_spi_remove_host);
-- 
2.20.1

