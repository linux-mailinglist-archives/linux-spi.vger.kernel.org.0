Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE6F4DC6
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 15:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfKHOHx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 09:07:53 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59517 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKHOHx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 09:07:53 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BB09D2000F;
        Fri,  8 Nov 2019 14:07:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 6/7] spi: zynq-qspi: Do the actual hardware initialization later in the probe
Date:   Fri,  8 Nov 2019 15:07:43 +0100
Message-Id: <20191108140744.1734-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108140744.1734-1-miquel.raynal@bootlin.com>
References: <20191108140744.1734-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Supporting more than one CS will need some tweaking of the linear
configuration register which is (rightfully) initialized in the
hardware initialization helper. The extra initialization needs the
knowledge of the actual number of CS, which is retrieved by reading
the value of the num-cs DT property.

As the initialization helper is called pretty early and might be
called much later in the probe without side effect, let's delay it a
bit so that the number of CS will be available when running this
helper. This way, adding support for multiple CS lines in a next patch
will be eased.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 9adfcc66b02b..07d361501aa0 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -658,9 +658,6 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_pclk;
 	}
 
-	/* QSPI controller initializations */
-	zynq_qspi_init_hw(xqspi);
-
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -691,6 +688,10 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ctlr->setup = zynq_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->dev.of_node = np;
+
+	/* QSPI controller initializations */
+	zynq_qspi_init_hw(xqspi);
+
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
-- 
2.20.1

