Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0677F22C420
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 13:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGXLOZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 07:14:25 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:45266 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgGXLOY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 07:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595589264; x=1627125264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kdnnUfJA3TSa21JJyP6z//+f1nK3wUmHRfNsUPX2Oak=;
  b=oH/3fIzJMvCwcAm6GTa9/vSygMPFuQNdAyzU/68WCufBM8lRZpn3UCh6
   /GX8nhYPFpjcARmC9Dd9O2kr/R/idYG1Cm8OY8Q//Y9DjjQf5v7KQXupd
   MnyBEjS8R5z4G35FveOhsbWyz2/uEckn23JAxsXOpextLCS7vUugJbckf
   SRrIxViS4SLQRzYy263FK4EyFRzF+tmHsWIFSeWqVkG3K+PuItxUKpbzF
   6ZQNsjzrWDohFdYU/Gml59vDED02JDAjlot2yb17hL+da/Vy31Jk7tTwI
   cUC5ZA06FlC1xnODQ1FoFwaHAxjMW9sHaBFKgDp4atcR/NO19DONLlv81
   A==;
IronPort-SDR: /C3Mj8ZKf4QzNT2SXnQBJzsfuUmeOSLJBst7yvDLPY4lP61PCumLJq2cs9SMzYv5rzo96y61NP
 HDbLtSZiC5w71uenoin020UyPgzV3TMx0AXifMyLJgub2mNWXcvnx+u+fcodqSw0skJwwQrr8G
 ZCfcUhViCAKRvJpymPlNmT+6ViN72vruQcucmlN/tROWzQmKG/HLt9V4zZDWzU1NojlIKSH2OI
 LM/PZLUosf8APR2ksW1vlu2pF7tJd11kFOpbSxQm6tGUyac50SFV45QcrRWda+fktK0kSLNcJ5
 LRc=
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="81158351"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2020 04:14:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 04:13:42 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 24 Jul 2020 04:13:40 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v4 1/6] spi: dw: Add support for RX sample delay register
Date:   Fri, 24 Jul 2020 13:13:59 +0200
Message-ID: <20200724111404.13293-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724111404.13293-1-lars.povlsen@microchip.com>
References: <20200724111404.13293-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This add support for the RX_SAMPLE_DLY register. If enabled in the
Designware IP, it allows tuning of the rx data signal by means of an
internal rx sample fifo.

The register is controlled by the rx-sample-delay-ns DT property,
which is defined per SPI slave as well on controller level.

The controller level rx-sample-delay-ns will apply to all slaves
without the property explicitly defined.

The register is located at offset 0xf0, and if the option is not
enabled in the IP, changing the register will have no effect. The
register will only be written if any slave defines a nonzero value
(after scaling by the clock period).

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw-core.c | 26 ++++++++++++++++++++++++++
 drivers/spi/spi-dw.h      |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 323c66c5db506..55afdcee7d2b2 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
 
 #include "spi-dw.h"
 
@@ -26,6 +27,8 @@ struct chip_data {
 
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
+
+	u32 rx_sample_dly;	/* RX sample delay */
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -52,6 +55,7 @@ static const struct debugfs_reg32 dw_spi_dbgfs_regs[] = {
 	DW_SPI_DBGFS_REG("DMACR", DW_SPI_DMACR),
 	DW_SPI_DBGFS_REG("DMATDLR", DW_SPI_DMATDLR),
 	DW_SPI_DBGFS_REG("DMARDLR", DW_SPI_DMARDLR),
+	DW_SPI_DBGFS_REG("RX_SAMPLE_DLY", DW_SPI_RX_SAMPLE_DLY),
 };
 
 static int dw_spi_debugfs_init(struct dw_spi *dws)
@@ -328,6 +332,12 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	if (master->can_dma && master->can_dma(master, spi, transfer))
 		dws->dma_mapped = master->cur_msg_mapped;
 
+	/* Update RX sample delay if required */
+	if (dws->cur_rx_sample_dly != chip->rx_sample_dly) {
+		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
+		dws->cur_rx_sample_dly = chip->rx_sample_dly;
+	}
+
 	/* For poll mode just disable all interrupts */
 	spi_mask_intr(dws, 0xff);
 
@@ -380,10 +390,22 @@ static int dw_spi_setup(struct spi_device *spi)
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
+		struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
+		u32 rx_sample_dly_ns;
+
 		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
 		spi_set_ctldata(spi, chip);
+		/* Get specific / default rx-sample-delay */
+		if (device_property_read_u32(&spi->dev,
+					     "rx-sample-delay-ns",
+					     &rx_sample_dly_ns) != 0)
+			/* Use default controller value */
+			rx_sample_dly_ns = dws->def_rx_sample_dly_ns;
+		chip->rx_sample_dly = DIV_ROUND_CLOSEST(rx_sample_dly_ns,
+							NSEC_PER_SEC /
+							dws->max_freq);
 	}
 
 	chip->tmode = SPI_TMOD_TR;
@@ -472,6 +494,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
+	/* Get default rx sample delay */
+	device_property_read_u32(dev, "rx-sample-delay-ns",
+				 &dws->def_rx_sample_dly_ns);
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 151ba316619e6..90dfd21622d6d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -34,6 +34,7 @@
 #define DW_SPI_IDR			0x58
 #define DW_SPI_VERSION			0x5c
 #define DW_SPI_DR			0x60
+#define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_CS_OVERRIDE		0xf4
 
 /* Bit fields in CTRLR0 */
@@ -140,6 +141,8 @@ struct dw_spi {
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
 	u32			current_freq;	/* frequency in hz */
+	u32			cur_rx_sample_dly;
+	u32			def_rx_sample_dly_ns;
 
 	/* DMA info */
 	struct dma_chan		*txchan;
-- 
2.27.0

