Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D547CE6B
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 09:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbhLVImA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 22 Dec 2021 03:42:00 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59731 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbhLVImA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 03:42:00 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D5D68E0007;
        Wed, 22 Dec 2021 08:41:57 +0000 (UTC)
Date:   Wed, 22 Dec 2021 09:41:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: mtd: spi-nor: Allow two CS per
 device
Message-ID: <20211222094156.7bfce4e4@xps13>
In-Reply-To: <20211222092324.7ec6ec6a@xps13>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
        <20211221170058.18333-2-miquel.raynal@bootlin.com>
        <20211221184725.46lelrdfoxeom6uc@ti.com>
        <20211222092324.7ec6ec6a@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


miquel.raynal@bootlin.com wrote on Wed, 22 Dec 2021 09:23:24 +0100:

> Hi Pratyush,
> 
> p.yadav@ti.com wrote on Wed, 22 Dec 2021 00:17:27 +0530:
> 
> > On 21/12/21 06:00PM, Miquel Raynal wrote:  
> > > The Xilinx QSPI controller has two advanced modes which allow the
> > > controller to behave differently and consider two flashes as one single
> > > storage.
> > > 
> > > One of these two modes is quite complex to support from a binding point
> > > of view and is the dual parallel memories. In this mode, each byte of
> > > data is stored in both devices: the even bits in one, the odd bits in
> > > the other. The split is automatically handled by the QSPI controller and
> > > is transparent for the user.
> > > 
> > > The other mode is simpler to support, it is called dual stacked
> > > memories. The controller shares the same SPI bus but each of the devices
> > > contain half of the data. Once in this mode, the controller does not
> > > follow CS requests but instead internally wires the two CS levels with
> > > the value of the most significant address bit.
> > > 
> > > Supporting these two modes will involve core changes which include the
> > > possibility of providing two CS for a single SPI device
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > > index 39421f7233e4..4abfb4cfc157 100644
> > > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > > @@ -47,7 +47,8 @@ properties:
> > >        identified by the JEDEC READ ID opcode (0x9F).
> > >  
> > >    reg:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2    
> > 
> > You allow up to 4 items in stacked-memories but only allow up to 2 CS, 
> > which would make the other 2 memories unusable. Should also change this 
> > to 4.  
> 
> Yes, I allowed "more" theoretical devices in the
> stacked/parallel-memories properties because there is no real
> limitation on this side so I didn't want to constrain it too much,
> while still keeping a maximum value, hence 4 seemed a nice guess for a
> "maximum but can be bigger value we don't really care it's just for
> bounding". However on the SPI side this is a big change with deep
> consequences and I don't want to rush things so it is on purpose that I
> kept the limitation to 2. But we can change the maxItems to 2
> everywhere if this appears to be the thing to do.

I forgot to mention that the stacked/parallel-memories could
also certainly be considered "memory" properties (think about the
generic term), not necessarily bound to SPI. We could definitely have
the same pattern with other memory types as well and not be tight to
the number of SPI CS.

Thanks,
Miquèl
