Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDDDCD5F
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505779AbfJRSHc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 14:07:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505772AbfJRSH2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 14:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IHyWJGNBUTMdcL9Rp2c8fG/a+rMZTdcE8MzTuFppp+I=; b=QT0lH+GMu2NO
        ybLk1tB16S+0aAVQLMVfGa24ACWypAUcuvzk7FJt+dahTwZvrtqsGZHg6WKmn3u4GaifOadGq8PHL
        6R3bhrI+zo2SUGjYcsoxJuh0plzabbKo446lDehsL4kHsiibrYIgcZDzsdWvSFfypwvwpRZ4lPAql
        PLRh0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWec-0004Hv-Mw; Fri, 18 Oct 2019 18:07:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1F19A2741DEA; Fri, 18 Oct 2019 19:07:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "spi: pxa2xx: No need to keep pointer to platform device" to the spi tree
In-Reply-To: <20191018105429.82782-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180710.1F19A2741DEA@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:10 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: No need to keep pointer to platform device

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

From 4f3d957718e7f0ac2b033dbf48c7cddecd0a8dd3 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 18 Oct 2019 13:54:25 +0300
Subject: [PATCH] spi: pxa2xx: No need to keep pointer to platform device

There is no need to keep a pointer to the platform device. Currently there are
no users of it directly, and if there will be in the future we may restore it
from pointer to the struct device.

Convert all users at the same time.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191018105429.82782-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/plat-pxa/ssp.c    |  4 ++--
 drivers/spi/spi-pxa2xx.c   |  2 +-
 include/linux/pxa2xx_ssp.h |  2 +-
 sound/soc/pxa/mmp-sspa.c   |  2 +-
 sound/soc/pxa/pxa-ssp.c    | 10 +++++-----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 9a6e4923bd69..563440315acd 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -89,7 +89,7 @@ void pxa_ssp_free(struct ssp_device *ssp)
 		ssp->use_count--;
 		ssp->label = NULL;
 	} else
-		dev_err(&ssp->pdev->dev, "device already free\n");
+		dev_err(ssp->dev, "device already free\n");
 	mutex_unlock(&ssp_lock);
 }
 EXPORT_SYMBOL(pxa_ssp_free);
@@ -118,7 +118,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	if (ssp == NULL)
 		return -ENOMEM;
 
-	ssp->pdev = pdev;
+	ssp->dev = dev;
 
 	ssp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ssp->clk))
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index bb6a14d1ab0f..59d1406a9c96 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1567,7 +1567,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
-	ssp->pdev = pdev;
+	ssp->dev = &pdev->dev;
 	ssp->port_id = pxa2xx_spi_get_port_id(adev);
 
 	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index a5d1837e4f35..6facf27865f9 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -206,7 +206,7 @@ enum pxa_ssp_type {
 };
 
 struct ssp_device {
-	struct platform_device *pdev;
+	struct device	*dev;
 	struct list_head	node;
 
 	struct clk	*clk;
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index e3e5425b5c62..e701637a9ae9 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -177,7 +177,7 @@ static int mmp_sspa_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* we can only change the settings if the port is not in use */
 	if ((mmp_sspa_read_reg(sspa, SSPA_TXSP) & SSPA_SP_S_EN) ||
 	    (mmp_sspa_read_reg(sspa, SSPA_RXSP) & SSPA_SP_S_EN)) {
-		dev_err(&sspa->pdev->dev,
+		dev_err(sspa->dev,
 			"can't change hardware dai format: stream is in use\n");
 		return -EINVAL;
 	}
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 5fdd1a24c232..6c5201431f6e 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -52,11 +52,11 @@ struct ssp_priv {
 
 static void dump_registers(struct ssp_device *ssp)
 {
-	dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
+	dev_dbg(ssp->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
 		 pxa_ssp_read_reg(ssp, SSCR0), pxa_ssp_read_reg(ssp, SSCR1),
 		 pxa_ssp_read_reg(ssp, SSTO));
 
-	dev_dbg(&ssp->pdev->dev, "SSPSP 0x%08x SSSR 0x%08x SSACD 0x%08x\n",
+	dev_dbg(ssp->dev, "SSPSP 0x%08x SSSR 0x%08x SSACD 0x%08x\n",
 		 pxa_ssp_read_reg(ssp, SSPSP), pxa_ssp_read_reg(ssp, SSSR),
 		 pxa_ssp_read_reg(ssp, SSACD));
 }
@@ -223,7 +223,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		clk_id = PXA_SSP_CLK_EXT;
 	}
 
-	dev_dbg(&ssp->pdev->dev,
+	dev_dbg(ssp->dev,
 		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
 		cpu_dai->id, clk_id, freq);
 
@@ -316,7 +316,7 @@ static int pxa_ssp_set_pll(struct ssp_priv *priv, unsigned int freq)
 
 			ssacd |= (0x6 << 4);
 
-			dev_dbg(&ssp->pdev->dev,
+			dev_dbg(ssp->dev,
 				"Using SSACDD %x to supply %uHz\n",
 				val, freq);
 			break;
@@ -687,7 +687,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	 * - complain loudly and fail if they've not been set up yet.
 	 */
 	if ((sscr0 & SSCR0_MOD) && !ttsa) {
-		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
+		dev_err(ssp->dev, "No TDM timeslot configured\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1

