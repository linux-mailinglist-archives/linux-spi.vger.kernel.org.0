Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F189350608
	for <lists+linux-spi@lfdr.de>; Wed, 31 Mar 2021 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhCaSKt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Mar 2021 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhCaSKp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Mar 2021 14:10:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE5C061574;
        Wed, 31 Mar 2021 11:10:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d12so9374298lfv.11;
        Wed, 31 Mar 2021 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtfOZrmw/G2xBCH8BNQoITRY/KZ078scjS3Vm8ZtL54=;
        b=b3GAoj5k+BVMB3xeSlS+LvS3MJIaA2VvG/xi1oZ3CPD+uNxGQQ2Xt8ckOqWLE42Xc5
         S+Ph9TRefQiG56MtbR1uCeNxqMufmns2fvrHZvLGLdutaEsNzc/dq/91Ovzq5TaUpvHb
         rKeWF1qijOJVU12OhMGYRf/8xFgr57hubiOJFY6m6azTx7Cu715EAMF0+EqDShXuzwbc
         gO0JzTtIkhH9Q/VDms/tKun2koDqVzk6wlTWxYAYtWakt+KFgKbkOBWCOlz1mDitlq+Z
         utt9WHuftP5VeVHUQPdCIySlRJjHgI8VssWajxCyczddvVU6Ip6ouOHY+Qr6t9ZkKUFc
         Pvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtfOZrmw/G2xBCH8BNQoITRY/KZ078scjS3Vm8ZtL54=;
        b=WTjZpyyMCcwV8HI8/XkT3iYwwcycDfnoBUxJ+c9GUwc2kECP53U7/hnd0ok36x3gND
         5ww0zSofKgMDx2sLSo0zU1cifhV9iEftW4wPsHuY7y1vgOXYfQim57CrKIihrTeQ9xnQ
         EGwc3pf5zhVqRDMXuGUMyce2QR8mUKQwP3r7s5vBA+yvL4HnRl19KNMuizBeziJ5vGoP
         6Kre6TPAqY6/ZX38IcoikGgovNRgi6b6bMXzBv4Kzdk1FsnOfRMCiAqFAtXpoO55tJ3T
         wSDfkK1/otK6mqWpRPFXYvD+gWQGLbup11cXFojDxrvlO5rsTY+7oOQAXYjgCTo9CFJ6
         PUsA==
X-Gm-Message-State: AOAM531ieE3rE4GFJhFhv/ZnR2J6DedAMF5pRMSj4W0YA0D9mkafzMsb
        q5oIhekymA9lDwwJsDURyKg=
X-Google-Smtp-Source: ABdhPJxoi8dLmsINmMA+u7ftKCym+36G1073Td2cmxITbqGPwqeTGFgJ0nNnuufO2broqZNbspGz/g==
X-Received: by 2002:a19:4911:: with SMTP id w17mr2829730lfa.361.1617214243764;
        Wed, 31 Mar 2021 11:10:43 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id n24sm294864lfe.264.2021.03.31.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 11:10:43 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:10:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] gpio: Add Elba SoC gpio driver for spi cs
 control
Message-ID: <20210331181041.me5mqqagtml355vk@mobilestation>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-2-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-2-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 28, 2021 at 06:59:26PM -0700, Brad Larson wrote:
> This GPIO driver is for the Pensando Elba SoC which
> provides control of four chip selects on two SPI busses.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  drivers/gpio/Kconfig           |   6 ++
>  drivers/gpio/Makefile          |   1 +
>  drivers/gpio/gpio-elba-spics.c | 114 +++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 drivers/gpio/gpio-elba-spics.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index e3607ec4c2e8..4720459b24f5 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -241,6 +241,12 @@ config GPIO_EIC_SPRD
>  	help
>  	  Say yes here to support Spreadtrum EIC device.
>  
> +config GPIO_ELBA_SPICS
> +	bool "Pensando Elba SPI chip-select"
> +	depends on (ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST)
> +	help
> +	  Say yes here to support the Penasndo Elba SoC SPI chip-select driver
> +
>  config GPIO_EM
>  	tristate "Emma Mobile GPIO"
>  	depends on (ARCH_EMEV2 || COMPILE_TEST) && OF_GPIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index c58a90a3c3b1..c5c7acad371b 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_GPIO_DAVINCI)		+= gpio-davinci.o
>  obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
>  obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
>  obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
> +obj-$(CONFIG_GPIO_ELBA_SPICS)		+= gpio-elba-spics.o
>  obj-$(CONFIG_GPIO_EM)			+= gpio-em.o
>  obj-$(CONFIG_GPIO_EP93XX)		+= gpio-ep93xx.o
>  obj-$(CONFIG_GPIO_EXAR)			+= gpio-exar.o
> diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spics.c
> new file mode 100644
> index 000000000000..351bbaeea033
> --- /dev/null
> +++ b/drivers/gpio/gpio-elba-spics.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Pensando Elba SoC SPI chip select driver
> + *
> + * Copyright (c) 2020-2021, Pensando Systems Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +//#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +/*
> + * pin:	     3		  2	   |	   1		0
> + * bit:	 7------6------5------4----|---3------2------1------0
> + *	cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0	 cs0_ovr
> + *		   ssi1		   |		 ssi0
> + */
> +#define SPICS_PIN_SHIFT(pin)	(2 * (pin))
> +#define SPICS_MASK(pin)		(0x3 << SPICS_PIN_SHIFT(pin))
> +#define SPICS_SET(pin, val)	((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
> +
> +struct elba_spics_priv {
> +	void __iomem *base;
> +	spinlock_t lock;
> +	struct gpio_chip chip;
> +};
> +
> +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static void elba_spics_set_value(struct gpio_chip *chip,
> +		unsigned int pin, int value)
> +{
> +	struct elba_spics_priv *p = gpiochip_get_data(chip);
> +	unsigned long flags;
> +	u32 tmp;
> +
> +	/* select chip select from register */
> +	spin_lock_irqsave(&p->lock, flags);
> +	tmp = readl_relaxed(p->base);
> +	tmp = (tmp & ~SPICS_MASK(pin)) | SPICS_SET(pin, value);
> +	writel_relaxed(tmp, p->base);
> +	spin_unlock_irqrestore(&p->lock, flags);
> +}
> +
> +static int elba_spics_direction_input(struct gpio_chip *chip, unsigned int pin)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static int elba_spics_direction_output(struct gpio_chip *chip,
> +		unsigned int pin, int value)
> +{
> +	elba_spics_set_value(chip, pin, value);
> +	return 0;
> +}
> +
> +static int elba_spics_probe(struct platform_device *pdev)
> +{
> +	struct elba_spics_priv *p;
> +	struct resource *res;
> +	int ret = 0;
> +
> +	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	p->base = devm_ioremap_resource(&pdev->dev, res);

In accordance with the DTS-node this is just a single register
0x307c2468-0x307c24C picked from some bigger block, which most likely
belongs to something like a system controller. PCIe node has got
another register from there "0x307c2480-0x307c2484/* MS CFG_WDT */",
and some BSM device too "0x307c2080-0x307c2084". Please consider using
syscon instead of directly requesting the resource here.

-Sergey

> +	if (IS_ERR(p->base))
> +		return PTR_ERR(p->base);
> +	spin_lock_init(&p->lock);
> +	platform_set_drvdata(pdev, p);
> +
> +	p->chip.ngpio = 4;	/* 2 cs pins for spi0, and 2 for spi1 */
> +	p->chip.base = -1;
> +	p->chip.direction_input = elba_spics_direction_input;
> +	p->chip.direction_output = elba_spics_direction_output;
> +	p->chip.get = elba_spics_get_value;
> +	p->chip.set = elba_spics_set_value;
> +	p->chip.label = dev_name(&pdev->dev);
> +	p->chip.parent = &pdev->dev;
> +	p->chip.owner = THIS_MODULE;
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, &p->chip, p);
> +	if (ret)
> +		dev_err(&pdev->dev, "unable to add gpio chip\n");
> +	return ret;
> +}
> +
> +static const struct of_device_id elba_spics_of_match[] = {
> +	{ .compatible = "pensando,elba-spics" },
> +	{}
> +};
> +
> +static struct platform_driver elba_spics_driver = {
> +	.probe = elba_spics_probe,
> +	.driver = {
> +		.name = "pensando-elba-spics",
> +		.of_match_table = elba_spics_of_match,
> +	},
> +};
> +module_platform_driver(elba_spics_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Pensando Elba SoC SPI chip-select driver");
> -- 
> 2.17.1
> 
