Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EEAFD155
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 00:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNXJJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Nov 2019 18:09:09 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42546 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNXJI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Nov 2019 18:09:08 -0500
Received: by mail-il1-f196.google.com with SMTP id n18so6995575ilt.9;
        Thu, 14 Nov 2019 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+ZSU/anVETJxDtIO+tJlt7OeoRyRDm1nl7XDr1Osps=;
        b=Zcddy4m/9nwvl3i1c0CdByq4GvKc02waL58snhLIPrYHpDJfVu7dJ8eAJRxCOfsSaP
         JDAOi1EFjUENiX2uc66oO7nr6cDFUdO8W6J6ZA977u6+GKPnoWzxATzh4FUK4731nzz2
         Zytsvymc+nOBEJf0N2SZ6saxSqUW2m+clVZD3SOzRHNOe/T/1nESVksNBpz4xHy7qKoR
         R8qNAz5RTQddaka3LDp2P/U9LRvKwry9XkCPH8mwuUCU2fEtSyTl9vOLSWv9Qo4x3UJD
         IsG8qG0eF2s52ZGcXBJvnSKLKQ9woQjXDBylwhCaNTM1aY8WD3WHQo+6eBgQII7sosOa
         pV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+ZSU/anVETJxDtIO+tJlt7OeoRyRDm1nl7XDr1Osps=;
        b=U0/eKkh5grmdWkcdEA/y/qKFCSTJY2ac5F//KrveDEIVjgqyuEcQ6SaUhiaFnLgQe4
         E+vyWsVzG9n8E8Ake7Ys3KeQWVYuz9YBGSDSi3MYqcSbqNpIJt7/a1s7bmK5623xjam4
         /g6vTiqA8x5GjTX1+y/Q+yvOcL86P53T3AYiT56/3XpuPa148rc5w7isgk0N+8KtkYll
         z7oyHfkRJVWCHuIq/D9vxMQM5qF6IPc/aDpra4x1NOoQC8sJDJouMa+In9nusrdex/sY
         sF5b6VBkzbD/uFtQoomZSePTLfS+yE5w7q+Z5M3kq9giCoCw4L3rSFLZ45dOWyz/ZXDj
         TSeA==
X-Gm-Message-State: APjAAAW+tMWgegvcZkmbiziJYohsMM2VqMrobAYX9bRbQogwz6xtcWr1
        94oozcQmJ2by6EffcjsNv3hA8F9lkChjkkJRGCw=
X-Google-Smtp-Source: APXvYqyYvoeU2pvH/llzhsbCSX/Z/jehjr4vrHK+EDflCWW58RqtMvmmhhpT1iQezdc9WgIfR/sQO642qa/Ar5q8LgQ=
X-Received: by 2002:a02:ac0a:: with SMTP id a10mr10294488jao.53.1573772945552;
 Thu, 14 Nov 2019 15:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com> <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws> <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws> <20191114222652.GA7517@bogus>
In-Reply-To: <20191114222652.GA7517@bogus>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 14 Nov 2019 15:08:54 -0800
Message-ID: <CAKdAkRQBrKOUTW8puakA26ODYW9=0H4VhwFhGQAqMs-cMmj3CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
To:     Rob Herring <robh@kernel.org>
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

On Thu, Nov 14, 2019 at 2:26 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 12, 2019 at 11:36:53AM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 12, 2019 at 07:15:47PM +0000, Mark Brown wrote:
> > > On Tue, Nov 12, 2019 at 11:03:28AM -0800, Dmitry Torokhov wrote:
> > > > On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> > > > > On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:
> > >
> > > > > > +      interrupts:
> > > > > > +        items:
> > > > > > +          - description: main interrupt (attention) line.
> > > > > > +          - description: dedicated wakeup interrupt.
> > > > > > +        minItems: 1 # The wakeup interrupt is optional.
> > >
> > > > > > +      interrupt-names:
> > > > > > +        items:
> > > > > > +          - const: irq
> > > > > > +          - const: wakeup
> > > > > > +        minItems: 1
> > >
> > > > > How will this interact with a SPI device that defines interrupts at the
> > > > > device level, possibly more than one of them?  Especially if the device
> > > > > has its own idea what the interrupts should be called.
> > >
> > > > My understanding that individual drivers should be able to override
> > > > whatever the default behavior core has configured, and the device can
> > > > establish their own mapping. We have this in I2C and I believe this
> > > > works well.
> > >
> > > > Is the concern about the device tree scheme or SPI core handling?
> > >
> > > Both really.
> >
> > So as I mentioned, the driver is not forced to use the interrupt
> > supplied by the SPI core, and the worst thing is that the core
> > configures the main IRQ as wakeirq and driver would need to call
> > dev_pm_clear_wake_irq() before switching to correct one. I expect there
> > will be just a few drivers needing that and many more would benefit from
> > the default behavior and not needing to repeat the same boilerplate
> > code.
> >
> > As far as scheme goes - I hope that Rob could confirm that we can
> > override number of interrupts and names in consumers of the binding, as
> > needed.
>
> This won't work. A device schema doesn't override what's defined here,
> but just further constrains this schema.
>
> You could define a "spi irq" schema which devices can include if they
> want to, but I don't think this pattern is that common to SPI devices.
> There's not any spec behind compared to say alert irq for SMBus.
>
> The 'wakeup' irq name is standardized (for DT), but that's not SPI
> specific. About all we could define there is 'wakeup-source' is boolean
> and if there is more than one interrupt, one should be named 'wakeup'.

OK, so what I am hearing is "interrupt"/"interrupt-names" properties
should be defined in individual device's bindings, and wakeup-source
can stay in spi-controller.yaml, right?

And as far as SPI core goes, we can still do what I proposed, because
we already handle "first" interrupt as the default one and the drivers
can override as needed anyway...

Thanks.

-- 
Dmitry
