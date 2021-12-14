Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22BB47438A
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhLNNeP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 08:34:15 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61106 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhLNNeP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 08:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639488854; x=1671024854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Qo4Yoc14KbsmAOOb9NeOHFfHRE1gAjcaSF36Np4U9M=;
  b=fkbSm7SefL0fTH/8ymqR9ZkorjMF8Zk/g6V5XDRmdhpE7BJYLWB/710D
   JY2jmib5gsCYLh3/cE9x1BbyYunBg5cs0+y7YbB0jSQ1/fyYTvRq1YQnM
   JDTw5S+UfJ64Bqv3QBsUMxDPqRDYHujYQSkOKxvVWkx79zxzB+OxH/Zup
   gIIe0+NO+vQSdqueHTmj8w/qCeIfPuJB3YLDldJ5ARXL8pho1bXteyxXg
   xpm4S8i12Q+VQyx1R1odYTEXZo8Q9u1qOC0enTEhOakSdRMrdY2iYJPiQ
   3dcA+g+AKMvamBneB05cBcCxDOi51Vtn1iOZizUOedkxzcImkteunBrC/
   A==;
IronPort-SDR: Zct+yrf3H0+dNcAX1mES2M8i74ZJHnvHdqHkT8A9N+aqQICEbZZB/MeZ5+ybS491w45P46hDA0
 i4m+0EbhTNPMNgs60T8nPYQjexf2X8X8sHuO+NFdMWmIl8qC32VMGdCub8WE9K59gmTqOfHg2F
 zWiBKSHj5BmegfbVjAxlHvdoJ43oLeEzQssmguc/bUm72i1TeRq9HpCjs+267J8xSOIRvVBrj2
 l3vq0Unwjyd1bLFSEXDGcPS7AXXFow62JEtkkL5KPP+VWtCZTuJ7K6LnC34KLaiXxmiyJ3IqGF
 5ldw+P/xts0ESfRG8AWCEDq6
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="147177967"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2021 06:34:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Dec 2021 06:34:13 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 14 Dec 2021 06:34:11 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Date:   Tue, 14 Dec 2021 15:34:04 +0200
Message-ID: <20211214133404.121739-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The sama7g5 QSPI controller uses dedicated clocks for the
QSPI Controller Interface and the QSPI Controller Core, and
requires synchronization before accessing registers or bit
fields.

QSPI_SR.SYNCBSY must be zero before accessing any of the bits:
QSPI_CR.QSPIEN, QSPI_CR.QSPIDIS, QSPI_CR.SRFRSH, QSPI_CR.SWRST,
QSPI_CR.UPDCFG, QSPI_CR.STTFR, QSPI_CR.RTOUT, QSPI_CR.LASTXFER.

Also, the QSPI controller core configuration can be updated by
writing the QSPI_CR.UPDCFG bit to ‘1’. This is needed by the
following registers: QSPI_MR, QSPI_SCR, QSPI_IAR, QSPI_WICR,
QSPI_IFR, QSPI_RICR, QSPI_SMR, QSPI_SKR,QSPI_REFRESH, QSPI_WRACNT
QSPI_PCALCFG.

The Octal SPI supports frequencies up to 200 MHZ DDR. The need
for output impedance calibration arises. To avoid the degradation
of the signal quality, a PAD calibration cell is used to adjust
the output impedance to the driven I/Os.

The transmission flow requires different sequences for setting
the configuration and for the actual transfer, than what is in
the sama5d2 and sam9x60 versions of the IP. Different interrupts
are handled. aq->ops->set_cfg() and aq->ops->transfer() are
introduced to help differentiating the flows.

Tested single and octal SPI mode with mx66lm1g45g.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 921 ++++++++++++++++++++++++++++++++++--
 1 file changed, 869 insertions(+), 52 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 92d9610df1fd..8980a729dd53 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -11,11 +11,15 @@
  * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescale.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -33,6 +37,7 @@
 #define QSPI_IDR     0x0018  /* Interrupt Disable Register */
 #define QSPI_IMR     0x001c  /* Interrupt Mask Register */
 #define QSPI_SCR     0x0020  /* Serial Clock Register */
+#define QSPI_SR2     0x0024  /* SAMA7G5 Status Register */
 
 #define QSPI_IAR     0x0030  /* Instruction Address Register */
 #define QSPI_ICR     0x0034  /* Instruction Code Register */
@@ -43,16 +48,32 @@
 #define QSPI_SMR     0x0040  /* Scrambling Mode Register */
 #define QSPI_SKR     0x0044  /* Scrambling Key Register */
 
+#define QSPI_REFRESH	0x0050	/* Refresh Register */
+#define QSPI_WRACNT	0x0054	/* Write Access Counter Register */
+#define QSPI_DLLCFG	0x0058	/* DLL Configuration Register */
+#define QSPI_PCALCFG	0x005C	/* Pad Calibration Configuration Register */
+#define QSPI_PCALBP	0x0060	/* Pad Calibration Bypass Register */
+#define QSPI_TOUT	0x0064	/* Timeout Register */
+
 #define QSPI_WPMR    0x00E4  /* Write Protection Mode Register */
 #define QSPI_WPSR    0x00E8  /* Write Protection Status Register */
 
 #define QSPI_VERSION 0x00FC  /* Version Register */
 
+#define SAMA7G5_QSPI0_MAX_SPEED_HZ	200000000
+#define SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ	133000000
 
 /* Bitfields in QSPI_CR (Control Register) */
 #define QSPI_CR_QSPIEN                  BIT(0)
 #define QSPI_CR_QSPIDIS                 BIT(1)
+#define QSPI_CR_DLLON			BIT(2)
+#define QSPI_CR_DLLOFF			BIT(3)
+#define QSPI_CR_STPCAL			BIT(4)
+#define QSPI_CR_SRFRSH			BIT(5)
 #define QSPI_CR_SWRST                   BIT(7)
+#define QSPI_CR_UPDCFG			BIT(8)
+#define QSPI_CR_STTFR			BIT(9)
+#define QSPI_CR_RTOUT			BIT(10)
 #define QSPI_CR_LASTXFER                BIT(24)
 
 /* Bitfields in QSPI_MR (Mode Register) */
@@ -60,12 +81,14 @@
 #define QSPI_MR_LLB                     BIT(1)
 #define QSPI_MR_WDRBT                   BIT(2)
 #define QSPI_MR_SMRM                    BIT(3)
+#define QSPI_MR_DQSDLYEN		BIT(3)
 #define QSPI_MR_CSMODE_MASK             GENMASK(5, 4)
 #define QSPI_MR_CSMODE_NOT_RELOADED     (0 << 4)
 #define QSPI_MR_CSMODE_LASTXFER         (1 << 4)
 #define QSPI_MR_CSMODE_SYSTEMATICALLY   (2 << 4)
 #define QSPI_MR_NBBITS_MASK             GENMASK(11, 8)
 #define QSPI_MR_NBBITS(n)               ((((n) - 8) << 8) & QSPI_MR_NBBITS_MASK)
+#define QSPI_MR_OENSD			BIT(15)
 #define QSPI_MR_DLYBCT_MASK             GENMASK(23, 16)
 #define QSPI_MR_DLYBCT(n)               (((n) << 16) & QSPI_MR_DLYBCT_MASK)
 #define QSPI_MR_DLYCS_MASK              GENMASK(31, 24)
@@ -79,6 +102,13 @@
 #define QSPI_SR_CSR                     BIT(8)
 #define QSPI_SR_CSS                     BIT(9)
 #define QSPI_SR_INSTRE                  BIT(10)
+#define QSPI_SR_LWRA			BIT(11)
+#define QSPI_SR_QITF			BIT(12)
+#define QSPI_SR_QITR			BIT(13)
+#define QSPI_SR_CSFA			BIT(14)
+#define QSPI_SR_CSRA			BIT(15)
+#define QSPI_SR_RFRSHD			BIT(16)
+#define QSPI_SR_TOUT			BIT(17)
 #define QSPI_SR_QSPIENS                 BIT(24)
 
 #define QSPI_SR_CMD_COMPLETED	(QSPI_SR_INSTRE | QSPI_SR_CSR)
@@ -91,9 +121,22 @@
 #define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
 #define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK)
 
+/* Bitfields in QSPI_SR2 (SAMA7G5 Status Register) */
+#define QSPI_SR2_SYNCBSY		BIT(0)
+#define QSPI_SR2_QSPIENS		BIT(1)
+#define QSPI_SR2_CSS			BIT(2)
+#define QSPI_SR2_RBUSY			BIT(3)
+#define QSPI_SR2_HIDLE			BIT(4)
+#define QSPI_SR2_DLOCK			BIT(5)
+#define QSPI_SR2_CALBSY			BIT(6)
+
+/* Bitfields in QSPI_IAR (Instruction Address Register) */
+#define QSPI_IAR_ADDR			GENMASK(31, 0)
+
 /* Bitfields in QSPI_ICR (Read/Write Instruction Code Register) */
 #define QSPI_ICR_INST_MASK              GENMASK(7, 0)
 #define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MASK)
+#define QSPI_ICR_INST_MASK_SAMA7G5	GENMASK(15, 0)
 #define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
 #define QSPI_ICR_OPT(opt)               (((opt) << 16) & QSPI_ICR_OPT_MASK)
 
@@ -106,6 +149,9 @@
 #define QSPI_IFR_WIDTH_QUAD_IO          (4 << 0)
 #define QSPI_IFR_WIDTH_DUAL_CMD         (5 << 0)
 #define QSPI_IFR_WIDTH_QUAD_CMD         (6 << 0)
+#define QSPI_IFR_WIDTH_OCT_OUTPUT	(7 << 0)
+#define QSPI_IFR_WIDTH_OCT_IO		(8 << 0)
+#define QSPI_IFR_WIDTH_OCT_CMD		(9 << 0)
 #define QSPI_IFR_INSTEN                 BIT(4)
 #define QSPI_IFR_ADDREN                 BIT(5)
 #define QSPI_IFR_OPTEN                  BIT(6)
@@ -116,19 +162,60 @@
 #define QSPI_IFR_OPTL_4BIT              (2 << 8)
 #define QSPI_IFR_OPTL_8BIT              (3 << 8)
 #define QSPI_IFR_ADDRL                  BIT(10)
+#define QSPI_IFR_ADDRL_SAMA7G5		GENMASK(11, 10)
 #define QSPI_IFR_TFRTYP_MEM		BIT(12)
 #define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)
 #define QSPI_IFR_CRM                    BIT(14)
+#define QSPI_IFR_DDREN			BIT(15)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
+#define QSPI_IFR_END			BIT(22)
+#define QSPI_IFR_SMRM			BIT(23)
 #define QSPI_IFR_APBTFRTYP_READ		BIT(24)	/* Defined in SAM9X60 */
+#define QSPI_IFR_DQSEN			BIT(25)
+#define QSPI_IFR_DDRCMDEN		BIT(26)
+#define QSPI_IFR_HFWBEN			BIT(27)
+#define QSPI_IFR_PROTTYP		GENMASK(29, 28)
+#define QSPI_IFR_PROTTYP_STD_SPI	0
+#define QSPI_IFR_PROTTYP_TWIN_QUAD	1
+#define QSPI_IFR_PROTTYP_OCTAFLASH	2
+#define QSPI_IFR_PROTTYP_HYPERFLASH	3
 
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
 #define QSPI_SMR_RVDIS                  BIT(1)
+#define QSPI_SMR_SCRKL                  BIT(2)
+
+/* Bitfields in QSPI_REFRESH (Refresh Register) */
+#define QSPI_REFRESH_DELAY_COUNTER	GENMASK(31, 0)
+
+/* Bitfields in QSPI_WRACNT (Write Access Counter Register) */
+#define QSPI_WRACNT_NBWRA		GENMASK(31, 0)
+
+/* Bitfields in QSPI_DLLCFG (DLL Configuration Register) */
+#define QSPI_DLLCFG_RANGE		BIT(0)
+
+/* Bitfields in QSPI_PCALCFG (DLL Pad Calibration Configuration Register) */
+#define QSPI_PCALCFG_AAON		BIT(0)
+#define QSPI_PCALCFG_DAPCAL		BIT(1)
+#define QSPI_PCALCFG_DIFFPM		BIT(2)
+#define QSPI_PCALCFG_CLKDIV		GENMASK(6, 4)
+#define QSPI_PCALCFG_CALCNT		GENMASK(16, 8)
+#define QSPI_PCALCFG_CALP		GENMASK(27, 24)
+#define QSPI_PCALCFG_CALN		GENMASK(31, 28)
+
+/* Bitfields in QSPI_PCALBP (DLL Pad Calibration Bypass Register) */
+#define QSPI_PCALBP_BPEN		BIT(0)
+#define QSPI_PCALBP_CALPBP		GENMASK(11, 8)
+#define QSPI_PCALBP_CALNBP		GENMASK(19, 16)
+
+/* Bitfields in QSPI_TOUT (Timeout Register) */
+#define QSPI_TOUT_TCNTM			GENMASK(15, 0)
 
 /* Bitfields in QSPI_WPMR (Write Protection Mode Register) */
 #define QSPI_WPMR_WPEN                  BIT(0)
+#define QSPI_WPMR_WPITEN		BIT(1)
+#define QSPI_WPMR_WPCREN		BIT(2)
 #define QSPI_WPMR_WPKEY_MASK            GENMASK(31, 8)
 #define QSPI_WPMR_WPKEY(wpkey)          (((wpkey) << 8) & QSPI_WPMR_WPKEY_MASK)
 
@@ -137,23 +224,74 @@
 #define QSPI_WPSR_WPVSRC_MASK           GENMASK(15, 8)
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
 
+#define ATMEL_QSPI_TIMEOUT		1000	/* ms */
+#define ATMEL_QSPI_SYNC_TIMEOUT		300	/* ms */
+#define QSPI_DLLCFG_THRESHOLD_FREQ	90000000U
+#define QSPI_CALIB_TIME			2000	/* 2 us */
+
+/* Use PIO for small transfers. */
+#define ATMEL_QSPI_DMA_MIN_BYTES	16
+/**
+ * struct atmel_qspi_pcal - Pad Calibration Clock Division
+ * @pclk_rate: peripheral clock rate.
+ * @pclkdiv: calibration clock division. The clock applied to the calibration
+ *           cell is divided by pclkdiv + 1.
+ */
+struct atmel_qspi_pcal {
+	u32 pclk_rate;
+	u8 pclk_div;
+};
+
+#define ATMEL_QSPI_PCAL_ARRAY_SIZE	8
+static const struct atmel_qspi_pcal pcal[ATMEL_QSPI_PCAL_ARRAY_SIZE] = {
+	{25000000, 0},
+	{50000000, 1},
+	{75000000, 2},
+	{100000000, 3},
+	{125000000, 4},
+	{150000000, 5},
+	{175000000, 6},
+	{200000000, 7},
+};
+
 struct atmel_qspi_caps {
+	u32 max_speed_hz;
 	bool has_qspick;
+	bool has_gclk;
 	bool has_ricr;
+	bool octal;
+	bool has_dma;
 };
 
+struct atmel_qspi_ops;
+
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
 	struct clk		*pclk;
 	struct clk		*qspick;
+	struct clk		*gclk;
 	struct platform_device	*pdev;
 	const struct atmel_qspi_caps *caps;
+	const struct atmel_qspi_ops *ops;
 	resource_size_t		mmap_size;
 	u32			pending;
+	u32			irq_mask;
 	u32			mr;
 	u32			scr;
+	u32			slave_max_speed_hz;
 	struct completion	cmd_completion;
+	struct completion	dma_completion;
+	dma_addr_t		mmap_phys_base;
+	struct dma_chan		*rx_chan;
+	struct dma_chan		*tx_chan;
+};
+
+struct atmel_qspi_ops {
+	int (*set_cfg)(struct atmel_qspi *aq, const struct spi_mem_op *op,
+		       u32 *offset);
+	int (*transfer)(struct spi_mem *mem, const struct spi_mem_op *op,
+			u32 offset);
 };
 
 struct atmel_qspi_mode {
@@ -173,6 +311,19 @@ static const struct atmel_qspi_mode atmel_qspi_modes[] = {
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
 
+static const struct atmel_qspi_mode atmel_qspi_sama7g5_modes[] = {
+	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
+	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
+	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
+	{ 1, 2, 2, QSPI_IFR_WIDTH_DUAL_IO },
+	{ 1, 4, 4, QSPI_IFR_WIDTH_QUAD_IO },
+	{ 2, 2, 2, QSPI_IFR_WIDTH_DUAL_CMD },
+	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
+	{ 1, 1, 8, QSPI_IFR_WIDTH_OCT_OUTPUT },
+	{ 1, 8, 8, QSPI_IFR_WIDTH_OCT_IO },
+	{ 8, 8, 8, QSPI_IFR_WIDTH_OCT_CMD },
+};
+
 #ifdef VERBOSE_DEBUG
 static const char *atmel_qspi_reg_name(u32 offset, char *tmp, size_t sz)
 {
@@ -195,6 +346,8 @@ static const char *atmel_qspi_reg_name(u32 offset, char *tmp, size_t sz)
 		return "IMR";
 	case QSPI_SCR:
 		return "SCR";
+	case QSPI_SR2:
+		return "SR2";
 	case QSPI_IAR:
 		return "IAR";
 	case QSPI_ICR:
@@ -207,6 +360,18 @@ static const char *atmel_qspi_reg_name(u32 offset, char *tmp, size_t sz)
 		return "SMR";
 	case QSPI_SKR:
 		return "SKR";
+	case QSPI_REFRESH:
+		return "REFRESH";
+	case QSPI_WRACNT:
+		return "WRACNT";
+	case QSPI_DLLCFG:
+		return "DLLCFG";
+	case QSPI_PCALCFG:
+		return "PCALCFG";
+	case QSPI_PCALBP:
+		return "PCALBP";
+	case QSPI_TOUT:
+		return "TOUT";
 	case QSPI_WPMR:
 		return "WPMR";
 	case QSPI_WPSR:
@@ -274,9 +439,29 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 	return -ENOTSUPP;
 }
 
+static int atmel_qspi_sama7g5_find_mode(const struct spi_mem_op *op)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(atmel_qspi_sama7g5_modes); i++)
+		if (atmel_qspi_is_compatible(op, &atmel_qspi_sama7g5_modes[i]))
+			return i;
+
+	return -EOPNOTSUPP;
+}
+
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+
+	if (aq->caps->octal) {
+		if (atmel_qspi_sama7g5_find_mode(op) < 0)
+			return false;
+		else
+			return true;
+	}
+
 	if (atmel_qspi_find_mode(op) < 0)
 		return false;
 
@@ -406,56 +591,365 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	return 0;
 }
 
-static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int atmel_qspi_wait_for_completion(struct atmel_qspi *aq, u32 irq_mask)
 {
-	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
-	u32 sr, offset;
-	int err;
+	int err = 0;
+	u32 sr;
+
+	/* Poll INSTRuction End status */
+	sr = atmel_qspi_read(aq, QSPI_SR);
+	if ((sr & irq_mask) == irq_mask)
+		return 0;
+
+	/* Wait for INSTRuction End interrupt */
+	reinit_completion(&aq->cmd_completion);
+	aq->pending = sr & irq_mask;
+	aq->irq_mask = irq_mask;
+	atmel_qspi_write(irq_mask, aq, QSPI_IER);
+	if (!wait_for_completion_timeout(&aq->cmd_completion,
+					 msecs_to_jiffies(ATMEL_QSPI_TIMEOUT)))
+		err = -ETIMEDOUT;
+	atmel_qspi_write(irq_mask, aq, QSPI_IDR);
+
+	return err;
+}
+
+static int atmel_qspi_transfer(struct spi_mem *mem,
+			       const struct spi_mem_op *op, u32 offset)
+{
+	struct atmel_qspi *aq =
+		spi_controller_get_devdata(mem->spi->controller);
+
+	if (!op->data.nbytes)
+		return atmel_qspi_wait_for_completion(aq,
+						      QSPI_SR_CMD_COMPLETED);
+
+	/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
+	(void)atmel_qspi_read(aq, QSPI_IFR);
+
+	/* Send/Receive data */
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		memcpy_fromio(op->data.buf.in, aq->mem + offset,
+			      op->data.nbytes);
+	else
+		memcpy_toio(aq->mem + offset, op->data.buf.out,
+			    op->data.nbytes);
+
+	/* Release the chip-select */
+	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
+
+	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CMD_COMPLETED);
+}
+
+static int atmel_qspi_reg_sync(struct atmel_qspi *aq)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 !(val & QSPI_SR2_SYNCBSY), 40,
+				 ATMEL_QSPI_SYNC_TIMEOUT);
+	return ret;
+}
+
+static int atmel_qspi_update_config(struct atmel_qspi *aq)
+{
+	int ret;
+
+	ret = atmel_qspi_reg_sync(aq);
+	if (ret)
+		return ret;
+	atmel_qspi_write(QSPI_CR_UPDCFG, aq, QSPI_CR);
+	return atmel_qspi_reg_sync(aq);
+}
+
+static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
+				      const struct spi_mem_op *op, u32 *offset)
+{
+	u32 iar, icr, ifr;
+	int mode, ret;
+
+	iar = 0;
+	icr = FIELD_PREP(QSPI_ICR_INST_MASK_SAMA7G5, op->cmd.opcode);
+	ifr = QSPI_IFR_INSTEN;
+
+	mode = atmel_qspi_sama7g5_find_mode(op);
+	if (mode < 0)
+		return mode;
+	ifr |= atmel_qspi_sama7g5_modes[mode].config;
+
+	if (op->dummy.buswidth && op->dummy.nbytes) {
+		if (op->addr.dtr && op->dummy.dtr && op->data.dtr)
+			ifr |= QSPI_IFR_NBDUM(op->dummy.nbytes * 8 /
+					      (2 * op->dummy.buswidth));
+		else
+			ifr |= QSPI_IFR_NBDUM(op->dummy.nbytes * 8 /
+					      op->dummy.buswidth);
+	}
+
+	if (op->addr.buswidth && op->addr.nbytes) {
+		ifr |= FIELD_PREP(QSPI_IFR_ADDRL_SAMA7G5, op->addr.nbytes - 1) |
+		       QSPI_IFR_ADDREN;
+		iar = FIELD_PREP(QSPI_IAR_ADDR, op->addr.val);
+	}
+
+	if (op->addr.dtr && op->dummy.dtr && op->data.dtr) {
+		ifr |= QSPI_IFR_DDREN;
+		if (op->cmd.dtr)
+			ifr |= QSPI_IFR_DDRCMDEN;
+
+		ifr |= QSPI_IFR_DQSEN;
+	}
+
+	if (op->cmd.buswidth == 8 || op->addr.buswidth == 8 ||
+	    op->data.buswidth == 8)
+		ifr |= FIELD_PREP(QSPI_IFR_PROTTYP, QSPI_IFR_PROTTYP_OCTAFLASH);
+
+	/* offset of the data access in the QSPI memory space */
+	*offset = iar;
+
+	/* Set data enable */
+	if (op->data.nbytes) {
+		ifr |= QSPI_IFR_DATAEN;
+
+		if (op->addr.nbytes)
+			ifr |= QSPI_IFR_TFRTYP_MEM;
+	}
 
 	/*
-	 * Check if the address exceeds the MMIO window size. An improvement
-	 * would be to add support for regular SPI mode and fall back to it
-	 * when the flash memories overrun the controller's memory space.
+	 * If the QSPI controller is set in regular SPI mode, set it in
+	 * Serial Memory Mode (SMM).
 	 */
-	if (op->addr.val + op->data.nbytes > aq->mmap_size)
-		return -ENOTSUPP;
+	if (aq->mr != QSPI_MR_SMM) {
+		atmel_qspi_write(QSPI_MR_SMM | QSPI_MR_DQSDLYEN, aq, QSPI_MR);
+		aq->mr = QSPI_MR_SMM;
 
-	err = atmel_qspi_set_cfg(aq, op, &offset);
-	if (err)
-		return err;
+		ret = atmel_qspi_update_config(aq);
+		if (ret)
+			return ret;
+	}
 
-	/* Skip to the final steps if there is no data */
-	if (op->data.nbytes) {
-		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)atmel_qspi_read(aq, QSPI_IFR);
+	/* Clear pending interrupts */
+	(void)atmel_qspi_read(aq, QSPI_SR);
 
-		/* Send/Receive data */
-		if (op->data.dir == SPI_MEM_DATA_IN)
+	/* Set QSPI Instruction Frame registers */
+	if (op->addr.nbytes && !op->data.nbytes)
+		atmel_qspi_write(iar, aq, QSPI_IAR);
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		atmel_qspi_write(icr, aq, QSPI_RICR);
+	} else {
+		atmel_qspi_write(icr, aq, QSPI_WICR);
+		if (op->data.nbytes)
+			atmel_qspi_write(FIELD_PREP(QSPI_WRACNT_NBWRA,
+						    op->data.nbytes),
+					 aq, QSPI_WRACNT);
+	}
+
+	atmel_qspi_write(ifr, aq, QSPI_IFR);
+
+	return atmel_qspi_update_config(aq);
+}
+
+static void atmel_qspi_dma_callback(void *param)
+{
+	struct atmel_qspi *aq = param;
+
+	complete(&aq->dma_completion);
+}
+
+static int atmel_qspi_dma_xfer(struct atmel_qspi *aq, struct dma_chan *chan,
+			       dma_addr_t dma_dst, dma_addr_t dma_src,
+			       unsigned int len)
+{
+	struct dma_async_tx_descriptor *tx;
+	dma_cookie_t cookie;
+	int ret;
+
+	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx) {
+		dev_err(&aq->pdev->dev, "device_prep_dma_memcpy error\n");
+		return -EIO;
+	}
+
+	reinit_completion(&aq->dma_completion);
+	tx->callback = atmel_qspi_dma_callback;
+	tx->callback_param = aq;
+	cookie = tx->tx_submit(tx);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(&aq->pdev->dev, "dma_submit_error %d\n", cookie);
+		return ret;
+	}
+
+	dma_async_issue_pending(chan);
+	ret = wait_for_completion_timeout(&aq->dma_completion,
+					  msecs_to_jiffies(20 * ATMEL_QSPI_TIMEOUT));
+	if (ret == 0) {
+		dmaengine_terminate_sync(chan);
+		dev_err(&aq->pdev->dev, "DMA wait_for_completion_timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int atmel_qspi_dma_rx_xfer(struct spi_mem *mem,
+				  const struct spi_mem_op *op,
+				  struct sg_table *sgt, loff_t loff)
+{
+	struct atmel_qspi *aq =
+		spi_controller_get_devdata(mem->spi->controller);
+	struct scatterlist *sg;
+	dma_addr_t dma_src;
+	unsigned int i, len;
+	int ret;
+
+	dma_src = aq->mmap_phys_base + loff;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		len = sg_dma_len(sg);
+		ret = atmel_qspi_dma_xfer(aq, aq->rx_chan, sg_dma_address(sg),
+					  dma_src, len);
+		if (ret)
+			return ret;
+		dma_src += len;
+	}
+
+	return 0;
+}
+
+static int atmel_qspi_dma_tx_xfer(struct spi_mem *mem,
+				  const struct spi_mem_op *op,
+				  struct sg_table *sgt, loff_t loff)
+{
+	struct atmel_qspi *aq =
+		spi_controller_get_devdata(mem->spi->controller);
+	struct scatterlist *sg;
+	dma_addr_t dma_dst;
+	unsigned int i, len;
+	int ret;
+
+	dma_dst = aq->mmap_phys_base + loff;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		len = sg_dma_len(sg);
+		ret = atmel_qspi_dma_xfer(aq, aq->tx_chan, dma_dst,
+					  sg_dma_address(sg), len);
+		if (ret)
+			return ret;
+		dma_dst += len;
+	}
+
+	return 0;
+}
+
+static int atmel_qspi_dma_transfer(struct spi_mem *mem,
+				   const struct spi_mem_op *op, loff_t loff)
+{
+	struct sg_table sgt;
+	int ret;
+
+	ret = spi_controller_dma_map_mem_op_data(mem->spi->controller, op,
+						 &sgt);
+	if (ret)
+		return ret;
+
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		ret = atmel_qspi_dma_rx_xfer(mem, op, &sgt, loff);
+	else
+		ret = atmel_qspi_dma_tx_xfer(mem, op, &sgt, loff);
+
+	spi_controller_dma_unmap_mem_op_data(mem->spi->controller, op, &sgt);
+
+	return ret;
+}
+
+static int atmel_qspi_sama7g5_transfer(struct spi_mem *mem,
+				       const struct spi_mem_op *op, u32 offset)
+{
+	struct atmel_qspi *aq =
+		spi_controller_get_devdata(mem->spi->controller);
+	u32 val;
+	int ret;
+
+	if (!op->data.nbytes) {
+		/* Start the transfer. */
+		ret = atmel_qspi_reg_sync(aq);
+		if (ret)
+			return ret;
+		atmel_qspi_write(QSPI_CR_STTFR, aq, QSPI_CR);
+
+		return atmel_qspi_wait_for_completion(aq, QSPI_SR_CSRA);
+	}
+
+	/* Send/Receive data. */
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (aq->rx_chan && op->addr.nbytes &&
+		    op->data.nbytes > ATMEL_QSPI_DMA_MIN_BYTES) {
+			ret = atmel_qspi_dma_transfer(mem, op, offset);
+			if (ret)
+				return ret;
+		} else {
 			memcpy_fromio(op->data.buf.in, aq->mem + offset,
 				      op->data.nbytes);
-		else
+		}
+
+		if (op->addr.nbytes) {
+			ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+						 !(val & QSPI_SR2_RBUSY), 40,
+						 ATMEL_QSPI_SYNC_TIMEOUT);
+			if (ret)
+				return ret;
+		}
+	} else {
+		if (aq->tx_chan && op->addr.nbytes &&
+		    op->data.nbytes > ATMEL_QSPI_DMA_MIN_BYTES) {
+			ret = atmel_qspi_dma_transfer(mem, op, offset);
+			if (ret)
+				return ret;
+		} else {
 			memcpy_toio(aq->mem + offset, op->data.buf.out,
 				    op->data.nbytes);
+		}
 
-		/* Release the chip-select */
-		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
+		ret = atmel_qspi_wait_for_completion(aq, QSPI_SR_LWRA);
+		if (ret)
+			return ret;
 	}
 
-	/* Poll INSTRuction End status */
-	sr = atmel_qspi_read(aq, QSPI_SR);
-	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
-		return err;
+	/* Release the chip-select. */
+	ret = atmel_qspi_reg_sync(aq);
+	if (ret)
+		return ret;
+	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
 
-	/* Wait for INSTRuction End interrupt */
-	reinit_completion(&aq->cmd_completion);
-	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IER);
-	if (!wait_for_completion_timeout(&aq->cmd_completion,
-					 msecs_to_jiffies(1000)))
-		err = -ETIMEDOUT;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IDR);
+	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CSRA);
+}
 
-	return err;
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	u32 offset;
+	int err;
+
+	/*
+	 * Check if the address exceeds the MMIO window size. An improvement
+	 * would be to add support for regular SPI mode and fall back to it
+	 * when the flash memories overrun the controller's memory space.
+	 */
+	if (op->addr.val + op->data.nbytes > aq->mmap_size)
+		return -EOPNOTSUPP;
+
+	if (op->addr.nbytes > 4)
+		return -EOPNOTSUPP;
+
+	err = aq->ops->set_cfg(aq, op, &offset);
+	if (err)
+		return err;
+
+	return aq->ops->transfer(mem, op, offset);
 }
 
 static const char *atmel_qspi_get_name(struct spi_mem *spimem)
@@ -469,6 +963,160 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
 	.get_name = atmel_qspi_get_name
 };
 
+static int atmel_qspi_set_pad_calibration(struct atmel_qspi *aq)
+{
+	unsigned long pclk_rate;
+	u32 status, val;
+	int i, ret;
+	u8 pclk_div = 0;
+
+	pclk_rate = clk_get_rate(aq->pclk);
+	if (!pclk_rate)
+		return -EINVAL;
+
+	for (i = 0; i < ATMEL_QSPI_PCAL_ARRAY_SIZE; i++) {
+		if (pclk_rate <= pcal[i].pclk_rate) {
+			pclk_div = pcal[i].pclk_div;
+			break;
+		}
+	}
+
+	/*
+	 * Use the biggest divider in case the peripheral clock exceeds
+	 * 200MHZ.
+	 */
+	if (pclk_rate > pcal[ATMEL_QSPI_PCAL_ARRAY_SIZE - 1].pclk_rate)
+		pclk_div = pcal[ATMEL_QSPI_PCAL_ARRAY_SIZE - 1].pclk_div;
+
+	/* Disable QSPI while configuring the pad calibration. */
+	status = atmel_qspi_read(aq, QSPI_SR2);
+	if (status & QSPI_SR2_QSPIENS) {
+		ret = atmel_qspi_reg_sync(aq);
+		if (ret)
+			return ret;
+		atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
+	}
+
+	/*
+	 * The analog circuitry is not shut down at the end of the calibration
+	 * and the start-up time is only required for the first calibration
+	 * sequence, thus increasing performance. Set the delay between the Pad
+	 * calibration analog circuitry and the calibration request to 2us.
+	 */
+	atmel_qspi_write(QSPI_PCALCFG_AAON |
+			 FIELD_PREP(QSPI_PCALCFG_CLKDIV, pclk_div) |
+			 FIELD_PREP(QSPI_PCALCFG_CALCNT,
+				    2 * (pclk_rate / 1000000)),
+			 aq, QSPI_PCALCFG);
+
+	/* DLL On + start calibration. */
+	atmel_qspi_write(QSPI_CR_DLLON | QSPI_CR_STPCAL, aq, QSPI_CR);
+
+	/* Check synchronization status before updating configuration. */
+	ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				  (val & QSPI_SR2_DLOCK) &&
+				  !(val & QSPI_SR2_CALBSY), 40,
+				  ATMEL_QSPI_TIMEOUT);
+
+	/* Refresh analogic blocks every 1 ms.*/
+	atmel_qspi_write(FIELD_PREP(QSPI_REFRESH_DELAY_COUNTER,
+				    aq->slave_max_speed_hz / 1000),
+			 aq, QSPI_REFRESH);
+
+	return ret;
+}
+
+static int atmel_qspi_set_gclk(struct atmel_qspi *aq)
+{
+	u32 status, val;
+	int ret;
+
+	/* Disable DLL before setting GCLK */
+	status = atmel_qspi_read(aq, QSPI_SR2);
+	if (status & QSPI_SR2_DLOCK) {
+		atmel_qspi_write(QSPI_CR_DLLOFF, aq, QSPI_CR);
+
+		ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+					 !(val & QSPI_SR2_DLOCK), 40,
+					 ATMEL_QSPI_TIMEOUT);
+		if (ret)
+			return ret;
+	}
+
+	if (aq->slave_max_speed_hz > QSPI_DLLCFG_THRESHOLD_FREQ)
+		atmel_qspi_write(QSPI_DLLCFG_RANGE, aq, QSPI_DLLCFG);
+	else
+		atmel_qspi_write(0, aq, QSPI_DLLCFG);
+
+	ret = clk_set_rate(aq->gclk, aq->slave_max_speed_hz);
+	if (ret) {
+		dev_err(&aq->pdev->dev, "Failed to set generic clock rate.\n");
+		return ret;
+	}
+
+	/* Enable the QSPI generic clock */
+	ret = clk_prepare_enable(aq->gclk);
+	if (ret)
+		dev_err(&aq->pdev->dev, "Failed to enable generic clock.\n");
+
+	return ret;
+}
+
+static int atmel_qspi_sama7g5_init(struct atmel_qspi *aq)
+{
+	u32 val;
+	int ret;
+
+	ret = atmel_qspi_set_gclk(aq);
+	if (ret)
+		return ret;
+
+	if (aq->caps->octal) {
+		ret = atmel_qspi_set_pad_calibration(aq);
+		if (ret)
+			return ret;
+	} else {
+		atmel_qspi_write(QSPI_CR_DLLON, aq, QSPI_CR);
+		ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
+					  (val & QSPI_SR2_DLOCK), 40,
+					  ATMEL_QSPI_TIMEOUT);
+	}
+
+	/* Set the QSPI controller by default in Serial Memory Mode */
+	atmel_qspi_write(QSPI_MR_SMM | QSPI_MR_DQSDLYEN, aq, QSPI_MR);
+	aq->mr = QSPI_MR_SMM;
+	ret = atmel_qspi_update_config(aq);
+	if (ret)
+		return ret;
+
+	/* Enable the QSPI controller. */
+	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 val & QSPI_SR2_QSPIENS, 40,
+				 ATMEL_QSPI_SYNC_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (aq->caps->octal) {
+		ret = readl_poll_timeout(aq->regs + QSPI_SR, val,
+					 val & QSPI_SR_RFRSHD, 40,
+					 ATMEL_QSPI_TIMEOUT);
+	}
+
+	atmel_qspi_write(QSPI_TOUT_TCNTM, aq, QSPI_TOUT);
+	return ret;
+}
+
+static int atmel_qspi_sama7g5_setup(struct spi_device *spi)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(spi->controller);
+
+	/* The controller can communicate with a single slave. */
+	aq->slave_max_speed_hz = spi->max_speed_hz;
+
+	return atmel_qspi_sama7g5_init(aq);
+}
+
 static int atmel_qspi_setup(struct spi_device *spi)
 {
 	struct spi_controller *ctrl = spi->master;
@@ -482,6 +1130,9 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
+	if (aq->caps->has_gclk)
+		return atmel_qspi_sama7g5_setup(spi);
+
 	src_rate = clk_get_rate(aq->pclk);
 	if (!src_rate)
 		return -EINVAL;
@@ -497,8 +1148,18 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void atmel_qspi_init(struct atmel_qspi *aq)
+static int atmel_qspi_init(struct atmel_qspi *aq)
 {
+	int ret;
+
+	if (aq->caps->has_gclk) {
+		ret = atmel_qspi_reg_sync(aq);
+		if (ret)
+			return ret;
+		atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
+		return 0;
+	}
+
 	/* Reset the QSPI controller */
 	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
@@ -508,6 +1169,7 @@ static void atmel_qspi_init(struct atmel_qspi *aq)
 
 	/* Enable the QSPI controller */
 	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
+	return 0;
 }
 
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
@@ -523,12 +1185,65 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	aq->pending |= pending;
-	if ((aq->pending & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
+	if ((aq->pending & aq->irq_mask) == aq->irq_mask)
 		complete(&aq->cmd_completion);
 
 	return IRQ_HANDLED;
 }
 
+static int atmel_qspi_dma_init(struct spi_controller *ctrl)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	int ret;
+
+	aq->rx_chan = dma_request_chan(&aq->pdev->dev, "rx");
+	if (IS_ERR(aq->rx_chan)) {
+		aq->rx_chan = NULL;
+		return dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->rx_chan),
+				     "RX DMA channel is not available\n");
+	}
+
+	aq->tx_chan = dma_request_chan(&aq->pdev->dev, "tx");
+	if (IS_ERR(aq->tx_chan)) {
+		ret = dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->tx_chan),
+				    "TX DMA channel is not available\n");
+		goto release_rx_chan;
+	}
+
+	ctrl->dma_rx = aq->rx_chan;
+	ctrl->dma_tx = aq->tx_chan;
+	init_completion(&aq->dma_completion);
+
+	dev_info(&aq->pdev->dev, "Using %s (tx) and %s (rx) for DMA transfers\n",
+		 dma_chan_name(aq->tx_chan), dma_chan_name(aq->rx_chan));
+
+	return 0;
+
+release_rx_chan:
+	dma_release_channel(aq->rx_chan);
+	aq->rx_chan = NULL;
+	aq->tx_chan = NULL;
+	return ret;
+}
+
+static void atmel_qspi_dma_release(struct atmel_qspi *aq)
+{
+	if (aq->rx_chan)
+		dma_release_channel(aq->rx_chan);
+	if (aq->tx_chan)
+		dma_release_channel(aq->tx_chan);
+}
+
+static const struct atmel_qspi_ops atmel_qspi_ops = {
+	.set_cfg = atmel_qspi_set_cfg,
+	.transfer = atmel_qspi_transfer,
+};
+
+static const struct atmel_qspi_ops atmel_qspi_sama7g5_ops = {
+	.set_cfg = atmel_qspi_sama7g5_set_cfg,
+	.transfer = atmel_qspi_sama7g5_transfer,
+};
+
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
@@ -540,7 +1255,27 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (!ctrl)
 		return -ENOMEM;
 
+	aq = spi_controller_get_devdata(ctrl);
+
+	aq->caps = of_device_get_match_data(&pdev->dev);
+	if (!aq->caps) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		return -EINVAL;
+	}
+
+	init_completion(&aq->cmd_completion);
+	aq->pdev = pdev;
+
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
+	if (aq->caps->octal)
+		ctrl->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
+
+	if (aq->caps->has_gclk)
+		aq->ops = &atmel_qspi_sama7g5_ops;
+	else
+		aq->ops = &atmel_qspi_ops;
+
+	ctrl->max_speed_hz = aq->caps->max_speed_hz;
 	ctrl->setup = atmel_qspi_setup;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &atmel_qspi_mem_ops;
@@ -548,11 +1283,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	ctrl->dev.of_node = pdev->dev.of_node;
 	platform_set_drvdata(pdev, ctrl);
 
-	aq = spi_controller_get_devdata(ctrl);
-
-	init_completion(&aq->cmd_completion);
-	aq->pdev = pdev;
-
 	/* Map the registers */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
 	aq->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -570,6 +1300,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	}
 
 	aq->mmap_size = resource_size(res);
+	aq->mmap_phys_base = (dma_addr_t)res->start;
 
 	/* Get the peripheral clock */
 	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
@@ -588,13 +1319,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	aq->caps = of_device_get_match_data(&pdev->dev);
-	if (!aq->caps) {
-		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
-		err = -EINVAL;
-		goto disable_pclk;
-	}
-
 	if (aq->caps->has_qspick) {
 		/* Get the QSPI system clock */
 		aq->qspick = devm_clk_get(&pdev->dev, "qspick");
@@ -611,27 +1335,46 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 				"failed to enable the QSPI system clock\n");
 			goto disable_pclk;
 		}
+	} else if (aq->caps->has_gclk) {
+		/* Get the QSPI generic clock */
+		aq->gclk = devm_clk_get(&pdev->dev, "gclk");
+		if (IS_ERR(aq->gclk)) {
+			dev_err(&pdev->dev, "missing Generic clock\n");
+			err = PTR_ERR(aq->gclk);
+			goto disable_pclk;
+		}
+	}
+
+	if (aq->caps->has_dma) {
+		err = atmel_qspi_dma_init(ctrl);
+		if (err == -EPROBE_DEFER)
+			goto disable_qspick;
 	}
 
 	/* Request the IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		err = irq;
-		goto disable_qspick;
+		goto dma_release;
 	}
 	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
 	if (err)
-		goto disable_qspick;
+		goto dma_release;
 
-	atmel_qspi_init(aq);
+	err = atmel_qspi_init(aq);
+	if (err)
+		goto dma_release;
 
 	err = spi_register_controller(ctrl);
 	if (err)
-		goto disable_qspick;
+		goto dma_release;
 
 	return 0;
 
+dma_release:
+	if (aq->caps->has_dma)
+		atmel_qspi_dma_release(aq);
 disable_qspick:
 	clk_disable_unprepare(aq->qspick);
 disable_pclk:
@@ -640,15 +1383,61 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int atmel_qspi_sama7g5_suspend(struct atmel_qspi *aq)
+{
+	int ret;
+	u32 val;
+
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 !(val & QSPI_SR2_RBUSY) &&
+				 (val & QSPI_SR2_HIDLE), 40,
+				 ATMEL_QSPI_SYNC_TIMEOUT);
+	if (ret)
+		return ret;
+
+	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 !(val & QSPI_SR2_QSPIENS), 40,
+				 ATMEL_QSPI_SYNC_TIMEOUT);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(aq->gclk);
+
+	atmel_qspi_write(QSPI_CR_DLLOFF, aq, QSPI_CR);
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 !(val & QSPI_SR2_DLOCK), 40,
+				 ATMEL_QSPI_TIMEOUT);
+	if (ret)
+		return ret;
+
+	ret =  readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				  !(val & QSPI_SR2_CALBSY), 40,
+				  ATMEL_QSPI_TIMEOUT);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(aq->pclk);
+	return 0;
+}
+
 static int atmel_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl = platform_get_drvdata(pdev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
 	spi_unregister_controller(ctrl);
+
+	if (aq->caps->has_gclk)
+		return atmel_qspi_sama7g5_suspend(aq);
+
+	if (aq->caps->has_dma)
+		atmel_qspi_dma_release(aq);
+
 	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
+
 	return 0;
 }
 
@@ -657,6 +1446,9 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
+	if (aq->caps->has_gclk)
+		return atmel_qspi_sama7g5_suspend(aq);
+
 	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
@@ -670,6 +1462,9 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
 	clk_prepare_enable(aq->pclk);
+	if (aq->caps->has_gclk)
+		return atmel_qspi_sama7g5_init(aq);
+
 	clk_prepare_enable(aq->qspick);
 
 	atmel_qspi_init(aq);
@@ -689,6 +1484,19 @@ static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
 	.has_ricr = true,
 };
 
+static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
+	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
+	.has_gclk = true,
+	.octal = true,
+	.has_dma = true,
+};
+
+static const struct atmel_qspi_caps atmel_sama7g5_qspi_caps = {
+	.max_speed_hz = SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ,
+	.has_gclk = true,
+	.has_dma = true,
+};
+
 static const struct of_device_id atmel_qspi_dt_ids[] = {
 	{
 		.compatible = "atmel,sama5d2-qspi",
@@ -698,6 +1506,15 @@ static const struct of_device_id atmel_qspi_dt_ids[] = {
 		.compatible = "microchip,sam9x60-qspi",
 		.data = &atmel_sam9x60_qspi_caps,
 	},
+	{
+		.compatible = "microchip,sama7g5-ospi",
+		.data = &atmel_sama7g5_ospi_caps,
+	},
+	{
+		.compatible = "microchip,sama7g5-qspi",
+		.data = &atmel_sama7g5_qspi_caps,
+	},
+
 	{ /* sentinel */ }
 };
 
-- 
2.25.1

