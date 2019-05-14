Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B411C1C1A7
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 07:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfENFEE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 01:04:04 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17394 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfENFED (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 01:04:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda4c1b0000>; Mon, 13 May 2019 22:03:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 22:04:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 22:04:02 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 05:04:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 May 2019 05:04:02 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.159]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cda4c410001>; Mon, 13 May 2019 22:04:02 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 3/4] spi: tegra114: add support for HW CS timing
Date:   Mon, 13 May 2019 22:03:54 -0700
Message-ID: <1557810235-16401-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557810203; bh=0RKRq2bvltptfksFYSB9GGkwDLDaXxP6AB/leTsEVgY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZLz+A3oW04veRzkP1nIhIr6IfePDMkG0O3qmT6tZszN4Knng5F5HXNtCleLTwGf1e
         HZjxE6LZOnraY7H3JxjNYKbgKqlYsMJB/VllfUGE6fykhB5FEwqtO691xEks08Obf6
         Wpp2PkyDB/v1+CISoUr2Q4w26q3weiqQTRkqmyRIuep3B4c+WUvkEBV2aRqv4ZMKbd
         SUoPQtCNxS1nh0GBdh984eIvjWsHlIllQ7K9xYVafvF936VgPda0CpptWB6aNPUKQQ
         Pi2UPyVBsPwguCC4ldHfxDFSs6XINUy0UsQo4df8ntzyF1g0Hm25TZ7XdqZPtDglhQ
         MTN9pi4WozCzQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch implements set_cs_timing SPI controller method to allow
SPI client driver to configure device specific SPI CS timings.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 48 ++++++++++++++++++++++++++++++++++++++++++++--
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
2.7.4

