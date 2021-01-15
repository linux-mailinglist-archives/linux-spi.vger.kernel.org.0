Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52A2F8006
	for <lists+linux-spi@lfdr.de>; Fri, 15 Jan 2021 16:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbhAOPwT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Jan 2021 10:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbhAOPwS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Jan 2021 10:52:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8061C0613C1
        for <linux-spi@vger.kernel.org>; Fri, 15 Jan 2021 07:51:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0RNt-0003Nc-88; Fri, 15 Jan 2021 16:51:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0RNs-0008LT-TR; Fri, 15 Jan 2021 16:51:32 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Mark Brown <broonie@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: [PATCH v2 4/7] spi: Drop unused efm32 bus driver
Date:   Fri, 15 Jan 2021 16:51:27 +0100
Message-Id: <20210115155130.185010-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115155130.185010-1-u.kleine-koenig@pengutronix.de>
References: <20210115155130.185010-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Support for this machine was just removed, so drop the now unused spi
bus driver, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/Kconfig                     |   7 -
 drivers/spi/Makefile                    |   1 -
 drivers/spi/spi-efm32.c                 | 462 ------------------------
 include/linux/platform_data/efm32-spi.h |  15 -
 4 files changed, 485 deletions(-)
 delete mode 100644 drivers/spi/spi-efm32.c
 delete mode 100644 include/linux/platform_data/efm32-spi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index aadaea052f51..d3375aa6e292 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -292,13 +292,6 @@ config SPI_DLN2
 	 This driver can also be built as a module.  If so, the module
 	 will be called spi-dln2.
 
-config SPI_EFM32
-	tristate "EFM32 SPI controller"
-	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
-	select SPI_BITBANG
-	help
-	  Driver for the spi controller found on Energy Micro's EFM32 SoCs.
-
 config SPI_EP93XX
 	tristate "Cirrus Logic EP93xx SPI controller"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea5821662e..5a21b5cc8015 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -42,7 +42,6 @@ spi-dw-$(CONFIG_SPI_DW_DMA)		+= spi-dw-dma.o
 obj-$(CONFIG_SPI_DW_BT1)		+= spi-dw-bt1.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-pci.o
-obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
 obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
 obj-$(CONFIG_SPI_FSI)			+= spi-fsi.o
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
deleted file mode 100644
index ea6e4a7b3feb..000000000000
--- a/drivers/spi/spi-efm32.c
+++ /dev/null
@@ -1,462 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2012-2013 Uwe Kleine-Koenig for Pengutronix
- */
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/platform_data/efm32-spi.h>
-#include <linux/of.h>
-
-#define DRIVER_NAME "efm32-spi"
-
-#define MASK_VAL(mask, val)		((val << __ffs(mask)) & mask)
-
-#define REG_CTRL		0x00
-#define REG_CTRL_SYNC			0x0001
-#define REG_CTRL_CLKPOL			0x0100
-#define REG_CTRL_CLKPHA			0x0200
-#define REG_CTRL_MSBF			0x0400
-#define REG_CTRL_TXBIL			0x1000
-
-#define REG_FRAME		0x04
-#define REG_FRAME_DATABITS__MASK	0x000f
-#define REG_FRAME_DATABITS(n)		((n) - 3)
-
-#define REG_CMD			0x0c
-#define REG_CMD_RXEN			0x0001
-#define REG_CMD_RXDIS			0x0002
-#define REG_CMD_TXEN			0x0004
-#define REG_CMD_TXDIS			0x0008
-#define REG_CMD_MASTEREN		0x0010
-
-#define REG_STATUS		0x10
-#define REG_STATUS_TXENS		0x0002
-#define REG_STATUS_TXC			0x0020
-#define REG_STATUS_TXBL			0x0040
-#define REG_STATUS_RXDATAV		0x0080
-
-#define REG_CLKDIV		0x14
-
-#define REG_RXDATAX		0x18
-#define REG_RXDATAX_RXDATA__MASK	0x01ff
-#define REG_RXDATAX_PERR		0x4000
-#define REG_RXDATAX_FERR		0x8000
-
-#define REG_TXDATA		0x34
-
-#define REG_IF		0x40
-#define REG_IF_TXBL			0x0002
-#define REG_IF_RXDATAV			0x0004
-
-#define REG_IFS		0x44
-#define REG_IFC		0x48
-#define REG_IEN		0x4c
-
-#define REG_ROUTE		0x54
-#define REG_ROUTE_RXPEN			0x0001
-#define REG_ROUTE_TXPEN			0x0002
-#define REG_ROUTE_CLKPEN		0x0008
-#define REG_ROUTE_LOCATION__MASK	0x0700
-#define REG_ROUTE_LOCATION(n)		MASK_VAL(REG_ROUTE_LOCATION__MASK, (n))
-
-struct efm32_spi_ddata {
-	struct spi_bitbang bitbang;
-
-	spinlock_t lock;
-
-	struct clk *clk;
-	void __iomem *base;
-	unsigned int rxirq, txirq;
-	struct efm32_spi_pdata pdata;
-
-	/* irq data */
-	struct completion done;
-	const u8 *tx_buf;
-	u8 *rx_buf;
-	unsigned tx_len, rx_len;
-};
-
-#define ddata_to_dev(ddata)	(&(ddata->bitbang.master->dev))
-#define efm32_spi_vdbg(ddata, format, arg...)	\
-	dev_vdbg(ddata_to_dev(ddata), format, ##arg)
-
-static void efm32_spi_write32(struct efm32_spi_ddata *ddata,
-		u32 value, unsigned offset)
-{
-	writel_relaxed(value, ddata->base + offset);
-}
-
-static u32 efm32_spi_read32(struct efm32_spi_ddata *ddata, unsigned offset)
-{
-	return readl_relaxed(ddata->base + offset);
-}
-
-static int efm32_spi_setup_transfer(struct spi_device *spi,
-		struct spi_transfer *t)
-{
-	struct efm32_spi_ddata *ddata = spi_master_get_devdata(spi->master);
-
-	unsigned bpw = t->bits_per_word ?: spi->bits_per_word;
-	unsigned speed = t->speed_hz ?: spi->max_speed_hz;
-	unsigned long clkfreq = clk_get_rate(ddata->clk);
-	u32 clkdiv;
-
-	efm32_spi_write32(ddata, REG_CTRL_SYNC | REG_CTRL_MSBF |
-			(spi->mode & SPI_CPHA ? REG_CTRL_CLKPHA : 0) |
-			(spi->mode & SPI_CPOL ? REG_CTRL_CLKPOL : 0), REG_CTRL);
-
-	efm32_spi_write32(ddata,
-			REG_FRAME_DATABITS(bpw), REG_FRAME);
-
-	if (2 * speed >= clkfreq)
-		clkdiv = 0;
-	else
-		clkdiv = 64 * (DIV_ROUND_UP(2 * clkfreq, speed) - 4);
-
-	if (clkdiv > (1U << 21))
-		return -EINVAL;
-
-	efm32_spi_write32(ddata, clkdiv, REG_CLKDIV);
-	efm32_spi_write32(ddata, REG_CMD_MASTEREN, REG_CMD);
-	efm32_spi_write32(ddata, REG_CMD_RXEN | REG_CMD_TXEN, REG_CMD);
-
-	return 0;
-}
-
-static void efm32_spi_tx_u8(struct efm32_spi_ddata *ddata)
-{
-	u8 val = 0;
-
-	if (ddata->tx_buf) {
-		val = *ddata->tx_buf;
-		ddata->tx_buf++;
-	}
-
-	ddata->tx_len--;
-	efm32_spi_write32(ddata, val, REG_TXDATA);
-	efm32_spi_vdbg(ddata, "%s: tx 0x%x\n", __func__, val);
-}
-
-static void efm32_spi_rx_u8(struct efm32_spi_ddata *ddata)
-{
-	u32 rxdata = efm32_spi_read32(ddata, REG_RXDATAX);
-	efm32_spi_vdbg(ddata, "%s: rx 0x%x\n", __func__, rxdata);
-
-	if (ddata->rx_buf) {
-		*ddata->rx_buf = rxdata;
-		ddata->rx_buf++;
-	}
-
-	ddata->rx_len--;
-}
-
-static void efm32_spi_filltx(struct efm32_spi_ddata *ddata)
-{
-	while (ddata->tx_len &&
-			ddata->tx_len + 2 > ddata->rx_len &&
-			efm32_spi_read32(ddata, REG_STATUS) & REG_STATUS_TXBL) {
-		efm32_spi_tx_u8(ddata);
-	}
-}
-
-static int efm32_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
-{
-	struct efm32_spi_ddata *ddata = spi_master_get_devdata(spi->master);
-	int ret = -EBUSY;
-
-	spin_lock_irq(&ddata->lock);
-
-	if (ddata->tx_buf || ddata->rx_buf)
-		goto out_unlock;
-
-	ddata->tx_buf = t->tx_buf;
-	ddata->rx_buf = t->rx_buf;
-	ddata->tx_len = ddata->rx_len =
-		t->len * DIV_ROUND_UP(t->bits_per_word, 8);
-
-	efm32_spi_filltx(ddata);
-
-	reinit_completion(&ddata->done);
-
-	efm32_spi_write32(ddata, REG_IF_TXBL | REG_IF_RXDATAV, REG_IEN);
-
-	spin_unlock_irq(&ddata->lock);
-
-	wait_for_completion(&ddata->done);
-
-	spin_lock_irq(&ddata->lock);
-
-	ret = t->len - max(ddata->tx_len, ddata->rx_len);
-
-	efm32_spi_write32(ddata, 0, REG_IEN);
-	ddata->tx_buf = ddata->rx_buf = NULL;
-
-out_unlock:
-	spin_unlock_irq(&ddata->lock);
-
-	return ret;
-}
-
-static irqreturn_t efm32_spi_rxirq(int irq, void *data)
-{
-	struct efm32_spi_ddata *ddata = data;
-	irqreturn_t ret = IRQ_NONE;
-
-	spin_lock(&ddata->lock);
-
-	while (ddata->rx_len > 0 &&
-			efm32_spi_read32(ddata, REG_STATUS) &
-			REG_STATUS_RXDATAV) {
-		efm32_spi_rx_u8(ddata);
-
-		ret = IRQ_HANDLED;
-	}
-
-	if (!ddata->rx_len) {
-		u32 ien = efm32_spi_read32(ddata, REG_IEN);
-
-		ien &= ~REG_IF_RXDATAV;
-
-		efm32_spi_write32(ddata, ien, REG_IEN);
-
-		complete(&ddata->done);
-	}
-
-	spin_unlock(&ddata->lock);
-
-	return ret;
-}
-
-static irqreturn_t efm32_spi_txirq(int irq, void *data)
-{
-	struct efm32_spi_ddata *ddata = data;
-
-	efm32_spi_vdbg(ddata,
-			"%s: txlen = %u, rxlen = %u, if=0x%08x, stat=0x%08x\n",
-			__func__, ddata->tx_len, ddata->rx_len,
-			efm32_spi_read32(ddata, REG_IF),
-			efm32_spi_read32(ddata, REG_STATUS));
-
-	spin_lock(&ddata->lock);
-
-	efm32_spi_filltx(ddata);
-
-	efm32_spi_vdbg(ddata, "%s: txlen = %u, rxlen = %u\n",
-			__func__, ddata->tx_len, ddata->rx_len);
-
-	if (!ddata->tx_len) {
-		u32 ien = efm32_spi_read32(ddata, REG_IEN);
-
-		ien &= ~REG_IF_TXBL;
-
-		efm32_spi_write32(ddata, ien, REG_IEN);
-		efm32_spi_vdbg(ddata, "disable TXBL\n");
-	}
-
-	spin_unlock(&ddata->lock);
-
-	return IRQ_HANDLED;
-}
-
-static u32 efm32_spi_get_configured_location(struct efm32_spi_ddata *ddata)
-{
-	u32 reg = efm32_spi_read32(ddata, REG_ROUTE);
-
-	return (reg & REG_ROUTE_LOCATION__MASK) >> __ffs(REG_ROUTE_LOCATION__MASK);
-}
-
-static void efm32_spi_probe_dt(struct platform_device *pdev,
-		struct spi_master *master, struct efm32_spi_ddata *ddata)
-{
-	struct device_node *np = pdev->dev.of_node;
-	u32 location;
-	int ret;
-
-	ret = of_property_read_u32(np, "energymicro,location", &location);
-
-	if (ret)
-		/* fall back to wrongly namespaced property */
-		ret = of_property_read_u32(np, "efm32,location", &location);
-
-	if (ret)
-		/* fall back to old and (wrongly) generic property "location" */
-		ret = of_property_read_u32(np, "location", &location);
-
-	if (!ret) {
-		dev_dbg(&pdev->dev, "using location %u\n", location);
-	} else {
-		/* default to location configured in hardware */
-		location = efm32_spi_get_configured_location(ddata);
-
-		dev_info(&pdev->dev, "fall back to location %u\n", location);
-	}
-
-	ddata->pdata.location = location;
-}
-
-static int efm32_spi_probe(struct platform_device *pdev)
-{
-	struct efm32_spi_ddata *ddata;
-	struct resource *res;
-	int ret;
-	struct spi_master *master;
-	struct device_node *np = pdev->dev.of_node;
-
-	if (!np)
-		return -EINVAL;
-
-	master = spi_alloc_master(&pdev->dev, sizeof(*ddata));
-	if (!master) {
-		dev_dbg(&pdev->dev,
-				"failed to allocate spi master controller\n");
-		return -ENOMEM;
-	}
-	platform_set_drvdata(pdev, master);
-
-	master->dev.of_node = pdev->dev.of_node;
-
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
-	master->use_gpio_descriptors = true;
-
-	ddata = spi_master_get_devdata(master);
-
-	ddata->bitbang.master = master;
-	ddata->bitbang.setup_transfer = efm32_spi_setup_transfer;
-	ddata->bitbang.txrx_bufs = efm32_spi_txrx_bufs;
-
-	spin_lock_init(&ddata->lock);
-	init_completion(&ddata->done);
-
-	ddata->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(ddata->clk)) {
-		ret = PTR_ERR(ddata->clk);
-		dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
-		goto err;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		goto err;
-	}
-
-	if (resource_size(res) < 0x60) {
-		ret = -EINVAL;
-		dev_err(&pdev->dev, "memory resource too small\n");
-		goto err;
-	}
-
-	ddata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(ddata->base)) {
-		ret = PTR_ERR(ddata->base);
-		goto err;
-	}
-
-	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0)
-		goto err;
-
-	ddata->rxirq = ret;
-
-	ret = platform_get_irq(pdev, 1);
-	if (ret <= 0)
-		ret = ddata->rxirq + 1;
-
-	ddata->txirq = ret;
-
-	ret = clk_prepare_enable(ddata->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable clock (%d)\n", ret);
-		goto err;
-	}
-
-	efm32_spi_probe_dt(pdev, master, ddata);
-
-	efm32_spi_write32(ddata, 0, REG_IEN);
-	efm32_spi_write32(ddata, REG_ROUTE_TXPEN | REG_ROUTE_RXPEN |
-			REG_ROUTE_CLKPEN |
-			REG_ROUTE_LOCATION(ddata->pdata.location), REG_ROUTE);
-
-	ret = request_irq(ddata->rxirq, efm32_spi_rxirq,
-			0, DRIVER_NAME " rx", ddata);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register rxirq (%d)\n", ret);
-		goto err_disable_clk;
-	}
-
-	ret = request_irq(ddata->txirq, efm32_spi_txirq,
-			0, DRIVER_NAME " tx", ddata);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register txirq (%d)\n", ret);
-		goto err_free_rx_irq;
-	}
-
-	ret = spi_bitbang_start(&ddata->bitbang);
-	if (ret) {
-		dev_err(&pdev->dev, "spi_bitbang_start failed (%d)\n", ret);
-
-		free_irq(ddata->txirq, ddata);
-err_free_rx_irq:
-		free_irq(ddata->rxirq, ddata);
-err_disable_clk:
-		clk_disable_unprepare(ddata->clk);
-err:
-		spi_master_put(master);
-	}
-
-	return ret;
-}
-
-static int efm32_spi_remove(struct platform_device *pdev)
-{
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct efm32_spi_ddata *ddata = spi_master_get_devdata(master);
-
-	spi_bitbang_stop(&ddata->bitbang);
-
-	efm32_spi_write32(ddata, 0, REG_IEN);
-
-	free_irq(ddata->txirq, ddata);
-	free_irq(ddata->rxirq, ddata);
-	clk_disable_unprepare(ddata->clk);
-	spi_master_put(master);
-
-	return 0;
-}
-
-static const struct of_device_id efm32_spi_dt_ids[] = {
-	{
-		.compatible = "energymicro,efm32-spi",
-	}, {
-		/* doesn't follow the "vendor,device" scheme, don't use */
-		.compatible = "efm32,spi",
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(of, efm32_spi_dt_ids);
-
-static struct platform_driver efm32_spi_driver = {
-	.probe = efm32_spi_probe,
-	.remove = efm32_spi_remove,
-
-	.driver = {
-		.name = DRIVER_NAME,
-		.of_match_table = efm32_spi_dt_ids,
-	},
-};
-module_platform_driver(efm32_spi_driver);
-
-MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
-MODULE_DESCRIPTION("EFM32 SPI driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/include/linux/platform_data/efm32-spi.h b/include/linux/platform_data/efm32-spi.h
deleted file mode 100644
index a2c56fcd0534..000000000000
--- a/include/linux/platform_data/efm32-spi.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_PLATFORM_DATA_EFM32_SPI_H__
-#define __LINUX_PLATFORM_DATA_EFM32_SPI_H__
-
-#include <linux/types.h>
-
-/**
- * struct efm32_spi_pdata
- * @location: pinmux location for the I/O pins (to be written to the ROUTE
- * 	register)
- */
-struct efm32_spi_pdata {
-	u8 location;
-};
-#endif /* ifndef __LINUX_PLATFORM_DATA_EFM32_SPI_H__ */
-- 
2.29.2

