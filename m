Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B041BB6C6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgD1Ge2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 02:34:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45578 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgD1Ge2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Apr 2020 02:34:28 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5A18127E99E;
        Tue, 28 Apr 2020 07:34:26 +0100 (BST)
Date:   Tue, 28 Apr 2020 08:34:23 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     "Pratyush Yadav" <me@yadavpratyush.com>, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, "Pratyush Yadav" <p.yadav@ti.com>,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D
 mode
Message-ID: <20200428083423.4fafd187@collabora.com>
In-Reply-To: <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
        <20200421092328.129308f6@collabora.com>
        <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
        <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 28 Apr 2020 14:14:31 +0800
masonccyang@mxic.com.tw wrote:

> Hi Pratyush,
> 
> > > On Tue, 21 Apr 2020 14:39:42 +0800
> > > Mason Yang <masonccyang@mxic.com.tw> wrote:
> > >   
> > > > Hello,
> > > > 
> > > > This is repost of patchset from Boris Brezillon's
> > > > [RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].  
> > > 
> > > I only quickly went through the patches you sent and saying it's a
> > > repost of the RFC is a bit of a lie. You completely ignored the state
> > > tracking I was trying to do to avoid leaving the flash in 8D mode when
> > > suspending/resetting the board, and I think that part is crucial. If I
> > > remember correctly, we already had this discussion so I must say I'm a
> > > bit disappointed.
> > > 
> > > Can you sync with Pratyush? I think his series [1] is better in that   
> it
> > > tries to restore the flash in single-SPI mode before suspend (it's
> > > missing the shutdown case, but that can be easily added I think). Of
> > > course that'd be even better to have proper state tracking at the SPI
> > > NOR level.  
> > 
> > Hi Mason,
> > 
> > I posted a re-roll of my series here [0]. Could you please base your 
> > changes on top of it? Let me know if the series is missing something you   
> 
> > need.
> > 
> > [0]    
> https://lore.kernel.org/linux-mtd/20200424184410.8578-1-p.yadav@ti.com/
> 
> 
> Our mx25uw51245g supports BFPT DWORD-18,19 and 20 data and xSPI profile 
> 1.0,
> and it comply with BFPT DWORD-19, octal mode enable sequences by write CFG 
> Reg2 
> with instruction 0x72. Therefore, I can't apply your patches.
> 
> I quickly went through your patches but can't reply them in each your 
> patches.

Why?!! Aren't you registered to the MTD mailing list? Sorry but having
reviews outside of the original thread is far from ideal. Please find a
way to reply to the original patchset.

> 
> i.e,.
> 1) [v4,03/16] spi: spi-mem: allow specifying a command's extension
> 
> -                                u8 opcode;
> +                                u16 opcode;
> 
> big/little Endian issue, right?

There's no endianness issue since it's SPI controller responsibility to
interpret this field.
 
> why not just u8 ext_opcode;

Because I see the ext_ext_code comimg, and it's also more consistent
with the addr field if we use an u16 and a number of cmd cycles.

> No any impact for exist code and actually only xSPI device use extension 
> command.

And extending the opcode field to an u16 has no impact either.

