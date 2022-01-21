Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68852496268
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbiAUPzA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 10:55:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59750 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381716AbiAUPyp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 10:54:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF5E3B82069;
        Fri, 21 Jan 2022 15:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702A0C340E8;
        Fri, 21 Jan 2022 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642780482;
        bh=W6JQ5Nrf5iKsKOcSh7js6ozGbm0zYldeWMnxl9nkzI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y9b/j8jCfnDEtWqXSjQixUIaaex2V8cVeBiGAxsVkEL5Cy+Ugx8hqKMYjAC0VyS8o
         7mVe75ffmtuy6jFEZ37XCBgQkd1hzjN4mis8a8AKPwAPdSst+7RmbC2ECqjWFO8Wm7
         0WfgjZ/COrfeRMJjf9Np6JkZcVYx5XUnCG+itUQODvSesjdFcqr7+kF0xx3Ihx2fu2
         uySDyGWXLeC10xG2zSX1CaOdubNq9Z/wKpWtckaiHjN4n7CDr/8mnmDJDP8FUK1djx
         Ed5ue6nhZg8nIxEAGdPl/wRTOgKjagQcEJ+quS8JpJEW2Tx3oprBNBz+xC6JBuSNx/
         3x+R2emK+pUCQ==
Received: by mail-ed1-f48.google.com with SMTP id j2so43520067edj.8;
        Fri, 21 Jan 2022 07:54:42 -0800 (PST)
X-Gm-Message-State: AOAM531vSOFxRCcL9nGG1qfvzQKlZJqIpB6nKyGMOdASxrGEMNIVY0Bc
        45vxIA4dDwv7VKB7e6XuvuDrL8sphP+btwrg4g==
X-Google-Smtp-Source: ABdhPJzYJb7CGgIlw5eKMhAtTOQCT21R37klTn5qVypYYorVvi9kcdGhIlWutFCXWm9RH+msRAlMSDDN75krE4EHUY0=
X-Received: by 2002:aa7:dc05:: with SMTP id b5mr4833806edu.46.1642780480572;
 Fri, 21 Jan 2022 07:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
 <20211210201039.729961-3-miquel.raynal@bootlin.com> <YbjVSNAC8M5Y1nHp@robh.at.kernel.org>
 <20211216160226.4fac5ccc@xps13>
In-Reply-To: <20211216160226.4fac5ccc@xps13>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Jan 2022 09:54:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1X1V8UUHgfKaSbhZLtche3bqnCj62jFRVWzQLEc3hng@mail.gmail.com>
Message-ID: <CAL_Jsq+1X1V8UUHgfKaSbhZLtche3bqnCj62jFRVWzQLEc3hng@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 16, 2021 at 9:02 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Rob,
>
> robh@kernel.org wrote on Tue, 14 Dec 2021 11:32:56 -0600:
>
> > On Fri, Dec 10, 2021 at 09:10:38PM +0100, Miquel Raynal wrote:
> > > Describe two new memories modes:
> > > - A stacked mode when the bus is common but the address space extended
> > >   with an additinals wires.
> > > - A parallel mode with parallel busses accessing parallel flashes where
> > >   the data is spread.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../bindings/spi/spi-peripheral-props.yaml    | 29 +++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > index 5dd209206e88..4194fee8f556 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > @@ -82,6 +82,35 @@ properties:
> > >      description:
> > >        Delay, in microseconds, after a write transfer.
> > >
> > > +  stacked-memories:
> > > +    $ref: /schemas/types.yaml#/definitions/uint64-matrix
> >
> > matrix or...
> >
> > > +    description: Several SPI memories can be wired in stacked mode.
> > > +      This basically means that either a device features several chip
> > > +      selects, or that different devices must be seen as a single
> > > +      bigger chip. This basically doubles (or more) the total address
> > > +      space with only a single additional wire, while still needing
> > > +      to repeat the commands when crossing a chip boundary. The size of
> > > +      each chip should be provided as members of the array.
> >
> > array?
> >
> > Sounds like an array from the description as there is only 1 element,
> > the size.
>
> Well, what I expected to have was something like:
>
> dt:             <property> = <uint64>, <uint64>;

The downside to this is you really need:

property = /bits/ 64 <uint64>, /bits/ 64 <uint64>;

And I just fixed some examples that had:

property = /bits/ 64 <uint64>, <uint64>;

The property length there is 12 bytes. That aspect of the syntax is
really not obvious. I only realized that somewhat recently.

You can even do:

property = /bits/ 64 <uint64>, "a string", /bits/ 8 <uint8>;

While dts syntax allows this, our sanity does not.

> It seemed like the only possible way (that the tooling would validate)
> was to use:
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint64-matrix
>
> So I assumed I was defining a matrix of AxB elements, where A is the
> number of devices I want to "stack" and B is the number of values
> needed to describe its size, so 1.

Yeah, that's well reasoned and I agree. The other array case is you
have N values where each value represents different data rather than
instances of the same data. The challenge is for the schema fixups to
recognize which is which without saying the schema must look like
exactly X or Y as there will be exceptions.

> I realized that the following example, which I was expecting to work,
> was failing:
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint64-array
> dt:             <property> = <uint64>, <uint64>;
>
> Indeed, as you propose, this actually works but describes two values
> (tied somehow) into a single element, which is not exactly what I
> wanted:
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint64-array
> dt:             <property> = <uint64 uint64>;
>
> But more disturbing, all the following constructions worked, when using
> 32-bits values instead:
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint32-array
> dt:             <property> = <uint32 uint32>;
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint32-array
> dt:             <property> = <uint32>, <uint32>;
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint32-matrix
> dt:             <property> = <uint32 uint32>;
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint32-matrix
> dt:             <property> = <uint32>, <uint32>;

That works because there's some really ugly code to transform the
schema into both forms.

> I am fine waiting a bit if you think there is a need for some tooling
> update on your side. Otherwise, do you really think that this solution
> is the one we should really use?
>
> bindings:       $ref: /schemas/types.yaml#/definitions/uint64-array
> dt:             <property> = <uint64 uint64>;

Because of the /bits/ issue, yes.

More importantly, the bracketing in dts files is not going to matter
soon (from a validation perspective). I'm working on moving validation
from using the yaml encoded DT (which depends on and preserves
brackets) to using dtbs. This will use the schemas to decode the
property values into the right format/type.


> Because from my point of view it does not match what we usually do for
> other "types" of elements, such as:
>
> dt:             <property> = <phandle1 index1>, <phandle2 index2>;
>
> or
>
> dt:             <property> = <small-val1>, <small-val2>;
>
> >
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +    items:
> > > +      maxItems: 1
> >
> > This says you can only have 2 64-bit entries. Probably not what you
> > want. This looks like a case for a maxItems 'should be enough for now'
> > type of value.
>
> Yes, that is what I wanted to describe.
>
> In my recent contributions you always preferred to bound things as much
> as possible, even though later it might become necessary to loosen the
> constraint. Right now I see the use of these properties for 2 devices,
> but in theory there is no limit.

Ok, as long as we're not loosening it frequently.

Rob
