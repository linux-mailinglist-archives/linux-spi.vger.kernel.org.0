Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7576D4929A3
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 16:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbiARP1n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 10:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345390AbiARP1k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 10:27:40 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94090C06161C
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 07:27:39 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id x33so37419850uad.12
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smPJ+PfHqIcEW/NreVTOjYiJFUQBiA/lKjwPSM2y5t4=;
        b=ARaZHePHOEVVGfSjhj7Ci5ir5jS/g5U94NyvuxbRqmMJ7DpTaSjL3Z3Yi8GHWKObm1
         BEfeHVCMnv9nM43xZl9tP0wowMrnSrBokPJ4EnMBXTxGXP9HF7HYugGDOcBVmH2asT5W
         mQj8DtAnOVzXxYdgU8EUFl7dMxWUDE3jqAWR9mVc/wlTPsCDa0dUysD4WMYAdlKvMmgu
         XjoihUHe0Xa4u8AY8MmKlJ+TDFDdWJNaNmsXinV4VnCfo1KogCPlg4If3cpZ/dIal/6V
         M5b5012sWTF5mnCraALKrEoWUSwqLDTGLBErg+uEjIBZy277ouWHWkiFCpODL6xo8+z+
         PVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smPJ+PfHqIcEW/NreVTOjYiJFUQBiA/lKjwPSM2y5t4=;
        b=eAhJPk9d5X76MnUgkp+5PGwuM7Y4WwyIoN8mtxut0vl74up3oUB8VLpXvLEJ0XVBbv
         4X7I7WZMwUd8J52Sr6IUoAWwEOZLx4P5T0NLzPn5Gp/w8CRjNgKvpOtVK+1Z4aaj90NV
         aqgYUigGIO0hS8/I4mNNBgIEq2wpizlsoWwir0pfOF3XGj/HEzfZ9SWnIKPgPV1LbPlb
         EFo1Ge8eaR73Ide97GOYd+yt0dPUMNEx0hy58TQ699aLwdgpLqfPsZCg3QQBTC4pdjW5
         1BGyK/0b8f7NZmKyL4/iYffllwIDTgj//MO3t7cO5iQBcqCOPiQ+bLkdiNtm0FNce6EH
         k95A==
X-Gm-Message-State: AOAM533b8VJ2X0TSho2ryvWmHv3cPpiRVGhDLY4aEbd8ts6RMtSlb+Jn
        0wQ0DfdBmvW7IGud9PZ1TeXUI50b+rbrtOWPDGWujA==
X-Google-Smtp-Source: ABdhPJzquQf4mctI+Cw1mD1oGkRL4f93CVicKRsQaEKOZihqmwVKAZanUzPNdeLgVsz2Zt9vSDSDM8kp2yRDy0WS4N0=
X-Received: by 2002:a05:6102:108c:: with SMTP id s12mr9823322vsr.20.1642519658515;
 Tue, 18 Jan 2022 07:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20220118110928.120640-1-linus.walleij@linaro.org> <20220118110928.120640-3-linus.walleij@linaro.org>
In-Reply-To: <20220118110928.120640-3-linus.walleij@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 18 Jan 2022 17:27:27 +0200
Message-ID: <CAPLW+4kNbC2BNcC54evJL_9tYoY_S3hcski81KHUPughs3f0ag@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] spi: s3c64xx: Convert to use GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jan 2022 at 13:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Convert the S3C64xx SPI host to use GPIO descriptors.
>
> Provide GPIO descriptor tables for the one user with CS
> 0 and 1.
>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1-v2:
> - Split off code cleaning to separate patches
> ---
>  arch/arm/mach-s3c/mach-crag6410-module.c  | 13 ------
>  arch/arm/mach-s3c/mach-crag6410.c         | 11 +++++
>  drivers/spi/spi-s3c64xx.c                 | 50 +++++------------------
>  include/linux/platform_data/spi-s3c64xx.h |  4 +-
>  4 files changed, 23 insertions(+), 55 deletions(-)
>
> diff --git a/arch/arm/mach-s3c/mach-crag6410-module.c b/arch/arm/mach-s3c/mach-crag6410-module.c
> index 407ad493493e..5d1d4b67a4b7 100644
> --- a/arch/arm/mach-s3c/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c/mach-crag6410-module.c
> @@ -32,10 +32,6 @@
>
>  #include "crag6410.h"
>
> -static struct s3c64xx_spi_csinfo wm0010_spi_csinfo = {
> -       .line = S3C64XX_GPC(3),
> -};
> -
>  static struct wm0010_pdata wm0010_pdata = {
>         .gpio_reset = S3C64XX_GPN(6),
>         .reset_active_high = 1, /* Active high for Glenfarclas Rev 2 */
> @@ -49,7 +45,6 @@ static struct spi_board_info wm1253_devs[] = {
>                 .chip_select    = 0,
>                 .mode           = SPI_MODE_0,
>                 .irq            = S3C_EINT(4),
> -               .controller_data = &wm0010_spi_csinfo,
>                 .platform_data = &wm0010_pdata,
>         },
>  };
> @@ -62,7 +57,6 @@ static struct spi_board_info balblair_devs[] = {
>                 .chip_select    = 0,
>                 .mode           = SPI_MODE_0,
>                 .irq            = S3C_EINT(4),
> -               .controller_data = &wm0010_spi_csinfo,
>                 .platform_data = &wm0010_pdata,
>         },
>  };
> @@ -229,10 +223,6 @@ static struct arizona_pdata wm5102_reva_pdata = {
>         },
>  };
>
> -static struct s3c64xx_spi_csinfo codec_spi_csinfo = {
> -       .line = S3C64XX_GPN(5),
> -};
> -
>  static struct spi_board_info wm5102_reva_spi_devs[] = {
>         [0] = {
>                 .modalias       = "wm5102",
> @@ -242,7 +232,6 @@ static struct spi_board_info wm5102_reva_spi_devs[] = {
>                 .mode           = SPI_MODE_0,
>                 .irq            = GLENFARCLAS_PMIC_IRQ_BASE +
>                                   WM831X_IRQ_GPIO_2,
> -               .controller_data = &codec_spi_csinfo,
>                 .platform_data = &wm5102_reva_pdata,
>         },
>  };
> @@ -275,7 +264,6 @@ static struct spi_board_info wm5102_spi_devs[] = {
>                 .mode           = SPI_MODE_0,
>                 .irq            = GLENFARCLAS_PMIC_IRQ_BASE +
>                                   WM831X_IRQ_GPIO_2,
> -               .controller_data = &codec_spi_csinfo,
>                 .platform_data = &wm5102_pdata,
>         },
>  };
> @@ -298,7 +286,6 @@ static struct spi_board_info wm5110_spi_devs[] = {
>                 .mode           = SPI_MODE_0,
>                 .irq            = GLENFARCLAS_PMIC_IRQ_BASE +
>                                   WM831X_IRQ_GPIO_2,
> -               .controller_data = &codec_spi_csinfo,
>                 .platform_data = &wm5102_reva_pdata,
>         },
>  };
> diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
> index 41f0aba2d2fd..e3e0fe897bcc 100644
> --- a/arch/arm/mach-s3c/mach-crag6410.c
> +++ b/arch/arm/mach-s3c/mach-crag6410.c
> @@ -825,6 +825,15 @@ static const struct gpio_led_platform_data gpio_leds_pdata = {
>
>  static struct dwc2_hsotg_plat crag6410_hsotg_pdata;
>
> +static struct gpiod_lookup_table crag_spi0_gpiod_table = {
> +       .dev_id = "s3c6410-spi.0",
> +       .table = {
> +               GPIO_LOOKUP_IDX("GPIOC", 3, "cs", 0, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("GPION", 5, "cs", 1, GPIO_ACTIVE_LOW),
> +               { },
> +       },
> +};
> +
>  static void __init crag6410_machine_init(void)
>  {
>         /* Open drain IRQs need pullups */
> @@ -856,6 +865,8 @@ static void __init crag6410_machine_init(void)
>         i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
>
>         samsung_keypad_set_platdata(&crag6410_keypad_data);
> +
> +       gpiod_add_lookup_table(&crag_spi0_gpiod_table);
>         s3c64xx_spi0_set_platdata(0, 2);
>
>         pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 8755cd85e83c..5e03c9144bfe 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -13,10 +13,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> -#include <linux/gpio.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>
>  #include <linux/platform_data/spi-s3c64xx.h>
>
> @@ -655,6 +653,9 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
>         struct spi_device *spi = msg->spi;
>         struct s3c64xx_spi_csinfo *cs = spi->controller_data;
>
> +       if (!cs)
> +               return 0;

Shouldn't some error code be returned in that case? Or is it normal case?

> +
>         /* Configure feedback delay */
>         writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
>
> @@ -830,34 +831,16 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>         if (spi->dev.of_node) {
>                 cs = s3c64xx_get_slave_ctrldata(spi);
>                 spi->controller_data = cs;
> -       } else if (cs) {
> -               /* On non-DT platforms the SPI core will set spi->cs_gpio
> -                * to -ENOENT. The GPIO pin used to drive the chip select
> -                * is defined by using platform data so spi->cs_gpio value
> -                * has to be override to have the proper GPIO pin number.
> -                */
> -               spi->cs_gpio = cs->line;
>         }
>
> -       if (IS_ERR_OR_NULL(cs)) {
> +       /* NULL is fine, we just avoid using the FB delay (=0) */
> +       if (IS_ERR(cs)) {
>                 dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
>                 return -ENODEV;
>         }
>
> -       if (!spi_get_ctldata(spi)) {
> -               if (gpio_is_valid(spi->cs_gpio)) {
> -                       err = gpio_request_one(spi->cs_gpio, GPIOF_OUT_INIT_HIGH,
> -                                              dev_name(&spi->dev));
> -                       if (err) {
> -                               dev_err(&spi->dev,
> -                                       "Failed to get /CS gpio [%d]: %d\n",
> -                                       spi->cs_gpio, err);
> -                               goto err_gpio_req;
> -                       }
> -               }
> -
> +       if (!spi_get_ctldata(spi))
>                 spi_set_ctldata(spi, cs);
> -       }
>
>         pm_runtime_get_sync(&sdd->pdev->dev);
>
> @@ -909,11 +892,9 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>         /* setup() returns with device de-selected */
>         s3c64xx_spi_set_cs(spi, false);
>
> -       if (gpio_is_valid(spi->cs_gpio))
> -               gpio_free(spi->cs_gpio);
>         spi_set_ctldata(spi, NULL);
>
> -err_gpio_req:
> +       /* This was dynamically allocated on the DT path */
>         if (spi->dev.of_node)
>                 kfree(cs);
>
> @@ -924,19 +905,9 @@ static void s3c64xx_spi_cleanup(struct spi_device *spi)
>  {
>         struct s3c64xx_spi_csinfo *cs = spi_get_ctldata(spi);
>
> -       if (gpio_is_valid(spi->cs_gpio)) {
> -               gpio_free(spi->cs_gpio);
> -               if (spi->dev.of_node)
> -                       kfree(cs);
> -               else {
> -                       /* On non-DT platforms, the SPI core sets
> -                        * spi->cs_gpio to -ENOENT and .setup()
> -                        * overrides it with the GPIO pin value
> -                        * passed using platform data.
> -                        */
> -                       spi->cs_gpio = -ENOENT;
> -               }
> -       }
> +       /* This was dynamically allocated on the DT path */
> +       if (spi->dev.of_node)
> +               kfree(cs);
>
>         spi_set_ctldata(spi, NULL);
>  }
> @@ -1131,6 +1102,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>         master->prepare_message = s3c64xx_spi_prepare_message;
>         master->transfer_one = s3c64xx_spi_transfer_one;
>         master->num_chipselect = sci->num_cs;
> +       master->use_gpio_descriptors = true;
>         master->dma_alignment = 8;
>         master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
>                                         SPI_BPW_MASK(8);
> diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
> index 10890a4b55b9..391f4dc68742 100644
> --- a/include/linux/platform_data/spi-s3c64xx.h
> +++ b/include/linux/platform_data/spi-s3c64xx.h
> @@ -16,15 +16,13 @@ struct platform_device;
>   * struct s3c64xx_spi_csinfo - ChipSelect description
>   * @fb_delay: Slave specific feedback delay.
>   *            Refer to FB_CLK_SEL register definition in SPI chapter.
> - * @line: Custom 'identity' of the CS line.
>   *
> - * This is per SPI-Slave Chipselect information.
> + * This is per SPI-Slave FB delay information.

Not sure if this change is needed: this comments will be incorrect if
some new fields are added in future. For example, downstream trees
like [1] have more fields there, not only feedback delay one.

[1] https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/include/linux/platform_data/spi-s3c64xx.h#53

>   * Allocate and initialize one in machine init code and make the
>   * spi_board_info.controller_data point to it.
>   */
>  struct s3c64xx_spi_csinfo {
>         u8 fb_delay;
> -       unsigned line;
>  };
>
>  /**
> --
> 2.34.1
>

Other than minor comments above:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Btw, this SPI driver is used in Exynos850 SoC, which I'm working on
right now. It's the shame I didn't enable it yet on my board, so I
can't test the code. But I'm happy to see it's being modernized, kudos
for doing that!
