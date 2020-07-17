Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CEE22348E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 08:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGQGap (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 02:30:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:14777 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgGQGao (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:44 -0400
IronPort-SDR: NtQocaUb8ZTzaxmIBHmzryjmGNOv822ocx87tlAc4QYaAT2W2NtxlukfNH7zoh76QelLbU6yWD
 rXYT/iIf03pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129628429"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129628429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:44 -0700
IronPort-SDR: wsBwZc/2namRn+PPDuqc4THcPhz1vdIhKRRfQ7j1dzVpMK1p1n9wiUJ2XxxFHy3Io/X6eyqHLB
 PaTsyjreFr1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="317262869"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2020 23:30:41 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 5/8] spi: lantiq: Add fifo size bit mask in SoC specific data structure
Date:   Fri, 17 Jul 2020 14:27:54 +0800
Message-Id: <a0889abf17a9fbc7077f10be0f0342b7ebdf9361.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On newer chipsets, SPI controller has fifos of larger size.
So add the fifo size bit mask entry in SoC specific data structure.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index cbe019f995999..a0d1f82d309f9 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -59,9 +59,7 @@
 #define LTQ_SPI_CLC_DISR	BIT(0)	/* Disable request bit */
 
 #define LTQ_SPI_ID_TXFS_S	24	/* Implemented TX FIFO size */
-#define LTQ_SPI_ID_TXFS_M	(0x3F << LTQ_SPI_ID_TXFS_S)
 #define LTQ_SPI_ID_RXFS_S	16	/* Implemented RX FIFO size */
-#define LTQ_SPI_ID_RXFS_M	(0x3F << LTQ_SPI_ID_RXFS_S)
 #define LTQ_SPI_ID_MOD_S	8	/* Module ID */
 #define LTQ_SPI_ID_MOD_M	(0xff << LTQ_SPI_ID_MOD_S)
 #define LTQ_SPI_ID_CFG_S	5	/* DMA interface support */
@@ -124,19 +122,15 @@
 					 LTQ_SPI_WHBSTATE_CLRTUE)
 
 #define LTQ_SPI_RXFCON_RXFITL_S	8	/* FIFO interrupt trigger level */
-#define LTQ_SPI_RXFCON_RXFITL_M	(0x3F << LTQ_SPI_RXFCON_RXFITL_S)
 #define LTQ_SPI_RXFCON_RXFLU	BIT(1)	/* FIFO flush */
 #define LTQ_SPI_RXFCON_RXFEN	BIT(0)	/* FIFO enable */
 
 #define LTQ_SPI_TXFCON_TXFITL_S	8	/* FIFO interrupt trigger level */
-#define LTQ_SPI_TXFCON_TXFITL_M	(0x3F << LTQ_SPI_TXFCON_TXFITL_S)
 #define LTQ_SPI_TXFCON_TXFLU	BIT(1)	/* FIFO flush */
 #define LTQ_SPI_TXFCON_TXFEN	BIT(0)	/* FIFO enable */
 
 #define LTQ_SPI_FSTAT_RXFFL_S	0
-#define LTQ_SPI_FSTAT_RXFFL_M	(0x3f << LTQ_SPI_FSTAT_RXFFL_S)
 #define LTQ_SPI_FSTAT_TXFFL_S	8
-#define LTQ_SPI_FSTAT_TXFFL_M	(0x3f << LTQ_SPI_FSTAT_TXFFL_S)
 
 #define LTQ_SPI_GPOCON_ISCSBN_S	8
 #define LTQ_SPI_GPOCON_INVOUTN_S	0
@@ -162,6 +156,7 @@ struct lantiq_ssc_hwcfg {
 	unsigned int	irncr;
 	unsigned int	irnicr;
 	bool		irq_ack;
+	u32		fifo_size_mask;
 };
 
 struct lantiq_ssc_spi {
@@ -211,16 +206,18 @@ static void lantiq_ssc_maskl(const struct lantiq_ssc_spi *spi, u32 clr,
 
 static unsigned int tx_fifo_level(const struct lantiq_ssc_spi *spi)
 {
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
 	u32 fstat = lantiq_ssc_readl(spi, LTQ_SPI_FSTAT);
 
-	return (fstat & LTQ_SPI_FSTAT_TXFFL_M) >> LTQ_SPI_FSTAT_TXFFL_S;
+	return (fstat >> LTQ_SPI_FSTAT_TXFFL_S) & hwcfg->fifo_size_mask;
 }
 
 static unsigned int rx_fifo_level(const struct lantiq_ssc_spi *spi)
 {
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
 	u32 fstat = lantiq_ssc_readl(spi, LTQ_SPI_FSTAT);
 
-	return fstat & LTQ_SPI_FSTAT_RXFFL_M;
+	return (fstat >> LTQ_SPI_FSTAT_RXFFL_S) & hwcfg->fifo_size_mask;
 }
 
 static unsigned int tx_fifo_free(const struct lantiq_ssc_spi *spi)
@@ -808,6 +805,7 @@ static const struct lantiq_ssc_hwcfg lantiq_ssc_xway = {
 	.irnen_t	= LTQ_SPI_IRNEN_T_XWAY,
 	.irnicr		= 0xF8,
 	.irncr		= 0xFC,
+	.fifo_size_mask	= GENMASK(5, 0),
 	.irq_ack	= false,
 };
 
@@ -816,6 +814,7 @@ static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
 	.irnen_t	= LTQ_SPI_IRNEN_T_XRX,
 	.irnicr		= 0xF8,
 	.irncr		= 0xFC,
+	.fifo_size_mask	= GENMASK(5, 0),
 	.irq_ack	= false,
 };
 
@@ -941,8 +940,8 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	INIT_WORK(&spi->work, lantiq_ssc_bussy_work);
 
 	id = lantiq_ssc_readl(spi, LTQ_SPI_ID);
-	spi->tx_fifo_size = (id & LTQ_SPI_ID_TXFS_M) >> LTQ_SPI_ID_TXFS_S;
-	spi->rx_fifo_size = (id & LTQ_SPI_ID_RXFS_M) >> LTQ_SPI_ID_RXFS_S;
+	spi->tx_fifo_size = (id >> LTQ_SPI_ID_TXFS_S) & hwcfg->fifo_size_mask;
+	spi->rx_fifo_size = (id >> LTQ_SPI_ID_RXFS_S) & hwcfg->fifo_size_mask;
 	supports_dma = (id & LTQ_SPI_ID_CFG_M) >> LTQ_SPI_ID_CFG_S;
 	revision = id & LTQ_SPI_ID_REV_M;
 
-- 
2.11.0

