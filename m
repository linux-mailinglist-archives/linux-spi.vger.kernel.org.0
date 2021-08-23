Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D413F431D
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhHWBhw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhHWBhw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:37:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFB1C061757
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:37:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r19so23672724eds.13
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxWio+q29reCoS7GlvNwJGZL+eItWHFeqY81vp5x9Eg=;
        b=23wPDmux5XY53E+mP4bRFgGciUnIFIhG9fpgmm2SwcuISYFzuqinRLQDynUleKXVQm
         FBdSuNibkOZJgvNzXM3ckwvVU1FyoA3ML8jovp7zgpEfE3lhFdBHPuavXCYQ6CzQKUPp
         MxmDDn1ipawshzjuKdsA6Ux8OjktZD53r3O7dfnZNBMfPZa8fodVFhLXXHOU/1Qf0Xu3
         16JyTJiFJn+rMxXC5k5lr6WZ+h9iyeaPFBOwkamrLjLbGhYs28Dv97PFYI4MUbR2no76
         gVk4S7SywqBKThyMZLZQBivUBSEdbysrpX7ioa14Anc6s1wPN1ZmIQ4vCuQ3BcKn/1Oq
         C05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxWio+q29reCoS7GlvNwJGZL+eItWHFeqY81vp5x9Eg=;
        b=sn+hiXv/3nHIrzM9EcTsmwX/hV/kjY9beN+27EYsHwz62CsnHPsD3ANekmLy9XR99T
         Ka5cVyLF3WO8baRZIqyJgXLCm8chNpVEIYmr7vaG/vqF3A6idNEQSR1mP8xVONTOALHW
         qo4f1Pq1k5sk52nRigFBpBLGX1iyKSAD8BHtd7EbWjBb1hznrrLO56hZVTFKu0SgTRiJ
         idAlLRG7QujCPYPEsvnjiybI3cHutCQu/g815qw03amSeLPwlG3kcXI4rAsMoJejboiF
         AHGM71ly8zTgB4SIH0rfXd7X6kNkEN3LqwQbvDz62vmxzwxXsMx4/ZojUNiONZ/xzLLV
         CeBg==
X-Gm-Message-State: AOAM530szxnfpxkSIepuMyjnfeH8eegg/aU/EWopquSCkc/GURVLEREq
        6okKBC3kDzlgFdbRZcfy8Aip5EWHRJX13OD3GlntTA==
X-Google-Smtp-Source: ABdhPJwdmj0S6igpGgeJzgSQL+ZyF8LMkoVE5mn7v3U1UbXMNV18gQn76356S4cAFmnfZHkz7HvmvvFqfaM+OLX0S/0=
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr35047588edb.268.1629682628803;
 Sun, 22 Aug 2021 18:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-8-brad@pensando.io>
 <20210330215541.GA729679@robh.at.kernel.org>
In-Reply-To: <20210330215541.GA729679@robh.at.kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:36:58 -0700
Message-ID: <CAK9rFnzxPFm3aJDUh0eZnV5q8EpGwqGkcKM=RbiVdp5C5UhaqQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] arm64: dts: Add Pensando Elba SoC support
To:     Rob Herring <robh@kernel.org>
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

Hi Rob,

On Tue, Mar 30, 2021 at 2:55 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Mar 28, 2021 at 06:59:32PM -0700, Brad Larson wrote:
> > Add Pensando common and Elba SoC specific device nodes
>
> Build your dtb with W=1 and 'make dtbs_check' and fix warnings.

I'll do that thanks.

> > +
> > +             // CLUSTER 0
> > +             cpu0: cpu@0 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a72", "arm,armv8";
>
> This should give you a warning.

I'll be sure to W=1 and make dtbs_check.  All the C++ comments are C syntax now.

> > +&qspi {
> > +     status = "okay";
> > +     flash0: mt25q@0 {
>
> flash@0

Yes, generic node name should be used.  Changed mt25q to flash.
-       flash0: mt25q@0 {
+       flash0: flash@0 {

> > +             compatible = "jdec,spi-nor";
>
> jedec,spi-nor

Changed jdec to jedec
-               compatible = "jdec,spi-nor";
+               compatible = "jedec,spi-nor";

> > +     spi@0 {
>
> 'spi@' is reserved for SPI controllers.

Changed the node name to indicate the spi bus number and chip select

&spi0 {
        num-cs = <4>;
        cs-gpios = <&spics 0 GPIO_ACTIVE_LOW>, <&spics 1 GPIO_ACTIVE_LOW>,
                   <&porta 1 GPIO_ACTIVE_LOW>, <&porta 7 GPIO_ACTIVE_LOW>;
        status = "okay";
-       spi@0 {
+       spi0_cs0@0 {
                compatible = "pensando,cpld";
                #address-cells = <1>;
                #size-cells = <1>;
                spi-max-frequency = <12000000>;
                reg = <0>;
        };
-       spi@1 {
+       spi0_cs1@1 {
        ...

> > +             compatible = "pensando,cpld";
>
> Any new compatibles need to be documented with schema.

I'll create the bindings file for the v3 patchset dependent on the
discussion revolving around adding pensando,cpld to this list in
spi/spidev.c.

static const struct of_device_id spidev_dt_ids[] = {
        { .compatible = "rohm,dh2228fv" },
        { .compatible = "lineartechnology,ltc2488" },
        { .compatible = "ge,achc" },
        { .compatible = "semtech,sx1301" },
        { .compatible = "lwn,bk4" },
        { .compatible = "dh,dhcom-board" },
        { .compatible = "menlo,m53cpld" },
        { .compatible = "pensando,cpld" },    <===
        {},
};
MODULE_DEVICE_TABLE(of, spidev_dt_ids);

> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
> > @@ -0,0 +1,78 @@
> > +&flash0 {
> > +     partitions {
> > +             compatible = "fixed-partitions";
>
> This should just be moved into elba-asic-common.dtsi IMO unless you have
> good reasons to keep it separate.

This file is shared across platforms which have additional flash
devices and partition schemes.

> You need SPDX license tags at the top of each file. checkpatch.pl should
> tell you this.

I don't recall checkpatch.pl reporting that for device tree files.
I've added to each file now.

> > +/*
> > + * Copyright (c) 2019, Pensando Systems Inc.
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include "dt-bindings/interrupt-controller/arm-gic.h"
> > +
> > +/ {
> > +     compatible = "pensando,elba";
>
> This needs an SoC family schema.
>
> Generally this and 'model' should be in the same file (the board file).

Will add schema for pensando,elba in the v3 patchset.  The compatible
and model are now in the board file elba-asic.dts as shown below

+/ {
+       model = "Elba ASIC Board";
+       compatible = "pensando,elba";
+
+       aliases {
+               serial0 = &uart0;
+               spi0 = &spi0;
+               spi1 = &qspi;
+       };
+
+       chosen {
+               stdout-path = "serial0:115200n8";
+       };
+};

> > +
> > +     interrupt-parent = <&gic>;
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +
> > +     clocks {
>
> Drop this container node.

Removed the container node.

> > +     /* Common UIO device for MSI drivers */
> > +     uio_penmsi {
> > +             compatible = "pensando,uio_penmsi";
> > +             name = "uio_penmsi";
>
> No. What's UIO?

UIO nodes are removed, only core SoC support will be included

> > +     soc: soc {
> > +             compatible = "simple-bus";
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             gic: interrupt-controller@800000 {
>
> Order nodes by increasing unit address.

Yes, I've done this and will be part of the v3 patchset

> > +             /*
> > +              * Until we  know the interrupt domain following this, we
> > +              * are forced to use this is the place where interrupts from
> > +              * PCI converge. In the ideal case, we use one domain higher,
> > +              * where the PCI-ness has been shed.
> > +              */
> > +             pxc0_intr: intc@20102200 {
>
> interrupt-controller@...

Changed intc to interrupt-controller

> > +                     compatible = "pensando,soc-ictlr-csrintr";
> > +                     interrupt-controller;
> > +                     reg = <0x0 0x20102200 0x0 0x4>;
> > +                     #interrupt-cells = <3>;
> > +                     interrupt-parent = <&gic>;
> > +                     interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names = "pxc0_intr";
> > +             };
> > +
> > +             uart0: serial@4800 {
> > +                     device_type = "serial";
>
> Drop 'device_type'. It's deprecated for all but memory and pci.
>

Removed  device_type = "serial";

> > +             gpio0: gpio@4000 {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     compatible = "snps,dw-apb-gpio";
> > +                     reg = <0x0 0x4000 0x0 0x78>;
> > +                     status = "disabled";
> > +
> > +                     porta: gpio-controller@0 {
>
> gpio@0

Changed from gpio@0 to gpio-port@0 based on additional reviewer input

-                       porta: gpio-controller@0 {
+                       porta: gpio-port@0 {

> > +
> > +             /* UIO device using interrupt line PCIEMAC */
>
> UIO is a kernel thing. It doesn't belong in DT.

UIO nodes are removed for core SoC support patchset

> > +
> > +             emmc: mmc@30440000 {
> > +                     compatible = "pensando,elba-emmc", "cdns,sd4hc";
> > +                     clocks = <&emmc_clk>;
> > +                     interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +                     reg = <0x0 0x30440000 0x0 0x10000
> > +                            0x0 0x30480044 0x0 0x4>;
>
> Use <> around each entry.

The system fails to boot if I make that change, mmc probe fails and
rootfs not found

-               reg = <0x0 0x30440000 0x0 0x10000
-                      0x0 0x30480044 0x0 0x4>;
+               reg = <0x0 0x30440000 0x0 0x10000>,
+                     <0x0 0x30480044 0x0 0x4>;

Regards,
Brad
