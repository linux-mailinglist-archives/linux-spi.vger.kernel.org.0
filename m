Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BED253345
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHZPPc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 11:15:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:41664 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgHZPPc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:32 -0400
IronPort-SDR: Mc1icyIUWW7WJ1HQgtXptb8pnjyBWr6NiXtoBKeibw0NurnAkm75Lv6eKITmEh7kMAfMGXScOM
 FLGvaaYvI/5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="155567494"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="155567494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:15:17 -0700
IronPort-SDR: 4wwYB7wZXM2pER7/7/fPkUkFlBYqFGUawYPXhPsUKv02SMV+P4StjDkiXERDHPNX5d6a+dMZ/x
 SIqsqtzqP5dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="331814079"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 08:15:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1B6CF2; Wed, 26 Aug 2020 18:14:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] spi: pxa2xx: Switch to use BIT() and GENMASK() in pxa2xx_ssp.h
Date:   Wed, 26 Aug 2020 18:14:54 +0300
Message-Id: <20200826151455.55970-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826151455.55970-1-andriy.shevchenko@linux.intel.com>
References: <20200826151455.55970-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch pxa2xx_ssp.h header to use BIT() and GENMASK().
It's better to read and understand. While here, correct ordering
of some definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h | 150 ++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index f139e049e52e..223a4673f0c8 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -16,6 +16,7 @@
 #ifndef __LINUX_SSP_H
 #define __LINUX_SSP_H
 
+#include <linux/bits.h>
 #include <linux/compiler_types.h>
 #include <linux/io.h>
 #include <linux/kconfig.h>
@@ -48,130 +49,127 @@ struct device_node;
 #define SSACDD		(0x40)	/* SSP Audio Clock Dither Divider */
 
 /* Common PXA2xx bits first */
-#define SSCR0_DSS	(0x0000000f)	/* Data Size Select (mask) */
+#define SSCR0_DSS	GENMASK(3, 0)	/* Data Size Select (mask) */
 #define SSCR0_DataSize(x)  ((x) - 1)	/* Data Size Select [4..16] */
-#define SSCR0_FRF	(0x00000030)	/* FRame Format (mask) */
+#define SSCR0_FRF	GENMASK(5, 4)	/* FRame Format (mask) */
 #define SSCR0_Motorola	(0x0 << 4)	/* Motorola's Serial Peripheral Interface (SPI) */
 #define SSCR0_TI	(0x1 << 4)	/* Texas Instruments' Synchronous Serial Protocol (SSP) */
 #define SSCR0_National	(0x2 << 4)	/* National Microwire */
-#define SSCR0_ECS	(1 << 6)	/* External clock select */
-#define SSCR0_SSE	(1 << 7)	/* Synchronous Serial Port Enable */
+#define SSCR0_ECS	BIT(6)		/* External clock select */
+#define SSCR0_SSE	BIT(7)		/* Synchronous Serial Port Enable */
 #define SSCR0_SCR(x)	((x) << 8)	/* Serial Clock Rate (mask) */
 
 /* PXA27x, PXA3xx */
-#define SSCR0_EDSS	(1 << 20)	/* Extended data size select */
-#define SSCR0_NCS	(1 << 21)	/* Network clock select */
-#define SSCR0_RIM	(1 << 22)	/* Receive FIFO overrrun interrupt mask */
-#define SSCR0_TUM	(1 << 23)	/* Transmit FIFO underrun interrupt mask */
-#define SSCR0_FRDC	(0x07000000)	/* Frame rate divider control (mask) */
+#define SSCR0_EDSS	BIT(20)		/* Extended data size select */
+#define SSCR0_NCS	BIT(21)		/* Network clock select */
+#define SSCR0_RIM	BIT(22)		/* Receive FIFO overrrun interrupt mask */
+#define SSCR0_TUM	BIT(23)		/* Transmit FIFO underrun interrupt mask */
+#define SSCR0_FRDC	GENMASK(26, 24)	/* Frame rate divider control (mask) */
 #define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)	/* Time slots per frame [1..8] */
-#define SSCR0_FPCKE	(1 << 29)	/* FIFO packing enable */
-#define SSCR0_ACS	(1 << 30)	/* Audio clock select */
-#define SSCR0_MOD	(1 << 31)	/* Mode (normal or network) */
-
-
-#define SSCR1_RIE	(1 << 0)	/* Receive FIFO Interrupt Enable */
-#define SSCR1_TIE	(1 << 1)	/* Transmit FIFO Interrupt Enable */
-#define SSCR1_LBM	(1 << 2)	/* Loop-Back Mode */
-#define SSCR1_SPO	(1 << 3)	/* Motorola SPI SSPSCLK polarity setting */
-#define SSCR1_SPH	(1 << 4)	/* Motorola SPI SSPSCLK phase setting */
-#define SSCR1_MWDS	(1 << 5)	/* Microwire Transmit Data Size */
-
-#define SSSR_ALT_FRM_MASK	3	/* Masks the SFRM signal number */
-#define SSSR_TNF	(1 << 2)	/* Transmit FIFO Not Full */
-#define SSSR_RNE	(1 << 3)	/* Receive FIFO Not Empty */
-#define SSSR_BSY	(1 << 4)	/* SSP Busy */
-#define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
-#define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
-#define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
+#define SSCR0_FPCKE	BIT(29)		/* FIFO packing enable */
+#define SSCR0_ACS	BIT(30)		/* Audio clock select */
+#define SSCR0_MOD	BIT(31)		/* Mode (normal or network) */
+
+#define SSCR1_RIE	BIT(0)		/* Receive FIFO Interrupt Enable */
+#define SSCR1_TIE	BIT(1)		/* Transmit FIFO Interrupt Enable */
+#define SSCR1_LBM	BIT(2)		/* Loop-Back Mode */
+#define SSCR1_SPO	BIT(3)		/* Motorola SPI SSPSCLK polarity setting */
+#define SSCR1_SPH	BIT(4)		/* Motorola SPI SSPSCLK phase setting */
+#define SSCR1_MWDS	BIT(5)		/* Microwire Transmit Data Size */
+
+#define SSSR_ALT_FRM_MASK	GENMASK(1, 0)	/* Masks the SFRM signal number */
+#define SSSR_TNF		BIT(2)		/* Transmit FIFO Not Full */
+#define SSSR_RNE		BIT(3)		/* Receive FIFO Not Empty */
+#define SSSR_BSY		BIT(4)		/* SSP Busy */
+#define SSSR_TFS		BIT(5)		/* Transmit FIFO Service Request */
+#define SSSR_RFS		BIT(6)		/* Receive FIFO Service Request */
+#define SSSR_ROR		BIT(7)		/* Receive FIFO Overrun */
 
 #define RX_THRESH_DFLT	8
 #define TX_THRESH_DFLT	8
 
-#define SSSR_TFL_MASK	(0xf << 8)	/* Transmit FIFO Level mask */
-#define SSSR_RFL_MASK	(0xf << 12)	/* Receive FIFO Level mask */
+#define SSSR_TFL_MASK	GENMASK(11, 8)	/* Transmit FIFO Level mask */
+#define SSSR_RFL_MASK	GENMASK(15, 12)	/* Receive FIFO Level mask */
 
-#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
+#define SSCR1_TFT	GENMASK(9, 6)	/* Transmit FIFO Threshold (mask) */
 #define SSCR1_TxTresh(x) (((x) - 1) << 6)	/* level [1..16] */
-#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
+#define SSCR1_RFT	GENMASK(13, 10)	/* Receive FIFO Threshold (mask) */
 #define SSCR1_RxTresh(x) (((x) - 1) << 10)	/* level [1..16] */
 
 #define RX_THRESH_CE4100_DFLT	2
 #define TX_THRESH_CE4100_DFLT	2
 
-#define CE4100_SSSR_TFL_MASK	(0x3 << 8)	/* Transmit FIFO Level mask */
-#define CE4100_SSSR_RFL_MASK	(0x3 << 12)	/* Receive FIFO Level mask */
+#define CE4100_SSSR_TFL_MASK	GENMASK(9, 8)	/* Transmit FIFO Level mask */
+#define CE4100_SSSR_RFL_MASK	GENMASK(13, 12)	/* Receive FIFO Level mask */
 
-#define CE4100_SSCR1_TFT	(0x000000c0)	/* Transmit FIFO Threshold (mask) */
+#define CE4100_SSCR1_TFT	GENMASK(7, 6)	/* Transmit FIFO Threshold (mask) */
 #define CE4100_SSCR1_TxTresh(x) (((x) - 1) << 6)	/* level [1..4] */
-#define CE4100_SSCR1_RFT	(0x00000c00)	/* Receive FIFO Threshold (mask) */
+#define CE4100_SSCR1_RFT	GENMASK(11, 10)	/* Receive FIFO Threshold (mask) */
 #define CE4100_SSCR1_RxTresh(x) (((x) - 1) << 10)	/* level [1..4] */
 
 /* QUARK_X1000 SSCR0 bit definition */
-#define QUARK_X1000_SSCR0_DSS		(0x1F << 0)	/* Data Size Select (mask) */
+#define QUARK_X1000_SSCR0_DSS		GENMASK(4, 0)	/* Data Size Select (mask) */
 #define QUARK_X1000_SSCR0_DataSize(x)	((x) - 1)	/* Data Size Select [4..32] */
-#define QUARK_X1000_SSCR0_FRF		(0x3 << 5)	/* FRame Format (mask) */
+#define QUARK_X1000_SSCR0_FRF		GENMASK(6, 5)	/* FRame Format (mask) */
 #define QUARK_X1000_SSCR0_Motorola	(0x0 << 5)	/* Motorola's Serial Peripheral Interface (SPI) */
 
 #define RX_THRESH_QUARK_X1000_DFLT	1
 #define TX_THRESH_QUARK_X1000_DFLT	16
 
-#define QUARK_X1000_SSSR_TFL_MASK	(0x1F << 8)	/* Transmit FIFO Level mask */
-#define QUARK_X1000_SSSR_RFL_MASK	(0x1F << 13)	/* Receive FIFO Level mask */
+#define QUARK_X1000_SSSR_TFL_MASK	GENMASK(12, 8)	/* Transmit FIFO Level mask */
+#define QUARK_X1000_SSSR_RFL_MASK	GENMASK(17, 13)	/* Receive FIFO Level mask */
 
-#define QUARK_X1000_SSCR1_TFT	(0x1F << 6)	/* Transmit FIFO Threshold (mask) */
+#define QUARK_X1000_SSCR1_TFT	GENMASK(10, 6)	/* Transmit FIFO Threshold (mask) */
 #define QUARK_X1000_SSCR1_TxTresh(x) (((x) - 1) << 6)	/* level [1..32] */
-#define QUARK_X1000_SSCR1_RFT	(0x1F << 11)	/* Receive FIFO Threshold (mask) */
+#define QUARK_X1000_SSCR1_RFT	GENMASK(15, 11)	/* Receive FIFO Threshold (mask) */
 #define QUARK_X1000_SSCR1_RxTresh(x) (((x) - 1) << 11)	/* level [1..32] */
-#define QUARK_X1000_SSCR1_STRF	(1 << 17)	/* Select FIFO or EFWR */
-#define QUARK_X1000_SSCR1_EFWR	(1 << 16)	/* Enable FIFO Write/Read */
+#define QUARK_X1000_SSCR1_EFWR	BIT(16)		/* Enable FIFO Write/Read */
+#define QUARK_X1000_SSCR1_STRF	BIT(17)		/* Select FIFO or EFWR */
 
 /* extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
 #define SSCR0_PSP		(3 << 4)	/* PSP - Programmable Serial Protocol */
-#define SSCR1_TTELP		(1 << 31)	/* TXD Tristate Enable Last Phase */
-#define SSCR1_TTE		(1 << 30)	/* TXD Tristate Enable */
-#define SSCR1_EBCEI		(1 << 29)	/* Enable Bit Count Error interrupt */
-#define SSCR1_SCFR		(1 << 28)	/* Slave Clock free Running */
-#define SSCR1_ECRA		(1 << 27)	/* Enable Clock Request A */
-#define SSCR1_ECRB		(1 << 26)	/* Enable Clock request B */
-#define SSCR1_SCLKDIR		(1 << 25)	/* Serial Bit Rate Clock Direction */
-#define SSCR1_SFRMDIR		(1 << 24)	/* Frame Direction */
-#define SSCR1_RWOT		(1 << 23)	/* Receive Without Transmit */
-#define SSCR1_TRAIL		(1 << 22)	/* Trailing Byte */
-#define SSCR1_TSRE		(1 << 21)	/* Transmit Service Request Enable */
-#define SSCR1_RSRE		(1 << 20)	/* Receive Service Request Enable */
-#define SSCR1_TINTE		(1 << 19)	/* Receiver Time-out Interrupt enable */
-#define SSCR1_PINTE		(1 << 18)	/* Peripheral Trailing Byte Interrupt Enable */
-#define SSCR1_IFS		(1 << 16)	/* Invert Frame Signal */
-#define SSCR1_STRF		(1 << 15)	/* Select FIFO or EFWR */
-#define SSCR1_EFWR		(1 << 14)	/* Enable FIFO Write/Read */
-
-#define SSSR_BCE		(1 << 23)	/* Bit Count Error */
-#define SSSR_CSS		(1 << 22)	/* Clock Synchronisation Status */
-#define SSSR_TUR		(1 << 21)	/* Transmit FIFO Under Run */
-#define SSSR_EOC		(1 << 20)	/* End Of Chain */
-#define SSSR_TINT		(1 << 19)	/* Receiver Time-out Interrupt */
-#define SSSR_PINT		(1 << 18)	/* Peripheral Trailing Byte Interrupt */
 
+#define SSCR1_EFWR		BIT(14)		/* Enable FIFO Write/Read */
+#define SSCR1_STRF		BIT(15)		/* Select FIFO or EFWR */
+#define SSCR1_IFS		BIT(16)		/* Invert Frame Signal */
+#define SSCR1_PINTE		BIT(18)		/* Peripheral Trailing Byte Interrupt Enable */
+#define SSCR1_TINTE		BIT(19)		/* Receiver Time-out Interrupt enable */
+#define SSCR1_RSRE		BIT(20)		/* Receive Service Request Enable */
+#define SSCR1_TSRE		BIT(21)		/* Transmit Service Request Enable */
+#define SSCR1_TRAIL		BIT(22)		/* Trailing Byte */
+#define SSCR1_RWOT		BIT(23)		/* Receive Without Transmit */
+#define SSCR1_SFRMDIR		BIT(24)		/* Frame Direction */
+#define SSCR1_SCLKDIR		BIT(25)		/* Serial Bit Rate Clock Direction */
+#define SSCR1_ECRB		BIT(26)		/* Enable Clock request B */
+#define SSCR1_ECRA		BIT(27)		/* Enable Clock Request A */
+#define SSCR1_SCFR		BIT(28)		/* Slave Clock free Running */
+#define SSCR1_EBCEI		BIT(29)		/* Enable Bit Count Error interrupt */
+#define SSCR1_TTE		BIT(30)		/* TXD Tristate Enable */
+#define SSCR1_TTELP		BIT(31)		/* TXD Tristate Enable Last Phase */
+
+#define SSSR_PINT		BIT(18)		/* Peripheral Trailing Byte Interrupt */
+#define SSSR_TINT		BIT(19)		/* Receiver Time-out Interrupt */
+#define SSSR_EOC		BIT(20)		/* End Of Chain */
+#define SSSR_TUR		BIT(21)		/* Transmit FIFO Under Run */
+#define SSSR_CSS		BIT(22)		/* Clock Synchronisation Status */
+#define SSSR_BCE		BIT(23)		/* Bit Count Error */
 
 #define SSPSP_SCMODE(x)		((x) << 0)	/* Serial Bit Rate Clock Mode */
-#define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
-#define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
+#define SSPSP_SFRMP		BIT(2)		/* Serial Frame Polarity */
+#define SSPSP_ETDS		BIT(3)		/* End of Transfer data State */
 #define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
 #define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
 #define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
 #define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
 #define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
-#define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
+#define SSPSP_FSRT		BIT(25)		/* Frame Sync Relative Timing */
 
 /* PXA3xx */
 #define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
 #define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
 #define SSPSP_TIMING_MASK	(0x7f8001f0)
 
-#define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
-#define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
 #define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
 #define SSACD_ACDS_1		(0)
 #define SSACD_ACDS_2		(1)
@@ -179,14 +177,16 @@ struct device_node;
 #define SSACD_ACDS_8		(3)
 #define SSACD_ACDS_16		(4)
 #define SSACD_ACDS_32		(5)
+#define SSACD_SCDB		BIT(3)		/* SSPSYSCLK Divider Bypass */
 #define SSACD_SCDB_4X		(0)
 #define SSACD_SCDB_1X		(1)
-#define SSACD_SCDX8		(1 << 7)	/* SYSCLK division ratio select */
+#define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
+#define SSACD_SCDX8		BIT(7)		/* SYSCLK division ratio select */
 
 /* LPSS SSP */
 #define SSITF			0x44		/* TX FIFO trigger level */
+#define SSITF_TxHiThresh(x)	(((x) - 1) << 0)
 #define SSITF_TxLoThresh(x)	(((x) - 1) << 8)
-#define SSITF_TxHiThresh(x)	((x) - 1)
 
 #define SSIRF			0x48		/* RX FIFO trigger level */
 #define SSIRF_RxThresh(x)	((x) - 1)
-- 
2.28.0

