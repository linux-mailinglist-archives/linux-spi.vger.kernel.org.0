Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23006A9D80
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjCCRWu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjCCRWq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:22:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290A515E7
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:22:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-0006Ot-7P; Fri, 03 Mar 2023 18:21:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95P-001bia-Q5; Fri, 03 Mar 2023 18:20:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95P-001tht-22; Fri, 03 Mar 2023 18:20:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Anand Gore <anand.gore@broadcom.com>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, Han Xu <han.xu@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jay Fang <f.fangjian@huawei.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-spi@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 00/87] spi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:14 +0100
Message-Id: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11739; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RWqvc8RnhEbQQ2oAk+E+9rPdzPGR+1W5SnXdzobHuT8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAisJkW18zyL+YEzlTtbekP+5UvgovAIj/gcML nwd+Kay6RGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrCQAKCRDB/BR4rcrs CaFBB/92x5SnXIGhT6giruoYpGJoso7Z3MP3OVm/DCgJH6s6vYJGV9pYI2lu5eRUCDJcQoZTtgK ZkjyGMNYXLHw5tUKn88EDwX0RuzGhj1fwNvi8u3zdCpZd0blCS4DV8PGtqPH15IKjCg/NSwpEO0 xOmALBy9uOxij739aBF/xuxhaZWpjiyjPVbwwC1NGIxdOTpGl00eDfc6ZiABfbeTa5LWEblpdn3 rWOBzSBlcyizkhTVwSimgHB/YEYbG/drCH5pRdxMGW+U10fVOuvdYOknPfRpZ5kOcyLnDxD362d aviWRkaIauhw3X9/YDqmV6gHXwcidGlxnJzNMnpfCDTq2Mlj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

this patch series adapts the platform drivers below drivers/spi
to use the .remove_new() callback. Compared to the traditional .remove()
callback .remove_new() returns no value. This is a good thing because
the driver core doesn't (and cannot) cope for errors during remove. The
only effect of a non-zero return value in .remove() is that the driver
core emits a warning. The device is removed anyhow and an early return
from .remove() usually yields a resource leak.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later.

All drivers touched here returned zero unconditionally in their remove
callback, so they could all be converted trivially to .remove_new().

Note that this series depends on commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") that is already in Linus' tree
but not yet included in a tagged version.

Best regards
Uwe

Uwe Kleine-König (87):
  spi: ar934x: Convert to platform remove callback returning void
  spi: armada-3700: Convert to platform remove callback returning void
  spi: aspeed-smc: Convert to platform remove callback returning void
  spi: at91-usart: Convert to platform remove callback returning void
  spi: ath79: Convert to platform remove callback returning void
  spi: atmel: Convert to platform remove callback returning void
  spi: au1550: Convert to platform remove callback returning void
  spi: axi-spi-engine: Convert to platform remove callback returning void
  spi: bcm2835: Convert to platform remove callback returning void
  spi: bcm2835aux: Convert to platform remove callback returning void
  spi: bcm63xx-hsspi: Convert to platform remove callback returning void
  spi: bcm63xx: Convert to platform remove callback returning void
  spi: bcmbca-hsspi: Convert to platform remove callback returning void
  spi: brcmstb-qspi: Convert to platform remove callback returning void
  spi: cadence-quadspi: Convert to platform remove callback returning void
  spi: cadence: Convert to platform remove callback returning void
  spi: cavium-octeon: Convert to platform remove callback returning void
  spi: coldfire-qspi: Convert to platform remove callback returning void
  spi: davinci: Convert to platform remove callback returning void
  spi: dln2: Convert to platform remove callback returning void
  spi: dw-bt1: Convert to platform remove callback returning void
  spi: dw-mmio: Convert to platform remove callback returning void
  spi: ep93xx: Convert to platform remove callback returning void
  spi: fsl-dspi: Convert to platform remove callback returning void
  spi: fsl-espi: Convert to platform remove callback returning void
  spi: fsl-lpspi: Convert to platform remove callback returning void
  spi: fsl-qspi: Convert to platform remove callback returning void
  spi: fsl-spi: Convert to platform remove callback returning void
  spi: geni-qcom: Convert to platform remove callback returning void
  spi: hisi-kunpeng: Convert to platform remove callback returning void
  spi: img-spfi: Convert to platform remove callback returning void
  spi: iproc-qspi: Convert to platform remove callback returning void
  spi: lantiq-ssc: Convert to platform remove callback returning void
  spi: meson-spicc: Convert to platform remove callback returning void
  spi: meson-spifc: Convert to platform remove callback returning void
  spi: microchip-core-qspi: Convert to platform remove callback returning void
  spi: microchip-core: Convert to platform remove callback returning void
  spi: mpc512x-psc: Convert to platform remove callback returning void
  spi: mpc52xx-psc: Convert to platform remove callback returning void
  spi: mpc52xx: Convert to platform remove callback returning void
  spi: mtk-nor: Convert to platform remove callback returning void
  spi: mtk-snfi: Convert to platform remove callback returning void
  spi: mxic: Convert to platform remove callback returning void
  spi: mxs: Convert to platform remove callback returning void
  spi: npcm-fiu: Convert to platform remove callback returning void
  spi: npcm-pspi: Convert to platform remove callback returning void
  spi: nxp-fspi: Convert to platform remove callback returning void
  spi: oc-tiny: Convert to platform remove callback returning void
  spi: omap-uwire: Convert to platform remove callback returning void
  spi: omap2-mcspi: Convert to platform remove callback returning void
  spi: orion: Convert to platform remove callback returning void
  spi: pic32-sqi: Convert to platform remove callback returning void
  spi: pic32: Convert to platform remove callback returning void
  spi: ppc4xx: Convert to platform remove callback returning void
  spi: pxa2xx: Convert to platform remove callback returning void
  spi: qcom-qspi: Convert to platform remove callback returning void
  spi: rb4xx: Convert to platform remove callback returning void
  spi: rockchip-sfc: Convert to platform remove callback returning void
  spi: rockchip: Convert to platform remove callback returning void
  spi: rpc-if: Convert to platform remove callback returning void
  spi: rspi: Convert to platform remove callback returning void
  spi: s3c64xx: Convert to platform remove callback returning void
  spi: sh-hspi: Convert to platform remove callback returning void
  spi: sh-msiof: Convert to platform remove callback returning void
  spi: sh-sci: Convert to platform remove callback returning void
  spi: sh: Convert to platform remove callback returning void
  spi: sifive: Convert to platform remove callback returning void
  spi: slave-mt27xx: Convert to platform remove callback returning void
  spi: sn-f-ospi: Convert to platform remove callback returning void
  spi: sprd-adi: Convert to platform remove callback returning void
  spi: st-ssc4: Convert to platform remove callback returning void
  spi: stm32-qspi: Convert to platform remove callback returning void
  spi: stm32: Convert to platform remove callback returning void
  spi: sun4i: Convert to platform remove callback returning void
  spi: sun6i: Convert to platform remove callback returning void
  spi: sunplus-sp7021: Convert to platform remove callback returning void
  spi: synquacer: Convert to platform remove callback returning void
  spi: tegra114: Convert to platform remove callback returning void
  spi: tegra20-sflash: Convert to platform remove callback returning void
  spi: tegra20-slink: Convert to platform remove callback returning void
  spi: tegra210-quad: Convert to platform remove callback returning void
  spi: topcliff-pch: Convert to platform remove callback returning void
  spi: uniphier: Convert to platform remove callback returning void
  spi: xilinx: Convert to platform remove callback returning void
  spi: xtensa-xtfpga: Convert to platform remove callback returning void
  spi: zynq-qspi: Convert to platform remove callback returning void
  spi: zynqmp-gqspi: Convert to platform remove callback returning void

 drivers/spi/spi-ar934x.c              |  6 ++----
 drivers/spi/spi-armada-3700.c         |  6 ++----
 drivers/spi/spi-aspeed-smc.c          |  5 ++---
 drivers/spi/spi-at91-usart.c          |  6 ++----
 drivers/spi/spi-ath79.c               |  6 ++----
 drivers/spi/spi-atmel.c               |  6 ++----
 drivers/spi/spi-au1550.c              |  5 ++---
 drivers/spi/spi-axi-spi-engine.c      |  6 ++----
 drivers/spi/spi-bcm2835.c             | 12 +++---------
 drivers/spi/spi-bcm2835aux.c          |  6 ++----
 drivers/spi/spi-bcm63xx-hsspi.c       |  6 ++----
 drivers/spi/spi-bcm63xx.c             |  6 ++----
 drivers/spi/spi-bcmbca-hsspi.c        |  6 ++----
 drivers/spi/spi-brcmstb-qspi.c        |  6 ++----
 drivers/spi/spi-cadence-quadspi.c     |  6 ++----
 drivers/spi/spi-cadence.c             |  6 ++----
 drivers/spi/spi-cavium-octeon.c       |  6 ++----
 drivers/spi/spi-coldfire-qspi.c       |  6 ++----
 drivers/spi/spi-davinci.c             |  5 ++---
 drivers/spi/spi-dln2.c                |  6 ++----
 drivers/spi/spi-dw-bt1.c              |  6 ++----
 drivers/spi/spi-dw-mmio.c             |  6 ++----
 drivers/spi/spi-ep93xx.c              |  6 ++----
 drivers/spi/spi-fsl-dspi.c            |  6 ++----
 drivers/spi/spi-fsl-espi.c            |  6 ++----
 drivers/spi/spi-fsl-lpspi.c           |  5 ++---
 drivers/spi/spi-fsl-qspi.c            |  6 ++----
 drivers/spi/spi-fsl-spi.c             | 11 ++++-------
 drivers/spi/spi-geni-qcom.c           |  5 ++---
 drivers/spi/spi-hisi-kunpeng.c        |  6 ++----
 drivers/spi/spi-img-spfi.c            |  6 ++----
 drivers/spi/spi-iproc-qspi.c          |  6 ++----
 drivers/spi/spi-lantiq-ssc.c          |  6 ++----
 drivers/spi/spi-meson-spicc.c         |  6 ++----
 drivers/spi/spi-meson-spifc.c         |  6 ++----
 drivers/spi/spi-microchip-core-qspi.c |  6 ++----
 drivers/spi/spi-microchip-core.c      |  6 ++----
 drivers/spi/spi-mpc512x-psc.c         | 22 ++++++++--------------
 drivers/spi/spi-mpc52xx-psc.c         |  6 ++----
 drivers/spi/spi-mpc52xx.c             |  6 ++----
 drivers/spi/spi-mtk-nor.c             |  6 ++----
 drivers/spi/spi-mtk-snfi.c            |  5 ++---
 drivers/spi/spi-mxic.c                |  6 ++----
 drivers/spi/spi-mxs.c                 |  6 ++----
 drivers/spi/spi-npcm-fiu.c            |  5 ++---
 drivers/spi/spi-npcm-pspi.c           |  6 ++----
 drivers/spi/spi-nxp-fspi.c            |  6 ++----
 drivers/spi/spi-oc-tiny.c             |  5 ++---
 drivers/spi/spi-omap-uwire.c          |  5 ++---
 drivers/spi/spi-omap2-mcspi.c         |  6 ++----
 drivers/spi/spi-orion.c               |  6 ++----
 drivers/spi/spi-pic32-sqi.c           |  6 ++----
 drivers/spi/spi-pic32.c               |  6 ++----
 drivers/spi/spi-ppc4xx.c              |  5 ++---
 drivers/spi/spi-pxa2xx.c              |  6 ++----
 drivers/spi/spi-qcom-qspi.c           |  6 ++----
 drivers/spi/spi-rb4xx.c               |  6 ++----
 drivers/spi/spi-rockchip-sfc.c        |  6 ++----
 drivers/spi/spi-rockchip.c            |  6 ++----
 drivers/spi/spi-rpc-if.c              |  6 ++----
 drivers/spi/spi-rspi.c                |  6 ++----
 drivers/spi/spi-s3c64xx.c             |  6 ++----
 drivers/spi/spi-sh-hspi.c             |  6 ++----
 drivers/spi/spi-sh-msiof.c            |  5 ++---
 drivers/spi/spi-sh-sci.c              |  5 ++---
 drivers/spi/spi-sh.c                  |  6 ++----
 drivers/spi/spi-sifive.c              |  6 ++----
 drivers/spi/spi-slave-mt27xx.c        |  6 ++----
 drivers/spi/spi-sn-f-ospi.c           |  6 ++----
 drivers/spi/spi-sprd-adi.c            |  5 ++---
 drivers/spi/spi-st-ssc4.c             |  6 ++----
 drivers/spi/spi-stm32-qspi.c          |  6 ++----
 drivers/spi/spi-stm32.c               |  6 ++----
 drivers/spi/spi-sun4i.c               |  6 ++----
 drivers/spi/spi-sun6i.c               |  5 ++---
 drivers/spi/spi-sunplus-sp7021.c      |  5 ++---
 drivers/spi/spi-synquacer.c           |  6 ++----
 drivers/spi/spi-tegra114.c            |  6 ++----
 drivers/spi/spi-tegra20-sflash.c      |  6 ++----
 drivers/spi/spi-tegra20-slink.c       |  5 ++---
 drivers/spi/spi-tegra210-quad.c       |  6 ++----
 drivers/spi/spi-topcliff-pch.c        |  6 ++----
 drivers/spi/spi-uniphier.c            |  6 ++----
 drivers/spi/spi-xilinx.c              |  6 ++----
 drivers/spi/spi-xtensa-xtfpga.c       |  6 ++----
 drivers/spi/spi-zynq-qspi.c           |  6 ++----
 drivers/spi/spi-zynqmp-gqspi.c        |  6 ++----
 87 files changed, 183 insertions(+), 350 deletions(-)

base-commit: 2eb29d59ddf02e39774abfb60b2030b0b7e27c1f
-- 
2.39.1

