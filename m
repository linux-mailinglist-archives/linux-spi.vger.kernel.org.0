Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC42F52CA
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 18:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfKHRpv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 12:45:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37566 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfKHRpv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 12:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=b3C7gijS/8kKmdHw0Z9BScpM80WNvZGBHgxJyi74e4w=; b=kWYYL+yr8lt5
        ojW52H7Al0bOFfMD9+FpIl4i0Rm2RVSZwQIDl7sOEqpHv6sA269A1ppVp0AroJD6Kl8kgLB/Bwsrj
        NSRCBySkXlEMUYFBCLkhS5LphiA4YLkbosTjxz79DAUxpct8yEK2IU/HZtDZoGD6WXJn0oow+Pl1N
        f68dI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iT8KO-0007qU-NI; Fri, 08 Nov 2019 17:45:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3BA1A2741460; Fri,  8 Nov 2019 17:45:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Applied "spi: zynq-qspi: Anything else than CS0 is not supported yet" to the spi tree
In-Reply-To: <20191108140744.1734-2-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20191108174544.3BA1A2741460@ypsilon.sirena.org.uk>
Date:   Fri,  8 Nov 2019 17:45:44 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: zynq-qspi: Anything else than CS0 is not supported yet

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

From 087622d09472f96f1f5d6ced36ca75c92e86af21 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 8 Nov 2019 15:07:38 +0100
Subject: [PATCH] spi: zynq-qspi: Anything else than CS0 is not supported yet

Unlike what the driver is currently advertizing, CS0 only can be used,
CS1 is not supported at all. Prevent people to use CS1.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191108140744.1734-2-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index b1c56e9d7c94..9f53ea08adf7 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -680,10 +680,14 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(np, "num-cs",
 				   &num_cs);
-	if (ret < 0)
+	if (ret < 0) {
 		ctlr->num_chipselect = ZYNQ_QSPI_DEFAULT_NUM_CS;
-	else
+	} else if (num_cs > ZYNQ_QSPI_DEFAULT_NUM_CS) {
+		dev_err(&pdev->dev, "anything but CS0 is not yet supported\n");
+		goto remove_master;
+	} else {
 		ctlr->num_chipselect = num_cs;
+	}
 
 	ctlr->mode_bits =  SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
-- 
2.20.1

