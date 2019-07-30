Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6978C7B133
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2019 20:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfG3SEQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Jul 2019 14:04:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387822AbfG3SEQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Jul 2019 14:04:16 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 42CCA28B8F9;
        Tue, 30 Jul 2019 19:04:14 +0100 (BST)
Date:   Tue, 30 Jul 2019 20:04:10 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <bbrezillon@kernel.org>, <tudor.ambarus@microchip.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [RFC v1 0/3] *spi-mem: adding setup and callback function
Message-ID: <20190730200410.72b2f7d3@collabora.com>
In-Reply-To: <d8adef3f-e901-2e25-6183-35cb1e53bcda@ti.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
        <20190729172859.4374a2ad@collabora.com>
        <CAP6Zq1iPXDX_Gtz6ZWYm3JoHgHjdapotVLGw-Lq4tc2X-6eAug@mail.gmail.com>
        <20190730085438.6fe0480b@collabora.com>
        <d8adef3f-e901-2e25-6183-35cb1e53bcda@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 30 Jul 2019 23:18:25 +0530
Vignesh Raghavendra <vigneshr@ti.com> wrote:

> On 30-Jul-19 12:24 PM, Boris Brezillon wrote:
> > Trimmed the recipient list a bit and used Frieder's new address.
> > +Sergey
> > 
> > On Mon, 29 Jul 2019 23:55:05 +0300
> > Tomer Maimon <tmaimon77@gmail.com> wrote:
> >   
> >> Hi Boris,
> >>
> >> Thanks for the prompt reply,
> >>
> >>
> >>
> >> On Mon, 29 Jul 2019 at 18:29, Boris Brezillon <boris.brezillon@collabora.com>
> >> wrote:
> >>  
> >>> Hi Tomer,
> >>>
> >>> On Mon, 29 Jul 2019 17:25:01 +0300
> >>> Tomer Maimon <tmaimon77@gmail.com> wrote:
> >>>    
> >>>> Lately we have working on Flash interface unit (FIU) SPI driver that
> >>>> using spi-mem interface, Our FIU HW module support direct Flash Rd//Wr.
> >>>>
> >>>> In our SOC (32 bit dual core ARM) we have 3 FIU's that using memory    
> >>> mapping as follow:    
> >>>>
> >>>> FIU0 - have 2 chip select and each one have 128MB memory mapping (total    
> >>> 256MB memory mapping)    
> >>>> FIU1 - have 4 chip select and each one have 128MB memory mapping (total    
> >>> 512MB memory mapping)    
> >>>> FIU2 - have 4 chip select and each one have 16MB memory mapping (total    
> >>> 32MB memory mapping)    
> >>>>
> >>>> Totally 800MB memory mapping.
> >>>>
> >>>> When the FIU driver probe it don't know the size of each Flash that
> >>>> connected to the FIU, so the entire memory mapping is allocated for each    
> >>> FIU    
> >>>> according the FIU device tree memory map parameters.    
> >>>
> >>> Do you need those mappings to be active to support simple reg accesses?
> >>>    
> >>>> It means, if we enable all three FIU's the drivers will try to allocate    
> >>> totally 800MB.    
> >>>>
> >>>> In 32bit system it is problematic because the kernel have only 1GB
> >>>> of memory allocation so the vmalloc cannot take 800MB.
> >>>>
> >>>> When implementing the FIU driver in the mtd/spi-nor we allocating memory    
> >>> address only    
> >>>> for detected Flash with exact size (usually we are not using 128MB    
> >>> Flash), and in that case usually we allocating much less memory.    
> >>>>
> >>>> To solve this issue we needed to overcome two things:
> >>>>
> >>>> 1.    Get argument from the upper layer (spi-mem layer)
> >>>> 2.    Calling the get argument function after SPI_NOR_SCAN function.    
> >>> (the MTD Flash size filled in  SPI_NOR_SCAN function)
> >>>
> >>> That's clearly breaking the layering we've tried to restore with the
> >>> spi-nor/spi-mem split, and I don't see why this is needed since we now
> >>> have a way to create direct mappings dynamically (with the dirmap API).
> >>> Have you tried implementing the dirmap hooks in your driver?    
> >>
> >>
> >>  Sorry but I wasn't familiar with the direct mapping in the spi-mem, it
> >> seems it needed to implemented in the m25p80 driver as well, am I correct?  
> > 
> > There's this patch [1] floating around. IIRC, Sergey was waiting for
> > the m25p80 -> spi-nor merge to send a v5. Vignesh, any updates on that
> > one? If you don't have time to work on that, maybe Sergey could send a
> > v5.
> >   
> 
> I did send an updated series of merging m25p80 to spi-nor last week and
> have received few comments. Will respin one more version this week
> (mostly by tomorrow).

Okay, great!
