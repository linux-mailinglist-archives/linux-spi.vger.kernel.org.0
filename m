Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24D349D6B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfFRJeD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 18 Jun 2019 05:34:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39231 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfFRJeD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 05:34:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so8730400lfo.6
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 02:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rjUkB2y0cDKZD5Eu+L6mo37jTuuRbS2nG9j7x6+uX9A=;
        b=NaV4Um1YiebhxjD+nNteMYPrcCfKrvVMe1WeNIAEZLu2VZ456+saZVbhmgUcOU2nBz
         NoKgLACrV0qGTOfVZ+h/IMcPqAcln+i5Ne0fDVsuHcOfG5vTj2BGT1Bg7mlqZq31JidA
         4f77x6IkXXX9D512ZU5jYRK3N5+mZlkBZxwSKDoOSGguiGeBTM+JaGJzypnw9KO7LMOM
         dKBFD/Hfn0ZlCeMM6D+EICT5+oVNTafAShicd0XkeQ+XkR7bcybt/A1oLqj93REqBNPQ
         xJGjqb3LJPxZyhB0aTcWTfqS/yav33sDNwGHUO40J5JZ/nUVfrzH/AZTpVefOv46RQZJ
         +P+Q==
X-Gm-Message-State: APjAAAVOnaY98BmBgzKG1HbudcyC7h3ki9ItaNEm9TML5NHpAsWDithU
        RcydIXUj4ahLD+BKY4JTVwMoB5XucEnR8WedsmmsrUgd
X-Google-Smtp-Source: APXvYqz5HzgVwfLFi+2EB4No4j0jbrp5X/pitKlHeiDWb+yP+klDTkAu7OWjc25GgQ3xUpQl3qkZL5ty+dSzPgshy7I=
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr10208592lfm.87.1560850440714;
 Tue, 18 Jun 2019 02:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com> <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com> <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com> <20190618091955.GN16364@dell>
In-Reply-To: <20190618091955.GN16364@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jun 2019 11:33:47 +0200
Message-ID: <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lee,

On Tue, Jun 18, 2019 at 11:20 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 18 Jun 2019, Geert Uytterhoeven wrote:
> > On Mon, Jun 17, 2019 at 11:31 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Fri, 14 Jun 2019, Sergei Shtylyov wrote:
> > > > On 06/12/2019 12:05 PM, Lee Jones wrote:
> > > > >> +static const struct mfd_cell rpcif_hf_ctlr = {
> > > > >> +  .name = "rpcif-hyperflash",
> > > > >> +};
> > > > >> +
> > > > >> +static const struct mfd_cell rpcif_spi_ctlr = {
> > > > >> +  .name = "rpcif-spi",
> > > > >> +};
> > > > >
> > > > > This looks like a very tenuous use of the MFD API.
> > > > >
> > > > > I suggest that this isn't actually an MFD at all.
> > > >
> > > >    The same hardware supports 2 different physical interfaces, hence
> > > > the drivers have to comply to 2 different driver frameworks... sounded
> > > > like MFD to me. :-)
> > >
> > > Not to me.
> > >
> > > This appears to be some kind of 'mode selector' for an MTD device.
> >
> > ... for either an SPI or MTD device.
>
> Okay, so I think I misunderstood the device.  I was under the
> impression that it was a flash memory device where the only difference
> was the interface by which it is controlled?
>
> > > Lots of drivers have multiple ways to control them - they are not all
> > > MFDs.
> >
> > So where to reside the common part? drivers/platform/renesas/?
>
> That does not make sense, since this is not a platform controller.
>
> > > > [...]
> > > > >> +static int rpcif_probe(struct platform_device *pdev)
> > > > >> +{
> > > > >> +  struct device_node *flash;
> > > > >> +  const struct mfd_cell *cell;
> > > > >> +  struct resource *res;
> > > > >> +  void __iomem *base;
> > > > >> +  struct rpcif *rpc;
> > > > >> +
> > > > >> +  flash = of_get_next_child(pdev->dev.of_node, NULL);
> > > > >> +  if (!flash) {
> > > > >> +          dev_warn(&pdev->dev, "no flash node found\n");
> > > > >> +          return -ENODEV;
> > > > >> +  }
> > > > >> +
> > > > >> +  if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> > > > >> +          cell = &rpcif_spi_ctlr;
> > > > >> +  } else if (of_device_is_compatible(flash, "cfi-flash")) {
> > > > >> +          cell = &rpcif_hf_ctlr;
> > > > >> +  } else {
> > > > >> +          dev_warn(&pdev->dev, "unknown flash type\n");
> > > > >> +          return -ENODEV;
> > > > >> +  }
> > > > >
> > > > > Why not let DT choose which device to probe?
> > > >
> > > >    It's the DT that decides here. How else would you imagine that?
> > > > It's the same hardware, just the different physical busses that it
> > > > commands...
> > >
> > > DT is not deciding here.  This driver is deciding based on the
> > > information contained in the tables - very different thing.
> > >
> > > Why not just let the OF framework probe the correct device i.e. let it
> > > parse the 2 compatible strings and let it match the correct driver for
> > > the device?
> >
> > The OF framework matches against the RPC-IF node, which is a single
> > hardware type, hence has a fixed compatible value.
> > The mode depends on the subnode in DT, which is something the OF
> > framework doesn't match against, so the driver itself has to check the
> > subnode's compatible value.
>
> I can see how it has been implemented.
>
> It is that which I was questioning.
>
> > DT describes hardware, not software (Linux subsystem boundary) policy.
>
> So is an RPC-IF a real hardware device.  Can you share the datasheet?

Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
not yet public.

However, a very similar hardware block is present in the RZ/A2M SoC.
Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
User’s Manual: Hardware", which you can download from
https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
