Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6FDD331D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2019 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJJVCb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Oct 2019 17:02:31 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49918 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJJVCa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Oct 2019 17:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GOvsSXPX5WtsXHeYWNOuRtlXQ9QuSoefn1nZ0F/ehbA=; b=OwiduhoVYCBq+kBw6BNGb52t+
        k3WKuzfH+gk4cG4kW/cdwhUynmWiiU9pnNCTqIEucGpzVNDm+EcmC1bfjocV4gUjcMYl04y+je9kn
        wkjLfxhJYXP6RZE5q/ynoNZd6aM0u8yuj27EpNgYMtKdVmG2OoC8DmfXsntI+lB+/Q9oeWjsg1tX2
        UFED/3mQ44z4s5uPIhecp9t17UF9VrhIYVHKopdBsYyKiRIcQhHEZYehrwr02ve3xCyqD6xx4k2Ll
        orq9N+jC9bxwQSbywwfmlE9FaDneC+9Ol6dCuuWZwk8kqIls72YQXPKWMqkWsVgI7TQiVxnoxmdYR
        dg3c5rjnQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:42498)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iIfZc-0001FP-0J; Thu, 10 Oct 2019 22:02:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iIfZZ-0000WS-0V; Thu, 10 Oct 2019 22:02:09 +0100
Date:   Thu, 10 Oct 2019 22:02:08 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-samsung-soc@vger.kernel.org, linus.walleij@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 34/36] ARM: s3c: stop including mach/hardware.h from
 mach/io.h
Message-ID: <20191010210208.GK25745@shell.armlinux.org.uk>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-34-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-34-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 10, 2019 at 10:30:18PM +0200, Arnd Bergmann wrote:
> A number of other files rely on mach/map.h to be indirectly
> included from mach/io.h through mach/hardware.h.
> 
> Reduce this to the minimal plat/map-base.h and add explicit
> includes everywhere else.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/common.c                          | 1 +
>  arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h       | 2 ++
>  arch/arm/mach-s3c24xx/include/mach/hardware.h           | 7 -------
>  arch/arm/mach-s3c24xx/include/mach/io.h                 | 3 +--
>  arch/arm/mach-s3c24xx/include/mach/regs-clock.h         | 2 ++
>  arch/arm/mach-s3c24xx/include/mach/regs-gpio.h          | 2 ++
>  arch/arm/mach-s3c24xx/include/mach/regs-irq.h           | 2 ++
>  arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h | 1 +
>  arch/arm/mach-s3c24xx/include/mach/s3c2412.h            | 2 ++
>  arch/arm/mach-s3c24xx/mach-h1940.c                      | 1 +
>  arch/arm/mach-s3c24xx/mach-jive.c                       | 1 +
>  arch/arm/mach-s3c24xx/mach-rx1950.c                     | 1 +
>  arch/arm/mach-s3c24xx/pm-h1940.S                        | 1 -
>  arch/arm/mach-s3c24xx/regs-mem.h                        | 2 ++
>  arch/arm/mach-s3c24xx/s3c2410.c                         | 2 +-
>  arch/arm/mach-s3c24xx/s3c2412.c                         | 2 +-
>  arch/arm/mach-s3c24xx/s3c2416.c                         | 2 +-
>  arch/arm/mach-s3c24xx/s3c2443.c                         | 2 +-
>  arch/arm/mach-s3c24xx/s3c244x.c                         | 2 +-
>  arch/arm/mach-s3c24xx/sleep-s3c2410.S                   | 1 -
>  arch/arm/mach-s3c24xx/sleep-s3c2412.S                   | 1 -
>  arch/arm/mach-s3c24xx/sleep.S                           | 1 -
>  drivers/spi/spi-s3c24xx-regs.h                          | 2 ++
>  drivers/usb/gadget/udc/s3c2410_udc_regs.h               | 2 ++
>  24 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
> index d16a164df6c4..42d828f48345 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -21,6 +21,7 @@
>  #include <linux/dmaengine.h>
>  
>  #include <mach/hardware.h>
> +#include <mach/map.h>
>  #include <mach/regs-clock.h>
>  #include <asm/irq.h>
>  #include <asm/cacheflush.h>
> diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> index 2ad22b2d459b..f8a114891f16 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> @@ -14,6 +14,8 @@
>  #ifndef GPIO_SAMSUNG_S3C24XX_H
>  #define GPIO_SAMSUNG_S3C24XX_H
>  
> +#include <mach/map.h>
> +

Why?  Nothing in this file uses anything from mach/map.h

>  /*
>   * GPIO sizes for various SoCs:
>   *
> diff --git a/arch/arm/mach-s3c24xx/include/mach/hardware.h b/arch/arm/mach-s3c24xx/include/mach/hardware.h
> index f28ac6c78d82..c732ea54984c 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/hardware.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/hardware.h
> @@ -9,13 +9,6 @@
>  #ifndef __ASM_ARCH_HARDWARE_H
>  #define __ASM_ARCH_HARDWARE_H
>  
> -#ifndef __ASSEMBLY__
> -
>  extern unsigned int s3c2410_modify_misccr(unsigned int clr, unsigned int chg);
>  
> -#endif /* __ASSEMBLY__ */
> -
> -#include <linux/sizes.h>
> -#include <mach/map.h>
> -
>  #endif /* __ASM_ARCH_HARDWARE_H */
> diff --git a/arch/arm/mach-s3c24xx/include/mach/io.h b/arch/arm/mach-s3c24xx/include/mach/io.h
> index 3e8bff26cdd5..bcddf615adb6 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/io.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/io.h
> @@ -10,8 +10,7 @@
>  #ifndef __ASM_ARM_ARCH_IO_H
>  #define __ASM_ARM_ARCH_IO_H
>  
> -#include <mach/hardware.h>
> -
> +#include <plat/map-base.h>
>  
>  /*
>   * ISA style IO, for each machine to sort out mappings for,
> diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> index 7ca3dd4f13c0..da4e7b3aeba6 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> @@ -9,6 +9,8 @@
>  #ifndef __ASM_ARM_REGS_CLOCK
>  #define __ASM_ARM_REGS_CLOCK
>  
> +#include <mach/map.h>
> +

Why?  Nothing in this file uses anything from mach/map.h

>  #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
>  
>  #define S3C2410_PLLVAL(_m,_p,_s) ((_m) << 12 | ((_p) << 4) | ((_s)))
> diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
> index 594e967c0673..51827d5577b6 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
> @@ -10,6 +10,8 @@
>  #ifndef __ASM_ARCH_REGS_GPIO_H
>  #define __ASM_ARCH_REGS_GPIO_H
>  
> +#include <plat/map-s3c.h>
> +
>  #define S3C24XX_MISCCR		S3C24XX_GPIOREG2(0x80)
>  
>  /* general configuration options */
> diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-irq.h b/arch/arm/mach-s3c24xx/include/mach/regs-irq.h
> index 8d8e669e3903..2921b48c56b2 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/regs-irq.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/regs-irq.h
> @@ -8,6 +8,8 @@
>  #ifndef ___ASM_ARCH_REGS_IRQ_H
>  #define ___ASM_ARCH_REGS_IRQ_H
>  
> +#include <plat/map-s3c.h>
> +
>  /* interrupt controller */
>  
>  #define S3C2410_IRQREG(x)   ((x) + S3C24XX_VA_IRQ)
> diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> index 682759549e63..fefef7233f4b 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> @@ -11,6 +11,7 @@
>  #define __ASM_ARM_REGS_S3C2443_CLOCK
>  
>  #include <linux/delay.h>
> +#include <plat/map-s3c.h>
>  
>  #define S3C2443_CLKREG(x)		((x) + S3C24XX_VA_CLKPWR)
>  
> diff --git a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
> index 4ff83f956cfb..1ae369c81beb 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
> @@ -8,6 +8,8 @@
>  #ifndef __ARCH_ARM_MACH_S3C24XX_S3C2412_H
>  #define __ARCH_ARM_MACH_S3C24XX_S3C2412_H __FILE__
>  
> +#include <plat/map-s3c.h>
> +
>  #define S3C2412_MEMREG(x)		(S3C24XX_VA_MEMCTRL + (x))
>  #define S3C2412_EBIREG(x)		(S3C2412_VA_EBI + (x))
>  
> diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
> index d56e3befa459..287e42fc1665 100644
> --- a/arch/arm/mach-s3c24xx/mach-h1940.c
> +++ b/arch/arm/mach-s3c24xx/mach-h1940.c
> @@ -48,6 +48,7 @@
>  #include <sound/uda1380.h>
>  
>  #include <linux/platform_data/fb-s3c2410.h>
> +#include <mach/map.h>
>  #include <mach/hardware.h>
>  #include <mach/regs-clock.h>
>  #include <mach/regs-gpio.h>
> diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
> index 3b33132b2334..8012c34bddd9 100644
> --- a/arch/arm/mach-s3c24xx/mach-jive.c
> +++ b/arch/arm/mach-s3c24xx/mach-jive.c
> @@ -31,6 +31,7 @@
>  #include <linux/platform_data/mtd-nand-s3c2410.h>
>  #include <linux/platform_data/i2c-s3c2410.h>
>  
> +#include <mach/hardware.h>
>  #include <mach/regs-gpio.h>
>  #include <linux/platform_data/fb-s3c2410.h>
>  #include <mach/gpio-samsung.h>
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
> index ee4a0992339f..f94884090fbe 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -46,6 +46,7 @@
>  
>  #include <sound/uda1380.h>
>  
> +#include <mach/hardware.h>
>  #include <mach/regs-gpio.h>
>  #include <mach/gpio-samsung.h>
>  
> diff --git a/arch/arm/mach-s3c24xx/pm-h1940.S b/arch/arm/mach-s3c24xx/pm-h1940.S
> index a7bbe336ac6b..f9ee515e1cbe 100644
> --- a/arch/arm/mach-s3c24xx/pm-h1940.S
> +++ b/arch/arm/mach-s3c24xx/pm-h1940.S
> @@ -7,7 +7,6 @@
>  
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> -#include <mach/hardware.h>
>  #include <mach/map.h>
>  
>  #include <mach/regs-gpio.h>
> diff --git a/arch/arm/mach-s3c24xx/regs-mem.h b/arch/arm/mach-s3c24xx/regs-mem.h
> index 2f3bc48b5890..5048ab8f06c2 100644
> --- a/arch/arm/mach-s3c24xx/regs-mem.h
> +++ b/arch/arm/mach-s3c24xx/regs-mem.h
> @@ -9,6 +9,8 @@
>  #ifndef __ARCH_ARM_MACH_S3C24XX_REGS_MEM_H
>  #define __ARCH_ARM_MACH_S3C24XX_REGS_MEM_H __FILE__
>  
> +#include <plat/map-s3c.h>
> +
>  #define S3C2410_MEMREG(x)		(S3C24XX_VA_MEMCTRL + (x))
>  
>  #define S3C2410_BWSCON			S3C2410_MEMREG(0x00)
> diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
> index 8427c150dd22..44bf3e1e77f1 100644
> --- a/arch/arm/mach-s3c24xx/s3c2410.c
> +++ b/arch/arm/mach-s3c24xx/s3c2410.c
> @@ -25,7 +25,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  
> -#include <mach/hardware.h>
> +#include <mach/map.h>
>  #include <mach/gpio-samsung.h>
>  #include <asm/irq.h>
>  #include <asm/system_misc.h>
> diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
> index 209f952a6c98..75648dcc2c1d 100644
> --- a/arch/arm/mach-s3c24xx/s3c2412.c
> +++ b/arch/arm/mach-s3c24xx/s3c2412.c
> @@ -29,7 +29,7 @@
>  #include <asm/irq.h>
>  #include <asm/system_misc.h>
>  
> -#include <mach/hardware.h>
> +#include <mach/map.h>
>  #include <mach/regs-clock.h>
>  #include <mach/regs-gpio.h>
>  
> diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
> index 1cdb7bd3e713..ef2eace605e6 100644
> --- a/arch/arm/mach-s3c24xx/s3c2416.c
> +++ b/arch/arm/mach-s3c24xx/s3c2416.c
> @@ -26,7 +26,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  
> -#include <mach/hardware.h>
> +#include <mach/map.h>
>  #include <mach/gpio-samsung.h>
>  #include <asm/proc-fns.h>
>  #include <asm/irq.h>
> diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
> index f404ecac4baf..00318ad994ff 100644
> --- a/arch/arm/mach-s3c24xx/s3c2443.c
> +++ b/arch/arm/mach-s3c24xx/s3c2443.c
> @@ -23,7 +23,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  
> -#include <mach/hardware.h>
> +#include <mach/map.h>
>  #include <mach/gpio-samsung.h>
>  #include <mach/irqs.h>
>  #include <asm/irq.h>
> diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
> index f5bd489bac85..0ca188d0ffe5 100644
> --- a/arch/arm/mach-s3c24xx/s3c244x.c
> +++ b/arch/arm/mach-s3c24xx/s3c244x.c
> @@ -25,7 +25,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  
> -#include <mach/hardware.h>
> +#include <mach/map.h>
>  #include <asm/irq.h>
>  
>  #include <mach/regs-clock.h>
> diff --git a/arch/arm/mach-s3c24xx/sleep-s3c2410.S b/arch/arm/mach-s3c24xx/sleep-s3c2410.S
> index 659f9eff9de2..e4f6f64e7826 100644
> --- a/arch/arm/mach-s3c24xx/sleep-s3c2410.S
> +++ b/arch/arm/mach-s3c24xx/sleep-s3c2410.S
> @@ -13,7 +13,6 @@
>  #include <linux/linkage.h>
>  #include <linux/serial_s3c.h>
>  #include <asm/assembler.h>
> -#include <mach/hardware.h>
>  #include <mach/map.h>
>  
>  #include <mach/regs-gpio.h>
> diff --git a/arch/arm/mach-s3c24xx/sleep-s3c2412.S b/arch/arm/mach-s3c24xx/sleep-s3c2412.S
> index c373f1ca862b..434f5082b2ed 100644
> --- a/arch/arm/mach-s3c24xx/sleep-s3c2412.S
> +++ b/arch/arm/mach-s3c24xx/sleep-s3c2412.S
> @@ -8,7 +8,6 @@
>  
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> -#include <mach/hardware.h>
>  #include <mach/map.h>
>  
>  #include <mach/regs-irq.h>
> diff --git a/arch/arm/mach-s3c24xx/sleep.S b/arch/arm/mach-s3c24xx/sleep.S
> index f0f11ad60c52..4bda4a413584 100644
> --- a/arch/arm/mach-s3c24xx/sleep.S
> +++ b/arch/arm/mach-s3c24xx/sleep.S
> @@ -13,7 +13,6 @@
>  #include <linux/linkage.h>
>  #include <linux/serial_s3c.h>
>  #include <asm/assembler.h>
> -#include <mach/hardware.h>
>  #include <mach/map.h>
>  
>  #include <mach/regs-gpio.h>
> diff --git a/drivers/spi/spi-s3c24xx-regs.h b/drivers/spi/spi-s3c24xx-regs.h
> index 37b93ff7c7fe..b76d591eba8c 100644
> --- a/drivers/spi/spi-s3c24xx-regs.h
> +++ b/drivers/spi/spi-s3c24xx-regs.h
> @@ -8,6 +8,8 @@
>  #ifndef __ASM_ARCH_REGS_SPI_H
>  #define __ASM_ARCH_REGS_SPI_H
>  
> +#include <mach/map.h>
> +

If this is outside of arch/arm, it shouldn't need anything from
mach/map.h - mach/map.h is not for driver use.

>  #define S3C2410_SPCON		(0x00)
>  
>  #define S3C2410_SPCON_SMOD_DMA	(2 << 5)	/* DMA mode */
> diff --git a/drivers/usb/gadget/udc/s3c2410_udc_regs.h b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> index d8d2eeaca088..4df279342cdd 100644
> --- a/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> +++ b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> @@ -6,6 +6,8 @@
>  #ifndef __ASM_ARCH_REGS_UDC_H
>  #define __ASM_ARCH_REGS_UDC_H
>  
> +#include <mach/map.h>
> +

If this is outside of arch/arm, it shouldn't need anything from
mach/map.h - mach/map.h is not for driver use.

>  #define S3C2410_USBDREG(x) (x)
>  
>  #define S3C2410_UDC_FUNC_ADDR_REG	S3C2410_USBDREG(0x0140)
> -- 
> 2.20.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
