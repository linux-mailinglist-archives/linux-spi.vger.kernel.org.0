Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5166B4E21C1
	for <lists+linux-spi@lfdr.de>; Mon, 21 Mar 2022 09:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiCUINz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 21 Mar 2022 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiCUINx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Mar 2022 04:13:53 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A311BDBD;
        Mon, 21 Mar 2022 01:12:28 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id gh15so6321838qvb.8;
        Mon, 21 Mar 2022 01:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wICsFIN9ZJuas+sxL7xNcM8ZFAXB8Ijif9RKrDeIc3o=;
        b=Ee95tFL4S513s9ZfQalxeNuW6xTeCtaH8FoG/6Q8EMTwYvGk92D2R+LAftadxIJt7V
         5arZeNDins1vQ89p7glp4g1HesQxK7e1/gLPnJzzeQbCyRFPYHwNiZyhNqmnJN9id6id
         qq/4GV3L8G7eG8O4yWfCRyKd7Joc7RfFqV9f5aESEF9/CRz8WF6nqHjUW1/CgEK90TsO
         PxTCq2ZY+eGrKV80/HT8d2OTQFFJ6zfO8qel2Fa2eiXob2VVYDXsFW66bI/xk51BBdnH
         H3abW4DS7gDtREOxFM24yffCVYUxgRSrMBPWx1gkOrOS+c68BBQ9Qpf0xgTKcSRsNkFv
         pkiA==
X-Gm-Message-State: AOAM530P/HzmS6s7Qwms6+RmcsGA7791Ape7RcXXfFGbZtlUhJwUmG2a
        OX6e2/70SQGLzJ7i/2t8t0UsnkhtM/7IAQ==
X-Google-Smtp-Source: ABdhPJw4NI1PzC1GLRFeFFzq5Dl/d0qLq2B20VHWLRidpoSMbUtMaocDq/c6Sag5cKtzPoqm4yMWGQ==
X-Received: by 2002:a05:6214:f03:b0:441:27ee:ba71 with SMTP id gw3-20020a0562140f0300b0044127eeba71mr2637510qvb.88.1647850346361;
        Mon, 21 Mar 2022 01:12:26 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm10843628qtw.26.2022.03.21.01.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:12:25 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2e64a6b20eeso6956777b3.3;
        Mon, 21 Mar 2022 01:12:25 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr22987805ywb.132.1647850345315; Mon, 21
 Mar 2022 01:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
 <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com> <3bf14cf0-f00d-f718-30ea-e63272f3ce72@arm.com>
In-Reply-To: <3bf14cf0-f00d-f718-30ea-e63272f3ce72@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Mar 2022 09:12:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8iy4vMASuUgeQmjHdAMNzvCikwheyQO1-AQH0yYk0RQ@mail.gmail.com>
Message-ID: <CAMuHMdV8iy4vMASuUgeQmjHdAMNzvCikwheyQO1-AQH0yYk0RQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Robin,

On Fri, Mar 18, 2022 at 9:50 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-02-25 21:13, Heiner Kallweit wrote:
> > Add a YAML schema binding for TM1628 auxdisplay
> > (7/11-segment LED) controller.
> >
> > This patch is partially based on previous work from
> > Andreas Färber <afaerber@suse.de>.
> >
> > Co-developed-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml

> > +
> > +patternProperties:
> > +  "^.*@[1-7],([1-9]|1[0-6])$":
> > +    type: object
> > +    $ref: /schemas/leds/common.yaml#
> > +    unevaluatedProperties: false
> > +    description: |
> > +      Properties for a single LED.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          1-based grid number, followed by 1-based segment bit number.
> > +        maxItems: 1
> > +
> > +    required:
> > +      - reg
>
> I'm concerned that this leaves us no room to support the additional
> keypad functionality in future. Having now double-checked a datasheet,
> the inputs are also a two-dimensional mux (sharing the segment lines),
> so the device effectively has two distinct but numerically-overlapping
> child address spaces - one addressed by (grid,segment) and the other by
> (segment,key).

Sounds similar to HT16K33?

> Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation
> for that? I'm thinking either require an intermediate node to contain
> each notional address space, or perhaps add another leading address cell
> to select between them? I don't believe any of these things have further
> functionality beyond that.

The problem with these devices is that there are thousands of different
ways to wire them, and coming up with a generic wiring description in
DT and writing code to handle that can be very hard.

For HT16K33 non-dot-matrix wirings, I just added extra compatible
values matching the wiring of a few known devices[1].  That way the
driver can handle them efficiently.
It does have the disadvantage that adding support for new devices
means introducing more compatible values, and adding more code.

Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
