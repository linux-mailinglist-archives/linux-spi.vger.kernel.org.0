Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0288FB4791
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbfIQGgO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 02:36:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37441 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfIQGgN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 02:36:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id s28so2062185otd.4;
        Mon, 16 Sep 2019 23:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VA/5M2S2lqIzcsMp1DPf/Sv28rPk2HKwJRxSgrZ6sG0=;
        b=nm7ZFOvF7l2OnsjPSy7l28t10rId/mSWGcjP8M6h/x5CLjNRq3JSZ7LpCkOS1scS1f
         /dKKENIJsM1pm3WNC3SF9JhOoEdYda29YrszQ3uC88/C0d5qJP7uaD2UxrGx+5gDNv4q
         YO/robCU6ZRwuF2xxptdWR3pFHPzkRETnfchB/WbdzFSDpLUM/oxog3GMHs/KFCxxNhQ
         SLuCrXiSvAGj2IjbbhjhRnsBvYDx6A2PW4E38u2wqOaEvRqiVES8m5vYey+2cVdNQPmE
         sWGCH5afJ4oURlTqlxkpiN1iX/2o91sfHC1XtFFkfYSnbLby9Tl9uWMsSnOhY/JxmAGh
         QV3w==
X-Gm-Message-State: APjAAAXL5VSh0wI2H5AziHCksKBs7rxkUMmeg9nH3RaITru6AWqPVcPi
        MPIM+vNqXqC7QUu39ST0MdH6tCBgKWEQNhPEm90=
X-Google-Smtp-Source: APXvYqyzliy8aN4mUPDnslQqjjAc6HBGtMP/9mirV4GtW01sd8kN+3jplqulEdGp/El2AoHzaEfa+9yxYwadW99stJY=
X-Received: by 2002:a9d:12ca:: with SMTP id g68mr1489740otg.145.1568702172994;
 Mon, 16 Sep 2019 23:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdUnzmYEcp0B5MG7itB1JHtNL7Stj9S2EFB0U0y_naQVBQ@mail.gmail.com> <TY2PR01MB2924AA1B012C2D305EE5C9B7DF8C0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB2924AA1B012C2D305EE5C9B7DF8C0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Sep 2019 08:36:01 +0200
Message-ID: <CAMuHMdX9ZdLMmpHGqm2wmajwEDjuTY7s19PqwQ3kaVu8WLLykA@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: dw: Add basic runtime PM support
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Gareth,

On Mon, Sep 16, 2019 at 6:14 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> > On Mon, Sep 16, 2019 at 15:36 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > On Fri, Sep 13, 2019 at 2:13 PM Gareth Williams
> > <gareth.williams.jx@renesas.com> wrote:
> > > From: Phil Edworthy <phil.edworthy@renesas.com>
> > >
> > > Enable runtime PM so that the clock used to access the registers in
> > > the peripheral is turned on using a clock domain.
> > >
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/spi/spi-dw.c
> > > +++ b/drivers/spi/spi-dw.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/highmem.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/spi/spi.h>
> > >
> > > @@ -497,6 +498,9 @@ int dw_spi_add_host(struct device *dev, struct
> > dw_spi *dws)
> > >         if (dws->set_cs)
> > >                 master->set_cs = dws->set_cs;
> > >
> > > +       pm_runtime_enable(dev);
> > > +       pm_runtime_get_sync(dev);
> >
> > The second line keeps the device powered all the time.
> > What about setting spi_controller.auto_runtime_pm = true, so the SPI code
> > can manage its Runtime PM status?
>
> That makes sense and works on target, I will change this for V2.

> > I assume this will be called from drivers/spi/spi-dw-mmio.c, which already
> > enables the clock explicitly all the timer?
> Yes, spi-dw-mmio.c already enables the bus clock, however we want to use clock
>
> domain to enable the clock and not explicitly provide pclk in the dts. If there are
> no other uses of that pclk, we can remove that later on.

IC, that's useful sideband information.

"pclk" is indeed an optional clock.
"ssi_clk" must be first.

However, to make use of the clock domain code, you still have to list "pclk"
in DT, but use a different name, to avoid spi-dw-mmio.c enabling it all the
time? Or do you plan to modify spi-dw-mmio.c for that?
In the former case, you should document that in your bindings, which
currently build on top of snps,dw-apb-ssi.txt, thus include "pclk".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
