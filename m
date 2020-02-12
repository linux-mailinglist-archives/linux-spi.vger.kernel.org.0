Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB315B586
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 00:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgBLX6a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Feb 2020 18:58:30 -0500
Received: from foss.arm.com ([217.140.110.172]:39844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgBLX6a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 Feb 2020 18:58:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B133C328;
        Wed, 12 Feb 2020 15:58:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 355703F68E;
        Wed, 12 Feb 2020 15:58:29 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:58:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Applied "spi: Add generic SPI multiplexer" to the spi tree
In-Reply-To: <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
Message-Id: <applied-20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add generic SPI multiplexer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e9e40543ad5b38b848879768359fd13650529961 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Tue, 4 Feb 2020 16:28:38 +1300
Subject: [PATCH] spi: Add generic SPI multiplexer

Add a SPI device driver that sits in-band and provides a SPI controller
which supports chip selects via a mux-control. This enables extra SPI
devices to be connected with limited native chip selects.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20200204032838.20739-3-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig   |  11 +++
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-mux.c | 187 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/spi/spi-mux.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0434614d8201..887fefe87fd5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -897,6 +897,17 @@ config SPI_ZYNQMP_GQSPI
 # Add new SPI master controllers in alphabetical order above this line
 #
 
+comment "SPI Multiplexer support"
+
+config SPI_MUX
+	tristate "SPI multiplexer support"
+	select MULTIPLEXER
+	help
+	  This adds support for SPI multiplexers. Each SPI mux will be
+	  accessible as a SPI controller, the devices behind the mux will appear
+	  to be chip selects on this controller. It is still necessary to
+	  select one or more specific mux-controller drivers.
+
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9892bdfab15e..74db1f2c3299 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
+obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 
diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
new file mode 100644
index 000000000000..4f94c9127fc1
--- /dev/null
+++ b/drivers/spi/spi-mux.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// General Purpose SPI multiplexer
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mux/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#define SPI_MUX_NO_CS	((unsigned int)-1)
+
+/**
+ * DOC: Driver description
+ *
+ * This driver supports a MUX on an SPI bus. This can be useful when you need
+ * more chip selects than the hardware peripherals support, or than are
+ * available in a particular board setup.
+ *
+ * The driver will create an additional SPI controller. Devices added under the
+ * mux will be handled as 'chip selects' on this controller.
+ */
+
+/**
+ * struct spi_mux_priv - the basic spi_mux structure
+ * @spi:		pointer to the device struct attached to the parent
+ *			spi controller
+ * @current_cs:		The current chip select set in the mux
+ * @child_msg_complete: The mux replaces the complete callback in the child's
+ *			message to its own callback; this field is used by the
+ *			driver to store the child's callback during a transfer
+ * @child_msg_context:	Used to store the child's context to the callback
+ * @child_msg_dev:	Used to store the spi_device pointer to the child
+ * @mux:		mux_control structure used to provide chip selects for
+ *			downstream spi devices
+ */
+struct spi_mux_priv {
+	struct spi_device	*spi;
+	unsigned int		current_cs;
+
+	void			(*child_msg_complete)(void *context);
+	void			*child_msg_context;
+	struct spi_device	*child_msg_dev;
+	struct mux_control	*mux;
+};
+
+/* should not get called when the parent controller is doing a transfer */
+static int spi_mux_select(struct spi_device *spi)
+{
+	struct spi_mux_priv *priv = spi_controller_get_devdata(spi->controller);
+	int ret;
+
+	if (priv->current_cs == spi->chip_select)
+		return 0;
+
+	dev_dbg(&priv->spi->dev, "setting up the mux for cs %d\n",
+		spi->chip_select);
+
+	/* copy the child device's settings except for the cs */
+	priv->spi->max_speed_hz = spi->max_speed_hz;
+	priv->spi->mode = spi->mode;
+	priv->spi->bits_per_word = spi->bits_per_word;
+
+	ret = mux_control_select(priv->mux, spi->chip_select);
+	if (ret)
+		return ret;
+
+	priv->current_cs = spi->chip_select;
+
+	return 0;
+}
+
+static int spi_mux_setup(struct spi_device *spi)
+{
+	struct spi_mux_priv *priv = spi_controller_get_devdata(spi->controller);
+
+	/*
+	 * can be called multiple times, won't do a valid setup now but we will
+	 * change the settings when we do a transfer (necessary because we
+	 * can't predict from which device it will be anyway)
+	 */
+	return spi_setup(priv->spi);
+}
+
+static void spi_mux_complete_cb(void *context)
+{
+	struct spi_mux_priv *priv = (struct spi_mux_priv *)context;
+	struct spi_controller *ctlr = spi_get_drvdata(priv->spi);
+	struct spi_message *m = ctlr->cur_msg;
+
+	m->complete = priv->child_msg_complete;
+	m->context = priv->child_msg_context;
+	m->spi = priv->child_msg_dev;
+	spi_finalize_current_message(ctlr);
+	mux_control_deselect(priv->mux);
+}
+
+static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
+						struct spi_message *m)
+{
+	struct spi_mux_priv *priv = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = m->spi;
+	int ret;
+
+	ret = spi_mux_select(spi);
+	if (ret)
+		return ret;
+
+	/*
+	 * Replace the complete callback, context and spi_device with our own
+	 * pointers. Save originals
+	 */
+	priv->child_msg_complete = m->complete;
+	priv->child_msg_context = m->context;
+	priv->child_msg_dev = m->spi;
+
+	m->complete = spi_mux_complete_cb;
+	m->context = priv;
+	m->spi = priv->spi;
+
+	/* do the transfer */
+	return spi_async(priv->spi, m);
+}
+
+static int spi_mux_probe(struct spi_device *spi)
+{
+	struct spi_controller *ctlr;
+	struct spi_mux_priv *priv;
+	int ret;
+
+	ctlr = spi_alloc_master(&spi->dev, sizeof(*priv));
+	if (!ctlr)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, ctlr);
+	priv = spi_controller_get_devdata(ctlr);
+	priv->spi = spi;
+
+	priv->mux = devm_mux_control_get(&spi->dev, NULL);
+	if (IS_ERR(priv->mux)) {
+		ret = PTR_ERR(priv->mux);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&spi->dev, "failed to get control-mux\n");
+		goto err_put_ctlr;
+	}
+
+	priv->current_cs = SPI_MUX_NO_CS;
+
+	/* supported modes are the same as our parent's */
+	ctlr->mode_bits = spi->controller->mode_bits;
+	ctlr->flags = spi->controller->flags;
+	ctlr->transfer_one_message = spi_mux_transfer_one_message;
+	ctlr->setup = spi_mux_setup;
+	ctlr->num_chipselect = mux_control_states(priv->mux);
+	ctlr->bus_num = -1;
+	ctlr->dev.of_node = spi->dev.of_node;
+
+	ret = devm_spi_register_controller(&spi->dev, ctlr);
+	if (ret)
+		goto err_put_ctlr;
+
+	return 0;
+
+err_put_ctlr:
+	spi_controller_put(ctlr);
+
+	return ret;
+}
+
+static const struct of_device_id spi_mux_of_match[] = {
+	{ .compatible = "spi-mux" },
+	{ }
+};
+
+static struct spi_driver spi_mux_driver = {
+	.probe  = spi_mux_probe,
+	.driver = {
+		.name   = "spi-mux",
+		.of_match_table = spi_mux_of_match,
+	},
+};
+
+module_spi_driver(spi_mux_driver);
+
+MODULE_DESCRIPTION("SPI multiplexer");
+MODULE_LICENSE("GPL");
-- 
2.20.1

