Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFED28BA64
	for <lists+linux-spi@lfdr.de>; Mon, 12 Oct 2020 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbgJLOIl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Oct 2020 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731843AbgJLOIk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Oct 2020 10:08:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7810C0613D9
        for <linux-spi@vger.kernel.org>; Mon, 12 Oct 2020 07:08:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kRyUU-0006e3-Aj; Mon, 12 Oct 2020 16:07:54 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kRyUT-0003JY-O0; Mon, 12 Oct 2020 16:07:53 +0200
Date:   Mon, 12 Oct 2020 16:07:53 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Message-ID: <20201012140753.GF12463@pengutronix.de>
References: <20201009042738.26602-1-ceggers@arri.de>
 <20201009073944.GA11648@pengutronix.de>
 <6367849.hfWVFoRi9M@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6367849.hfWVFoRi9M@n95hx1g2>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:05:21 up 235 days, 21:35, 155 users,  load average: 0.39, 0.21,
 0.16
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 09, 2020 at 09:48:29AM +0200, Christian Eggers wrote:
> Hi Sascha,
> 
> On Friday, 9 October 2020, 09:39:44 CEST, Sascha Hauer wrote:
> > On Fri, Oct 09, 2020 at 06:27:38AM +0200, Christian Eggers wrote:
> > > This reverts commit 525c9e5a32bd7951eae3f06d9d077fea51718a6c.
> > >
> > > If CONFIG_PM is disabled, the system completely freezes on probe as
> > > nothing enables the clock of the SPI peripheral.
> >
> > Instead of reverting it, why not just fix it?
> I expect that 5.9 will be released soon. I think that in this late stage
> reverting is more safe than fixing...
> 
> > Normally the device should be brought to active state manually in probe
> > before pm_runtime takes over, then CONFIG_PM disabled doesn't hurt.
> > Using pm_runtime to put the device to active state initially has the
> > problem you describe.
> Thanks for the hint. I've no experience in runtime power management. If you
> could provide a patch against the current version, I can make a quick test. I
> can also try to fix it myself, but this will take until next week.

Here we go. The patch basically works, but I am also not very confident
with pm_runtime, so please have a close look ;)

Sascha

-------------------------------8<--------------------------------

From 6c584eb8a2fbff46bf8bbebae6c10609c169309b Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 12 Oct 2020 15:59:50 +0200
Subject: [PATCH] spi: imx: fix runtime pm support for !CONFIG_PM

525c9e5a32bd introduced pm_runtime support for the i.MX SPI driver. With
this pm_runtime is used to bring up the clocks initially. When CONFIG_PM
is disabled the clocks are no longer enabled and the driver doesn't work
anymore. Fix this by enabling the clocks in the probe function and
telling pm_runtime that the device is active using
pm_runtime_set_active().

Fixes: 525c9e5a32bd spi: imx: enable runtime pm support
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 38a5f1304cec..c796e937dc6a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1674,15 +1674,18 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	pm_runtime_enable(spi_imx->dev);
+	ret = clk_prepare_enable(spi_imx->clk_per);
+	if (ret)
+		goto out_master_put;
+
+	ret = clk_prepare_enable(spi_imx->clk_ipg);
+	if (ret)
+		goto out_put_per;
+
 	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(spi_imx->dev);
-
-	ret = pm_runtime_get_sync(spi_imx->dev);
-	if (ret < 0) {
-		dev_err(spi_imx->dev, "failed to enable clock\n");
-		goto out_runtime_pm_put;
-	}
+	pm_runtime_set_active(spi_imx->dev);
+	pm_runtime_enable(spi_imx->dev);
 
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 	/*
@@ -1719,8 +1722,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
-	pm_runtime_put_sync(spi_imx->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(spi_imx->dev);
+
+	clk_disable_unprepare(spi_imx->clk_ipg);
+out_put_per:
+	clk_disable_unprepare(spi_imx->clk_per);
 out_master_put:
 	spi_master_put(master);
 
-- 
2.28.0


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
