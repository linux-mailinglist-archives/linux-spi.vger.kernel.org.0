Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6C1F1C7
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfEOLS3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 07:18:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730797AbfEOLS3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 07:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XueWC9NaAC+a0tui5U5SBbamkvqq+xEVAEG1fYGi7Q0=; b=cTl3bAQnWO80
        JrRi8wG+XyPxS1+2l9ILterwGc4TVopTiVu/a8aLhDOSELEa9VlfdRpHlFZXabb9Od5/o3JfKgQ5V
        XUfRgaZ2TXmeQRwo5BQFC1wIyN8+R0n4LoVaJlTzil958dV0qzdOrQICcxWoL5MDYWwcFH941U3kP
        B14K0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQrvU-0003bw-NW; Wed, 15 May 2019 11:18:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1C34E1126D6D; Wed, 15 May 2019 12:18:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     broonie@kernel.org, jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        thierry.reding@gmail.com
Subject: Applied "spi: tegra114: add support for hw based cs" to the spi tree
In-Reply-To: <1557810235-16401-3-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190515111824.1C34E1126D6D@debutante.sirena.org.uk>
Date:   Wed, 15 May 2019 12:18:24 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: tegra114: add support for hw based cs

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From 1bf9f3c9232d08651aa6990001e7b042c95303dc Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 13 May 2019 22:03:53 -0700
Subject: [PATCH] spi: tegra114: add support for hw based cs

Tegra SPI controller supports both HW and SW based CS control
for SPI transfers.

This patch adds support for HW based CS control where CS is driven
to active state during the transfer and is driven inactive at the
end of the transfer directly by the HW.

This patch enables the use of HW based CS only for single transfers
without cs_change request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 39 ++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f47417dd9edb..0cb0932d32fd 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -193,6 +193,7 @@ struct tegra_spi_data {
 	unsigned				dma_buf_size;
 	unsigned				max_buf_size;
 	bool					is_curr_dma_xfer;
+	bool					use_hw_based_cs;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -723,7 +724,9 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
-		struct spi_transfer *t, bool is_first_of_msg)
+					struct spi_transfer *t,
+					bool is_first_of_msg,
+					bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	u32 speed = t->speed_hz;
@@ -780,11 +783,17 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		if (spi->cs_gpiod)
 			gpiod_set_value(spi->cs_gpiod, 1);
 
-		command1 |= SPI_CS_SW_HW;
-		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SW_VAL;
-		else
-			command1 &= ~SPI_CS_SW_VAL;
+		if (is_single_xfer && !(t->cs_change)) {
+			tspi->use_hw_based_cs = true;
+			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
+		} else {
+			tspi->use_hw_based_cs = false;
+			command1 |= SPI_CS_SW_HW;
+			if (spi->mode & SPI_CS_HIGH)
+				command1 |= SPI_CS_SW_VAL;
+			else
+				command1 &= ~SPI_CS_SW_VAL;
+		}
 
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
@@ -905,11 +914,14 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	if (spi->cs_gpiod)
 		gpiod_set_value(spi->cs_gpiod, 0);
 
-	if (cs_val)
-		tspi->command1_reg |= SPI_CS_SW_VAL;
-	else
-		tspi->command1_reg &= ~SPI_CS_SW_VAL;
-	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	if (!tspi->use_hw_based_cs) {
+		if (cs_val)
+			tspi->command1_reg |= SPI_CS_SW_VAL;
+		else
+			tspi->command1_reg &= ~SPI_CS_SW_VAL;
+		tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	}
+
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
@@ -936,16 +948,19 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	int ret;
 	bool skip = false;
+	int single_xfer;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 
+	single_xfer = list_is_singular(&msg->transfers);
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
 		reinit_completion(&tspi->xfer_completion);
 
-		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
+		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
+						    single_xfer);
 
 		if (!xfer->len) {
 			ret = 0;
-- 
2.20.1

