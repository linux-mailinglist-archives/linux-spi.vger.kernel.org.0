Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCB3F42AD
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 02:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhHWAzE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 20:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhHWAzE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 20:55:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723DBC06175F
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 17:54:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mf2so14845034ejb.9
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCfKmnJmqqI7jJQlcyiuI5mMfUQXjNPCJKCttWb1qt8=;
        b=A4h2GLHXtRVS9vQdzorylmvzR7vxvIcjGZ0eFMklc7Fc4BUBoXPk3oB0cRyz8oceV9
         6SaGpAVvzJpYyTJe7GTd5+2E67N5vJm+hJZetckGUfODc6bXQMAyXh7545E49TqVJ0uR
         2ngVNAsQus/k2BhAQUJ9n3AJxb00EQobu/cpC+s4hucFhEN6oN+f+UZeEUADR1rMwCHz
         8+L+dFKH6a8y8qVp1hrDW+wzXXrmQSqIaiUKEDuiwumaHKPdZhVqBhD+ZaHlOGnEjPfF
         irEyg+erpbbo63ClBkNBsKeau1qqea+NBhQ5ZbgNxf4NGGlpqbW5ei9HyZM1kc4W7tKk
         mPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCfKmnJmqqI7jJQlcyiuI5mMfUQXjNPCJKCttWb1qt8=;
        b=o+YW75a8rFyBN5JnPwc65VxPpoTbKYTuw/EjYMgPrJdeLhfabwFIyAqR22z65z6gK8
         w3qam7MTvYPUTdwBWJ8iTKZ0giEcpdojcVQNZEWxxoag53VWn1CdUAe4NknOVF6GBCj8
         QNDOsCHEU1uSKu1QflPCrX/RThEmJamvfwzwI6zejpboeehuaNYmuoKhCaYepYA4idu5
         fVPLr9d3r8hsJlgZjEccJ0j9zfwloQdcyey0gA/DnwAJrp7riVxw7aCXjMOjWRBsMNy9
         jCDMwr1dpmWvRJXtgcGDVM+HeQlhdCFAE+Y95Qv7g8YEdrxjHYZUlUXH3q9kJg8Pa7wA
         vYnA==
X-Gm-Message-State: AOAM530yYwVhG6/u3EJO0Le1Zi2zRvCXrLpmN/2R9YKaqaBlGclrthAe
        iANewhVFkbDYCORbT331OFJwoJvrB7LUhIgA0+wAxw==
X-Google-Smtp-Source: ABdhPJyr6R4LC87uphsxySvEXCIWhOfzIxR0G9gDmPD+Fl8kr+9oUkEZA1IOgIEGr6eAgBrQ72fwayTcK8phJKWSOcU=
X-Received: by 2002:a17:906:3bc1:: with SMTP id v1mr4525657ejf.182.1629680060829;
 Sun, 22 Aug 2021 17:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-8-brad@pensando.io>
 <20210304080355.cc37g7jagswro3dg@mobilestation>
In-Reply-To: <20210304080355.cc37g7jagswro3dg@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 17:54:10 -0700
Message-ID: <CAK9rFnzBNjiUARvAe6k9DnDV-RCG9L0ARaiFVPQbUhv1UqTDRA@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
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

Hi Sergey,

On Thu, Mar 4, 2021 at 12:03 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Wed, Mar 03, 2021 at 07:41:40PM -0800, Brad Larson wrote:
> > Add Pensando common and Elba SoC specific device nodes
> > and corresponding binding documentation.
>
> This also needs to be split up into sub-patches seeing these are
> unrelated changes like device bindings update, new platform DT file.
>
> Note text-based bindings are deprecated in favor of the DT schemas.
> Also note dts needs to pass dtbs_check validation. So all new HW/DT
> nodes need to be reflected in the DT-schemas. See [1] for details.
>
> [1] Documentation/devicetree/writing-schema.rst

Yes, patchset v2 was a first cut at organizing into sub-patches and in
v2 I used DT schemas for new files.  I will need to add additional new
sub-patches per review comments for v3 of the patchset.

> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index af7442f73881..645ae696ba24 100644
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -122,7 +122,7 @@ unevaluatedProperties: false
> >  examples:
> >    - |
> >      emmc: mmc@5a000000 {
>
> > -        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> > +        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc", "pensando,elba-emmc";
>
> Alas it's not enough. New HW compatible strings shall be defined in the
> binding schema.

Based upon the next-20210818 version of cdns,sdhci.yaml below is the
proposed change.  In terms of defining new HW compatible strings is an
added example sufficient for pensando,elba-emmc?  There is no
additional definition for socionext,uniphier-sd4hc other than the
example in this file.

--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -15,9 +15,12 @@ allOf:
 properties:
   compatible:
-    items:
-      - enum:
-          - socionext,uniphier-sd4hc
+    oneOf:
+      - items:
+          - enum:
+              - socionext,uniphier-sd4hc
+              - pensando,elba-emmc
+          - const: cdns,sd4hc
       - const: cdns,sd4hc

   reg:
@@ -132,3 +135,17 @@ examples:
         mmc-hs400-1_8v;
         cdns,phy-dll-delay-sdclk = <0>;
     };
+  - |
+    emmc: mmc@30440000 {
+        compatible = "pensando,elba-emmc", "cdns,sd4hc";
+        clocks = <&emmc_clk>;
+        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+        reg = <0x0 0x30440000 0x0 0x10000
+               0x0 0x30480044 0x0 0x4>;
+        cdns,phy-input-delay-sd-highspeed = <0x4>;
+        cdns,phy-input-delay-legacy = <0x4>;
+        cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
+        cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
+        cdns,mmc-ddr-1_8v;
+    };

> > diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> > index 8ace832a2d80..dbb346b2b1d7 100644
> > --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> > @@ -6,6 +6,7 @@ Required properties:
> >       For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> >       For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> >       For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
>
> > +     For Pensando SoC - "pensando,cdns-qspi".
>
> What about converting this file to DT-schema and adding new HW
> bindings in there?

The file cadence-quadspi.txt has been converted to cdns,qspi-nor.yaml
in next-20210818.  This would be the updated change where
pensando,cdns-qspi is now pensando,elba-qspi to be more specific.

--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,6 +20,7 @@ properties:
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
+              - pensando,elba-qspi
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor

> > +     chosen {
>
> > +             stdout-path = "serial0:19200n8";
>
> Baudrate of 19200? So sad.(

The default baudrate for patchset v3 will be 115200  :-)

> > +&spi0 {
> > +     num-cs = <4>;
>
> > +     cs-gpios = <&spics 0 0>, <&spics 1 0>, <&porta 1 0>, <&porta 7 0>;
>
> Oh, you've got four peripheral SPI devices connected with only two native CS
> available. Hmm, then I don't really know a better way, but just to forget about
> the native DW APB CS functionality and activate the direct driving of
> all the CS-pins at the moment of the DW APB SPI controller probe
> procedure. Then indeed you'll need a custom CS function defined in the DW APB
> SPI driver to handle that.

Right, confusion was created by leaving in code implying that the two
native CS are supported.  CS0 is used just to start the serial engine.
The existing dw_spi_set_cs() function works fine resulting in this
implementation.

static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
{
        spi->chip_select = 0;
        dw_spi_set_cs(spi, enable);
}

> > +             spics: spics@307c2468 {
> > +                     compatible = "pensando,elba-spics";
> > +                     reg = <0x0 0x307c2468 0x0 0x4>;
> > +                     gpio-controller;
> > +                     #gpio-cells = <2>;
> > +             };
>
> So that GPIO-controller is just a single register which provides a way
> to toggle the DW APB SPI CS-mode together with their output value.
> If so and seeing there are a few more tiny spaces of config
> registers added to eMMC, PCI, etc DT node, I suppose all of them
> belong to some bigger config space of the SoC. Thus I'd suggest to at
> least implement them as part of a System Controller DT node. Then use
> that device service to switch on/off corresponding functionality.
> See [2] and the rest of added to the kernel DTS files with
> syscon-nodes for example.
>
> [2] Documentation/devicetree/bindings/mfd/syscon.yaml
>
> -Sergey
>

I've looked at the syscon documentation, other drivers that use it and
tried the below proposed example with variations.  The result is Elba
works ok for its four SPI devices but the host has a machine check
which must be due to a pcie access error.  From another thread on this
topic here is the recommended change to using syscon.

> Rob, please see here having a small sized reg-space one more time.
> Having so many small-sized registers scattered around the dts file
> makes me thinking that most of them likely belong to some bigger
> block like "System Controller". If so then there must be a main node
> compatible with "syscon" device, which phandle would be referenced in
> the particular device nodes. Like this:
>
> \ {
>         soc {
>                 syscon: syscon@307c0000 {
>                         compatible = "pensando,elba-sys-con", "syscon", "simple-mfd";
>                         reg = <0x0 0x307c0000 0x0 0x10000>;
>
>                         spics: spics@307c2468 {
>                                 compatible = "pensando,elba-spics";
>                                 gpio-controller;
>                                 #gpio-cells = <2>;
>                         };
>                 };
>                 pcie@307c2480 {
>                         compatible = "pensando,pcie";
>                         reg = <0x0 0x20000000 0x0 0x00380000>; /* PXB Base */
>
>                         syscon = <&syscon>;
>                 };
>
>                 /* etc */
>         };
> };

The current pcie node is

>         pcie@307c2480 {
>                 compatible = "pensando,pcie";
>                 reg = <0x0 0x307c2480 0x0 0x4           /* MS CFG_WDT */
>                        0x0 0x1400 0x0 0x10              /* WDT0 */
>                        0x0 0x20000000 0x0 0x380000>;    /* PXB Base */
>         };

Regards,
Brad
