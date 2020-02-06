Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3415489A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 16:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBFPy4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 10:54:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48246 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbgBFPyz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 10:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=06SZkkWNYV0dzpqU3VFXxiSszGgP4ghCFb22tKeSYmM=; b=uwgvbwIDXjy9
        D8UI8zcbEAFNpuzzeTCEifBV2Iq+6znEoGHfULSLQp3iQBHg6hXr9V6BHbG2zc9jLYJ83zBVdUlYO
        8OvEdh5OhzEbOuHMZMMOB/cA3yNqr+FofhcS2dj0Sllw+fjUDiDnBIP5ECNvxzgbHKsQFU2gSZgHH
        EE7t4=;
Received: from fw-tnat-cam2.arm.com ([217.140.106.50] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izjUQ-0002ld-Q7; Thu, 06 Feb 2020 15:54:50 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 81A80D02D58; Thu,  6 Feb 2020 15:54:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x" to the spi tree
In-Reply-To: <20200204124816.16735-2-vigneshr@ti.com>
Message-Id: <applied-20200204124816.16735-2-vigneshr@ti.com>
X-Patchwork-Hint: ignore
Date:   Thu,  6 Feb 2020 15:54:50 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From e4e8276a4f652be2c7bb783a0155d4adb85f5d7d Mon Sep 17 00:00:00 2001
From: Vignesh Raghavendra <vigneshr@ti.com>
Date: Tue, 4 Feb 2020 18:18:15 +0530
Subject: [PATCH] spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x

On AM654, McSPI can only support 4K - 1 bytes per transfer when DMA is
enabled. Therefore populate master->max_transfer_size callback to
inform client drivers of this restriction when DMA channels are
available.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20200204124816.16735-2-vigneshr@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c                 | 26 +++++++++++++++++++
 include/linux/platform_data/spi-omap2-mcspi.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7e2292c11d12..e9bc9cf984d6 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -130,6 +130,7 @@ struct omap2_mcspi {
 	int			fifo_depth;
 	bool			slave_aborted;
 	unsigned int		pin_dir:1;
+	size_t			max_xfer_len;
 };
 
 struct omap2_mcspi_cs {
@@ -1305,6 +1306,18 @@ static bool omap2_mcspi_can_dma(struct spi_master *master,
 	return (xfer->len >= DMA_MIN_BYTES);
 }
 
+static size_t omap2_mcspi_max_xfer_size(struct spi_device *spi)
+{
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_dma *mcspi_dma =
+		&mcspi->dma_channels[spi->chip_select];
+
+	if (mcspi->max_xfer_len && mcspi_dma->dma_rx)
+		return mcspi->max_xfer_len;
+
+	return SIZE_MAX;
+}
+
 static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*master = mcspi->master;
@@ -1373,6 +1386,11 @@ static struct omap2_mcspi_platform_config omap4_pdata = {
 	.regs_offset = OMAP4_MCSPI_REG_OFFSET,
 };
 
+static struct omap2_mcspi_platform_config am654_pdata = {
+	.regs_offset = OMAP4_MCSPI_REG_OFFSET,
+	.max_xfer_len = SZ_4K - 1,
+};
+
 static const struct of_device_id omap_mcspi_of_match[] = {
 	{
 		.compatible = "ti,omap2-mcspi",
@@ -1382,6 +1400,10 @@ static const struct of_device_id omap_mcspi_of_match[] = {
 		.compatible = "ti,omap4-mcspi",
 		.data = &omap4_pdata,
 	},
+	{
+		.compatible = "ti,am654-mcspi",
+		.data = &am654_pdata,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, omap_mcspi_of_match);
@@ -1439,6 +1461,10 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		mcspi->pin_dir = pdata->pin_dir;
 	}
 	regs_offset = pdata->regs_offset;
+	if (pdata->max_xfer_len) {
+		mcspi->max_xfer_len = pdata->max_xfer_len;
+		master->max_transfer_size = omap2_mcspi_max_xfer_size;
+	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index 0bf9fddb8306..3b400b1919a9 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -11,6 +11,7 @@ struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
 	unsigned int regs_offset;
 	unsigned int pin_dir:1;
+	size_t max_xfer_len;
 };
 
 struct omap2_mcspi_device_config {
-- 
2.20.1

