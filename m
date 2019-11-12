Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940DCF9909
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 19:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLSrX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 13:47:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLSrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 13:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fh7ErhK5kWtXa9xlJgNgIE+9NFeL2CofE3HNjsCnVy8=; b=WDofDLQ1RLSY
        rYz6vxvpU+kmZCTkUokfnWmCx/CZPsVCTWem9oYwPRe+No8eblqXvpx+EkSZvHIKerX4q4idzt3Q6
        MbGAc7bpkiMObDd8NLxEoEHS+dzuO6YiStoHSE8AG38P5utvyGUEz9NYik9WHgCod3l+9T2n7v9AZ
        utOtc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUbCB-00005V-1Q; Tue, 12 Nov 2019 18:47:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7CE43274299F; Tue, 12 Nov 2019 18:47:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Luhua Xu <luhua.xu@mediatek.com>,
        Mark Brown <broonie@kernel.org>, wsd_upstream@mediatek.com
Subject: Applied "spi: Fix regression to return zero on success instead of positive value" to the spi tree
In-Reply-To: <20191111195334.44833-1-tony@atomide.com>
X-Patchwork-Hint: ignore
Message-Id: <20191112184718.7CE43274299F@ypsilon.sirena.org.uk>
Date:   Tue, 12 Nov 2019 18:47:18 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Fix regression to return zero on success instead of positive value

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

From 57a9460705f105e1d79d1410c5cfe285beda8986 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 11 Nov 2019 11:53:34 -0800
Subject: [PATCH] spi: Fix regression to return zero on success instead of
 positive value

Commit d948e6ca1899 ("spi: add power control when set_cs") added generic
runtime PM handling, but also changed the return value to be 1 instead
of 0 that we had earlier as pm_runtime_get functions return a positve
value on success.

This causes SPI devices to return errors for cases where they do:

ret = spi_setup(spi);
if (ret)
	return ret;

As in many cases the SPI devices do not check for if (ret < 0).

Let's fix this by setting the status to 0 on succeess after the
runtime PM calls. Let's not return 0 at the end of the function
as this might break again later on if the function changes and
starts returning status again.

Fixes: d948e6ca1899 ("spi: add power control when set_cs")
Cc: Luhua Xu <luhua.xu@mediatek.com>
Cc: wsd_upstream@mediatek.com
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20191111195334.44833-1-tony@atomide.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 294d0038eea6..0d40953b463c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3269,6 +3269,15 @@ int spi_setup(struct spi_device *spi)
 				status);
 			return status;
 		}
+
+		/*
+		 * We do not want to return positive value from pm_runtime_get,
+		 * there are many instances of devices calling spi_setup() and
+		 * checking for a non-zero return value instead of a negative
+		 * return value.
+		 */
+		status = 0;
+
 		spi_set_cs(spi, false);
 		pm_runtime_mark_last_busy(spi->controller->dev.parent);
 		pm_runtime_put_autosuspend(spi->controller->dev.parent);
-- 
2.20.1

