Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFBFA87CE
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfIDOAS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 10:00:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730131AbfIDOAS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Sep 2019 10:00:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ABA633EA834E6FCC6DF4;
        Wed,  4 Sep 2019 22:00:15 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 22:00:06 +0800
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
Subject: [PATCH -next 13/36] spi: spi-geni-qcom: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 21:58:55 +0800
Message-ID: <20190904135918.25352-14-yuehaibing@huawei.com>
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
 drivers/spi/spi-geni-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 242b6c8..6f3d64a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -534,7 +534,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	int ret, irq;
 	struct spi_master *spi;
 	struct spi_geni_master *mas;
-	struct resource *res;
 	void __iomem *base;
 	struct clk *clk;
 
@@ -542,8 +541,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.7.4


