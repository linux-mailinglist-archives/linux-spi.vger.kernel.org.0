Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F23FDF5C
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 14:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKONwg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 08:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfKONwg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Nov 2019 08:52:36 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADD22073B;
        Fri, 15 Nov 2019 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573825954;
        bh=byccjQGKDp78Hpig9iIFTYDmZ2hi5+wPX21QztoMffQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jksCRt0n9nFcU+ZExUEHHKzIWbgnbV8XdpoR7rkhnQF7ZMS5HoKM7k5PLGDMp44++
         qoEFF4fDOqnYCRvWSl5sBsoW141oAQ743jD66MGXoOROWargZKeIEkpQ4BoOMKsz0k
         QTBZmrmAK7yVvtks+VlhPdIEc6bjs6iXSZYioSso=
Received: by mail-qv1-f48.google.com with SMTP id d3so3771388qvs.11;
        Fri, 15 Nov 2019 05:52:34 -0800 (PST)
X-Gm-Message-State: APjAAAVkguIokj3sxK8IwJ/87xHXNpmKtESsZpjn/KB5RxpvHH6e4tYf
        w6xHU81FBHGGo49syK5aqFU6jiCfMy0zWLZhNA==
X-Google-Smtp-Source: APXvYqwWnpvZlkGEaU+MoyCE0QcbXaYmkR1k9FsQYEefvYoJDNpv7HxUniQpMKCZFcqXCVK++8fwMkHnwAevVKIkZj8=
X-Received: by 2002:a0c:edcc:: with SMTP id i12mr1964139qvr.20.1573825953731;
 Fri, 15 Nov 2019 05:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com> <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws> <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws> <20191114222652.GA7517@bogus> <CAKdAkRQBrKOUTW8puakA26ODYW9=0H4VhwFhGQAqMs-cMmj3CQ@mail.gmail.com>
In-Reply-To: <CAKdAkRQBrKOUTW8puakA26ODYW9=0H4VhwFhGQAqMs-cMmj3CQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Nov 2019 07:52:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com>
Message-ID: <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 14, 2019 at 5:09 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Nov 14, 2019 at 2:26 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Nov 12, 2019 at 11:36:53AM -0800, Dmitry Torokhov wrote:
> > > On Tue, Nov 12, 2019 at 07:15:47PM +0000, Mark Brown wrote:
> > > > On Tue, Nov 12, 2019 at 11:03:28AM -0800, Dmitry Torokhov wrote:
> > > > > On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> > > > > > On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:
> > > >
> > > > > > > +      interrupts:
> > > > > > > +        items:
> > > > > > > +          - description: main interrupt (attention) line.
> > > > > > > +          - description: dedicated wakeup interrupt.
> > > > > > > +        minItems: 1 # The wakeup interrupt is optional.
> > > >
> > > > > > > +      interrupt-names:
> > > > > > > +        items:
> > > > > > > +          - const: irq
> > > > > > > +          - const: wakeup
> > > > > > > +        minItems: 1
> > > >
> > > > > > How will this interact with a SPI device that defines interrupts at the
> > > > > > device level, possibly more than one of them?  Especially if the device
> > > > > > has its own idea what the interrupts should be called.
> > > >
> > > > > My understanding that individual drivers should be able to override
> > > > > whatever the default behavior core has configured, and the device can
> > > > > establish their own mapping. We have this in I2C and I believe this
> > > > > works well.
> > > >
> > > > > Is the concern about the device tree scheme or SPI core handling?
> > > >
> > > > Both really.
> > >
> > > So as I mentioned, the driver is not forced to use the interrupt
> > > supplied by the SPI core, and the worst thing is that the core
> > > configures the main IRQ as wakeirq and driver would need to call
> > > dev_pm_clear_wake_irq() before switching to correct one. I expect there
> > > will be just a few drivers needing that and many more would benefit from
> > > the default behavior and not needing to repeat the same boilerplate
> > > code.
> > >
> > > As far as scheme goes - I hope that Rob could confirm that we can
> > > override number of interrupts and names in consumers of the binding, as
> > > needed.
> >
> > This won't work. A device schema doesn't override what's defined here,
> > but just further constrains this schema.
> >
> > You could define a "spi irq" schema which devices can include if they
> > want to, but I don't think this pattern is that common to SPI devices.
> > There's not any spec behind compared to say alert irq for SMBus.
> >
> > The 'wakeup' irq name is standardized (for DT), but that's not SPI
> > specific. About all we could define there is 'wakeup-source' is boolean
> > and if there is more than one interrupt, one should be named 'wakeup'.
>
> OK, so what I am hearing is "interrupt"/"interrupt-names" properties
> should be defined in individual device's bindings, and wakeup-source
> can stay in spi-controller.yaml, right?

It could, but it's not SPI specific. I think we should convert
bindings/power/wakeup-source.txt instead. Something like this:

select: true

properties:
  wakeup-source:
    type: boolean
    description: ...

if:
  properties:
    interrupt-names:
      contains:
        const: wakeup
  required:
    - interrupt-names
then:
  required:
    - wakeup-source

dependencies:
  wakeup-source: [ interrupts ]


Rob

> And as far as SPI core goes, we can still do what I proposed, because
> we already handle "first" interrupt as the default one and the drivers
> can override as needed anyway...
>
> Thanks.
>
> --
> Dmitry
