Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509254143D7
	for <lists+linux-spi@lfdr.de>; Wed, 22 Sep 2021 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhIVIeZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 22 Sep 2021 04:34:25 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:60021 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhIVIeZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Sep 2021 04:34:25 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 15586D3CB6;
        Wed, 22 Sep 2021 08:31:46 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E243EC0004;
        Wed, 22 Sep 2021 08:31:21 +0000 (UTC)
Date:   Wed, 22 Sep 2021 10:31:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Apurva Nandan <a-nandan@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nand: Convert to DT schema
 format
Message-ID: <20210922103121.28d489ef@xps13>
In-Reply-To: <CAL_Jsq+sg7f4pJGBhU48a4=uR7cYQmXsoSjbrktovV94m3+qFw@mail.gmail.com>
References: <20210920142713.129295-1-a-nandan@ti.com>
        <20210920142713.129295-2-a-nandan@ti.com>
        <20210920150651.vvdhennblwhdi3jw@mobilestation>
        <YUj6RUNYDoWA30Ln@robh.at.kernel.org>
        <3c03fcdd-b015-8fda-eadc-e1b6d24ba88d@ti.com>
        <CAL_Jsq+sg7f4pJGBhU48a4=uR7cYQmXsoSjbrktovV94m3+qFw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Rob, Mark,

robh@kernel.org wrote on Tue, 21 Sep 2021 14:16:02 -0500:

> On Tue, Sep 21, 2021 at 8:43 AM Apurva Nandan <a-nandan@ti.com> wrote:
> >
> > Hi Rob,
> >
> > On 21/09/21 2:46 am, Rob Herring wrote:  
> > > On Mon, Sep 20, 2021 at 06:06:51PM +0300, Serge Semin wrote:  
> > >> Hello Apurva
> > >>
> > >> On Mon, Sep 20, 2021 at 07:57:12PM +0530, Apurva Nandan wrote:  
> > >>> Convert spi-nand.txt binding to YAML format with an added example.
> > >>>
> > >>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > >>> ---
> > >>>   .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
> > >>>   .../devicetree/bindings/mtd/spi-nand.yaml     | 62 +++++++++++++++++++
> > >>>   2 files changed, 62 insertions(+), 5 deletions(-)
> > >>>   delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
> > >>>   create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml  
> > >> Thanks for the bindings conversion patch. There are several comments
> > >> below. But before addressing them it would be better to also get a
> > >> response from Rob.
> > >>  
> > >>> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
> > >>> deleted file mode 100644
> > >>> index 8b51f3b6d55c..000000000000
> > >>> --- a/Documentation/devicetree/bindings/mtd/spi-nand.txt
> > >>> +++ /dev/null
> > >>> @@ -1,5 +0,0 @@
> > >>> -SPI NAND flash
> > >>> -
> > >>> -Required properties:
> > >>> -- compatible: should be "spi-nand"
> > >>> -- reg: should encode the chip-select line used to access the NAND chip
> > >>> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > >>> new file mode 100644
> > >>> index 000000000000..601beba8d971
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > >>> @@ -0,0 +1,62 @@
> > >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >>> +%YAML 1.2
> > >>> +---
> > >>> +$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>> +
> > >>> +title: SPI NAND flash
> > >>> +
> > >>> +maintainers:
> > >>> +  - Apurva Nandan <a-nandan@ti.com>
> > >>> +
> > >>> +allOf:
> > >>> +  - $ref: "mtd.yaml#"
> > >>> +
> > >>> +properties:
> > >>> +  compatible:
> > >>> +    const: spi-nand
> > >>> +
> > >>> +  reg:
> > >>> +    maxItems: 1
> > >>> +
> > >>> +  spi-max-frequency: true
> > >>> +  spi-rx-bus-width: true
> > >>> +  spi-tx-bus-width: true
> > >>> +  rx-sample-delay-ns: true  
> > >> Since it's an SPI-client device there are more than these properties
> > >> could be set for it. See the SPI-controller bindings schema:
> > >> Documentation/devicetree/bindings/spi/spi-controller.yaml
> > >> So there is two possible ways to make it more generic:
> > >> 1) Detach the spi-client part from the spi-controller.yaml bindings
> > >> into a dedicated DT-schema file and refer to that new scheme from
> > >> here.  
> > > Yes, as mentioned there's patches doing this. But the above is fine.
> > > There's some value in defining here which properties are valid.  
> > Yeah right  
> > >> 2) Forget about these controller-specific properties and let the
> > >> parental SPI-controller bindings parsing them. Of course there must be
> > >> at least one of the next properties declared for it to work:
> > >> {unevaluatedProperties, additionalProperties}.
> > >>
> > >> It's up to Rob to decided which approach is better though...
> > >>  
> > >>> +
> > >>> +  '#address-cells': true
> > >>> +  '#size-cells': true  
> > >> Aren't they always equal to 1?  
> > > No SPI nand devices >4GB?  
> > Yeah, we have SPI NANDs >4GB, and "'#address-cells': true" allows those
> > sizes.  
> > >  
> > >>> +
> > >>> +additionalProperties:
> > >>> +  type: object  
> > >> I'd suggest to elaborate the way the partition sub-nodes looks
> > >> like, for instance, the node names, supported compatible names,
> > >> labels, etc.  
> > > That should probably all be in mtd.yaml. The question here is whether
> > > partitions are always under a 'partitions' node. Maybe this is new
> > > enough that only the new way has to be supported. Though if mtd.yaml
> > > supported both forms, allowing both all the time is okay IMO.
> > >
> > > Rob  
> >
> > I had added the "partition" node properties in the v1 patch, but as per
> > the reviews I removed it.
> > I think we can prefer having them in mtd.yaml if needed, in a separate
> > patch series.
> > Do you prefer the mtd.yaml changes as a part of this series or as a
> > separate patch?
> >
> > Other than that, I don't find any need for a v3 patch re-roll, do you agree?  
> 
> Yeah, I suppose not.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> And actually, it's Miquel that should apply these 2 rather than Mark.

Yeah, but that's fine for this one, I don't expect conflicts anyway.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
