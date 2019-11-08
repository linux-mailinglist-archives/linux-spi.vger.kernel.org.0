Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D935F4DC4
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 15:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfKHOHv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 09:07:51 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59517 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfKHOHv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 09:07:51 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6CCDC20008;
        Fri,  8 Nov 2019 14:07:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 3/7] spi: zynq-qspi: Keep the bitfields naming consistent
Date:   Fri,  8 Nov 2019 15:07:40 +0100
Message-Id: <20191108140744.1734-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108140744.1734-1-miquel.raynal@bootlin.com>
References: <20191108140744.1734-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Most of the bits/bitfields #define'd in this driver are composed with:
1/ the driver prefix
2/ the name of the register they apply to

Keep the naming consistent by applying this rule to the CONFIG register
internals. These definitions will be used in a following change set.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 641691f5dedf..78711fe955f4 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -61,9 +61,9 @@
  * These are the values used in the calculation of baud rate divisor and
  * setting the slave select.
  */
-#define ZYNQ_QSPI_BAUD_DIV_MAX		GENMASK(2, 0) /* Baud rate maximum */
-#define ZYNQ_QSPI_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift in CR */
-#define ZYNQ_QSPI_SS_SHIFT		10 /* Slave Select field shift in CR */
+#define ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX	GENMASK(2, 0) /* Baud rate maximum */
+#define ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift */
+#define ZYNQ_QSPI_CONFIG_PCS		10 /* Peripheral Chip Select */
 
 /*
  * QSPI Interrupt Registers bit Masks
@@ -293,7 +293,7 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 		/* Select the slave */
 		config_reg &= ~ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
 		config_reg |= (((~(BIT(spi->chip_select))) <<
-				ZYNQ_QSPI_SS_SHIFT) &
+				ZYNQ_QSPI_CONFIG_PCS) &
 				ZYNQ_QSPI_CONFIG_SSCTRL_MASK);
 	} else {
 		config_reg |= ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
@@ -332,7 +332,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 	 *      ----------------
 	 *      111 - divide by 256
 	 */
-	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
+	while ((baud_rate_val < ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX)  &&
 	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
 		spi->max_speed_hz)
 		baud_rate_val++;
@@ -348,7 +348,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 		config_reg |= ZYNQ_QSPI_CONFIG_CPOL_MASK;
 
 	config_reg &= ~ZYNQ_QSPI_CONFIG_BDRATE_MASK;
-	config_reg |= (baud_rate_val << ZYNQ_QSPI_BAUD_DIV_SHIFT);
+	config_reg |= (baud_rate_val << ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT);
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
 
 	return 0;
-- 
2.20.1

