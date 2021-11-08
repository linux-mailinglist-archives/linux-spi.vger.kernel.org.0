Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31663447DE9
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbhKHK3K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 05:29:10 -0500
Received: from foss.arm.com ([217.140.110.172]:48408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237572AbhKHK2s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Nov 2021 05:28:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 257AB1FB;
        Mon,  8 Nov 2021 02:26:01 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.58.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C89913F800;
        Mon,  8 Nov 2021 02:25:58 -0800 (PST)
Date:   Mon, 8 Nov 2021 10:25:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
Message-ID: <YYj7MA4D1zCF39lh@FVFF77S0Q05N>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-12-brad@pensando.io>
 <20211025091731.GA2001@C02TD0UTHF1T.local>
 <CAK9rFnx7DgS3TYMmu5NBacV_6WC_UwJ=u7n3e_fGd0RpEcg3kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9rFnx7DgS3TYMmu5NBacV_6WC_UwJ=u7n3e_fGd0RpEcg3kA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 04, 2021 at 03:53:13PM -0700, Brad Larson wrote:
> On Mon, Oct 25, 2021 at 2:17 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Sun, Oct 24, 2021 at 06:51:56PM -0700, Brad Larson wrote:
> > > +     timer {
> > > +             compatible = "arm,armv8-timer";
> > > +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
> > > +                                     IRQ_TYPE_LEVEL_LOW)>,
> > > +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
> > > +                                     IRQ_TYPE_LEVEL_LOW)>,
> > > +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
> > > +                                     IRQ_TYPE_LEVEL_LOW)>,
> > > +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
> > > +                                     IRQ_TYPE_LEVEL_LOW)>;
> > > +     };
> >
> > The GIC_CPU_MASK_SIMPLE() stuff is meant for GICv2, but as below you
> > have GICv3, where this is not valid, so this should go.
> >
> > Also, beware that GIC_CPU_MASK_SIMPLE(1) means a single CPU, which
> > doesn't mak sense for the 16 CPUs you have.
> >
> 
> Thanks for pointing this out.  Elba SoC is a GICv3 implementation and looking
> at other device tree files we should be using this:
> 
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(16) |
>                                         IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(16) |
>                                         IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(16) |
>                                         IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(16) |
>                                         IRQ_TYPE_LEVEL_LOW)>;
>         };

No; as above, you should *not* use GIC_CPU_MASK_SIMPLE() at all for GICv3. i.e.

>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>                              <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>                              <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>                              <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>         };

Please see the GICv3 binding documentation:

  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml

... and note that it does not have the cpumask field as use by the binding for
prior generations of GIC:

  Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml


If you've seen other dts files using GIC_CPU_MASK_SIMPLE() with GICv3, those
are incorrect, and need to be fixed.

Thanks,
Mark.
