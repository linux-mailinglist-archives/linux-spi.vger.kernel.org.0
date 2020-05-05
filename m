Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EDC1C5656
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgEENHd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 09:07:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:12710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEENHd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 09:07:33 -0400
IronPort-SDR: eoB23/ZNT6Kdfn6eD5CYgEetKpZo/ui/QUuwRhiO5vpw4ZT1YU7/SOdpp4qOZ/Z3DE8y8jeVHi
 WsR08TtKaoUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 06:07:32 -0700
IronPort-SDR: ZJuyGMsTx+0benBMYGFBUnun9CsjN2vkHWrsNmmrTS0C4pRnz/2jOveN0YlG2brRnD9/ohH0M5
 GYDB+XskQ5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="277868854"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2020 06:07:31 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 3/7] spi: dw: Add support for DesignWare DWC_ssi
Date:   Tue,  5 May 2020 21:06:14 +0800
Message-Id: <20200505130618.554-4-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds initial support for DesignWare DWC_ssi soft IP. DWC_ssi is
the enhanced version of DW_apb_ssi, which is currently supported by this
driver. Their registers are same, but the bit fields of register CTRLR0
are different.

DWC_ssi has additional features compared to DW_apb_ssi. Major enhancements
in DWC_ssi are hyper bus protocol, boot mode support and advanced XIP
support. DWC_ssi is an AHB slave device, whilst DW_apb_ssi is an APB slave
device.

Register offset
                DW_ssi          DW_apb_ssi
CTRLR0          0x00            0x00
CTRLR1          0x04            0x04
SSIENR          0x08            0x08
MWCR            0x0c            0x0c
SER             0x10            0x10
BAUDR           0x14            0x14
TXFTLR          0x18            0x18
RXFTLR          0x1c            0x1c
TXFLR           0x20            0x20
RXFLR           0x24            0x24
SR              0x28            0x28
IMR             0x2c            0x2c
ISR             0x30            0x30
RISR            0x34            0x34
TXOICR          0x38            0x38
RXOICR          0x3c            0x3c
RXUICR          0x40            0x40
MSTICR          0x44            0x44
ICR             0x48            0x48
DMACR           0x4c            0x4c
DMATDLR         0x50            0x50
DMARDLR         0x54            0x54
IDR             0x58            0x58
SSI_VERSION_ID  0x5c            0x5c
DRx (0 to 35)   0x60+i*0x4      0x60+i*0x4
RX_SAMPLE_DLY   0xf0            0xf0
SPI_CTRLR0      0xf4            0xf4
TXD_DRIVE_EDGE  0xf8            0xf8
XIP_MODE_BITS   0xfc            RSVD

Register configuration - CTRLR0
                        DW_ssi          DW_apb_ssi
  SPI_HYPERBUS_EN       bit[24]         NONE
  SPI_FRF               bit[23:22]      bit[22:21]
  DFS_32                NONE            bit[20:16]
  CFS                   bit[19:16]      bit[15:12]
  SSTE                  bit[14]         bit[24]
  SRL                   bit[13]         bit[11]
  SLV_OE                bit[12]         bit[10]
  TMOD                  bit[11:10]      bit[9:8]
  SCPOL | SPHA          bit[9:8]        bit[7:6]
  FRF                   bit[7:6]        bit[5:4]
  DFS                   bit[4:0]        bit[3:0]

The documents used are
[1] DW_apb_ssi_databook.pdf version 4.01a (2016.10a).
[2] DWC_ssi_databook.pdf version 1.01a.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 10 ++++++++++
 drivers/spi/spi-dw.c      | 33 +++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw.h      | 12 ++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a52f75e22109..1df6f3deee2c 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -146,6 +146,15 @@ static int dw_spi_dw_apb_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
+			       struct dw_spi_mmio *dwsmmio)
+{
+	/* Register hook to configure CTRLR0 */
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_v1_01a;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -244,6 +253,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
+	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 4905457641ef..240a61b66a06 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -277,6 +277,39 @@ u32 dw_spi_update_cr0(struct spi_controller *master, struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(dw_spi_update_cr0);
 
+/* Configure CTRLR0 for DWC_ssi */
+u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
+			     struct spi_device *spi,
+			     struct spi_transfer *transfer)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(master);
+	struct chip_data *chip = spi_get_ctldata(spi);
+	u32 cr0;
+
+	/* CTRLR0[ 4: 0] Data Frame Size */
+	cr0 = (transfer->bits_per_word - 1);
+
+	/* CTRLR0[ 7: 6] Frame Format */
+	cr0 |= chip->type << DWC_SSI_CTRLR0_FRF_OFFSET;
+
+	/*
+	 * SPI mode (SCPOL|SCPH)
+	 * CTRLR0[ 8] Serial Clock Phase
+	 * CTRLR0[ 9] Serial Clock Polarity
+	 */
+	cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
+	cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;
+
+	/* CTRLR0[11:10] Transfer Mode */
+	cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
+
+	/* CTRLR0[13] Shift Register Loop */
+	cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
+
+	return cr0;
+}
+EXPORT_SYMBOL_GPL(dw_spi_update_cr0_v1_01a);
+
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2745a7e7405c..8fe724279d15 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -57,6 +57,15 @@
 #define SPI_SRL_OFFSET			11
 #define SPI_CFS_OFFSET			12
 
+/* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
+#define DWC_SSI_CTRLR0_SRL_OFFSET	13
+#define DWC_SSI_CTRLR0_TMOD_OFFSET	10
+#define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)
+#define DWC_SSI_CTRLR0_SCPOL_OFFSET	9
+#define DWC_SSI_CTRLR0_SCPH_OFFSET	8
+#define DWC_SSI_CTRLR0_FRF_OFFSET	6
+#define DWC_SSI_CTRLR0_DFS_OFFSET	0
+
 /* Bit fields in SR, 7 bits */
 #define SR_MASK				0x7f		/* cover 7 bits */
 #define SR_BUSY				(1 << 0)
@@ -245,6 +254,9 @@ extern int dw_spi_resume_host(struct dw_spi *dws);
 extern u32 dw_spi_update_cr0(struct spi_controller *master,
 			     struct spi_device *spi,
 			     struct spi_transfer *transfer);
+extern u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
+				    struct spi_device *spi,
+				    struct spi_transfer *transfer);
 
 /* platform related setup */
 extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
-- 
2.17.1

