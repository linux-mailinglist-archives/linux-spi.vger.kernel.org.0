Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1144D21B
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhKKG5T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 01:57:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:34073 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbhKKG5S (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 01:57:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230324733"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="230324733"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 22:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="642864908"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 22:54:26 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v3 2/5] spi: dw: Add SSTE support for DWC SSI controller
Date:   Thu, 11 Nov 2021 14:51:58 +0800
Message-Id: <20211111065201.10249-3-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111065201.10249-1-nandhini.srikandan@intel.com>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add support for Slave Select Toggle Enable (SSTE) in DWC SSI controller
via DTS. The slave select line will toggle between consecutive data frames,
with the serial clock being held to its default value while slave
select line is high.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw-core.c | 11 +++++++++++
 drivers/spi/spi-dw.h      |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index a305074c482e..bfa075a4f779 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -27,6 +27,7 @@
 struct chip_data {
 	u32 cr0;
 	u32 rx_sample_dly;	/* RX sample delay */
+	bool sste;		/* Slave select Toggle flag */
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -269,6 +270,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 
 static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 {
+	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = 0;
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
@@ -285,6 +287,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 
 		/* CTRLR0[11] Shift Register Loop */
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
+
+		/* CTRLR0[24] Slave Select Toggle Enable */
+		cr0 |= chip->sste << SPI_SSTE_OFFSET;
 	} else {
 		/* CTRLR0[ 7: 6] Frame Format */
 		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
@@ -300,6 +305,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 		/* CTRLR0[13] Shift Register Loop */
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
 
+		/* CTRLR0[14] Slave Select Toggle Enable */
+		cr0 |= chip->sste << DWC_SSI_CTRLR0_SSTE_OFFSET;
+
 		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
 			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
 	}
@@ -789,6 +797,9 @@ static int dw_spi_setup(struct spi_device *spi)
 		chip->rx_sample_dly = DIV_ROUND_CLOSEST(rx_sample_dly_ns,
 							NSEC_PER_SEC /
 							dws->max_freq);
+
+		/* Get slave select toggling feature requirement */
+		chip->sste = device_property_read_bool(&spi->dev, "snps,sste");
 	}
 
 	/*
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b665e040862c..2ee3f839de39 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -65,8 +65,10 @@
 #define SPI_SLVOE_OFFSET		10
 #define SPI_SRL_OFFSET			11
 #define SPI_CFS_OFFSET			12
+#define SPI_SSTE_OFFSET			24
 
 /* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
+#define DWC_SSI_CTRLR0_SSTE_OFFSET	14
 #define DWC_SSI_CTRLR0_SRL_OFFSET	13
 #define DWC_SSI_CTRLR0_TMOD_OFFSET	10
 #define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)
-- 
2.17.1

