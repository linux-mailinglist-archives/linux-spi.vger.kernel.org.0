Return-Path: <linux-spi+bounces-10091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F67B821C5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463B07B4D21
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D5A30FC27;
	Wed, 17 Sep 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="PAits0+p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1030E85E
	for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146856; cv=none; b=THS8mciFF3qaV+FXNMEWFgOeiDTock4dgG6hDJFSa9k6PzpCWPdWzfrZ3XhknuQH7HvwueblXmBjIUJlLRHJaIRQpbu7hJFYZ6VxSMOk/ZJWdzWbXemdEuyj+ad9oXKEYT8SrZE3Oapmp1RrEWgfHAPs4748G5+afN40GxWWfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146856; c=relaxed/simple;
	bh=UOkAzzQuy3LWzjbSBXNgt6bZvXte9WduzJnLoO7aaVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFfNn6NUheC7PdeJxER3qDt/CUf0CksmdMtUpsNt9Q9IoKidjQU6vM6tUgtkgW/2zYRPSfZJCa7lDGxb+zf/P+wc21OhjigxdzKx9de/AEf6szxaQ/zv/7o2lkMlHcgQN/7qY8EHuAbLwnn/8Eu1x0cdQlWCK4e2HxRv5UoE+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=PAits0+p; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-424117c229aso2688055ab.0
        for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758146852; x=1758751652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGQtGp62UKeUTIRX/tlGYpYMA2uV9fKED2PtfG5fsQs=;
        b=PAits0+p4TSyD6XjWUOqxzUf7gAuqsDM4kmU1qYKENVEWuNMmX3YyhKa+BiH77vDwq
         btwsiWlrnqaCuubLb52Q9prJYVjimJeb5/nLs3WyYHQjahR0JD54ueU0J+Dwno+5qkmS
         yUkjtQ/ZoTheiMF9R30Bs6f7D7h10X4ucUgRw9A+2PgHfEGZC6eGa01ba8OUaJI5+ZEo
         C6WUKvuWbbTdp5Auzac0CgY6Pm9PFcKk5/cWPZttXDu5DUFDVPsuZjV09XWvZs11svTI
         9+Nd4Zq04cM+8gxXul9wMEprz5XeMYDGxScOQ9pu6ldzxYxLY9dMKmFrdmJT+lFcV5w9
         NPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146852; x=1758751652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGQtGp62UKeUTIRX/tlGYpYMA2uV9fKED2PtfG5fsQs=;
        b=A+qoiWRQZEAPOD10+4BAcfl3KH2rgvCoiV7+lSmiGePc1+8HVBY4/Z6ufjAdMYuX1N
         DFtMt9sgGMQz698hJ9Qblmv7FuM80ZeH+QE9y1cr4Xben1Ih3jGdMQfEzdnDbplDgleA
         /jMD/xeXKMs4Amyot0ZawU7o6gCwaN7Gxz93yByCjvBM/ieUpGQdv9Duncpz37bkclpE
         S9FWsogofEF98fQnBVSnJfDqkvzOTwB0VGv+2ArdgEGylH8Wge0Hm8ipSnaMU1HuNlbw
         +WZCLumlg/WI72RBEYMOSV3QrUCFF42lto6QeNCnB3SdyCZOTvmIVbEd1CQfA4JRByGo
         BHNw==
X-Gm-Message-State: AOJu0Yzz0moH3YLL+zLJN1W2TgQVycmVwiyG1w6nAzvL92q2fPhDu6T8
	YQhIU+34dXHW8RSryd3RyoZMkdTqCnvQRHUVapqHP7Sq72BxAVfiVI511i4u8kfzYtc=
X-Gm-Gg: ASbGncvjUPml5hm8ZgonvNoeWgSgiljYMla1vyhtISQj5boCUSm1un7fUdv5Sr6HSSs
	fPhLuL5f4+tCONZkPGdxiKabTn35JnilDdn4yuV31Vztahomv/NjWLR9HEny2olRwx8gM0ZIWzm
	OFAHpWlzJNRgd3hGOAClUaHA2cJ/vcy5EmtmJAOuuJYSkdID87QWW7urBvrKewVUZy1d0L2VBFD
	+32fZVQJsXIYMJ59BNO/XwopME0viOP7Qg/qKB/xvC+xKiBct+il+MTNimcFMPj4lZvT9neUQ0a
	4DAszwtYuSbM4uy7M9DgCegzr4HRFoCBWbFDWU3BPHZAZcNNDmn9JZhvOK7UF7ehE/SC7wACHB/
	rfE1vMCKZSfB3yNki9fAR2cx44Niy28cgmmsjNnOoCHOV0AT/hbbnRld7p6BKI5WM1uTdjyB32S
	ajXIVhMOOS
X-Google-Smtp-Source: AGHT+IHpsvS6iQUY8qyhC3NYaG1C1hgoVeQZuZ83fBJcY+JXzZ+68/cetIxJQgGXojJ/2ewN8CUGbw==
X-Received: by 2002:a05:6e02:12e7:b0:415:fe45:3dfe with SMTP id e9e14a558f8ab-4241a4bf8eamr59612765ab.3.1758146851852;
        Wed, 17 Sep 2025 15:07:31 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm2346335ab.22.2025.09.17.15.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:07:31 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
Date: Wed, 17 Sep 2025 17:07:22 -0500
Message-ID: <20250917220724.288127-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250917220724.288127-1-elder@riscstar.com>
References: <20250917220724.288127-1-elder@riscstar.com>
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
 drivers/spi/Kconfig           |   8 +
 drivers/spi/Makefile          |   1 +
 drivers/spi/spi-spacemit-k1.c | 985 ++++++++++++++++++++++++++++++++++
 3 files changed, 994 insertions(+)
 create mode 100644 drivers/spi/spi-spacemit-k1.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 82fa5eb3b8684..915a52407a85a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -577,6 +577,14 @@ config SPI_KSPI2
 	  This driver can also be built as a module. If so, the module
 	  will be called spi-kspi2.
 
+config SPI_SPACEMIT_K1
+	tristate "K1 SPI Controller"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on OF
+	default ARCH_SPACEMIT
+	help
+	  Enable support for the SpacemiT K1 SPI controller.
+
 config SPI_LM70_LLP
 	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
 	depends on PARPORT
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index eefaeca097456..29d55eeb9abb4 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
 obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o
 obj-$(CONFIG_SPI_INTEL_PCI)		+= spi-intel-pci.o
 obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
+obj-$(CONFIG_SPI_SPACEMIT_K1)		+= spi-spacemit-k1.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
 obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
 obj-$(CONFIG_SPI_KSPI2)			+= spi-kspi2.o
diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
new file mode 100644
index 0000000000000..6edf75efe7c68
--- /dev/null
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -0,0 +1,985 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for SpacemiT K1 SPI controller
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
+/* This is used if the spi-max-frequency property is not present */
+#define K1_SPI_MAX_SPEED_HZ	25600000
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
+	void __iomem *ioaddr;
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
+	u32 data_reg_addr;		/* DMA address of the data register */
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
+	u32 addr = drv_data->data_reg_addr;
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
+				     : DMA_SLAVE_BUSWIDTH_4_BYTES;
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
+	void __iomem *virt;
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
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val |= TOP_TRAIL;	/* Trailing bytes handled by DMA */
+	writel(val, virt);
+
+	virt = drv_data->ioaddr + SSP_FIFO_CTRL;
+	val = readl(virt);
+	val |= FIFO_TSRE | FIFO_RSRE;
+	writel(val, virt);
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
+	void __iomem *virt;
+	u32 val;
+
+	virt = drv_data->ioaddr + SSP_FIFO_CTRL;
+	val = readl(virt);
+	val &= ~(FIFO_TSRE | FIFO_RSRE);
+	writel(val, virt);
+
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val &= ~TOP_TRAIL;		/* Trailing bytes handled by the CPU */
+	writel(val, virt);
+
+	/* Signal an error if an RX overflow or TX underflow occurred */
+	val = readl(drv_data->ioaddr + SSP_STATUS);
+	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR))
+		drv_data->message->status = -EIO;
+}
+
+/* Discard any data in the RX FIFO */
+static void k1_spi_flush(struct k1_spi_driver_data *drv_data)
+{
+	u32 val = readl(drv_data->ioaddr + SSP_STATUS);
+	u32 count;
+
+	/* If there's nothing in the FIFO, we're done */
+	if (!(val & SSP_STATUS_RNE))
+		return;
+
+	/* Read and discard what's there (one more than what the field says) */
+	count = FIELD_GET(SSP_STATUS_RFL, val) + 1;
+	do
+		(void)readl(drv_data->ioaddr + SSP_DATAR);
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
+	nsec_per_word = DIV_ROUND_UP(nsec_per_word, drv_data->rate);
+
+	/*
+	 * The timeout (which we'll set to three word transfer times) is
+	 * expressed as a number of APB clock ticks.
+	 *   bus_ticks = 3 * nsec * (drv_data->bus_rate / NANOHZ_PER_HZ)
+	 */
+	bus_ticks = 3 * nsec_per_word * drv_data->bus_rate;
+	drv_data->rx_timeout = DIV_ROUND_UP(bus_ticks, NANOHZ_PER_HZ);
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
+	val = readl(drv_data->ioaddr + SSP_DATAR);
+	rx->resid -= bytes;
+
+	if (!rx->buf)
+		return;	/* Null reader: discard the data */
+
+	if (bytes == 1)
+		*(u8 *)rx->buf = val;
+	else if (bytes == 1)
+		*(u16 *)rx->buf = val;
+	else
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
+	val = readl(drv_data->ioaddr + SSP_STATUS);
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
+	u32 bytes;
+	u32 val;
+
+	bytes = drv_data->bytes;
+	if (tx->buf) {
+		if (bytes == 1)
+			val = *(u8 *)tx->buf;
+		else if (bytes == 2)
+			val = *(u16 *)tx->buf;
+		else if (bytes == 4)
+			val = *(u32 *)tx->buf;
+		tx->buf += bytes;
+	} else {
+		val = 0;	/* Null writer; write 1, 2, or 4 zero bytes */
+	}
+
+	tx->resid -= bytes;
+	writel(val, drv_data->ioaddr + SSP_DATAR);
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
+	val = readl(drv_data->ioaddr + SSP_STATUS);
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
+	void __iomem *virt;
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
+	writel(val, drv_data->ioaddr + SSP_TIMEOUT);
+
+	/* Data size is one more than the value in the TOP_DSS field */
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val |= FIELD_PREP(TOP_DSS_MASK, transfer->bits_per_word - 1);
+	writel(val, virt);
+
+	/* Clear any existing interrupt conditions */
+	val = readl(drv_data->ioaddr + SSP_STATUS);
+	writel(val, drv_data->ioaddr + SSP_STATUS);
+
+	/* Enable the hardware */
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val |= TOP_SSE;
+	writel(val, virt);
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
+	writel(val, drv_data->ioaddr + SSP_INT_EN);
+
+	return true;
+}
+
+static void k1_spi_transfer_end(struct k1_spi_driver_data *drv_data,
+				struct spi_transfer *transfer)
+{
+	struct spi_message *message = drv_data->message;
+	void __iomem *virt;
+	u32 val;
+
+	if (drv_data->dma_mapped)
+		k1_spi_transfer_end_dma(drv_data);
+
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val &= ~TOP_SSE;
+	writel(val, virt);
+
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val &= ~TOP_DSS_MASK;
+	writel(val, virt);
+
+	writel(0, drv_data->ioaddr + SSP_TIMEOUT);
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
+	void __iomem *virt;
+	u32 val;
+
+	drv_data->message = message;
+
+	/* Message status starts out successful; set to -EIO on error */
+	message->status = 0;
+
+	/* Hold frame low to avoid losing transferred data */
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val |= TOP_HOLD_FRAME_LOW;
+	writel(val, virt);
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
+	virt = drv_data->ioaddr + SSP_TOP_CTRL;
+	val = readl(virt);
+	val &= ~TOP_HOLD_FRAME_LOW;
+	writel(val, virt);
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
+	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);
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
+	writel(0, drv_data->ioaddr + SSP_TOP_CTRL);
+}
+
+static int k1_spi_dma_setup_io(struct k1_spi_driver_data *drv_data, bool rx)
+{
+	const char *name = rx ? "rx" : "tx";
+	struct device *dev = drv_data->dev;
+	struct dma_chan *chan;
+	struct k1_spi_io *io;
+
+	chan = devm_dma_request_chan(dev, name);
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
+	/* If neither is specified, we don't use DMA */
+	if (rx_ret == -ENODEV && tx_ret == -ENODEV)
+		return 0;
+
+	if (rx_ret || tx_ret)
+		goto err_cleanup;
+
+	drv_data->dummy = devm_kzalloc(dev, SZ_2K, GFP_KERNEL);
+	if (drv_data->dummy)
+		return 0;		/* Success! */
+
+	dev_warn(dev, "error allocating DMA dummy buffer; DMA disabled\n");
+err_cleanup:
+	if (tx_ret) {
+		if (tx_ret != -EPROBE_DEFER)
+			dev_err(dev, "error requesting DMA TX DMA channel\n");
+	} else {
+		k1_spi_dma_cleanup_io(drv_data, false);
+	}
+
+	if (rx_ret)
+		dev_err(dev, "error requesting DMA RX DMA channel\n");
+	else
+		k1_spi_dma_cleanup_io(drv_data, true);
+
+	if (tx_ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* Return success if we don't get the dummy buffer; PIO will be used */
+
+	return rx_ret ? : tx_ret ? : 0;
+}
+
+static void k1_spi_dma_cleanup(struct device *dev, void *res)
+{
+	struct k1_spi_driver_data *drv_data = res;
+
+	if (k1_spi_dma_enabled(drv_data)) {
+		k1_spi_dma_cleanup_io(drv_data, false);
+		k1_spi_dma_cleanup_io(drv_data, true);
+	}
+}
+
+static int devm_k1_spi_dma_setup(struct k1_spi_driver_data *drv_data)
+{
+	struct k1_spi_driver_data **ptr;
+	int ret;
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
+static void k1_spi_host_init(struct k1_spi_driver_data *drv_data, int id)
+{
+	struct device_node *np = dev_of_node(drv_data->dev);
+	struct spi_controller *host = drv_data->controller;
+	struct device *dev = drv_data->dev;
+	u32 bus_num;
+	int ret;
+
+	host->dev.of_node = np;
+	host->dev.parent = drv_data->dev;
+	if (!of_property_read_u32(np, "spacemit,k1-ssp-id", &bus_num))
+		host->bus_num = bus_num;
+	else
+		host->bus_num = id;
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
+	ret = of_property_read_u32(np, "spi-max-frequency", &host->max_speed_hz);
+	if (ret < 0) {
+		if (ret != -EINVAL)
+			dev_warn(dev, "bad spi-max-frequency, using %u\n",
+				 K1_SPI_MAX_SPEED_HZ);
+		host->max_speed_hz = K1_SPI_MAX_SPEED_HZ;
+	}
+}
+
+/* Set our registers to a known initial state */
+static void
+k1_spi_register_reset(struct k1_spi_driver_data *drv_data, bool initial)
+{
+	u32 val = 0;
+
+	writel(0, drv_data->ioaddr + SSP_TOP_CTRL);
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
+	writel(val, drv_data->ioaddr + SSP_FIFO_CTRL);
+
+	writel(0, drv_data->ioaddr + SSP_INT_EN);
+	writel(0, drv_data->ioaddr + SSP_TIMEOUT);
+
+	/* Clear any pending interrupt conditions */
+	val = readl(drv_data->ioaddr + SSP_STATUS);
+	writel(val, drv_data->ioaddr + SSP_STATUS);
+}
+
+static irqreturn_t k1_spi_ssp_isr(int irq, void *dev_id)
+{
+	struct k1_spi_driver_data *drv_data = dev_id;
+	void __iomem *virt;
+	bool rx_done;
+	bool tx_done;
+	u32 val;
+
+	/* Get status and clear pending interrupts */
+	virt = drv_data->ioaddr + SSP_STATUS;
+	val = readl(virt);
+	writel(val, virt);
+
+	if (!drv_data->message)
+		return IRQ_NONE;
+
+	/* Check for a TX underrun or RX underrun first */
+	if (val & (SSP_STATUS_TUR | SSP_STATUS_ROR)) {
+		/* Disable all interrupts on error */
+		writel(0, drv_data->ioaddr + SSP_INT_EN);
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
+		virt = drv_data->ioaddr + SSP_INT_EN;
+
+		/* If both are done, disable all interrupts */
+		if (rx_done && tx_done) {
+			val = 0;
+		} else {
+			val = readl(virt);
+			if (rx_done)
+				val &= ~(SSP_INT_EN_TINTE | SSP_INT_EN_RIE);
+			if (tx_done)
+				val &= ~SSP_INT_EN_TIE;
+		}
+		writel(val, virt);
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
+	drv_data->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0,
+								  &iores);
+	if (IS_ERR(drv_data->ioaddr))
+		return dev_err_probe(dev, PTR_ERR(drv_data->ioaddr),
+				     "error mapping memory\n");
+	drv_data->data_reg_addr = iores->start + SSP_DATAR;
+
+	ret = devm_k1_spi_dma_setup(drv_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "error setting up DMA\n");
+
+	k1_spi_host_init(drv_data, pdev->id);
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
+		.name	= "k1x-spi",
+		.of_match_table = k1_spi_dt_ids,
+	},
+	.probe = k1_spi_probe,
+	.remove = k1_spi_remove,
+};
+
+module_platform_driver(k1_spi_driver);
+
+MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


