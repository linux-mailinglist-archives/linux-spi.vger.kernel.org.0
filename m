Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA146B628
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 09:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhLGIlC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 7 Dec 2021 03:41:02 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59543 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhLGIlC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 03:41:02 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 533BDE0014;
        Tue,  7 Dec 2021 08:37:29 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:37:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     <Tudor.Ambarus@microchip.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <monstr@monstr.eu>
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <20211207093727.5261fe66@xps13>
In-Reply-To: <20211207075721.ghwbruqcgi36fk72@ti.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
        <20211206095921.33302-3-miquel.raynal@bootlin.com>
        <20211207071406.c2ajc3shqybevvjj@ti.com>
        <0d97a420-685e-5120-3c09-d433382c02aa@microchip.com>
        <20211207075721.ghwbruqcgi36fk72@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush & Tudor,

p.yadav@ti.com wrote on Tue, 7 Dec 2021 13:27:23 +0530:

> On 07/12/21 07:35AM, Tudor.Ambarus@microchip.com wrote:
> > On 12/7/21 9:14 AM, Pratyush Yadav wrote:  
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > 
> > > On 06/12/21 10:59AM, Miquel Raynal wrote:  
> > >> Describe two new memories modes:
> > >> - A stacked mode when the bus is common but the address space extended
> > >>   with an additinals wires.
> > >> - A parallel mode with parallel busses accessing parallel flashes where
> > >>   the data is spread.
> > >>
> > >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > >> ---
> > >>  .../bindings/spi/spi-peripheral-props.yaml    | 21 +++++++++++++++++++
> > >>  1 file changed, 21 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > >> index 5dd209206e88..13aa6a2374c9 100644
> > >> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > >> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > >> @@ -82,6 +82,27 @@ properties:
> > >>      description:
> > >>        Delay, in microseconds, after a write transfer.
> > >>
> > >> +  stacked-memories:
> > >> +    type: boolean  
> > > 
> > > I don't think a boolean is enough to completely describe the memory.
> > > Sure, you say the memories are stacked, but where do you specify when to
> > > switch the CS? They could be two 512 MiB memories, two 1 GiB memories,
> > > or one 512 MiB and one 256 MiB.  
> > 
> > If the multi-die flash contains identical dies then the die boundary can be
> > determined with flash_size / number_of_cs. Are there any multi die flashes
> > with different types of dies?  
> 
> The way I see it, a multi-die flash is not much different from 2 
> independent flashes attached to the same SPI bus. So if we are going to 
> implement this feature, I want it to be generic enough to allow 
> supporting this type of hardware setup as well.
> 
> I am not aware of any flashes with a different CS for each die (that 
> isn't handled by the flash internally), let alone with different types 
> of dies. IIRC from our IRC conversation, Miquel's use case was using 2 
> smaller identical flashes connected to the same SPI bus with 1 CS each. 
> Do I remember this right Miquel?

I made the assumption that dies would be identical in order to use this
mode. However, if you think this is too risky I see two alternatives:
* Keep the bindings as I proposed and if we ever have the case, add
  another property, something like:
	stacked-memories;
	stacked-sizes = <x>, <y>;
* Merge these two properties into one:
	stacked-memories = <x>, <y>;

But TBH I prefer the former solution for these two reasons:
1/ You need to know the devices exact geometry when writing the
   bindings while this is something that is usually let to the core and
   the hardware designers.
2/ I am not sure this is really a valid use case. If we ever need to
   concatenate two devices, in particular if they are different, I
   would prefer reviving the mtd-concat series which, besides lacking a
   dynamic discovery feature, is almost ready to be used. Plus, adding
   too much complexity to the core logic (such as handling different
   die sizes) might impact negatively the overall performances even for
   simpler devices.

> > >> +    description: Several SPI memories can be wired in stacked mode.
> > >> +      This basically means that either a device features several chip
> > >> +      selects, or that different devices must be seen as a single
> > >> +      bigger chip. This basically doubles (or more) the total address
> > >> +      space with only a single additional wire, while still needing
> > >> +      to repeat the commands when crossing a chip boundary. XIP is
> > >> +      usually not supported in this mode.
> > >> +
> > >> +  parallel-memories:
> > >> +    type: boolean  
> > > 
> > > With this I assume both memories have to be the same size?  
> > 
> > It looks like the assumption for both cases is that the dies are identical.  
> 
> I would like to _not_ assume that for stacked-memories, unless 
> implementing that becomes too complicated.
> 
> >   
> > >   
> > >> +    description: Several SPI memories can be wired in parallel mode.
> > >> +      The devices are physically on a different buses but will always
> > >> +      act synchronously as each data word is spread across the
> > >> +      different memories (eg. even bits are stored in one memory, odd
> > >> +      bits in the other). This basically doubles the address space and
> > >> +      the throughput while greatly complexifying the wiring because as
> > >> +      many busses as devices must be wired. XIP is usually not
> > >> +      supported in this mode.
> > >> +
> > >>  # The controller specific properties go here.
> > >>  allOf:
> > >>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> > >> --
> > >> 2.27.0
> > >>  
> > > 
> > > --
> > > Regards,
> > > Pratyush Yadav
> > > Texas Instruments Inc.
> > >   
> >   
> 


Thanks,
Miquèl
