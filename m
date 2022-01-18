Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAAB49280B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 15:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbiAROLS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243598AbiAROLR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 09:11:17 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A12BC061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 06:11:17 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id b16so2283733uaq.4
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 06:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvdj+qp/eg7R28PY/+VFyrjgCtfoSmQmictLv75v8vk=;
        b=uXDgiYavbuYTB7HGUlLunNnUK/prmWCoEG6Cbjat47kYJb+z6fOXYfJ0aiamCfcja1
         zn7Ch/vN35LhgxYT6xtKt3X10LmsTZsJPVtDfCvLjkR2p6l/zu7Y3oXahAOHgbmcSVd+
         3wf/63ZB733GPdmZlp4qnN2z+UTT7P1KUopZdfuakG47QMQYEnWa1TumMi9DLetZf12M
         6YetyxVt3MARb1uBipL/DGge1/E569xEaafBa0LttIOiAtRoGyPBoAPTnpPabyZpYGX2
         RdPFWVuJa/4gJpuG4fZkFxA9B38vX9NkozIgREMFh0vLITZA0CQPdV5KOJ9hPeMJZuqS
         vtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvdj+qp/eg7R28PY/+VFyrjgCtfoSmQmictLv75v8vk=;
        b=eXhxlXOYjHF/zYQTPqpHAloMUZKNZ/QtLlCR7CkjfAPYNHBKDfJSrfWEv4tVmvz13h
         Pk7GTxavIivSyDZcG4N7nZPD1QrseY0Uzo4yqaafEe55HJGKGNJ28FuvK2VehE9NRaKt
         NzMlINI9KTFy4fyIA50gDJiR3TxffwT6mMuGzCFqUtKbtnUXOFTS2/wvAOKbtmfFeFcb
         4NQw7f5INGo4wOG1uhD5HZAbkgeATrjq29UO+uIOVM6BJZ8fphR9iVIovcGh7DBS9flF
         ECX6HYexkTUJ44qrkHcd8r6kmSnXV/u2qdCl+TOeG4lzJhYzoatz7UuBPG5gJJvmc4Jc
         kpcQ==
X-Gm-Message-State: AOAM533cKfGqdu/LRHOgyGxizv6Rw2ddDos80or1f3HMq8aBgQZpRXSa
        JttQOFwf0xQpCC252Z4kT45K58J6YnW+bJZ1eq0eFg==
X-Google-Smtp-Source: ABdhPJwKMmLqxxQMEadpG0q2QweNkW/88mrTLMQ88DkrxxSlUOIKjiSuEwn9bi71kD67+gveLFXaBVfwZUOwwdqDa90=
X-Received: by 2002:ab0:13ee:: with SMTP id n43mr9680656uae.9.1642515076437;
 Tue, 18 Jan 2022 06:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20220118110928.120640-1-linus.walleij@linaro.org> <20220118110928.120640-2-linus.walleij@linaro.org>
In-Reply-To: <20220118110928.120640-2-linus.walleij@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 18 Jan 2022 16:11:05 +0200
Message-ID: <CAPLW+4=+9bQU2CLk5LEhDXKz3S5ziYDMsVOd07xuae9UagHdfw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] spi: s3c64xx: Drop custom gpio setup argument
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
> The SPI0 platform population function was taking a custom
> gpio setup callback but the only user pass NULL as
> argument so drop this argument.
>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1-v2:
> - Split out to separate patch
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  arch/arm/mach-s3c/devs.c                  | 5 ++---
>  arch/arm/mach-s3c/mach-crag6410.c         | 2 +-
>  include/linux/platform_data/spi-s3c64xx.h | 4 +---
>  3 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
> index 9f086aee862b..1e266fc24f9b 100644
> --- a/arch/arm/mach-s3c/devs.c
> +++ b/arch/arm/mach-s3c/devs.c
> @@ -1107,8 +1107,7 @@ struct platform_device s3c64xx_device_spi0 = {
>         },
>  };
>
> -void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
> -                                               int num_cs)
> +void __init s3c64xx_spi0_set_platdata(int src_clk_nr, int num_cs)
>  {
>         struct s3c64xx_spi_info pd;
>
> @@ -1120,7 +1119,7 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>
>         pd.num_cs = num_cs;
>         pd.src_clk_nr = src_clk_nr;
> -       pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
> +       pd.cfg_gpio = s3c64xx_spi0_cfg_gpio;
>
>         s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
>  }
> diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
> index 4a12c75d407f..41f0aba2d2fd 100644
> --- a/arch/arm/mach-s3c/mach-crag6410.c
> +++ b/arch/arm/mach-s3c/mach-crag6410.c
> @@ -856,7 +856,7 @@ static void __init crag6410_machine_init(void)
>         i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
>
>         samsung_keypad_set_platdata(&crag6410_keypad_data);
> -       s3c64xx_spi0_set_platdata(NULL, 0, 2);
> +       s3c64xx_spi0_set_platdata(0, 2);
>
>         pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
>         platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
> diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
> index 19d690f34670..10890a4b55b9 100644
> --- a/include/linux/platform_data/spi-s3c64xx.h
> +++ b/include/linux/platform_data/spi-s3c64xx.h
> @@ -43,15 +43,13 @@ struct s3c64xx_spi_info {
>  /**
>   * s3c64xx_spi_set_platdata - SPI Controller configure callback by the board
>   *                             initialization code.
> - * @cfg_gpio: Pointer to gpio setup function.
>   * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
>   * @num_cs: Number of elements in the 'cs' array.
>   *
>   * Call this from machine init code for each SPI Controller that
>   * has some chips attached to it.
>   */
> -extern void s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
> -                                               int num_cs);
> +extern void s3c64xx_spi0_set_platdata(int src_clk_nr, int num_cs);
>
>  /* defined by architecture to configure gpio */
>  extern int s3c64xx_spi0_cfg_gpio(void);
> --
> 2.34.1
>
