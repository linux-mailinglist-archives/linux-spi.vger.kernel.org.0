Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF832CF82
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 10:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhCDJSW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 04:18:22 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:45417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbhCDJR6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 04:17:58 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1rGy-1lJwrd3HzM-002FlE; Thu, 04 Mar 2021 10:06:30 +0100
Received: by mail-oi1-f172.google.com with SMTP id d20so29312159oiw.10;
        Thu, 04 Mar 2021 01:06:29 -0800 (PST)
X-Gm-Message-State: AOAM531WYSDMdrS9d9TYpfv8cSUYTwXrHkFW6HG9A5HEb3EdbMYceAcC
        +bzY0EJmPT8kOjnKOGUYule4WfAahpUVfQAioWs=
X-Google-Smtp-Source: ABdhPJwDjUL2GkPHOFy1Wxp/23X9Q3Z/08u3CdZWiGgYTIrus8UWpg2dWeE9I8lJdDxq+Xt35Z1HfDBqojDyxcXjvhs=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr2178311oib.11.1614848787917;
 Thu, 04 Mar 2021 01:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-8-brad@pensando.io>
In-Reply-To: <20210304034141.7062-8-brad@pensando.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Mar 2021 10:06:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1dwtXqneyNdNNdG4f03o3a+SCUXCb5ESDap+mjyG3Ohg@mail.gmail.com>
Message-ID: <CAK8P3a1dwtXqneyNdNNdG4f03o3a+SCUXCb5ESDap+mjyG3Ohg@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rI+9jRhiYZmox/XbWzWQhsNvdJ7qVdy58g5Kea9WU7IgKyco+2f
 wIiXP7bpvHIPoYQGOKiRbA8WQYbXmk2SQaWS/tNlSAbjbaCVBSRfATl6K6HVcU/lLCSoPg/
 a5NXOlHpiKloX//ZETM1s2EuMELQ8Tte39QU1pB5pBYl2/q4LMrJkzNnSXsOPpGf/BMFaJR
 EDhX0+ihYfLWYSyCreNww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQAqxFO4uuo=:tI/603A1FguWmSqUiFrmsx
 uvUvfSmVnkuKDFa0asJmw+Ago6+kewBXxzWjihSa42GOK4ISw2s1NGEPH4Cqk75leGitPQcNF
 vx2aLNYjEMADZnNY+qs0zYlBS/cc+VQEBw9nbVqvQ1pYQ0ljy8RfzIDafEEQ/hGHkQkq/O4cr
 RZGL/30+7q7+MWGdbW2KBk6PF203TkiO3XW1u/ZzQ/U1eBmpQhZEaG11Q5gR/ElXBq4jkWDnf
 JHM3AvpyRlGZcsMVnSDtaCC5cQ3au/uL7qQAmg09PHvMMOgpdvBniOCkeMXWCpu+Uk7Vm8y5K
 3vlSgNlNRx0zBIOYW+NNO4Y078cROBkvOBYHKfgFpPLG4SyDsdfnUisEaeHCAioGXfq0ay/0V
 N9Hsc9W8v+ZGVl/CtHP56XtubYAUr1ss5qL2PmBMf9djvzp5QkABGT8UGJEC6sTlfGmBdxERP
 Jsc2aSM/ig26zMkm2N/w+vt3CIlcg/n2VZSqyK8OQFyyFhVAmfFE4A/oQHgAGjAkTIrMvslhq
 hDjem+Dc3XW/S1DOf2csPR3XEl7CGxn6g+f3GAY7mS8pwmwchLi7FmyL6cFVi74Y/e9EP8sKm
 lHx8a3eZTDh4koTupwZE6AM97gu00Q4iD0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 4, 2021 at 4:41 AM Brad Larson <brad@pensando.io> wrote:
>
> Add Pensando common and Elba SoC specific device nodes
> and corresponding binding documentation.
>
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  .../bindings/gpio/pensando,elba-spics.txt     |  24 ++
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   2 +-
>  .../bindings/spi/cadence-quadspi.txt          |   1 +

It would be better to split each of the above out into a separate patch for
easier review, and send them along with the driver changes.

> diff --git a/Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt b/Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt
> new file mode 100644
> index 000000000000..30f5f3275238
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt
> @@ -0,0 +1,24 @@
> +Pensando Elba SPI Chip Select Driver
> +
> +The Pensando Elba ASIC provides four SPI bus chip selects
> +
> +Required properties:
> +- compatible: Should be "pensando,elba-spics"
> +- reg: Address range of spics controller
> +- gpio-controller: Marks the device node as gpio controller
> +- #gpio-cells: Must be 2

You need to document what each of the cells are for. In your
example, the second cell is always zero, is that intentional?

> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index af7442f73881..645ae696ba24 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -122,7 +122,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      emmc: mmc@5a000000 {
> -        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> +        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc", "pensando,elba-emmc";
>          reg = <0x5a000000 0x400>;
>          interrupts = <0 78 4>;
>          clocks = <&clk 4>;

These are in the wrong order, the most generic one (cdns,sd4hc) always
comes last.

If you add the string in the example, it also has to be an option in the
actual binding, otherwise neither the example nor your dtb would
be valid.

You also wouldn't find a controller that is compatible with both the uniphier
variant and the elba variant, unless your 'elba' SoC is strictly derived from
Socionext's Uniphier products and inherits all the quirks in its sdhci
implementation that were not already part of Cadence's IP block.

> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> index 8ace832a2d80..dbb346b2b1d7 100644
> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> @@ -6,6 +6,7 @@ Required properties:
>         For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
>         For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
>         For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
> +       For Pensando SoC - "pensando,cdns-qspi".

This does not look specific enough: There is no guarantee that this
is the only time Pensando uses any Cadenci qspi block. If the company
is not yet out of business, you should be prepared for future products
and have the name of the chip in there as well.

> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72", "arm,armv8";
> +                       reg = <0 0x0>;
> +                       enable-method = "spin-table";
> +                       next-level-cache = <&l2_0>;

spin-table is not really something we want to see for new machines.
Please add proper psci support to your boot loader.

> index 000000000000..9623df208131
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +       model = "Elba ASIC Board";
> +
> +       aliases {
> +               serial0 = &uart0;
> +                spi0 = &spi0;
> +                spi1 = &qspi;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:19200n8";
> +       };
> +};

These properties are usually board specific, and should be moved into the
.dts file.

> +       spi@0 {
> +               compatible = "pensando,cpld";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               spi-max-frequency = <12000000>;
> +               reg = <0>;
> +       };


> +       spi@2 {
> +               compatible = "pensando,cpld-rd1173";

These don't seem to have a binding document, which needs to be added
first. What is a Pensando "cpld"? Is it possible that there will be multiple
versions of it that need to be uniquely identified?

> +
> +       /* Common UIO device for MSI drivers */
> +       uio_penmsi {
> +               compatible = "pensando,uio_penmsi";
> +               name = "uio_penmsi";
> +       };

Missing binding again. Since you name this a UIO device, I assume this
is actually tied to a particular Linux device driver and exported to user
space. The information in the dts should however not assume a particular
OS implementation but describe the platform.

Is this for PCI MSI? If so, I would recommend just using the GICv3 that you
also have, and leave this device completely unused.

In either case, please leave out the device node until a binding has
been agreed and a matching kernel driver was reviewed (if any)

> +
> +               /*
> +                * Until we  know the interrupt domain following this, we
> +                * are forced to use this is the place where interrupts from
> +                * PCI converge. In the ideal case, we use one domain higher,
> +                * where the PCI-ness has been shed.
> +                */
> +               pxc0_intr: intc@20102200 {
> +                       compatible = "pensando,soc-ictlr-csrintr";
> +                       interrupt-controller;
> +                       reg = <0x0 0x20102200 0x0 0x4>;
> +                       #interrupt-cells = <3>;
> +                       interrupt-parent = <&gic>;
> +                       interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "pxc0_intr";
> +               };

Leave this one out as well, this has to be reviewed in combination with the
PCI driver.

> +               pcie@307c2480 {
> +                       compatible = "pensando,pcie";
> +                       reg = <0x0 0x307c2480 0x0 0x4   /* MS CFG_WDT */
> +                              0x0 0x00001400 0x0 0x10  /* WDT0 */
> +                              0x0 0x20000000 0x0 0x00380000>; /* PXB Base */
> +               };

This does not follow the PCI host bridge binding. Leave it out for now,
and bring it back once you have a proper PCI driver.

        Arnd
