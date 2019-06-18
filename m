Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0F49C53
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 10:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfFRIpy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 04:45:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46703 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfFRIpy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 04:45:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so12210300ljg.13
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 01:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGi10YvL5hYacvnUbLgDbBTS+RR4EcyOCox0HvkotpY=;
        b=e2gqMVRckA5l4keL5BhOG328miHCyvxb29rK2ZfFF/ZA45S0kPWelcZ+IY5GAZtexL
         mehIWeTugdRN46JhumVtKfWoefv+pLWU4Wl6+PWCEfWSpHTeh0JlFrlE8bB+b8bd8sgR
         zvrRWzM9oQyK4uv6duBLtw+X4dOEzi/JZROcp6+ttSQ3LapLPtMpeoszyBnF6l0f1Ojg
         awVTrFNITrUvbXPHQiNOo45hYBVLdlRYcOnnWxzMRwfpNV2pLSQMqF2m1hyBAwDUGICI
         D6OXUyulrOdi2Mks25M4/ZaToRnBk05y5bJNHxDepkeC0nMVuZJ56ECdSdh+xACWlodh
         9VOA==
X-Gm-Message-State: APjAAAUvwrKkXTBLlVZlxQ3P91Rwhc1LHlKdjryQB7v8rudYhbyINXcs
        em8akmfI32IpRibrVjoew3OvA+nxO6AsfW8a99A=
X-Google-Smtp-Source: APXvYqxhNMoK5ZJC+Ll8CSH6tPrz/+XMSF+KtGpR+VoQP9KPH25moMpsTlex4CQvuNn2Q2svbvBDzOsM7NgtvTna4jA=
X-Received: by 2002:a2e:2b57:: with SMTP id q84mr15311038lje.105.1560847552591;
 Tue, 18 Jun 2019 01:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com> <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com> <20190617093048.GD16364@dell>
In-Reply-To: <20190617093048.GD16364@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jun 2019 10:45:39 +0200
Message-ID: <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lee,

Thanks for your comments!

On Mon, Jun 17, 2019 at 11:31 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 14 Jun 2019, Sergei Shtylyov wrote:
> > On 06/12/2019 12:05 PM, Lee Jones wrote:
> > >> +static const struct mfd_cell rpcif_hf_ctlr = {
> > >> +  .name = "rpcif-hyperflash",
> > >> +};
> > >> +
> > >> +static const struct mfd_cell rpcif_spi_ctlr = {
> > >> +  .name = "rpcif-spi",
> > >> +};
> > >
> > > This looks like a very tenuous use of the MFD API.
> > >
> > > I suggest that this isn't actually an MFD at all.
> >
> >    The same hardware supports 2 different physical interfaces, hence
> > the drivers have to comply to 2 different driver frameworks... sounded
> > like MFD to me. :-)
>
> Not to me.
>
> This appears to be some kind of 'mode selector' for an MTD device.

... for either an SPI or MTD device.

> Lots of drivers have multiple ways to control them - they are not all
> MFDs.

So where to reside the common part? drivers/platform/renesas/?

> > [...]
> > >> +static int rpcif_probe(struct platform_device *pdev)
> > >> +{
> > >> +  struct device_node *flash;
> > >> +  const struct mfd_cell *cell;
> > >> +  struct resource *res;
> > >> +  void __iomem *base;
> > >> +  struct rpcif *rpc;
> > >> +
> > >> +  flash = of_get_next_child(pdev->dev.of_node, NULL);
> > >> +  if (!flash) {
> > >> +          dev_warn(&pdev->dev, "no flash node found\n");
> > >> +          return -ENODEV;
> > >> +  }
> > >> +
> > >> +  if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> > >> +          cell = &rpcif_spi_ctlr;
> > >> +  } else if (of_device_is_compatible(flash, "cfi-flash")) {
> > >> +          cell = &rpcif_hf_ctlr;
> > >> +  } else {
> > >> +          dev_warn(&pdev->dev, "unknown flash type\n");
> > >> +          return -ENODEV;
> > >> +  }
> > >
> > > Why not let DT choose which device to probe?
> >
> >    It's the DT that decides here. How else would you imagine that?
> > It's the same hardware, just the different physical busses that it
> > commands...
>
> DT is not deciding here.  This driver is deciding based on the
> information contained in the tables - very different thing.
>
> Why not just let the OF framework probe the correct device i.e. let it
> parse the 2 compatible strings and let it match the correct driver for
> the device?

The OF framework matches against the RPC-IF node, which is a single
hardware type, hence has a fixed compatible value.
The mode depends on the subnode in DT, which is something the OF
framework doesn't match against, so the driver itself has to check the
subnode's compatible value.
DT describes hardware, not software (Linux subsystem boundary) policy.

I think you could have two drivers (SPI and MFD) each matching against
the same compatible value, with .probe() functions returning -ENODEV
if the subnode doesn't have the appropriate compatible value.
However, (1) I don't know how well that would play with module
autoloading based on of_device_id, and (2) that still leaves the question
where to put the shared code.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
