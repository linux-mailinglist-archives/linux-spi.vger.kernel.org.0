Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C73BF452F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfKHK7b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 05:59:31 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45975 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfKHK7b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 05:59:31 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 59E5AE001C;
        Fri,  8 Nov 2019 10:59:29 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 7/7] spi: zynq-qspi: Support two chip selects
Date:   Fri,  8 Nov 2019 11:59:20 +0100
Message-Id: <20191108105920.19014-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108105920.19014-1-miquel.raynal@bootlin.com>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Zynq QSPI controller features 2 CS. When the num-cs DT property
is set to 2, the hardware will be initialized to support having two
devices connected over each CS.

In this case, both CS lines are driven by the state of the U_PAGE
(upper page) bit. When unset, the lower page (CS0) is selected,
otherwise it is the upper page (CS1).

Change tested on a custom design featuring two SPI-NORs with different
CS on the Zynq-7000 QSPI bus.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 68e0515e1791..121253cf5266 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -115,8 +115,8 @@
  */
 #define MODEBITS			(SPI_CPOL | SPI_CPHA)
 
-/* Default number of chip selects */
-#define ZYNQ_QSPI_DEFAULT_NUM_CS	1
+/* Maximum number of chip selects */
+#define ZYNQ_QSPI_MAX_NUM_CS		2
 
 /**
  * struct zynq_qspi - Defines qspi driver instance
@@ -160,6 +160,7 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
 /**
  * zynq_qspi_init_hw - Initialize the hardware
  * @xqspi:	Pointer to the zynq_qspi structure
+ * @num_cs:	Number of connected CS (to enable dual memories if needed)
  *
  * The default settings of the QSPI controller's configurable parameters on
  * reset are
@@ -177,7 +178,7 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
  *	- Set the little endian mode of TX FIFO and
  *	- Enable the QSPI controller
  */
-static void zynq_qspi_init_hw(struct zynq_qspi *xqspi)
+static void zynq_qspi_init_hw(struct zynq_qspi *xqspi, unsigned int num_cs)
 {
 	u32 config_reg;
 
@@ -185,7 +186,12 @@ static void zynq_qspi_init_hw(struct zynq_qspi *xqspi)
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_IDIS_OFFSET, ZYNQ_QSPI_IXR_ALL_MASK);
 
 	/* Disable linear mode as the boot loader may have used it */
-	zynq_qspi_write(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET, 0);
+	config_reg = 0;
+	/* At the same time, enable dual mode if more than 1 CS is available */
+	if (num_cs > 1)
+		config_reg |= ZYNQ_QSPI_LCFG_TWO_MEM;
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET, config_reg);
 
 	/* Clear the RX FIFO */
 	while (zynq_qspi_read(xqspi, ZYNQ_QSPI_STATUS_OFFSET) &
@@ -312,6 +318,17 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
+	/* Select the lower (CS0) or upper (CS1) memory */
+	if (ctlr->num_chipselect > 1) {
+		config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET);
+		if (!spi->chip_select)
+			config_reg &= ~ZYNQ_QSPI_LCFG_U_PAGE;
+		else
+			config_reg |= ZYNQ_QSPI_LCFG_U_PAGE;
+
+		zynq_qspi_write(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET, config_reg);
+	}
+
 	/* Ground the line to assert the CS */
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
 	if (assert)
@@ -697,9 +714,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs",
 				   &num_cs);
 	if (ret < 0) {
-		ctlr->num_chipselect = ZYNQ_QSPI_DEFAULT_NUM_CS;
-	} else if (num_cs > ZYNQ_QSPI_DEFAULT_NUM_CS) {
-		dev_err(&pdev->dev, "anything but CS0 is not yet supported\n");
+		ctlr->num_chipselect = 1;
+	} else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
+		dev_err(&pdev->dev, "only 2 chip selects are available\n");
 		goto remove_master;
 	} else {
 		ctlr->num_chipselect = num_cs;
@@ -713,7 +730,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = np;
 
 	/* QSPI controller initializations */
-	zynq_qspi_init_hw(xqspi);
+	zynq_qspi_init_hw(xqspi, ctlr->num_chipselect);
 
 	ret = spi_register_controller(ctlr);
 	if (ret) {
-- 
2.20.1

