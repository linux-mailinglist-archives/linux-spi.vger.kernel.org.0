Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28FAA87B0
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfIDOAB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 10:00:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730606AbfIDOAA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Sep 2019 10:00:00 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5AC0B9810AA2A1D82DEB;
        Wed,  4 Sep 2019 21:59:51 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 21:59:43 +0800
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
Subject: [PATCH -next 05/36] spi: bcm2835aux: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 21:58:47 +0800
Message-ID: <20190904135918.25352-6-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190904135918.25352-1-yuehaibing@huawei.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-bcm2835aux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index b18ce69..a2162ff 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -491,7 +491,6 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct bcm2835aux_spi *bs;
-	struct resource *res;
 	unsigned long clk_hz;
 	int err;
 
@@ -524,8 +523,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	bs = spi_master_get_devdata(master);
 
 	/* the main area */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bs->regs = devm_ioremap_resource(&pdev->dev, res);
+	bs->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bs->regs)) {
 		err = PTR_ERR(bs->regs);
 		goto out_master_put;
-- 
2.7.4


