Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02C21F1C8
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfEOLSa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 07:18:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54426 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbfEOLSa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 07:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mH+rxxpA4qXs2qBoBVsRBUtYgq/WpHpZ29ZrxKELIFw=; b=AI2RYNfuzhfY
        OgRC3yWx9SXpVF8bV1XYWZeT1aNW9pxF9ZngoPgeIqItmcRQqSZ6tgPhs4qo8wh6O0SqclJUvE5IT
        Q3TjPFZC9aOc3YG4c+tyWI4Gf0bm0zUy2bhqkX8Rr6iz+p9iNmPGMi5/R/m6f0ClLrjE2dIRKwB9W
        1fakI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQrvU-0003bv-FH; Wed, 15 May 2019 11:18:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B28F41126D6A; Wed, 15 May 2019 12:18:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     broonie@kernel.org, jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        thierry.reding@gmail.com
Subject: Applied "spi: tegra114: add support for TX and RX trimmers" to the spi tree
In-Reply-To: <1557810235-16401-5-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190515111823.B28F41126D6A@debutante.sirena.org.uk>
Date:   Wed, 15 May 2019 12:18:23 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: tegra114: add support for TX and RX trimmers

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

From 318dacbd049b447a5b45290b39f1c889b9cbde4d Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 13 May 2019 22:03:55 -0700
Subject: [PATCH] spi: tegra114: add support for TX and RX trimmers

Tegra SPI master controller has programmable trimmers to adjust the
data with respect to the clock.

These trimmers are programmed in TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY
fields of COMMAND2 register.

SPI TX trimmer is to adjust the outgoing data with respect to the
outgoing clock and SPI RX trimmer is to adjust the loopback clock with
respect to the incoming data from the slave device.

These trimmers vary based on trace lengths of the platform design for
each of the slaves on the SPI bus and optimal value programmed is from
the platform validation across PVT.

This patch adds support for configuring TX and RX clock delay trimmers
through the device tree properties.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e59ff7c1cee6..253a7f182fc9 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -169,6 +169,11 @@ struct tegra_spi_soc_data {
 	bool has_intr_mask_reg;
 };
 
+struct tegra_spi_client_data {
+	int tx_clk_tap_delay;
+	int rx_clk_tap_delay;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -208,8 +213,10 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					def_command2_reg;
 	u32					spi_cs_timing1;
 	u32					spi_cs_timing2;
+	u8					last_used_cs;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -770,10 +777,12 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 					bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
-	u32 command1;
+	u32 command1, command2;
 	int req_mode;
+	u32 tx_tap = 0, rx_tap = 0;
 
 	if (speed != tspi->cur_speed) {
 		clk_set_rate(tspi->clk, speed);
@@ -836,7 +845,18 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 				command1 &= ~SPI_CS_SW_VAL;
 		}
 
-		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
+		if (tspi->last_used_cs != spi->chip_select) {
+			if (cdata && cdata->tx_clk_tap_delay)
+				tx_tap = cdata->tx_clk_tap_delay;
+			if (cdata && cdata->rx_clk_tap_delay)
+				rx_tap = cdata->rx_clk_tap_delay;
+			command2 = SPI_TX_TAP_DELAY(tx_tap) |
+				   SPI_RX_TAP_DELAY(rx_tap);
+			if (command2 != tspi->def_command2_reg)
+				tegra_spi_writel(tspi, command2, SPI_COMMAND2);
+			tspi->last_used_cs = spi->chip_select;
+		}
+
 	} else {
 		command1 = tspi->command1_reg;
 		command1 &= ~SPI_BIT_LENGTH(~0);
@@ -892,9 +912,42 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 	return ret;
 }
 
+static struct tegra_spi_client_data
+	*tegra_spi_parse_cdata_dt(struct spi_device *spi)
+{
+	struct tegra_spi_client_data *cdata;
+	struct device_node *slave_np;
+
+	slave_np = spi->dev.of_node;
+	if (!slave_np) {
+		dev_dbg(&spi->dev, "device node not found\n");
+		return NULL;
+	}
+
+	cdata = kzalloc(sizeof(*cdata), GFP_KERNEL);
+	if (!cdata)
+		return NULL;
+
+	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
+			     &cdata->tx_clk_tap_delay);
+	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
+			     &cdata->rx_clk_tap_delay);
+	return cdata;
+}
+
+static void tegra_spi_cleanup(struct spi_device *spi)
+{
+	struct tegra_spi_client_data *cdata = spi->controller_data;
+
+	spi->controller_data = NULL;
+	if (spi->dev.of_node)
+		kfree(cdata);
+}
+
 static int tegra_spi_setup(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 val;
 	unsigned long flags;
 	int ret;
@@ -905,6 +958,11 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
+	if (!cdata) {
+		cdata = tegra_spi_parse_cdata_dt(spi);
+		spi->controller_data = cdata;
+	}
+
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
@@ -1034,6 +1092,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
+			tspi->last_used_cs = master->num_chipselect + 1;
 			goto complete_xfer;
 		}
 
@@ -1351,6 +1410,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
+	tspi->def_command2_reg = tegra_spi_readl(tspi, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
@@ -1423,6 +1484,8 @@ static int tegra_spi_resume(struct device *dev)
 		return ret;
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command2_reg, SPI_COMMAND2);
+	tspi->last_used_cs = master->num_chipselect + 1;
 	pm_runtime_put(dev);
 
 	return spi_master_resume(master);
-- 
2.20.1

