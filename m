Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1381B45081A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhKOPVJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 10:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhKOPVE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 10:21:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E030C061714;
        Mon, 15 Nov 2021 07:18:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r11so9692621edd.9;
        Mon, 15 Nov 2021 07:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEGCaYW7o8CiYJ7dj7CTIBNrCzFV6AyEo6CAbFbpu88=;
        b=YKw8y5EYY7p6pKycrl5yK1BBcR1pB/C1Ju10tlj7vuetwWTISeAb/K2QVULPlWoWgw
         nc0AGh688R+/wpZdDLC4Yqkb22kyy91jdjemMfpOi+nDcksnfpcrUsbOHZmeVFTOd5NQ
         eBX00sAN2JQuotwiBfTGcM8lyaTbNYeckjWy3eviq21hWJwRETLekb3Zf/YRHS9tkDg2
         /yCtNMum0nAoDaXeY9ZnOGmrAYadSZSTx9ZvZv8ZNdM0Fyo7f/ml7Bxcy8HP785At4vc
         5zUu7skBvWyQRbGL/4+tOMNt5OKPrhjskKBDhavztjUr3gwSyQoZqO4MvIh40CapoyRl
         0f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEGCaYW7o8CiYJ7dj7CTIBNrCzFV6AyEo6CAbFbpu88=;
        b=bSPHoJFGaB/Z7Kp5nmqu1OYCuTpjwf+wOAJ9fVOUAzNJVzuv3PyLexZnFBMgTWMMCw
         +JbNOcmVOKr3qu4kQjTl/hacyPTCcrmBWg9GvYO4SHuaBYBCpA/HllaKp2Q0DeT2U23R
         quaods8H9mpcnhcGAZNPK671auPGTiAhpTY6WCAt1X3G9cZhdpLHGHIeKTneVZLIBjSg
         AG5PBvYawudNFrzMsm8IW4NxFS0CYFutH6kEuG7HddKz/FfK1nKZPcmiz8ERcfDAIKEQ
         3H9yQ7klfERDbG+Ez9ZAelAIoC7aBq0KxEOT9tu5Zp6H/8U1pShFkUejB/ci0g+DjI2p
         USGQ==
X-Gm-Message-State: AOAM530yReJU7OGv9t/2eExbn3KR8C1rJ5iU2IbPrfhJrv0nZWaJW6wv
        45hStQaF2GuD51Aff6Jdp8WlXbsIPoFoNd7hneM=
X-Google-Smtp-Source: ABdhPJySPHMrm6R7Dz1CZDCOgkUPCgVBFP/QfHuCM72KLM8yQJWZVtCECTL2TJ249KlmZ5aZjoQHUPmz7/MiUg5YufQ=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr25589481ejb.69.1636989484880;
 Mon, 15 Nov 2021 07:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-2-Sergey.Semin@baikalelectronics.ru>
 <YZJuPrnhupbnPxGt@smile.fi.intel.com> <20211115150344.sgrqqnl7nudntrqx@mobilestation>
In-Reply-To: <20211115150344.sgrqqnl7nudntrqx@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 17:17:23 +0200
Message-ID: <CAHp75VfndC2Ht78Zi_DHCEKgnsBanmXW0i7YSQt1eQSSghTfxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] spi: dw: Add a symbols namespace for the core module
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 5:03 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Mon, Nov 15, 2021 at 04:27:10PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 01:30:21AM +0300, Serge Semin wrote:

...

> > > +MODULE_IMPORT_NS(SPI_DW_CORE);
> >
> > I would rather see this at the end of file, but it should work either way.
>
> I've just realized it, do I really need the
> namespace imported in this object at all?.. It's linked into the
> spi-dw-core.ko. See drivers/spi/Makefile:
> obj-$(CONFIG_SPI_DESIGNWARE)            += spi-dw.o
> spi-dw-y                                := spi-dw-core.o
> spi-dw-$(CONFIG_SPI_DW_DMA)             += spi-dw-dma.o
> so the object must have got the same namespace.
>
> Yeah, most likely I shouldn't have used the MODULE_IMPORT_NS() here...

Indeed.

-- 
With Best Regards,
Andy Shevchenko
