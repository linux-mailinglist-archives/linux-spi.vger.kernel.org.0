Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2884B204
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 08:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfFSGRE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 02:17:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfFSGRE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 02:17:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so374835wmf.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hpCSKUW+pJz0UZq1AL3L1eRgiCmZcrkhzJagBfnLUxY=;
        b=fhR0yd8i47/BJapHT4ite9/sB0EmdTO7K60ystuf0xH63+wr/HL5TMxNSOcNtRy5ov
         9umzMzl5735GbEUOFvRblJbPFuCQ4LQ/yqnPRpJB+bFYyqjgNFE9uZYBHwyhFdIPPaPN
         oxiPeKlvR6VHIace+yzt9hOkC+QxPcoD6S8RntEASD0YjsL/upRKcOY7OC3+KnVptKhc
         PK1Uszh4dvv2o2jhnOJbn477UkrOL+reT0jtnZnGxbL1H9Y2gOWsxwmqrEI6bPgKrg+a
         XIK9XDFCg+grf9cZGD92xP2Cl1fSBCG+8g5BjHgg40HGSNWwE7gv6Dxb6+c8HlYf78W5
         QZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hpCSKUW+pJz0UZq1AL3L1eRgiCmZcrkhzJagBfnLUxY=;
        b=rPG913yxYX5heaqSWO4y2buv8ln4tRHBjfcxqcoIix6A70IWJx+FmsUlipPZj4sLVQ
         rEwb/5RwRw2RVqsXEvnmGBfYrvS4ULWqb2Woqsk7D3e+qWLDIE1acbTvzIribWHW+6rg
         nNqrG4vlAvH7H935MB0X9XhCgx99nmGqPvx51vsF7d+ZVSfrMJ/RNTLSBnfToNGSwF83
         m9X3G36B6eKiL9ZD+WtImmbDFihiQg/7QQsRPgduthnT7fv6VSq2gzlEbL/PjgcvHNVS
         Y91mGjK34CbZy0pepipMjmBqsAccCJeqTR8KtuS+wWw8mEuhhtmdhXlqjodoUp9XPZst
         dKpQ==
X-Gm-Message-State: APjAAAXr6UENwXxj4UYqE89DtxJTJVBztIdnYZRih1y1TctcZK77ho/x
        rcYjCi6PE7rYworWT46WdZrBB23+3do=
X-Google-Smtp-Source: APXvYqwJxI5Rb4sFqZ5D4rYmQUeb12UtH09XcHFN3I6h0vM/rzw+XVzBf/UJe8QTE+IUW2oQX9KVHQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr6175337wmb.32.1560925021122;
        Tue, 18 Jun 2019 23:17:01 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id t12sm19984430wrw.53.2019.06.18.23.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 23:17:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:16:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190619061659.GH18371@dell>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
 <ff85a907-8f26-5e80-c7f0-655ca11afe25@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff85a907-8f26-5e80-c7f0-655ca11afe25@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jun 2019, Sergei Shtylyov wrote:

> On 06/18/2019 12:57 PM, Lee Jones wrote:
> 
> [...]
> >>>>>>>> +static int rpcif_probe(struct platform_device *pdev)
> >>>>>>>> +{
> >>>>>>>> +  struct device_node *flash;
> >>>>>>>> +  const struct mfd_cell *cell;
> >>>>>>>> +  struct resource *res;
> >>>>>>>> +  void __iomem *base;
> >>>>>>>> +  struct rpcif *rpc;
> >>>>>>>> +
> >>>>>>>> +  flash = of_get_next_child(pdev->dev.of_node, NULL);
> >>>>>>>> +  if (!flash) {
> >>>>>>>> +          dev_warn(&pdev->dev, "no flash node found\n");
> >>>>>>>> +          return -ENODEV;
> >>>>>>>> +  }
> >>>>>>>> +
> >>>>>>>> +  if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> >>>>>>>> +          cell = &rpcif_spi_ctlr;
> >>>>>>>> +  } else if (of_device_is_compatible(flash, "cfi-flash")) {
> >>>>>>>> +          cell = &rpcif_hf_ctlr;
> >>>>>>>> +  } else {
> >>>>>>>> +          dev_warn(&pdev->dev, "unknown flash type\n");
> >>>>>>>> +          return -ENODEV;
> >>>>>>>> +  }
> >>>>>>>
> >>>>>>> Why not let DT choose which device to probe?
> >>>>>>
> >>>>>>    It's the DT that decides here. How else would you imagine that?
> >>>>>> It's the same hardware, just the different physical busses that it
> >>>>>> commands...
> >>>>>
> >>>>> DT is not deciding here.  This driver is deciding based on the
> >>>>> information contained in the tables - very different thing.
> >>>>>
> >>>>> Why not just let the OF framework probe the correct device i.e. let it
> >>>>> parse the 2 compatible strings and let it match the correct driver for
> >>>>> the device?
> >>>>
> >>>> The OF framework matches against the RPC-IF node, which is a single
> >>>> hardware type, hence has a fixed compatible value.
> >>>> The mode depends on the subnode in DT, which is something the OF
> >>>> framework doesn't match against, so the driver itself has to check the
> >>>> subnode's compatible value.
> >>>
> >>> I can see how it has been implemented.
> >>>
> >>> It is that which I was questioning.
> >>>
> >>>> DT describes hardware, not software (Linux subsystem boundary) policy.
> >>>
> >>> So is an RPC-IF a real hardware device.  Can you share the datasheet?
> >>
> >> Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
> >> not yet public.
> > 
> > When will it be public?
> 
>    Ask Renesas. :-)
> 
> > Do you have access to it?
> 
>    We do...
> 
> > Maybe someone who does can help with the magic number definitions.
> 
>    Not very likely. :-)
> 
> >> However, a very similar hardware block is present in the RZ/A2M SoC.
> >> Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
> >> User’s Manual: Hardware", which you can download from
> >> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents
> 
>    Also, there's RZ/A1 where a previous version of this hardware seems to be used, see chapter 17
> (SPI Multi I/O Bus Controller) of the RZ/A1H/M manual, downloadable from:
> https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz/rza/rza1h.html#documents
> 
> >   "The SPI multi I/O bus controller enables the direct connection of
> >    serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
> >    devices to this LSI chip.> 
> >    This module allows the connected serial flash, OctaFlashTM, XccelaTM
> >    flash, or HyperFlashTM memory devices to be accessed by reading the
> >    external address space, or using Manual mode to transmit and receive
> >    data."
> 
>    For contrast, RZ/A1 didn't yet support OctaFlash and HyperFlash, and R-Car gen3 RPC-IF doesn't
> support Xccella yet...
> 
> > Looks like a flash device to me.
> 
>    More like a multi-protocol flash controller, with the real flash chip connected
> to it.

Right, this has been my point from the start.

It's a flash controller.  Sure, you can access it in different ways,
but it's still *just* a flash controller and thus not a true MFD.

Surely this whole thing, including the shared portion should live in
one of the memory related subsystems?

This is not the first device people have tried to shove in MFD, that
is really *just* an <X> device, able to be controlled via different
protocols.

MFD is for registering child devices of chips which offer genuine
cross-subsystem functionality.  It is not designed for mode selecting,
or as a place to shove shared code just because a better location
doesn't appear to exist.

Also, ramming it into drivers/platform/<vendor> is not correct either,
since this is not a platform controller driver either.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
