Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B2F99D8
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 20:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKLTg5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 14:36:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47069 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTg4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 14:36:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so12478031pgu.13;
        Tue, 12 Nov 2019 11:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+1dTgLU8V2gPUJMDs5EGQtQwfTApnkprfC/+aKilzwY=;
        b=CuzbeNQQG3AwYDek9KhARHCvyYAMmNx8O5hxsZ3M/H5ueuVzHucOFo9LAeZYMhgZuG
         aJ43LJzjLFuGJ3ou5WMOwv4hwl4Jn69BIBhJUjPI0f33cKS6l5kAcE/wnrhKqdW2vy4s
         dA5pRetFGcoNBxubMmfktqz2CNUBHLoak0k1w6+5a5eKXwctNzsfDjxzYHjpiYPlG1Wn
         yIHSAA3iXNP8OyqAo4ZkfJymxFXnyEuyX5/V4YCCk+r3fJW25MG4KDIjgi3eIAACONwu
         FnAAkRTk8Hv8Vc8hOaDwGYMsqtcGzIA1VUhcV/DPUZcrNNq2hJnyZx4Tw4GShayZ9iu9
         A8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1dTgLU8V2gPUJMDs5EGQtQwfTApnkprfC/+aKilzwY=;
        b=FPdUBu7ugipzSbE1S0DXFRdccgGT546PRAoINEME1WRClR8rHUtkeVr5/YazgcM4Uc
         mEfsq0MqdejjQ4ixenFKysBDNoqAXx4QlN6/0364vmWCzhG+yy99nt1Tm5G8752APesr
         Vz/RAfh21eMLsBEnh5XnTt6o/GMDtvCZt1mlETKiLXEkgUOwBRPwqYsjWGYA51Z3Mpr9
         ccEtAsF9rPpdbf2+u9esMlX/xg7htpcnXj3d6skBnjeiT1/uE2/odNq+sNO3X1tYjJPq
         FontIzYt6072+t/SgruDwKPcR2o3PYmia11/tO1NJjN/BaKOcdIwf7ary74G/4blBI3c
         v2ew==
X-Gm-Message-State: APjAAAUa2FHhMGzI2gctc5uMKH1vTybJhYD8AJN60iC5p/YYfKKNOxQ5
        9kIoY34TPu++YBt53DScNjU=
X-Google-Smtp-Source: APXvYqwzmAo4XyJWd+jODvfeIfuwtnC+T2Iok6kDQb4qyr14s922L+cDyn5b05cgADryqeUP3+KRRA==
X-Received: by 2002:a63:6483:: with SMTP id y125mr37445468pgb.444.1573587415684;
        Tue, 12 Nov 2019 11:36:55 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g3sm19003956pfo.82.2019.11.12.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:36:55 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:36:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Message-ID: <20191112193653.GB13374@dtor-ws>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
 <20191112191547.GK5195@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112191547.GK5195@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 12, 2019 at 07:15:47PM +0000, Mark Brown wrote:
> On Tue, Nov 12, 2019 at 11:03:28AM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> > > On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:
> 
> > > > +      interrupts:
> > > > +        items:
> > > > +          - description: main interrupt (attention) line.
> > > > +          - description: dedicated wakeup interrupt.
> > > > +        minItems: 1 # The wakeup interrupt is optional.
> 
> > > > +      interrupt-names:
> > > > +        items:
> > > > +          - const: irq
> > > > +          - const: wakeup
> > > > +        minItems: 1
> 
> > > How will this interact with a SPI device that defines interrupts at the
> > > device level, possibly more than one of them?  Especially if the device
> > > has its own idea what the interrupts should be called.
> 
> > My understanding that individual drivers should be able to override
> > whatever the default behavior core has configured, and the device can
> > establish their own mapping. We have this in I2C and I believe this
> > works well.
> 
> > Is the concern about the device tree scheme or SPI core handling?
> 
> Both really.

So as I mentioned, the driver is not forced to use the interrupt
supplied by the SPI core, and the worst thing is that the core
configures the main IRQ as wakeirq and driver would need to call
dev_pm_clear_wake_irq() before switching to correct one. I expect there
will be just a few drivers needing that and many more would benefit from
the default behavior and not needing to repeat the same boilerplate
code.

As far as scheme goes - I hope that Rob could confirm that we can
override number of interrupts and names in consumers of the binding, as
needed.

-- 
Dmitry
