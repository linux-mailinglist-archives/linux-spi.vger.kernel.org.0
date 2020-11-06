Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F272A980C
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 16:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKFPHN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 10:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKFPHL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Nov 2020 10:07:11 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7CC0613CF;
        Fri,  6 Nov 2020 07:07:11 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id s14so1284636qkg.11;
        Fri, 06 Nov 2020 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PVN4GnwT1M8qbwSdJv3enlb0YS6kxWNKqU65jyrdvdk=;
        b=Kg5lc83UF6M93kViL/jvkSmmIgxzuf7yhlb5awT4Ng7xoHi4QkpYVIn94V0H0b7dwj
         0RiZeoypQGPTzMMue6rmdqQQeYNhlE813lXKpDHzEzg/+dB/jfDkq5VklMT8b3I1795h
         Z/cNEABj/QIBQz2LwAGNOYioYZB+Q/jYiGL/tCTuhJnI6zSHqbrjdWfewblZvxnDcWjv
         kapEEs9MArRTm+Ui2D8x9EaAOq90UGLFZn7iUAIpoS7P8Zsm3rYvQMhGJQ50C4HSbCfi
         i/eSmbjOC0RUP05DYuedZ1NQmTcnSqm6jHKFpZGAfvZWAK+mYg9V0b8gFuwpOYBTKgQy
         YmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PVN4GnwT1M8qbwSdJv3enlb0YS6kxWNKqU65jyrdvdk=;
        b=le8kXP+5625iK2qiW4iTgG1p6SahXibooHuYfxgEkfYfXJ//xqHe2686XpXIW9LKdw
         CQUpUBerD5S2ylVNk5SvewGN8EfoINAuTELK+Qxk1ut40qwj84VixlBzmeAEqTFX0BVl
         dgdEczpF1ExrGlRUqSGqfvAUsVhP9GiNr9MkirwN01IUKmPWT0WfcCSRKP7+mupcB2oq
         NNJSLPvx/2qWWqf+srAZW3X7wl6aOYQverl3sz5+qj1w67MU1y4uOwSBMy605iDzGXhG
         SEdQPRa8yxi4JaV51HOGjOKTMvdxoLXFP9ASB8EujaEprTh7NzW7HEiPbvyqpNJ70nJg
         cEVQ==
X-Gm-Message-State: AOAM532wclC14myEO/3HziNIPLcjY9W2kNxktteUwcvL3PFpSCUMd8MW
        owxgO7nMcr0vjoekajXYSWo=
X-Google-Smtp-Source: ABdhPJzbNOzciyp7b8vITRbT/IiQNasuzf0g+GgqMQCvb7/HBqAWH161Yb8CBmjHP+al9jzNMgCt2Q==
X-Received: by 2002:a05:620a:1024:: with SMTP id a4mr2003922qkk.390.1604675230712;
        Fri, 06 Nov 2020 07:07:10 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.246])
        by smtp.gmail.com with ESMTPSA id q188sm700731qka.56.2020.11.06.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 07:07:10 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
Date:   Fri,  6 Nov 2020 10:07:06 -0500
Message-Id: <20201106150706.29089-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com>

Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
introduced the optional use of GPIO descriptors for chip selects.

A side-effect of this change: when a SPI bus uses GPIO descriptors,
all its client devices have SPI_CS_HIGH set in spi->mode. This flag is
required for the SPI bus to operate correctly.

This unfortunately breaks many client drivers, which use the following
pattern to configure their underlying SPI bus:

static int client_device_probe(struct spi_device *spi)
{
	...
	spi->mode = SPI_MODE_0;
	spi->bits_per_word = 8;
	err = spi_setup(spi);
	..
}

In short, many client drivers overwrite the SPI_CS_HIGH bit in
spi->mode, and break the underlying SPI bus driver.

This is especially true for Freescale/NXP imx ecspi, where large
numbers of spi client drivers now no longer work.

Proposed fix:
-------------
When using gpio descriptors, depend on gpiolib to handle CS polarity.
Existing quirks in gpiolib ensure that this is handled correctly.

Existing gpiolib behaviour will force the polarity of any chip-select
gpiod to active-high (if 'spi-active-high' devicetree prop present) or
active-low (if 'spi-active-high' absent). Irrespective of whether
the gpio is marked GPIO_ACTIVE_[HIGH|LOW] in the devicetree.

Loose ends:
-----------
If this fix is applied:
- is commit 138c9c32f090
  ("spi: spidev: Fix CS polarity if GPIO descriptors are used")
  still necessary / correct ?

Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
---

Tree: v5.10-rc2

To: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Simon Han <z.han@kunbus.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

 drivers/spi/spi.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..7566482c052c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -812,18 +812,16 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		enable = !enable;
 
 	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio)) {
-		/*
-		 * Honour the SPI_NO_CS flag and invert the enable line, as
-		 * active low is default for SPI. Execution paths that handle
-		 * polarity inversion in gpiolib (such as device tree) will
-		 * enforce active high using the SPI_CS_HIGH resulting in a
-		 * double inversion through the code above.
-		 */
 		if (!(spi->mode & SPI_NO_CS)) {
 			if (spi->cs_gpiod)
+				/* polarity handled by gpiolib */
 				gpiod_set_value_cansleep(spi->cs_gpiod,
-							 !enable);
+							 enable1);
 			else
+				/*
+				 * invert the enable line, as active low is
+				 * default for SPI.
+				 */
 				gpio_set_value_cansleep(spi->cs_gpio, !enable);
 		}
 		/* Some SPI masters need both GPIO CS & slave_select */
@@ -1992,15 +1990,6 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 	spi->chip_select = value;
 
-	/*
-	 * For descriptors associated with the device, polarity inversion is
-	 * handled in the gpiolib, so all gpio chip selects are "active high"
-	 * in the logical sense, the gpiolib will invert the line if need be.
-	 */
-	if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods &&
-	    ctlr->cs_gpiods[spi->chip_select])
-		spi->mode |= SPI_CS_HIGH;
-
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
-- 
2.17.1

