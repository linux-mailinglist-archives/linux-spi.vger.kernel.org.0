Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2531C51F7
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEJcu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 05:32:50 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:21370 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgEEJct (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 05:32:49 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 0459VjeU090585;
        Tue, 5 May 2020 17:31:45 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 2E9C939369600D8DEBAD;
        Tue,  5 May 2020 17:31:46 +0800 (CST)
In-Reply-To: <20200429181856.kkavelcczylg4yxf@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw> <20200421092328.129308f6@collabora.com> <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com> <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw> <20200428085401.574wmo6qddmumd7q@yadavpratyush.com> <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw> <20200429181856.kkavelcczylg4yxf@yadavpratyush.com>
To:     "Pratyush Yadav" <me@yadavpratyush.com>
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        "Pratyush Yadav" <p.yadav@ti.com>, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
MIME-Version: 1.0
X-KeepSent: 28AE0642:4F34D6BB-4825855F:002D6E58;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF28AE0642.4F34D6BB-ON4825855F.002D6E58-4825855F.003458C9@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 5 May 2020 17:31:45 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/05/05 PM 05:31:46,
        Serialize complete at 2020/05/05 PM 05:31:46
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 0459VjeU090585
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Pratyush,

> > > > > 
> > > > > I posted a re-roll of my series here [0]. Could you please base 
your 
> > 
> > > > > changes on top of it? Let me know if the series is missing 
something 
> > you 
> > > > 
> > > > > need.
> > > > > 
> > > > > [0] 
> > > > 
> > 
https://lore.kernel.org/linux-mtd/20200424184410.8578-1-p.yadav@ti.com/
> > > > 
> > > > 
> > > > Our mx25uw51245g supports BFPT DWORD-18,19 and 20 data and xSPI 
> > profile 
> > > > 1.0,
> > > > and it comply with BFPT DWORD-19, octal mode enable sequences by 
write 
> > CFG 
> > > > Reg2 
> > > > with instruction 0x72. Therefore, I can't apply your patches.
> > > 
> > > I didn't mean apply my patches directly. I meant more along the 
lines of 
> > 
> > > edit your patches to work on top of my series. It should be as easy 
as 
> > > adding your flash's fixup hooks and its octal DTR enable hook, but 
if my 
> > 
> > > series is missing something you need (like complete Profile 1.0 
parsing, 
> > 
> > > which I left out because I wanted to be conservative and didn't see 
any 
> > > immediate use-case for us), let me know, and we can work together to 

> > > address it.
> > 
> > yes,sure!
> > let's work together to upstream the Octal 8D-8D-8D driver to mainline.
> > 
> > The main concern is where and how to enable xSPI octal mode?
> > 
> > Vignesh don't agree to enable it in fixup hooks and that's why I 
patched
> > it to spi_nor_late_init_params() and confirmed the device support xSPI 

> > Octal mode after BFPT DWORD-19 and xSPI pf 1.0 have been parsed.
> 
> My series does it in a octal_dtr_enable() hook, which is called from 
> spi_nor_init(). Just like how it is done for quad_enable(). So, the 
> expectation is that you populate the octal DTR hook for your flash in a 
> flash-specific hook (like the default_init() fixup hook). Example of 
> this can be seen in patches 15 and 16 of my series in 
> spi_nor_cypress_octal_enable() and spi_nor_micron_octal_dtr_enable().
> 
> An alternative for this would be a generic way to enable these flashes, 
> like from BFPT DWORD 19. That doesn't work for either of the flashes I 
> had, so I didn't implement it because I wouldn't be able to test it. If 
> it works for you, please implement it. I don't mind doing it myself, but 

> then you would need to help me test it.
> 
> > I can't apply your patches to enable xSPI Octal mode for mx25uw51245g 
> > because your patches set up Octal protocol first and then using Octal 
> > protocol to write Configuration Register 2(CFG Reg2). I think driver
> > should write CFG Reg2 in SPI 1-1-1 mode (power on state) and make sure
> > write CFG Reg 2 is success and then setup Octa protocol in the last.
> 
> Register writes should work in 1S mode, because nor->reg_proto is only 
> set _after_ 8D mode is enabled (see spi_nor_octal_dtr_enable()). In 
> fact, both patch 15 and 16 in my series use register writes in 1S mode.

but I didn't see driver roll back "nor->read/write_proto = 1" 
if xxx->octal_dtr_enable() return failed!

> 
> > As JESD216F description on BFPT DOWRD 19th, only two way to enable 
> > xSPI Octal mode;
> > one is by two instruction: issue instruction 06h(WREN) and then E8h.
> > the other is issue instruction 06h, then issue instruction 72h (Write
> > CFG Reg2), address 0h and data 02h (8D-8D-8D).
> > 
> > Let our patches comply with this. you may refer to my patches
> > [v2,3/5] mtd: spi-nor: Parse BFPT DWORD-18, 19 and 20 for Octal 
8D-8D-8D 
> > mode
> 
> The Cypress Semper S28 flash family says that it does not have an Octal 
> Enable bit (i.e, the Octal Enable Requirements field is 0), even though 
> it does have an Octal Enable bit. That bit resides in CFG Reg 5. And the 

> Micron MT35ABA family, doesn't have DWORD19 in their BFPT at all. So, 
> the two flashes I need to support don't have this. At the very least, we 

> need to provide a flash-specific way to enable Octal DTR mode, along 
> with an xSPI compliant way.
> 
> So I suggest that we have two separate type of 8D enable functions. One 
> type which is generic and works on any xSPI complint device, like the 
> spi_nor_cfg_reg2_octal_enable() in your patch. The other would be 
> flash-specific ones, which flashes can set in their fixup hooks.

okay, sure.

> 
> >                  /* Octal mode enable sequences. */
> >                  switch (bfpt.dwords[BFPT_DWORD(19)] & 
> > BFPT_DWORD19_OCTAL_SEQ_MASK) {
> >                  case BFPT_DWORD19_TWO_INST:
> > +       ----> to patch here.
> >                                  break;
> >                  case BFPT_DWORD19_CFG_REG2:
> >                                  params->xspi_enable = 
> > spi_nor_cfg_reg2_octal_enable;
> >                                  break;
> >                  default:
> >                                  break;
> >                  }
> > 
> > 
> > > 
> > > > I quickly went through your patches but can't reply them in each 
your 
> > > > patches.
> > > > 
> > > > i.e,.
> > > > 1) [v4,03/16] spi: spi-mem: allow specifying a command's extension
> > > > 
> > > > -                                u8 opcode;
> > > > +                                u16 opcode;
> > > > 
> > > > big/little Endian issue, right? 
> > > > why not just u8 ext_opcode;
> > > > No any impact for exist code and actually only xSPI device use 
> > extension 
> > > > command.
> > > 
> > > Boris already explained the reasoning behind it.
> > 
> > yup, I got his point and please make sure CPU data access.
> > 
> > i.e,.
> > Fix endianness of the BFPT DWORDs and xSPI in sfdp.c
> > 
> > and your patch,
> > +                                ext = spi_nor_get_cmd_ext(nor, op);
> > +                                op->cmd.opcode = (op->cmd.opcode << 
8) | 
> > ext;
> > +                                op->cmd.nbytes = 2;
> > 
> > I think maybe using u8 opcode[2] could avoid endianness.
> 
> Again, thanks Boris for answering this. FWIW, I don't see anything wrong 

> with his suggestion.
> 
> To clarify a bit more, the idea is that we transmit the opcode MSB 
> first, just we do for the address. Assume we want to issue the command 
> 0x05. In 1S mode, we set cmd.opcode to 0x05. Here cmd.nbytes == 1. Treat 

> is as a 1-byte value, so the MSB is the same as the LSB. We directly 
> send 0x5 on the bus.

There are many SPI controllers driver use "op->cmd.opcode" directly,
so is spi-mxic.c.

i.e,.
ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, op->cmd.nbytes);

> 
> If cmd.nbytes == 2, then the opcode would be 0x05FA (assuming extension 
> is invert of command). So we send the MSB (0x05) first, and LSB (0xFA) 
> next.

My platform is Xilinx Zynq platform which CPU is ARMv7 processor.

In 1-1-1 mode, it's OK to send 1 byte command by u16 opcode but
in 8D-8D-8D mode, I need to patch

i.e.,
op->cmd.opcode = op->cmd.opcode | (ext << 8);

rather than your patch.


> 
> In all this, I don't see where endianness comes into the picture. While 
> the _location_ of the MSB in memory may change because of the 
> endianness, the MSB of the _number_ will always be 0x05. So, regardless 
> of the endianness, the operation (opcode >> 8) should always give 0x05 
> and (opcode & F) should always give 0xFA. Endianness is just how you 
> represent these values in memory.
> 

thanks & best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

