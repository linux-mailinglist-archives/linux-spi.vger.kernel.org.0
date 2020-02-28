Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848541735AA
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgB1KyA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 05:54:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50020 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KyA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Feb 2020 05:54:00 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 15DF9293656;
        Fri, 28 Feb 2020 10:53:58 +0000 (GMT)
Date:   Fri, 28 Feb 2020 11:53:55 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200228115355.5033798f@collabora.com>
In-Reply-To: <20200228093658.zc3uifqg4zruokq3@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-7-p.yadav@ti.com>
        <20200227175841.51435e3f@collabora.com>
        <20200228093658.zc3uifqg4zruokq3@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Feb 2020 15:06:58 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> Hi Boris,
> 
> On 27/02/20 05:58PM, Boris Brezillon wrote:
> > On Wed, 26 Feb 2020 15:06:58 +0530
> > Pratyush Yadav <p.yadav@ti.com> wrote:
> >   
> > > Double Transfer Rate (DTR) is SPI protocol in which data is transferred
> > > on each clock edge as opposed to on each clock cycle. Make
> > > framework-level changes to allow supporting flashes in DTR mode.
> > > 
> > > Right now, mixed DTR modes are not supported. So, for example a mode
> > > like 4S-4D-4D will not work. All phases need to be either DTR or STR.  
> > 
> > Didn't go deep into the patch but at first glance you don't seem to
> > extend the framework to support stateful modes as I tried to do here
> > [1]. That's really something we should address before considering
> > supporting xD-xD-xD modes, unless the SPI-NOR only supports one
> > stateful mode. If we don't do that first, we might face all sort of
> > unpleasant issues:
> > 
> > * kexec not working correctly because the previous kernel left the NOR
> >   in an unknown state
> > * suspend/resume not working properly
> > * linux not booting properly because the bootloader left the device in
> >   its non-default mode
> > * ...  
> 
> Correct. I am working on a follow-up series that takes care of these 
> problems. The series will allow spi-nor to detect what mode the flash is 
> in and then run the SFPD procedure in that mode (or maybe switch to 
> single SPI mode and then go about its business as usual? I haven't 
> figured out all the details yet).
> 
> So for the context of this series, assume we are handed the flash in 
> single SPI mode.
>  
> > [1]https://patchwork.kernel.org/cover/10638055/  
> 
> BTW, I took a quick look at this series but I don't see any code that 
> tries to detect which mode the flash is in (which is the troublesome 
> part [0]). So, for example, if the bootloader leaves the flash in 
> 8D-8D-8D mode, how would your series handle that situation?

Oh, it's definitely not taking care of that, it was just paving the
road for spi-nor state tracking. You'd need to extend it to support
8D-8D-8D to 1-1-1 transitions at boot time (if that's even possible).

> 
> [0] There are multiple problems to take care of when trying to detect 
>     which mode a flash is in. We can try reading SFDP in each mode and 
>     whichever mode gives us the correct "SFDP" signature is the mode the 
>     flash is in. But the problem is that even in xSPI standard Read SFDP 
>     command is optional in 8D-8D-8D mode, let alone non-xSPI flashes.
>     Another problem is that the address bytes and dummy cycles for Read 
>     SFDP are not the same for every flash. The xSPI standard says 
>     address bytes can be 3/4 and dummy cycles can be 8/20. So, for 
>     example, Cypress s28hs/s28ht family and Micron Xccela (mt35x) family 
>     use 4 address bytes, but the Adesto ATXP032/ATXP032R flashes use 3 
>     address bytes.

I'd rather go with something simpler and more widely supported than SFDP
reads. Don't we have a simple command that's supported by all flashes
and returns well known data. Isn't there an EXIT sequence that allows
NORs to return to a single SPI state?

> 
>     Say that a flash supports Read SFDP in 8D-8D-8D mode and we try all 
>     the combinations to find out which mode the flash is in, we now have 
>     the problem of actually identifying the flash. Unfortunately, the 
>     Read ID command is not uniform across flash vendors. The Micron 
>     Xccela flashes use 8 dummy cycles and no address bytes for Read ID. 
>     The Cypress s28hs/t family uses configurable dummy cycles 
>     (defaulting to 3) and needs 4 dummy address bytes all of which are 
>     0.

Yep, that's what I complained about when I tried to support the
Macronix flash. They didn't plan for a reliable RETURN-TO-SINGLE-SPI
sequence which would not conflict with any other existing SPI commands,
and that's a real problem.

> 
>     If we can't find out which flash it is, we can't run its fixup 
>     hooks, and might end up running it with incorrect settings. And all 
>     this is assuming a flash even has SFDP and has it available in all 
>     modes.

Absolutely.

> 
>     So, the only solution I can now think of is having the flash name in 
>     its compatible string in the device tree. This way we can skip all 
>     the Read ID ugliness and can have flash-specific hooks to make it 
>     easier to detect the mode it is in (though I wonder if it is even 
>     possible to detect the mode in a flash that doesn't have SFDP in 
>     8D-8D-8D).

Hm, I'd really like to avoid that if possible.

> 
>     Thoughts? Is there a better way to solve this problem that I didn't 
>     think of?
> 

Nope, except maybe mandate that the bootloader always put the NOR in
single SPI mode before booting Linux (and Linux should do the same,
which is what my series was trying to address IIRC).
