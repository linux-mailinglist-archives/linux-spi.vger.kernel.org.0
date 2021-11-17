Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB39A454282
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 09:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhKQIW1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 03:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhKQIW0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 03:22:26 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100BC061570;
        Wed, 17 Nov 2021 00:19:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d11so4407629ljg.8;
        Wed, 17 Nov 2021 00:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bgs8iyUy89PkKvzl321W/UAXVH57vSKrzyQqzOIg/uo=;
        b=TnY11PkOecu9gptvsD5iv0+wmUGir99GjK9/k3tBZOwew4wfLpIG+zbAeVl5x4W7b1
         Cpbedg//+UfgYiaDeyfO+0Zks+5y0YWrPFFTtbgV8Xr1x2HQ0ecKJDub0wCyWoKocNEN
         38KH36jveNOf7cJQr7FIUMQV6YxDJ+MowxaWyWZ+1kWDMYhb8GIoCylopTPKHpj8iOya
         RTHhc4guieXR93jZ1lPD0xFXzcX4WQDsAj3jourJuWohtzFksx5r6ltkFVqhZyJVSvxB
         PZyvkTQX1jECPp//Z5ioTLZ5INdVutYbz5r+cw9Rtrjfp1q+MW15iVAlmWVLiIH+OCeB
         gl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bgs8iyUy89PkKvzl321W/UAXVH57vSKrzyQqzOIg/uo=;
        b=Td2/awECVBwh7E4uPpkWkKWfqSASaBD3SqT/k+wA4EiE/NNBN7uq3IMOgq3f0AgTXJ
         aiGy8uNXOsz8Wl9yn6chVHzSzVKTkyRYg63GfURF2Xfgk0hMwGl53AE3xUEERr6QfB8x
         XtT/NU0vKzc3qbodSocXAy9c3e0n/nPA9DFiOEnwfcLswK1jXBhERqlyj50jsMP0bx1T
         DYLxe72VrfIEsrd8UJ9OXfeD52RvnUXJjoYM7l/KmSKcvELOJhbkU5+7D5nRhCsbK/rY
         jI/VSwm0hQetx1QmSsboEApDLKuzR2bXfBDT4d0L/mjZEaPrbwZAWTD2JVsBgrctwVFi
         kqhA==
X-Gm-Message-State: AOAM533ClO/FaVIddofO1SaOjYL4EJ+CldjsGWm3qVWVbCf0L10GzJO5
        ZlxTP95VKGfnAIOl4OTVrn8=
X-Google-Smtp-Source: ABdhPJzXiZb7AbiLv4mX/n1uVupgxzrFrsNr8u0D38JXKOqnjBNQXe1nkF/X9hhJXvlEYO752Wd4PA==
X-Received: by 2002:a05:651c:179b:: with SMTP id bn27mr3019354ljb.444.1637137165798;
        Wed, 17 Nov 2021 00:19:25 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id c21sm2044020lfv.29.2021.11.17.00.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 00:19:25 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:19:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller
 bindings
Message-ID: <20211117081922.nnqsr5zzzydurq5t@mobilestation>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-6-brad@pensando.io>
 <20211028074945.rv2j5kgzk7yc2srr@mobilestation>
 <CAK9rFnw396xK+u3qUpgbnGNw7WDJPJm0L3o4nPAcFeqQjBDbXg@mail.gmail.com>
 <20211116112907.lbwdcz5pmgxqzv55@mobilestation>
 <CAK9rFny7zQRpvGOVK0+01hKQNu7XCMOz8vTfbHPs6gMR10muDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9rFny7zQRpvGOVK0+01hKQNu7XCMOz8vTfbHPs6gMR10muDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 16, 2021 at 03:11:53PM -0800, Brad Larson wrote:
> Hi Sergey,
> 
> On Tue, Nov 16, 2021 at 3:29 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > > > AFAICS from the driver-part of the patchset it's not enough. You've
> > > > also got the syscon phandle, which needs to be reflected in the
> > > > bindings. That also makes me thinking that you didn't perform the
> > > > "dtbs_check" on the dts-files you were going to submit, but for some
> > > > reason discarded from this series (btw why?). If you did you would
> > > > have got an error of an unevaluated property detection.
> > >
> > > I ran the checks below and didn't get errors.  Rob provided some info
> > > and I found the server did not have yamllint installed (not flagged by
> > > tool).  Also dt-schema was not the latest.  I'm re-doing this and
> > > including "DT_CHECKER_FLAGS=-m" as that is new with v5.13.
> > >
> >
> > > make ARCH=arm64 dtbs_check
> > > DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > > make ARCH=arm64 dtbs_check
> > > DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > > make ARCH=arm64 dtbs_check
> > > DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > make ARCH=arm64 dtbs_check
> > > DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > make ARCH=arm64 dtbs_check
> > > DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/pensando,elba.yaml
> >
> > Hmm, that's weird. Rob, does dtschema tool have the
> > "unevaluatedProperties" property support?
> >
> > Brad, anyway you still need to add the syscon-property (pensando,*spics)
> > requirement in the snps,dw-apb-ssi.yaml schema. See the way it's done there
> > for instance for "baikal,bt1-sys-ssi" when it comes to the
> > vendor-specific properties definition in the allOf composition block.
> > You'll need to define a custom phandle property there in case if a
> > DT-node is compatible with you SPI controller.
> 
> Updating and adding only this bindings update to file
> snps,dw-apb-ssi.yaml in 5.16.0-rc1 (next-20211116):
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d7e08b03e204..99deb587a47b 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,21 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:

> +        compatible:
> +          contains:
> +            enum:
> +              - pensando,elba-spics

I was wrong using that construction here (fixup patch would be very
welcome) seeing the "snps,dw-apb-ssi" doesn't permit having a generic
"snps,dw*" compatible string. So just const-compatible property should
be enough:

+        compatible:
+          const: pensando,elba-spics


> +    then:
> +      properties:
> +        pensando,spics:
> +          $ref: /schemas/types.yaml#/definitions/phandle
> +          description:
> +            Phandle to the system control device node which provides access to
> +            the spics control register
> +      required:

> +        - pensando,spics

Please note, I've asked to be more specific in this property naming.
Something like this should be fine
"pensando,elba-syscon-spics"/"pensando,syscon-spics".

> 
>  properties:
>    compatible:
> @@ -73,6 +88,8 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1
> +      - description: Pensando Elba SoC SPI Controller
> +        const: pensando,elba-spics
> 
>    reg:
>      minItems: 1
> 
> $ make ARCH=arm64 defconfig
> ...
> 

> $ make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

I am kind of surprised that this command is still evaluating all
the schemas. Compiling only the depended DT-schemas would much
better... Anyway that's why you are getting unrelated to the
snps,dw-apb-ssi.yaml errors.

> ...
>   DTEX    Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dts
>   DTC     Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml
> Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml:0:0:
> /example-0/spi@fff00000/flash@1: failed to match any schema with
> compatible: ['spi-nand']

That means there is no bindings defined for the "spi-nand"-compatible
node. AFAICS it doesn't make the tool to fail though. Anyway fixing this
part would be a subject of additional patches (which would be very
appreciated). That would concern converting the
Documentation/devicetree/bindings/mtd/spi-nand.txt legacy bindings to
the DT-schema. It's not enough though. Seeing that file lacks of
the NAND Flash specific DT-property description, you'd need to detach
ones (described by the "^nand@[a-f0-9]$"-pattern property) from the
Documentation/devicetree/bindings/mtd/nand-controller.yaml schema and
place them into a separate DT-schema file for generic nand-flashes
Documentation/devicetree/bindings/mtd/nand-flash.yaml in a framework
of a pre-requisite patch. Than in the legacy bindings conversion patch
you'd need to use it to correctly evaluate a generic NAND flash node.
Adding some example properties to the DT-schema would be also
required.

-Sergey

> 
> The spi-nand schema match failure happens before I make any change.
> The tool also throws errors for these files which are unrelated
> 
> Documentation/devicetree/bindings/net/qcom,ipa.yaml: ignoring, error
> in schema: properties: qcom,smem-state-names
> Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml:
> ignoring, error in schema: patternProperties: ^filter@[0-9]+$:
> properties: st,adc-channel-names
> Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml:
> ignoring, error in schema: properties: qcom,bcm-voter-names
> 
> Thanks,
> Brad
