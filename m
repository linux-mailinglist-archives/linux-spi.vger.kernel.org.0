Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C598445CE4
	for <lists+linux-spi@lfdr.de>; Fri,  5 Nov 2021 01:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhKEAFE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Nov 2021 20:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhKEAFA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Nov 2021 20:05:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A8C061714
        for <linux-spi@vger.kernel.org>; Thu,  4 Nov 2021 17:02:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c8so10410445ede.13
        for <linux-spi@vger.kernel.org>; Thu, 04 Nov 2021 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOphd7Vw+yHC8lqA1EFBT5Der5nQd77Uyr9RS3TE3vY=;
        b=ojAFxlvXXrY1p/+SCZHNI7vZKCcculw8iwC2NB/OnEXmwSfS5TMU8io5BA6UvqotV6
         Lu0brpWxP9c61Un72pLgyWZ3YQYH1VCkWP44lc5QdKl7kAgwDSH+9tbOhVy5/j10uH55
         yupyF0xr7R9A4rIMZf6XiTwIAcW6VuIdu1kjsTCW+ufFooXR8AfmOKtW6GKbHe5peSEb
         xHmdEFu0X2dazlU7X3BE5QM1gwZEtsktpeKN9AH24rIr8l4JUXSEAB6GmdxNl2QE1LSu
         nJGQKw32D7zUVU/RBnNN/23Bc3WC1QqQvbZ1UIAbz4+TbesqMlENDvCogHkU7Bs4IboY
         ZPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOphd7Vw+yHC8lqA1EFBT5Der5nQd77Uyr9RS3TE3vY=;
        b=58bBnXoFjHmZ0aboPMF/bWzgDZdLcnjNQVTl4hNt9EqBYzYOot6oKGozkWpByf2Z+s
         FHS+vfhNHiWaSPukKoqkPcW0EZiTmJmSwsoQtKJgy65NuvfFbGPQEOA1FEhkVjXM9q94
         UwM2qE6bltKu7FinEqXM4Ryzr0XB33TghGUqXAD2ioXpafyQFDNVmmDkdZmrDg1JMvEt
         3wstaKE2Nr3MYmME8iTom/bEWBDk+2N5M884s7AyPTfFtUdoi5WPPMtqL0jU8mRSfMe9
         pTY+WyCHsL9HGKjzyRA3EXfhN5g7UczlZDpapE6pyHTO64oOIGpPB+2G+r/jtSg0x3Z0
         VnOw==
X-Gm-Message-State: AOAM531RB5WQDWCdzwbZrNltntkD4PA/6pAdvUwZj4AMrAIDWt6dMHtn
        QbMJrsEhSvw+usYoR+BhLkfGZs0RkTcYlXska3SFjA==
X-Google-Smtp-Source: ABdhPJxOPpYinyvLA0o3crm9sNVZWqIh0PTIeVd1zqa9HAyW2SKHBi/7U4L6LYyUfGY3YXZzKF/K+/23bYyzZsAdBDo=
X-Received: by 2002:a17:907:1dd5:: with SMTP id og21mr16511258ejc.233.1636070535098;
 Thu, 04 Nov 2021 17:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-12-brad@pensando.io>
 <20211025091731.GA2001@C02TD0UTHF1T.local> <a20805de16e1196c2ed46dd949473c9a@kernel.org>
In-Reply-To: <a20805de16e1196c2ed46dd949473c9a@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Thu, 4 Nov 2021 17:02:04 -0700
Message-ID: <CAK9rFnxH=DtC9vEJJCXkGEWjvg2E8vHPUcRy9rJpo34Furtmvw@mail.gmail.com>
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

Hi Marc,

On Mon, Oct 25, 2021 at 4:15 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-10-25 10:17, Mark Rutland wrote:
> > Hi,
> >
> > On Sun, Oct 24, 2021 at 06:51:56PM -0700, Brad Larson wrote:
> >> Add Pensando common and Elba SoC specific device nodes
> >>
> >> Signed-off-by: Brad Larson <brad@pensando.io>
> >
> > [...]
> >> +            gic: interrupt-controller@800000 {
> >> +                    compatible = "arm,gic-v3";
> >> +                    #interrupt-cells = <3>;
> >> +                    #address-cells = <2>;
> >> +                    #size-cells = <2>;
> >> +                    ranges;
> >> +                    interrupt-controller;
> >> +                    reg = <0x0 0x800000 0x0 0x200000>,      /* GICD */
> >> +                          <0x0 0xa00000 0x0 0x200000>;      /* GICR */
>
> This is missing the GICv2 compat regions that the CPUs implement.

Is this what is described as optional in the GIC architecture specification
where a GICv3 system can run restricted GICv2 code?  Can you point
me in the right direction in the spec and example dts node if needed.

> >> +                    interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> >> +
> >> +                    gic_its: msi-controller@820000 {
> >> +                            compatible = "arm,gic-v3-its";
> >> +                            msi-controller;
> >> +                            #msi-cells = <1>;
> >> +                            reg = <0x0 0x820000 0x0 0x10000>;
> >> +                            socionext,synquacer-pre-its =
> >> +                                                    <0xc00000 0x1000000>;
> >> +                    };
> >> +            };
> >
> > Is there any shared lineage with Synquacer? The commit message didn't
> > describe this quirk.
>
> Funny, it looks like there is a sudden outburst of stupid copy/paste
> among HW designers. TI did the exact same thing recently.
>
> This totally negates all the advantages of having an ITS and makes
> sure that you have all the overhead. Facepalm...

Some background may help explain.  To generate an LPI a peripheral must
write to the GITS_TRANSLATER (a specific address). For the ITS to know
which translations apply to the generated interrupts, it must know which
peripheral performed the write. The ID of the peripheral is known as its
DeviceID, which is often carried along with the write as an AXI sideband
signal.

The Elba SoC doesn't carry the DeviceID, so we have to conjure one up
between the peripheral and the ITS.  Instead of telling a peripheral to target
the GITS_TRANSLATER directly, we instead direct it to a specific offset
within a pre-ITS address range (our own IP block).  For writes that land in
that memory range, we derive the DeviceID from (offset >> 2).  The pre-ITS
block then sends (DeviceID, data) to the GITS_TRANSLATER.

The hardware designer came up with the Pre-ITS mechanism in Feb 2018.
When we looked at the upstream kernel later (we developed on 4.14)
we found that not only did it support something similar, it supported the
exact scheme we are using.

Thanks,
Brad
