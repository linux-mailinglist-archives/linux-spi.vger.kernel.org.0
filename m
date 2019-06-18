Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919B949DE1
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfFRJ5q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 05:57:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfFRJ5q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 05:57:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so13270980wru.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/4mKWlKI1onk2lF+5AnQRsNwS3VzSXi5a7YyVS4qLbE=;
        b=URyU1G941Y1nHkTJ+3zBm9a51791YQB2ZsYmqA6qylWZKNPxpiFTZ7qEb0rsR7SlV6
         YoQGKb/+14SQUs97fBdZUXQFLVTkXXFdkkVPeKl7HZUF21vJKJpKNhvQQ2emHZcQyKXv
         U5wNPNuzP0e7PnW6PjCQ+vg3g76C4Ns9CS3qrl+vlmX3B3HfU0xPwNEZeQREe3PZvblE
         AZeMq5OppnviWCsXPW13LbxzV/BNV+7I9QXr8q9ACFFlwb/rJoftKcXrsghLt7lS0nAN
         ObeFrGcMHXw07Z1U5HhRYICxKLihEcqHiZSqYSGlLQiU46Bx2wAPY9dUj6iuLwLGElAA
         5bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/4mKWlKI1onk2lF+5AnQRsNwS3VzSXi5a7YyVS4qLbE=;
        b=qnNS4Y2gesoUpwOaaEZok8UQ0w6ka+bplPs03wreJZ/EyV5TC27kSzdjkC/RzPJWJI
         mmnK7T+4R/t/vMWdwUURPiBkLodpozhex7/VfEWno6VL6OUfl7MxjxkH6HhwPuCu9lPp
         z9v9T1UwNdg3s128PpcbPPzLYcDdusCzJeWWHJVsTVv0l2X6fTd4SNAdKQl+hIPV+zj1
         LNtHoxFE7sNzccNT316iJnYvSOYkYNnPVD9YuS9v57BRWtxCq/RHP0Wy4OJnX6hvnod4
         2iXEYDUwvrM3F4Yi+orvpNTmpScYZISlFoST9hqVTi7Ws0jFU8Jx8ZV3eNkDIbvnU976
         O91A==
X-Gm-Message-State: APjAAAXe8Qg29wK9lu2BbHHMlyoWM234aSiBeGYA4OeNUrefhfO5bKhc
        zZLp3tGnRd1E6GzPnR0leUfjzw==
X-Google-Smtp-Source: APXvYqzLfny/4uG1hUmvpubyqm69drL36o5ttBGXgBLLdcilG3V7M78KeEaNbssHbdekbaIQXvU+jQ==
X-Received: by 2002:adf:9003:: with SMTP id h3mr2273513wrh.172.1560851863511;
        Tue, 18 Jun 2019 02:57:43 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id q20sm32952614wra.36.2019.06.18.02.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 02:57:42 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:57:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190618095741.GA18371@dell>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jun 2019, Geert Uytterhoeven wrote:
> On Tue, Jun 18, 2019 at 11:20 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 18 Jun 2019, Geert Uytterhoeven wrote:
> > > On Mon, Jun 17, 2019 at 11:31 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Fri, 14 Jun 2019, Sergei Shtylyov wrote:
> > > > > On 06/12/2019 12:05 PM, Lee Jones wrote:
> > > > > >> +static const struct mfd_cell rpcif_hf_ctlr = {
> > > > > >> +  .name = "rpcif-hyperflash",
> > > > > >> +};
> > > > > >> +
> > > > > >> +static const struct mfd_cell rpcif_spi_ctlr = {
> > > > > >> +  .name = "rpcif-spi",
> > > > > >> +};
> > > > > >
> > > > > > This looks like a very tenuous use of the MFD API.
> > > > > >
> > > > > > I suggest that this isn't actually an MFD at all.
> > > > >
> > > > >    The same hardware supports 2 different physical interfaces, hence
> > > > > the drivers have to comply to 2 different driver frameworks... sounded
> > > > > like MFD to me. :-)
> > > >
> > > > Not to me.
> > > >
> > > > This appears to be some kind of 'mode selector' for an MTD device.
> > >
> > > ... for either an SPI or MTD device.
> >
> > Okay, so I think I misunderstood the device.  I was under the
> > impression that it was a flash memory device where the only difference
> > was the interface by which it is controlled?
> >
> > > > Lots of drivers have multiple ways to control them - they are not all
> > > > MFDs.
> > >
> > > So where to reside the common part? drivers/platform/renesas/?
> >
> > That does not make sense, since this is not a platform controller.
> >
> > > > > [...]
> > > > > >> +static int rpcif_probe(struct platform_device *pdev)
> > > > > >> +{
> > > > > >> +  struct device_node *flash;
> > > > > >> +  const struct mfd_cell *cell;
> > > > > >> +  struct resource *res;
> > > > > >> +  void __iomem *base;
> > > > > >> +  struct rpcif *rpc;
> > > > > >> +
> > > > > >> +  flash = of_get_next_child(pdev->dev.of_node, NULL);
> > > > > >> +  if (!flash) {
> > > > > >> +          dev_warn(&pdev->dev, "no flash node found\n");
> > > > > >> +          return -ENODEV;
> > > > > >> +  }
> > > > > >> +
> > > > > >> +  if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> > > > > >> +          cell = &rpcif_spi_ctlr;
> > > > > >> +  } else if (of_device_is_compatible(flash, "cfi-flash")) {
> > > > > >> +          cell = &rpcif_hf_ctlr;
> > > > > >> +  } else {
> > > > > >> +          dev_warn(&pdev->dev, "unknown flash type\n");
> > > > > >> +          return -ENODEV;
> > > > > >> +  }
> > > > > >
> > > > > > Why not let DT choose which device to probe?
> > > > >
> > > > >    It's the DT that decides here. How else would you imagine that?
> > > > > It's the same hardware, just the different physical busses that it
> > > > > commands...
> > > >
> > > > DT is not deciding here.  This driver is deciding based on the
> > > > information contained in the tables - very different thing.
> > > >
> > > > Why not just let the OF framework probe the correct device i.e. let it
> > > > parse the 2 compatible strings and let it match the correct driver for
> > > > the device?
> > >
> > > The OF framework matches against the RPC-IF node, which is a single
> > > hardware type, hence has a fixed compatible value.
> > > The mode depends on the subnode in DT, which is something the OF
> > > framework doesn't match against, so the driver itself has to check the
> > > subnode's compatible value.
> >
> > I can see how it has been implemented.
> >
> > It is that which I was questioning.
> >
> > > DT describes hardware, not software (Linux subsystem boundary) policy.
> >
> > So is an RPC-IF a real hardware device.  Can you share the datasheet?
> 
> Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
> not yet public.

When will it be public?

Do you have access to it?

Maybe someone who does can help with the magic number definitions.

> However, a very similar hardware block is present in the RZ/A2M SoC.
> Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
> User’s Manual: Hardware", which you can download from
> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents

  "The SPI multi I/O bus controller enables the direct connection of
   serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
   devices to this LSI chip.

   This module allows the connected serial flash, OctaFlashTM, XccelaTM
   flash, or HyperFlashTM memory devices to be accessed by reading the
   external address space, or using Manual mode to transmit and receive
   data."

Looks like a flash device to me.

Can the SPI portion be used to connect generic SPI devices?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
