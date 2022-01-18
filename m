Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3D4927E8
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 15:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbiAROAu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 09:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbiAROAs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 09:00:48 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF6BC061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 06:00:48 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id m90so36802738uam.2
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH6mrMnTcRnYhQ/60P21Ou25hu431NT7bRGY1A4qENQ=;
        b=mcU1UpjzykY9s8XxjUDd/DoITMVGq0PCdIu+RF++pIQDPH2d24mrM58p2Y7SBoj2Yd
         7XPEIsf1rCHYNsgUQIn3it7O99sQciNRXtE0p3j2IeB8w5/17N9XZudCAW0+Odl+PZeC
         bgYSDzNCR65SU4NfSdihwBkyIGaFjXImoAXcEZWjMkq/JYoIjv5fLfvGPR6vkbKE/Rpw
         Y4jo7gY4jxIoFX5PAabCvcv9K06cxywMQ0a+mwAXG/BvYM+2rvUiHC9qcuR9aWVna/gL
         R6vgvf8+03ER0vByR/VHunDqsDvzCKNNqVu3m7Q39u3f3ggrddQimFRomtN0YZ3blDxr
         fi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH6mrMnTcRnYhQ/60P21Ou25hu431NT7bRGY1A4qENQ=;
        b=jkl5t5VP8UEXwRDE9VK5+fwJYo+NBlxPlhgLd3T0aGmJ/hmipj+Elyxm7qquHOx2AK
         Rp2iHJPSlwg6Un+gwNvpDah/guuuiMlPb8tgw4DjCx58W4IXK85GchpJ3UPMZXx1LRNe
         fX8QxhxPPIpcOaKQDKgFALW0M2TdWRfYdQRlC8eW6GFdO6ShaBTl8cobUTIGRDZRQAtz
         RfJlQF80SIhFwZF0Dd+tB1Xf+ST5m2fL2GnEjW+rL9mvpSveTqF22wi1Q7JD7sqmXU58
         KRXm+OgC5GeXIgBARbEkzHRvaTx8iqzyrzEx+AEaXrPcBm9sNLa2f92zPo0nE3ZeUXcW
         BaSA==
X-Gm-Message-State: AOAM531J2zfpgJ0lVMQQ7fYCkO8+IbWnbUKkGBCDUBBMdYqOBncu18N2
        aWR99Fkga1346C+JYVGRB95XyjuT/2Qdz+snfc0MWQ==
X-Google-Smtp-Source: ABdhPJwT+pj0knnZ6KtzMGVJehL1QVPwQ06NFEozN8EW30EpG+ix63pb9GVliVDFk2PPoXYHUEM/05EfpEXUUjlEYdU=
X-Received: by 2002:a67:dd90:: with SMTP id i16mr9454274vsk.86.1642514446138;
 Tue, 18 Jan 2022 06:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20220118110928.120640-1-linus.walleij@linaro.org>
In-Reply-To: <20220118110928.120640-1-linus.walleij@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 18 Jan 2022 16:00:34 +0200
Message-ID: <CAPLW+4kS73Tg2C7dJ_gkMHF6=KT0pB4gQ18hAoTMTv-j5Q73pg@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] spi: s3c64xx: Delete unused boardfile helpers
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
> The helpers to use SPI host 1 and 2 are unused in the kernel
> and taking up space and maintenance hours. New systems should
> use device tree and not this, so delete the code.
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

>  arch/arm/mach-s3c/Kconfig                 | 12 ----
>  arch/arm/mach-s3c/devs.c                  | 72 -----------------------
>  arch/arm/mach-s3c/setup-spi-s3c64xx.c     |  9 ---
>  arch/arm/mach-s3c/spi-core-s3c24xx.h      |  6 --
>  include/linux/platform_data/spi-s3c64xx.h |  8 ---
>  5 files changed, 107 deletions(-)
>
> diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
> index 25606e668cf9..1899fc3f44fd 100644
> --- a/arch/arm/mach-s3c/Kconfig
> +++ b/arch/arm/mach-s3c/Kconfig
> @@ -191,18 +191,6 @@ config S3C64XX_DEV_SPI0
>           Compile in platform device definitions for S3C64XX's type
>           SPI controller 0
>
> -config S3C64XX_DEV_SPI1
> -       bool
> -       help
> -         Compile in platform device definitions for S3C64XX's type
> -         SPI controller 1
> -
> -config S3C64XX_DEV_SPI2
> -       bool
> -       help
> -         Compile in platform device definitions for S3C64XX's type
> -         SPI controller 2
> -
>  config SAMSUNG_DEV_TS
>         bool
>         help
> diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
> index 06dec64848f9..9f086aee862b 100644
> --- a/arch/arm/mach-s3c/devs.c
> +++ b/arch/arm/mach-s3c/devs.c
> @@ -1125,75 +1125,3 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>         s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
>  }
>  #endif /* CONFIG_S3C64XX_DEV_SPI0 */
> -
> -#ifdef CONFIG_S3C64XX_DEV_SPI1
> -static struct resource s3c64xx_spi1_resource[] = {
> -       [0] = DEFINE_RES_MEM(S3C_PA_SPI1, SZ_256),
> -       [1] = DEFINE_RES_IRQ(IRQ_SPI1),
> -};
> -
> -struct platform_device s3c64xx_device_spi1 = {
> -       .name           = "s3c6410-spi",
> -       .id             = 1,
> -       .num_resources  = ARRAY_SIZE(s3c64xx_spi1_resource),
> -       .resource       = s3c64xx_spi1_resource,
> -       .dev = {
> -               .dma_mask               = &samsung_device_dma_mask,
> -               .coherent_dma_mask      = DMA_BIT_MASK(32),
> -       },
> -};
> -
> -void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
> -                                               int num_cs)
> -{
> -       struct s3c64xx_spi_info pd;
> -
> -       /* Reject invalid configuration */
> -       if (!num_cs || src_clk_nr < 0) {
> -               pr_err("%s: Invalid SPI configuration\n", __func__);
> -               return;
> -       }
> -
> -       pd.num_cs = num_cs;
> -       pd.src_clk_nr = src_clk_nr;
> -       pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
> -
> -       s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
> -}
> -#endif /* CONFIG_S3C64XX_DEV_SPI1 */
> -
> -#ifdef CONFIG_S3C64XX_DEV_SPI2
> -static struct resource s3c64xx_spi2_resource[] = {
> -       [0] = DEFINE_RES_MEM(S3C_PA_SPI2, SZ_256),
> -       [1] = DEFINE_RES_IRQ(IRQ_SPI2),
> -};
> -
> -struct platform_device s3c64xx_device_spi2 = {
> -       .name           = "s3c6410-spi",
> -       .id             = 2,
> -       .num_resources  = ARRAY_SIZE(s3c64xx_spi2_resource),
> -       .resource       = s3c64xx_spi2_resource,
> -       .dev = {
> -               .dma_mask               = &samsung_device_dma_mask,
> -               .coherent_dma_mask      = DMA_BIT_MASK(32),
> -       },
> -};
> -
> -void __init s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
> -                                               int num_cs)
> -{
> -       struct s3c64xx_spi_info pd;
> -
> -       /* Reject invalid configuration */
> -       if (!num_cs || src_clk_nr < 0) {
> -               pr_err("%s: Invalid SPI configuration\n", __func__);
> -               return;
> -       }
> -
> -       pd.num_cs = num_cs;
> -       pd.src_clk_nr = src_clk_nr;
> -       pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
> -
> -       s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi2);
> -}
> -#endif /* CONFIG_S3C64XX_DEV_SPI2 */
> diff --git a/arch/arm/mach-s3c/setup-spi-s3c64xx.c b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
> index efcf78d41585..497aff71c29c 100644
> --- a/arch/arm/mach-s3c/setup-spi-s3c64xx.c
> +++ b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
> @@ -16,12 +16,3 @@ int s3c64xx_spi0_cfg_gpio(void)
>         return 0;
>  }
>  #endif
> -
> -#ifdef CONFIG_S3C64XX_DEV_SPI1
> -int s3c64xx_spi1_cfg_gpio(void)
> -{
> -       s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
> -                               S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> -       return 0;
> -}
> -#endif
> diff --git a/arch/arm/mach-s3c/spi-core-s3c24xx.h b/arch/arm/mach-s3c/spi-core-s3c24xx.h
> index 057667469cc3..919c5fd0c9af 100644
> --- a/arch/arm/mach-s3c/spi-core-s3c24xx.h
> +++ b/arch/arm/mach-s3c/spi-core-s3c24xx.h
> @@ -16,12 +16,6 @@ static inline void s3c24xx_spi_setname(char *name)
>  #ifdef CONFIG_S3C64XX_DEV_SPI0
>         s3c64xx_device_spi0.name = name;
>  #endif
> -#ifdef CONFIG_S3C64XX_DEV_SPI1
> -       s3c64xx_device_spi1.name = name;
> -#endif
> -#ifdef CONFIG_S3C64XX_DEV_SPI2
> -       s3c64xx_device_spi2.name = name;
> -#endif
>  }
>
>  #endif /* __PLAT_S3C_SPI_CORE_S3C24XX_H */
> diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
> index 773daf7915a3..19d690f34670 100644
> --- a/include/linux/platform_data/spi-s3c64xx.h
> +++ b/include/linux/platform_data/spi-s3c64xx.h
> @@ -52,17 +52,9 @@ struct s3c64xx_spi_info {
>   */
>  extern void s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>                                                 int num_cs);
> -extern void s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
> -                                               int num_cs);
> -extern void s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
> -                                               int num_cs);
>
>  /* defined by architecture to configure gpio */
>  extern int s3c64xx_spi0_cfg_gpio(void);
> -extern int s3c64xx_spi1_cfg_gpio(void);
> -extern int s3c64xx_spi2_cfg_gpio(void);
>
>  extern struct s3c64xx_spi_info s3c64xx_spi0_pdata;
> -extern struct s3c64xx_spi_info s3c64xx_spi1_pdata;
> -extern struct s3c64xx_spi_info s3c64xx_spi2_pdata;
>  #endif /*__SPI_S3C64XX_H */
> --
> 2.34.1
>
