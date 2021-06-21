Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744453AE79C
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFUKvK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 06:51:10 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:41464 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhFUKvI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 06:51:08 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4CCFCC8E25;
        Mon, 21 Jun 2021 18:48:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P23993T140319383979776S1624272530191297_;
        Mon, 21 Jun 2021 18:48:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <01b44af9b2ca93eee1bdba4fb6faeecc>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v10 6/6] spi: rockchip: Support SPI_CS_HIGH
Date:   Mon, 21 Jun 2021 18:48:48 +0800
Message-Id: <20210621104848.19539-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621104848.19539-1-jon.lin@rock-chips.com>
References: <20210621104800.19088-1-jon.lin@rock-chips.com>
 <20210621104848.19539-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

1.Add standard spi-cs-high support
2.Refer to spi-controller.yaml for details

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/spi/spi-rockchip.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fbd750b1d28e..540861ca2ba3 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -107,6 +107,8 @@
 #define CR0_OPM_MASTER				0x0
 #define CR0_OPM_SLAVE				0x1
 
+#define CR0_SOI_OFFSET				23
+
 #define CR0_MTM_OFFSET				0x21
 
 /* Bit fields in SER, 2bit */
@@ -236,7 +238,7 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
-	bool cs_asserted = !enable;
+	bool cs_asserted = spi->mode & SPI_CS_HIGH ? enable : !enable;
 
 	/* Return immediately for no-op */
 	if (cs_asserted == rs->cs_asserted[spi->chip_select])
@@ -507,6 +509,8 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
+	if (spi->mode & SPI_CS_HIGH)
+		cr0 |= BIT(spi->chip_select) << CR0_SOI_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
 		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
@@ -795,6 +799,14 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		ctlr->can_dma = rockchip_spi_can_dma;
 	}
 
+	switch (readl_relaxed(rs->regs + ROCKCHIP_SPI_VERSION)) {
+	case ROCKCHIP_SPI_VER2_TYPE2:
+		ctlr->mode_bits |= SPI_CS_HIGH;
+		break;
+	default:
+		break;
+	}
+
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register controller\n");
-- 
2.17.1



