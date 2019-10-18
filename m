Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24350DC31A
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 12:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392070AbfJRKyf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 06:54:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:38803 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407703AbfJRKyf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Oct 2019 06:54:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 03:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="348045946"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Oct 2019 03:54:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CA5141F5; Fri, 18 Oct 2019 13:54:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/5] spi: pxa2xx: No need to keep pointer to platform device
Date:   Fri, 18 Oct 2019 13:54:25 +0300
Message-Id: <20191018105429.82782-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no need to keep a pointer to the platform device. Currently there are
no users of it directly, and if there will be in the future we may restore it
from pointer to the struct device.

Convert all users at the same time.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
index 49cb3ba1519f..76fdce54f007 100644
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
2.23.0

