Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97E453C97
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 00:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhKPXPE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 18:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhKPXPE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 18:15:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C4C061767
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 15:12:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so1956885edd.9
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 15:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+FOQ/sRLLKL2n8D67xhtne1+6QjN4MmxkGWuAPYSYFU=;
        b=ZSbtVfyHFNCPojkasx6Tp7Wo3H/ofQiL38o5dRfRNGrRB1kyRN8Vd7Z83qaN7FH/n8
         bL58fwkkH7Ol/VPda6afFVS6M5W80Ga4tJ6MVNCCRr1z2uSibF/FMjiyBj363LW0HgOi
         DfWaTzKB2Yt7wlaRD5m4LhklSnIP7m7DxMx2dD4CivyXH2Sz9JBJg0T3NyJwBnNdmUJg
         2nQYNZjx4m8pXYfv5GNtLbh5MjGgVMxRAHdIu2yQYUuB2Jol1gI5NY5PkcI/o3bJAHKV
         YuFk6Be73lvUEGF3MW1uFaVnPdcgqMPa+KWvSTe7G7zC+HKhrmce4UG2YeON3EfGaewi
         GZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FOQ/sRLLKL2n8D67xhtne1+6QjN4MmxkGWuAPYSYFU=;
        b=F6cADtEa8xw4jwMxhqsIgQQg/1GlQLWxNFsHQ593HbjfHWwK9y5lfTjrBNJcOtkZ3c
         N9OZ7oGiTpybin3D4jy8xI2mft5PnkjYTZAlY5vYHxCQ4685hdlHm6vdcbTn9zLNZ+zO
         JvL5IU2Y++ngNw9GUZT1cDtpcTbl8l1h1hTryeI3U/Evh0SQaIBkeY+6/QT45lXrplsJ
         prKYRF6kPTSHpt6I1Tfilm4KzbbGgEQjPWmG69ouFZbe7s0Zc2sOoEX0KpcZ6aYf2nfc
         Lq8ZTu2nI7K5T0jA2d9z25jvd4JQhzZ4DvKf572CHIcNkF6d4KbqqY9xHOw2jxp6juPW
         O65w==
X-Gm-Message-State: AOAM532yQwpkJGoCzd6Oe4NIYpbt6o/tmJMvzZViOyBXu7GE++4jeil4
        gXCGT1qW32ZClf4DuRMh57Sbo8BqnaFM95/HA75ilg==
X-Google-Smtp-Source: ABdhPJz2wF5JF1ydPJjyqPEwYlCjMltAxHidsQ4cfpYNY8KosRGi6/KK+aEQfERtYk3HS3Fkv18BPluzzYQrew/QaNI=
X-Received: by 2002:a17:907:2d20:: with SMTP id gs32mr14959055ejc.270.1637104324599;
 Tue, 16 Nov 2021 15:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-6-brad@pensando.io>
 <20211028074945.rv2j5kgzk7yc2srr@mobilestation> <CAK9rFnw396xK+u3qUpgbnGNw7WDJPJm0L3o4nPAcFeqQjBDbXg@mail.gmail.com>
 <20211116112907.lbwdcz5pmgxqzv55@mobilestation>
In-Reply-To: <20211116112907.lbwdcz5pmgxqzv55@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Tue, 16 Nov 2021 15:11:53 -0800
Message-ID: <CAK9rFny7zQRpvGOVK0+01hKQNu7XCMOz8vTfbHPs6gMR10muDw@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller bindings
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergey,

On Tue, Nov 16, 2021 at 3:29 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> > > AFAICS from the driver-part of the patchset it's not enough. You've
> > > also got the syscon phandle, which needs to be reflected in the
> > > bindings. That also makes me thinking that you didn't perform the
> > > "dtbs_check" on the dts-files you were going to submit, but for some
> > > reason discarded from this series (btw why?). If you did you would
> > > have got an error of an unevaluated property detection.
> >
> > I ran the checks below and didn't get errors.  Rob provided some info
> > and I found the server did not have yamllint installed (not flagged by
> > tool).  Also dt-schema was not the latest.  I'm re-doing this and
> > including "DT_CHECKER_FLAGS=-m" as that is new with v5.13.
> >
>
> > make ARCH=arm64 dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > make ARCH=arm64 dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > make ARCH=arm64 dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > make ARCH=arm64 dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
> > make ARCH=arm64 dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/pensando,elba.yaml
>
> Hmm, that's weird. Rob, does dtschema tool have the
> "unevaluatedProperties" property support?
>
> Brad, anyway you still need to add the syscon-property (pensando,*spics)
> requirement in the snps,dw-apb-ssi.yaml schema. See the way it's done there
> for instance for "baikal,bt1-sys-ssi" when it comes to the
> vendor-specific properties definition in the allOf composition block.
> You'll need to define a custom phandle property there in case if a
> DT-node is compatible with you SPI controller.

Updating and adding only this bindings update to file
snps,dw-apb-ssi.yaml in 5.16.0-rc1 (next-20211116):

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index d7e08b03e204..99deb587a47b 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,21 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pensando,elba-spics
+    then:
+      properties:
+        pensando,spics:
+          $ref: /schemas/types.yaml#/definitions/phandle
+          description:
+            Phandle to the system control device node which provides access to
+            the spics control register
+      required:
+        - pensando,spics

 properties:
   compatible:
@@ -73,6 +88,8 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: Pensando Elba SoC SPI Controller
+        const: pensando,elba-spics

   reg:
     minItems: 1

$ make ARCH=arm64 defconfig
...

$ make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
...
  DTEX    Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dts
  DTC     Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml
Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml:0:0:
/example-0/spi@fff00000/flash@1: failed to match any schema with
compatible: ['spi-nand']

The spi-nand schema match failure happens before I make any change.
The tool also throws errors for these files which are unrelated

Documentation/devicetree/bindings/net/qcom,ipa.yaml: ignoring, error
in schema: properties: qcom,smem-state-names
Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml:
ignoring, error in schema: patternProperties: ^filter@[0-9]+$:
properties: st,adc-channel-names
Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml:
ignoring, error in schema: properties: qcom,bcm-voter-names

Thanks,
Brad
