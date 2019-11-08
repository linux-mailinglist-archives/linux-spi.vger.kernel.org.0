Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC0F452D
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfKHK73 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 05:59:29 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34657 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfKHK73 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 05:59:29 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BFC94E001B;
        Fri,  8 Nov 2019 10:59:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5/7] spi: zynq-qspi: Clarify the select chip function
Date:   Fri,  8 Nov 2019 11:59:18 +0100
Message-Id: <20191108105920.19014-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108105920.19014-1-miquel.raynal@bootlin.com>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The code used to assert and de-assert a chip select line is very
complicated for no reason. Simplify the logic by either setting or
resetting the concerned bit, which actually only changes an electrical
state.

Update the comment to reflect that there is no possibility to actually
choose a CS as the default (CS0) will be driven in any case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 34c24b2ad3cf..1ea9a4c2eceb 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -51,7 +51,6 @@
 #define ZYNQ_QSPI_CONFIG_BDRATE_MASK	0x00000038 /* Baud Rate Divisor Mask */
 #define ZYNQ_QSPI_CONFIG_CPHA_MASK	0x00000004 /* Clock Phase Control */
 #define ZYNQ_QSPI_CONFIG_CPOL_MASK	0x00000002 /* Clock Polarity Control */
-#define ZYNQ_QSPI_CONFIG_SSCTRL_MASK	0x00000400 /* Slave Select Mask */
 #define ZYNQ_QSPI_CONFIG_FWIDTH_MASK	0x000000C0 /* FIFO width */
 #define ZYNQ_QSPI_CONFIG_MSTREN_MASK	0x00000001 /* Master Mode */
 
@@ -63,7 +62,7 @@
  */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX	7 /* Baud rate divisor maximum */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift */
-#define ZYNQ_QSPI_CONFIG_PCS		10 /* Peripheral Chip Select */
+#define ZYNQ_QSPI_CONFIG_PCS		BIT(10) /* Peripheral Chip Select */
 
 /*
  * QSPI Interrupt Registers bit Masks
@@ -313,16 +312,12 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
+	/* Ground the line to assert the CS */
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
-	if (assert) {
-		/* Select the slave */
-		config_reg &= ~ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
-		config_reg |= (((~(BIT(spi->chip_select))) <<
-				ZYNQ_QSPI_CONFIG_PCS) &
-				ZYNQ_QSPI_CONFIG_SSCTRL_MASK);
-	} else {
-		config_reg |= ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
-	}
+	if (assert)
+		config_reg &= ~ZYNQ_QSPI_CONFIG_PCS;
+	else
+		config_reg |= ZYNQ_QSPI_CONFIG_PCS;
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
 }
-- 
2.20.1

