Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5401D16C0
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbgEMOAs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:00:48 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62324 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388776AbgEMOAr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378446; x=1620914446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/thRVYUM0XeOw/EsW4JAmGaBkslBy0kyoRiLscrOEs=;
  b=ssTtXH4WHpCYDY1OZjtLyIMl+OWa7ktcyCSoFTGwNIkRl6FANV+NVnc3
   rbWsBez/PaFRaKIMavO2Gk19a/AciCNbGIYuXrvtyIeYDZCFoVnURe5ng
   Qe8EeSM/kHOtcjhS/urYlTPmQXnf9ORDd/FsNsoolUHiDlnopUGtEusXe
   Ml/n+QvlHHGFS0n+dPlbYX3BrFBiykwIRcliezZzkYhfNi9/HA1tYL4bo
   0kNt5l5renDa2/tX4wdwM5AH7LDXSHx5+ADyi4NABCAEfX6p3nu830gJ7
   rMOBYsh404Mr+bUv3wWTlyKvCD89EbgDu2wlvD4slJUL4zkBQdAJmejZk
   A==;
IronPort-SDR: b4JIm4J9WSFX+Pq41qrUtq7qPwNcRI2DslfTJ6HN1XIhRrDlwjYQ6h+E0lYyGenGKe/280HFc5
 j+SD2DVQxlA7pxQFaQrgXpQCQoWC79Jh5osGxD5FTDf5V9+DZRRnwIsYqUpN9Xok3liQl4t4Ki
 Oqtp3Pxf+gbP1xfPuSkvMt3GWYoRuUlBKbBuQe75sbVn3IyGftyHam1KT83nZcPFBGx9w2p+Ee
 cpoqQs2+OiIgB+EQWj5JBRSl4sIHy7aDN7Bdb/RZzhdgo40+gArMhm+fFVdk2jtJg34EzfYhgc
 gSs=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="75774856"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:00:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:00:48 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:43 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 02/10] spi: dw: Add support for RX sample delay register
Date:   Wed, 13 May 2020 16:00:23 +0200
Message-ID: <20200513140031.25633-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
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

The register is located at offset 0xf0, and if the option is not
enabled in the IP, changing the register will have no effect.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw.c | 7 +++++++
 drivers/spi/spi-dw.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index e572eb34a3c1a..32997f28fa5bb 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -81,6 +81,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
 			"DMATDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMATDLR));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"DMARDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMARDLR));
+	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			 "RX_SAMPLE_DLY: \t0x%08x\n",
+			 dw_readl(dws, DW_SPI_RX_SAMPLE_DLY));
 	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
 			"=================================\n");

@@ -315,6 +318,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		spi_set_clk(dws, chip->clk_div);
 	}

+	/* Apply RX sample delay, iff requested (nonzero) */
+	if (dws->rx_sample_dly)
+		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, dws->rx_sample_dly);
+
 	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
 	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 1bf5713e047d3..ed6e47b3f50da 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -31,6 +31,7 @@
 #define DW_SPI_IDR			0x58
 #define DW_SPI_VERSION			0x5c
 #define DW_SPI_DR			0x60
+#define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_CS_OVERRIDE		0xf4

 /* Bit fields in CTRLR0 */
@@ -111,6 +112,7 @@ struct dw_spi {

 	int			cs_override;
 	u32			reg_io_width;	/* DR I/O width in bytes */
+	u8			rx_sample_dly;	/* RX fifo tuning (option) */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
 	void (*set_cs)(struct spi_device *spi, bool enable);
--
2.26.2
