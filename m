Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C101F1D0
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfEOLzY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 07:55:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfEOLSc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 07:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fD191BWt3Mk159coCvNwMJ2L4tNuIv/BNCkxSDNHmnI=; b=hKRliB2yjCdw
        EXrpSoWYRKKGqKf77Gwj8lTMTvb63QZwgEzmT2LqaoBVridkTB4sSuA/Us3W6Fkpq6ceN9DHin8Oh
        OnvR3oleoCfNAbFXnV6QgQVrr2BVEqXGhFGireqB3zWQbWIEffAZvTCdUxdiGKT4wNmVfmRgW2ogj
        dPKos=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQrvX-0003c7-H5; Wed, 15 May 2019 11:18:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E25FB1126D6C; Wed, 15 May 2019 12:18:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     broonie@kernel.org, jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        thierry.reding@gmail.com
Subject: Applied "spi: tegra114: add support for HW CS timing" to the spi tree
In-Reply-To: <1557810235-16401-4-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190515111823.E25FB1126D6C@debutante.sirena.org.uk>
Date:   Wed, 15 May 2019 12:18:23 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: tegra114: add support for HW CS timing

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

From 9b76ef39b7fbc2ddb0869725f9745a402d93cce5 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 13 May 2019 22:03:54 -0700
Subject: [PATCH] spi: tegra114: add support for HW CS timing

This patch implements set_cs_timing SPI controller method to allow
SPI client driver to configure device specific SPI CS timings.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 0cb0932d32fd..e59ff7c1cee6 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -95,8 +95,10 @@
 		(reg = (((val) & 0x1) << ((cs) * 8 + 5)) |	\
 			((reg) & ~(1 << ((cs) * 8 + 5))))
 #define SPI_SET_CYCLES_BETWEEN_PACKETS(reg, cs, val)		\
-		(reg = (((val) & 0xF) << ((cs) * 8)) |		\
-			((reg) & ~(0xF << ((cs) * 8))))
+		(reg = (((val) & 0x1F) << ((cs) * 8)) |		\
+			((reg) & ~(0x1F << ((cs) * 8))))
+#define MAX_SETUP_HOLD_CYCLES			16
+#define MAX_INACTIVE_CYCLES			32
 
 #define SPI_TRANS_STATUS			0x010
 #define SPI_BLK_CNT(val)			(((val) >> 0) & 0xFFFF)
@@ -206,6 +208,8 @@ struct tegra_spi_data {
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
+	u32					spi_cs_timing1;
+	u32					spi_cs_timing2;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -723,6 +727,43 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
+static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
+				       u8 hold_dly, u8 inactive_dly)
+{
+	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	u32 setup_hold;
+	u32 spi_cs_timing;
+	u32 inactive_cycles;
+	u8 cs_state;
+
+	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
+	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
+	if (setup_dly && hold_dly) {
+		setup_hold = SPI_SETUP_HOLD(setup_dly - 1, hold_dly - 1);
+		spi_cs_timing = SPI_CS_SETUP_HOLD(tspi->spi_cs_timing1,
+						  spi->chip_select,
+						  setup_hold);
+		if (tspi->spi_cs_timing1 != spi_cs_timing) {
+			tspi->spi_cs_timing1 = spi_cs_timing;
+			tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING1);
+		}
+	}
+
+	inactive_cycles = min_t(u8, inactive_dly, MAX_INACTIVE_CYCLES);
+	if (inactive_cycles)
+		inactive_cycles--;
+	cs_state = inactive_cycles ? 0 : 1;
+	spi_cs_timing = tspi->spi_cs_timing2;
+	SPI_SET_CS_ACTIVE_BETWEEN_PACKETS(spi_cs_timing, spi->chip_select,
+					  cs_state);
+	SPI_SET_CYCLES_BETWEEN_PACKETS(spi_cs_timing, spi->chip_select,
+				       inactive_cycles);
+	if (tspi->spi_cs_timing2 != spi_cs_timing) {
+		tspi->spi_cs_timing2 = spi_cs_timing;
+		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING2);
+	}
+}
+
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 					struct spi_transfer *t,
 					bool is_first_of_msg,
@@ -1232,6 +1273,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
+	master->set_cs_timing = tegra_spi_set_hw_cs_timing;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->auto_runtime_pm = true;
 	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
@@ -1307,6 +1349,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 	tspi->def_command1_reg  = SPI_M_S;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
+	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
+	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
-- 
2.20.1

