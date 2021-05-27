Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28603937DD
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 23:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhE0VVr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 17:21:47 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:51173 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhE0VVq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 17:21:46 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 17:21:46 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D98AE10189B73;
        Thu, 27 May 2021 23:11:02 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id B45226011CC8;
        Thu, 27 May 2021 23:11:02 +0200 (CEST)
X-Mailbox-Line: From f76a0599469f265b69c371538794101fa37b5536 Mon Sep 17 00:00:00 2001
Message-Id: <f76a0599469f265b69c371538794101fa37b5536.1622149321.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 27 May 2021 23:10:56 +0200
Subject: [PATCH for-5.13] spi: Cleanup on failure of initial setup
To:     Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-spi@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit c7299fea6769 ("spi: Fix spi device unregister flow") changed the
SPI core's behavior if the ->setup() hook returns an error upon adding
an spi_device:  Before, the ->cleanup() hook was invoked to free any
allocations that were made by ->setup().  With the commit, that's no
longer the case, so the ->setup() hook is expected to free the
allocations itself.

I've identified 5 drivers which depend on the old behavior and am fixing
them up hereinafter: spi-bitbang.c spi-fsl-spi.c spi-omap-uwire.c
spi-omap2-mcspi.c spi-pxa2xx.c

Importantly, ->setup() is not only invoked on spi_device *addition*:
It may subsequently be called to *change* SPI parameters.  If changing
these SPI parameters fails, freeing memory allocations would be wrong.
That should only be done if the spi_device is finally destroyed.
I am therefore using a bool "initial_setup" in 4 of the affected drivers
to differentiate between the invocation on *adding* the spi_device and
any subsequent invocations: spi-bitbang.c spi-fsl-spi.c spi-omap-uwire.c
spi-omap2-mcspi.c

In spi-pxa2xx.c, it seems the ->setup() hook can only fail on spi_device
addition, not any subsequent calls.  It therefore doesn't need the bool.

It's worth noting that 5 other drivers already perform a cleanup if the
->setup() hook fails.  Before c7299fea6769, they caused a double-free
if ->setup() failed on spi_device addition.  Since the commit, they're
fine.  These drivers are: spi-mpc512x-psc.c spi-pl022.c spi-s3c64xx.c
spi-st-ssc4.c spi-tegra114.c

(spi-pxa2xx.c also already performs a cleanup, but only in one of
several error paths.)

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Saravana Kannan <saravanak@google.com>
---
Compile-tested only!  Please review and test.
 drivers/spi/spi-bitbang.c     | 18 ++++++++++++++----
 drivers/spi/spi-fsl-spi.c     |  4 ++++
 drivers/spi/spi-omap-uwire.c  |  9 ++++++++-
 drivers/spi/spi-omap2-mcspi.c | 33 ++++++++++++++++++++-------------
 drivers/spi/spi-pxa2xx.c      |  9 ++++++++-
 5 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 6a6af85aebfd..27d0087f8688 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -184,6 +184,8 @@ int spi_bitbang_setup(struct spi_device *spi)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	struct spi_bitbang	*bitbang;
+	bool			initial_setup = false;
+	int			retval;
 
 	bitbang = spi_master_get_devdata(spi->master);
 
@@ -192,22 +194,30 @@ int spi_bitbang_setup(struct spi_device *spi)
 		if (!cs)
 			return -ENOMEM;
 		spi->controller_state = cs;
+		initial_setup = true;
 	}
 
 	/* per-word shift register access, in hardware or bitbanging */
 	cs->txrx_word = bitbang->txrx_word[spi->mode & (SPI_CPOL|SPI_CPHA)];
-	if (!cs->txrx_word)
-		return -EINVAL;
+	if (!cs->txrx_word) {
+		retval = -EINVAL;
+		goto err_free;
+	}
 
 	if (bitbang->setup_transfer) {
-		int retval = bitbang->setup_transfer(spi, NULL);
+		retval = bitbang->setup_transfer(spi, NULL);
 		if (retval < 0)
-			return retval;
+			goto err_free;
 	}
 
 	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
 	return 0;
+
+err_free:
+	if (initial_setup)
+		kfree(cs);
+	return retval;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index d0e5aa18b7ba..bdf94cc7be1a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -440,6 +440,7 @@ static int fsl_spi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_spi_reg __iomem *reg_base;
+	bool initial_setup = false;
 	int retval;
 	u32 hw_mode;
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
@@ -452,6 +453,7 @@ static int fsl_spi_setup(struct spi_device *spi)
 		if (!cs)
 			return -ENOMEM;
 		spi_set_ctldata(spi, cs);
+		initial_setup = true;
 	}
 	mpc8xxx_spi = spi_master_get_devdata(spi->master);
 
@@ -475,6 +477,8 @@ static int fsl_spi_setup(struct spi_device *spi)
 	retval = fsl_spi_setup_transfer(spi, NULL);
 	if (retval < 0) {
 		cs->hw_mode = hw_mode; /* Restore settings */
+		if (initial_setup)
+			kfree(cs);
 		return retval;
 	}
 
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 71402f71ddd8..df28c6664aba 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -424,15 +424,22 @@ static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static int uwire_setup(struct spi_device *spi)
 {
 	struct uwire_state *ust = spi->controller_state;
+	bool initial_setup = false;
+	int status;
 
 	if (ust == NULL) {
 		ust = kzalloc(sizeof(*ust), GFP_KERNEL);
 		if (ust == NULL)
 			return -ENOMEM;
 		spi->controller_state = ust;
+		initial_setup = true;
 	}
 
-	return uwire_setup_transfer(spi, NULL);
+	status = uwire_setup_transfer(spi, NULL);
+	if (status && initial_setup)
+		kfree(ust);
+
+	return status;
 }
 
 static void uwire_cleanup(struct spi_device *spi)
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 999c22736416..ede7f05e5ced 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1032,8 +1032,22 @@ static void omap2_mcspi_release_dma(struct spi_master *master)
 	}
 }
 
+static void omap2_mcspi_cleanup(struct spi_device *spi)
+{
+	struct omap2_mcspi_cs	*cs;
+
+	if (spi->controller_state) {
+		/* Unlink controller state from context save list */
+		cs = spi->controller_state;
+		list_del(&cs->node);
+
+		kfree(cs);
+	}
+}
+
 static int omap2_mcspi_setup(struct spi_device *spi)
 {
+	bool			initial_setup = false;
 	int			ret;
 	struct omap2_mcspi	*mcspi = spi_master_get_devdata(spi->master);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
@@ -1051,35 +1065,28 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		spi->controller_state = cs;
 		/* Link this to context save list */
 		list_add_tail(&cs->node, &ctx->cs);
+		initial_setup = true;
 	}
 
 	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(mcspi->dev);
+		if (initial_setup)
+			omap2_mcspi_cleanup(spi);
 
 		return ret;
 	}
 
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
+	if (ret && initial_setup)
+		omap2_mcspi_cleanup(spi);
+
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
 
 	return ret;
 }
 
-static void omap2_mcspi_cleanup(struct spi_device *spi)
-{
-	struct omap2_mcspi_cs	*cs;
-
-	if (spi->controller_state) {
-		/* Unlink controller state from context save list */
-		cs = spi->controller_state;
-		list_del(&cs->node);
-
-		kfree(cs);
-	}
-}
-
 static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
 {
 	struct omap2_mcspi *mcspi = data;
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5e59ba075bc7..8ee0cc071777 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1254,6 +1254,8 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
 
 		err = gpiod_direction_output(gpiod, !chip->gpio_cs_inverted);
+		if (err)
+			gpiod_put(chip->gpiod_cs);
 	}
 
 	return err;
@@ -1267,6 +1269,7 @@ static int setup(struct spi_device *spi)
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
 	uint tx_thres, tx_hi_thres, rx_thres;
+	int err;
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
@@ -1413,7 +1416,11 @@ static int setup(struct spi_device *spi)
 	if (drv_data->ssp_type == CE4100_SSP)
 		return 0;
 
-	return setup_cs(spi, chip, chip_info);
+	err = setup_cs(spi, chip, chip_info);
+	if (err)
+		kfree(chip);
+
+	return err;
 }
 
 static void cleanup(struct spi_device *spi)
-- 
2.31.1

