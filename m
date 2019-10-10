Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCBD33AE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2019 23:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfJJVxg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Oct 2019 17:53:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39694 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVxf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Oct 2019 17:53:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so7064788qki.6;
        Thu, 10 Oct 2019 14:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KUJrhrPz34prZHQPwuRHd4WWImJkzkCSryx5fAKFeY=;
        b=sqfZoSPYvhJdBSFx66TubOXenl7vwDwrcMjXHOEXQIQmPdExbFoRcOt+j/4P9JjLQ2
         S/42IHla/cnpX3Gy8uyjOIWmrJWfquHaf8lVX/Oapb6+fzR25cnW+2gPJ6dj7TUJrhRI
         /+xXH02sl3/edXhLXYcaxataXcwMo7yu51pG7MReQwO4wmc0Ydow+bBrm36EUIyTdZaM
         zO7EAioFfp7/TJtsdhCnY9nZBSyzuzAG5NUcgukakBoWpj7HLaHCDJWezEgEpajGw5M7
         YdijZqozE0IjOPV3OE49ppP2esKu1/mn3GNt/6KwHTzYcETyvhbDCew2iUR6cDw2NGtq
         WK6A==
X-Gm-Message-State: APjAAAW2ZKl1wNeiJsNUirxt6Yc98UpOQZOw0qedSemwaer8OhbMdIhi
        Cpet7MfqD3EwdekjoOLmdRikz3mzPGf9RUf2OyM=
X-Google-Smtp-Source: APXvYqwI5aZHDA5AQ5r7nRWW4bmOM1FPEwqypeNgqzsA4zDVqF3VF9ai0AW+gXH8pRsYBpeg659n6diW29XFvF8Ul3Q=
X-Received: by 2002:a05:620a:218f:: with SMTP id g15mr12031339qka.3.1570744414547;
 Thu, 10 Oct 2019 14:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-34-arnd@arndb.de> <20191010210208.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20191010210208.GK25745@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Oct 2019 23:53:18 +0200
Message-ID: <CAK8P3a2HTrxhncNbFtGA3itsZU6hfvRm6bW5ikx-PMFpVKcwdg@mail.gmail.com>
Subject: Re: [PATCH 34/36] ARM: s3c: stop including mach/hardware.h from mach/io.h
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 10, 2019 at 11:02 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 10, 2019 at 10:30:18PM +0200, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> > index 2ad22b2d459b..f8a114891f16 100644
> > --- a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> > +++ b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> > @@ -14,6 +14,8 @@
> >  #ifndef GPIO_SAMSUNG_S3C24XX_H
> >  #define GPIO_SAMSUNG_S3C24XX_H
> >
> > +#include <mach/map.h>
> > +
>
> Why?  Nothing in this file uses anything from mach/map.h

Good point, I don't recall how this happened, most likely either
edited the wrong file after a build regression, or I had moved some
definition into this file in a patch that I later discarded and this
change got left behind.

> > diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> > index 7ca3dd4f13c0..da4e7b3aeba6 100644
> > --- a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> > +++ b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> > @@ -9,6 +9,8 @@
> >  #ifndef __ASM_ARM_REGS_CLOCK
> >  #define __ASM_ARM_REGS_CLOCK
> >
> > +#include <mach/map.h>
> > +
>
> Why?  Nothing in this file uses anything from mach/map.h

I think I added this one for S3C24XX_VA_CLKPWR, which is in
plat/map-s3c.h

> > diff --git a/drivers/spi/spi-s3c24xx-regs.h b/drivers/spi/spi-s3c24xx-regs.h
> > index 37b93ff7c7fe..b76d591eba8c 100644
> > --- a/drivers/spi/spi-s3c24xx-regs.h
> > +++ b/drivers/spi/spi-s3c24xx-regs.h
> > @@ -8,6 +8,8 @@
> >  #ifndef __ASM_ARCH_REGS_SPI_H
> >  #define __ASM_ARCH_REGS_SPI_H
> >
> > +#include <mach/map.h>
> > +
>
> If this is outside of arch/arm, it shouldn't need anything from
> mach/map.h - mach/map.h is not for driver use.

This was the result of a botched rebase: The patch was initially
at the start of the series where the #include was still required
but later moved to the end behind the patch that used to remove
it again.

> > diff --git a/drivers/usb/gadget/udc/s3c2410_udc_regs.h b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> > index d8d2eeaca088..4df279342cdd 100644
> > --- a/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> > +++ b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> > @@ -6,6 +6,8 @@
> >  #ifndef __ASM_ARCH_REGS_UDC_H
> >  #define __ASM_ARCH_REGS_UDC_H
> >
> > +#include <mach/map.h>
> > +
>
> If this is outside of arch/arm, it shouldn't need anything from
> mach/map.h - mach/map.h is not for driver use.

Same here.

Thanks for taking a look, I'll fix it all up tomorrow.

          Arnd
