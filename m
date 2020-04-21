Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB41B25C2
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgDUMRf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 08:17:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33096 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUMRf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 08:17:35 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 04A992A1640;
        Tue, 21 Apr 2020 13:17:32 +0100 (BST)
Date:   Tue, 21 Apr 2020 14:17:25 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, <broonie@kernel.org>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <juliensu@mxic.com.tw>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D
 mode
Message-ID: <20200421141725.24ce5986@collabora.com>
In-Reply-To: <56365995-fe30-534f-9dbc-7307d9b9f846@ti.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
        <20200421092328.129308f6@collabora.com>
        <56365995-fe30-534f-9dbc-7307d9b9f846@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Apr 2020 15:05:08 +0530
Vignesh Raghavendra <vigneshr@ti.com> wrote:

> On 21/04/20 12:53 pm, Boris Brezillon wrote:
> > +Pratyush who's working on a similar patchet [1].
> > 
> > Hello Mason,
> > 
> > On Tue, 21 Apr 2020 14:39:42 +0800
> > Mason Yang <masonccyang@mxic.com.tw> wrote:
> >   
> >> Hello,
> >>
> >> This is repost of patchset from Boris Brezillon's
> >> [RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].  
> > 
> > I only quickly went through the patches you sent and saying it's a
> > repost of the RFC is a bit of a lie. You completely ignored the state
> > tracking I was trying to do to avoid leaving the flash in 8D mode when
> > suspending/resetting the board, and I think that part is crucial. If I
> > remember correctly, we already had this discussion so I must say I'm a
> > bit disappointed.
> > 
> > Can you sync with Pratyush? I think his series [1] is better in that it
> > tries to restore the flash in single-SPI mode before suspend (it's
> > missing the shutdown case, but that can be easily added I think). Of
> > course that'd be even better to have proper state tracking at the SPI
> > NOR level.
> >   
> 
> [1] does soft reset on shutdown which should put it to reset default
> state of 1S-1S-1S mode (if thats the POR default)

Oh ok, looks like I didn't read the patch series carefully enough.

> 
> But, there is still one open question now that we are considering
> supporting stateful modes:
> 
> What to do with flashes that power up in 8D mode either due to factory
> defaults or if 8D mode NV bit is set? Do we say SPI NOR framework won't
> support such flashes?
> Auto discovery of such flashes is quite difficult as different flashes
> use different protocols for RDID cmd in 8D mode (address phase may or
> may not be present, dummy cycles vary etc) is almost impossible w/o any
> hint passed to the driver?

I don't know yet. Looks like we'll have to pass the part-id and default
mode for those flashes (part-name being a part-specific compatible, and
boot-up mode being an extra property). But maybe we can ignore that for
now and focus on flashes booting in single SPI mode first :P.
