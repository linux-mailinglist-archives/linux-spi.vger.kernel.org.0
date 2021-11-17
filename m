Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE33454F6A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 22:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbhKQVi2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 16:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239951AbhKQVi1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 16:38:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E4BC061570
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 13:35:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so17351183edz.2
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oE/PpLF33Bzsi0HnoSd2D3IwGwaXk2bQ1kvpSMCx344=;
        b=QXKVrGtTrCFY3/MBy6Ae0VTxlonw/DRAwSMtioyfsFpu2GcapCZk8ECLNgHzTseKvw
         z4a+aYv43SjZNW9uCZfhmS17j+f8gCgthROz70Lx0hFYnFUcRSvmoInMeC07P6JZ0h3V
         Xr+RAhPlvzJYcKexb/aQuT9t9+/L4FZKUWiptUjyDUslFUoqctzOgri6mtkQcbbZTtvA
         npV5JkOzQTIeSfkzvp74QKTJGPdVK/AX9ysyEayMfOemtar8e6uJ3fKQWAITwhXv9fZr
         jEHJWh4QDMrx2m8a5nMPQ7jXzh/j7+IFYmXyz3+PXKz7B21vPoOBG9YEk3lVpfjvf/z4
         HMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oE/PpLF33Bzsi0HnoSd2D3IwGwaXk2bQ1kvpSMCx344=;
        b=K15wHT5uV7N2H3kuysvYCdfXI4EdZt+pMMxZD9PYPEHK4lG1ZwXP+CTA+eq7UVqSe3
         WHOqP70wJbCYkUaKzj44+PkJwJlPNsQnyTAHSgHkvel0OgBOhlrU3F4w76LneUxX4ogO
         HOalPP3azHJwxCqBWFjyT+qeJ9bsKQv7ItUZ6zaUoJg5SoXD/p9uUYu57rD6AhJcZYzE
         Xsg3KVxGG6VWqFH+5QkJOSu/aw/N/LKa0YCVXEpN59Hgz4SJEpE0jsylYRNdQhrYAkVR
         cZtBuUs0nNm1+Xm1ifNiXFfpyvmQfeGYirZynO3qN5bV9evg/oGN+4et/x3vw3J3/PAV
         9M0Q==
X-Gm-Message-State: AOAM533/beSDCHCYlFD6aFCLjbgLIBYJOik5jWBMDzQWFifOn2y+DcE4
        szDVwrTwePNRHQTvNiCjKf++dtvOwbmEWr58T87iYg==
X-Google-Smtp-Source: ABdhPJzr0FWsxLkdp+GqPycs6CHrFza83kIvQ058rw/43FF71YpE2yK7ii3nVMCgEOTvhGBAP0KBWaoOOVwD5hfSdFQ=
X-Received: by 2002:a17:907:9487:: with SMTP id dm7mr26958236ejc.95.1637184926827;
 Wed, 17 Nov 2021 13:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-6-brad@pensando.io>
 <20211028074945.rv2j5kgzk7yc2srr@mobilestation> <CAK9rFnw396xK+u3qUpgbnGNw7WDJPJm0L3o4nPAcFeqQjBDbXg@mail.gmail.com>
 <20211116112907.lbwdcz5pmgxqzv55@mobilestation> <CAK9rFny7zQRpvGOVK0+01hKQNu7XCMOz8vTfbHPs6gMR10muDw@mail.gmail.com>
 <20211117081922.nnqsr5zzzydurq5t@mobilestation>
In-Reply-To: <20211117081922.nnqsr5zzzydurq5t@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 17 Nov 2021 13:35:15 -0800
Message-ID: <CAK9rFnzJ4scTXF7pVGDuerp873K+qN_2D9C3X6pdo_TzhyE=ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller bindings
To:     Serge Semin <fancer.lancer@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergey,

On Wed, Nov 17, 2021 at 12:19 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> I was wrong using that construction here (fixup patch would be very
> welcome) seeing the "snps,dw-apb-ssi" doesn't permit having a generic
> "snps,dw*" compatible string. So just const-compatible property should
> be enough:
>
> +        compatible:
> +          const: pensando,elba-spics
>
>
> > +    then:
> > +      properties:
> > +        pensando,spics:
> > +          $ref: /schemas/types.yaml#/definitions/phandle
> > +          description:
> > +            Phandle to the system control device node which provides access to
> > +            the spics control register
> > +      required:
>
> > +        - pensando,spics
>
> Please note, I've asked to be more specific in this property naming.
> Something like this should be fine
> "pensando,elba-syscon-spics"/"pensando,syscon-spics".

I would have avoided a typo in the last reply if the spics property
was more specific.  Based on needed construction like this?

DT:
                spi0: spi@2800 {
                        compatible = "pensando,elba-spi";
                        reg = <0x0 0x2800 0x0 0x100>;
                        pensando,elba-syscon-spics = <&mssoc 0x2468>;
                        clocks = <&ahb_clk>;
                        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        num-cs = <2>;
                        status = "disabled";
                };

Binding:
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,15 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pensando,elba-spi
+    then:
+      required:
+        - pensando,elba-syscon-spics

 properties:
   compatible:
@@ -73,6 +82,8 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: Pensando Elba SoC SPI Controller
+        const: pensando,elba-spi

   reg:
     minItems: 1

Thanks,
Brad
