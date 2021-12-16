Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F62477546
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhLPPCc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Dec 2021 10:02:32 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:58805 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhLPPCb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 10:02:31 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4046F200003;
        Thu, 16 Dec 2021 15:02:28 +0000 (UTC)
Date:   Thu, 16 Dec 2021 16:02:26 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <20211216160226.4fac5ccc@xps13>
In-Reply-To: <YbjVSNAC8M5Y1nHp@robh.at.kernel.org>
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
        <20211210201039.729961-3-miquel.raynal@bootlin.com>
        <YbjVSNAC8M5Y1nHp@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Tue, 14 Dec 2021 11:32:56 -0600:

> On Fri, Dec 10, 2021 at 09:10:38PM +0100, Miquel Raynal wrote:
> > Describe two new memories modes:
> > - A stacked mode when the bus is common but the address space extended
> >   with an additinals wires.
> > - A parallel mode with parallel busses accessing parallel flashes where
> >   the data is spread.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/spi/spi-peripheral-props.yaml    | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 5dd209206e88..4194fee8f556 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -82,6 +82,35 @@ properties:
> >      description:
> >        Delay, in microseconds, after a write transfer.
> >  
> > +  stacked-memories:
> > +    $ref: /schemas/types.yaml#/definitions/uint64-matrix  
> 
> matrix or...
> 
> > +    description: Several SPI memories can be wired in stacked mode.
> > +      This basically means that either a device features several chip
> > +      selects, or that different devices must be seen as a single
> > +      bigger chip. This basically doubles (or more) the total address
> > +      space with only a single additional wire, while still needing
> > +      to repeat the commands when crossing a chip boundary. The size of
> > +      each chip should be provided as members of the array.  
> 
> array?
> 
> Sounds like an array from the description as there is only 1 element, 
> the size.

Well, what I expected to have was something like:

dt:		<property> = <uint64>, <uint64>;

It seemed like the only possible way (that the tooling would validate)
was to use:

bindings:	$ref: /schemas/types.yaml#/definitions/uint64-matrix

So I assumed I was defining a matrix of AxB elements, where A is the
number of devices I want to "stack" and B is the number of values
needed to describe its size, so 1.

I realized that the following example, which I was expecting to work,
was failing:

bindings:	$ref: /schemas/types.yaml#/definitions/uint64-array
dt:		<property> = <uint64>, <uint64>;

Indeed, as you propose, this actually works but describes two values
(tied somehow) into a single element, which is not exactly what I
wanted:

bindings: 	$ref: /schemas/types.yaml#/definitions/uint64-array
dt:		<property> = <uint64 uint64>;

But more disturbing, all the following constructions worked, when using
32-bits values instead:

bindings: 	$ref: /schemas/types.yaml#/definitions/uint32-array
dt:		<property> = <uint32 uint32>;

bindings: 	$ref: /schemas/types.yaml#/definitions/uint32-array
dt:		<property> = <uint32>, <uint32>;

bindings: 	$ref: /schemas/types.yaml#/definitions/uint32-matrix
dt:		<property> = <uint32 uint32>;

bindings: 	$ref: /schemas/types.yaml#/definitions/uint32-matrix
dt:		<property> = <uint32>, <uint32>;

I am fine waiting a bit if you think there is a need for some tooling
update on your side. Otherwise, do you really think that this solution
is the one we should really use?

bindings: 	$ref: /schemas/types.yaml#/definitions/uint64-array
dt:		<property> = <uint64 uint64>;

Because from my point of view it does not match what we usually do for
other "types" of elements, such as:

dt:		<property> = <phandle1 index1>, <phandle2 index2>;

or

dt:		<property> = <small-val1>, <small-val2>;

> 
> > +    minItems: 2
> > +    maxItems: 2
> > +    items:
> > +      maxItems: 1  
> 
> This says you can only have 2 64-bit entries. Probably not what you 
> want. This looks like a case for a maxItems 'should be enough for now' 
> type of value.

Yes, that is what I wanted to describe.

In my recent contributions you always preferred to bound things as much
as possible, even though later it might become necessary to loosen the
constraint. Right now I see the use of these properties for 2 devices,
but in theory there is no limit.

Of course if we switch to the array representation I suppose I should
stick to:

+    minItems: 2
+    maxItems: 2

> 
> > +
> > +  parallel-memories:
> > +    $ref: /schemas/types.yaml#/definitions/uint64-matrix
> > +    description: Several SPI memories can be wired in parallel mode.
> > +      The devices are physically on a different buses but will always
> > +      act synchronously as each data word is spread across the
> > +      different memories (eg. even bits are stored in one memory, odd
> > +      bits in the other). This basically doubles the address space and
> > +      the throughput while greatly complexifying the wiring because as
> > +      many busses as devices must be wired. The size of each chip should
> > +      be provided as members of the array.
> > +    minItems: 2
> > +    maxItems: 2
> > +    items:
> > +      maxItems: 1
> > +
> >  # The controller specific properties go here.
> >  allOf:
> >    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> > -- 
> > 2.27.0
> > 
> >   


Thanks,
Miquèl
