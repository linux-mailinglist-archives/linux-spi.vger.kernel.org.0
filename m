Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C0E1A4E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391495AbfJWMcG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 08:32:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35217 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391515AbfJWMcG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 08:32:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id k2so4920019edx.2;
        Wed, 23 Oct 2019 05:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQN2p3CqQqqGqvDm8RQZXLnReFZTauNKSF3Je5lv8Vs=;
        b=gItzH1IURch9FFmt63SUbbuq/OHTKyUQ+X7g1I/SDPfP8SPD++IdzXjsJLSxhnrT+N
         tMZ7HCc3PZJRuioc9AhYyW6s0zwbCsyhMjRSc+HbjmeoxuoLpnbM0yq6iN+cbvruD/vc
         rTRSRo5AorLH7xpE5vk2bqL81l6/FVXACI8mFe7Wdjpog4PletWf2rPalNrBnsqgzsUK
         prfA7+sG/29ktzTFqFMbvgGQWXW+KvNNHfIKEaRtVB7cwgWhrcPxHwDLydbg37kbcBJ0
         x07ojpOZiqSzFVkx/TSKdq9HbYfZxw33JAMRD1oza44o3yyauaQUSvmvFXtThfrXTSBU
         8O0g==
X-Gm-Message-State: APjAAAVvImdjU/xeCMkWXraiHXTMP2+Fcn8XJl95qjDSMA8n5dxJII9U
        XTuWekMG/g8hH5ZaaoDosG8=
X-Google-Smtp-Source: APXvYqzAyy2/9uMMaEi+++Uil+JEuPxjvNWuDWfQdsPMkZduyAwEgeg60Y2iekGhRXEaJq6rYisoxg==
X-Received: by 2002:a17:906:d214:: with SMTP id w20mr32128690ejz.68.1571833923476;
        Wed, 23 Oct 2019 05:32:03 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id k24sm163420edx.46.2019.10.23.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:32:02 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:32:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 13/36] ARM: s3c: move regs-spi.h into spi driver
Message-ID: <20191023123200.GC11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-13-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-13-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:57PM +0200, Arnd Bergmann wrote:
> The file is mostly specific to the driver, the few bits that
> are actually used by the platform code get moved to mach/map.h
> instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/include/mach/map.h                      | 2 ++
>  arch/arm/mach-s3c24xx/s3c2412.c                               | 1 -
>  arch/arm/plat-samsung/devs.c                                  | 1 -
>  drivers/spi/spi-s3c24xx-fiq.S                                 | 4 +++-
>  .../include/plat/regs-spi.h => drivers/spi/spi-s3c24xx-regs.h | 3 ---
>  drivers/spi/spi-s3c24xx.c                                     | 3 +--
>  6 files changed, 6 insertions(+), 8 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/regs-spi.h => drivers/spi/spi-s3c24xx-regs.h (95%)
> 
> diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
> index bca93112f57d..a20c9fd0d855 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/map.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/map.h
> @@ -86,6 +86,8 @@
>  #define S3C2410_PA_SPI	   (0x59000000)
>  #define S3C2443_PA_SPI0		(0x52000000)
>  #define S3C2443_PA_SPI1		S3C2410_PA_SPI
> +#define S3C2410_SPI1		(0x20)
> +#define S3C2412_SPI1		(0x100)
>  
>  /* SDI */
>  #define S3C2410_PA_SDI	   (0x5A000000)
> diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
> index 8fe4d4670dcb..c3fb3e6c0dd8 100644
> --- a/arch/arm/mach-s3c24xx/s3c2412.c
> +++ b/arch/arm/mach-s3c24xx/s3c2412.c
> @@ -37,7 +37,6 @@
>  #include <plat/cpu-freq.h>
>  #include <plat/devs.h>
>  #include <plat/pm.h>
> -#include <plat/regs-spi.h>
>  
>  #include "common.h"
>  #include "nand-core.h"
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index 6e4c1cb07104..fd94a35e22f8 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -59,7 +59,6 @@
>  #include <linux/platform_data/usb-s3c2410_udc.h>
>  #include <linux/platform_data/usb-ohci-s3c2410.h>
>  #include <plat/usb-phy.h>
> -#include <plat/regs-spi.h>
>  #include <linux/platform_data/asoc-s3c.h>
>  #include <linux/platform_data/spi-s3c64xx.h>
>  
> diff --git a/drivers/spi/spi-s3c24xx-fiq.S b/drivers/spi/spi-s3c24xx-fiq.S
> index e95d6282109e..9d5f8f1e5e81 100644
> --- a/drivers/spi/spi-s3c24xx-fiq.S
> +++ b/drivers/spi/spi-s3c24xx-fiq.S
> @@ -12,10 +12,12 @@
>  
>  #include <mach/map.h>
>  #include <mach/regs-irq.h>
> -#include <plat/regs-spi.h>
>  
>  #include "spi-s3c24xx-fiq.h"
>  
> +#define S3C2410_SPTDAT           (0x10)
> +#define S3C2410_SPRDAT           (0x14)
> +
>  	.text
>  
>  	@ entry to these routines is as follows, with the register names
> diff --git a/arch/arm/plat-samsung/include/plat/regs-spi.h b/drivers/spi/spi-s3c24xx-regs.h
> similarity index 95%
> rename from arch/arm/plat-samsung/include/plat/regs-spi.h
> rename to drivers/spi/spi-s3c24xx-regs.h
> index 607844311566..37b93ff7c7fe 100644
> --- a/arch/arm/plat-samsung/include/plat/regs-spi.h
> +++ b/drivers/spi/spi-s3c24xx-regs.h
> @@ -8,9 +8,6 @@
>  #ifndef __ASM_ARCH_REGS_SPI_H
>  #define __ASM_ARCH_REGS_SPI_H

Can you also update the guard name?

Best regards,
Krzysztof

>  
> -#define S3C2410_SPI1		(0x20)
> -#define S3C2412_SPI1		(0x100)
> -
>  #define S3C2410_SPCON		(0x00)
>  
>  #define S3C2410_SPCON_SMOD_DMA	(2 << 5)	/* DMA mode */
> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
> index 2d6e37f25e2d..2f395e4861f6 100644
> --- a/drivers/spi/spi-s3c24xx.c
> +++ b/drivers/spi/spi-s3c24xx.c
> @@ -21,10 +21,9 @@
>  #include <linux/spi/s3c24xx.h>
>  #include <linux/module.h>
>  
> -#include <plat/regs-spi.h>
> -
>  #include <asm/fiq.h>
>  
> +#include "spi-s3c24xx-regs.h"
>  #include "spi-s3c24xx-fiq.h"
>  
>  /**
> -- 
> 2.20.0
> 
