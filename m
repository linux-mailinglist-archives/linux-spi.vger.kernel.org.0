Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDED95FA5
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfHTNOc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:32 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:36716 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfHTNOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:30 -0400
Received: by mail-wr1-f97.google.com with SMTP id r3so12378475wrt.3
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=2XMcunS52COiqqxhWjU5S089vJ5lQ2jXjW3UlOzNP9Y=;
        b=TMF7rqEjwo45vRwuaii6yw6LjvbVZlNlqom6PiXbHsWLpRhuFp/mILbyDp+n3knnYx
         EctswQANqkMlgPdDZ+DguWPsSrpEXitk8IdN/3hyLO+cmmHEO+dTdXwI4EpEvRR32Z60
         Jcwtaq4Yms7gI46S4MXWH/r1y4eZSAramrZf3e9Lfclkwns2NjuTjdhfStIakNQRD5Kn
         UZeqp/2/aVlIFGnYUMsBun0kqHbzXs/UNhj7gwLm+1MLjlB1y17tmAvsc6XKQPC6EWgv
         I0Dz4BlF1HOfsQuUiAi27IgUfDno5EZKFtZ/o9PXd+4CFV7kIm+BGq8TfLgkh/e87+iF
         M/1w==
X-Gm-Message-State: APjAAAUK+psxO4b91stcCMvaRS1eI6tHckWA6iSbWBDM8C4HcLI/mCXt
        mwqWO7eHDeEU1BnlS2UpfqVtGGBLnvWtK7cek1BhFWj8/d7vMZFP42tR0kwBJv5Xtg==
X-Google-Smtp-Source: APXvYqxzu5cZQ3/w2EPQR7R4WEUC78yvOodiKxjfyqMHUz6Oy8zXzlIWkLsarpDAeFagW+l4CwBn1LehFQJu
X-Received: by 2002:adf:f088:: with SMTP id n8mr34130168wro.58.1566306867177;
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id b4sm297232wrt.92.2019.08.20.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xy-0002Li-UF; Tue, 20 Aug 2019 13:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 77C26274314E; Tue, 20 Aug 2019 14:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Use reverse Christmas tree declaration order" to the spi tree
In-Reply-To: <20190818180115.31114-11-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131426.77C26274314E@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:26 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Use reverse Christmas tree declaration order

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From d6bdfa6c203d16e7f290ecc34137c396b1602782 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:11 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Use reverse Christmas tree declaration
 order

This patch puts variable declaration in the reverse order of their
length for cosmetic purposes.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-11-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a9bcbc458172..e2e71bd73b5c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -268,8 +268,8 @@ static void dspi_rx_dma_callback(void *arg)
 
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
-	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
+	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
 	int i;
 
@@ -346,9 +346,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
-	struct fsl_dspi_dma *dma = dspi->dma;
-	struct device *dev = &dspi->pdev->dev;
 	struct spi_message *message = dspi->cur_msg;
+	struct device *dev = &dspi->pdev->dev;
+	struct fsl_dspi_dma *dma = dspi->dma;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
 	int ret = 0;
@@ -383,9 +383,9 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
-	struct fsl_dspi_dma *dma;
-	struct dma_slave_config cfg;
 	struct device *dev = &dspi->pdev->dev;
+	struct dma_slave_config cfg;
+	struct fsl_dspi_dma *dma;
 	int ret;
 
 	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
@@ -527,10 +527,10 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 			   unsigned long clkrate)
 {
-	int pscale_tbl[4] = {1, 3, 5, 7};
 	int scale_needed, scale, minscale = INT_MAX;
-	int i, j;
+	int pscale_tbl[4] = {1, 3, 5, 7};
 	u32 remainder;
+	int i, j;
 
 	scale_needed = div_u64_rem((u64)delay_ns * clkrate, NSEC_PER_SEC,
 				   &remainder);
@@ -652,9 +652,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
+	enum dspi_trans_mode trans_mode;
 	struct spi_transfer *transfer;
 	int status = 0;
-	enum dspi_trans_mode trans_mode;
 
 	message->actual_length = 0;
 
@@ -752,12 +752,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
 static int dspi_setup(struct spi_device *spi)
 {
-	struct chip_data *chip;
 	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
-	struct fsl_dspi_platform_data *pdata;
-	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
+	u32 cs_sck_delay = 0, sck_cs_delay = 0;
+	struct fsl_dspi_platform_data *pdata;
 	unsigned char pasc = 0, asc = 0;
+	struct chip_data *chip;
 	unsigned long clkrate;
 
 	/* Only alloc on first setup */
@@ -990,13 +990,13 @@ static void dspi_init(struct fsl_dspi *dspi)
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct regmap_config *regmap_config;
+	struct fsl_dspi_platform_data *pdata;
 	struct spi_controller *ctlr;
+	int ret, cs_num, bus_num;
 	struct fsl_dspi *dspi;
 	struct resource *res;
-	const struct regmap_config *regmap_config;
 	void __iomem *base;
-	struct fsl_dspi_platform_data *pdata;
-	int ret, cs_num, bus_num;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
-- 
2.20.1

