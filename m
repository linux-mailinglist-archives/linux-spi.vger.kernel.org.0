Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAF3FBF37
	for <lists+linux-spi@lfdr.de>; Tue, 31 Aug 2021 01:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbhH3XD0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Aug 2021 19:03:26 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:53775 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbhH3XDX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Aug 2021 19:03:23 -0400
Received: (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E0D23200005;
        Mon, 30 Aug 2021 23:02:25 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Pavel Nadein <pavelnadein@gmail.com>
Cc:     Pavel Nadein <pasha-net@narod.ru>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [5.16][PATCH 2/3] SPI: add Ingenic JZ47xx driver.
Date:   Tue, 31 Aug 2021 01:01:38 +0200
Message-Id: <20210830230139.21476-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830230139.21476-1-contact@artur-rojek.eu>
References: <20210830230139.21476-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a driver to support the SPI controller found in Ingenic SoCs.

Co-developed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/spi/Kconfig       |   9 +
 drivers/spi/Makefile      |   1 +
 drivers/spi/spi-ingenic.c | 482 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 492 insertions(+)
 create mode 100644 drivers/spi/spi-ingenic.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83e352b0c8f9..ea824b0012c6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -406,6 +406,15 @@ config SPI_IMX
 	help
 	  This enables support for the Freescale i.MX SPI controllers.
 
+config SPI_INGENIC
+	tristate "Ingenic JZ47xx SoCs SPI controller"
+	depends on MACH_INGENIC || COMPILE_TEST
+	help
+	  This enables support for the Ingenic JZ47xx SoCs SPI controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called spi-ingenic.
+
 config SPI_JCORE
 	tristate "J-Core SPI Master"
 	depends on OF && (SUPERH || COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 699db95c8441..322952dfd279 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SPI_HISI_KUNPENG)		+= spi-hisi-kunpeng.o
 obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
+obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
 obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
new file mode 100644
index 000000000000..03077a7e11c8
--- /dev/null
+++ b/drivers/spi/spi-ingenic.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI bus driver for the Ingenic JZ47xx SoCs
+ * Copyright (c) 2017-2021 Artur Rojek <contact@artur-rojek.eu>
+ * Copyright (c) 2017-2021 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#define REG_SSIDR	0x0
+#define REG_SSICR0	0x4
+#define REG_SSICR1	0x8
+#define REG_SSISR	0xc
+#define REG_SSIGR	0x18
+
+#define REG_SSICR0_TENDIAN_LSB		BIT(19)
+#define REG_SSICR0_RENDIAN_LSB		BIT(17)
+#define REG_SSICR0_SSIE			BIT(15)
+#define REG_SSICR0_LOOP			BIT(10)
+#define REG_SSICR0_EACLRUN		BIT(7)
+#define REG_SSICR0_FSEL			BIT(6)
+#define REG_SSICR0_TFLUSH		BIT(2)
+#define REG_SSICR0_RFLUSH		BIT(1)
+
+#define REG_SSICR1_FRMHL_MASK		(BIT(31) | BIT(30))
+#define REG_SSICR1_FRMHL		BIT(30)
+#define REG_SSICR1_LFST			BIT(25)
+#define REG_SSICR1_UNFIN		BIT(23)
+#define REG_SSICR1_PHA			BIT(1)
+#define REG_SSICR1_POL			BIT(0)
+
+#define REG_SSISR_END			BIT(7)
+#define REG_SSISR_BUSY			BIT(6)
+#define REG_SSISR_TFF			BIT(5)
+#define REG_SSISR_RFE			BIT(4)
+#define REG_SSISR_RFHF			BIT(2)
+#define REG_SSISR_UNDR			BIT(1)
+#define REG_SSISR_OVER			BIT(0)
+
+#define SPI_INGENIC_FIFO_SIZE		128u
+
+struct jz_soc_info {
+	u32 bits_per_word_mask;
+	struct reg_field flen_field;
+	bool has_trendian;
+};
+
+struct ingenic_spi {
+	const struct jz_soc_info *soc_info;
+	struct clk *clk;
+	struct resource *mem_res;
+
+	struct regmap *map;
+	struct regmap_field *flen_field;
+};
+
+static int spi_ingenic_wait(struct ingenic_spi *priv,
+			    unsigned long mask,
+			    bool condition)
+{
+	unsigned int val;
+
+	return regmap_read_poll_timeout(priv->map, REG_SSISR, val,
+					!!(val & mask) == condition,
+					100, 10000);
+}
+
+static void spi_ingenic_set_cs(struct spi_device *spi, bool disable)
+{
+	struct ingenic_spi *priv = spi_controller_get_devdata(spi->controller);
+
+	if (disable) {
+		regmap_clear_bits(priv->map, REG_SSICR1, REG_SSICR1_UNFIN);
+		regmap_clear_bits(priv->map, REG_SSISR,
+				  REG_SSISR_UNDR | REG_SSISR_OVER);
+
+		spi_ingenic_wait(priv, REG_SSISR_END, true);
+	} else {
+		regmap_set_bits(priv->map, REG_SSICR1, REG_SSICR1_UNFIN);
+	}
+
+	regmap_set_bits(priv->map, REG_SSICR0,
+			REG_SSICR0_RFLUSH | REG_SSICR0_TFLUSH);
+}
+
+static void spi_ingenic_prepare_transfer(struct ingenic_spi *priv,
+					 struct spi_device *spi,
+					 struct spi_transfer *xfer)
+{
+	unsigned long clk_hz = clk_get_rate(priv->clk);
+	u32 cdiv, speed_hz = xfer->speed_hz ?: spi->max_speed_hz,
+	    bits_per_word = xfer->bits_per_word ?: spi->bits_per_word;
+
+	cdiv = clk_hz / (speed_hz * 2);
+	cdiv = clamp(cdiv, 1u, 0x100u) - 1;
+
+	regmap_write(priv->map, REG_SSIGR, cdiv);
+
+	regmap_field_write(priv->flen_field, bits_per_word - 2);
+}
+
+static void spi_ingenic_finalize_transfer(void *controller)
+{
+	spi_finalize_current_transfer(controller);
+}
+
+static struct dma_async_tx_descriptor *
+spi_ingenic_prepare_dma(struct spi_controller *ctlr, struct dma_chan *chan,
+			struct sg_table *sg, enum dma_transfer_direction dir,
+			unsigned int bits)
+{
+	struct ingenic_spi *priv = spi_controller_get_devdata(ctlr);
+	struct dma_slave_config cfg = {
+		.direction = dir,
+		.src_addr = priv->mem_res->start + REG_SSIDR,
+		.dst_addr = priv->mem_res->start + REG_SSIDR,
+	};
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	int ret;
+
+	if (bits > 16) {
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		cfg.src_maxburst = cfg.dst_maxburst = 4;
+	} else if (bits > 8) {
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		cfg.src_maxburst = cfg.dst_maxburst = 2;
+	} else {
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		cfg.src_maxburst = cfg.dst_maxburst = 1;
+	}
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret)
+		return ERR_PTR(ret);
+
+	desc = dmaengine_prep_slave_sg(chan, sg->sgl, sg->nents, dir,
+				       DMA_PREP_INTERRUPT);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	if (dir == DMA_DEV_TO_MEM) {
+		desc->callback = spi_ingenic_finalize_transfer;
+		desc->callback_param = ctlr;
+	}
+
+	cookie = dmaengine_submit(desc);
+
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dmaengine_desc_free(desc);
+		return ERR_PTR(ret);
+	}
+
+	return desc;
+}
+
+static int spi_ingenic_dma_tx(struct spi_controller *ctlr,
+			      struct spi_transfer *xfer, unsigned int bits)
+{
+	struct dma_async_tx_descriptor *rx_desc, *tx_desc;
+
+	rx_desc = spi_ingenic_prepare_dma(ctlr, ctlr->dma_rx,
+					  &xfer->rx_sg, DMA_DEV_TO_MEM, bits);
+	if (IS_ERR(rx_desc))
+		return PTR_ERR(rx_desc);
+
+	tx_desc = spi_ingenic_prepare_dma(ctlr, ctlr->dma_tx,
+					  &xfer->tx_sg, DMA_MEM_TO_DEV, bits);
+	if (IS_ERR(tx_desc)) {
+		dmaengine_terminate_async(ctlr->dma_rx);
+		dmaengine_desc_free(rx_desc);
+		return PTR_ERR(tx_desc);
+	}
+
+	dma_async_issue_pending(ctlr->dma_rx);
+	dma_async_issue_pending(ctlr->dma_tx);
+
+	return 1;
+}
+
+#define SPI_INGENIC_TX(x)							\
+static int spi_ingenic_tx##x(struct ingenic_spi *priv,				\
+			     struct spi_transfer *xfer)				\
+{										\
+	unsigned int count = xfer->len / (x / 8);				\
+	unsigned int prefill = min(count, SPI_INGENIC_FIFO_SIZE);		\
+	const u##x *tx_buf = xfer->tx_buf;					\
+	u##x *rx_buf = xfer->rx_buf;						\
+	unsigned int i, val;							\
+	int err;								\
+										\
+	/* Fill up the TX fifo */						\
+	for (i = 0; i < prefill; i++) {						\
+		val = tx_buf ? tx_buf[i] : 0;					\
+										\
+		regmap_write(priv->map, REG_SSIDR, val);			\
+	}									\
+										\
+	for (i = 0; i < count; i++) {						\
+		err = spi_ingenic_wait(priv, REG_SSISR_RFE, false);		\
+		if (err)							\
+			return err;						\
+										\
+		regmap_read(priv->map, REG_SSIDR, &val);			\
+		if (rx_buf)							\
+			rx_buf[i] = val;					\
+										\
+		if (i < count - prefill) {					\
+			val = tx_buf ? tx_buf[i + prefill] : 0;			\
+										\
+			regmap_write(priv->map, REG_SSIDR, val);		\
+		}								\
+	}									\
+										\
+	return 0;								\
+}
+SPI_INGENIC_TX(8)
+SPI_INGENIC_TX(16)
+SPI_INGENIC_TX(32)
+#undef SPI_INGENIC_TX
+
+static int spi_ingenic_transfer_one(struct spi_controller *ctlr,
+				    struct spi_device *spi,
+				    struct spi_transfer *xfer)
+{
+	struct ingenic_spi *priv = spi_controller_get_devdata(ctlr);
+	unsigned int bits = xfer->bits_per_word ?: spi->bits_per_word;
+	bool can_dma = ctlr->can_dma && ctlr->can_dma(ctlr, spi, xfer);
+
+	spi_ingenic_prepare_transfer(priv, spi, xfer);
+
+	if (ctlr->cur_msg_mapped && can_dma)
+		return spi_ingenic_dma_tx(ctlr, xfer, bits);
+
+	if (bits > 16)
+		return spi_ingenic_tx32(priv, xfer);
+
+	if (bits > 8)
+		return spi_ingenic_tx16(priv, xfer);
+
+	return spi_ingenic_tx8(priv, xfer);
+}
+
+static int spi_ingenic_prepare_message(struct spi_controller *ctlr,
+				       struct spi_message *message)
+{
+	struct ingenic_spi *priv = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = message->spi;
+	unsigned int cs = REG_SSICR1_FRMHL << spi->chip_select;
+	unsigned int ssicr0_mask = REG_SSICR0_LOOP | REG_SSICR0_FSEL;
+	unsigned int ssicr1_mask = REG_SSICR1_PHA | REG_SSICR1_POL | cs;
+	unsigned int ssicr0 = 0, ssicr1 = 0;
+
+	if (priv->soc_info->has_trendian) {
+		ssicr0_mask |= REG_SSICR0_RENDIAN_LSB | REG_SSICR0_TENDIAN_LSB;
+
+		if (spi->mode & SPI_LSB_FIRST)
+			ssicr0 |= REG_SSICR0_RENDIAN_LSB | REG_SSICR0_TENDIAN_LSB;
+	} else {
+		ssicr1_mask |= REG_SSICR1_LFST;
+
+		if (spi->mode & SPI_LSB_FIRST)
+			ssicr1 |= REG_SSICR1_LFST;
+	}
+
+	if (spi->mode & SPI_LOOP)
+		ssicr0 |= REG_SSICR0_LOOP;
+	if (spi->chip_select)
+		ssicr0 |= REG_SSICR0_FSEL;
+
+	if (spi->mode & SPI_CPHA)
+		ssicr1 |= REG_SSICR1_PHA;
+	if (spi->mode & SPI_CPOL)
+		ssicr1 |= REG_SSICR1_POL;
+	if (spi->mode & SPI_CS_HIGH)
+		ssicr1 |= cs;
+
+	regmap_update_bits(priv->map, REG_SSICR0, ssicr0_mask, ssicr0);
+	regmap_update_bits(priv->map, REG_SSICR1, ssicr1_mask, ssicr1);
+
+	return 0;
+}
+
+static int spi_ingenic_prepare_hardware(struct spi_controller *ctlr)
+{
+	struct ingenic_spi *priv = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->map, REG_SSICR0, REG_SSICR0_EACLRUN);
+	regmap_write(priv->map, REG_SSICR1, 0);
+	regmap_write(priv->map, REG_SSISR, 0);
+	regmap_set_bits(priv->map, REG_SSICR0, REG_SSICR0_SSIE);
+
+	return 0;
+}
+
+static int spi_ingenic_unprepare_hardware(struct spi_controller *ctlr)
+{
+	struct ingenic_spi *priv = spi_controller_get_devdata(ctlr);
+
+	regmap_clear_bits(priv->map, REG_SSICR0, REG_SSICR0_SSIE);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static bool spi_ingenic_can_dma(struct spi_controller *ctlr,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	struct dma_slave_caps caps;
+	int ret;
+
+	ret = dma_get_slave_caps(ctlr->dma_tx, &caps);
+	if (ret) {
+		dev_err(&spi->dev, "Unable to get slave caps: %d\n", ret);
+		return false;
+	}
+
+	return !caps.max_sg_burst ||
+		xfer->len <= caps.max_sg_burst * SPI_INGENIC_FIFO_SIZE;
+}
+
+static int spi_ingenic_request_dma(struct spi_controller *ctlr,
+				   struct device *dev)
+{
+	ctlr->dma_tx = dma_request_slave_channel(dev, "tx");
+	if (!ctlr->dma_tx)
+		return -ENODEV;
+
+	ctlr->dma_rx = dma_request_slave_channel(dev, "rx");
+
+	if (!ctlr->dma_rx)
+		return -ENODEV;
+
+	ctlr->can_dma = spi_ingenic_can_dma;
+
+	return 0;
+}
+
+static void spi_ingenic_release_dma(void *data)
+{
+	struct spi_controller *ctlr = data;
+
+	if (ctlr->dma_tx)
+		dma_release_channel(ctlr->dma_tx);
+	if (ctlr->dma_rx)
+		dma_release_channel(ctlr->dma_rx);
+}
+
+static const struct regmap_config spi_ingenic_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = REG_SSIGR,
+};
+
+static int spi_ingenic_probe(struct platform_device *pdev)
+{
+	const struct jz_soc_info *pdata;
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct ingenic_spi *priv;
+	void __iomem *base;
+	int ret;
+
+	pdata = of_device_get_match_data(dev);
+	if (!pdata) {
+		dev_err(dev, "Missing platform data.\n");
+		return -EINVAL;
+	}
+
+	ctlr = devm_spi_alloc_master(dev, sizeof(*priv));
+	if (!ctlr) {
+		dev_err(dev, "Unable to allocate SPI controller.\n");
+		return -ENOMEM;
+	}
+
+	priv = spi_controller_get_devdata(ctlr);
+	priv->soc_info = pdata;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Unable to get clock.\n");
+	}
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &priv->mem_res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->map = devm_regmap_init_mmio(dev, base, &spi_ingenic_regmap_config);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	priv->flen_field = devm_regmap_field_alloc(dev, priv->map,
+						   pdata->flen_field);
+	if (IS_ERR(priv->flen_field))
+		return PTR_ERR(priv->flen_field);
+
+	platform_set_drvdata(pdev, ctlr);
+
+	ctlr->prepare_transfer_hardware = spi_ingenic_prepare_hardware;
+	ctlr->unprepare_transfer_hardware = spi_ingenic_unprepare_hardware;
+	ctlr->prepare_message = spi_ingenic_prepare_message;
+	ctlr->set_cs = spi_ingenic_set_cs;
+	ctlr->transfer_one = spi_ingenic_transfer_one;
+	ctlr->mode_bits = SPI_MODE_3 | SPI_LSB_FIRST | SPI_LOOP | SPI_CS_HIGH;
+	ctlr->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+	ctlr->max_dma_len = SPI_INGENIC_FIFO_SIZE;
+	ctlr->bits_per_word_mask = pdata->bits_per_word_mask;
+	ctlr->min_speed_hz = 7200;
+	ctlr->max_speed_hz = 54000000;
+	ctlr->num_chipselect = 2;
+	ctlr->dev.of_node = pdev->dev.of_node;
+
+	if (spi_ingenic_request_dma(ctlr, dev))
+		dev_warn(dev, "DMA not available.\n");
+
+	ret = devm_add_action_or_reset(dev, spi_ingenic_release_dma, ctlr);
+	if (ret) {
+		dev_err(dev, "Unable to add action.\n");
+		return ret;
+	}
+
+	ret = devm_spi_register_controller(dev, ctlr);
+	if (ret)
+		dev_err(dev, "Unable to register SPI controller.\n");
+
+	return ret;
+}
+
+static const struct jz_soc_info jz4750_soc_info = {
+	.bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 17),
+	.flen_field = REG_FIELD(REG_SSICR1, 4, 7),
+	.has_trendian = false,
+};
+
+static const struct jz_soc_info jz4780_soc_info = {
+	.bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 32),
+	.flen_field = REG_FIELD(REG_SSICR1, 3, 7),
+	.has_trendian = true,
+};
+
+static const struct of_device_id spi_ingenic_of_match[] = {
+	{ .compatible = "ingenic,jz4750-spi", .data = &jz4750_soc_info },
+	{ .compatible = "ingenic,jz4780-spi", .data = &jz4780_soc_info },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_ingenic_of_match);
+
+static struct platform_driver spi_ingenic_driver = {
+	.driver = {
+		.name = "spi-ingenic",
+		.of_match_table = spi_ingenic_of_match,
+	},
+	.probe = spi_ingenic_probe,
+};
+
+module_platform_driver(spi_ingenic_driver);
+MODULE_DESCRIPTION("SPI bus driver for the Ingenic JZ47xx SoCs");
+MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_LICENSE("GPL");
-- 
2.33.0

