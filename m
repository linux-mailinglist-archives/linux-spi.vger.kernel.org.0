Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C64D6C1B51
	for <lists+linux-spi@lfdr.de>; Mon, 20 Mar 2023 17:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCTQYa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 20 Mar 2023 12:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjCTQYN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Mar 2023 12:24:13 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C67366BB;
        Mon, 20 Mar 2023 09:17:11 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id r5so13704896qtp.4;
        Mon, 20 Mar 2023 09:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU12f+vPMvEhFHISO9GFf1PVW/V1JjwDrJX6/nQgB0M=;
        b=K1IbLXOnn+ydDKkHR0dQxvbYPinGO3CcobjW6HQJmwQOXWZXQCCm8TdBAMv2BU8mIp
         Yh2GCLFx2VYQyE8JLcQMuUKklYQsnoGl+/HZOKNad1NXYBL0wTZYZ0+CdYVtzBjbSf/l
         osueTVVEKWvPy0ILfW+Vx0W8clQ/bEJQrEeXeFNIyOWHBBUXCvKXEgQSF7ZcWoNShZcz
         PTzEFNyVlmRKMw6U8YHTYWUHuT5qHjRNG/MBxupSK+QaOcWekEjprXMsq6sFmEs1ANuw
         qA7AbOLLbTJYJ0TAQap1Vy+Y7pZUsHSmwB8K1hW9TD+Ve54bI8la0PFHJV0bV65uv2Si
         cNHw==
X-Gm-Message-State: AO0yUKVv3Ng89dTN8te9+ClQ0hIV5vo4OEFKnUPVOfgua3aWmC7DvgH4
        mblraeeDE3sOAev4szyoSFywbmfSlpQPaA==
X-Google-Smtp-Source: AK7set8qsrQymzOrUc8HrZbJ6rwg4yYKGU+XhyKYT9eD7tIm3ulgFbIJ9zaSfXKT3BZKAS6773uxHQ==
X-Received: by 2002:a05:622a:1829:b0:3e2:ccf9:bfa0 with SMTP id t41-20020a05622a182900b003e2ccf9bfa0mr3816568qtc.49.1679329028966;
        Mon, 20 Mar 2023 09:17:08 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c9-20020ac853c9000000b003e37dac7eb5sm418013qtq.87.2023.03.20.09.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:17:08 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e194so13773505ybf.1;
        Mon, 20 Mar 2023 09:17:08 -0700 (PDT)
X-Received: by 2002:a5b:d0f:0:b0:b3b:6576:b22b with SMTP id
 y15-20020a5b0d0f000000b00b3b6576b22bmr5929917ybp.12.1679329028181; Mon, 20
 Mar 2023 09:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <052af97ecbaa9ba6e0d406883dd3389fa397579a.1678891999.git.geert+renesas@glider.be>
 <20230320160521.GA1771933-robh@kernel.org>
In-Reply-To: <20230320160521.GA1771933-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Mar 2023 17:16:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9U+tPfeU1=K-PZd2O=jeFewvJNqarOyNM2ge+vSBa1g@mail.gmail.com>
Message-ID: <CAMuHMdX9U+tPfeU1=K-PZd2O=jeFewvJNqarOyNM2ge+vSBa1g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,sh-msiof: Miscellaneous improvements
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On Mon, Mar 20, 2023 at 5:07 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 15, 2023 at 03:54:07PM +0100, Geert Uytterhoeven wrote:
> > Make "clocks" and "power-domains" required everywhere.
> > Make "resets" required on R-Car Gen2 and newer (i.e. all but SH-Mobile).
>
> Breaking the ABI is fine because ???

This does not break the ABI, as all related DTS already have these properties.
This just aligns the bindings with reality.

> > Update the example to match reality:
> >   - Use interrupt binding definitions instead of hardcoded numbers,
> >   - Convert to new-style CPG/MSSR bindings,
> >   - Add missing "power-domains" and "resets" properties.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  .../bindings/spi/renesas,sh-msiof.yaml        | 23 +++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> > index 491a695a2deb3b83..00acbbb0f65dcf57 100644
> > --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> > +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> > @@ -149,23 +149,38 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > +  - clocks
> > +  - power-domains
> >    - '#address-cells'
> >    - '#size-cells'
> >
> > +if:
> > +  not:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          const: renesas,sh-mobile-msiof
> > +then:
> > +  required:
> > +    - resets
> > +
> >  unevaluatedProperties: false
> >
> >  examples:
> >    - |
> > -    #include <dt-bindings/clock/r8a7791-clock.h>
> > -    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/power/r8a7791-sysc.h>
> >
> >      msiof0: spi@e6e20000 {
> >          compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
> >          reg = <0xe6e20000 0x0064>;
> > -        interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
> > -        clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
> > +        interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&cpg CPG_MOD 000>;
> >          dmas = <&dmac0 0x51>, <&dmac0 0x52>;
> >          dma-names = "tx", "rx";
> > +        power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
> > +        resets = <&cpg 0>;
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >      };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
