Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4835747CE5C
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 09:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhLVIgF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 22 Dec 2021 03:36:05 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49695 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbhLVIgE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 03:36:04 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 41A07240003;
        Wed, 22 Dec 2021 08:35:59 +0000 (UTC)
Date:   Wed, 22 Dec 2021 09:35:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <monstr@monstr.eu>, <thomas.petazzoni@bootlin.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <p.yadav@ti.com>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <20211222093523.30f8ae7c@xps13>
In-Reply-To: <be9d451a-6451-be58-1c2a-a9aea7f67c56@microchip.com>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
        <20211221170058.18333-3-miquel.raynal@bootlin.com>
        <a11a0650-4624-0a9f-d0a5-c45393fead7c@microchip.com>
        <20211222090542.43dfe12e@xps13>
        <be9d451a-6451-be58-1c2a-a9aea7f67c56@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor,

Tudor.Ambarus@microchip.com wrote on Wed, 22 Dec 2021 08:22:05 +0000:
> On 12/22/21 10:05 AM, Miquel Raynal wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hello Tudor,  
> 
> Hi!
> 
> > 
> > Tudor.Ambarus@microchip.com wrote on Wed, 22 Dec 2021 07:52:44 +0000:
> >   
> >> On 12/21/21 7:00 PM, Miquel Raynal wrote:  
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> Describe two new memories modes:
> >>> - A stacked mode when the bus is common but the address space extended
> >>>   with an additinals wires.
> >>> - A parallel mode with parallel busses accessing parallel flashes where
> >>>   the data is spread.
> >>>
> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>> ---
> >>>
> >>> Hello Rob,
> >>>
> >>> I know the below does not pass the tests (at least the example patch 3
> >>> does not pass) but I believe the issue is probably on the tooling side
> >>> because the exact same thing with uing32-array instead is accepted. The
> >>> problem comes from the minItems/maxItems lines. Without them, this is
> >>> okay. The maxItems btw matches the "good enough value for now" idea.
> >>>
> >>> The errors I get are:
> >>>
> >>> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-controller.yaml
> >>>   LINT    Documentation/devicetree/bindings
> >>>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> >>>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> >>>   DTEX    Documentation/devicetree/bindings/spi/spi-controller.example.dts
> >>>   DTC     Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
> >>>   CHECK   Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
> >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> >>>         From schema: /src/Documentation/devicetree/bindings/spi/spi-controller.yaml
> >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> >>>         From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'display@0', 'sensor@1', 'flash@2' were unexpected)
> >>>         From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: flash@2: stacked-memories: [[268435456, 268435456]] is too short
> >>>         From schema: /src/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>>
> >>>
> >>>  .../bindings/spi/spi-peripheral-props.yaml    | 25 +++++++++++++++++++
> >>>  1 file changed, 25 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> >>> index 5dd209206e88..fedb7ae98ff6 100644
> >>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> >>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> >>> @@ -82,6 +82,31 @@ properties:
> >>>      description:
> >>>        Delay, in microseconds, after a write transfer.
> >>>
> >>> +  stacked-memories:
> >>> +    description: Several SPI memories can be wired in stacked mode.
> >>> +      This basically means that either a device features several chip
> >>> +      selects, or that different devices must be seen as a single
> >>> +      bigger chip. This basically doubles (or more) the total address
> >>> +      space with only a single additional wire, while still needing
> >>> +      to repeat the commands when crossing a chip boundary. The size of
> >>> +      each chip should be provided as members of the array.
> >>> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> >>> +    minItems: 2
> >>> +    maxItems: 4  
> >>
> >> Why do we define maxItems? Can't we remove this restriction?  
> > 
> > Rob usually prefers to bound properties, that's why we often see "good
> > enough values for now" in the bindings. If it's no longer the case it's  
> 
> right, I saw it.
> 
> > fine to drop the maxItems property.  
> 
> There's no such hardware limitation as far as I know, that's why I've
> asked. Maybe Rob can advise.

Yes, I'll follow what Rob thinks its best:
- keeping maxItems: 4 (as it is), which is a good enough value
- dropping the maxItems here because in the end no bounding is necessary
- using maxItems: 2 to match the SPI CS even though in theory these two
  numbers are not correlated (stacked-memories might very well be
  used by other non SPI memories as well).

BTW if you're fine with the proposal your Ack is welcome ;)

Thanks,
Miquèl
