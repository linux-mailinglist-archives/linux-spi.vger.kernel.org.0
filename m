Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2544F09B1
	for <lists+linux-spi@lfdr.de>; Sun,  3 Apr 2022 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358685AbiDCNO5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Apr 2022 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358691AbiDCNO5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Apr 2022 09:14:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ECC10FC5;
        Sun,  3 Apr 2022 06:12:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m18so6124191plx.3;
        Sun, 03 Apr 2022 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DununIeK/0JGzSE7oon4yy1IFvvB5DWyIPUczxoDAJc=;
        b=doN+rD2jAwiNN4hS7e3dAUGLvi/T4pZX5CcV9luAlEwsFHP8LBLznuq0A0H5lQ6Ev8
         ylmvfdBqYYizVDDjaj9waAcAbw/IqjbR9EqxAtnbKK09ThRFXf18X5EIZtNGoPs1vxqB
         7CTe1+cv1roTE58ORl4pfXnKHzE2nW3U1MMridy2lq+VkZstB6M9grMFzouxZaHCbd6E
         TmoHoic88VV/SOghJiNi5j/6pXPYzqURLI3gb4MmozIUq5H0lL/rNCg0FiQa8xPoX0a+
         T/SVZLBVuDgAiEsxOjL5dnZIUMWEPKQYs81/o6gsRgaoplOzF+oTwndOToilZ8f1sDua
         qzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DununIeK/0JGzSE7oon4yy1IFvvB5DWyIPUczxoDAJc=;
        b=kMi4UslF7iwO0rpklTZAScxBnWlhR0I/D/8FrVp/66+qwLqF86zRP29Z/eVIRSBTwW
         yv3Souzm4Hf5lgSIlHOi7CNbSrDEjNsU3XWlqOsJm0eryqCcVva0pktaMKbXv56Kvp3c
         QOsSwEjs+m+uDkMhWcY5Uv4MU0gWBdklX1autrcpSoz2Vda6l5J3WzJXWzxE9cGHjEsO
         x07NxLNbhx4M8mvQIY6+GlW/pziEkN4yj+zEL1gT52Fbp5Nr1HByMMDTSDKWd9wXhgq5
         JcroZb7S5VFB5PbjVevvlOyzJKBLuVEiAA8doGdzzCXZJ7xVziGrl0ev3PUnblqQ8v38
         4nhQ==
X-Gm-Message-State: AOAM533+m/zW+HKk0XQe7c79QkSjgxw0csH9GFvkbKhB5WJZKx3SIx5j
        AGT4MXiDZIf+TJsgx3Sl5y8=
X-Google-Smtp-Source: ABdhPJzPGyTssE/FERSqUikBpHfILzbFM9cR9Hr0eTMfuhcPwkYihZOkLLrg90S01qA3p9EchNGKeA==
X-Received: by 2002:a17:902:cf0d:b0:156:1cc:f08f with SMTP id i13-20020a170902cf0d00b0015601ccf08fmr18904106plg.42.1648991575729;
        Sun, 03 Apr 2022 06:12:55 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id x123-20020a623181000000b004fdf99d25f6sm1554857pfx.80.2022.04.03.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:12:55 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH 2/4] spi: add driver for MTK SPI NAND Flash Interface
Date:   Sun,  3 Apr 2022 21:11:52 +0800
Message-Id: <20220403131154.1267887-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403131154.1267887-1-gch981213@gmail.com>
References: <20220403131154.1267887-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver implements support for the SPI-NAND mode of MTK NAND Flash
Interface as a SPI-MEM controller with piplined ECC capability.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/spi/Kconfig        |   10 +
 drivers/spi/Makefile       |    1 +
 drivers/spi/spi-mtk-snfi.c | 1356 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1367 insertions(+)
 create mode 100644 drivers/spi/spi-mtk-snfi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d2815eb361c0..739eec7d0c15 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -590,6 +590,16 @@ config SPI_MTK_NOR
 	  SPI interface as well as several SPI NOR specific instructions
 	  via SPI MEM interface.
 
+config SPI_MTK_SNFI
+	tristate "MediaTek SPI NAND Flash Interface"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on MTD_NAND_ECC_MEDIATEK
+	help
+	  This enables support for SPI-NAND mode on the MediaTek NAND
+	  Flash Interface found on MediaTek ARM SoCs. This controller
+	  is implemented as a SPI-MEM controller with pipelined ECC
+	  capcability.
+
 config SPI_NPCM_FIU
 	tristate "Nuvoton NPCM FLASH Interface Unit"
 	depends on ARCH_NPCM || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3aa28ed3f761..51541ff17e67 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
 obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
 obj-$(CONFIG_SPI_MT7621)		+= spi-mt7621.o
 obj-$(CONFIG_SPI_MTK_NOR)		+= spi-mtk-nor.o
+obj-$(CONFIG_SPI_MTK_SNFI)		+= spi-mtk-snfi.o
 obj-$(CONFIG_SPI_MXIC)			+= spi-mxic.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NPCM_FIU)		+= spi-npcm-fiu.o
diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
new file mode 100644
index 000000000000..14e96332f11b
--- /dev/null
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -0,0 +1,1356 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for the SPI-NAND mode of Mediatek NAND Flash Interface
+//
+// Copyright (c) 2022 Chuanhong Guo <gch981213@gmail.com>
+//
+// This driver is based on the SPI-NAND mtd driver from Mediatek SDK:
+//
+// Copyright (C) 2020 MediaTek Inc.
+// Author: Weijie Gao <weijie.gao@mediatek.com>
+//
+// This controller organize the page data as several interleaved sectors
+// like the following: (sizeof(FDM + ECC) = snf->nfi_cfg.spare_size)
+// +---------+------+------+---------+------+------+-----+
+// | Sector1 | FDM1 | ECC1 | Sector2 | FDM2 | ECC2 | ... |
+// +---------+------+------+---------+------+------+-----+
+// With auto-format turned on, DMA only returns this part:
+// +---------+---------+-----+
+// | Sector1 | Sector2 | ... |
+// +---------+---------+-----+
+// The FDM data will be filled to the registers, and ECC parity data isn't
+// accessible.
+// With auto-format off, all ((Sector+FDM+ECC)*nsectors) will be read over DMA
+// in it's original order shown in the first table. ECC can't be turned on when
+// auto-format is off.
+//
+// However, Linux SPI-NAND driver expects the data returned as:
+// +------+-----+
+// | Page | OOB |
+// +------+-----+
+// where the page data is continuously stored instead of interleaved.
+// So we assume all instructions matching the page_op template between ECC
+// prepare_io_req and finish_io_req are for page cache r/w.
+// Here's how this spi-mem driver operates when reading:
+//  1. Always set snf->autofmt = true in prepare_io_req (even when ECC is off).
+//  2. Perform page ops and let the controller fill the DMA bounce buffer with
+//     de-interleaved sector data and set FDM registers.
+//  3. Return the data as:
+//     +---------+---------+-----+------+------+-----+
+//     | Sector1 | Sector2 | ... | FDM1 | FDM2 | ... |
+//     +---------+---------+-----+------+------+-----+
+//  4. For other matching spi_mem ops outside a prepare/finish_io_req pair,
+//     read the data with auto-format off into the bounce buffer and copy
+//     needed data to the buffer specified in the request.
+//
+// Write requests operates in a similar manner.
+// As a limitation of this strategy, we won't be able to access any ECC parity
+// data at all in Linux.
+//
+// Here's the bad block mark situation on MTK chips:
+// In older chips like mt7622, MTK uses the first FDM byte in the first sector
+// as the bad block mark. After de-interleaving, this byte appears at [pagesize]
+// in the returned data, which is the BBM position expected by kernel. However,
+// the conventional bad block mark is the first byte of the OOB, which is part
+// of the last sector data in the interleaved layout. Instead of fixing their
+// hardware, MTK decided to address this inconsistency in software. On these
+// later chips, the BootROM expects the following:
+// 1. The [pagesize] byte on a nand page is used as BBM, which will appear at
+//    (page_size - (nsectors - 1) * spare_size) in the DMA buffer.
+// 2. The original byte stored at that position in the DMA buffer will be stored
+//    as the first byte of the FDM section in the last sector.
+// We can't disagree with the BootROM, so after de-interleaving, we need to
+// perform the following swaps in read:
+// 1. Store the BBM at [page_size - (nsectors - 1) * spare_size] to [page_size],
+//    which is the expected BBM position by kernel.
+// 2. Store the page data byte at [pagesize + (nsectors-1) * fdm] back to
+//    [page_size - (nsectors - 1) * spare_size]
+// Similarly, when writing, we need to perform swaps in the other direction.
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/of_platform.h>
+#include <linux/mtd/nand-ecc-mtk.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/mtd/nand.h>
+
+// NFI registers
+#define NFI_CNFG 0x000
+#define CNFG_OP_MODE_S 12
+#define CNFG_OP_MODE_CUST 6
+#define CNFG_OP_MODE_PROGRAM 3
+#define CNFG_AUTO_FMT_EN BIT(9)
+#define CNFG_HW_ECC_EN BIT(8)
+#define CNFG_DMA_BURST_EN BIT(2)
+#define CNFG_READ_MODE BIT(1)
+#define CNFG_DMA_MODE BIT(0)
+
+#define NFI_PAGEFMT 0x0004
+#define NFI_SPARE_SIZE_LS_S 16
+#define NFI_FDM_ECC_NUM_S 12
+#define NFI_FDM_NUM_S 8
+#define NFI_SPARE_SIZE_S 4
+#define NFI_SEC_SEL_512 BIT(2)
+#define NFI_PAGE_SIZE_S 0
+#define NFI_PAGE_SIZE_512_2K 0
+#define NFI_PAGE_SIZE_2K_4K 1
+#define NFI_PAGE_SIZE_4K_8K 2
+#define NFI_PAGE_SIZE_8K_16K 3
+
+#define NFI_CON 0x008
+#define CON_SEC_NUM_S 12
+#define CON_BWR BIT(9)
+#define CON_BRD BIT(8)
+#define CON_NFI_RST BIT(1)
+#define CON_FIFO_FLUSH BIT(0)
+
+#define NFI_INTR_EN 0x010
+#define NFI_INTR_STA 0x014
+#define NFI_IRQ_INTR_EN BIT(31)
+#define NFI_IRQ_CUS_READ BIT(8)
+#define NFI_IRQ_CUS_PG BIT(7)
+
+#define NFI_CMD 0x020
+#define NFI_CMD_DUMMY_READ 0x00
+#define NFI_CMD_DUMMY_WRITE 0x80
+
+#define NFI_STRDATA 0x040
+#define STR_DATA BIT(0)
+
+#define NFI_STA 0x060
+#define NFI_NAND_FSM GENMASK(28, 24)
+#define NFI_FSM GENMASK(19, 16)
+#define READ_EMPTY BIT(12)
+
+#define NFI_FIFOSTA 0x064
+#define FIFO_WR_REMAIN_S 8
+#define FIFO_RD_REMAIN_S 0
+
+#define NFI_ADDRCNTR 0x070
+#define SEC_CNTR GENMASK(16, 12)
+#define SEC_CNTR_S 12
+#define NFI_SEC_CNTR(val) (((val)&SEC_CNTR) >> SEC_CNTR_S)
+
+#define NFI_STRADDR 0x080
+
+#define NFI_BYTELEN 0x084
+#define BUS_SEC_CNTR(val) (((val)&SEC_CNTR) >> SEC_CNTR_S)
+
+#define NFI_FDM0L 0x0a0
+#define NFI_FDM0M 0x0a4
+#define NFI_FDML(n) (NFI_FDM0L + (n)*8)
+#define NFI_FDMM(n) (NFI_FDM0M + (n)*8)
+
+#define NFI_DEBUG_CON1 0x220
+#define WBUF_EN BIT(2)
+
+#define NFI_MASTERSTA 0x224
+#define MAS_ADDR GENMASK(11, 9)
+#define MAS_RD GENMASK(8, 6)
+#define MAS_WR GENMASK(5, 3)
+#define MAS_RDDLY GENMASK(2, 0)
+#define NFI_MASTERSTA_MASK_7622 (MAS_ADDR | MAS_RD | MAS_WR | MAS_RDDLY)
+
+// SNFI registers
+#define SNF_MAC_CTL 0x500
+#define MAC_XIO_SEL BIT(4)
+#define SF_MAC_EN BIT(3)
+#define SF_TRIG BIT(2)
+#define WIP_READY BIT(1)
+#define WIP BIT(0)
+
+#define SNF_MAC_OUTL 0x504
+#define SNF_MAC_INL 0x508
+
+#define SNF_RD_CTL2 0x510
+#define DATA_READ_DUMMY_S 8
+#define DATA_READ_MAX_DUMMY 0xf
+#define DATA_READ_CMD_S 0
+
+#define SNF_RD_CTL3 0x514
+
+#define SNF_PG_CTL1 0x524
+#define PG_LOAD_CMD_S 8
+
+#define SNF_PG_CTL2 0x528
+
+#define SNF_MISC_CTL 0x538
+#define SW_RST BIT(28)
+#define FIFO_RD_LTC_S 25
+#define PG_LOAD_X4_EN BIT(20)
+#define DATA_READ_MODE_S 16
+#define DATA_READ_MODE GENMASK(18, 16)
+#define DATA_READ_MODE_X1 0
+#define DATA_READ_MODE_X2 1
+#define DATA_READ_MODE_X4 2
+#define DATA_READ_MODE_DUAL 5
+#define DATA_READ_MODE_QUAD 6
+#define PG_LOAD_CUSTOM_EN BIT(7)
+#define DATARD_CUSTOM_EN BIT(6)
+#define CS_DESELECT_CYC_S 0
+
+#define SNF_MISC_CTL2 0x53c
+#define PROGRAM_LOAD_BYTE_NUM_S 16
+#define READ_DATA_BYTE_NUM_S 11
+
+#define SNF_DLY_CTL3 0x548
+#define SFCK_SAM_DLY_S 0
+
+#define SNF_STA_CTL1 0x550
+#define CUS_PG_DONE BIT(28)
+#define CUS_READ_DONE BIT(27)
+#define SPI_STATE_S 0
+#define SPI_STATE GENMASK(3, 0)
+
+#define SNF_CFG 0x55c
+#define SPI_MODE BIT(0)
+
+#define SNF_GPRAM 0x800
+#define SNF_GPRAM_SIZE 0xa0
+
+#define SNFI_POLL_INTERVAL 1000000
+
+static const uint8_t mt7622_spare_sizes[] = { 16, 26, 27, 28 };
+
+struct mtk_snand_caps {
+	uint16_t sector_size;
+	uint16_t max_sectors;
+	uint16_t fdm_size;
+	uint16_t fdm_ecc_size;
+	uint16_t fifo_size;
+
+	bool bbm_swap;
+	bool empty_page_check;
+	uint32_t mastersta_mask;
+
+	const uint8_t *spare_sizes;
+	uint32_t num_spare_size;
+};
+
+static const struct mtk_snand_caps mt7622_snand_caps = {
+	.sector_size = 512,
+	.max_sectors = 8,
+	.fdm_size = 8,
+	.fdm_ecc_size = 1,
+	.fifo_size = 32,
+	.bbm_swap = false,
+	.empty_page_check = false,
+	.mastersta_mask = NFI_MASTERSTA_MASK_7622,
+	.spare_sizes = mt7622_spare_sizes,
+	.num_spare_size = ARRAY_SIZE(mt7622_spare_sizes)
+};
+
+static const struct mtk_snand_caps mt7629_snand_caps = {
+	.sector_size = 512,
+	.max_sectors = 8,
+	.fdm_size = 8,
+	.fdm_ecc_size = 1,
+	.fifo_size = 32,
+	.bbm_swap = true,
+	.empty_page_check = false,
+	.mastersta_mask = NFI_MASTERSTA_MASK_7622,
+	.spare_sizes = mt7622_spare_sizes,
+	.num_spare_size = ARRAY_SIZE(mt7622_spare_sizes)
+};
+
+struct mtk_snand_conf {
+	size_t page_size;
+	size_t oob_size;
+	u8 nsectors;
+	u8 spare_size;
+};
+
+struct mtk_snand {
+	struct spi_controller *ctlr;
+	struct device *dev;
+	struct clk *nfi_clk;
+	struct clk *pad_clk;
+	void __iomem *nfi_base;
+	int irq;
+	struct completion op_done;
+	const struct mtk_snand_caps *caps;
+	struct mtk_ecc_config ecc_cfg;
+	struct mtk_ecc *ecc;
+	struct mtk_snand_conf nfi_cfg;
+	struct mtk_ecc_stats ecc_stats;
+	struct nand_ecc_engine ecc_eng;
+	bool autofmt;
+	u8 *buf;
+	dma_addr_t buf_dma;
+	size_t buf_len;
+};
+
+static struct mtk_snand *nand_to_mtk_snand(struct nand_device *nand)
+{
+	struct nand_ecc_engine *eng = nand->ecc.engine;
+
+	return container_of(eng, struct mtk_snand, ecc_eng);
+}
+
+static inline int snand_prepare_bouncebuf(struct mtk_snand *snf, size_t size)
+{
+	if (snf->buf_len >= size)
+		return 0;
+	if (snf->buf)
+		dmam_free_coherent(snf->dev, snf->buf_len, snf->buf,
+				   snf->buf_dma);
+	snf->buf =
+		dmam_alloc_coherent(snf->dev, size, &snf->buf_dma, GFP_KERNEL);
+	if (!snf->buf)
+		return -ENOMEM;
+	snf->buf_len = size;
+	memset(snf->buf, 0xff, snf->buf_len);
+	return 0;
+}
+
+static inline uint32_t nfi_read32(struct mtk_snand *snf, uint32_t reg)
+{
+	return readl(snf->nfi_base + reg);
+}
+
+static inline void nfi_write32(struct mtk_snand *snf, uint32_t reg,
+			       uint32_t val)
+{
+	writel(val, snf->nfi_base + reg);
+}
+
+static inline void nfi_write16(struct mtk_snand *snf, uint32_t reg,
+			       uint16_t val)
+{
+	writew(val, snf->nfi_base + reg);
+}
+
+static inline void nfi_rmw32(struct mtk_snand *snf, uint32_t reg, uint32_t clr,
+			     uint32_t set)
+{
+	uint32_t val;
+
+	val = readl(snf->nfi_base + reg);
+	val &= ~clr;
+	val |= set;
+	writel(val, snf->nfi_base + reg);
+}
+
+static void nfi_read_data(struct mtk_snand *snf, uint32_t reg, uint8_t *data,
+			  uint32_t len)
+{
+	uint32_t i, val = 0, es = sizeof(uint32_t);
+
+	for (i = reg; i < reg + len; i++) {
+		if (i == reg || i % es == 0)
+			val = nfi_read32(snf, i & ~(es - 1));
+
+		*data++ = (uint8_t)(val >> (8 * (i % es)));
+	}
+}
+
+static int mtk_nfi_reset(struct mtk_snand *snf)
+{
+	uint32_t val, fifo_mask;
+	int ret;
+
+	nfi_write32(snf, NFI_CON, CON_FIFO_FLUSH | CON_NFI_RST);
+
+	ret = readw_poll_timeout(snf->nfi_base + NFI_MASTERSTA, val,
+				 !(val & snf->caps->mastersta_mask), 0,
+				 SNFI_POLL_INTERVAL);
+	if (ret) {
+		dev_err(snf->dev, "NFI master is still busy after reset\n");
+		return ret;
+	}
+
+	ret = readl_poll_timeout(snf->nfi_base + NFI_STA, val,
+				 !(val & (NFI_FSM | NFI_NAND_FSM)), 0,
+				 SNFI_POLL_INTERVAL);
+	if (ret) {
+		dev_err(snf->dev, "Failed to reset NFI\n");
+		return ret;
+	}
+
+	fifo_mask = ((snf->caps->fifo_size - 1) << FIFO_RD_REMAIN_S) |
+		    ((snf->caps->fifo_size - 1) << FIFO_WR_REMAIN_S);
+	ret = readw_poll_timeout(snf->nfi_base + NFI_FIFOSTA, val,
+				 !(val & fifo_mask), 0, SNFI_POLL_INTERVAL);
+	if (ret) {
+		dev_err(snf->dev, "NFI FIFOs are not empty\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mtk_snand_mac_reset(struct mtk_snand *snf)
+{
+	int ret;
+	uint32_t val;
+
+	nfi_rmw32(snf, SNF_MISC_CTL, 0, SW_RST);
+
+	ret = readl_poll_timeout(snf->nfi_base + SNF_STA_CTL1, val,
+				 !(val & SPI_STATE), 0, SNFI_POLL_INTERVAL);
+	if (ret)
+		dev_err(snf->dev, "Failed to reset SNFI MAC\n");
+
+	nfi_write32(snf, SNF_MISC_CTL,
+		    (2 << FIFO_RD_LTC_S) | (10 << CS_DESELECT_CYC_S));
+
+	return ret;
+}
+
+static int mtk_snand_mac_trigger(struct mtk_snand *snf, uint32_t outlen,
+				 uint32_t inlen)
+{
+	int ret;
+	uint32_t val;
+
+	nfi_write32(snf, SNF_MAC_CTL, SF_MAC_EN);
+	nfi_write32(snf, SNF_MAC_OUTL, outlen);
+	nfi_write32(snf, SNF_MAC_INL, inlen);
+
+	nfi_write32(snf, SNF_MAC_CTL, SF_MAC_EN | SF_TRIG);
+
+	ret = readl_poll_timeout(snf->nfi_base + SNF_MAC_CTL, val,
+				 val & WIP_READY, 0, SNFI_POLL_INTERVAL);
+	if (ret) {
+		dev_err(snf->dev, "Timed out waiting for WIP_READY\n");
+		goto cleanup;
+	}
+
+	ret = readl_poll_timeout(snf->nfi_base + SNF_MAC_CTL, val, !(val & WIP),
+				 0, SNFI_POLL_INTERVAL);
+	if (ret)
+		dev_err(snf->dev, "Timed out waiting for WIP cleared\n");
+
+cleanup:
+	nfi_write32(snf, SNF_MAC_CTL, 0);
+
+	return ret;
+}
+
+static int mtk_snand_mac_io(struct mtk_snand *snf, const struct spi_mem_op *op)
+{
+	size_t rx_len = 0;
+	size_t reg_offs = 0;
+	u32 val = 0;
+	const u8 *tx_buf = NULL;
+	u8 *rx_buf = NULL;
+	int i, ret;
+	u8 b;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		rx_len = op->data.nbytes;
+		rx_buf = op->data.buf.in;
+	} else {
+		tx_buf = op->data.buf.out;
+	}
+
+	mtk_snand_mac_reset(snf);
+
+	for (i = 0; i < op->cmd.nbytes; i++, reg_offs++) {
+		b = (op->cmd.opcode >> ((op->cmd.nbytes - i - 1) * 8)) & 0xff;
+		val |= b << (8 * (reg_offs % 4));
+		if (reg_offs % 4 == 3) {
+			nfi_write32(snf, SNF_GPRAM + reg_offs - 3, val);
+			val = 0;
+		}
+	}
+
+	for (i = 0; i < op->addr.nbytes; i++, reg_offs++) {
+		b = (op->addr.val >> ((op->addr.nbytes - i - 1) * 8)) & 0xff;
+		val |= b << (8 * (reg_offs % 4));
+		if (reg_offs % 4 == 3) {
+			nfi_write32(snf, SNF_GPRAM + reg_offs - 3, val);
+			val = 0;
+		}
+	}
+
+	for (i = 0; i < op->dummy.nbytes; i++, reg_offs++) {
+		if (reg_offs % 4 == 3) {
+			nfi_write32(snf, SNF_GPRAM + reg_offs - 3, val);
+			val = 0;
+		}
+	}
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		for (i = 0; i < op->data.nbytes; i++, reg_offs++) {
+			val |= tx_buf[i] << (8 * (reg_offs % 4));
+			if (reg_offs % 4 == 3) {
+				nfi_write32(snf, SNF_GPRAM + reg_offs - 3, val);
+				val = 0;
+			}
+		}
+	}
+
+	if (reg_offs % 4 != 3)
+		nfi_write32(snf, SNF_GPRAM + (reg_offs & ~3), val);
+
+	for (i = 0; i < reg_offs; i += 4)
+		dev_dbg(snf->dev, "%d: %08X", i,
+			nfi_read32(snf, SNF_GPRAM + i));
+
+	dev_dbg(snf->dev, "SNF TX: %lu RX: %lu", reg_offs, rx_len);
+
+	ret = mtk_snand_mac_trigger(snf, reg_offs, rx_len);
+	if (ret)
+		return ret;
+
+	if (!rx_len)
+		return 0;
+
+	nfi_read_data(snf, SNF_GPRAM + reg_offs, rx_buf, rx_len);
+	return 0;
+}
+
+static int mtk_snand_setup_pagefmt(struct mtk_snand *snf, size_t page_size,
+				   size_t oob_size)
+{
+	int spare_idx = -1;
+	u32 msg_size, spare_size, parity_bits, max_ecc_bytes;
+	u32 spare_size_shift, pagesize_idx;
+	u32 sector_size_512;
+	u8 nsectors;
+	int i;
+
+	// skip if it's already configured as required.
+	if (snf->nfi_cfg.page_size == page_size &&
+	    snf->nfi_cfg.oob_size == oob_size)
+		return 0;
+
+	nsectors = page_size / snf->caps->sector_size;
+	if (nsectors > snf->caps->max_sectors) {
+		dev_err(snf->dev, "too many sectors required.\n");
+		goto err;
+	}
+
+	if (snf->caps->sector_size == 512) {
+		sector_size_512 = NFI_SEC_SEL_512;
+		spare_size_shift = NFI_SPARE_SIZE_S;
+	} else {
+		sector_size_512 = 0;
+		spare_size_shift = NFI_SPARE_SIZE_LS_S;
+	}
+
+	switch (page_size) {
+	case SZ_512:
+		pagesize_idx = NFI_PAGE_SIZE_512_2K;
+		break;
+	case SZ_2K:
+		if (snf->caps->sector_size == 512)
+			pagesize_idx = NFI_PAGE_SIZE_2K_4K;
+		else
+			pagesize_idx = NFI_PAGE_SIZE_512_2K;
+		break;
+	case SZ_4K:
+		if (snf->caps->sector_size == 512)
+			pagesize_idx = NFI_PAGE_SIZE_4K_8K;
+		else
+			pagesize_idx = NFI_PAGE_SIZE_2K_4K;
+		break;
+	case SZ_8K:
+		if (snf->caps->sector_size == 512)
+			pagesize_idx = NFI_PAGE_SIZE_8K_16K;
+		else
+			pagesize_idx = NFI_PAGE_SIZE_4K_8K;
+		break;
+	case SZ_16K:
+		pagesize_idx = NFI_PAGE_SIZE_8K_16K;
+		break;
+	default:
+		dev_err(snf->dev, "unsupported page size.\n");
+		goto err;
+	}
+
+	spare_size = oob_size / nsectors;
+	// If we're using the 1KB sector size, HW will automatically double the
+	// spare size. We should only use half of the value in this case.
+	if (snf->caps->sector_size == 1024)
+		spare_size /= 2;
+
+	for (i = snf->caps->num_spare_size - 1; i >= 0; i--) {
+		if (snf->caps->spare_sizes[i] <= spare_size) {
+			spare_size = snf->caps->spare_sizes[i];
+			if (snf->caps->sector_size == 1024)
+				spare_size *= 2;
+			spare_idx = i;
+			break;
+		}
+	}
+
+	if (spare_idx < 0) {
+		dev_err(snf->dev, "unsupported spare size: %u\n", spare_size);
+		goto err;
+	}
+
+	nfi_write32(snf, NFI_PAGEFMT,
+		    (snf->caps->fdm_ecc_size << NFI_FDM_ECC_NUM_S) |
+			    (snf->caps->fdm_size << NFI_FDM_NUM_S) |
+			    (spare_idx << spare_size_shift) |
+			    (pagesize_idx << NFI_PAGE_SIZE_S) |
+			    sector_size_512);
+
+	msg_size = snf->caps->sector_size + snf->caps->fdm_ecc_size;
+	snf->ecc_cfg.len = msg_size;
+	parity_bits = fls(1 + 8 * msg_size);
+	max_ecc_bytes = spare_size - snf->caps->fdm_size;
+	snf->ecc_cfg.strength = max_ecc_bytes * 8 / parity_bits;
+	mtk_ecc_adjust_strength(snf->ecc, &snf->ecc_cfg.strength);
+
+	snf->nfi_cfg.page_size = page_size;
+	snf->nfi_cfg.oob_size = oob_size;
+	snf->nfi_cfg.nsectors = nsectors;
+	snf->nfi_cfg.spare_size = spare_size;
+
+	snf->ecc_cfg.mode = ECC_NFI_MODE;
+	snf->ecc_cfg.sectors = nsectors;
+
+	dev_info(snf->dev, "page format: (%u + %u) * %u, ECC strength: %u\n",
+		 snf->caps->sector_size, spare_size, nsectors,
+		 snf->ecc_cfg.strength);
+	return snand_prepare_bouncebuf(snf, page_size + oob_size);
+err:
+	dev_err(snf->dev, "page size %lu+%lu is not supported\n", page_size,
+		oob_size);
+	return -EOPNOTSUPP;
+}
+
+static int mtk_snand_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobecc)
+{
+	// ECC area is not accessible
+	return -ERANGE;
+}
+
+static int mtk_snand_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobfree)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtk_snand *ms = nand_to_mtk_snand(nand);
+
+	if (section >= ms->nfi_cfg.nsectors)
+		return -ERANGE;
+
+	oobfree->length = ms->caps->fdm_size - 1;
+	oobfree->offset = section * ms->caps->fdm_size + 1;
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops mtk_snand_ooblayout = {
+	.ecc = mtk_snand_ooblayout_ecc,
+	.free = mtk_snand_ooblayout_free,
+};
+
+static int mtk_snand_ecc_init_ctx(struct nand_device *nand)
+{
+	struct mtk_snand *snf = nand_to_mtk_snand(nand);
+	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int ret;
+
+	ret = mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
+				      nand->memorg.oobsize);
+	if (ret)
+		return ret;
+
+	mtd_set_ooblayout(mtd, &mtk_snand_ooblayout);
+
+	// This driver ignores any ECC capability configured by user or
+	// requested by the nand chip because the BootROM and MTK bootloader
+	// expects the page format to be the exact one as calculated in
+	// setup_pagefmt.
+	conf->step_size = snf->caps->sector_size;
+	conf->strength = snf->ecc_cfg.strength;
+
+	return 0;
+}
+
+static int mtk_snand_ecc_prepare_io_req(struct nand_device *nand,
+					struct nand_page_io_req *req)
+{
+	struct mtk_snand *snf = nand_to_mtk_snand(nand);
+	int ret;
+
+	ret = mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
+				      nand->memorg.oobsize);
+	if (ret)
+		return ret;
+	snf->autofmt = true;
+	return 0;
+}
+
+static int mtk_snand_ecc_finish_io_req(struct nand_device *nand,
+				       struct nand_page_io_req *req)
+{
+	struct mtk_snand *snf = nand_to_mtk_snand(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+
+	snf->autofmt = false;
+	if ((req->mode == MTD_OPS_RAW) || (req->type != NAND_PAGE_READ))
+		return 0;
+
+	if (snf->ecc_stats.failed)
+		mtd->ecc_stats.failed += snf->ecc_stats.failed;
+	mtd->ecc_stats.corrected += snf->ecc_stats.corrected;
+	return snf->ecc_stats.failed ? -EBADMSG : snf->ecc_stats.bitflips;
+}
+
+static struct nand_ecc_engine_ops mtk_snfi_ecc_engine_ops = {
+	.init_ctx = mtk_snand_ecc_init_ctx,
+	.prepare_io_req = mtk_snand_ecc_prepare_io_req,
+	.finish_io_req = mtk_snand_ecc_finish_io_req,
+};
+
+static void mtk_snand_read_fdm(struct mtk_snand *snf, uint8_t *buf)
+{
+	uint32_t vall, valm;
+	uint8_t *oobptr = buf;
+	int i, j;
+
+	for (i = 0; i < snf->nfi_cfg.nsectors; i++) {
+		vall = nfi_read32(snf, NFI_FDML(i));
+		valm = nfi_read32(snf, NFI_FDMM(i));
+
+		for (j = 0; j < snf->caps->fdm_size; j++)
+			oobptr[j] = (j >= 4 ? valm : vall) >> ((j % 4) * 8);
+
+		oobptr += snf->caps->fdm_size;
+	}
+}
+
+/**
+ * swap [pagesize] byte on nand with the first fdm byte in the last sector.
+ *
+ * @param snf
+ */
+static void mtk_snand_bm_swap(struct mtk_snand *snf)
+{
+	uint32_t buf_bbm_pos, fdm_bbm_pos;
+
+	if (!snf->caps->bbm_swap || snf->nfi_cfg.nsectors == 1)
+		return;
+
+	buf_bbm_pos = snf->nfi_cfg.page_size -
+		      (snf->nfi_cfg.nsectors - 1) * snf->nfi_cfg.spare_size;
+	fdm_bbm_pos = snf->nfi_cfg.page_size +
+		      (snf->nfi_cfg.nsectors - 1) * snf->caps->fdm_size;
+
+	swap(snf->buf[fdm_bbm_pos], snf->buf[buf_bbm_pos]);
+}
+
+/**
+ * swap the first fdm byte in the first and the last sector.
+ *
+ * @param snf
+ */
+static void mtk_snand_fdm_bm_swap(struct mtk_snand *snf)
+{
+	uint32_t fdm_bbm_pos1, fdm_bbm_pos2;
+
+	if (!snf->caps->bbm_swap || snf->nfi_cfg.nsectors == 1)
+		return;
+
+	fdm_bbm_pos1 = snf->nfi_cfg.page_size;
+	fdm_bbm_pos2 = snf->nfi_cfg.page_size +
+		       (snf->nfi_cfg.nsectors - 1) * snf->caps->fdm_size;
+	swap(snf->buf[fdm_bbm_pos1], snf->buf[fdm_bbm_pos2]);
+}
+
+static int mtk_snand_read_page_cache(struct mtk_snand *snf,
+				     const struct spi_mem_op *op)
+{
+	// the address part to be sent by the controller
+	u32 op_addr = op->addr.val;
+	// where to start copying data from bounce buffer
+	u32 rd_offset = 0;
+	u32 dummy_clk = (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth);
+	u32 op_mode = 0;
+	int ret = 0;
+	u32 rd_mode, rd_bytes, val;
+
+	if (snf->autofmt) {
+		u32 last_bit;
+		u32 mask;
+
+		op_mode = CNFG_AUTO_FMT_EN;
+		if (op->data.ecc)
+			op_mode |= CNFG_HW_ECC_EN;
+		// extract the plane bit:
+		// Find the highest bit set in (pagesize+oobsize).
+		// Bits higher than that in op->addr are kept and sent over SPI
+		// Lower bits are used as an offset for copying data from DMA
+		// bounce buffer.
+		last_bit = fls(snf->nfi_cfg.page_size + snf->nfi_cfg.oob_size);
+		mask = (1 << last_bit) - 1;
+		rd_offset = op_addr & mask;
+		op_addr &= ~mask;
+	}
+	mtk_snand_mac_reset(snf);
+	mtk_nfi_reset(snf);
+
+	// command and dummy cycles
+	nfi_write32(snf, SNF_RD_CTL2,
+		    (dummy_clk << DATA_READ_DUMMY_S) |
+			    (op->cmd.opcode << DATA_READ_CMD_S));
+
+	// read address
+	nfi_write32(snf, SNF_RD_CTL3, op_addr);
+
+	// Set read op_mode
+	if (op->data.buswidth == 4)
+		rd_mode = op->addr.buswidth == 4 ? DATA_READ_MODE_QUAD :
+						   DATA_READ_MODE_X4;
+	else if (op->data.buswidth == 2)
+		rd_mode = op->addr.buswidth == 2 ? DATA_READ_MODE_DUAL :
+						   DATA_READ_MODE_X2;
+	else
+		rd_mode = DATA_READ_MODE_X1;
+	rd_mode <<= DATA_READ_MODE_S;
+	nfi_rmw32(snf, SNF_MISC_CTL, DATA_READ_MODE,
+		  rd_mode | DATARD_CUSTOM_EN);
+
+	// Set bytes to read
+	rd_bytes = (snf->nfi_cfg.spare_size + snf->caps->sector_size) *
+		   snf->nfi_cfg.nsectors;
+	nfi_write32(snf, SNF_MISC_CTL2,
+		    (rd_bytes << PROGRAM_LOAD_BYTE_NUM_S) | rd_bytes);
+
+	// NFI read prepare
+	nfi_write16(snf, NFI_CNFG,
+		    (CNFG_OP_MODE_CUST << CNFG_OP_MODE_S) | CNFG_DMA_BURST_EN |
+			    CNFG_READ_MODE | CNFG_DMA_MODE | op_mode);
+
+	nfi_write32(snf, NFI_CON, (snf->nfi_cfg.nsectors << CON_SEC_NUM_S));
+	nfi_write32(snf, NFI_STRADDR, (u32)snf->buf_dma);
+	if (op->data.ecc) {
+		snf->ecc_cfg.op = ECC_DECODE;
+		ret = mtk_ecc_enable(snf->ecc, &snf->ecc_cfg);
+		if (ret)
+			goto cleanup;
+	}
+	// Prepare for custom read interrupt
+	nfi_write32(snf, NFI_INTR_EN, NFI_IRQ_INTR_EN | NFI_IRQ_CUS_READ);
+	reinit_completion(&snf->op_done);
+
+	// Trigger NFI into custom mode
+	nfi_write16(snf, NFI_CMD, NFI_CMD_DUMMY_READ);
+
+	// Start DMA read
+	nfi_rmw32(snf, NFI_CON, 0, CON_BRD);
+	nfi_write16(snf, NFI_STRDATA, STR_DATA);
+
+	if (!wait_for_completion_timeout(
+		    &snf->op_done, usecs_to_jiffies(SNFI_POLL_INTERVAL))) {
+		dev_err(snf->dev, "DMA timed out for reading from cache.\n");
+		ret = -ETIMEDOUT;
+		goto cleanup;
+	}
+
+	// Wait for BUS_SEC_CNTR returning expected value
+	ret = readl_poll_timeout(snf->nfi_base + NFI_BYTELEN, val,
+				 BUS_SEC_CNTR(val) >= snf->nfi_cfg.nsectors, 0,
+				 SNFI_POLL_INTERVAL);
+	if (ret) {
+		dev_err(snf->dev, "Timed out waiting for BUS_SEC_CNTR\n");
+		goto cleanup2;
+	}
+
+	// Wait for bus becoming idle
+	ret = readl_poll_timeout(snf->nfi_base + NFI_MASTERSTA, val,
+				 !(val & snf->caps->mastersta_mask), 0,
+				 SNFI_POLL_INTERVAL);
+	if (ret) {
+		dev_err(snf->dev, "Timed out waiting for bus becoming idle\n");
+		goto cleanup2;
+	}
+
+	if (op->data.ecc) {
+		ret = mtk_ecc_wait_done(snf->ecc, ECC_DECODE);
+		if (ret) {
+			dev_err(snf->dev, "wait ecc done timeout\n");
+			goto cleanup2;
+		}
+		// save status before disabling ecc
+		mtk_ecc_get_stats(snf->ecc, &snf->ecc_stats,
+				  snf->nfi_cfg.nsectors);
+	}
+
+	if (snf->autofmt) {
+		mtk_snand_read_fdm(snf, snf->buf + snf->nfi_cfg.page_size);
+		if (snf->caps->bbm_swap) {
+			mtk_snand_bm_swap(snf);
+			mtk_snand_fdm_bm_swap(snf);
+		}
+	}
+
+	// copy data back
+	if (nfi_read32(snf, NFI_STA) & READ_EMPTY) {
+		memset(op->data.buf.in, 0xff, op->data.nbytes);
+		snf->ecc_stats.bitflips = 0;
+		snf->ecc_stats.failed = 0;
+		snf->ecc_stats.corrected = 0;
+	} else {
+		if (rd_offset < snf->buf_len) {
+			u32 cap_len = snf->buf_len - rd_offset;
+
+			if (op->data.nbytes < cap_len)
+				cap_len = op->data.nbytes;
+			memcpy(op->data.buf.in, snf->buf + rd_offset, cap_len);
+		}
+	}
+cleanup2:
+	if (op->data.ecc)
+		mtk_ecc_disable(snf->ecc);
+cleanup:
+	// Stop read
+	nfi_write32(snf, NFI_CON, 0);
+	nfi_write16(snf, NFI_CNFG, 0);
+
+	// Clear SNF done flag
+	nfi_rmw32(snf, SNF_STA_CTL1, 0, CUS_READ_DONE);
+	nfi_write32(snf, SNF_STA_CTL1, 0);
+
+	// Disable interrupt
+	nfi_read32(snf, NFI_INTR_STA);
+	nfi_write32(snf, NFI_INTR_EN, 0);
+
+	nfi_rmw32(snf, SNF_MISC_CTL, DATARD_CUSTOM_EN, 0);
+
+	return ret;
+}
+
+static int mtk_snand_write_page_cache(struct mtk_snand *snf,
+				      const struct spi_mem_op *op)
+{
+	// the address part to be sent by the controller
+	u32 op_addr = op->addr.val;
+	// where to start copying data from bounce buffer
+	u32 wr_offset = 0;
+	u32 op_mode = 0;
+	int ret = 0;
+	u32 wr_mode = 0;
+	u32 wr_bytes, val;
+	size_t cap_len;
+
+	if (snf->autofmt) {
+		u32 last_bit;
+		u32 mask;
+
+		op_mode = CNFG_AUTO_FMT_EN;
+		if (op->data.ecc)
+			op_mode |= CNFG_HW_ECC_EN;
+
+		last_bit = fls(snf->nfi_cfg.page_size + snf->nfi_cfg.oob_size);
+		mask = (1 << last_bit) - 1;
+		wr_offset = op_addr & mask;
+		op_addr &= ~mask;
+	}
+	mtk_snand_mac_reset(snf);
+	mtk_nfi_reset(snf);
+
+	if (wr_offset)
+		memset(snf->buf, 0xff, wr_offset);
+
+	cap_len = snf->buf_len - wr_offset;
+	if (op->data.nbytes < cap_len)
+		cap_len = op->data.nbytes;
+	memcpy(snf->buf + wr_offset, op->data.buf.out, cap_len);
+	if (snf->autofmt && snf->caps->bbm_swap) {
+		mtk_snand_fdm_bm_swap(snf);
+		mtk_snand_bm_swap(snf);
+	}
+
+	// Command
+	nfi_write32(snf, SNF_PG_CTL1, (op->cmd.opcode << PG_LOAD_CMD_S));
+
+	// write address
+	nfi_write32(snf, SNF_PG_CTL2, op_addr);
+
+	// Set read op_mode
+	if (op->data.buswidth == 4)
+		wr_mode = PG_LOAD_X4_EN;
+
+	nfi_rmw32(snf, SNF_MISC_CTL, PG_LOAD_X4_EN,
+		  wr_mode | PG_LOAD_CUSTOM_EN);
+
+	// Set bytes to write
+	wr_bytes = (snf->nfi_cfg.spare_size + snf->caps->sector_size) *
+		   snf->nfi_cfg.nsectors;
+	nfi_write32(snf, SNF_MISC_CTL2,
+		    (wr_bytes << PROGRAM_LOAD_BYTE_NUM_S) | wr_bytes);
+
+	// NFI write prepare
+	nfi_write16(snf, NFI_CNFG,
+		    (CNFG_OP_MODE_PROGRAM << CNFG_OP_MODE_S) |
+			    CNFG_DMA_BURST_EN | CNFG_DMA_MODE | op_mode);
+
+	nfi_write32(snf, NFI_CON, (snf->nfi_cfg.nsectors << CON_SEC_NUM_S));
+	nfi_write32(snf, NFI_STRADDR, (u32)snf->buf_dma);
+	if (op->data.ecc) {
+		snf->ecc_cfg.op = ECC_ENCODE;
+		ret = mtk_ecc_enable(snf->ecc, &snf->ecc_cfg);
+		if (ret)
+			goto cleanup;
+	}
+	// Prepare for custom write interrupt
+	nfi_write32(snf, NFI_INTR_EN, NFI_IRQ_INTR_EN | NFI_IRQ_CUS_PG);
+	reinit_completion(&snf->op_done);
+	;
+
+	// Trigger NFI into custom mode
+	nfi_write16(snf, NFI_CMD, NFI_CMD_DUMMY_WRITE);
+
+	// Start DMA write
+	nfi_rmw32(snf, NFI_CON, 0, CON_BWR);
+	nfi_write16(snf, NFI_STRDATA, STR_DATA);
+
+	if (!wait_for_completion_timeout(
+		    &snf->op_done, usecs_to_jiffies(SNFI_POLL_INTERVAL))) {
+		dev_err(snf->dev, "DMA timed out for program load.\n");
+		ret = -ETIMEDOUT;
+		goto cleanup;
+	}
+
+	// Wait for NFI_SEC_CNTR returning expected value
+	ret = readl_poll_timeout(snf->nfi_base + NFI_ADDRCNTR, val,
+				 NFI_SEC_CNTR(val) >= snf->nfi_cfg.nsectors, 0,
+				 SNFI_POLL_INTERVAL);
+	if (ret)
+		dev_err(snf->dev, "Timed out waiting for NFI_SEC_CNTR\n");
+
+	if (op->data.ecc)
+		mtk_ecc_disable(snf->ecc);
+cleanup:
+	// Stop write
+	nfi_write32(snf, NFI_CON, 0);
+	nfi_write16(snf, NFI_CNFG, 0);
+
+	// Clear SNF done flag
+	nfi_rmw32(snf, SNF_STA_CTL1, 0, CUS_PG_DONE);
+	nfi_write32(snf, SNF_STA_CTL1, 0);
+
+	// Disable interrupt
+	nfi_read32(snf, NFI_INTR_STA);
+	nfi_write32(snf, NFI_INTR_EN, 0);
+
+	nfi_rmw32(snf, SNF_MISC_CTL, PG_LOAD_CUSTOM_EN, 0);
+
+	return ret;
+}
+
+/**
+ * Check whether op can be executed with read_from_cache or program_load
+ * mode in the controller.
+ * This controller can execute typical Read From Cache and Program Load
+ * instructions found on SPI-NAND with 2-byte address.
+ * Note: DTR and cmd buswidth & nbytes should be checked before calling this.
+ *
+ * @param op spi-mem op to check
+ * @return true if the op matches the instruction template
+ */
+static bool mtk_snand_is_page_ops(const struct spi_mem_op *op)
+{
+	if (op->addr.nbytes != 2)
+		return false;
+
+	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
+	    op->addr.buswidth != 4)
+		return false;
+
+	// match read from page instructions
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		// check dummy cycle first
+		if (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth >
+		    DATA_READ_MAX_DUMMY)
+			return false;
+		// quad io / quad out
+		if ((op->addr.buswidth == 4 || op->addr.buswidth == 1) &&
+		    op->data.buswidth == 4)
+			return true;
+
+		// dual io / dual out
+		if ((op->addr.buswidth == 2 || op->addr.buswidth == 1) &&
+		    op->data.buswidth == 2)
+			return true;
+
+		// standard spi
+		if (op->addr.buswidth == 1 && op->data.buswidth == 1)
+			return true;
+	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
+		// check dummy cycle first
+		if (op->dummy.nbytes)
+			return false;
+		// program load quad out
+		if (op->addr.buswidth == 1 && op->data.buswidth == 4)
+			return true;
+		// standard spi
+		if (op->addr.buswidth == 1 && op->data.buswidth == 1)
+			return true;
+	}
+	return false;
+}
+
+static bool mtk_snand_supports_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+		return false;
+	if (mtk_snand_is_page_ops(op))
+		return true;
+	return ((op->addr.nbytes == 0 || op->addr.buswidth == 1) &&
+		(op->dummy.nbytes == 0 || op->dummy.buswidth == 1) &&
+		(op->data.nbytes == 0 || op->data.buswidth == 1));
+}
+
+static int mtk_snand_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct mtk_snand *ms = spi_controller_get_devdata(mem->spi->master);
+	// page ops transfer size must be exactly ((sector_size + spare_size) *
+	// nsectors). Limit the op size if the caller requests more than that.
+	// exec_op will read more than needed and discard the leftover if the
+	// caller requests less data.
+	if (mtk_snand_is_page_ops(op)) {
+		size_t l;
+		// skip adjust_op_size for page ops
+		if (ms->autofmt)
+			return 0;
+		l = ms->caps->sector_size + ms->nfi_cfg.spare_size;
+		l *= ms->nfi_cfg.nsectors;
+		if (op->data.nbytes > l)
+			op->data.nbytes = l;
+	} else {
+		size_t hl = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+
+		if (hl >= SNF_GPRAM_SIZE)
+			return -EOPNOTSUPP;
+		if (op->data.nbytes > SNF_GPRAM_SIZE - hl)
+			op->data.nbytes = SNF_GPRAM_SIZE - hl;
+	}
+	return 0;
+}
+
+static int mtk_snand_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct mtk_snand *ms = spi_controller_get_devdata(mem->spi->master);
+
+	dev_dbg(ms->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
+		op->addr.val, op->addr.buswidth, op->addr.nbytes,
+		op->data.buswidth, op->data.nbytes);
+	if (mtk_snand_is_page_ops(op)) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			return mtk_snand_read_page_cache(ms, op);
+		else
+			return mtk_snand_write_page_cache(ms, op);
+	} else {
+		return mtk_snand_mac_io(ms, op);
+	}
+}
+
+static const struct spi_controller_mem_ops mtk_snand_mem_ops = {
+	.adjust_op_size = mtk_snand_adjust_op_size,
+	.supports_op = mtk_snand_supports_op,
+	.exec_op = mtk_snand_exec_op,
+};
+
+static const struct spi_controller_mem_caps mtk_snand_mem_caps = {
+	.ecc = true,
+};
+
+static irqreturn_t mtk_snand_irq(int irq, void *id)
+{
+	struct mtk_snand *snf = id;
+	uint32_t sta, ien;
+
+	sta = nfi_read32(snf, NFI_INTR_STA);
+	ien = nfi_read32(snf, NFI_INTR_EN);
+
+	if (!(sta & ien))
+		return IRQ_NONE;
+
+	nfi_write32(snf, NFI_INTR_EN, 0);
+	complete(&snf->op_done);
+	return IRQ_HANDLED;
+}
+
+static const struct of_device_id mtk_snand_ids[] = {
+	{ .compatible = "mediatek,mt7622-snand", .data = &mt7622_snand_caps },
+	{ .compatible = "mediatek,mt7629-snand", .data = &mt7629_snand_caps },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mtk_snand_ids);
+
+static int mtk_snand_enable_clk(struct mtk_snand *ms)
+{
+	int ret;
+
+	ret = clk_prepare_enable(ms->nfi_clk);
+	if (ret) {
+		dev_err(ms->dev, "unable to enable nfi clk\n");
+		return ret;
+	}
+	ret = clk_prepare_enable(ms->pad_clk);
+	if (ret) {
+		dev_err(ms->dev, "unable to enable pad clk\n");
+		goto err1;
+	}
+	return 0;
+err1:
+	clk_disable_unprepare(ms->nfi_clk);
+	return ret;
+}
+
+static void mtk_snand_disable_clk(struct mtk_snand *ms)
+{
+	clk_disable_unprepare(ms->pad_clk);
+	clk_disable_unprepare(ms->nfi_clk);
+}
+
+static int mtk_snand_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *dev_id;
+	struct spi_controller *ctlr;
+	struct mtk_snand *ms;
+	int ret;
+
+	dev_id = of_match_node(mtk_snand_ids, np);
+	if (!dev_id)
+		return -EINVAL;
+
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*ms));
+	if (!ctlr)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, ctlr);
+
+	ms = spi_controller_get_devdata(ctlr);
+
+	ms->ctlr = ctlr;
+	ms->caps = dev_id->data;
+
+	ms->ecc = of_mtk_ecc_get(np);
+	if (IS_ERR(ms->ecc))
+		return PTR_ERR(ms->ecc);
+	else if (!ms->ecc)
+		return -ENODEV;
+
+	ms->nfi_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ms->nfi_base)) {
+		ret = PTR_ERR(ms->nfi_base);
+		goto release_ecc;
+	}
+
+	ms->dev = &pdev->dev;
+
+	ms->nfi_clk = devm_clk_get(&pdev->dev, "nfi_clk");
+	if (IS_ERR(ms->nfi_clk)) {
+		ret = PTR_ERR(ms->nfi_clk);
+		dev_err(&pdev->dev, "unable to get nfi_clk, err = %d\n", ret);
+		goto release_ecc;
+	}
+
+	ms->pad_clk = devm_clk_get(&pdev->dev, "pad_clk");
+	if (IS_ERR(ms->pad_clk)) {
+		ret = PTR_ERR(ms->pad_clk);
+		dev_err(&pdev->dev, "unable to get pad_clk, err = %d\n", ret);
+		goto release_ecc;
+	}
+
+	ret = mtk_snand_enable_clk(ms);
+	if (ret)
+		goto release_ecc;
+
+	init_completion(&ms->op_done);
+
+	ms->irq = platform_get_irq(pdev, 0);
+	if (ms->irq < 0) {
+		ret = ms->irq;
+		goto disable_clk;
+	}
+	ret = devm_request_irq(ms->dev, ms->irq, mtk_snand_irq, 0x0,
+			       "mtk-snand", ms);
+	if (ret) {
+		dev_err(ms->dev, "failed to request snfi irq\n");
+		goto disable_clk;
+	}
+
+	ret = dma_set_mask(ms->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(ms->dev, "failed to set dma mask\n");
+		goto disable_clk;
+	}
+
+	// setup an initial page format for ops matching page_cache_op template
+	// before ECC is called.
+	ret = mtk_snand_setup_pagefmt(ms, ms->caps->sector_size,
+				      ms->caps->spare_sizes[0]);
+	if (ret) {
+		dev_err(ms->dev, "failed to set initial page format\n");
+		goto disable_clk;
+	}
+
+	// setup ECC engine
+	ms->ecc_eng.dev = &pdev->dev;
+	ms->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
+	ms->ecc_eng.ops = &mtk_snfi_ecc_engine_ops;
+	ms->ecc_eng.priv = ms;
+
+	ret = nand_ecc_register_on_host_hw_engine(&ms->ecc_eng);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register ecc engine.\n");
+		goto disable_clk;
+	}
+
+	ctlr->num_chipselect = 1;
+	ctlr->mem_ops = &mtk_snand_mem_ops;
+	ctlr->mem_caps = &mtk_snand_mem_caps;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->dev.of_node = pdev->dev.of_node;
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed.\n");
+		goto disable_clk;
+	}
+
+	return 0;
+disable_clk:
+	mtk_snand_disable_clk(ms);
+release_ecc:
+	mtk_ecc_release(ms->ecc);
+	return ret;
+}
+
+static int mtk_snand_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct mtk_snand *ms = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
+	mtk_snand_disable_clk(ms);
+	mtk_ecc_release(ms->ecc);
+	return 0;
+}
+
+static struct platform_driver mtk_snand_driver = {
+	.probe = mtk_snand_probe,
+	.remove = mtk_snand_remove,
+	.driver = {
+		.name = "mtk-snand",
+		.of_match_table = mtk_snand_ids,
+	},
+};
+
+module_platform_driver(mtk_snand_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Chuanhong Guo <gch981213@gmail.com>");
+MODULE_DESCRIPTION("MeidaTek SPI-NAND Flash Controller Driver");
-- 
2.35.1

