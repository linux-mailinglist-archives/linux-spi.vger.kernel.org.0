Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A92120B9
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgGBKOD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:14:03 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:17347 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGBKOC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684841; x=1625220841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vr7IJg82w/CxJvBCjz5G7ZncKTloNcb8/f99H0MqnqE=;
  b=0y0scIz0uiC4PdJLH5CnYABu9bIcUVLz4DoNI2c1Ct8qN7jf/EjsQNA8
   yG1JNNbbz9qNZSPDX/hFzSmoi6/VB3f8Jso/kyf4o2BDvqVQspZkSq3DP
   39PA067yv6zs2jYF+wI3e4NAx1ptVK+HxCZ21Twetf6HXPXKicfQSxqKe
   0geWqsW1cjK3VTiXWoAzFQeDRHhmu0RgKUqV6y5P4f+ngjheRL+4WQWPj
   7AqVoS3VAonc5rIzInatSJJWhGUz10zU2VQByyDv6Hzl//TodsZd6Cqqs
   gsGc/e5f2PsgENUGrPI4fSx2UNHvrrPb3/XgzPtEjXRIog6zffWs1iAK9
   Q==;
IronPort-SDR: r9P6xitf7mpknS7PYsT/BodsBAPnv9DbZwRn9tCvLFXGzbbWX8jXSQmPqfhyHFVy0qld7ucFd7
 k+NtnTHlTT5Q7xqmo/1t9LIG7DujOMbFx00GZu2mB5x/GaDKta5zGZxFCUY/dhW7areNGv2XS2
 sBSM49/XWR6K2QeHiAP2CBdDsoEN9EtDhAkyBOYP01roJ5nsrZzrIJfIWa066dQe9OB6uKktZl
 LyKWVZYL1YpTxpshohYsVc2F6nt0GI59wCcpE912splRoV0GPLPVomC0mP2Ip/noEijsK2FjUn
 hDo=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="80483290"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:13:41 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:13:38 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v3 1/8] spi: dw: Add support for RX sample delay register
Date:   Thu, 2 Jul 2020 12:13:24 +0200
Message-ID: <20200702101331.26375-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702101331.26375-1-lars.povlsen@microchip.com>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
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

The register is controlled by the snps,rx-sample-delay-ns DT
property, which is defined per SPI slave.

The register is located at offset 0xf0, and if the option is not
enabled in the IP, changing the register will have no effect. The
register will only be written if any slave defines a nonzero value
(after scaling by the clock period).

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw-core.c | 20 ++++++++++++++++++++
 drivers/spi/spi-dw.h      |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 323c66c5db506..d249f25cbff7f 100644
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
+	if (dws->curr_rx_sample_dly != chip->rx_sample_dly) {
+		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
+		dws->curr_rx_sample_dly = chip->rx_sample_dly;
+	}
+
 	/* For poll mode just disable all interrupts */
 	spi_mask_intr(dws, 0xff);
 
@@ -380,10 +390,20 @@ static int dw_spi_setup(struct spi_device *spi)
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
+		struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
+		u32 rx_sample_dly;
+
 		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
 		spi_set_ctldata(spi, chip);
+		/* Is rx_sample_dly defined for a slave? */
+		if (device_property_read_u32(&spi->dev,
+					     "snps,rx-sample-delay-ns",
+					     &rx_sample_dly) == 0)
+			chip->rx_sample_dly = DIV_ROUND_CLOSEST(rx_sample_dly,
+								NSEC_PER_SEC /
+								dws->max_freq);
 	}
 
 	chip->tmode = SPI_TMOD_TR;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 151ba316619e6..f9243bf2a662b 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -34,6 +34,7 @@
 #define DW_SPI_IDR			0x58
 #define DW_SPI_VERSION			0x5c
 #define DW_SPI_DR			0x60
+#define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_CS_OVERRIDE		0xf4
 
 /* Bit fields in CTRLR0 */
@@ -140,6 +141,7 @@ struct dw_spi {
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
 	u32			current_freq;	/* frequency in hz */
+	u32			curr_rx_sample_dly;
 
 	/* DMA info */
 	struct dma_chan		*txchan;
-- 
2.27.0

