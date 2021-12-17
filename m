Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2540478B99
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 13:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhLQMjk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 07:39:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36540 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhLQMjk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Dec 2021 07:39:40 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BHCdBfJ107898;
        Fri, 17 Dec 2021 06:39:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639744751;
        bh=FAu+99gnOYXsg8Iibj0K87OAsF32t/5ttw3obRFik6g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mjgOFnMe4T6TZbBLv7RmhiefzGfP4lgrvktSCnoQmYMDup82s/kBd/bPvaV80CKYW
         iqnf/iw5HFfuaKmxEsGmrOEl3oryNa/L9M9CO4mXfU53/qxoH4Sx6UCtPxZGZ8V3xr
         8ZfLBH/fXA/lx25gjm26f4E0EsIHRxCOY/JpVkII=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BHCdBmY041776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Dec 2021 06:39:11 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Dec 2021 06:39:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Dec 2021 06:39:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BHCdAqP064527;
        Fri, 17 Dec 2021 06:39:11 -0600
Date:   Fri, 17 Dec 2021 18:09:10 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <20211217123908.wmki3tlnk3k4nxha@ti.com>
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
 <20211210201039.729961-3-miquel.raynal@bootlin.com>
 <20211214194431.4kpwfgvju6msh5d4@ti.com>
 <20211216172544.2005d96e@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211216172544.2005d96e@xps13>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/12/21 05:25PM, Miquel Raynal wrote:
> Hello Pratyush,
> 
> p.yadav@ti.com wrote on Wed, 15 Dec 2021 01:14:33 +0530:
> 
> > Hi Miquel,
> > 
> > On 10/12/21 09:10PM, Miquel Raynal wrote:
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
> > Why matrix? Can't you use array here? Sorry, I am not much familiar with 
> > JSON schema.
> 
> Yes, Rob also opened the discussion, I've answered there on this point,
> but I agree, this should be define as an array, but the current tooling
> refused to accept what I wanted from a dt-writing point of view. More
> on that on the dedicated thread.
> 
> > > +    description: Several SPI memories can be wired in stacked mode.
> > > +      This basically means that either a device features several chip
> > > +      selects, or that different devices must be seen as a single
> > > +      bigger chip. This basically doubles (or more) the total address
> > > +      space with only a single additional wire, while still needing
> > > +      to repeat the commands when crossing a chip boundary. The size of
> > > +      each chip should be provided as members of the array.
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +    items:
> > > +      maxItems: 1  
> > 
> > Thanks. This looks better to me.
> > 
> > But before we go ahead, I think there has been some confusion around 
> > what exactly your patches intend to support. Let's clear them up first. 
> > What type of setup do you want to support?
> 
> Before I try to clarify your questions below, the setup that I have is:
> 
> Xilinx ZynqMP QSPI controller + 2 flashes.
> 
> What I want to describe is the specific handling of what the Xilinx
> QSPI controller is able to do. This controller has two modes when wired
> to more than one flash:
> - stacked
> - parallel
> 
> I have not entered the documentation nor the code in details yet, but I
> believe that handling two flashes in the stacked configuration, besides
> a couple of possible optimizations that are possible by the hardware,
> is close to what any controller would do. Maybe there is one difference
> though, when in the "stacked" mode, this controller treats the two
> flashes as a single one, so that is why, if we want to support this
> "advanced" mode, we *need* a way to know that this mode should be used
> because the controller expects a wider range of addresses.

Ok.

> 
> About the parallel configuration, there is absolutely no doubt that we
> have no other choice than describing how the data is spread across two
> devices. We don't really care about the manner, but the controller
> needs to know how to assert the two CS internally so this definitely
> something that needs to be described.

Yes. And with device sizes as part of the property we should be able to 
do this.

> 
> Now the question you might ask is, why do we define these properties as
> flash properties then? And this is a real good question, I think both
> actually work as long as we consider that we can only have either a
> spi-memory or any other type of device on a single bus, but not both at
> the same time. In v1 I proposed a controller property. Mark proposed to
> switch for a device property which I did in v2 onward.

I also think making it a device property makes more sense. You are 
describing how the flashes are laid out, which is independent of the 
controller. With the same SoC, I could have one board with a single 
flash and another with a dual-die flash.

> 
> >   1. One single flash but with multiple dies, with each die sitting on a 
> >      different CS.
> 
> Yes.
> 
> >   2. Two (or more) identical but independent flash memories to be 
> >      treated as one.
> 
> Yes.
> 
> >   3. Two (or more) different and independent flash memories to be 
> >      treated as one.
> 
> I don't know. My first proposal excluded these, but I believe we can
> handle them with the change your proposed (the device size as part of
> the property).
> 
> > In our earlier exchanges you said you want to support 2. And when I 
> > wanted you to account for 3 as well you said we should use mtdconcat for 
> > that.
> 
> Not that we should, but that we could because from a core perspective
> it's way more challenging than supporting identical devices. But the
> conversation drifted about the software backend that we should use
> rather than on the actual description, because mtdconcat is not a
> feature which benefits from any kind of description yet, so even if we
> use mtdconcat as backed, we will need some kind of description here as
> well. So, as I told previously, I am fine considering these setups
> in my proposal, that's why I updated my proposal to include the
> devices size, even though that is way out of scope compared to my
> initial target.

Right, and I appreciate that :-)

> 
> But here we are talking about driver code, which has nothing to do with
> the bindings. If we focus on the bindings, I believe the solution with
> the sizes covers all cases.

I think it is important to discuss _how_ we would implement this in the 
driver because this could help identify flaws or shortcomings in the 
bindings. In this case, I agree with you that the solution with sizes 
should cover all 3 cases and we now have lot more flexibility in how we 
design the driver.

> 
> > So my question is, why can't we use mtdconcat for 2 as well, since 
> > it is just a special case of 3? And if we are using mtdconcat, then why 
> > do we need this at all? Shouldn't you then choose the chip at MTD layer 
> > and use the respective SPI device to get the CS value, which would make 
> > this property useless?
> 
> Reason 1:
> As depicted above, while the stacked mode might more or less
> fit the mtdconcat idea, it is absolutely not the case for the parallel
> mode.

Right. My question was mostly about the stacked mode.

> 
> Reason 2:
> mtdconcat is a software backend. Here we are discussing bindings.
> No matter what backed we finally pick, there will be the need for a
> proper description and so far there has been no binding for mtdconcat
> (even though I tried to push in favor of it a while ago without
> success). So no matter what software solution we we adopt, we
> *will* need an upstream binding description at some point. But
> mtdconcat really means "there are two devices we want to consider as a
> single". While here the point is: we have two devices that get
> abstracted by the controller, and we still must describe that.
> 
> > I can see this making sense for case 1. For that case you said you don't 
> > have an existing datasheet or device to propose. And if there is no real 
> > device doing it I see little point in figuring out a binding for it.
> 
> Yes, because somewhat we focused the debate over the devices, while I
> was initially talking about a controller abstraction. There is (at
> least) one controller doing such abstractions, the Xilinx ZynqMP
> generic QSPI controller, the spec is public (chapter 24):
> https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf

I think this _is_ a device problem first. The controller part should be 
easy to do once we solve the device problem. Once we clearly describe 
how the devices are laid out it should be simple for the controller side 
to figure out what to do.

> 
> I hope all this clarifies the situation!

Thanks. I am quite happy with this patch. I'll drop my R-by once you 
figure out what type to use with these properties in v5.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
