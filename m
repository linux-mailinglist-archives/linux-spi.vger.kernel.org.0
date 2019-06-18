Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97EF49CF4
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfFRJUC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 05:20:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36407 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfFRJUC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 05:20:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so2388589wmm.1
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Wk2ZxBdWWs+8+9M3L02bVXb3ZODNcxuc6cqePHkBEzA=;
        b=uo5y159K4gqOnqV7KMvCGjn+E5v2DjLwpSxX/hg1ejwE2bYwXryspD0iVk5ooT79nI
         pfum2BCMrUsxHOJfFAOElWj/2gE8J1l6iC+8kz/OVzxYrut82TszfxjuDi6bthCJFKvS
         2iL+kFeu82W/QWKlMgGt8PD2Vxf5dAG0vqCozJMZnQL88XuU0iwlgrZMLvGdBWz4kxqQ
         OYeCN6VoNG4tGRZmFgHizkqAFOn4Md+Wk9GNF1Fq9PtCUEkFQjyR+qbhZXF/pAOFm1uf
         Stj83QuyuZTZWFJVhybuJ9GubrOvX6/2UjOsA8Dh80zSoYD0NAmZGS9zVFs7HBcRXGbG
         gEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wk2ZxBdWWs+8+9M3L02bVXb3ZODNcxuc6cqePHkBEzA=;
        b=N624a5vbbjmGtC6vYfMNeoF3H9M9zWSzLP8pQZgp/hpC/Ltp794Sx1piNg7crynOI2
         oXUk4phLNO1Kf0LaxxJMhfwvXHweOkEsZnmnQlgh0J0r3BG54XU+ywo9Wuw1ZxVfVf1p
         G1q8bJmiQCpsC+lX57/TUQNB5kfAE89Op0/WHAuP1PUs2lykehMPmVn/OWBn7FVpirJx
         zlhqc7SRsAqIYwFZlKyFOtpTOPVDhuZaHXUFiSCmFyjIkyRlPPm/dBnfHCLjbFEvb/PR
         yxuPxrd/QQhZwIL2icPmC270pVb+OJD8GhHY8HgeYiCpJBdCP3DAa/Sopyn7vL7UbgEt
         IhsQ==
X-Gm-Message-State: APjAAAWHJUH7BPAjEUdr/jYmJKgfyefxVwaz0SgzJ8OJrRqO0aLV4EWB
        I1y4nmqHpUD+3h9RGnMsnhiEKg==
X-Google-Smtp-Source: APXvYqwknAmaQoxlx3XN+Yzg3zCLojpdm0JMrqO7D4ZVE0XWhiFsyQq4RONmQcBkE7NRKiRp/Kpajw==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr2451553wmc.34.1560849599280;
        Tue, 18 Jun 2019 02:19:59 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id t63sm2171490wmt.6.2019.06.18.02.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 02:19:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:19:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190618091955.GN16364@dell>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jun 2019, Geert Uytterhoeven wrote:
> On Mon, Jun 17, 2019 at 11:31 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 14 Jun 2019, Sergei Shtylyov wrote:
> > > On 06/12/2019 12:05 PM, Lee Jones wrote:
> > > >> +static const struct mfd_cell rpcif_hf_ctlr = {
> > > >> +  .name = "rpcif-hyperflash",
> > > >> +};
> > > >> +
> > > >> +static const struct mfd_cell rpcif_spi_ctlr = {
> > > >> +  .name = "rpcif-spi",
> > > >> +};
> > > >
> > > > This looks like a very tenuous use of the MFD API.
> > > >
> > > > I suggest that this isn't actually an MFD at all.
> > >
> > >    The same hardware supports 2 different physical interfaces, hence
> > > the drivers have to comply to 2 different driver frameworks... sounded
> > > like MFD to me. :-)
> >
> > Not to me.
> >
> > This appears to be some kind of 'mode selector' for an MTD device.
> 
> ... for either an SPI or MTD device.

Okay, so I think I misunderstood the device.  I was under the
impression that it was a flash memory device where the only difference
was the interface by which it is controlled?

> > Lots of drivers have multiple ways to control them - they are not all
> > MFDs.
> 
> So where to reside the common part? drivers/platform/renesas/?

That does not make sense, since this is not a platform controller.

> > > [...]
> > > >> +static int rpcif_probe(struct platform_device *pdev)
> > > >> +{
> > > >> +  struct device_node *flash;
> > > >> +  const struct mfd_cell *cell;
> > > >> +  struct resource *res;
> > > >> +  void __iomem *base;
> > > >> +  struct rpcif *rpc;
> > > >> +
> > > >> +  flash = of_get_next_child(pdev->dev.of_node, NULL);
> > > >> +  if (!flash) {
> > > >> +          dev_warn(&pdev->dev, "no flash node found\n");
> > > >> +          return -ENODEV;
> > > >> +  }
> > > >> +
> > > >> +  if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> > > >> +          cell = &rpcif_spi_ctlr;
> > > >> +  } else if (of_device_is_compatible(flash, "cfi-flash")) {
> > > >> +          cell = &rpcif_hf_ctlr;
> > > >> +  } else {
> > > >> +          dev_warn(&pdev->dev, "unknown flash type\n");
> > > >> +          return -ENODEV;
> > > >> +  }
> > > >
> > > > Why not let DT choose which device to probe?
> > >
> > >    It's the DT that decides here. How else would you imagine that?
> > > It's the same hardware, just the different physical busses that it
> > > commands...
> >
> > DT is not deciding here.  This driver is deciding based on the
> > information contained in the tables - very different thing.
> >
> > Why not just let the OF framework probe the correct device i.e. let it
> > parse the 2 compatible strings and let it match the correct driver for
> > the device?
> 
> The OF framework matches against the RPC-IF node, which is a single
> hardware type, hence has a fixed compatible value.
> The mode depends on the subnode in DT, which is something the OF
> framework doesn't match against, so the driver itself has to check the
> subnode's compatible value.

I can see how it has been implemented.

It is that which I was questioning.

> DT describes hardware, not software (Linux subsystem boundary) policy.

So is an RPC-IF a real hardware device.  Can you share the datasheet?

> I think you could have two drivers (SPI and MFD) each matching against
> the same compatible value, with .probe() functions returning -ENODEV

No, don't do that.

> if the subnode doesn't have the appropriate compatible value.
> However, (1) I don't know how well that would play with module
> autoloading based on of_device_id, and (2) that still leaves the question
> where to put the shared code.

Other than the SPI driver in this set (which I have now looked at),
what else uses the MFD "back-end"?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
