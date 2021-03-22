Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC83438D8
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 06:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCVFxw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Mar 2021 01:53:52 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27751 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229875AbhCVFxW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Mar 2021 01:53:22 -0400
X-UUID: 200bc7ee9ae24622be5fb6520308a8da-20210322
X-UUID: 200bc7ee9ae24622be5fb6520308a8da-20210322
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 914627878; Mon, 22 Mar 2021 13:53:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 13:53:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Mar 2021 13:53:06 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 3/4] spi: mediatek: add mtk_spi_compatible support
Date:   Mon, 22 Mar 2021 13:52:43 +0800
Message-ID: <20210322055244.30179-4-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210322055244.30179-1-leilk.liu@mediatek.com>
References: <20210322055244.30179-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 569023D4B5FEB7772D85FCDC49AC3136A05674D1807D11B39F8C6507BF24F9562000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

this patch adds max_fifo_size and must_rx compat support.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-slave-mt27xx.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 44edaa360405..7e6fadc88cef 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -10,6 +10,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
+
 
 #define SPIS_IRQ_EN_REG		0x0
 #define SPIS_IRQ_CLR_REG	0x4
@@ -61,8 +63,6 @@
 #define SPIS_DMA_ADDR_EN	BIT(1)
 #define SPIS_SOFT_RST		BIT(0)
 
-#define MTK_SPI_SLAVE_MAX_FIFO_SIZE 512U
-
 struct mtk_spi_slave {
 	struct device *dev;
 	void __iomem *base;
@@ -70,10 +70,19 @@ struct mtk_spi_slave {
 	struct completion xfer_done;
 	struct spi_transfer *cur_transfer;
 	bool slave_aborted;
+	const struct mtk_spi_compatible *dev_comp;
 };
 
+struct mtk_spi_compatible {
+	const u32 max_fifo_size;
+	bool must_rx;
+};
+static const struct mtk_spi_compatible mt2712_compat = {
+	.max_fifo_size = 512,
+};
 static const struct of_device_id mtk_spi_slave_of_match[] = {
-	{ .compatible = "mediatek,mt2712-spi-slave", },
+	{ .compatible = "mediatek,mt2712-spi-slave",
+	  .data = (void *)&mt2712_compat,},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_slave_of_match);
@@ -272,7 +281,7 @@ static int mtk_spi_slave_transfer_one(struct spi_controller *ctlr,
 	mdata->slave_aborted = false;
 	mdata->cur_transfer = xfer;
 
-	if (xfer->len > MTK_SPI_SLAVE_MAX_FIFO_SIZE)
+	if (xfer->len > mdata->dev_comp->max_fifo_size)
 		return mtk_spi_slave_dma_transfer(ctlr, spi, xfer);
 	else
 		return mtk_spi_slave_fifo_transfer(ctlr, spi, xfer);
@@ -369,6 +378,7 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct mtk_spi_slave *mdata;
 	int irq, ret;
+	const struct of_device_id *of_id;
 
 	ctlr = spi_alloc_slave(&pdev->dev, sizeof(*mdata));
 	if (!ctlr) {
@@ -386,7 +396,17 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	ctlr->setup = mtk_spi_slave_setup;
 	ctlr->slave_abort = mtk_slave_abort;
 
+	of_id = of_match_node(mtk_spi_slave_of_match, pdev->dev.of_node);
+	if (!of_id) {
+		dev_err(&pdev->dev, "failed to probe of_node\n");
+		ret = -EINVAL;
+		goto err_put_ctlr;
+	}
 	mdata = spi_controller_get_devdata(ctlr);
+	mdata->dev_comp = of_id->data;
+
+	if (mdata->dev_comp->must_rx)
+		ctlr->flags = SPI_MASTER_MUST_RX;
 
 	platform_set_drvdata(pdev, ctlr);
 
-- 
2.18.0

