Return-Path: <linux-spi+bounces-7013-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEBA4D69E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 09:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BABE3A8F08
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4C1FBCA9;
	Tue,  4 Mar 2025 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZu0W82b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55C1FBCB2;
	Tue,  4 Mar 2025 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077408; cv=none; b=IvNnz5HqqnBrBbHDL1M7v8Ly/MIPRXOn2ez4Lde/LRjjuixUxa4vX6iNmncb2530HM2e3h5033khSxbzyKvdIUNRfqcrvk7IH60NmRIqNlhE+tGe+6+o7I7rnVsYREN/2dR8KoznrKBdlisjOs3izGEn88HpAp5+flu1HqRTzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077408; c=relaxed/simple;
	bh=q4+eCauqW17EST8bv6FaDswBHcheaYEpE/R+t+QjLRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0wM8TLlXywxi7+YWeGxadK4vcWGG2BFfXDB9YJIhizd3F3NRvNNVZD2YwMnA0eUCw29MJu8qDymXoM3kB9Qyw2SEFLBT1H8gu+7fSqhPSB5/UE+Hqsgb7MhbFWubkZI83gv0VmrLvuAvjrmA2IjqGRMTCbMYrqtr6sySOS2mmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZu0W82b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2238d965199so43525925ad.2;
        Tue, 04 Mar 2025 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741077406; x=1741682206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VSXb4VkUGXDziqmui1PJlF3peJdsLjgXlezDaswlB4=;
        b=VZu0W82b2X6UxXLZWq8mqwS8App4k1oLluwEmLKGEdxsCr3aXd3TfqbkuyZM9Cw6YB
         02YhfvDyagGdW0H2kDpo1vhWX3J2H2v6QtuCzHSI4yaRixY3Ro/UVsxqr9USpwqFIwus
         E/WCBFqt952nKo0VBzM8kB0RzCWfzNENG65Vl8qjHZ05vGmKM6pYLzvGMITdt2stkLJp
         EE+kLBGyfcjKeGcoZvXLG1BEWtz4BMivCFK76fGgtzcHx/wUSn4GgTCEckuYeuWW3E1w
         HyMvY3L8GCCf0SGkiVBJBw9tzKRn/aA4Wuy4gj4ki1zEVO/Tl5W44gTmjf2nezkIFEGc
         LW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077406; x=1741682206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VSXb4VkUGXDziqmui1PJlF3peJdsLjgXlezDaswlB4=;
        b=JvdMqIVLdJnU5cxYXzQ4pOhrFSLZimpNwF6JK7iSL1u3LSyzA0ckpgpvLICpCIZIKs
         cTPRzup98+94sCFzJG5F7Jby7pE/REV2MILch+6i6Jk7yPNTl9HMYmW/UMpm9IU2qGB0
         3kGl5cz7V78c+rns49j/Sn1BG8EMxLUeQZpmETQkuUEa0y6E7A7q3EJUAYmwXoQDbAWS
         yI5aBHX9ehSLy6M3p5W36X4Rw9ld/GB8F1VgcDLtGayI59n7lS6OdFehHEAarl34RTxw
         6vhV0kKhkTgSz5x4h5an+Eyj73hivQGa13DLPiA8VkVa043ttQhPajzTAdym8sTd/87w
         pKUg==
X-Forwarded-Encrypted: i=1; AJvYcCUoW5dD/gs33wbIZvDUrHMVF2FoyjjBV9N8qxHnzZytPIOjZk3KBZhXpf4BwAEpGadKIUO4jlNCv5AU@vger.kernel.org, AJvYcCVkxzChehfIgwtyOdT/up+Xchtocgj5e+JECvAVzbzY7QrmZjuK3u44k8jg41ZzRRuOScajdX6X3zXbmtXq@vger.kernel.org, AJvYcCXUc6+uvCyQG7j59KjhIUIQtxRjTON9xqvwEP4buwTdGg05O9WjxM2wqVTNXymKS8bGbrwxgF0mg3AF@vger.kernel.org
X-Gm-Message-State: AOJu0YwBA13qOx0MQZIZnsMLTE9jt8GHPODsSLGCCcw6fibZY58srBwQ
	cQh9a9buZdW1nXfAGHzVRR+oesRhn6V798mGatN1C35h8KVpwXPH
X-Gm-Gg: ASbGnctfJTtRbTXKadA7sV7DinHLtnk+vHfEfudcSWdQS9zIZotOVhEnSZk7keuFLHS
	Jrkky74kql98Hm2kojgCYPLU9AL1qNLoHOY7gpOCijFdecrBQG/g+K/NvkFJ4dAYCXlRUzazmfx
	fQEX32iBSu1IUa5F9q8lvRD3zO2npRnQOYpiH7boyfN6VvFjI/XHK8uM93Pu18gW9TNGlgk7ES1
	cE4CxUYbhoWKEjY0zQiiA3UEFJYiekSGcCPRrB4IwMyzYUTGCFXc62h6D38j29j7NYFPZOm1ZoT
	bKxnNErnvDmPD1libZvI4R5KzM7li174HoNEQGY=
X-Google-Smtp-Source: AGHT+IESbh2MWB5ZthrDA4qD4tVSFOXwtgkXKslXehESIPna5DXJJgt5rxs4kSh/5aU7kjgz7qRDCw==
X-Received: by 2002:a17:903:2990:b0:223:39ae:a98 with SMTP id d9443c01a7336-22368fce70emr268726475ad.22.1741077406081;
        Tue, 04 Mar 2025 00:36:46 -0800 (PST)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc3b7sm90597735ad.173.2025.03.04.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:36:45 -0800 (PST)
From: Longbin Li <looong.bin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v2 2/2] spi: sophgo: add SG2044 SPI NOR controller driver
Date: Tue,  4 Mar 2025 16:35:43 +0800
Message-ID: <20250304083548.10101-3-looong.bin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304083548.10101-1-looong.bin@gmail.com>
References: <20250304083548.10101-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SG2044 SPI NOR controller in Sophgo SoC.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 drivers/spi/Kconfig          |   9 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-sg2044-nor.c | 500 +++++++++++++++++++++++++++++++++++
 3 files changed, 510 insertions(+)
 create mode 100644 drivers/spi/spi-sg2044-nor.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ea8a31032927..281310178734 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1021,6 +1021,15 @@ config SPI_SN_F_OSPI
 	  for connecting an SPI Flash memory over up to 8-bit wide bus.
 	  It supports indirect access mode only.

+config SPI_SG2044_NOR
+	tristate "SG2044 SPI NOR Controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  This enables support for the SG2044 SPI NOR controller,
+	  which supports Dual/Qual read and write operations while
+	  also supporting 3Byte address devices and 4Byte address
+	  devices.
+
 config SPI_SPRD
 	tristate "Spreadtrum SPI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9db7554c1864..c7a46fd61903 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
 obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
 obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
 obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
+obj-$(CONFIG_SPI_SG2044_NOR)	+= spi-sg2044-nor.o
 obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
 obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
 obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
new file mode 100644
index 000000000000..454153a63b42
--- /dev/null
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SG2044 SPI NOR controller driver
+ *
+ * Copyright (c) 2025 Longbin Li <looong.bin@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi-mem.h>
+
+/* Hardware register definitions */
+#define SPIFMC_CTRL				0x00
+#define SPIFMC_CTRL_CPHA			BIT(12)
+#define SPIFMC_CTRL_CPOL			BIT(13)
+#define SPIFMC_CTRL_HOLD_OL			BIT(14)
+#define SPIFMC_CTRL_WP_OL			BIT(15)
+#define SPIFMC_CTRL_LSBF			BIT(20)
+#define SPIFMC_CTRL_SRST			BIT(21)
+#define SPIFMC_CTRL_SCK_DIV_SHIFT		0
+#define SPIFMC_CTRL_FRAME_LEN_SHIFT		16
+#define SPIFMC_CTRL_SCK_DIV_MASK		0x7FF
+
+#define SPIFMC_CE_CTRL				0x04
+#define SPIFMC_CE_CTRL_CEMANUAL			BIT(0)
+#define SPIFMC_CE_CTRL_CEMANUAL_EN		BIT(1)
+
+#define SPIFMC_DLY_CTRL				0x08
+#define SPIFMC_CTRL_FM_INTVL_MASK		0x000f
+#define SPIFMC_CTRL_FM_INTVL			BIT(0)
+#define SPIFMC_CTRL_CET_MASK			0x0f00
+#define SPIFMC_CTRL_CET				BIT(8)
+
+#define SPIFMC_DMMR				0x0c
+
+#define SPIFMC_TRAN_CSR				0x10
+#define SPIFMC_TRAN_CSR_TRAN_MODE_MASK		GENMASK(1, 0)
+#define SPIFMC_TRAN_CSR_TRAN_MODE_RX		BIT(0)
+#define SPIFMC_TRAN_CSR_TRAN_MODE_TX		BIT(1)
+#define SPIFMC_TRAN_CSR_FAST_MODE		BIT(3)
+#define SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT		(0x00 << 4)
+#define SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT		(0x01 << 4)
+#define SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT		(0x02 << 4)
+#define SPIFMC_TRAN_CSR_DMA_EN			BIT(6)
+#define SPIFMC_TRAN_CSR_MISO_LEVEL		BIT(7)
+#define SPIFMC_TRAN_CSR_ADDR_BYTES_MASK		GENMASK(10, 8)
+#define SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT	8
+#define SPIFMC_TRAN_CSR_WITH_CMD		BIT(11)
+#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_MASK	GENMASK(13, 12)
+#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE	(0x00 << 12)
+#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_2_BYTE	(0x01 << 12)
+#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_4_BYTE	(0x02 << 12)
+#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE	(0x03 << 12)
+#define SPIFMC_TRAN_CSR_GO_BUSY			BIT(15)
+#define SPIFMC_TRAN_CSR_ADDR4B_SHIFT		20
+#define SPIFMC_TRAN_CSR_CMD4B_SHIFT		21
+
+#define SPIFMC_TRAN_NUM				0x14
+#define SPIFMC_FIFO_PORT			0x18
+#define SPIFMC_FIFO_PT				0x20
+
+#define SPIFMC_INT_STS				0x28
+#define SPIFMC_INT_TRAN_DONE			BIT(0)
+#define SPIFMC_INT_RD_FIFO			BIT(2)
+#define SPIFMC_INT_WR_FIFO			BIT(3)
+#define SPIFMC_INT_RX_FRAME			BIT(4)
+#define SPIFMC_INT_TX_FRAME			BIT(5)
+
+#define SPIFMC_INT_EN				0x2c
+#define SPIFMC_INT_TRAN_DONE_EN			BIT(0)
+#define SPIFMC_INT_RD_FIFO_EN			BIT(2)
+#define SPIFMC_INT_WR_FIFO_EN			BIT(3)
+#define SPIFMC_INT_RX_FRAME_EN			BIT(4)
+#define SPIFMC_INT_TX_FRAME_EN			BIT(5)
+
+#define SPIFMC_OPT				0x030
+#define SPIFMC_OPT_DISABLE_FIFO_FLUSH		BIT(1)
+
+#define SPIFMC_MAX_FIFO_DEPTH			8
+
+#define SPIFMC_MAX_READ_SIZE			0x10000
+
+struct sg2044_spifmc {
+	struct spi_controller *ctrl;
+	void __iomem *io_base;
+	struct device *dev;
+	struct mutex lock;
+	struct clk *clk;
+};
+
+static int sg2044_spifmc_wait_int(struct sg2044_spifmc *spifmc, u8 int_type)
+{
+	u32 stat;
+
+	return readl_poll_timeout(spifmc->io_base + SPIFMC_INT_STS, stat,
+				  (stat & int_type), 0, 1000000);
+}
+
+static int sg2044_spifmc_wait_xfer_size(struct sg2044_spifmc *spifmc,
+					int xfer_size)
+{
+	u8 stat;
+
+	return readl_poll_timeout(spifmc->io_base + SPIFMC_FIFO_PT, stat,
+				  ((stat & 0xf) == xfer_size), 1, 1000000);
+}
+
+static u32 sg2044_spifmc_init_reg(struct sg2044_spifmc *spifmc)
+{
+	u32 reg;
+
+	reg = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
+	reg &= ~(SPIFMC_TRAN_CSR_TRAN_MODE_MASK |
+		 SPIFMC_TRAN_CSR_FAST_MODE |
+		 SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT |
+		 SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT |
+		 SPIFMC_TRAN_CSR_DMA_EN |
+		 SPIFMC_TRAN_CSR_ADDR_BYTES_MASK |
+		 SPIFMC_TRAN_CSR_WITH_CMD |
+		 SPIFMC_TRAN_CSR_FIFO_TRG_LVL_MASK);
+
+	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
+
+	return reg;
+}
+
+static ssize_t sg2044_spifmc_read_64k(struct sg2044_spifmc *spifmc,
+				      const struct spi_mem_op *op, loff_t from,
+				      size_t len, u_char *buf)
+{
+	int xfer_size, offset;
+	u32 reg;
+	int ret;
+	int i;
+
+	reg = sg2044_spifmc_init_reg(spifmc);
+	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
+	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
+	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
+	reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	for (i = op->addr.nbytes - 1; i >= 0; i--)
+		writeb((from >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	for (i = 0; i < op->dummy.nbytes; i++)
+		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
+	writel(0, spifmc->io_base + SPIFMC_INT_STS);
+	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
+	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
+
+	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_RD_FIFO);
+	if (ret < 0)
+		return ret;
+
+	offset = 0;
+	while (offset < len) {
+		xfer_size = min_t(size_t, SPIFMC_MAX_FIFO_DEPTH, len - offset);
+
+		ret = sg2044_spifmc_wait_xfer_size(spifmc, xfer_size);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < xfer_size; i++)
+			buf[i + offset] = readb(spifmc->io_base + SPIFMC_FIFO_PORT);
+
+		offset += xfer_size;
+	}
+
+	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
+	if (ret < 0)
+		return ret;
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+
+	return len;
+}
+
+static ssize_t sg2044_spifmc_read(struct sg2044_spifmc *spifmc,
+				  const struct spi_mem_op *op)
+{
+	size_t xfer_size;
+	size_t offset;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	int ret;
+	u8 *din = op->data.buf.in;
+
+	offset = 0;
+	while (offset < len) {
+		xfer_size = min_t(size_t, SPIFMC_MAX_READ_SIZE, len - offset);
+
+		ret = sg2044_spifmc_read_64k(spifmc, op, from, xfer_size, din);
+		if (ret < 0)
+			return ret;
+
+		offset += xfer_size;
+		din += xfer_size;
+		from += xfer_size;
+	}
+
+	return 0;
+}
+
+static ssize_t sg2044_spifmc_write(struct sg2044_spifmc *spifmc,
+				   const struct spi_mem_op *op)
+{
+	size_t xfer_size;
+	const u8 *dout = op->data.buf.out;
+	int i, offset;
+	size_t ret;
+	u32 reg;
+
+	reg = sg2044_spifmc_init_reg(spifmc);
+	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
+	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
+	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
+	reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	for (i = op->addr.nbytes - 1; i >= 0; i--)
+		writeb((op->addr.val >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	for (i = 0; i < op->dummy.nbytes; i++)
+		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	writel(0, spifmc->io_base + SPIFMC_INT_STS);
+	writel(op->data.nbytes, spifmc->io_base + SPIFMC_TRAN_NUM);
+	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
+	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
+
+	ret = sg2044_spifmc_wait_xfer_size(spifmc, 0);
+	if (ret < 0)
+		return ret;
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+
+	offset = 0;
+	while (offset < op->data.nbytes) {
+		xfer_size = min_t(size_t, SPIFMC_MAX_FIFO_DEPTH, op->data.nbytes - offset);
+
+		ret = sg2044_spifmc_wait_xfer_size(spifmc, 0);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < xfer_size; i++)
+			writeb(dout[i + offset], spifmc->io_base + SPIFMC_FIFO_PORT);
+
+		offset += xfer_size;
+	}
+
+	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
+	if (ret < 0)
+		return ret;
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+
+	return 0;
+}
+
+static ssize_t sg2044_spifmc_tran_cmd(struct sg2044_spifmc *spifmc,
+				      const struct spi_mem_op *op)
+{
+	int i, ret;
+	u32 reg;
+
+	reg = sg2044_spifmc_init_reg(spifmc);
+	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
+	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE;
+	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	for (i = op->addr.nbytes - 1; i >= 0; i--)
+		writeb((op->addr.val >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	for (i = 0; i < op->dummy.nbytes; i++)
+		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	writel(0, spifmc->io_base + SPIFMC_INT_STS);
+	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
+	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
+
+	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
+	if (ret < 0)
+		return ret;
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+
+	return 0;
+}
+
+static void sg2044_spifmc_trans(struct sg2044_spifmc *spifmc,
+				const struct spi_mem_op *op)
+{
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		sg2044_spifmc_read(spifmc, op);
+	else if (op->data.dir == SPI_MEM_DATA_OUT)
+		sg2044_spifmc_write(spifmc, op);
+	else
+		sg2044_spifmc_tran_cmd(spifmc, op);
+}
+
+static ssize_t sg2044_spifmc_trans_reg(struct sg2044_spifmc *spifmc,
+				       const struct spi_mem_op *op)
+{
+	const u8 *dout = NULL;
+	u8 *din = NULL;
+	size_t len = op->data.nbytes;
+	int ret, i;
+	u32 reg;
+
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		din = op->data.buf.in;
+	else
+		dout = op->data.buf.out;
+
+	reg = sg2044_spifmc_init_reg(spifmc);
+	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE;
+	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
+
+	if (din) {
+		reg |= SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT;
+		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
+		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
+
+		writel(SPIFMC_OPT_DISABLE_FIFO_FLUSH, spifmc->io_base + SPIFMC_OPT);
+	} else {
+		/*
+		 * If write values to the Status Register,
+		 * configure TRAN_CSR register as the same as
+		 * sg2044_spifmc_read_reg.
+		 */
+		if (op->cmd.opcode == 0x01) {
+			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
+			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
+			writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
+		}
+	}
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
+
+	for (i = 0; i < len; i++) {
+		if (din)
+			writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
+		else
+			writeb(dout[i], spifmc->io_base + SPIFMC_FIFO_PORT);
+	}
+
+	writel(0, spifmc->io_base + SPIFMC_INT_STS);
+	writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
+	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
+	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
+
+	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
+	if (ret < 0)
+		return ret;
+
+	if (din) {
+		while (len--)
+			*din++ = readb(spifmc->io_base + SPIFMC_FIFO_PORT);
+	}
+
+	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
+
+	return 0;
+}
+
+static int sg2044_spifmc_exec_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct sg2044_spifmc *spifmc;
+
+	spifmc = spi_controller_get_devdata(mem->spi->controller);
+
+	mutex_lock(&spifmc->lock);
+
+	if (op->addr.nbytes == 0)
+		sg2044_spifmc_trans_reg(spifmc, op);
+	else
+		sg2044_spifmc_trans(spifmc, op);
+
+	mutex_unlock(&spifmc->lock);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops sg2044_spifmc_mem_ops = {
+	.exec_op = sg2044_spifmc_exec_op,
+};
+
+static void sg2044_spifmc_init(struct sg2044_spifmc *spifmc)
+{
+	u32 tran_csr;
+	u32 reg;
+
+	writel(0, spifmc->io_base + SPIFMC_DMMR);
+
+	reg = readl(spifmc->io_base + SPIFMC_CTRL);
+	reg |= SPIFMC_CTRL_SRST;
+	reg &= ~(SPIFMC_CTRL_SCK_DIV_MASK);
+	reg |= 1;
+	writel(reg, spifmc->io_base + SPIFMC_CTRL);
+
+	writel(0, spifmc->io_base + SPIFMC_CE_CTRL);
+
+	tran_csr = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
+	tran_csr |= (0 << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT);
+	tran_csr |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_4_BYTE;
+	tran_csr |= SPIFMC_TRAN_CSR_WITH_CMD;
+	writel(tran_csr, spifmc->io_base + SPIFMC_TRAN_CSR);
+}
+
+static int sg2044_spifmc_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl;
+	struct sg2044_spifmc *spifmc;
+	void __iomem *base;
+	int ret;
+
+	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*spifmc));
+	if (!ctrl)
+		return -ENOMEM;
+
+	spifmc = spi_controller_get_devdata(ctrl);
+	dev_set_drvdata(&pdev->dev, ctrl);
+
+	spifmc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(spifmc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(spifmc->clk),
+				     "%s: Cannot get and enable AHB clock\n",
+				     __func__);
+
+	spifmc->dev = &pdev->dev;
+	spifmc->ctrl = ctrl;
+
+	spifmc->io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ctrl->num_chipselect = 1;
+	ctrl->dev.of_node = pdev->dev.of_node;
+	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctrl->auto_runtime_pm = false;
+	ctrl->mem_ops = &sg2044_spifmc_mem_ops;
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
+
+	mutex_init(&spifmc->lock);
+
+	sg2044_spifmc_init(spifmc);
+	sg2044_spifmc_init_reg(spifmc);
+
+	ret = devm_spi_register_controller(&pdev->dev, ctrl);
+	if (ret) {
+		mutex_destroy(&spifmc->lock);
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sg2044_spifmc_remove(struct platform_device *pdev)
+{
+	struct sg2044_spifmc *spifmc = platform_get_drvdata(pdev);
+
+	mutex_destroy(&spifmc->lock);
+}
+
+static const struct of_device_id sg2044_spifmc_match[] = {
+	{ .compatible = "sophgo,sg2044-spifmc-nor" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sg2044_spifmc_match);
+
+static struct platform_driver sg2044_nor_driver = {
+	.driver = {
+		.name = "sg2044,spifmc-nor",
+		.of_match_table = sg2044_spifmc_match,
+	},
+	.probe = sg2044_spifmc_probe,
+	.remove = sg2044_spifmc_remove,
+};
+module_platform_driver(sg2044_nor_driver);
+
+MODULE_DESCRIPTION("SG2044 SPI NOR controller driver");
+MODULE_AUTHOR("Longbin Li <looong.bin@gmail.com>");
+MODULE_LICENSE("GPL");
--
2.48.1

