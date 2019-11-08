Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611D3F4DC3
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfKHOHv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 09:07:51 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56133 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKHOHu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 09:07:50 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 51C8620002;
        Fri,  8 Nov 2019 14:07:48 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/7] spi: zynq-qspi: Keep the naming consistent across the driver
Date:   Fri,  8 Nov 2019 15:07:39 +0100
Message-Id: <20191108140744.1734-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108140744.1734-1-miquel.raynal@bootlin.com>
References: <20191108140744.1734-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In this driver (and also in a lot of other drivers in drivers/spi/),
the spi_controller structure is sometimes referred as 'ctlr' and
sometimes as 'ctrl'. Grepping there shows that 'ctlr' seems to be more
common so keep the naming consistent in this driver and s/ctrl/ctlr/.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 713f9a03a40a..641691f5dedf 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -284,8 +284,8 @@ static void zynq_qspi_txfifo_op(struct zynq_qspi *xqspi, unsigned int size)
  */
 static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 {
-	struct spi_controller *ctrl = spi->master;
-	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctrl);
+	struct spi_controller *ctlr = spi->master;
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
@@ -365,10 +365,10 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
  */
 static int zynq_qspi_setup_op(struct spi_device *spi)
 {
-	struct spi_controller *ctrl = spi->master;
-	struct zynq_qspi *qspi = spi_controller_get_devdata(ctrl);
+	struct spi_controller *ctlr = spi->master;
+	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
 
-	if (ctrl->busy)
+	if (ctlr->busy)
 		return -EBUSY;
 
 	clk_enable(qspi->refclk);
-- 
2.20.1

