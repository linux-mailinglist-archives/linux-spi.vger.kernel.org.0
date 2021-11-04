Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E233A445C6D
	for <lists+linux-spi@lfdr.de>; Thu,  4 Nov 2021 23:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhKDW4G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Nov 2021 18:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhKDW4E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Nov 2021 18:56:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D163C06120A
        for <linux-spi@vger.kernel.org>; Thu,  4 Nov 2021 15:53:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b15so7401865edd.7
        for <linux-spi@vger.kernel.org>; Thu, 04 Nov 2021 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaaNOGobytyErlzeuWKHVMN+JarWlcxJWqZAgz0U4Ac=;
        b=FlDR1CIlE6iRQnoU9OBH1RPrCi8GzrhNWlj5EC+Gthsht2PmwwAxK16cLula+lgUPs
         HOI/5cwUZAWe7lQVsc2+ydn3+DIrEiblam9I9N3nf2gypDgJfzSNZUMs8t2sFXv5a00G
         P9yaDiisNl5dxds3OnAz3aysPkEnhpFd1qZqirqO7wN9hgfOtG3sanlPhY/EX3YJWB2a
         l2dVkbCnPpQddHFc8namR2MuSEXffsyLyDIbbl+XJh8sS+etmHrnUFliTGK7r2JUjG7X
         eRCWK35JXuzREcuuesNh3s2soD3NCib6F2QgnT+bjkyI1xtoXTMSccyr0ClCkhgCCk4/
         1PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaaNOGobytyErlzeuWKHVMN+JarWlcxJWqZAgz0U4Ac=;
        b=FM2x7qJ6968RBv3F4AGTGf4FDmOuPDX5Z9pEPGSL3HykCBIZ/3ElN6Qr8CUXvxV45w
         oZLJ/vz76xdmvYdbspADMS9pEwUkIil90GnfSpS6oPbBxIdjM0zAt6cakR4EPD/9SBHb
         4QqHEr8s6KDMb6Fs6rYpZCyg4BupXYKPCwxoJ/ixZAByMc+YzbamgG1GQOTcOYAp0v5v
         GwpZSi4VaNi5eoTb75ZPjMVax2TXysjXH88kzQJIdk6P9G7DGBo5HXeVWA4PzrzC4lmu
         wbWabKsb4hQd8G7nTCG7YNo26EKXlWuRaThDyE67sY5uP2iymJbTJkuS3aKHaO+ZL6eF
         rjNw==
X-Gm-Message-State: AOAM532ufR6UZetcVd/1xVmyXVD83H2hzi3a2jJCQ/pHIqi7XEL9+L8t
        L2q/PWimt1CPbLrR2pWV/lN6JxlKu5OE3cvigi+G+A==
X-Google-Smtp-Source: ABdhPJzUrnvUCW/c69Ez93sR4uzeVeBsL/wv91s5v5bUJWtKFABC5QThvyqPWPpbeJXV+eImBVpvq8PzbROnddUV+80=
X-Received: by 2002:a17:906:a3c4:: with SMTP id ca4mr64446282ejb.529.1636066404493;
 Thu, 04 Nov 2021 15:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-12-brad@pensando.io>
 <20211025091731.GA2001@C02TD0UTHF1T.local>
In-Reply-To: <20211025091731.GA2001@C02TD0UTHF1T.local>
From:   Brad Larson <brad@pensando.io>
Date:   Thu, 4 Nov 2021 15:53:13 -0700
Message-ID: <CAK9rFnx7DgS3TYMmu5NBacV_6WC_UwJ=u7n3e_fGd0RpEcg3kA@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
To:     Mark Rutland <mark.rutland@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Mon, Oct 25, 2021 at 2:17 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> On Sun, Oct 24, 2021 at 06:51:56PM -0700, Brad Larson wrote:
> > Add Pensando common and Elba SoC specific device nodes
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
>
> [...]
>
> > +     timer {
> > +             compatible = "arm,armv8-timer";
> > +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
> > +                                     IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
> > +                                     IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
> > +                                     IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
> > +                                     IRQ_TYPE_LEVEL_LOW)>;
> > +     };
>
> The GIC_CPU_MASK_SIMPLE() stuff is meant for GICv2, but as below you
> have GICv3, where this is not valid, so this should go.
>
> Also, beware that GIC_CPU_MASK_SIMPLE(1) means a single CPU, which
> doesn't mak sense for the 16 CPUs you have.
>

Thanks for pointing this out.  Elba SoC is a GICv3 implementation and looking
at other device tree files we should be using this:

        timer {
                compatible = "arm,armv8-timer";
                interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(16) |
                                        IRQ_TYPE_LEVEL_LOW)>,
                             <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(16) |
                                        IRQ_TYPE_LEVEL_LOW)>,
                             <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(16) |
                                        IRQ_TYPE_LEVEL_LOW)>,
                             <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(16) |
                                        IRQ_TYPE_LEVEL_LOW)>;
        };

> > +             gic: interrupt-controller@800000 {
> > +                     compatible = "arm,gic-v3";
> > +                     #interrupt-cells = <3>;
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +                     ranges;
> > +                     interrupt-controller;
> > +                     reg = <0x0 0x800000 0x0 0x200000>,      /* GICD */
> > +                           <0x0 0xa00000 0x0 0x200000>;      /* GICR */
> > +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     gic_its: msi-controller@820000 {
> > +                             compatible = "arm,gic-v3-its";
> > +                             msi-controller;
> > +                             #msi-cells = <1>;
> > +                             reg = <0x0 0x820000 0x0 0x10000>;
> > +                             socionext,synquacer-pre-its =
> > +                                                     <0xc00000 0x1000000>;
> > +                     };
> > +             };
>
> Is there any shared lineage with Synquacer? The commit message didn't
> describe this quirk.

There is no shared lineage with Synqacer.  We are solving the same issue
with the same mechanism.  I'll add a comment to this DTS node.

Thanks,
Brad
