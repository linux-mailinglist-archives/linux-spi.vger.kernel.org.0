Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2330C10AD30
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 11:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfK0KHX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 05:07:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43483 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0KHX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 05:07:23 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NGfJ26y9z9tyfc;
        Wed, 27 Nov 2019 11:07:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=iuJVRthq; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CRuyUY0DFsKY; Wed, 27 Nov 2019 11:07:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NGfJ101vz9tyf8;
        Wed, 27 Nov 2019 11:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574849240; bh=kq3W6YZ9xAhKv42eMDlB3qfFpO7Hs7slfnCQwxFZwnE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=iuJVRthqiy36bBCt4I7DGLp7Pv49P9apZHiDZ01KU0mTurLODOHn3KGz8c/A7m8o/
         BaW1hKU1kxu0yijrvwlqGgvM6pMm4uD6LGCclwDacrScRvZMSOx7A4tEeV0JzGJz+r
         IOaIF4jM8D/+LfBETBeCcdL1wghsK0ce+akFYfng=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F4938B84E;
        Wed, 27 Nov 2019 11:07:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AQNfhmWK-Djm; Wed, 27 Nov 2019 11:07:12 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2F7E8B84D;
        Wed, 27 Nov 2019 11:07:12 +0100 (CET)
Subject: Re: [PATCH] gpio: Handle counting of Freescale chipselects
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20191127094031.140736-1-linus.walleij@linaro.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bcfa8e29-7adf-8a14-43e8-8e1d73df33bc@c-s.fr>
Date:   Wed, 27 Nov 2019 11:07:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191127094031.140736-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 10:40, Linus Walleij a écrit :
> We have a special quirk to handle the Freescale
> nonstandard SPI chipselect GPIOs in the gpiolib-of.c
> file, but it currently only handles the case where
> the GPIOs are actually requested (gpiod_*get()).
> 
> We also need to handle that the SPI core attempts
> to count the GPIOs before use, and that needs a
> similar quirk in the OF part of the library.
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Still getting:

[    3.374867] fsl_spi: probe of ff000a80.spi failed with error -22

Christophe


> ---
> Mark: I will merge this through the GPIO tree if
> it fixes the problem.
> ---
>   drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 80ea49f570f4..33e16fa17bd8 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -23,6 +23,29 @@
>   #include "gpiolib.h"
>   #include "gpiolib-of.h"
>   
> +/**
> + * of_gpio_spi_cs_get_count() - special GPIO counting for SPI
> + * Some elder GPIO controllers need special quirks. Currently we handle
> + * the Freescale GPIO controller with bindings that doesn't use the
> + * established "cs-gpios" for chip selects but instead rely on
> + * "gpios" for the chip select lines. If we detect this, we redirect
> + * the counting of "cs-gpios" to count "gpios" transparent to the
> + * driver.
> + */
> +int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
> +{
> +	struct device_node *np = dev->of_node;
> +
> +	if (!IS_ENABLED(CONFIG_SPI_MASTER))
> +		return 0;
> +	if (strcmp(con_id, "cs"))
> +		return 0;
> +	if (!of_device_is_compatible(np, "fsl,spi") &&
> +	    !of_device_is_compatible(np, "aeroflexgaisler,spictrl"))
> +		return 0;
> +	return of_gpio_get_count(dev, NULL);
> +}
> +
>   /*
>    * This is used by external users of of_gpio_count() from <linux/of_gpio.h>
>    *
> @@ -35,6 +58,10 @@ int of_gpio_get_count(struct device *dev, const char *con_id)
>   	char propname[32];
>   	unsigned int i;
>   
> +	ret = of_gpio_spi_cs_get_count(dev, con_id);
> +	if (ret > 0)
> +		return ret;
> +
>   	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
>   		if (con_id)
>   			snprintf(propname, sizeof(propname), "%s-%s",
> 
