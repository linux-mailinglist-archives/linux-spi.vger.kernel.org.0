Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9ADC883E1
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2019 22:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHIU2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Aug 2019 16:28:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfHIU2q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Aug 2019 16:28:46 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MyseA-1iIVXW00Ju-00vy1u; Fri, 09 Aug 2019 22:28:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 07/16] spi: remove w90x900 driver
Date:   Fri,  9 Aug 2019 22:27:35 +0200
Message-Id: <20190809202749.742267-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809202749.742267-1-arnd@arndb.de>
References: <20190809202749.742267-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JqH27kA3Qoi1b+pnAqK0VgsxNvciWL6b93nQ/1T/pe+AaU9tw2U
 U/YkbsZnEFPqgDfhkjVyYYyOZNboib+AV5W1JkviMxYy/1ZDUcy24n7mf8YnBkeuI9w0Ot2
 vZwQ4FrJp7vPpK9PmSOKxNZBG4iiwWhdkxXj6X2tV8KYoYcX79YpzgVlp3oxOgwjDinGLg7
 0vuHYOcZYqZ7at8yluipQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjmqXyktiug=:3Zgeb+CEt39IC2TvY9B2ct
 21dlKZ6aCMYUNFG4DpzUnmxQ6/QkC08x6ioGXibAHWyOXs92OvQl6bqbAqtAgx5HDPcCppMiD
 /1ppZ1eySyRdo09lvM7uqjwHuyeoWYU9Cz7gDeO6iYQDdn5gj1C20K3bIya4/0Pzc5S4xALi7
 nKfGi6bHfTbitCHUI1P9g+NtXeJRHo4vPYnA5sW9uhOgJPr/izD6OrrkKnb4j63KuLfv1rA0/
 LbOpHhDnjqLFjpDhtm/Kvq2xRQIKGIAjIw9pQe3SsCtkG68BJnQP8WodszfNtG5nPeBvGrbJM
 S3UuWA1VNAWKoiPP92525yNuaJ0Pvk6l9ssLRnGDLJh3Ly8fDULDO3Xff3D2a7zist7I5eGxC
 has8C7s6Y41HPYv4UCAUcW3DBWqdplypB/uALpLmfxltn4Nuk6lwNBhuXM7zzsBBdCr+RhpsT
 ESQgK3zED4zbwkGbWkELNR3GyHQCuD1YsgS1flQavfawiui2zDMKDS3HFc+ivOfIqh25Z97YE
 EaIzrTGaGUOMP5xC7A55LZuUdPzMbsBWDs9Wd6svsH2eedWR8W02KTv3FLTrFolb4hzgxJjxt
 qbmXPqfEVJVQ9NRBCLg7GT5qZgv565cvnei1uJEpBCY6ksBoRyBvYjJn+BPTgdYPMvCkB3irl
 5jREeTvuiS9k3eQhOHk2m4iilcqbqThHxcOTSASLUZMSuwOKeS+z00c1Dn759IP3OFLAO0oRV
 iln0tA2LbV/+Qo28b+6L0uNr+ZawZ+SH1BKD5A==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ARM w90x900 platform is getting removed, so this driver is obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig                      |   7 -
 drivers/spi/Makefile                     |   1 -
 drivers/spi/spi-nuc900.c                 | 429 -----------------------
 include/Kbuild                           |   1 -
 include/linux/platform_data/spi-nuc900.h |  29 --
 5 files changed, 467 deletions(-)
 delete mode 100644 drivers/spi/spi-nuc900.c
 delete mode 100644 include/linux/platform_data/spi-nuc900.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3a1d8f1170de..949b18ed9d6b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -440,13 +440,6 @@ config SPI_NPCM_PSPI
 	  This driver provides support for Nuvoton NPCM BMC
 	  Peripheral SPI controller in master mode.
 
-config SPI_NUC900
-	tristate "Nuvoton NUC900 series SPI"
-	depends on ARCH_W90X900
-	select SPI_BITBANG
-	help
-	  SPI driver for Nuvoton NUC900 series ARM SoCs
-
 config SPI_LANTIQ_SSC
 	tristate "Lantiq SSC SPI controller"
 	depends on LANTIQ || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 63dcab552bcb..b1131809a294 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -64,7 +64,6 @@ obj-$(CONFIG_SPI_MT7621)		+= spi-mt7621.o
 obj-$(CONFIG_SPI_MXIC)			+= spi-mxic.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NPCM_PSPI)		+= spi-npcm-pspi.o
-obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
deleted file mode 100644
index 37e2034ad4d5..000000000000
--- a/drivers/spi/spi-nuc900.c
+++ /dev/null
@@ -1,429 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2009 Nuvoton technology.
- * Wan ZongShun <mcuos.com@gmail.com>
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
-
-#include <linux/platform_data/spi-nuc900.h>
-
-/* usi registers offset */
-#define USI_CNT		0x00
-#define USI_DIV		0x04
-#define USI_SSR		0x08
-#define USI_RX0		0x10
-#define USI_TX0		0x10
-
-/* usi register bit */
-#define ENINT		(0x01 << 17)
-#define ENFLG		(0x01 << 16)
-#define SLEEP		(0x0f << 12)
-#define TXNUM		(0x03 << 8)
-#define TXBITLEN	(0x1f << 3)
-#define TXNEG		(0x01 << 2)
-#define RXNEG		(0x01 << 1)
-#define LSB		(0x01 << 10)
-#define SELECTLEV	(0x01 << 2)
-#define SELECTPOL	(0x01 << 31)
-#define SELECTSLAVE	0x01
-#define GOBUSY		0x01
-
-struct nuc900_spi {
-	struct spi_bitbang	 bitbang;
-	struct completion	 done;
-	void __iomem		*regs;
-	int			 irq;
-	int			 len;
-	int			 count;
-	const unsigned char	*tx;
-	unsigned char		*rx;
-	struct clk		*clk;
-	struct spi_master	*master;
-	struct nuc900_spi_info *pdata;
-	spinlock_t		lock;
-};
-
-static inline struct nuc900_spi *to_hw(struct spi_device *sdev)
-{
-	return spi_master_get_devdata(sdev->master);
-}
-
-static void nuc900_slave_select(struct spi_device *spi, unsigned int ssr)
-{
-	struct nuc900_spi *hw = to_hw(spi);
-	unsigned int val;
-	unsigned int cs = spi->mode & SPI_CS_HIGH ? 1 : 0;
-	unsigned int cpol = spi->mode & SPI_CPOL ? 1 : 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_SSR);
-
-	if (!cs)
-		val &= ~SELECTLEV;
-	else
-		val |= SELECTLEV;
-
-	if (!ssr)
-		val &= ~SELECTSLAVE;
-	else
-		val |= SELECTSLAVE;
-
-	__raw_writel(val, hw->regs + USI_SSR);
-
-	val = __raw_readl(hw->regs + USI_CNT);
-
-	if (!cpol)
-		val &= ~SELECTPOL;
-	else
-		val |= SELECTPOL;
-
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static void nuc900_spi_chipsel(struct spi_device *spi, int value)
-{
-	switch (value) {
-	case BITBANG_CS_INACTIVE:
-		nuc900_slave_select(spi, 0);
-		break;
-
-	case BITBANG_CS_ACTIVE:
-		nuc900_slave_select(spi, 1);
-		break;
-	}
-}
-
-static void nuc900_spi_setup_txnum(struct nuc900_spi *hw, unsigned int txnum)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT) & ~TXNUM;
-
-	if (txnum)
-		val |= txnum << 0x08;
-
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-
-}
-
-static void nuc900_spi_setup_txbitlen(struct nuc900_spi *hw,
-							unsigned int txbitlen)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT) & ~TXBITLEN;
-
-	val |= (txbitlen << 0x03);
-
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static void nuc900_spi_gobusy(struct nuc900_spi *hw)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT);
-
-	val |= GOBUSY;
-
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static inline unsigned int hw_txbyte(struct nuc900_spi *hw, int count)
-{
-	return hw->tx ? hw->tx[count] : 0;
-}
-
-static int nuc900_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
-{
-	struct nuc900_spi *hw = to_hw(spi);
-
-	hw->tx = t->tx_buf;
-	hw->rx = t->rx_buf;
-	hw->len = t->len;
-	hw->count = 0;
-
-	__raw_writel(hw_txbyte(hw, 0x0), hw->regs + USI_TX0);
-
-	nuc900_spi_gobusy(hw);
-
-	wait_for_completion(&hw->done);
-
-	return hw->count;
-}
-
-static irqreturn_t nuc900_spi_irq(int irq, void *dev)
-{
-	struct nuc900_spi *hw = dev;
-	unsigned int status;
-	unsigned int count = hw->count;
-
-	status = __raw_readl(hw->regs + USI_CNT);
-	__raw_writel(status, hw->regs + USI_CNT);
-
-	if (status & ENFLG) {
-		hw->count++;
-
-		if (hw->rx)
-			hw->rx[count] = __raw_readl(hw->regs + USI_RX0);
-		count++;
-
-		if (count < hw->len) {
-			__raw_writel(hw_txbyte(hw, count), hw->regs + USI_TX0);
-			nuc900_spi_gobusy(hw);
-		} else {
-			complete(&hw->done);
-		}
-
-		return IRQ_HANDLED;
-	}
-
-	complete(&hw->done);
-	return IRQ_HANDLED;
-}
-
-static void nuc900_tx_edge(struct nuc900_spi *hw, unsigned int edge)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT);
-
-	if (edge)
-		val |= TXNEG;
-	else
-		val &= ~TXNEG;
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static void nuc900_rx_edge(struct nuc900_spi *hw, unsigned int edge)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT);
-
-	if (edge)
-		val |= RXNEG;
-	else
-		val &= ~RXNEG;
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static void nuc900_send_first(struct nuc900_spi *hw, unsigned int lsb)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT);
-
-	if (lsb)
-		val |= LSB;
-	else
-		val &= ~LSB;
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static void nuc900_set_sleep(struct nuc900_spi *hw, unsigned int sleep)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT) & ~SLEEP;
-
-	if (sleep)
-		val |= (sleep << 12);
-
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static void nuc900_enable_int(struct nuc900_spi *hw)
-{
-	unsigned int val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hw->lock, flags);
-
-	val = __raw_readl(hw->regs + USI_CNT);
-
-	val |= ENINT;
-
-	__raw_writel(val, hw->regs + USI_CNT);
-
-	spin_unlock_irqrestore(&hw->lock, flags);
-}
-
-static void nuc900_set_divider(struct nuc900_spi *hw)
-{
-	__raw_writel(hw->pdata->divider, hw->regs + USI_DIV);
-}
-
-static void nuc900_init_spi(struct nuc900_spi *hw)
-{
-	clk_enable(hw->clk);
-	spin_lock_init(&hw->lock);
-
-	nuc900_tx_edge(hw, hw->pdata->txneg);
-	nuc900_rx_edge(hw, hw->pdata->rxneg);
-	nuc900_send_first(hw, hw->pdata->lsb);
-	nuc900_set_sleep(hw, hw->pdata->sleep);
-	nuc900_spi_setup_txbitlen(hw, hw->pdata->txbitlen);
-	nuc900_spi_setup_txnum(hw, hw->pdata->txnum);
-	nuc900_set_divider(hw);
-	nuc900_enable_int(hw);
-}
-
-static int nuc900_spi_probe(struct platform_device *pdev)
-{
-	struct nuc900_spi *hw;
-	struct spi_master *master;
-	struct resource *res;
-	int err = 0;
-
-	master = spi_alloc_master(&pdev->dev, sizeof(struct nuc900_spi));
-	if (master == NULL) {
-		dev_err(&pdev->dev, "No memory for spi_master\n");
-		return -ENOMEM;
-	}
-
-	hw = spi_master_get_devdata(master);
-	hw->master = master;
-	hw->pdata  = dev_get_platdata(&pdev->dev);
-
-	if (hw->pdata == NULL) {
-		dev_err(&pdev->dev, "No platform data supplied\n");
-		err = -ENOENT;
-		goto err_pdata;
-	}
-
-	platform_set_drvdata(pdev, hw);
-	init_completion(&hw->done);
-
-	master->mode_bits          = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	if (hw->pdata->lsb)
-		master->mode_bits |= SPI_LSB_FIRST;
-	master->num_chipselect     = hw->pdata->num_cs;
-	master->bus_num            = hw->pdata->bus_num;
-	hw->bitbang.master         = hw->master;
-	hw->bitbang.chipselect     = nuc900_spi_chipsel;
-	hw->bitbang.txrx_bufs      = nuc900_spi_txrx;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hw->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hw->regs)) {
-		err = PTR_ERR(hw->regs);
-		goto err_pdata;
-	}
-
-	hw->irq = platform_get_irq(pdev, 0);
-	if (hw->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ specified\n");
-		err = -ENOENT;
-		goto err_pdata;
-	}
-
-	err = devm_request_irq(&pdev->dev, hw->irq, nuc900_spi_irq, 0,
-				pdev->name, hw);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		goto err_pdata;
-	}
-
-	hw->clk = devm_clk_get(&pdev->dev, "spi");
-	if (IS_ERR(hw->clk)) {
-		dev_err(&pdev->dev, "No clock for device\n");
-		err = PTR_ERR(hw->clk);
-		goto err_pdata;
-	}
-
-	mfp_set_groupg(&pdev->dev, NULL);
-	nuc900_init_spi(hw);
-
-	err = spi_bitbang_start(&hw->bitbang);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to register SPI master\n");
-		goto err_register;
-	}
-
-	return 0;
-
-err_register:
-	clk_disable(hw->clk);
-err_pdata:
-	spi_master_put(hw->master);
-	return err;
-}
-
-static int nuc900_spi_remove(struct platform_device *dev)
-{
-	struct nuc900_spi *hw = platform_get_drvdata(dev);
-
-	spi_bitbang_stop(&hw->bitbang);
-	clk_disable(hw->clk);
-	spi_master_put(hw->master);
-	return 0;
-}
-
-static struct platform_driver nuc900_spi_driver = {
-	.probe		= nuc900_spi_probe,
-	.remove		= nuc900_spi_remove,
-	.driver		= {
-		.name	= "nuc900-spi",
-	},
-};
-module_platform_driver(nuc900_spi_driver);
-
-MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
-MODULE_DESCRIPTION("nuc900 spi driver!");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:nuc900-spi");
diff --git a/include/Kbuild b/include/Kbuild
index c38f0d46b267..5e0642d79dce 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -550,7 +550,6 @@ header-test-			+= linux/platform_data/sky81452-backlight.h
 header-test-			+= linux/platform_data/spi-davinci.h
 header-test-			+= linux/platform_data/spi-ep93xx.h
 header-test-			+= linux/platform_data/spi-mt65xx.h
-header-test-			+= linux/platform_data/spi-nuc900.h
 header-test-			+= linux/platform_data/st_sensors_pdata.h
 header-test-			+= linux/platform_data/ti-sysc.h
 header-test-			+= linux/platform_data/timer-ixp4xx.h
diff --git a/include/linux/platform_data/spi-nuc900.h b/include/linux/platform_data/spi-nuc900.h
deleted file mode 100644
index ca3510877000..000000000000
--- a/include/linux/platform_data/spi-nuc900.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2009 Nuvoton technology corporation.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- */
-
-#ifndef __SPI_NUC900_H
-#define __SPI_NUC900_H
-
-extern void mfp_set_groupg(struct device *dev, const char *subname);
-
-struct nuc900_spi_info {
-	unsigned int num_cs;
-	unsigned int lsb;
-	unsigned int txneg;
-	unsigned int rxneg;
-	unsigned int divider;
-	unsigned int sleep;
-	unsigned int txnum;
-	unsigned int txbitlen;
-	int bus_num;
-};
-
-struct nuc900_spi_chip {
-	unsigned char bits_per_word;
-};
-
-#endif /* __SPI_NUC900_H */
-- 
2.20.0

