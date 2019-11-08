Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD744F52C9
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKHRpv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 12:45:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfKHRpv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 12:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JKTfmpSbVBqbZWbMm4R+jzpwWjaKYvvCqN2w5M/OpNs=; b=L0W6e9ERLt2r
        JqpHHi0qzrZxKhfRIC+jqikX6FCaQxa6UP6F5m1gNacq4vUy3v4Nw9mmIV3pC8GQT0O+gYjdXlmOy
        4/k/6TeNQwO9ZZohLjsxGSfC2zGKSiyEAxwKzeIuh909vRCxbt9d8fg16R3VenqiuTWUIlD+XNUMY
        983Tw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iT8KO-0007qQ-Gj; Fri, 08 Nov 2019 17:45:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F28452741702; Fri,  8 Nov 2019 17:45:43 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Applied "spi: zynq-qspi: Keep the bitfields naming consistent" to the spi tree
In-Reply-To: <20191108140744.1734-4-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191108174543.F28452741702@ypsilon.sirena.org.uk>
Date:   Fri,  8 Nov 2019 17:45:43 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: zynq-qspi: Keep the bitfields naming consistent

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

From 941be723735113028361c4664cd10134d3d27006 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 8 Nov 2019 15:07:40 +0100
Subject: [PATCH] spi: zynq-qspi: Keep the bitfields naming consistent

Most of the bits/bitfields #define'd in this driver are composed with:
1/ the driver prefix
2/ the name of the register they apply to

Keep the naming consistent by applying this rule to the CONFIG register
internals. These definitions will be used in a following change set.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191108140744.1734-4-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 9f53ea08adf7..530533b6c974 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -60,9 +60,9 @@
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
@@ -292,7 +292,7 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 		/* Select the slave */
 		config_reg &= ~ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
 		config_reg |= (((~(BIT(spi->chip_select))) <<
-				ZYNQ_QSPI_SS_SHIFT) &
+				ZYNQ_QSPI_CONFIG_PCS) &
 				ZYNQ_QSPI_CONFIG_SSCTRL_MASK);
 	} else {
 		config_reg |= ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
@@ -331,7 +331,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 	 *      ----------------
 	 *      111 - divide by 256
 	 */
-	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
+	while ((baud_rate_val < ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX)  &&
 	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
 		spi->max_speed_hz)
 		baud_rate_val++;
@@ -347,7 +347,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 		config_reg |= ZYNQ_QSPI_CONFIG_CPOL_MASK;
 
 	config_reg &= ~ZYNQ_QSPI_CONFIG_BDRATE_MASK;
-	config_reg |= (baud_rate_val << ZYNQ_QSPI_BAUD_DIV_SHIFT);
+	config_reg |= (baud_rate_val << ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT);
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
 
 	return 0;
-- 
2.20.1

