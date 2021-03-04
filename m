Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1332CAF9
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 04:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhCDDoG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 22:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhCDDnn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 22:43:43 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C59BC061764
        for <linux-spi@vger.kernel.org>; Wed,  3 Mar 2021 19:42:25 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q204so16880765pfq.10
        for <linux-spi@vger.kernel.org>; Wed, 03 Mar 2021 19:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7IXr18Hn1vMbGajH4e6/GFThZSI5KjMPmreJV9rQ8rA=;
        b=kRE7T/nkqip8YNz7QG7WPvRdvtYdpFzP9192IOB/Q6VZ2LQVNT1WNU1bpdYBlPy2mn
         S+5SwtX1E9GQUETYlGg58PPCKLvcdHqUYMHOQqjrEpbrXPrpAREi7jv7uKuvxlT8IcAV
         GzFRsfRTR7HgzBNNx/6AGNNwudMwN1FpAYayPt4SjXqpi3KsFkGye9bGKyjg937bHyle
         Tm8fHzoum+GV9vxkwYTQOd6m1rZvSLEGx+BPFjhQwNm830T6BoBEiWggy/QmlXKkrCHW
         83bJFoFblyi1OoRfU4aNoHDJAuJAnOTWjBms2418qfxt2AEbxGK8VsOZS3yGzG2t91kY
         +pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7IXr18Hn1vMbGajH4e6/GFThZSI5KjMPmreJV9rQ8rA=;
        b=Bxonl1+OIzpw/U3V6Yr0PriSxrA7+0jV9v13tvqX1MhGD1ZLKBhTZucBb2XmmPplk1
         zo0e3VpCu4bfcDXcRXm8/AlBLh+qt+H1H1a3NTawsqHyTG0b6suqllGJ98xqqvhFzigC
         DmmCfN/Ov0R8Q0UwMu9ErI33pkKIT93eEOOqzddqbd9ePRhpJ6Y1d+E+fYn2UsPiDwOo
         RDiIK2Avyg9kKKOYwE+oWLhB79tV93dhtxOdbkvnG3YihROBB8yx3As99XpYVIK+DBgk
         y7N4JjjFLIuFen5gNMDS8VyZUYY49XhLFLGSa2eoMgRS5/QmdVOkeDZ2Se4pY7Lo/5td
         4pkA==
X-Gm-Message-State: AOAM531QsT0BLZhOag5+/Mz66JICane2+qx4NJDEnHiFwiMYDvdrjUiK
        bJuDHavrQeQAQzRt0HiNU8LTww==
X-Google-Smtp-Source: ABdhPJxMTM5ReqMCqsCRCXJgOVJfHIWmnqTZJ9tyXozj1PAOfEuo2iFkwrnP8UWnNSW7//IWvda/7Q==
X-Received: by 2002:a05:6a00:a95:b029:1ee:471f:e323 with SMTP id b21-20020a056a000a95b02901ee471fe323mr1798005pfl.69.1614829344580;
        Wed, 03 Mar 2021 19:42:24 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:24 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
Date:   Wed,  3 Mar 2021 19:41:34 -0800
Message-Id: <20210304034141.7062-2-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This GPIO driver is for the Pensando Elba SoC which
provides control of four chip selects on two SPI busses.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/gpio/Kconfig           |   6 ++
 drivers/gpio/Makefile          |   1 +
 drivers/gpio/gpio-elba-spics.c | 120 +++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 drivers/gpio/gpio-elba-spics.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e3607ec4c2e8..d99bc82aa8fa 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -241,6 +241,12 @@ config GPIO_EIC_SPRD
 	help
 	  Say yes here to support Spreadtrum EIC device.
 
+config GPIO_ELBA_SPICS
+	bool "Pensando Elba SPI chip-select"
+	depends on ARCH_PENSANDO_ELBA_SOC
+	help
+	  Say yes here to support the Pensndo Elba SoC SPI chip-select driver
+
 config GPIO_EM
 	tristate "Emma Mobile GPIO"
 	depends on (ARCH_EMEV2 || COMPILE_TEST) && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c58a90a3c3b1..c5c7acad371b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_GPIO_DAVINCI)		+= gpio-davinci.o
 obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
 obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
+obj-$(CONFIG_GPIO_ELBA_SPICS)		+= gpio-elba-spics.o
 obj-$(CONFIG_GPIO_EM)			+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)		+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXAR)			+= gpio-exar.o
diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spics.c
new file mode 100644
index 000000000000..a845525cf2a3
--- /dev/null
+++ b/drivers/gpio/gpio-elba-spics.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pensando Elba ASIC SPI chip select driver
+ *
+ * Copyright (c) 2020-2021, Pensando Systems Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/*
+ * pin:	     3		  2	   |	   1		0
+ * bit:	 7------6------5------4----|---3------2------1------0
+ *	cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0	 cs0_ovr
+ *		   ssi1		   |		 ssi0
+ */
+#define SPICS_PIN_SHIFT(pin)	(2 * (pin))
+#define SPICS_MASK(pin)		(0x3 << SPICS_PIN_SHIFT(pin))
+#define SPICS_SET(pin, val)	((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
+
+struct elba_spics_priv {
+	void __iomem *base;
+	spinlock_t lock;
+	struct gpio_chip chip;
+};
+
+static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
+{
+	return -ENXIO;
+}
+
+static void elba_spics_set_value(struct gpio_chip *chip,
+		unsigned int pin, int value)
+{
+	struct elba_spics_priv *p = gpiochip_get_data(chip);
+	unsigned long flags;
+	u32 tmp;
+
+	/* select chip select from register */
+	spin_lock_irqsave(&p->lock, flags);
+	tmp = readl_relaxed(p->base);
+	tmp = (tmp & ~SPICS_MASK(pin)) | SPICS_SET(pin, value);
+	writel_relaxed(tmp, p->base);
+	spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static int elba_spics_direction_input(struct gpio_chip *chip, unsigned int pin)
+{
+	return -ENXIO;
+}
+
+static int elba_spics_direction_output(struct gpio_chip *chip,
+		unsigned int pin, int value)
+{
+	elba_spics_set_value(chip, pin, value);
+	return 0;
+}
+
+static int elba_spics_probe(struct platform_device *pdev)
+{
+	struct elba_spics_priv *p;
+	struct resource *res;
+	int ret;
+
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	p->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(p->base)) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		return PTR_ERR(p->base);
+	}
+	spin_lock_init(&p->lock);
+	platform_set_drvdata(pdev, p);
+
+	p->chip.ngpio = 4;	/* 2 cs pins for spi0, and 2 for spi1 */
+	p->chip.base = -1;
+	p->chip.direction_input = elba_spics_direction_input;
+	p->chip.direction_output = elba_spics_direction_output;
+	p->chip.get = elba_spics_get_value;
+	p->chip.set = elba_spics_set_value;
+	p->chip.label = dev_name(&pdev->dev);
+	p->chip.parent = &pdev->dev;
+	p->chip.owner = THIS_MODULE;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &p->chip, p);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to add gpio chip\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "elba spics registered\n");
+	return 0;
+}
+
+static const struct of_device_id ebla_spics_of_match[] = {
+	{ .compatible = "pensando,elba-spics" },
+	{}
+};
+
+static struct platform_driver elba_spics_driver = {
+	.probe = elba_spics_probe,
+	.driver = {
+		.name = "pensando-elba-spics",
+		.of_match_table = ebla_spics_of_match,
+	},
+};
+module_platform_driver(elba_spics_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Elba SPI chip-select driver");
-- 
2.17.1

