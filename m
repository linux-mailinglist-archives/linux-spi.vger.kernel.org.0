Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56541449C8E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 20:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhKHTiM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 14:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbhKHTiM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 14:38:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B27C061764
        for <linux-spi@vger.kernel.org>; Mon,  8 Nov 2021 11:35:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so67400388edd.10
        for <linux-spi@vger.kernel.org>; Mon, 08 Nov 2021 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/MR0vqbYTkAsYuLNAb29468NBKY3mHo6iVJJTJx4h0=;
        b=eH34PqDe6uY4jqBZvuGAv4uNlpzvYcOVNa+yRh0IxFWZ1+GwXQO3Nq6sdkn6AwMr66
         Ob+7tJckDHQ+VOwnmEeh80RE3zHnAN6dJJIeMB7LpesL9hvdGCZ2Tx/qgZRB3THQHLbw
         oBoRUsdOoupzBgR6+wAiZXO/ztOh0Yfnt8p1N3O7XaRt0Mkwhy2sBqk4i6k0bAGZ95dx
         c3Yq+9Uz+EXC0pC8+vFZm19F3wTiMKSvEMy+A/5zfM5vBbULOrzQU8PN7idtAW0qUqSZ
         MmNAaBNXfK3aN4Gk0R4FvG4b8nUi7x6YGy4BYP/sumJP31Lhf9oB9eyUDZFuA6nrokBu
         MY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/MR0vqbYTkAsYuLNAb29468NBKY3mHo6iVJJTJx4h0=;
        b=yt+Flc9iq/euunXGgwIWL9X1O9jOG0XPVMcTBCcIfMXne6aXIEPEOexYFRCkNrzjcE
         uaFDo0u2M1JAM2ZSpcPkdcVoD/R1dKywIxP/l2cWN0Zax9edaAgmc8DsZZWWd1CZBdJL
         sOVHppXHxXco2CdovzVUt20zBacHRuTLdohmTFEelHpezzUHzfYrjOGglkl2bjB7R2Bo
         frie+I+Wanpw4CwXDj5yh5vp/uwPywHDhgoTxmUsS+IlLIj7bOg+OEZRtRkU1Kb6aqYY
         WAr0I7t25XCaUzFTDd+tzhoO6YBYp2ooB19N+xYyCztzE6qEDqh/U5W6qiMYcEb+jKqW
         aXvA==
X-Gm-Message-State: AOAM533CtbvK2m5dICrJPBsDbhR1dJOiBoLenmRO+mJ4wFm3ZI9hzf6Y
        ZPikMIEekd1b42sp6RbLBqwBFBvbFjHjcewAFBaLlw==
X-Google-Smtp-Source: ABdhPJwpaoKAhf7YBb+13Nn+Kx8crS+r3pHNmhs/IkckIQ1sUmJKNxXCpW8CIp7Ll4JNzOB6vtAZ1z8y699gDaYjS1U=
X-Received: by 2002:a17:907:2d20:: with SMTP id gs32mr2084348ejc.270.1636400125691;
 Mon, 08 Nov 2021 11:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-12-brad@pensando.io>
 <20211025091731.GA2001@C02TD0UTHF1T.local> <a20805de16e1196c2ed46dd949473c9a@kernel.org>
 <CAK9rFnxH=DtC9vEJJCXkGEWjvg2E8vHPUcRy9rJpo34Furtmvw@mail.gmail.com> <87zgqi96nh.wl-maz@kernel.org>
In-Reply-To: <87zgqi96nh.wl-maz@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 8 Nov 2021 11:35:14 -0800
Message-ID: <CAK9rFnz6X3wR6bMPkVicGoqj+prm5OmY3y3B_8Fc+WGJxcVsXA@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Fri, Nov 5, 2021 at 4:35 AM Marc Zyngier <maz@kernel.org> wrote:
>
> > > >> +                    interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > > >> +
> > > >> +                    gic_its: msi-controller@820000 {
> > > >> +                            compatible = "arm,gic-v3-its";
> > > >> +                            msi-controller;
> > > >> +                            #msi-cells = <1>;
> > > >> +                            reg = <0x0 0x820000 0x0 0x10000>;
> > > >> +                            socionext,synquacer-pre-its =
> > > >> +                                                    <0xc00000 0x1000000>;
> > > >> +                    };
> > > >> +            };
> > > >
> > > > Is there any shared lineage with Synquacer? The commit message didn't
> > > > describe this quirk.
> > >
> > > Funny, it looks like there is a sudden outburst of stupid copy/paste
> > > among HW designers. TI did the exact same thing recently.
> > >
> > > This totally negates all the advantages of having an ITS and makes
> > > sure that you have all the overhead. Facepalm...
> >
> > Some background may help explain.  To generate an LPI a peripheral must
> > write to the GITS_TRANSLATER (a specific address). For the ITS to know
> > which translations apply to the generated interrupts, it must know which
> > peripheral performed the write. The ID of the peripheral is known as its
> > DeviceID, which is often carried along with the write as an AXI sideband
> > signal.
>
> Yes, I happen to be vaguely familiar with the GIC architecture.
>
> > The Elba SoC doesn't carry the DeviceID, so we have to conjure one up
> > between the peripheral and the ITS.  Instead of telling a peripheral to target
> > the GITS_TRANSLATER directly, we instead direct it to a specific offset
> > within a pre-ITS address range (our own IP block).  For writes that land in
> > that memory range, we derive the DeviceID from (offset >> 2).  The pre-ITS
> > block then sends (DeviceID, data) to the GITS_TRANSLATER.
> >
> > The hardware designer came up with the Pre-ITS mechanism in Feb 2018.
> > When we looked at the upstream kernel later (we developed on 4.14)
> > we found that not only did it support something similar, it supported the
> > exact scheme we are using.
>
> And this scheme is totally wrong. It breaks interrupt isolation.
>
> Instead of having a single doorbell and getting the ITS to segregate
> between devices itself, you end-up with multiple ones, allowing a
> rogue device to impersonate another one by targeting another doorbell.
> You can't even use an SMMU to preserve some isolation, because all the
> doorbells are in the *same page*. Unmitigated disaster.
>
> At this stage, why did you bother having an ITS at all? You get none
> of the security features. Only the excess area, memory allocation,
> additional latency and complexity. All you get is a larger INTID
> space.
>
> This only shows that the hardware designer didn't understand the ITS
> at all. Which seems a common pattern, unfortunately.

The Elba SoC is an embedded chip and not intended as a SBSA-compliant
general platform.  In this implementation the ITS is used to provide
message-based interrupts for our (potentially large set) of hardware
based platform device instances.  Virtualization is not a consideration.
We don't have a SMMU.  Interrupt isolation isn't a practical consideration
for this product.  Propose adding a comment to the dts.

+                       /*
+                        * Elba SoC implemented a pre-ITS that happened to
+                        * be the same implementation as synquacer.
+                        */
                        its: interrupt-controller@820000 {
                                compatible = "arm,gic-v3-its";
                                msi-controller;

Thanks
Brad
