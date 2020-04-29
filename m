Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC91BD766
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD2Ihe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 04:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbgD2Ihe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Apr 2020 04:37:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52EC03C1AD;
        Wed, 29 Apr 2020 01:37:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 862B52A205F;
        Wed, 29 Apr 2020 09:37:31 +0100 (BST)
Date:   Wed, 29 Apr 2020 10:37:27 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     "Pratyush Yadav" <me@yadavpratyush.com>, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, "Pratyush Yadav" <p.yadav@ti.com>,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D
 mode
Message-ID: <20200429103727.20835000@collabora.com>
In-Reply-To: <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
        <20200421092328.129308f6@collabora.com>
        <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
        <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
        <20200428085401.574wmo6qddmumd7q@yadavpratyush.com>
        <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 29 Apr 2020 15:31:35 +0800
masonccyang@mxic.com.tw wrote:

> Hi Pratyush,
> 
>  
> > > > > On Tue, 21 Apr 2020 14:39:42 +0800
> > > > > Mason Yang <masonccyang@mxic.com.tw> wrote:
> > > > >   
> > > > > > Hello,
> > > > > > 
> > > > > > This is repost of patchset from Boris Brezillon's
> > > > > > [RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].  
> > > > > 
> > > > > I only quickly went through the patches you sent and saying it's a
> > > > > repost of the RFC is a bit of a lie. You completely ignored the   
> state
> > > > > tracking I was trying to do to avoid leaving the flash in 8D mode   
> when
> > > > > suspending/resetting the board, and I think that part is crucial.   
> If I
> > > > > remember correctly, we already had this discussion so I must say   
> I'm a
> > > > > bit disappointed.
> > > > > 
> > > > > Can you sync with Pratyush? I think his series [1] is better in   
> that 
> > > it  
> > > > > tries to restore the flash in single-SPI mode before suspend (it's
> > > > > missing the shutdown case, but that can be easily added I think).   
> Of
> > > > > course that'd be even better to have proper state tracking at the   
> SPI
> > > > > NOR level.  
> > > > 
> > > > Hi Mason,
> > > > 
> > > > I posted a re-roll of my series here [0]. Could you please base your   
> 
> > > > changes on top of it? Let me know if the series is missing something   
> you 
> > >   
> > > > need.
> > > > 
> > > > [0]   
> > >   
> https://lore.kernel.org/linux-mtd/20200424184410.8578-1-p.yadav@ti.com/
> > > 
> > > 
> > > Our mx25uw51245g supports BFPT DWORD-18,19 and 20 data and xSPI   
> profile 
> > > 1.0,
> > > and it comply with BFPT DWORD-19, octal mode enable sequences by write   
> CFG 
> > > Reg2 
> > > with instruction 0x72. Therefore, I can't apply your patches.  
> > 
> > I didn't mean apply my patches directly. I meant more along the lines of   
> 
> > edit your patches to work on top of my series. It should be as easy as 
> > adding your flash's fixup hooks and its octal DTR enable hook, but if my   
> 
> > series is missing something you need (like complete Profile 1.0 parsing,   
> 
> > which I left out because I wanted to be conservative and didn't see any 
> > immediate use-case for us), let me know, and we can work together to 
> > address it.  
> 
> yes,sure!
> let's work together to upstream the Octal 8D-8D-8D driver to mainline.
> 
> The main concern is where and how to enable xSPI octal mode?
> 
> Vignesh don't agree to enable it in fixup hooks and that's why I patched
> it to spi_nor_late_init_params() and confirmed the device support xSPI 
> Octal mode after BFPT DWORD-19 and xSPI pf 1.0 have been parsed.
> 
> I can't apply your patches to enable xSPI Octal mode for mx25uw51245g 
> because your patches set up Octal protocol first and then using Octal 
> protocol to write Configuration Register 2(CFG Reg2). I think driver
> should write CFG Reg2 in SPI 1-1-1 mode (power on state) and make sure
> write CFG Reg 2 is success and then setup Octa protocol in the last.
> 
> As JESD216F description on BFPT DOWRD 19th, only two way to enable 
> xSPI Octal mode;
> one is by two instruction: issue instruction 06h(WREN) and then E8h.
> the other is issue instruction 06h, then issue instruction 72h (Write
> CFG Reg2), address 0h and data 02h (8D-8D-8D).
> 
> Let our patches comply with this. you may refer to my patches
> [v2,3/5] mtd: spi-nor: Parse BFPT DWORD-18, 19 and 20 for Octal 8D-8D-8D 
> mode
> 
>                  /* Octal mode enable sequences. */
>                  switch (bfpt.dwords[BFPT_DWORD(19)] & 
> BFPT_DWORD19_OCTAL_SEQ_MASK) {
>                  case BFPT_DWORD19_TWO_INST:
> +       ----> to patch here.
>                                  break;
>                  case BFPT_DWORD19_CFG_REG2:
>                                  params->xspi_enable = 
> spi_nor_cfg_reg2_octal_enable;
>                                  break;
>                  default:
>                                  break;
>                  }
> 
> 
> >   
> > > I quickly went through your patches but can't reply them in each your 
> > > patches.
> > > 
> > > i.e,.
> > > 1) [v4,03/16] spi: spi-mem: allow specifying a command's extension
> > > 
> > > -                                u8 opcode;
> > > +                                u16 opcode;
> > > 
> > > big/little Endian issue, right? 
> > > why not just u8 ext_opcode;
> > > No any impact for exist code and actually only xSPI device use   
> extension 
> > > command.  
> > 
> > Boris already explained the reasoning behind it.  
> 
> yup, I got his point and please make sure CPU data access.
> 
> i.e,.
> Fix endianness of the BFPT DWORDs and xSPI in sfdp.c
> 
> and your patch,
> +                                ext = spi_nor_get_cmd_ext(nor, op);
> +                                op->cmd.opcode = (op->cmd.opcode << 8) | 
> ext;
> +                                op->cmd.nbytes = 2;
> 
> I think maybe using u8 opcode[2] could avoid endianness.
> 

Again, if there's an endianness issue it's in your SPI driver, not
here, and I suspect you'd have the same issue with the address cycles.
SPI mem protocols has been using big endian for everything, and I think
that should be applied to dual-byte opcodes too.

> Moreover, Vignesh think it's fine to use u8 ext_opcode in my v1 patches.
> please check his comments on
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1573808288-19365-3-git-send-email-masonccyang@mxic.com.tw/ 
> 
> 
> 
> Let's open this discussion and maybe Vighesh and Tudor could have some 
> comments on it.

Changing for opcode[2] would mean patching all spi-mem drivers. That's
doable, but given we already have the address field encoded in a u64, I
don't see a good reason to not apply that rule to the opcode.
