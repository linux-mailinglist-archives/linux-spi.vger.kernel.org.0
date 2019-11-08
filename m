Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99FEF52CB
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 18:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfKHRpw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 12:45:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKHRpw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 12:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=054D4IehVPi3LXAnly7Ia/RvdD/amczeyU/c9Ai/ERk=; b=ifjQ14ueFA6R
        CrcdqsQPtx3JfDZ9F5xYLMAEo0Jd/7uTe4Oh3fhEeIIYZPKiB94Ee/F7TpSppEt+3UBsTGsJAJA0p
        pn7N6mwfyFXlrZTomrScTbzNAmJyghigcI8I1TVViMbnedaui2/X5/zRMTPf2Mch/yCdflL1lEw0H
        /dHqg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iT8KN-0007qJ-UO; Fri, 08 Nov 2019 17:45:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0D58E2741460; Fri,  8 Nov 2019 17:45:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Applied "spi: zynq-qspi: Support two chip selects" to the spi tree
In-Reply-To: <20191108140744.1734-8-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191108174543.0D58E2741460@ypsilon.sirena.org.uk>
Date:   Fri,  8 Nov 2019 17:45:42 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: zynq-qspi: Support two chip selects

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d575c9b7c8b4c5ddfb1aa75ac91fdcc20ce328c4 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 8 Nov 2019 15:07:44 +0100
Subject: [PATCH] spi: zynq-qspi: Support two chip selects

The Zynq QSPI controller features 2 CS. When the num-cs DT property
is set to 2, the hardware will be initialized to support having two
devices connected over each CS.

In this case, both CS lines are driven by the state of the U_PAGE
(upper page) bit. When unset, the lower page (CS0) is selected,
otherwise it is the upper page (CS1).

Change tested on a custom design featuring two SPI-NORs with different
CS on the Zynq-7000 QSPI bus.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191108140744.1734-8-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index e76f9c9738f0..17641157354d 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -114,8 +114,8 @@
  */
 #define ZYNQ_QSPI_MODEBITS			(SPI_CPOL | SPI_CPHA)
 
-/* Default number of chip selects */
-#define ZYNQ_QSPI_DEFAULT_NUM_CS	1
+/* Maximum number of chip selects */
+#define ZYNQ_QSPI_MAX_NUM_CS		2
 
 /**
  * struct zynq_qspi - Defines qspi driver instance
@@ -159,6 +159,7 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
 /**
  * zynq_qspi_init_hw - Initialize the hardware
  * @xqspi:	Pointer to the zynq_qspi structure
+ * @num_cs:	Number of connected CS (to enable dual memories if needed)
  *
  * The default settings of the QSPI controller's configurable parameters on
  * reset are
@@ -176,7 +177,7 @@ static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
  *	- Set the little endian mode of TX FIFO and
  *	- Enable the QSPI controller
  */
-static void zynq_qspi_init_hw(struct zynq_qspi *xqspi)
+static void zynq_qspi_init_hw(struct zynq_qspi *xqspi, unsigned int num_cs)
 {
 	u32 config_reg;
 
@@ -184,7 +185,12 @@ static void zynq_qspi_init_hw(struct zynq_qspi *xqspi)
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
@@ -286,6 +292,17 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
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
@@ -673,9 +690,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(np, "num-cs",
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
@@ -689,7 +706,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = np;
 
 	/* QSPI controller initializations */
-	zynq_qspi_init_hw(xqspi);
+	zynq_qspi_init_hw(xqspi, ctlr->num_chipselect);
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-- 
2.20.1

