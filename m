Return-Path: <linux-spi+bounces-11225-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABCC5EEFA
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 19:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7F83B2F1A
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554F2E2299;
	Fri, 14 Nov 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="JZhSZENu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF72DF12C
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146675; cv=none; b=jtRAPdcjcYtqi+Vha08Vn4SE68gcwghbw2Y0EtnpDneT3t3dB3g+p55EKFRlREuwHTlWNnIv2z8PghaSbBYhGT5If6zoKfeFGWLOeY6Ty7gq6ggoOGoWTzp3/KyJ+oNwbCPYPCA6u+Nn/T3i7qZqh80Y60fmpdatGnIIT+3t93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146675; c=relaxed/simple;
	bh=wOS8xOdxnWDQ5AoeMU/bFr3MT8gBLUAUYKbNbsm5IWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/oOr94IGO3YkaW8hqa8UeI3sxOpe5smTC+Nb5jx4Shk+FEUy6AB9EbjaLVZHjDFTi3wLvdIJQETAPMdaXk70/LsgGKeIGh3q0t5LGaSZ4B81ZO80Y4bcxjpo8ZPEhHSEwIPL8AR1t6gporU4NBE4jeg29l34ExCYam7y3STNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=JZhSZENu; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-948a50b8ea6so158768139f.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 10:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1763146672; x=1763751472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsJQrYIOhdVE0ra2tZjK+ukffYSnwTg/haHpenzjpoc=;
        b=JZhSZENuGPk5XKxruVl0g3R4bNe3hTDfTh4rx9wd6wx0AMGkrj6Xz4BF7YU5ft42C6
         ZTfzF+PjJ0bj7DCC/DVy3C07NfOBDFE+lf7pa32Ok511sfIyPj4e6HD2muah19lUFfdq
         eUUYzWn0NCvdHYF6JySm/CeidClmm7aXbwLcmsJUUEUeUEDjO432T3cjgA+NXtkb78el
         zfDui9AJgdI5QHSIQN4pqT8xYQM6Ye/fuPDP6t38XqiEvqdhEzRgoqb/jdG7MLKioXxz
         AuJ4zxs/i852I24WAXtEGX/Duu+AWAnn8HzYArc4WPrWS7dNUmrwm1k/nb4vw9o2vepQ
         +Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146672; x=1763751472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PsJQrYIOhdVE0ra2tZjK+ukffYSnwTg/haHpenzjpoc=;
        b=mSMRjGqUdNllxXWRaAAgffbQhDT2aH+oeu3j+4MNRh6dHAljQF/yGcwqaZZ6jjDiEG
         rGnn5zA1TynJfa93140j0wvuyDqgO8DDfmb4AFsNbeip7h9HyRzCE/bAfN0Gc9ScDozQ
         C1EOgQoLmCXcCdOVUF6qyPsGuIB0tiUHOnRNA9Fd4SkcC/XtBxq4/Rb2vEUYL7z6OnGE
         87i/P+0JihSAkgV0EA+MhVxyo3aWd7dQm8qSN5x62m/pwZbkSnXH2vzwRsiHkl7te1ud
         m66uqlAc10tG89kHg4zx6ewmEfo/HPyN1zENeJMxVRljP1WNPSqPSNOCj0tUaDCVeK82
         8pqA==
X-Forwarded-Encrypted: i=1; AJvYcCXRJ9XAtyk/sAGnAtwytvYgy/ZGJbI2gj1JeCUzZh7GxXh1XdAH2piHyz7usL2JGisg8aVYQmnZXYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzp7tnA3Oc9+iaAro8aI3s3HWmwPcII9/4TOaVEhnaebKEpRmt
	w1u/Y6YTisrQ/qxy68WxbX4R1u03IQi0VUsqLmHPGjUB5gSy47FGmTwp5r3JM6XpgAM=
X-Gm-Gg: ASbGnctNnM5p7jWpOmJalgYHmVpK/HIotte4U/osirI3XMYFTBio+UvNv3e9Ahbv1sY
	Uco+BlT7Zy4aYnmyW+CrMWKWFOqCKnmoh+Z63UFrT8VNrH2TJjm8zRBT0l8vJru/7/wWG3ulyH5
	GPC/2Gq+ET/AnT/j/Hnml2517Z9YniMpTjMuDoiLRH51DmPL0qSzO993WQN5qQnBjIu80PM+GmF
	70ifZGt2/V0Zo28fp3UFM+Apu0K9CrZxafuauTvlxnOpVzRCpeC2U7rVDHv2fnrsM4P7ckcUb3S
	AanPSUGf1DHioh7z1D7rPbco0crCT03swCnckz9jxapwu+uQVB0Sx41qXDBAnnAMeB89iWoVJXS
	gZ3jW+XWFOhoAARiW+kYom+mF9V6h+/w6zAheGE3dskNzhQSPOHhDt6CyTFN54wIM4Nb9hfsfMN
	uMAYsZiMtg018Xme5f2VL1hn3TlvqkGF8fSum8HV1rr+SgLxkGSjIXLw==
X-Google-Smtp-Source: AGHT+IGQ1UrB/Ikfd0EVJ+k8O6P/0MMB3BApCZ8FU0+DGSpReXpJRXdlwwu32vPA/AZspKHWLLd6CQ==
X-Received: by 2002:a05:6602:640d:b0:948:8be8:a8d7 with SMTP id ca18e2360f4ac-948e0da72e6mr647799039f.13.1763146671586;
        Fri, 14 Nov 2025 10:57:51 -0800 (PST)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2ba690bsm278679339f.8.2025.11.14.10.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:57:50 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	dlan@gentoo.org
Cc: p.zabel@pengutronix.de,
	linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
Date: Fri, 14 Nov 2025 12:57:43 -0600
Message-ID: <20251114185745.2838358-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251114185745.2838358-1-elder@riscstar.com>
References: <20251114185745.2838358-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces the driver for the SPI controller found in the
SpacemiT K1 SoC.  Currently the driver supports master mode only.
The SPI hardware implements RX and TX FIFOs, 32 entries each, and
supports both PIO and DMA mode transfers.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v7: - The driver is built as a kernel module by default
    - A bug interpreting the resource pointer has been fixed when
      cleaning up the DMA state
    - A error that was reported when COMPILE_TEST built two 32-bit
      architectures has been fixed by using DIV_ROUND_UP_ULL()
      rather than DIV_ROUND_UP() in k1_spi_set_speed()

 drivers/spi/Kconfig           |   9 +
 drivers/spi/Makefile          |   1 +
 drivers/spi/spi-spacemit-k1.c | 966 ++++++++++++++++++++++++++++++++++
 3 files changed, 976 insertions(+)
 create mode 100644 drivers/spi/spi-spacemit-k1.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 592d46c9998bb..7bba7095c64ff 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1072,6 +1072,15 @@ config SPI_SG2044_NOR
 	  also supporting 3Byte address devices and 4Byte address
 	  devices.
 
+config SPI_SPACEMIT_K1
+	tristate "K1 SPI Controller"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on OF
+	imply MMP_PDMA if ARCH_SPACEMIT
+	default m if ARCH_SPACEMIT
+	help
+	  Enable support for the SpacemiT K1 SPI controller.
+
 config SPI_SPRD
 	tristate "Spreadtrum SPI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8ff74a13faaa8..c17e7d62dbe16 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
 obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
 obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
 obj-$(CONFIG_SPI_SG2044_NOR)	+= spi-sg2044-nor.o
+obj-$(CONFIG_SPI_SPACEMIT_K1)		+= spi-spacemit-k1.o
 obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
 obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
 obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
new file mode 100644
index 0000000000000..c5a6ace67f64e
--- /dev/null
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -0,0 +1,966 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SpacemiT K1 SPI controller driver
+ *
+ * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
+ * Copyright (c) 2023, spacemit Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/scatterlist.h>
+#include <linux/sizes.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#include "internals.h"
+
+/* This is the range of transfer rates supported by the K1 SoC */
+#define K1_SPI_MIN_SPEED_HZ		6250
+#define K1_SPI_MAX_SPEED_HZ		51200000
+
+/* Default speed used if spi-max-frequency is invalid or not present */
+#define K1_SPI_DEFAULT_MAX_SPEED_HZ	25600000
+
+/* DMA constraints */
+#define K1_SPI_DMA_ALIGNMENT	64
+#define K1_SPI_MAX_DMA_LEN	SZ_512K
+
+/* SpacemiT K1 SPI Registers */
+
+/* SSP Top Control Register */
+#define SSP_TOP_CTRL		0x00
+#define TOP_SSE				BIT(0)		/* Enable port */
+#define TOP_FRF_MASK			GENMASK(2, 1)	/* Frame format */
+#define TOP_FRF_MOTOROLA			0	/* Motorola SPI */
+#define TOP_DSS_MASK			GENMASK(9, 5)	/* Data size (1-32) */
+#define TOP_SPO				BIT(10)		/* Polarity: 0=low */
+#define TOP_SPH				BIT(11)		/* Half-cycle phase */
+#define TOP_LBM				BIT(12)		/* Loopback mode */
+#define TOP_TRAIL			BIT(13)		/* Trailing bytes */
+#define TOP_HOLD_FRAME_LOW		BIT(14)		/* Master mode */
+
+/* SSP FIFO Control Register */
+#define SSP_FIFO_CTRL		0x04
+#define FIFO_TFT_MASK			GENMASK(4, 0)	/* TX FIFO threshold */
+#define FIFO_RFT_MASK			GENMASK(9, 5)	/* RX FIFO threshold */
+#define FIFO_TSRE			BIT(10)		/* TX service request */
+#define FIFO_RSRE			BIT(11)		/* RX service request */
+
+/* SSP Interrupt Enable Register */
+#define SSP_INT_EN		0x08
+#define SSP_INT_EN_TINTE		BIT(1)		/* RX timeout */
+#define SSP_INT_EN_RIE			BIT(2)		/* RX FIFO */
+#define SSP_INT_EN_TIE			BIT(3)		/* TX FIFO */
+#define SSP_INT_EN_RIM			BIT(4)		/* RX FIFO overrun */
+#define SSP_INT_EN_TIM			BIT(5)		/* TX FIFO underrun */
+
+/* SSP Time Out Register */
+#define SSP_TIMEOUT		0x0c
+#define SSP_TIMEOUT_MASK		GENMASK(23, 0)
+
+/* SSP Data Register */
+#define SSP_DATAR		0x10
+
+/* SSP Status Register */
+#define SSP_STATUS		0x14
+#define SSP_STATUS_BSY			BIT(0)		/* SPI/I2S busy */
+#define SSP_STATUS_TNF			BIT(6)		/* TX FIFO not full */
+#define SSP_STATUS_TFL			GENMASK(11, 7)	/* TX FIFO level */
+#define SSP_STATUS_TUR			BIT(12)		/* TX FIFO underrun */
+#define SSP_STATUS_RNE			BIT(14)		/* RX FIFO not empty */
+#define SSP_STATUS_RFL			GENMASK(19, 15)	/* RX FIFO level */
+#define SSP_STATUS_ROR			BIT(20)		/* RX FIFO overrun */
+
+/* The FIFO sizes and thresholds are the same for RX and TX */
+#define K1_SPI_FIFO_SIZE	32
+#define K1_SPI_THRESH		(K1_SPI_FIFO_SIZE / 2)
+
+struct k1_spi_io {
+	enum dma_data_direction dir;
+	struct dma_chan *chan;
+	void *buf;
+	unsigned int resid;
+	u32 nents;
+	struct sg_table sgt;
+};
+
+struct k1_spi_driver_data {
+	struct spi_controller *controller;
+	struct device *dev;
+	void __iomem *base;
+	unsigned long bus_rate;
+	struct clk *clk;
+	unsigned long rate;
+	u32 rx_timeout;
+	int irq;
+
+	struct k1_spi_io rx;
+	struct k1_spi_io tx;
+
+	void *dummy;			/* DMA disabled if NULL */
+	u32 base_addr;			/* DMA address corresponding to base */
+
+	struct spi_message *message;	/* Current message */
+
+	/* Current transfer information; not valid if message is null */
+	unsigned int len;
+	u32 bytes;			/* Bytes used for bits_per_word */
+	bool dma_mapped;
+	struct completion completion;	/* Transfer completion */
+};
+
+static bool k1_spi_dma_enabled(struct k1_spi_driver_data *drv_data)
+{
+	return !!drv_data->dummy;
+}
+
+static bool k1_spi_map_dma_buffer(struct k1_spi_io *io, size_t len, void *dummy)
+{
+	struct device *dmadev = io->chan->device->dev;
+	unsigned int nents = DIV_ROUND_UP(len, SZ_2K);
+	struct sg_table *sgt = &io->sgt;
+	void *bufp = io->buf ? : dummy;
+	struct scatterlist *sg;
+	unsigned int i;
+
+	if (nents != sgt->nents) {
+		sg_free_table(sgt);
+		if (sg_alloc_table(sgt, nents, GFP_KERNEL))
+			return false;
+	}
+
+	for_each_sg(sgt->sgl, sg, nents, i) {
+		size_t bytes = min_t(size_t, len, SZ_2K);
+
+		sg_set_buf(sg, bufp, bytes);
+		if (bufp != dummy)
+			bufp += bytes;
+		len -= bytes;
+	}
+	io->nents = dma_map_sg(dmadev, sgt->sgl, nents, io->dir);
+
+	return !!io->nents;
+}
+
+static void k1_spi_unmap_dma_buffer(struct k1_spi_io *io)
+{
+	struct sg_table *sgt = &io->sgt;
+
+	dma_unmap_sg(io->chan->device->dev, sgt->sgl, io->nents, io->dir);
+	io->nents = 0;
+}
+
+static bool k1_spi_map_dma_buffers(struct k1_spi_driver_data *drv_data)
+{
+	u32 dma_burst_size;
+	void *dummy;
+
+	if (!k1_spi_dma_enabled(drv_data))
+		return false;
+
+	dma_burst_size = K1_SPI_THRESH * drv_data->bytes;
+
+	/* Don't bother with DMA if we can't do even a single burst */
+	if (drv_data->len < dma_burst_size)
+		return false;
+
+	/* We won't use DMA if the transfer is too big, either */
+	if (drv_data->len > K1_SPI_MAX_DMA_LEN)
+		return false;
+
+	/* Map both directions for DMA; if either fails, we'll use PIO */
+	dummy = drv_data->dummy;
+	if (!k1_spi_map_dma_buffer(&drv_data->rx, drv_data->len, dummy))
+		return false;
+
+	if (k1_spi_map_dma_buffer(&drv_data->tx, drv_data->len, dummy))
+		return true;		/* Success! */
+
+	/* Failed to map the RX buffer; undo the TX mapping */
+	k1_spi_unmap_dma_buffer(&drv_data->rx);
+
+	return false;
+}
+
+static struct dma_async_tx_descriptor *
+k1_spi_prepare_dma_io(struct k1_spi_driver_data *drv_data, struct k1_spi_io *io)
+{
+	u32 addr = drv_data->base_addr + SSP_DATAR;
+	struct dma_slave_config cfg = { };
+	enum dma_transfer_direction dir;
+	enum dma_slave_buswidth width;
+	u32 dma_burst_size;
+	int ret;
+
+	dir = io->dir == DMA_TO_DEVICE ? DMA_MEM_TO_DEV
+				       : DMA_DEV_TO_MEM;
+
+	width = drv_data->bytes == 1 ? DMA_SLAVE_BUSWIDTH_1_BYTE :
+		drv_data->bytes == 2 ? DMA_SLAVE_BUSWIDTH_2_BYTES
+		/* bytes == 4 */     : DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	dma_burst_size = K1_SPI_THRESH * drv_data->bytes;
+
+	cfg.direction = dir;
+	if (dir == DMA_MEM_TO_DEV) {
+		cfg.dst_addr = addr;
+		cfg.dst_addr_width = width;
+		cfg.dst_maxburst = dma_burst_size;
+	} else {
+		cfg.src_addr = addr;
+		cfg.src_addr_width = width;
+		cfg.src_maxburst = dma_burst_size;
+	}
+
+	ret = dmaengine_slave_config(io->chan, &cfg);
+	if (ret)
+		return NULL;
+
+	return dmaengine_prep_slave_sg(io->chan, io->sgt.sgl, io->nents, dir,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+}
+
+/* DMA completion callback */
+static void k1_spi_callback(void *data)
+{
+	complete(data);
+}
+
+static bool k1_spi_transfer_start_dma(struct k1_spi_driver_data *drv_data)
+{
+	struct dma_async_tx_descriptor *rx_desc;
+	struct dma_async_tx_descriptor *tx_desc;
+	struct device *dev = drv_data->dev;
+	u32 val;
+
+	rx_desc = k1_spi_prepare_dma_io(drv_data, &drv_data->rx);
+	if (!rx_desc) {
+		dev_err(dev, "failed to get DMA RX descriptor\n");
+		return false;
+	}
+
+	tx_desc = k1_spi_prepare_dma_io(drv_data, &drv_data->tx);
+	if (!tx_desc) {
+		dev_err(dev, "failed to get DMA TX descriptor\n");
+		return false;
+	}
+
+	val = readl(drv_data->base + SSP_TOP_CTRL);
+	val |= TOP_TRAIL;	/* Trailing bytes handled by DMA */
+	writel(val, drv_data->base + SSP_TOP_CTRL);
+
+	val = readl(drv_data->base + SSP_FIFO_CTRL);
+	val |= FIFO_TSRE | FIFO_RSRE;
+	writel(val, drv_data->base + SSP_FIFO_CTRL);
+
+	/* When RX is complete we also know TX has completed */
+	rx_desc->callback = k1_spi_callback;
+	rx_desc->callback_param = &drv_data->completion;
+
+	dmaengine_submit(rx_desc);
+	dmaengine_submit(tx_desc);
+
+	dma_async_issue_pending(drv_data->rx.chan);
+	dma_async_issue_pending(drv_data->tx.chan);
+
+	return true;
+}
+
+static void k1_spi_transfer_end_dma(struct k1_spi_driver_data *drv_data)
+{
+	u32 val;
+
+	val = readl(drv_data->base + SSP_FIFO_CTRL);
+	val &= ~(FIFO_TSRE | FIFO_RSRE);
+	writel(val, drv_data->base + SSP_FIFO_CTRL);
+
+	val = readl(drv_data->base + SSP_TOP_CTRL);
+	val &= ~TOP_TRAIL;		/* Trailing bytes handled by the CPU */
+	writel(val, drv_data->base + SSP_TOP_CTRL);
+
+	/* Signal an error if an RX overrun or TX underrun occurred */
+	val = readl(drv_data->base + SSP_STATUS);
+	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR))
+		drv_data->message->status = -EIO;
+}
+
+/* Discard any data in the RX FIFO */
+static void k1_spi_flush(struct k1_spi_driver_data *drv_data)
+{
+	u32 val = readl(drv_data->base + SSP_STATUS);
+	u32 count;
+
+	/* If there's nothing in the FIFO, we're done */
+	if (!(val & SSP_STATUS_RNE))
+		return;
+
+	/* Read and discard what's there (one more than what the field says) */
+	count = FIELD_GET(SSP_STATUS_RFL, val) + 1;
+	do
+		(void)readl(drv_data->base + SSP_DATAR);
+	while (--count);
+}
+
+/* Set the transfer speed; the SPI core code ensures it is supported */
+static bool k1_spi_set_speed(struct k1_spi_driver_data *drv_data, u32 rate)
+{
+	struct clk *clk = drv_data->clk;
+	u64 nsec_per_word;
+	u64 bus_ticks;
+
+	if (clk_set_rate(clk, rate))
+		return false;
+
+	drv_data->rate = clk_get_rate(clk);
+
+	/*
+	 * Compute the RX FIFO inactivity timeout value that should be used.
+	 * The inactivity timer restarts with each word that lands in the
+	 * FIFO.  If two or more "word transfer times" pass without any new
+	 * data in the RX FIFO, we might as well read what's there.
+	 *
+	 * The rate at which words land in the FIFO is determined by the
+	 * word size and the transfer rate.  One bit is transferred per
+	 * clock tick, and 8 (or 16 or 32) bits are transferred per word.
+	 *
+	 * So we can get word transfer time (in nanoseconds) from:
+	 *   nsec_per_tick = NANOHZ_PER_HZ / drv_data->rate;
+	 *   ticks_per_word = BITS_PER_BYTE * drv_data->bytes;
+	 * We do the divide last for better accuracy.
+	 */
+	nsec_per_word = NANOHZ_PER_HZ * BITS_PER_BYTE * drv_data->bytes;
+	nsec_per_word = DIV_ROUND_UP_ULL(nsec_per_word, drv_data->rate);
+
+	/*
+	 * The timeout (which we'll set to three word transfer times) is
+	 * expressed as a number of APB clock ticks.
+	 *   bus_ticks = 3 * nsec * (drv_data->bus_rate / NANOHZ_PER_HZ)
+	 */
+	bus_ticks = 3 * nsec_per_word * drv_data->bus_rate;
+	drv_data->rx_timeout = DIV_ROUND_UP_ULL(bus_ticks, NANOHZ_PER_HZ);
+
+	return true;
+}
+
+static void k1_spi_read_word(struct k1_spi_driver_data *drv_data)
+{
+	struct k1_spi_io *rx = &drv_data->rx;
+	u32 bytes = drv_data->bytes;
+	u32 val;
+
+	val = readl(drv_data->base + SSP_DATAR);
+	rx->resid -= bytes;
+
+	if (!rx->buf)
+		return;	/* Null reader: discard the data */
+
+	if (bytes == 1)
+		*(u8 *)rx->buf = val;
+	else if (bytes == 2)
+		*(u16 *)rx->buf = val;
+	else	/* bytes == 4 */
+		*(u32 *)rx->buf = val;
+
+	rx->buf += bytes;
+}
+
+static bool k1_spi_read(struct k1_spi_driver_data *drv_data)
+{
+	struct k1_spi_io *rx = &drv_data->rx;
+	unsigned int count;
+	u32 val;
+
+	if (!rx->resid)
+		return true;	/* Nothing more to receive */
+
+	/* We'll read as many slots in the FIFO as there are available */
+	val = readl(drv_data->base + SSP_STATUS);
+	/* The number of open slots is one more than what's in the field */
+	count = FIELD_GET(SSP_STATUS_RFL, val) + 1;
+
+	/* A full FIFO count means the FIFO is either full or empty */
+
+	if (count == K1_SPI_FIFO_SIZE)
+		if (!(val & SSP_STATUS_RNE))
+			return false;	/* Nothing available to read */
+
+	count = min(count, rx->resid);
+	while (count--)
+		k1_spi_read_word(drv_data);
+
+	return !rx->resid;
+}
+
+static void k1_spi_write_word(struct k1_spi_driver_data *drv_data)
+{
+	struct k1_spi_io *tx = &drv_data->tx;
+	u32 val = 0;
+	u32 bytes;
+
+	bytes = drv_data->bytes;
+	if (tx->buf) {
+		if (bytes == 1)
+			val = *(u8 *)tx->buf;
+		else if (bytes == 2)
+			val = *(u16 *)tx->buf;
+		else	/* bytes == 4 */
+			val = *(u32 *)tx->buf;
+		tx->buf += bytes;
+	} /* Otherwise null writer; write 1, 2, or 4 zero bytes */
+
+	tx->resid -= bytes;
+	writel(val, drv_data->base + SSP_DATAR);
+}
+
+static bool k1_spi_write(struct k1_spi_driver_data *drv_data)
+{
+	struct k1_spi_io *tx = &drv_data->tx;
+	unsigned int count;
+	u32 val;
+
+	if (!tx->resid)
+		return true;	/* Nothing more to send */
+
+	/* See how many slots in the TX FIFO are available */
+	val = readl(drv_data->base + SSP_STATUS);
+	count = FIELD_GET(SSP_STATUS_TFL, val);
+
+	/* A zero count means the FIFO is either full or empty */
+	if (!count) {
+		if (val & SSP_STATUS_TNF)
+			count = K1_SPI_FIFO_SIZE;
+		else
+			return false;	/* No room in the FIFO */
+	}
+
+	/*
+	 * Limit how much we try to send at a time, to reduce the
+	 * chance the other side can overrun our RX FIFO.
+	 */
+	count = min3(count, K1_SPI_THRESH, tx->resid);
+	while (count--)
+		k1_spi_write_word(drv_data);
+
+	return !tx->resid;
+}
+
+static bool k1_spi_transfer_start(struct k1_spi_driver_data *drv_data,
+				  struct spi_transfer *transfer)
+{
+	u32 val;
+
+	/* Bits per word can change on a per-transfer basis */
+	drv_data->bytes = spi_bpw_to_bytes(transfer->bits_per_word);
+
+	/* Each transfer can also specify a different rate */
+	if (!k1_spi_set_speed(drv_data, transfer->speed_hz)) {
+		dev_err(drv_data->dev, "failed to set transfer speed\n");
+		return false;
+	}
+
+	k1_spi_flush(drv_data);
+
+	/* Record the current transfer information */
+	drv_data->rx.buf = transfer->rx_buf;
+	drv_data->rx.resid = transfer->len;
+	drv_data->tx.buf = (void *)transfer->tx_buf;
+	drv_data->tx.resid = transfer->len;
+	drv_data->len = transfer->len;
+
+	drv_data->dma_mapped = k1_spi_map_dma_buffers(drv_data);
+
+	/* Set the RX timeout period (required for both DMA and PIO) */
+	val = FIELD_PREP(SSP_TIMEOUT_MASK, drv_data->rx_timeout);
+	writel(val, drv_data->base + SSP_TIMEOUT);
+
+	/* Clear any existing interrupt conditions */
+	val = readl(drv_data->base + SSP_STATUS);
+	writel(val, drv_data->base + SSP_STATUS);
+
+	/* Set the data size and enable the hardware */
+	val = readl(drv_data->base + SSP_TOP_CTRL);
+	val |= FIELD_PREP(TOP_DSS_MASK, transfer->bits_per_word - 1);
+	val |= TOP_SSE;
+	writel(val, drv_data->base + SSP_TOP_CTRL);
+
+	/* DMA transfers are programmmed, then initiated */
+	if (drv_data->dma_mapped)
+		return k1_spi_transfer_start_dma(drv_data);
+
+	/*
+	 * For PIO transfers, interrupts will cause words to get
+	 * transferred.  The interrupts will get disabled as the
+	 * transfer completes.  We'll write what we can to get
+	 * things started.
+	 */
+	(void)k1_spi_write(drv_data);
+
+	val = SSP_INT_EN_RIM | SSP_INT_EN_TIM;
+	val |= SSP_INT_EN_TINTE | SSP_INT_EN_RIE | SSP_INT_EN_TIE;
+	writel(val, drv_data->base + SSP_INT_EN);
+
+	return true;
+}
+
+static void k1_spi_transfer_end(struct k1_spi_driver_data *drv_data,
+				struct spi_transfer *transfer)
+{
+	struct spi_message *message = drv_data->message;
+	u32 val;
+
+	if (drv_data->dma_mapped)
+		k1_spi_transfer_end_dma(drv_data);
+
+	val = readl(drv_data->base + SSP_TOP_CTRL);
+	val &= ~TOP_SSE;
+	val &= ~TOP_DSS_MASK;
+	writel(val, drv_data->base + SSP_TOP_CTRL);
+
+	writel(0, drv_data->base + SSP_TIMEOUT);
+
+	if (drv_data->dma_mapped) {
+		k1_spi_unmap_dma_buffer(&drv_data->tx);
+		k1_spi_unmap_dma_buffer(&drv_data->rx);
+	}
+
+	spi_transfer_delay_exec(transfer);
+
+	if (!message->status)
+		message->actual_length += drv_data->len;
+}
+
+static void k1_spi_transfer_wait(struct k1_spi_driver_data *drv_data)
+{
+	struct completion *completion = &drv_data->completion;
+	struct spi_message *message = drv_data->message;
+	unsigned long timeout;
+	int ret;
+
+	/* Length in bits to be transferred */
+	timeout = BITS_PER_BYTE * drv_data->bytes * drv_data->len;
+	/* Time (usec) to transfer that many bits at the current bit rate */
+	timeout = DIV_ROUND_UP(timeout * MICROHZ_PER_HZ, drv_data->rate);
+	/* Convert that (+ 25%) to jiffies for the wait call */
+	timeout = usecs_to_jiffies(5 * timeout / 4);
+
+	ret = wait_for_completion_interruptible_timeout(completion, timeout);
+	if (ret > 0)
+		return;
+
+	message->status = -EIO;
+	if (ret && drv_data->dma_mapped) {
+		dmaengine_terminate_sync(drv_data->tx.chan);
+		dmaengine_terminate_sync(drv_data->rx.chan);
+	}
+}
+
+static int k1_spi_transfer_one_message(struct spi_controller *host,
+					   struct spi_message *message)
+{
+	struct k1_spi_driver_data *drv_data = spi_controller_get_devdata(host);
+	struct completion *completion = &drv_data->completion;
+	struct spi_transfer *transfer;
+	u32 val;
+
+	drv_data->message = message;
+
+	/* Message status starts out successful; set to -EIO on error */
+	message->status = 0;
+
+	/* Hold frame low to avoid losing transferred data */
+	val = readl(drv_data->base + SSP_TOP_CTRL);
+	val |= TOP_HOLD_FRAME_LOW;
+	writel(val, drv_data->base + SSP_TOP_CTRL);
+
+	list_for_each_entry(transfer, &message->transfers, transfer_list) {
+		reinit_completion(completion);
+
+		/* Issue the next transfer */
+		if (!k1_spi_transfer_start(drv_data, transfer)) {
+			message->status = -EIO;
+			break;
+		}
+
+		k1_spi_transfer_wait(drv_data);
+
+		k1_spi_transfer_end(drv_data, transfer);
+
+		/* If an error has occurred, we're done */
+		if (message->status)
+			break;
+	}
+
+	drv_data->message = NULL;
+
+	spi_finalize_current_message(drv_data->controller);
+
+	val = readl(drv_data->base + SSP_TOP_CTRL);
+	val &= ~TOP_HOLD_FRAME_LOW;
+	writel(val, drv_data->base + SSP_TOP_CTRL);
+
+	return 0;
+}
+
+/*
+ * The client can call the setup function multiple times, and each call
+ * can specify a different SPI mode (and transfer speed).  Each transfer
+ * can specify its own speed though, and the core code ensures each
+ * transfer's speed is set to something nonzero and supported by both
+ * the controller and the device).  We just set the speed for each
+ * transfer.
+ */
+static int k1_spi_setup(struct spi_device *spi)
+{
+	struct k1_spi_driver_data *drv_data;
+	u32 val;
+
+	drv_data = spi_controller_get_devdata(spi->controller);
+
+	/*
+	 * Configure the message format for this device.  We only
+	 * support Motorola SPI format in master mode.
+	 */
+	val = FIELD_PREP(TOP_FRF_MASK, TOP_FRF_MOTOROLA);
+	val |= TOP_HOLD_FRAME_LOW;	/* Master mode */
+
+	/* Translate the mode into the value used to program the hardware. */
+	if (spi->mode & SPI_CPHA)
+		val |= TOP_SPH;		/* 1/2 cycle */
+	if (spi->mode & SPI_CPOL)
+		val |= TOP_SPO;		/* active low */
+	if (spi->mode & SPI_LOOP)
+		val |= TOP_LBM;		/* enable loopback */
+	writel(val, drv_data->base + SSP_TOP_CTRL);
+
+	return 0;
+}
+
+static void k1_spi_cleanup(struct spi_device *spi)
+{
+	struct k1_spi_driver_data *drv_data;
+
+	drv_data = spi_controller_get_devdata(spi->controller);
+
+	writel(0, drv_data->base + SSP_TOP_CTRL);
+}
+
+static int k1_spi_dma_setup_io(struct k1_spi_driver_data *drv_data, bool rx)
+{
+	struct dma_chan *chan;
+	struct k1_spi_io *io;
+
+	chan = dma_request_chan(drv_data->dev, rx ? "rx" : "tx");
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+
+	io = rx ? &drv_data->rx : &drv_data->tx;
+	io->dir = rx ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	io->chan = chan;
+
+	return 0;
+}
+
+static void k1_spi_dma_cleanup_io(struct k1_spi_driver_data *drv_data, bool rx)
+{
+	struct k1_spi_io *io = rx ? &drv_data->rx : &drv_data->tx;
+
+	dmaengine_terminate_sync(io->chan);
+	sg_free_table(&io->sgt);
+
+	dma_release_channel(io->chan);
+}
+
+static int k1_spi_dma_setup(struct k1_spi_driver_data *drv_data)
+{
+	struct device *dev = drv_data->dev;
+	int rx_ret;
+	int tx_ret;
+
+	/* We must get both DMA channels, or neither of them */
+	rx_ret = k1_spi_dma_setup_io(drv_data, true);
+	if (rx_ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	tx_ret = k1_spi_dma_setup_io(drv_data, false);
+
+	/* If neither is specified, we don't use DMA (as intended) */
+	if (rx_ret == -ENODEV && tx_ret == -ENODEV)
+		return 0;		/* Success!  PIO will be used */
+
+	if (rx_ret || tx_ret)
+		goto err_cleanup;
+
+	drv_data->dummy = kzalloc(SZ_2K, GFP_KERNEL);
+	if (drv_data->dummy)
+		return 0;		/* Success!  DMA will be used */
+
+	dev_warn(dev, "error allocating DMA dummy buffer; DMA disabled\n");
+err_cleanup:
+	if (!tx_ret)
+		k1_spi_dma_cleanup_io(drv_data, false);
+	else if (tx_ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (rx_ret)
+		dev_err(dev, "error requesting DMA RX DMA channel\n");
+	else
+		k1_spi_dma_cleanup_io(drv_data, true);
+
+	/* Return success if we don't get the dummy buffer; PIO will be used */
+
+	return rx_ret ? : tx_ret ? : 0;
+}
+
+static void k1_spi_dma_cleanup(struct device *dev, void *res)
+{
+	struct k1_spi_driver_data *drv_data;
+
+	drv_data = *(struct k1_spi_driver_data **)res;
+	if (!k1_spi_dma_enabled(drv_data))
+		return;
+
+	kfree(drv_data->dummy);
+	k1_spi_dma_cleanup_io(drv_data, false);
+	k1_spi_dma_cleanup_io(drv_data, true);
+}
+
+static int devm_k1_spi_dma_setup(struct k1_spi_driver_data *drv_data)
+{
+	struct k1_spi_driver_data **ptr;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_MMP_PDMA)) {
+		dev_warn(drv_data->dev, "DMA not available; using PIO\n");
+		return 0;
+	}
+
+	ptr = devres_alloc(k1_spi_dma_cleanup, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = k1_spi_dma_setup(drv_data);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = drv_data;
+	devres_add(drv_data->dev, ptr);
+
+	return 0;
+}
+
+static const struct of_device_id k1_spi_dt_ids[] = {
+	{ .compatible = "spacemit,k1-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, k1_spi_dt_ids);
+
+static void k1_spi_host_init(struct k1_spi_driver_data *drv_data)
+{
+	struct device_node *np = dev_of_node(drv_data->dev);
+	struct spi_controller *host = drv_data->controller;
+	struct device *dev = drv_data->dev;
+	u32 max_speed_hz;
+	int ret;
+
+	host->dev.of_node = np;
+	host->dev.parent = drv_data->dev;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	host->num_chipselect = 1;
+
+	if (k1_spi_dma_enabled(drv_data))
+		host->dma_alignment = K1_SPI_DMA_ALIGNMENT;
+	host->cleanup = k1_spi_cleanup;
+	host->setup = k1_spi_setup;
+	host->transfer_one_message = k1_spi_transfer_one_message;
+
+	ret = of_property_read_u32(np, "spi-max-frequency", &max_speed_hz);
+	if (!ret) {
+		host->max_speed_hz = clamp(max_speed_hz, K1_SPI_MIN_SPEED_HZ,
+					   K1_SPI_MAX_SPEED_HZ);
+		if (host->max_speed_hz != max_speed_hz)
+			dev_warn(dev, "spi-max-frequency %u out of range, using %u\n",
+				max_speed_hz, host->max_speed_hz);
+	} else {
+		if (ret != -EINVAL)
+			dev_warn(dev, "bad spi-max-frequency, using %u\n",
+				 K1_SPI_DEFAULT_MAX_SPEED_HZ);
+		host->max_speed_hz = K1_SPI_DEFAULT_MAX_SPEED_HZ;
+	}
+}
+
+/* Set our registers to a known initial state */
+static void
+k1_spi_register_reset(struct k1_spi_driver_data *drv_data, bool initial)
+{
+	u32 val = 0;
+
+	writel(0, drv_data->base + SSP_TOP_CTRL);
+
+	if (initial) {
+		/*
+		 * The TX and RX FIFO thresholds are the same no matter
+		 * what the speed or bits per word, so we can just set
+		 * them once.  The thresholds are one more than the values
+		 * in the register.
+		 */
+		val = FIELD_PREP(FIFO_RFT_MASK, K1_SPI_THRESH - 1);
+		val |= FIELD_PREP(FIFO_TFT_MASK, K1_SPI_THRESH - 1);
+	}
+	writel(val, drv_data->base + SSP_FIFO_CTRL);
+
+	writel(0, drv_data->base + SSP_INT_EN);
+	writel(0, drv_data->base + SSP_TIMEOUT);
+
+	/* Clear any pending interrupt conditions */
+	val = readl(drv_data->base + SSP_STATUS);
+	writel(val, drv_data->base + SSP_STATUS);
+}
+
+static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
+{
+	struct k1_spi_driver_data *drv_data = dev_id;
+	bool rx_done;
+	bool tx_done;
+	u32 val;
+
+	/* Get status and clear pending interrupts */
+	val = readl(drv_data->base + SSP_STATUS);
+	writel(val, drv_data->base + SSP_STATUS);
+
+	if (!drv_data->message)
+		return IRQ_NONE;
+
+	/* Check for an RX overrun or TX underrun first */
+	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR)) {
+		/* Disable all interrupts on error */
+		writel(0, drv_data->base + SSP_INT_EN);
+
+		drv_data->message->status = -EIO;
+		complete(&drv_data->completion);
+
+		return IRQ_HANDLED;
+	}
+
+	/* Drain the RX FIFO first, then transmit what we can */
+	rx_done = k1_spi_read(drv_data);
+	tx_done = k1_spi_write(drv_data);
+
+	/* Disable interrupts if we're done transferring either direction */
+	if (rx_done || tx_done) {
+		/* If both are done, disable all interrupts */
+		if (rx_done && tx_done) {
+			val = 0;
+		} else {
+			val = readl(drv_data->base + SSP_INT_EN);
+			if (rx_done)
+				val &= ~(SSP_INT_EN_TINTE | SSP_INT_EN_RIE);
+			if (tx_done)
+				val &= ~SSP_INT_EN_TIE;
+		}
+		writel(val, drv_data->base + SSP_INT_EN);
+	}
+
+	if (rx_done && tx_done)
+		complete(&drv_data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int k1_spi_probe(struct platform_device *pdev)
+{
+	struct k1_spi_driver_data *drv_data;
+	struct device *dev = &pdev->dev;
+	struct reset_control *reset;
+	struct spi_controller *host;
+	struct resource *iores;
+	struct clk *clk_bus;
+	int ret;
+
+	host = devm_spi_alloc_host(dev, sizeof(*drv_data));
+	if (!host)
+		return -ENOMEM;
+	drv_data = spi_controller_get_devdata(host);
+	drv_data->controller = host;
+	platform_set_drvdata(pdev, drv_data);
+	drv_data->dev = dev;
+	init_completion(&drv_data->completion);
+
+	drv_data->base = devm_platform_get_and_ioremap_resource(pdev, 0,
+								&iores);
+	if (IS_ERR(drv_data->base))
+		return dev_err_probe(dev, PTR_ERR(drv_data->base),
+				     "error mapping memory\n");
+	drv_data->base_addr = iores->start;
+
+	ret = devm_k1_spi_dma_setup(drv_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "error setting up DMA\n");
+
+	k1_spi_host_init(drv_data);
+
+	clk_bus = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(clk_bus))
+		return dev_err_probe(dev, PTR_ERR(clk_bus),
+				     "error getting/enabling bus clock\n");
+	drv_data->bus_rate = clk_get_rate(clk_bus);
+
+	drv_data->clk = devm_clk_get_enabled(dev, "core");
+	if (IS_ERR(drv_data->clk))
+		return dev_err_probe(dev, PTR_ERR(drv_data->clk),
+				     "error getting/enabling core clock\n");
+
+	reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				     "error getting/deasserting reset\n");
+
+	k1_spi_register_reset(drv_data, true);
+
+	drv_data->irq = platform_get_irq(pdev, 0);
+	if (drv_data->irq < 0)
+		return dev_err_probe(dev, drv_data->irq, "error getting IRQ\n");
+
+	ret = devm_request_irq(dev, drv_data->irq, k1_spi_ssp_isr,
+			       IRQF_SHARED, dev_name(dev), drv_data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "error requesting IRQ\n");
+
+	ret = devm_spi_register_controller(dev, host);
+	if (ret)
+		dev_err(dev, "error registering controller\n");
+
+	return ret;
+}
+
+static void k1_spi_remove(struct platform_device *pdev)
+{
+	struct k1_spi_driver_data *drv_data = platform_get_drvdata(pdev);
+
+	k1_spi_register_reset(drv_data, false);
+}
+
+static struct platform_driver k1_spi_driver = {
+	.driver = {
+		.name		= "k1-spi",
+		.of_match_table	= k1_spi_dt_ids,
+	},
+	.probe			= k1_spi_probe,
+	.remove			= k1_spi_remove,
+};
+
+module_platform_driver(k1_spi_driver);
+
+MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


