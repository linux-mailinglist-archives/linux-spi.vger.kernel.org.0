Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9D10C86C
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 13:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfK1MOn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 07:14:43 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19796 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1MOn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 07:14:43 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NxQl52lSz9tyK4;
        Thu, 28 Nov 2019 13:14:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=HfgbEHbA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JcmftBhe8vz5; Thu, 28 Nov 2019 13:14:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NxQl3wSBz9tyJ9;
        Thu, 28 Nov 2019 13:14:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574943279; bh=DFcpWs6GAjV0UtuvhmMoRB3oqSAaK5q3M5UANyGiHz4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HfgbEHbAQqiL78+/acoEbHG3L7YzFHqW7TTrttqbOdVWTLTPRSunhiJzfoMuS8UFm
         qaX5b4crkzfxuJlC16vTcp8dQHUONcWJGguElTLC7YmvB/Bopfcw5fon+64ZJSPjO6
         L57SQZCzGTqsfwtBa+kikadtbevUGOxojurA2MQ4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CCD478B889;
        Thu, 28 Nov 2019 13:14:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GKMZqVk0mJ4G; Thu, 28 Nov 2019 13:14:40 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1C638B87E;
        Thu, 28 Nov 2019 13:14:40 +0100 (CET)
Subject: Re: [PATCH 2/3 v3] gpio: Handle counting of Freescale chipselects
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20191128083718.39177-1-linus.walleij@linaro.org>
 <20191128083718.39177-2-linus.walleij@linaro.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fafcb1eb-bea3-a73c-7b26-6b16e7279286@c-s.fr>
Date:   Thu, 28 Nov 2019 13:14:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191128083718.39177-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 28/11/2019 à 09:37, Linus Walleij a écrit :
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

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> ChangeLog v2->v3:
> - Fixed the bug (I hope) as I was counting the number
>    of gpios by checking for "gpios-gpios" and "gpios-gpio"
>    rather than "gpios" (ehm...)
> ChangeLog v1->v2:
> - Hardcode the quirk to look for "gpios" as this is all
>    we support and else the call would just recurse back
>    and fail again.
> - Provide a proper NULL check so we don't upset strcmp().
> 
> Mark: I change my mind, better to keep the patches
> together, once Christophe has it working with my
> patch stack let's just merge all of it.
> ---
>   drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 80ea49f570f4..43ffec3a6fbb 100644
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
> +	if (!con_id || strcmp(con_id, "cs"))
> +		return 0;
> +	if (!of_device_is_compatible(np, "fsl,spi") &&
> +	    !of_device_is_compatible(np, "aeroflexgaisler,spictrl"))
> +		return 0;
> +	return of_gpio_named_count(np, "gpios");
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
