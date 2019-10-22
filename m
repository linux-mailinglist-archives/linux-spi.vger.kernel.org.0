Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B98AE0B43
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 20:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfJVSQB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 14:16:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56876 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbfJVSQA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 14:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WpDk5Ulj+JwiMZYHjvM/hrCJ4esW8lkbG5QgDJwyqyk=; b=YeovjC/4jJN9
        +gp0PMfQEK5ecGKoEDrK109Waz/KgyOQ1f0fM472lFEvQ3gcCyOg5QiP6QfwW7TaqlGmKxEgQyWB5
        jeZf2jUa/4/EwTRsJfXRZOZKyjluwCxWBiYq+G/XdErtPeA2xHycK/6+T1O2EisnPpXLFVtPMA3QE
        IH0xQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMyhG-0007Cn-F6; Tue, 22 Oct 2019 18:15:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DD46D274326D; Tue, 22 Oct 2019 19:15:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Applied "spi: dw: Move runtime PM enable/disable from common to platform driver part" to the spi tree
In-Reply-To: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191022181553.DD46D274326D@ypsilon.sirena.org.uk>
Date:   Tue, 22 Oct 2019 19:15:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw: Move runtime PM enable/disable from common to platform driver part

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

From b9fc2d207e547664271030c1f99fc08c92fcf3f8 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Fri, 18 Oct 2019 16:21:29 +0300
Subject: [PATCH] spi: dw: Move runtime PM enable/disable from common to
 platform driver part

After commit 1e6959832510 ("spi: dw: Add basic runtime PM support")
there is following warning from PCI enumerated DesignWare SPI controller
during probe:

	dw_spi_pci 0000:00:13.0: Unbalanced pm_runtime_enable!

Runtime PM is already enabled for PCI devices by the PCI core and doing
it again in common DW SPI code leads to unbalanced enable calls.

Fix this by moving the runtime PM enable/disable calls to the platform
driver part of the driver.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20191018132131.31608-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index bd46fca3f094..db896475b8d1 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/scatterlist.h>
@@ -193,6 +194,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 			goto out;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
 		goto out;
@@ -201,6 +204,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dwsmmio->pclk);
 out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
@@ -212,6 +216,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
 	dw_spi_remove_host(&dwsmmio->dws);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 
-- 
2.20.1

