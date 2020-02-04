Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46A15148C
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 04:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDD2v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 22:28:51 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54313 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgBDD2v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Feb 2020 22:28:51 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 377D8891A9;
        Tue,  4 Feb 2020 16:28:47 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580786927;
        bh=YcBNPW1MC7iU/ikJzciIJ6vcp9EMI6jO/wnHYot75EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PuL9xw2z7OKeWfJYyECz6XjwF4+y+y3TEblZEqR7T9PkqeblWe4ILs0wIqyDw+3q9
         /7uSS8pm/b5MwTdQOE0zA8XIOcXoJ94o28/Weif0Sf/0WYfHn2iRskfvdagLqweB5Q
         3lgEJDQFMTyUf9P3IBoPJZH0SbfaXsvIR+P5fZoCw6k3612EZiJf1mjnDJDWSlxQfG
         omiUJttly/a127+0sqW1rj5URqvepZAhnOk2ABYCuJDr6SeuMeQY4r5scg5IPkTW9C
         Hw96Am0X0zuCmtzQVMGMDOlPUhwZ3cKA5y2GQmaevT2a7XDAZO6gMe5467P7tC2HM/
         1qYAntMkyTX/w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e38e4ea0000>; Tue, 04 Feb 2020 16:28:47 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id C3BF813EF9D;
        Tue,  4 Feb 2020 16:28:41 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id EFF7A280071; Tue,  4 Feb 2020 16:28:41 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 2/2] spi: Add generic SPI multiplexer
Date:   Tue,  4 Feb 2020 16:28:38 +1300
Message-Id: <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204032838.20739-1-chris.packham@alliedtelesis.co.nz>
References: <20200204032838.20739-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a SPI device driver that sits in-band and provides a SPI controller
which supports chip selects via a mux-control. This enables extra SPI
devices to be connected with limited native chip selects.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v5:
    - Drop redudnant lines, use IS_ERR() instead of PTR_ERR_OR_ZERO
   =20
    Changes in v4:
    - incorporate review feedback from Andy

 drivers/spi/Kconfig   |  11 +++
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-mux.c | 187 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/spi/spi-mux.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 870f7797b56b..a4509000a291 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -881,6 +881,17 @@ config SPI_ZYNQMP_GQSPI
 # Add new SPI master controllers in alphabetical order above this line
 #
=20
+comment "SPI Multiplexer support"
+
+config SPI_MUX
+	tristate "SPI multiplexer support"
+	select MULTIPLEXER
+	help
+	  This adds support for SPI multiplexers. Each SPI mux will be
+	  accessible as a SPI controller, the devices behind the mux will appea=
r
+	  to be chip selects on this controller. It is still necessary to
+	  select one or more specific mux-controller drivers.
+
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bb49c9e6d0a0..116409533727 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) :=3D -DDEBUG
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+=3D spi.o
 obj-$(CONFIG_SPI_MEM)			+=3D spi-mem.o
+obj-$(CONFIG_SPI_MUX)			+=3D spi-mux.o
 obj-$(CONFIG_SPI_SPIDEV)		+=3D spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+=3D spi-loopback-test.o
=20
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
+ * This driver supports a MUX on an SPI bus. This can be useful when you=
 need
+ * more chip selects than the hardware peripherals support, or than are
+ * available in a particular board setup.
+ *
+ * The driver will create an additional SPI controller. Devices added un=
der the
+ * mux will be handled as 'chip selects' on this controller.
+ */
+
+/**
+ * struct spi_mux_priv - the basic spi_mux structure
+ * @spi:		pointer to the device struct attached to the parent
+ *			spi controller
+ * @current_cs:		The current chip select set in the mux
+ * @child_msg_complete: The mux replaces the complete callback in the ch=
ild's
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
+/* should not get called when the parent controller is doing a transfer =
*/
+static int spi_mux_select(struct spi_device *spi)
+{
+	struct spi_mux_priv *priv =3D spi_controller_get_devdata(spi->controlle=
r);
+	int ret;
+
+	if (priv->current_cs =3D=3D spi->chip_select)
+		return 0;
+
+	dev_dbg(&priv->spi->dev, "setting up the mux for cs %d\n",
+		spi->chip_select);
+
+	/* copy the child device's settings except for the cs */
+	priv->spi->max_speed_hz =3D spi->max_speed_hz;
+	priv->spi->mode =3D spi->mode;
+	priv->spi->bits_per_word =3D spi->bits_per_word;
+
+	ret =3D mux_control_select(priv->mux, spi->chip_select);
+	if (ret)
+		return ret;
+
+	priv->current_cs =3D spi->chip_select;
+
+	return 0;
+}
+
+static int spi_mux_setup(struct spi_device *spi)
+{
+	struct spi_mux_priv *priv =3D spi_controller_get_devdata(spi->controlle=
r);
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
+	struct spi_mux_priv *priv =3D (struct spi_mux_priv *)context;
+	struct spi_controller *ctlr =3D spi_get_drvdata(priv->spi);
+	struct spi_message *m =3D ctlr->cur_msg;
+
+	m->complete =3D priv->child_msg_complete;
+	m->context =3D priv->child_msg_context;
+	m->spi =3D priv->child_msg_dev;
+	spi_finalize_current_message(ctlr);
+	mux_control_deselect(priv->mux);
+}
+
+static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
+						struct spi_message *m)
+{
+	struct spi_mux_priv *priv =3D spi_controller_get_devdata(ctlr);
+	struct spi_device *spi =3D m->spi;
+	int ret;
+
+	ret =3D spi_mux_select(spi);
+	if (ret)
+		return ret;
+
+	/*
+	 * Replace the complete callback, context and spi_device with our own
+	 * pointers. Save originals
+	 */
+	priv->child_msg_complete =3D m->complete;
+	priv->child_msg_context =3D m->context;
+	priv->child_msg_dev =3D m->spi;
+
+	m->complete =3D spi_mux_complete_cb;
+	m->context =3D priv;
+	m->spi =3D priv->spi;
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
+	ctlr =3D spi_alloc_master(&spi->dev, sizeof(*priv));
+	if (!ctlr)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, ctlr);
+	priv =3D spi_controller_get_devdata(ctlr);
+	priv->spi =3D spi;
+
+	priv->mux =3D devm_mux_control_get(&spi->dev, NULL);
+	if (IS_ERR(priv->mux)) {
+		ret =3D PTR_ERR(priv->mux);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&spi->dev, "failed to get control-mux\n");
+		goto err_put_ctlr;
+	}
+
+	priv->current_cs =3D SPI_MUX_NO_CS;
+
+	/* supported modes are the same as our parent's */
+	ctlr->mode_bits =3D spi->controller->mode_bits;
+	ctlr->flags =3D spi->controller->flags;
+	ctlr->transfer_one_message =3D spi_mux_transfer_one_message;
+	ctlr->setup =3D spi_mux_setup;
+	ctlr->num_chipselect =3D mux_control_states(priv->mux);
+	ctlr->bus_num =3D -1;
+	ctlr->dev.of_node =3D spi->dev.of_node;
+
+	ret =3D devm_spi_register_controller(&spi->dev, ctlr);
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
+static const struct of_device_id spi_mux_of_match[] =3D {
+	{ .compatible =3D "spi-mux" },
+	{ }
+};
+
+static struct spi_driver spi_mux_driver =3D {
+	.probe  =3D spi_mux_probe,
+	.driver =3D {
+		.name   =3D "spi-mux",
+		.of_match_table =3D spi_mux_of_match,
+	},
+};
+
+module_spi_driver(spi_mux_driver);
+
+MODULE_DESCRIPTION("SPI multiplexer");
+MODULE_LICENSE("GPL");
--=20
2.25.0

