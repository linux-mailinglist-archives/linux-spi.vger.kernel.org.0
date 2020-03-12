Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4019E1837C8
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 18:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCLRjM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 13:39:12 -0400
Received: from foss.arm.com ([217.140.110.172]:38898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgCLRjL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 13:39:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC03FEC;
        Thu, 12 Mar 2020 10:39:11 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931EE3F6CF;
        Thu, 12 Mar 2020 10:39:10 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:39:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: meson-spicc: setup IO line delay" to the spi tree
In-Reply-To:  <20200312133131.26430-7-narmstrong@baylibre.com>
Message-Id:  <applied-20200312133131.26430-7-narmstrong@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: meson-spicc: setup IO line delay

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From f27bff479ea3de9ca325d4f8e8c8b49a87d6b0c5 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 12 Mar 2020 14:31:28 +0100
Subject: [PATCH] spi: meson-spicc: setup IO line delay

Now the controller can support frequencies higher than 30MHz, we need
the setup the I/O line delays in regard of the SPI clock frequency.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200312133131.26430-7-narmstrong@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 61 ++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index b5bd3a897e8f..4494a791f4a7 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -106,7 +106,21 @@
 #define SPICC_SWAP_RO		BIT(14) /* RX FIFO Data Swap Read-Only */
 #define SPICC_SWAP_W1		BIT(15) /* RX FIFO Data Swap Write-Only */
 #define SPICC_DLYCTL_RO_MASK	GENMASK(20, 15) /* Delay Control Read-Only */
-#define SPICC_DLYCTL_W1_MASK	GENMASK(21, 16) /* Delay Control Write-Only */
+#define SPICC_MO_DELAY_MASK	GENMASK(17, 16) /* Master Output Delay */
+#define SPICC_MO_NO_DELAY	0
+#define SPICC_MO_DELAY_1_CYCLE	1
+#define SPICC_MO_DELAY_2_CYCLE	2
+#define SPICC_MO_DELAY_3_CYCLE	3
+#define SPICC_MI_DELAY_MASK	GENMASK(19, 18) /* Master Input Delay */
+#define SPICC_MI_NO_DELAY	0
+#define SPICC_MI_DELAY_1_CYCLE	1
+#define SPICC_MI_DELAY_2_CYCLE	2
+#define SPICC_MI_DELAY_3_CYCLE	3
+#define SPICC_MI_CAP_DELAY_MASK	GENMASK(21, 20) /* Master Capture Delay */
+#define SPICC_CAP_AHEAD_2_CYCLE	0
+#define SPICC_CAP_AHEAD_1_CYCLE	1
+#define SPICC_CAP_NO_DELAY	2
+#define SPICC_CAP_DELAY_1_CYCLE	3
 #define SPICC_FIFORST_RO_MASK	GENMASK(22, 21) /* FIFO Softreset Read-Only */
 #define SPICC_FIFORST_W1_MASK	GENMASK(23, 22) /* FIFO Softreset Write-Only */
 
@@ -328,6 +342,49 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void meson_spicc_auto_io_delay(struct meson_spicc_device *spicc)
+{
+	u32 div, hz;
+	u32 mi_delay, cap_delay;
+	u32 conf;
+
+	if (spicc->data->has_enhance_clk_div) {
+		div = FIELD_GET(SPICC_ENH_DATARATE_MASK,
+				readl_relaxed(spicc->base + SPICC_ENH_CTL0));
+		div++;
+		div <<= 1;
+	} else {
+		div = FIELD_GET(SPICC_DATARATE_MASK,
+				readl_relaxed(spicc->base + SPICC_CONREG));
+		div += 2;
+		div = 1 << div;
+	}
+
+	mi_delay = SPICC_MI_NO_DELAY;
+	cap_delay = SPICC_CAP_AHEAD_2_CYCLE;
+	hz = clk_get_rate(spicc->clk);
+
+	if (hz >= 100000000)
+		cap_delay = SPICC_CAP_DELAY_1_CYCLE;
+	else if (hz >= 80000000)
+		cap_delay = SPICC_CAP_NO_DELAY;
+	else if (hz >= 40000000)
+		cap_delay = SPICC_CAP_AHEAD_1_CYCLE;
+	else if (div >= 16)
+		mi_delay = SPICC_MI_DELAY_3_CYCLE;
+	else if (div >= 8)
+		mi_delay = SPICC_MI_DELAY_2_CYCLE;
+	else if (div >= 6)
+		mi_delay = SPICC_MI_DELAY_1_CYCLE;
+
+	conf = readl_relaxed(spicc->base + SPICC_TESTREG);
+	conf &= ~(SPICC_MO_DELAY_MASK | SPICC_MI_DELAY_MASK
+		  | SPICC_MI_CAP_DELAY_MASK);
+	conf |= FIELD_PREP(SPICC_MI_DELAY_MASK, mi_delay);
+	conf |= FIELD_PREP(SPICC_MI_CAP_DELAY_MASK, cap_delay);
+	writel_relaxed(conf, spicc->base + SPICC_TESTREG);
+}
+
 static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 				   struct spi_transfer *xfer)
 {
@@ -346,6 +403,8 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 		writel_relaxed(conf, spicc->base + SPICC_CONREG);
 
 	clk_set_rate(spicc->clk, xfer->speed_hz);
+
+	meson_spicc_auto_io_delay(spicc);
 }
 
 static int meson_spicc_transfer_one(struct spi_master *master,
-- 
2.20.1

