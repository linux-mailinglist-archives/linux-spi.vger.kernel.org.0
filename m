Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB9A878F
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfIDN7i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 09:59:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730219AbfIDN7h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Sep 2019 09:59:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 53D972AB7375EADC37DD;
        Wed,  4 Sep 2019 21:59:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 21:59:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <shc_work@mail.ru>, <agross@kernel.org>, <khilman@baylibre.com>,
        <matthias.bgg@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <kgene@kernel.org>, <krzk@kernel.org>,
        <andi@etezian.org>, <palmer@sifive.com>,
        <paul.walmsley@sifive.com>, <baohua@kernel.org>,
        <mripard@kernel.org>, <wens@csie.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <yamada.masahiro@socionext.com>, <michal.simek@xilinx.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 00/36] use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 21:58:42 +0800
Message-ID: <20190904135918.25352-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

devm_platform_ioremap_resource() internally have platform_get_resource()
and devm_ioremap_resource() in it. So instead of calling them separately
use devm_platform_ioremap_resource() directly.

YueHaibing (36):
  spi: altera: use devm_platform_ioremap_resource() to simplify code
  spi: a3700: use devm_platform_ioremap_resource() to simplify code
  spi: ath79: use devm_platform_ioremap_resource() to simplify code
  spi: spi-axi: use devm_platform_ioremap_resource() to simplify code
  spi: bcm2835aux: use devm_platform_ioremap_resource() to simplify code
  spi: bcm2835: use devm_platform_ioremap_resource() to simplify code
  spi: bcm63xx-hsspi: use devm_platform_ioremap_resource() to simplify
    code
  spi: cadence: use devm_platform_ioremap_resource() to simplify code
  spi: octeon: use devm_platform_ioremap_resource() to simplify code
  spi: clps711x: use devm_platform_ioremap_resource() to simplify code
  spi: coldfire-qspi: use devm_platform_ioremap_resource() to simplify
    code
  spi: dw-mmio: use devm_platform_ioremap_resource() to simplify code
  spi: spi-geni-qcom: use devm_platform_ioremap_resource() to simplify
    code
  spi: lp-8841: use devm_platform_ioremap_resource() to simplify code
  spi: meson-spicc: use devm_platform_ioremap_resource() to simplify
    code
  spi: spi-meson-spifc: use devm_platform_ioremap_resource() to simplify
    code
  spi: mt7621: use devm_platform_ioremap_resource() to simplify code
  spi: mxs: use devm_platform_ioremap_resource() to simplify code
  spi: npcm: use devm_platform_ioremap_resource() to simplify code
  spi: nuc900: use devm_platform_ioremap_resource() to simplify code
  spi: oc-tiny: use devm_platform_ioremap_resource() to simplify code
  spi: pic32-sqi: use devm_platform_ioremap_resource() to simplify code
  spi: spi-qcom-qspi: use devm_platform_ioremap_resource() to simplify
    code
  spi: rb4xx: use devm_platform_ioremap_resource() to simplify code
  spi: s3c24xx: use devm_platform_ioremap_resource() to simplify code
  spi: sifive: use devm_platform_ioremap_resource() to simplify code
  spi: sirf: use devm_platform_ioremap_resource() to simplify code
  spi: st-ssc4: use devm_platform_ioremap_resource() to simplify code
  spi: sun4i: use devm_platform_ioremap_resource() to simplify code
  spi: sun6i: use devm_platform_ioremap_resource() to simplify code
  spi: tegra: use devm_platform_ioremap_resource() to simplify code
  spi: uniphier: use devm_platform_ioremap_resource() to simplify code
  spi: xlp: use devm_platform_ioremap_resource() to simplify code
  spi: zynqmp: use devm_platform_ioremap_resource() to simplify code
  spi: zynq-qspi: use devm_platform_ioremap_resource() to simplify code
  spi: fsl-spi: use devm_platform_ioremap_resource() to simplify code

 drivers/spi/spi-altera.c         | 4 +---
 drivers/spi/spi-armada-3700.c    | 4 +---
 drivers/spi/spi-ath79.c          | 4 +---
 drivers/spi/spi-axi-spi-engine.c | 4 +---
 drivers/spi/spi-bcm2835.c        | 4 +---
 drivers/spi/spi-bcm2835aux.c     | 4 +---
 drivers/spi/spi-bcm63xx-hsspi.c  | 4 +---
 drivers/spi/spi-cadence.c        | 4 +---
 drivers/spi/spi-cavium-octeon.c  | 4 +---
 drivers/spi/spi-clps711x.c       | 4 +---
 drivers/spi/spi-coldfire-qspi.c  | 4 +---
 drivers/spi/spi-dw-mmio.c        | 4 +---
 drivers/spi/spi-fsl-cpm.c        | 6 ++----
 drivers/spi/spi-geni-qcom.c      | 4 +---
 drivers/spi/spi-lp8841-rtc.c     | 4 +---
 drivers/spi/spi-meson-spicc.c    | 4 +---
 drivers/spi/spi-meson-spifc.c    | 4 +---
 drivers/spi/spi-mt7621.c         | 4 +---
 drivers/spi/spi-mxs.c            | 4 +---
 drivers/spi/spi-npcm-pspi.c      | 4 +---
 drivers/spi/spi-nuc900.c         | 4 +---
 drivers/spi/spi-oc-tiny.c        | 4 +---
 drivers/spi/spi-pic32-sqi.c      | 4 +---
 drivers/spi/spi-qcom-qspi.c      | 4 +---
 drivers/spi/spi-rb4xx.c          | 4 +---
 drivers/spi/spi-s3c24xx.c        | 4 +---
 drivers/spi/spi-sifive.c         | 4 +---
 drivers/spi/spi-sirf.c           | 4 +---
 drivers/spi/spi-st-ssc4.c        | 4 +---
 drivers/spi/spi-sun4i.c          | 4 +---
 drivers/spi/spi-sun6i.c          | 4 +---
 drivers/spi/spi-tegra20-sflash.c | 4 +---
 drivers/spi/spi-uniphier.c       | 4 +---
 drivers/spi/spi-xlp.c            | 4 +---
 drivers/spi/spi-zynq-qspi.c      | 4 +---
 drivers/spi/spi-zynqmp-gqspi.c   | 4 +---
 36 files changed, 37 insertions(+), 109 deletions(-)

-- 
2.7.4


