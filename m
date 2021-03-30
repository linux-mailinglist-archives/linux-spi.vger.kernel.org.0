Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0FF34EE72
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhC3Qt3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhC3QtS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 12:49:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DEC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 09:49:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a1so20664386ljp.2
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Ek1wb23w4C4IXdQ+bpI1DTLG50A/SfcGdFR/A0Yd9I=;
        b=yZOsHOyxekGvLSWpeVNG2VLZPXkSWCD/XCTNPggFQLo2nU7bQUJq1SlPm5NK7XFRqY
         50aTxsRv8Wzj2f6GFws+MbbDiIb3qtodL16cBHUx7yskNWk3cloLexVSuym1R43Jw3Le
         ulZl1Mr4dA5tRVxRLZqqJ59CvdEkeqjm0YAPdbUQjZT+vv9SI5gxQibSUc4KvbsYflF1
         rqcmqgC585S7Zy3X9/ohUhrUqcMOmqxAj23eB5njuZ7dDHRFqwJ/aLR6XN7hOPHH9+5U
         eWrAMUD7HSSo+bXJdKLMQV9adwQK4HRexv+ceEUdbWeWbU1dcw9aFoQs71ts32IEKPMQ
         AhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ek1wb23w4C4IXdQ+bpI1DTLG50A/SfcGdFR/A0Yd9I=;
        b=PbEl9izDeR64fYT8Du62EaRk6ybdTJAjYhSpTnEJwSjsMD1bZzW4avAaQbcMr60mN3
         JPGTetxQdliyiybmIzR+Mn1y9AQOXNYbdYkCSFApq30hQw5Q4JgscvNioHFTsbEj9WhD
         EtwaJhjf4TiLKRN7vucw6Tog8E/Tbzq3rX87MZc9WQP42K/vmY0NiygIrio1J9xm5dNH
         3EqELXMJCFXub59v4P5jmMZ0viVJp8q9zXk6I4afoZyLWU4JZrhzeJ+/DO4gaZ9uK1DJ
         LxmbxqRhsbyrtexn8YDbxLGd6WWRAB2pV7NqbfZTVYky7abKIvlNkhcrrOixOsKJoYIu
         5mQw==
X-Gm-Message-State: AOAM532w0zd0matQpi/aUky9fWXGTT9ndrJlUMJ4rsCLqsausbMNX8iy
        iiB2mmWaV0gR1z/Wmto2MYVDfQ==
X-Google-Smtp-Source: ABdhPJxA6FY+r6hpx+t44FOF4QdfNYS4IZ3D5BXnBZj8dtfPlxgIMpbM8fru4MVZZRwgudlPjcxmuQ==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr22194995ljh.333.1617122955905;
        Tue, 30 Mar 2021 09:49:15 -0700 (PDT)
Received: from localhost.localdomain (c-14cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.20])
        by smtp.gmail.com with ESMTPSA id m19sm2839025ljb.10.2021.03.30.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:49:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] spi: pl022: Use GPIOs looked up by the core
Date:   Tue, 30 Mar 2021 18:49:06 +0200
Message-Id: <20210330164907.2346010-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210330164907.2346010-1-linus.walleij@linaro.org>
References: <20210330164907.2346010-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI core looks up GPIO lines from the device tree,
so let's stop trying to do that on our own and rely
on the core to do this for us.

In addition to the GPIO line we also need to keep
track of the chip select index separately, as the native
chip select needs this index. The driver was reusing
the same GPIO array for native chip select indices,
so keep this in a separate state variable instead.

The facility to pass in custom GPIO lines from the
platform data can go, because even if we do have
out-of-tree code that want to use platform data, they
can soon pass in GPIOs using machine GPIO descriptor
tables which will be available after the next step
when we convert the driver to using GPIO descriptors.

The implicit inclusion of <linux/of.h> is made
explicit as we no longer need to include <linux/of_gpio.h>.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c    | 70 ++++++--------------------------------
 include/linux/amba/pl022.h |  7 ----
 2 files changed, 10 insertions(+), 67 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index e5dd7756c2ea..84ffed2a3554 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -32,7 +32,7 @@
 #include <linux/scatterlist.h>
 #include <linux/pm_runtime.h>
 #include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 
 /*
@@ -362,8 +362,8 @@ struct vendor_data {
  * @sgt_tx: scattertable for the TX transfer
  * @dummypage: a dummy page used for driving data on the bus with DMA
  * @dma_running: indicates whether DMA is in operation
- * @cur_cs: current chip select (gpio)
- * @chipselects: list of chipselects (gpios)
+ * @cur_cs: current chip select index
+ * @cur_gpio: current chip select GPIO line
  */
 struct pl022 {
 	struct amba_device		*adev;
@@ -398,7 +398,7 @@ struct pl022 {
 	bool				dma_running;
 #endif
 	int cur_cs;
-	int *chipselects;
+	int cur_gpio;
 };
 
 /**
@@ -454,8 +454,8 @@ static void pl022_cs_control(struct pl022 *pl022, u32 command)
 {
 	if (pl022->vendor->internal_cs_ctrl)
 		internal_cs_control(pl022, command);
-	else if (gpio_is_valid(pl022->cur_cs))
-		gpio_set_value(pl022->cur_cs, command);
+	else if (gpio_is_valid(pl022->cur_gpio))
+		gpio_set_value(pl022->cur_gpio, command);
 }
 
 /**
@@ -1580,7 +1580,9 @@ static int pl022_transfer_one_message(struct spi_master *master,
 
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip = spi_get_ctldata(msg->spi);
-	pl022->cur_cs = pl022->chipselects[msg->spi->chip_select];
+	pl022->cur_cs = msg->spi->chip_select;
+	/* This is always available but may be set to -ENOENT */
+	pl022->cur_gpio = msg->spi->cs_gpio;
 
 	restore_state(pl022);
 	flush(pl022);
@@ -1923,8 +1925,6 @@ static int pl022_setup(struct spi_device *spi)
 
 	/* Now set controller state based on controller data */
 	chip->xfer_type = chip_info->com_mode;
-	if (!gpio_is_valid(pl022->chipselects[spi->chip_select]))
-		dev_warn(&spi->dev, "invalid chip select\n");
 
 	/* Check bits per word with vendor specific range */
 	if ((bits <= 3) || (bits > pl022->vendor->max_bpw)) {
@@ -2072,7 +2072,6 @@ pl022_platform_data_dt_get(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct pl022_ssp_controller *pd;
-	u32 tmp = 0;
 
 	if (!np) {
 		dev_err(dev, "no dt node defined\n");
@@ -2085,8 +2084,6 @@ pl022_platform_data_dt_get(struct device *dev)
 
 	pd->bus_id = -1;
 	pd->enable_dma = 1;
-	of_property_read_u32(np, "num-cs", &tmp);
-	pd->num_chipselect = tmp;
 	of_property_read_u32(np, "pl022,autosuspend-delay",
 			     &pd->autosuspend_delay);
 	pd->rt = of_property_read_bool(np, "pl022,rt");
@@ -2101,8 +2098,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 			dev_get_platdata(&adev->dev);
 	struct spi_master *master;
 	struct pl022 *pl022 = NULL;	/*Data for this driver */
-	struct device_node *np = adev->dev.of_node;
-	int status = 0, i, num_cs;
+	int status = 0;
 
 	dev_info(&adev->dev,
 		 "ARM PL022 driver, device ID: 0x%08x\n", adev->periphid);
@@ -2114,13 +2110,6 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENODEV;
 	}
 
-	if (platform_info->num_chipselect) {
-		num_cs = platform_info->num_chipselect;
-	} else {
-		dev_err(dev, "probe: no chip select defined\n");
-		return -ENODEV;
-	}
-
 	/* Allocate master with space for data */
 	master = spi_alloc_master(dev, sizeof(struct pl022));
 	if (master == NULL) {
@@ -2133,19 +2122,12 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	pl022->master_info = platform_info;
 	pl022->adev = adev;
 	pl022->vendor = id->data;
-	pl022->chipselects = devm_kcalloc(dev, num_cs, sizeof(int),
-					  GFP_KERNEL);
-	if (!pl022->chipselects) {
-		status = -ENOMEM;
-		goto err_no_mem;
-	}
 
 	/*
 	 * Bus Number Which has been Assigned to this SSP controller
 	 * on this board
 	 */
 	master->bus_num = platform_info->bus_id;
-	master->num_chipselect = num_cs;
 	master->cleanup = pl022_cleanup;
 	master->setup = pl022_setup;
 	master->auto_runtime_pm = true;
@@ -2154,36 +2136,6 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	master->rt = platform_info->rt;
 	master->dev.of_node = dev->of_node;
 
-	if (platform_info->num_chipselect && platform_info->chipselects) {
-		for (i = 0; i < num_cs; i++)
-			pl022->chipselects[i] = platform_info->chipselects[i];
-	} else if (pl022->vendor->internal_cs_ctrl) {
-		for (i = 0; i < num_cs; i++)
-			pl022->chipselects[i] = i;
-	} else if (IS_ENABLED(CONFIG_OF)) {
-		for (i = 0; i < num_cs; i++) {
-			int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
-
-			if (cs_gpio == -EPROBE_DEFER) {
-				status = -EPROBE_DEFER;
-				goto err_no_gpio;
-			}
-
-			pl022->chipselects[i] = cs_gpio;
-
-			if (gpio_is_valid(cs_gpio)) {
-				if (devm_gpio_request(dev, cs_gpio, "ssp-pl022"))
-					dev_err(&adev->dev,
-						"could not request %d gpio\n",
-						cs_gpio);
-				else if (gpio_direction_output(cs_gpio, 1))
-					dev_err(&adev->dev,
-						"could not set gpio %d as output\n",
-						cs_gpio);
-			}
-		}
-	}
-
 	/*
 	 * Supports mode 0-3, loopback, and active low CS. Transfers are
 	 * always MS bit first on the original pl022.
@@ -2286,8 +2238,6 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
  err_no_ioremap:
 	amba_release_regions(adev);
  err_no_ioregion:
- err_no_gpio:
- err_no_mem:
 	spi_master_put(master);
 	return status;
 }
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 29274cedefde..9bf58aac0df2 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -223,10 +223,6 @@ struct dma_chan;
 /**
  * struct pl022_ssp_master - device.platform_data for SPI controller devices.
  * @bus_id: identifier for this bus
- * @num_chipselect: chipselects are used to distinguish individual
- *     SPI slaves, and are numbered from zero to num_chipselects - 1.
- *     each slave has a chipselect signal, but it's common that not
- *     every chipselect is connected to a slave.
  * @enable_dma: if true enables DMA driven transfers.
  * @dma_rx_param: parameter to locate an RX DMA channel.
  * @dma_tx_param: parameter to locate a TX DMA channel.
@@ -235,18 +231,15 @@ struct dma_chan;
  *     indicates no delay and the device will be suspended immediately.
  * @rt: indicates the controller should run the message pump with realtime
  *     priority to minimise the transfer latency on the bus.
- * @chipselects: list of <num_chipselects> chip select gpios
  */
 struct pl022_ssp_controller {
 	u16 bus_id;
-	u8 num_chipselect;
 	u8 enable_dma:1;
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
 	int autosuspend_delay;
 	bool rt;
-	int *chipselects;
 };
 
 /**
-- 
2.29.2

