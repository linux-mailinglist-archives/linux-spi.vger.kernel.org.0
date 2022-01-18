Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1B492174
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 09:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbiARIme (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 03:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiARImd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 03:42:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4DC061574;
        Tue, 18 Jan 2022 00:42:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n11so21771462plf.4;
        Tue, 18 Jan 2022 00:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=r0rdhPh0I70bPJJ1gDzTdolopTGfE7Dw6gdwChpTc+I=;
        b=SJp12dfxdI45hRIdZ+e6rycjtGLMc6+xYcF1tnbWAZu/DEL6AJbsSrMZhy4W1Zb1nF
         ICnySr+uBmTYg05eIzxeoY2MOjHNcut2/wtEXwyHgJX68nUfd7Z4St5qnkfyJE//xApY
         qcPQlBjWsYhx6RN6BMP49+UcjtyeZSB92936fPZHBwCZ8Hr7UDzXtMfV6c2lD3ouVRt1
         rcLZUJdsobikGlNFMyNJi7TJIfzlZHiCExbyI7qXZZfbVpiPTeeDVBd3J48GiYAAgwTh
         uWmzEnHpDuXN5iA01kAxjKp1TkrPOfFY2CaoM6eT7LUguascfAqP0X0tJ1BshUvknUHQ
         mxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=r0rdhPh0I70bPJJ1gDzTdolopTGfE7Dw6gdwChpTc+I=;
        b=bB3G/YNQMNGUgikeiPCa3+AwSzxuhIBXKz57dasZ9kNYNCmSscP/mzOnur0F8hPxWn
         i9+45fnDoqeaSI7ZHKOx9RZfcXc4inj7h/VdIbRiZmlCJp4jghlF01fl/a20uKNbwwj2
         7bLGks9SMQF5+xhSkAW4K5SXmSdj9jDYoEQ+4ys1iepKte0AHmrqxIomboCOC63fuH07
         5j7EIlwHf6lOxJtwUb6ucku7qoSIORQRsiqs/2Zc7OOkDfzN0aXHaDiDjAwY80uu6Op4
         hD7rpJiCK5UJwOq6Yy33hX+Uy9yfdQZDn1P8Gl5BadyM9pFkMST09sNx9ZffT1Egtj38
         iUCg==
X-Gm-Message-State: AOAM531nEI7dxlu2+oI+qgQM3CDUIEK4BDjuHuhBwJMpoCXg8bnQlWhk
        xkcU+xCcQKm12LriV3cPG/w=
X-Google-Smtp-Source: ABdhPJzHJQ+G9JT2JqH5sATFA0RI8n81f4ek6kOIrja0FrKx7Bz9Dwlt6S1LgRVynzHfeKs0MYEJAw==
X-Received: by 2002:a17:90b:38c9:: with SMTP id nn9mr17070856pjb.219.1642495352802;
        Tue, 18 Jan 2022 00:42:32 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t199sm14227787pgb.64.2022.01.18.00.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:42:32 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Date:   Tue, 18 Jan 2022 16:42:38 +0800
Message-Id: <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1642494310.git.lhjeff911@gmail.com>
References: <cover.1642494310.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1642494310.git.lhjeff911@gmail.com>
References: <cover.1642494310.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add spi driver for Sunplus SP7021.

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v6:
 - Change the interrupt-names 
   mas_risc to master_risc
 - Addressed comments from Mr. Andy Shevchenko
   Change the function name: mas is master and sla is slave.
   Add temporary varilable (as suggested by Mr. Andy Shevchenko)
   Modify clk setting
   Modify the master-slave detection of the probe function.(as suggested by Mr. Andy Shevchenko)
   Modify the return value of the probe function.(as suggested by Mr. Andy Shevchenko)
   Change GPL version(as suggested by Mr. Andy Shevchenko)

 MAINTAINERS                      |   6 +
 drivers/spi/Kconfig              |  11 +
 drivers/spi/Makefile             |   1 +
 drivers/spi/spi-sunplus-sp7021.c | 602 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 620 insertions(+)
 create mode 100644 drivers/spi/spi-sunplus-sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a58544f..a07da20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18493,6 +18493,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS SPI CONTROLLER INTERFACE DRIVER
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-sunplus-sp7021.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b2a8821..203f4ec 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -866,6 +866,17 @@ config SPI_SUN6I
 	help
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
+config SPI_SUNPLUS_SP7021
+	tristate "Sunplus SP7021 SPI controller"
+	depends on SOC_SP7021 || COMPILE_TEST
+	help
+	  This enables Sunplus SP7021 SPI controller driver on the SP7021 SoCs.
+	  This driver can also be built as a module. If so, the module will be
+	  called as spi-sunplus-sp7021.
+
+	  If you have a  Sunplus SP7021 platform say Y here.
+	  If unsure, say N.
+
 config SPI_SYNQUACER
 	tristate "Socionext's SynQuacer HighSpeed SPI controller"
 	depends on ARCH_SYNQUACER || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index dd7393a..b455eaf 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_SPI_STM32_QSPI) 		+= spi-stm32-qspi.o
 obj-$(CONFIG_SPI_ST_SSC4)		+= spi-st-ssc4.o
 obj-$(CONFIG_SPI_SUN4I)			+= spi-sun4i.o
 obj-$(CONFIG_SPI_SUN6I)			+= spi-sun6i.o
+obj-$(CONFIG_SPI_SUNPLUS_SP7021)	+= spi-sunplus-sp7021.o
 obj-$(CONFIG_SPI_SYNQUACER)		+= spi-synquacer.o
 obj-$(CONFIG_SPI_TEGRA210_QUAD)		+= spi-tegra210-quad.o
 obj-$(CONFIG_SPI_TEGRA114)		+= spi-tegra114.o
diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
new file mode 100644
index 0000000..627b9c3
--- /dev/null
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2021 Sunplus Inc.
+// Author: Li-hao Kuo <lhjeff911@gmail.com>
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+
+#define SP7021_DATA_RDY_REG		0x0044
+#define SP7021_SLAVE_DMA_CTRL_REG	0x0048
+#define SP7021_SLAVE_DMA_LENGTH_REG	0x004c
+#define SP7021_SLAVE_DMA_ADDR_REG	0x004c
+
+#define SP7021_SLAVE_DATA_RDY		BIT(0)
+#define SP7021_SLAVE_SW_RST		BIT(1)
+#define SP7021_SLA_DMA_W_INT		BIT(8)
+#define SP7021_SLAVE_CLR_INT		BIT(8)
+#define SP7021_SLAVE_DMA_EN		BIT(0)
+#define SP7021_SLAVE_DMA_RW		BIT(6)
+#define SP7021_SLAVE_DMA_CMD		GENMASK(3, 2)
+
+#define SP7021_FIFO_REG			0x0034
+#define SP7021_SPI_STATUS_REG		0x0038
+#define SP7021_SPI_CONFIG_REG		0x003c
+#define SP7021_INT_BUSY_REG		0x004c
+#define SP7021_DMA_CTRL_REG		0x0050
+
+#define SP7021_SPI_START_FD		BIT(0)
+#define SP7021_FD_SW_RST		BIT(1)
+#define SP7021_TX_EMP_FLAG		BIT(2)
+#define SP7021_RX_EMP_FLAG		BIT(4)
+#define SP7021_RX_FULL_FLAG		BIT(5)
+#define SP7021_FINISH_FLAG		BIT(6)
+
+#define SP7021_TX_CNT_MASK		GENMASK(11, 8)
+#define SP7021_RX_CNT_MASK		GENMASK(15, 12)
+#define SP7021_TX_LEN_MASK		GENMASK(23, 16)
+#define SP7021_GET_LEN_MASK		GENMASK(31, 24)
+#define SP7021_SET_TX_LEN		GENMASK(23, 16)
+#define SP7021_SET_XFER_LEN		GENMASK(31, 24)
+
+#define SP7021_CPOL_FD			BIT(0)
+#define SP7021_CPHA_R			BIT(1)
+#define SP7021_CPHA_W			BIT(2)
+#define SP7021_LSB_SEL			BIT(4)
+#define SP7021_CS_POR			BIT(5)
+#define SP7021_FD_SEL			BIT(6)
+
+#define SP7021_RX_UNIT			GENMASK(8, 7)
+#define SP7021_TX_UNIT			GENMASK(10, 9)
+#define SP7021_TX_EMP_FLAG_MASK		BIT(11)
+#define SP7021_RX_FULL_FLAG_MASK	BIT(14)
+#define SP7021_FINISH_FLAG_MASK		BIT(15)
+#define SP7021_CLEAN_RW_BYTE		GENMASK(10, 7)
+#define SP7021_CLEAN_FLUG_MASK		GENMASK(15, 11)
+#define SP7021_CLK_MASK			GENMASK(31, 16)
+
+#define SP7021_INT_BYPASS		BIT(3)
+#define SP7021_CLR_MASTER_INT		BIT(6)
+
+#define SP7021_SPI_DATA_SIZE		(255)
+#define SP7021_FIFO_DATA_LEN		(16)
+
+enum SP_SPI_MODE {
+	SP7021_SLAVE_READ = 0,
+	SP7021_SLAVE_WRITE = 1,
+	SP7021_SPI_IDLE = 2,
+};
+
+enum {
+	SP7021_MASTER_MODE = 0,
+	SP7021_SLAVE_MODE = 1,
+};
+
+struct sp7021_spi_ctlr {
+	struct device *dev;
+	struct spi_controller *ctlr;
+	void __iomem *m_base;
+	void __iomem *s_base;
+	u32 xfer_conf;
+	int mode;
+	int m_irq;
+	int s_irq;
+	struct clk *spi_clk;
+	struct reset_control *rstc;
+	// irq spin lock
+	spinlock_t lock;
+	// data xfer lock
+	struct mutex buf_lock;
+	struct completion isr_done;
+	struct completion slave_isr;
+	unsigned int  rx_cur_len;
+	unsigned int  tx_cur_len;
+	unsigned int  data_unit;
+	const u8 *tx_buf;
+	u8 *rx_buf;
+};
+
+static irqreturn_t sp7021_spi_slave_irq(int irq, void *dev)
+{
+	struct sp7021_spi_ctlr *pspim = dev;
+	unsigned int data_status;
+
+	data_status = readl(pspim->s_base + SP7021_DATA_RDY_REG);
+	writel(data_status | SP7021_SLAVE_CLR_INT, pspim->s_base + SP7021_DATA_RDY_REG);
+	complete(&pspim->slave_isr);
+	return IRQ_HANDLED;
+}
+
+static int sp7021_spi_slave_abort(struct spi_controller *ctlr)
+{
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+
+	complete(&pspim->slave_isr);
+	complete(&pspim->isr_done);
+	return 0;
+}
+
+int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
+
+	reinit_completion(&pspim->slave_isr);
+	writel(SP7021_SLAVE_DMA_EN | SP7021_SLAVE_DMA_RW | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
+	       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
+	writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
+	writel(xfer->tx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
+	writel(readl(pspim->s_base + SP7021_DATA_RDY_REG) | SP7021_SLAVE_DATA_RDY,
+	       pspim->s_base + SP7021_DATA_RDY_REG);
+	if (wait_for_completion_interruptible(&pspim->isr_done)) {
+		dev_err(&spi->dev, "%s() wait_for_completion err\n", __func__);
+		return -EINTR;
+	}
+	return 0;
+}
+
+int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
+	int ret = 0;
+
+	reinit_completion(&pspim->isr_done);
+	writel(SP7021_SLAVE_DMA_EN | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
+	       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
+	writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
+	writel(xfer->rx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
+	if (wait_for_completion_interruptible(&pspim->isr_done)) {
+		dev_err(&spi->dev, "%s() wait_for_completion err\n", __func__);
+		return -EINTR;
+	}
+	writel(SP7021_SLAVE_SW_RST, pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
+	return ret;
+}
+
+void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		pspim->rx_buf[pspim->rx_cur_len] =
+			readl(pspim->m_base + SP7021_FIFO_REG);
+		pspim->rx_cur_len++;
+	}
+}
+
+void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		writel(pspim->tx_buf[pspim->tx_cur_len],
+		       pspim->m_base + SP7021_FIFO_REG);
+		pspim->tx_cur_len++;
+	}
+}
+
+static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
+{
+	struct sp7021_spi_ctlr *pspim = dev;
+	unsigned int tx_cnt, total_len;
+	unsigned int tx_len, rx_cnt;
+	unsigned int fd_status;
+	unsigned long flags;
+	bool isrdone = false;
+	u32 value;
+
+	fd_status = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
+	tx_cnt = FIELD_GET(SP7021_TX_CNT_MASK, fd_status);
+	tx_len = FIELD_GET(SP7021_TX_LEN_MASK, fd_status);
+	total_len = FIELD_GET(SP7021_GET_LEN_MASK, fd_status);
+
+	if ((fd_status & SP7021_TX_EMP_FLAG) && (fd_status & SP7021_RX_EMP_FLAG) && total_len == 0)
+		return IRQ_NONE;
+
+	if (tx_len == 0 && total_len == 0)
+		return IRQ_NONE;
+
+	spin_lock_irqsave(&pspim->lock, flags);
+
+	rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
+	if (fd_status & SP7021_RX_FULL_FLAG)
+		rx_cnt = pspim->data_unit;
+
+	tx_cnt = min(tx_len - pspim->tx_cur_len, pspim->data_unit - tx_cnt);
+	dev_dbg(pspim->dev, "fd_st=0x%x rx_c:%d tx_c:%d tx_l:%d",
+		fd_status, rx_cnt, tx_cnt, tx_len);
+
+	if (rx_cnt > 0)
+		sp7021_spi_master_rb(pspim, rx_cnt);
+	if (tx_cnt > 0)
+		sp7021_spi_master_wb(pspim, tx_cnt);
+
+	fd_status = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
+	tx_len = FIELD_GET(SP7021_TX_LEN_MASK, fd_status);
+	total_len = FIELD_GET(SP7021_GET_LEN_MASK, fd_status);
+
+	if (fd_status & SP7021_FINISH_FLAG || tx_len == pspim->tx_cur_len) {
+		while (total_len != pspim->rx_cur_len) {
+			fd_status = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
+			total_len = FIELD_GET(SP7021_GET_LEN_MASK, fd_status);
+			if (fd_status & SP7021_RX_FULL_FLAG)
+				rx_cnt = pspim->data_unit;
+			else
+				rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
+
+			if (rx_cnt > 0)
+				sp7021_spi_master_rb(pspim, rx_cnt);
+		}
+		value = readl(pspim->m_base + SP7021_INT_BUSY_REG);
+		value |= SP7021_CLR_MASTER_INT;
+		writel(value, pspim->m_base + SP7021_INT_BUSY_REG);
+		writel(SP7021_FINISH_FLAG, pspim->m_base + SP7021_SPI_STATUS_REG);
+		isrdone = true;
+	}
+
+	if (isrdone)
+		complete(&pspim->isr_done);
+	spin_unlock_irqrestore(&pspim->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static void sp7021_prep_transfer(struct spi_controller *ctlr, struct spi_device *spi)
+{
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+
+	pspim->tx_cur_len = 0;
+	pspim->rx_cur_len = 0;
+	pspim->data_unit = SP7021_FIFO_DATA_LEN;
+}
+
+// preliminary set CS, CPOL, CPHA and LSB
+static int sp7021_spi_controller_prepare_message(struct spi_controller *ctlr,
+						 struct spi_message *msg)
+{
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct spi_device *s = msg->spi;
+	u32 valus, rs = 0;
+
+	valus = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
+	valus |= SP7021_FD_SW_RST;
+	writel(valus, pspim->m_base + SP7021_SPI_STATUS_REG);
+	rs |= SP7021_FD_SEL;
+	if (s->mode & SPI_CPOL)
+		rs |= SP7021_CPOL_FD;
+
+	if (s->mode & SPI_LSB_FIRST)
+		rs |= SP7021_LSB_SEL;
+
+	if (s->mode & SPI_CS_HIGH)
+		rs |= SP7021_CS_POR;
+
+	if (s->mode & SPI_CPHA)
+		rs |=  SP7021_CPHA_R;
+	else
+		rs |=  SP7021_CPHA_W;
+
+	rs |=  FIELD_PREP(SP7021_TX_UNIT, 0) | FIELD_PREP(SP7021_RX_UNIT, 0);
+	pspim->xfer_conf = rs;
+	if (pspim->xfer_conf & SP7021_CPOL_FD)
+		writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
+
+	return 0;
+}
+
+static void sp7021_spi_setup_clk(struct spi_controller *ctlr, struct spi_transfer *xfer)
+{
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	u32 clk_rate, clk_sel, div;
+
+	clk_rate = clk_get_rate(pspim->spi_clk);
+	div = clk_rate / xfer->speed_hz;
+	if (div < 2)
+		div = 2;
+	clk_sel = (div / 2) - 1;
+	pspim->xfer_conf &= SP7021_CLK_MASK;
+	pspim->xfer_conf |= FIELD_PREP(SP7021_CLK_MASK, clk_sel);
+	writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
+}
+
+static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+				       struct spi_transfer *xfer)
+{
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	unsigned long timeout = msecs_to_jiffies(1000);
+	unsigned int xfer_cnt, xfer_len, last_len;
+	unsigned int i, len_temp;
+	u32 reg_temp;
+	int ret;
+
+	xfer_cnt = xfer->len / SP7021_SPI_DATA_SIZE;
+	last_len = xfer->len % SP7021_SPI_DATA_SIZE;
+
+	for (i = 0; i <= xfer_cnt; i++) {
+		mutex_lock(&pspim->buf_lock);
+		sp7021_prep_transfer(ctlr, spi);
+		sp7021_spi_setup_clk(ctlr, xfer);
+		reinit_completion(&pspim->isr_done);
+
+		if (i == xfer_cnt)
+			xfer_len = last_len;
+		else
+			xfer_len = SP7021_SPI_DATA_SIZE;
+
+		pspim->tx_buf = xfer->tx_buf + i * SP7021_SPI_DATA_SIZE;
+		pspim->rx_buf = xfer->rx_buf + i * SP7021_SPI_DATA_SIZE;
+
+		if (pspim->tx_cur_len < xfer_len) {
+			len_temp = min(pspim->data_unit, xfer_len);
+			sp7021_spi_master_wb(pspim, len_temp);
+		}
+		reg_temp = readl(pspim->m_base + SP7021_SPI_CONFIG_REG);
+		reg_temp &= ~SP7021_CLEAN_RW_BYTE;
+		reg_temp &= ~SP7021_CLEAN_FLUG_MASK;
+		reg_temp |= SP7021_FD_SEL | SP7021_FINISH_FLAG_MASK |
+			    SP7021_TX_EMP_FLAG_MASK | SP7021_RX_FULL_FLAG_MASK |
+			    FIELD_PREP(SP7021_TX_UNIT, 0) | FIELD_PREP(SP7021_RX_UNIT, 0);
+		writel(reg_temp, pspim->m_base + SP7021_SPI_CONFIG_REG);
+
+		reg_temp = FIELD_PREP(SP7021_SET_TX_LEN, xfer_len) |
+				      FIELD_PREP(SP7021_SET_XFER_LEN, xfer_len) |
+				      SP7021_SPI_START_FD;
+		writel(reg_temp, pspim->m_base + SP7021_SPI_STATUS_REG);
+
+		if (!wait_for_completion_interruptible_timeout(&pspim->isr_done, timeout)) {
+			dev_err(&spi->dev, "wait_for_completion err\n");
+			return -ETIMEDOUT;
+		}
+
+		reg_temp = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
+		if (reg_temp & SP7021_FINISH_FLAG) {
+			writel(SP7021_FINISH_FLAG, pspim->m_base + SP7021_SPI_STATUS_REG);
+			writel(readl(pspim->m_base + SP7021_SPI_CONFIG_REG) &
+				SP7021_CLEAN_FLUG_MASK, pspim->m_base + SP7021_SPI_CONFIG_REG);
+		}
+
+		if (pspim->xfer_conf & SP7021_CPOL_FD)
+			writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
+
+		mutex_unlock(&pspim->buf_lock);
+		ret = 0;
+	}
+	return ret;
+}
+
+static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+				       struct spi_transfer *xfer)
+{
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+	struct device *dev = pspim->dev;
+	int mode, ret = 0;
+
+	mode = SP7021_SPI_IDLE;
+	if (xfer->tx_buf && xfer->rx_buf) {
+		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
+		ret = -EINVAL;
+	} else if (xfer->tx_buf) {
+		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
+					      xfer->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, xfer->tx_dma))
+			return -ENOMEM;
+		mode = SP7021_SLAVE_WRITE;
+	} else if (xfer->rx_buf) {
+		xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
+					      DMA_FROM_DEVICE);
+		if (dma_mapping_error(dev, xfer->rx_dma))
+			return -ENOMEM;
+		mode = SP7021_SLAVE_READ;
+	}
+
+	switch (mode) {
+	case SP7021_SLAVE_WRITE:
+		ret = sp7021_spi_slave_tx(spi, xfer);
+		break;
+	case SP7021_SLAVE_READ:
+		ret = sp7021_spi_slave_rx(spi, xfer);
+		break;
+	default:
+		break;
+	}
+	if (xfer->tx_buf)
+		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
+	if (xfer->rx_buf)
+		dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);
+
+	spi_finalize_current_transfer(ctlr);
+	return ret;
+}
+
+static void sp7021_spi_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void sp7021_spi_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static int sp7021_spi_controller_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp7021_spi_ctlr *pspim;
+	struct spi_controller *ctlr;
+	int mode, ret;
+
+	pdev->id = of_alias_get_id(pdev->dev.of_node, "sp_spi");
+
+	if (device_property_read_bool(dev, "spi-slave"))
+		mode = SP7021_SLAVE_MODE;
+	else
+		mode = SP7021_MASTER_MODE;
+
+	if (mode == SP7021_SLAVE_MODE)
+		ctlr = devm_spi_alloc_slave(dev, sizeof(*pspim));
+	else
+		ctlr = devm_spi_alloc_master(dev, sizeof(*pspim));
+	if (!ctlr)
+		return -ENOMEM;
+	device_set_node(&ctlr->dev, pdev->dev.fwnode);
+	ctlr->bus_num = pdev->id;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	ctlr->auto_runtime_pm = true;
+	ctlr->prepare_message = sp7021_spi_controller_prepare_message;
+	if (mode == SP7021_SLAVE_MODE) {
+		ctlr->transfer_one = sp7021_spi_slave_transfer_one;
+		ctlr->slave_abort = sp7021_spi_slave_abort;
+		ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	} else {
+		ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+		ctlr->min_speed_hz = 40000;
+		ctlr->max_speed_hz = 25000000;
+		ctlr->use_gpio_descriptors = true;
+		ctlr->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+		ctlr->transfer_one = sp7021_spi_master_transfer_one;
+	}
+	platform_set_drvdata(pdev, ctlr);
+	pspim = spi_controller_get_devdata(ctlr);
+	pspim->mode = mode;
+	pspim->ctlr = ctlr;
+	pspim->dev = dev;
+	spin_lock_init(&pspim->lock);
+	mutex_init(&pspim->buf_lock);
+	init_completion(&pspim->isr_done);
+	init_completion(&pspim->slave_isr);
+
+	pspim->m_base = devm_platform_ioremap_resource_byname(pdev, "master");
+	if (IS_ERR(pspim->m_base))
+		return dev_err_probe(dev, PTR_ERR(pspim->m_base), "m_base get fail\n");
+
+	pspim->s_base = devm_platform_ioremap_resource_byname(pdev, "slave");
+	if (IS_ERR(pspim->s_base))
+		return dev_err_probe(dev, PTR_ERR(pspim->s_base), "s_base get fail\n");
+
+	pspim->m_irq = platform_get_irq_byname(pdev, "master_risc");
+	if (pspim->m_irq < 0)
+		return pspim->m_irq;
+
+	pspim->s_irq = platform_get_irq_byname(pdev, "slave_risc");
+	if (pspim->s_irq < 0)
+		return pspim->s_irq;
+
+	ret = devm_request_irq(dev, pspim->m_irq, sp7021_spi_master_irq,
+			       IRQF_TRIGGER_RISING, pdev->name, pspim);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(dev, pspim->s_irq, sp7021_spi_slave_irq,
+			       IRQF_TRIGGER_RISING, pdev->name, pspim);
+	if (ret)
+		return ret;
+
+	pspim->spi_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pspim->spi_clk))
+		return dev_err_probe(dev, PTR_ERR(pspim->spi_clk), "clk get fail\n");
+
+	pspim->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(pspim->rstc))
+		return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst get fail\n");
+
+	ret = clk_prepare_enable(pspim->spi_clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clk\n");
+
+	ret = devm_add_action_or_reset(dev, sp7021_spi_disable_unprepare, pspim->spi_clk);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(pspim->rstc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert reset\n");
+
+	ret = devm_add_action_or_reset(dev, sp7021_spi_reset_control_assert, pspim->rstc);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(dev);
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		pm_runtime_disable(dev);
+		return dev_err_probe(dev, ret, "spi_register_master fail\n");
+	}
+	return 0;
+}
+
+static int sp7021_spi_controller_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
+
+	spi_unregister_controller(ctlr);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	return 0;
+}
+
+static int __maybe_unused sp7021_spi_controller_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+
+	return reset_control_assert(pspim->rstc);
+}
+
+static int __maybe_unused sp7021_spi_controller_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+
+	reset_control_deassert(pspim->rstc);
+	return clk_prepare_enable(pspim->spi_clk);
+}
+
+static int sp7021_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+
+	return reset_control_assert(pspim->rstc);
+}
+
+static int sp7021_spi_runtime_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
+
+	return reset_control_deassert(pspim->rstc);
+}
+
+static const struct dev_pm_ops sp7021_spi_pm_ops = {
+	SET_RUNTIME_PM_OPS(sp7021_spi_runtime_suspend,
+			   sp7021_spi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sp7021_spi_controller_suspend,
+				sp7021_spi_controller_resume)
+};
+
+static const struct of_device_id sp7021_spi_controller_ids[] = {
+	{ .compatible = "sunplus,sp7021-spi" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sp7021_spi_controller_ids);
+
+static struct platform_driver sp7021_spi_controller_driver = {
+	.probe = sp7021_spi_controller_probe,
+	.remove = sp7021_spi_controller_remove,
+	.driver = {
+		.name = "sunplus,sp7021-spi-controller",
+		.of_match_table = sp7021_spi_controller_ids,
+		.pm     = &sp7021_spi_pm_ops,
+	},
+};
+module_platform_driver(sp7021_spi_controller_driver);
+
+MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
+MODULE_DESCRIPTION("Sunplus SPI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

