Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C6917382E
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 14:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB1NTm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 08:19:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51562 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1NTm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Feb 2020 08:19:42 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B0434296B9F;
        Fri, 28 Feb 2020 13:19:40 +0000 (GMT)
Date:   Fri, 28 Feb 2020 14:18:14 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200228141814.633c7195@collabora.com>
In-Reply-To: <20200228120750.hstohetdnqja2g2p@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-7-p.yadav@ti.com>
        <20200227175841.51435e3f@collabora.com>
        <20200228093658.zc3uifqg4zruokq3@ti.com>
        <20200228115355.5033798f@collabora.com>
        <20200228120750.hstohetdnqja2g2p@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Feb 2020 17:37:50 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

 
> > Isn't there an EXIT sequence that allows NORs to return to a single 
> > SPI state?  
> 
> Yes there is, but it comes with a lot of strings attached. There is a 
> hardware reset pin on some flashes that puts the flash in Power-on-Reset 
> (POR) mode. But that pin is not mandatory. It also might not be 
> connected on a given board.
> 
> The other option is a "Soft Reset" (also optional), which puts the flash 
> in POR mode after it is given the soft reset command. But to send the 
> command you need to know the mode the device is in. On top of that, the 
> Soft Reset opcode differs between flashes. According to the xSPI spec, 
> some flashes can have the opcode as 0xF0 and some others can have it as 
> a two command sequence of 0x66 and 0x99.
> 
> And the cherry on top is the fact that these reset operations return to 
> a state based on the value of the non-volatile bits. So, if the 
> non-volatile configuration is 8D-8D-8D mode, then all these resets 
> achieve nothing.

Looks like flash vendors don't learn from their mistakes, they keep
adding more features without really thinking about backward
compatibility :-(.

> >   
> > > 
> > >     So, the only solution I can now think of is having the flash name in 
> > >     its compatible string in the device tree. This way we can skip all 
> > >     the Read ID ugliness and can have flash-specific hooks to make it 
> > >     easier to detect the mode it is in (though I wonder if it is even 
> > >     possible to detect the mode in a flash that doesn't have SFDP in 
> > >     8D-8D-8D).  
> > 
> > Hm, I'd really like to avoid that if possible.  
> 
> Unfortunately, I don't really see a better alternative. Just so I 
> understand this better, why do you think it is something worth avoiding?

There are 2 main reasons:

1/ board manufacturers usually source their flashes from different
vendors so they're not tied to one of them. That means you can't really
make the compatible too specific or you'd have to deal with DT variants
(one variant per-flash).

2/ I feel like once we start accepting specific compats, people will
try to abuse it and decide that they need one for their flash too,
before even trying to see if there's not a different way to detect the
flash.
