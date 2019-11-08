Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF77F4A46
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 13:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbfKHMII (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 07:08:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391895AbfKHMIH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 07:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V0JyvfKjDFABiJhKxAlztY7U8T0EiquozbTp1bvQlrY=; b=pFk6CZnM+Ak1
        mEcRd5307Oni/jz9jPUVHFIQFgzgGbqsQLNl1dEWXMHs3qoDCybxMux2pRVKKvgZPECDIA6ATS46B
        CJ9gkVuUdPWC5C38ob989rxErXxAPdBbwS8B4CN2nSWoBAmYGUb/D2yIX+LQKSycZT7rzzuSzXtO1
        5vGIY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iT33Z-0007DQ-2p; Fri, 08 Nov 2019 12:08:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 88C022740C6C; Fri,  8 Nov 2019 12:08:00 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Applied "spi: zynq-qspi: Keep the naming consistent across the driver" to the spi tree
In-Reply-To: <20191108105920.19014-3-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191108120800.88C022740C6C@ypsilon.sirena.org.uk>
Date:   Fri,  8 Nov 2019 12:08:00 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: zynq-qspi: Keep the naming consistent across the driver

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

From 9b10fa363baf3a506b089f3df3a5afd5e2f244db Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 8 Nov 2019 11:59:15 +0100
Subject: [PATCH] spi: zynq-qspi: Keep the naming consistent across the driver

In this driver (and also in a lot of other drivers in drivers/spi/),
the spi_controller structure is sometimes referred as 'ctlr' and
sometimes as 'ctrl'. Grepping there shows that 'ctlr' seems to be more
common so keep the naming consistent in this driver and s/ctrl/ctlr/.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191108105920.19014-3-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 8786054f4869..b1c56e9d7c94 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -283,8 +283,8 @@ static void zynq_qspi_txfifo_op(struct zynq_qspi *xqspi, unsigned int size)
  */
 static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 {
-	struct spi_controller *ctrl = spi->master;
-	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctrl);
+	struct spi_controller *ctlr = spi->master;
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 	u32 config_reg;
 
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
@@ -364,10 +364,10 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
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

