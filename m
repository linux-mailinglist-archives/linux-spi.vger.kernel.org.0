Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7492F52C6
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfKHRpt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 12:45:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37504 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHRpt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 12:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nARUHk6NPWqiybUpjTO1cBzFlZvx1wgLOH8dJtePUDI=; b=Lfe4wb5hoS93
        SELbSpijrC1Udf9xrjfqvTbKDOMC31fRJjh9TDINHDdM+qCl3zJL0i5FWsRL15kAVKRkFqwW/TcbB
        h+LHqJLGq5Y+mb5n19coA4PlsSicFJZo2H8z0mfFqKs1RBjc9V181LCV1XZymXa/EtsXNZnVB1hH8
        chbks=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iT8KO-0007qK-1y; Fri, 08 Nov 2019 17:45:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7A0102741703; Fri,  8 Nov 2019 17:45:43 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Applied "spi: zynq-qspi: Clarify the select chip function" to the spi tree
In-Reply-To: <20191108140744.1734-6-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191108174543.7A0102741703@ypsilon.sirena.org.uk>
Date:   Fri,  8 Nov 2019 17:45:43 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: zynq-qspi: Clarify the select chip function

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

From dffaf7439979e6dbb820633bb4f44dcadcac847e Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 8 Nov 2019 15:07:42 +0100
Subject: [PATCH] spi: zynq-qspi: Clarify the select chip function

The code used to assert and de-assert a chip select line is very
complicated for no reason. Simplify the logic by either setting or
resetting the concerned bit, which actually only changes an electrical
state.

Update the comment to reflect that there is no possibility to actually
choose a CS as the default (CS0) will be driven in any case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191108140744.1734-6-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 70ecefd817f7..80e51c894eaa 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -50,7 +50,6 @@
 #define ZYNQ_QSPI_CONFIG_BDRATE_MASK	GENMASK(5, 3) /* Baud Rate Mask */
 #define ZYNQ_QSPI_CONFIG_CPHA_MASK	BIT(2) /* Clock Phase Control */
 #define ZYNQ_QSPI_CONFIG_CPOL_MASK	BIT(1) /* Clock Polarity Control */
-#define ZYNQ_QSPI_CONFIG_SSCTRL_MASK	BIT(10) /* Slave Select Mask */
 #define ZYNQ_QSPI_CONFIG_FWIDTH_MASK	GENMASK(7, 6) /* FIFO width */
 #define ZYNQ_QSPI_CONFIG_MSTREN_MASK	BIT(0) /* Master Mode */
 
@@ -62,7 +61,7 @@
  */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX	GENMASK(2, 0) /* Baud rate maximum */
 #define ZYNQ_QSPI_CONFIG_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift */
-#define ZYNQ_QSPI_CONFIG_PCS		10 /* Peripheral Chip Select */
+#define ZYNQ_QSPI_CONFIG_PCS		BIT(10) /* Peripheral Chip Select */
 
 /*
  * QSPI Interrupt Registers bit Masks
@@ -287,16 +286,12 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
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

