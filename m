Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88D17A4A8
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 12:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgCELzt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 06:55:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35647 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCELzt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Mar 2020 06:55:49 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1j9p6S-0000dw-3U; Thu, 05 Mar 2020 12:55:48 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1j9p6R-0008OZ-OY; Thu, 05 Mar 2020 12:55:47 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] spi: spi-fsl-dspi: Make bus-num property optional
Date:   Thu,  5 Mar 2020 12:55:46 +0100
Message-Id: <20200305115546.31814-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI bus number is completely optional to Linux, so make the
corresponding device tree property optional as well.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 2 +-
 drivers/spi/spi-fsl-dspi.c                             | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 162e024b95a0..5c7817c8341c 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -14,11 +14,11 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must contain a "default" entry.
 - spi-num-chipselects : the number of the chipselect signals.
-- bus-num : the slave chip chipselect signal number.
 
 Optional property:
 - big-endian: If present the dspi device's registers are implemented
   in big endian mode.
+- bus-num : the slave chip chipselect signal number.
 
 Optional SPI slave node properties:
 - fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ec2dcb8c57a..8187dd4a3ec4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1038,7 +1038,7 @@ static int dspi_probe(struct platform_device *pdev)
 	const struct regmap_config *regmap_config;
 	struct fsl_dspi_platform_data *pdata;
 	struct spi_controller *ctlr;
-	int ret, cs_num, bus_num;
+	int ret, cs_num, bus_num = -1;
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
@@ -1074,11 +1074,7 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 		ctlr->num_chipselect = cs_num;
 
-		ret = of_property_read_u32(np, "bus-num", &bus_num);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "can't get bus-num\n");
-			goto out_ctlr_put;
-		}
+		of_property_read_u32(np, "bus-num", &bus_num);
 		ctlr->bus_num = bus_num;
 
 		if (of_property_read_bool(np, "spi-slave"))
-- 
2.25.1

