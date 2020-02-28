Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B451736CD
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 13:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgB1MIL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 07:08:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41046 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1MIL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Feb 2020 07:08:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01SC7q2Q043838;
        Fri, 28 Feb 2020 06:07:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582891672;
        bh=RVaHyNziJFILc4NB6NRDkwB5/daSs+z4c/gyOlgD+ek=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rwh+g20QW552RFvkuCgcRs2jkBFBcKp1jWgUlrjkZP2STi0TluWsZ7xTV9LCC4+Bx
         pzbeyaYAFOcFeznfcNEala2/LgYUWxU5ZTZVmIOHPW7cG3mQv525pyt/auXufiOsp1
         7LJHiZQZkHrKpmoctpQac93cH35T/gv4Jd+3atx8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01SC7qOn075668
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 06:07:52 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 06:07:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 06:07:51 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01SC7o7x085695;
        Fri, 28 Feb 2020 06:07:51 -0600
Date:   Fri, 28 Feb 2020 17:37:50 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200228120750.hstohetdnqja2g2p@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-7-p.yadav@ti.com>
 <20200227175841.51435e3f@collabora.com>
 <20200228093658.zc3uifqg4zruokq3@ti.com>
 <20200228115355.5033798f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200228115355.5033798f@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/02/20 11:53AM, Boris Brezillon wrote:
> On Fri, 28 Feb 2020 15:06:58 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
> 
> > Hi Boris,
> > 
> > On 27/02/20 05:58PM, Boris Brezillon wrote:
> > > On Wed, 26 Feb 2020 15:06:58 +0530
> > > Pratyush Yadav <p.yadav@ti.com> wrote:
> > >   
> > > > Double Transfer Rate (DTR) is SPI protocol in which data is transferred
> > > > on each clock edge as opposed to on each clock cycle. Make
> > > > framework-level changes to allow supporting flashes in DTR mode.
> > > > 
> > > > Right now, mixed DTR modes are not supported. So, for example a mode
> > > > like 4S-4D-4D will not work. All phases need to be either DTR or STR.  
> > > 
> > > Didn't go deep into the patch but at first glance you don't seem to
> > > extend the framework to support stateful modes as I tried to do here
> > > [1]. That's really something we should address before considering
> > > supporting xD-xD-xD modes, unless the SPI-NOR only supports one
> > > stateful mode. If we don't do that first, we might face all sort of
> > > unpleasant issues:
> > > 
> > > * kexec not working correctly because the previous kernel left the NOR
> > >   in an unknown state
> > > * suspend/resume not working properly
> > > * linux not booting properly because the bootloader left the device in
> > >   its non-default mode
> > > * ...  
> > 
> > Correct. I am working on a follow-up series that takes care of these 
> > problems. The series will allow spi-nor to detect what mode the flash is 
> > in and then run the SFPD procedure in that mode (or maybe switch to 
> > single SPI mode and then go about its business as usual? I haven't 
> > figured out all the details yet).
> > 
> > So for the context of this series, assume we are handed the flash in 
> > single SPI mode.
> >  
> > > [1]https://patchwork.kernel.org/cover/10638055/  
> > 
> > BTW, I took a quick look at this series but I don't see any code that 
> > tries to detect which mode the flash is in (which is the troublesome 
> > part [0]). So, for example, if the bootloader leaves the flash in 
> > 8D-8D-8D mode, how would your series handle that situation?
> 
> Oh, it's definitely not taking care of that, it was just paving the
> road for spi-nor state tracking. You'd need to extend it to support
> 8D-8D-8D to 1-1-1 transitions at boot time (if that's even possible).
> 
> > 
> > [0] There are multiple problems to take care of when trying to detect 
> >     which mode a flash is in. We can try reading SFDP in each mode and 
> >     whichever mode gives us the correct "SFDP" signature is the mode the 
> >     flash is in. But the problem is that even in xSPI standard Read SFDP 
> >     command is optional in 8D-8D-8D mode, let alone non-xSPI flashes.
> >     Another problem is that the address bytes and dummy cycles for Read 
> >     SFDP are not the same for every flash. The xSPI standard says 
> >     address bytes can be 3/4 and dummy cycles can be 8/20. So, for 
> >     example, Cypress s28hs/s28ht family and Micron Xccela (mt35x) family 
> >     use 4 address bytes, but the Adesto ATXP032/ATXP032R flashes use 3 
> >     address bytes.
> 
> I'd rather go with something simpler and more widely supported than SFDP
> reads. Don't we have a simple command that's supported by all flashes
> and returns well known data.

I'm not aware of any other command that would return well-known data.

> Isn't there an EXIT sequence that allows NORs to return to a single 
> SPI state?

Yes there is, but it comes with a lot of strings attached. There is a 
hardware reset pin on some flashes that puts the flash in Power-on-Reset 
(POR) mode. But that pin is not mandatory. It also might not be 
connected on a given board.

The other option is a "Soft Reset" (also optional), which puts the flash 
in POR mode after it is given the soft reset command. But to send the 
command you need to know the mode the device is in. On top of that, the 
Soft Reset opcode differs between flashes. According to the xSPI spec, 
some flashes can have the opcode as 0xF0 and some others can have it as 
a two command sequence of 0x66 and 0x99.

And the cherry on top is the fact that these reset operations return to 
a state based on the value of the non-volatile bits. So, if the 
non-volatile configuration is 8D-8D-8D mode, then all these resets 
achieve nothing.
 
> > 
> >     Say that a flash supports Read SFDP in 8D-8D-8D mode and we try all 
> >     the combinations to find out which mode the flash is in, we now have 
> >     the problem of actually identifying the flash. Unfortunately, the 
> >     Read ID command is not uniform across flash vendors. The Micron 
> >     Xccela flashes use 8 dummy cycles and no address bytes for Read ID. 
> >     The Cypress s28hs/t family uses configurable dummy cycles 
> >     (defaulting to 3) and needs 4 dummy address bytes all of which are 
> >     0.
> 
> Yep, that's what I complained about when I tried to support the
> Macronix flash. They didn't plan for a reliable RETURN-TO-SINGLE-SPI
> sequence which would not conflict with any other existing SPI commands,
> and that's a real problem.
> 
> > 
> >     If we can't find out which flash it is, we can't run its fixup 
> >     hooks, and might end up running it with incorrect settings. And all 
> >     this is assuming a flash even has SFDP and has it available in all 
> >     modes.
> 
> Absolutely.
> 
> > 
> >     So, the only solution I can now think of is having the flash name in 
> >     its compatible string in the device tree. This way we can skip all 
> >     the Read ID ugliness and can have flash-specific hooks to make it 
> >     easier to detect the mode it is in (though I wonder if it is even 
> >     possible to detect the mode in a flash that doesn't have SFDP in 
> >     8D-8D-8D).
> 
> Hm, I'd really like to avoid that if possible.

Unfortunately, I don't really see a better alternative. Just so I 
understand this better, why do you think it is something worth avoiding?
 
> > 
> >     Thoughts? Is there a better way to solve this problem that I didn't 
> >     think of?
> > 
> 
> Nope, except maybe mandate that the bootloader always put the NOR in
> single SPI mode before booting Linux (and Linux should do the same,
> which is what my series was trying to address IIRC).

A simple bootloader might not even have a SPI driver. So, if the flash 
PORs to 8D-8D-8D, Linux would be unable to use the flash.

Or, if the ROM puts the flash in 8D-8D-8D mode for better boot speed, we 
would have the same problem.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
