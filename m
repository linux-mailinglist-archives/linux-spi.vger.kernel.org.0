Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4EB1BE619
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2STI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 14:19:08 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47331 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2STH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Apr 2020 14:19:07 -0400
X-Originating-IP: 42.109.203.126
Received: from localhost (unknown [42.109.203.126])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 73CB21C000D;
        Wed, 29 Apr 2020 18:19:00 +0000 (UTC)
Date:   Wed, 29 Apr 2020 23:48:56 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     masonccyang@mxic.com.tw
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        Pratyush Yadav <p.yadav@ti.com>, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Message-ID: <20200429181856.kkavelcczylg4yxf@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
 <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
 <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
 <20200428085401.574wmo6qddmumd7q@yadavpratyush.com>
 <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On 29/04/20 03:31PM, masonccyang@mxic.com.tw wrote:
> Hi Pratyush,
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

My series does it in a octal_dtr_enable() hook, which is called from 
spi_nor_init(). Just like how it is done for quad_enable(). So, the 
expectation is that you populate the octal DTR hook for your flash in a 
flash-specific hook (like the default_init() fixup hook). Example of 
this can be seen in patches 15 and 16 of my series in 
spi_nor_cypress_octal_enable() and spi_nor_micron_octal_dtr_enable().

An alternative for this would be a generic way to enable these flashes, 
like from BFPT DWORD 19. That doesn't work for either of the flashes I 
had, so I didn't implement it because I wouldn't be able to test it. If 
it works for you, please implement it. I don't mind doing it myself, but 
then you would need to help me test it.
 
> I can't apply your patches to enable xSPI Octal mode for mx25uw51245g 
> because your patches set up Octal protocol first and then using Octal 
> protocol to write Configuration Register 2(CFG Reg2). I think driver
> should write CFG Reg2 in SPI 1-1-1 mode (power on state) and make sure
> write CFG Reg 2 is success and then setup Octa protocol in the last.

Register writes should work in 1S mode, because nor->reg_proto is only 
set _after_ 8D mode is enabled (see spi_nor_octal_dtr_enable()). In 
fact, both patch 15 and 16 in my series use register writes in 1S mode.
 
> As JESD216F description on BFPT DOWRD 19th, only two way to enable 
> xSPI Octal mode;
> one is by two instruction: issue instruction 06h(WREN) and then E8h.
> the other is issue instruction 06h, then issue instruction 72h (Write
> CFG Reg2), address 0h and data 02h (8D-8D-8D).
> 
> Let our patches comply with this. you may refer to my patches
> [v2,3/5] mtd: spi-nor: Parse BFPT DWORD-18, 19 and 20 for Octal 8D-8D-8D 
> mode

The Cypress Semper S28 flash family says that it does not have an Octal 
Enable bit (i.e, the Octal Enable Requirements field is 0), even though 
it does have an Octal Enable bit. That bit resides in CFG Reg 5. And the 
Micron MT35ABA family, doesn't have DWORD19 in their BFPT at all. So, 
the two flashes I need to support don't have this. At the very least, we 
need to provide a flash-specific way to enable Octal DTR mode, along 
with an xSPI compliant way.

So I suggest that we have two separate type of 8D enable functions. One 
type which is generic and works on any xSPI complint device, like the 
spi_nor_cfg_reg2_octal_enable() in your patch. The other would be 
flash-specific ones, which flashes can set in their fixup hooks.
 
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

Again, thanks Boris for answering this. FWIW, I don't see anything wrong 
with his suggestion.

To clarify a bit more, the idea is that we transmit the opcode MSB 
first, just we do for the address. Assume we want to issue the command 
0x05. In 1S mode, we set cmd.opcode to 0x05. Here cmd.nbytes == 1. Treat 
is as a 1-byte value, so the MSB is the same as the LSB. We directly 
send 0x5 on the bus.

If cmd.nbytes == 2, then the opcode would be 0x05FA (assuming extension 
is invert of command). So we send the MSB (0x05) first, and LSB (0xFA) 
next.

In all this, I don't see where endianness comes into the picture. While 
the _location_ of the MSB in memory may change because of the 
endianness, the MSB of the _number_ will always be 0x05. So, regardless 
of the endianness, the operation (opcode >> 8) should always give 0x05 
and (opcode & F) should always give 0xFA. Endianness is just how you 
represent these values in memory.
 
> Moreover, Vignesh think it's fine to use u8 ext_opcode in my v1 patches.
> please check his comments on
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1573808288-19365-3-git-send-email-masonccyang@mxic.com.tw/ 

In fact, that's how I did it in the first version of my series as well, 
but refactored it on Boris's suggestion.
 
> Let's open this discussion and maybe Vighesh and Tudor could have some 
> comments on it.
> thanks a lot.
> 
> > 
> > > 2) [v4,08/16] mtd: spi-nor: parse xSPI Profile 1.0 table
> > > 
> > > need extract more data from xSPI profile 1.0 table and no other 
> specific 
> > > setting. 
> > 
> > Not sure what you mean by "no other specific setting".
> 
> I mean this function just do xSPI profile 1.0 table parse, no read/pp 
> setting
> i.e,.
> 
> +                /*
> +                 * Update the fast read settings. We set the default 
> dummy cycles to 20
> +                 * here. Flashes can change this value if they need to 
> when enabling
> +                 * octal mode.
> +                 */
> +                params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> + spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
> +                                                                  0, 20, 
> opcode,
> + SNOR_PROTO_8_8_8_DTR);
> +
> +                /*
> +                 * Since the flash supports xSPI DTR reads, it should 
> also support DTR
> +                 * Page Program opcodes.
> +                 */
> +                params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;

Ok. Fair enough.
 
> 
> > 
> > > 3) [v4,11/16] mtd: spi-nor: enable octal DTR mode when possible
> > > 
> > > +static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
> > > +{
> > > +                int ret;
> > > +
> > > +                if (!nor->params->octal_dtr_enable)
> > > +                                return 0;
> > > +
> > > +                if (!(spi_nor_get_protocol_width(nor->read_proto) == 
> 8 ||
> > > +                      spi_nor_get_protocol_width(nor->write_proto) == 
> 8))
> > > +                                return 0;
> > > +
> > > +                ret = nor->params->octal_dtr_enable(nor, enable);
> > > +                if (ret)
> > > +                                return ret;
> > > +
> > > +                if (enable)
> > > +                                nor->reg_proto = 
> SNOR_PROTO_8_8_8_DTR;
> > > +                else
> > > +                                nor->reg_proto = SNOR_PROTO_1_1_1;
> > > +
> > > +                return 0;
> > > +}
> > > +
> > > 
> > > it seems you enable device in Octal mode after SPI-NOR Framework is 
> > > already
> > > in Octal protocol.
> > > Driver should set device by SPI 1-1-1 mode to enter Octal mode and 
> then 
> > > setup
> > > Read/PP command and protocol by spi_nor_set_read/pp_setting() for 
> Octal 
> > > mode,
> > > right ?
> > 
> > No. We need to setup Read and PP settings first. The overall flow is 
> > that we first run spi_nor_setup(). This will perform a "negotiation" 
> > between the controller and the flash to find out a common protocol they 
> > both support, and then change to that protocol in spi_nor_init(). Even 
> > if the flash supports octal DTR protocol, we can't use if if the 
> > controller doesn't. That is why we want to first select the protocol in 
> > the framework, and only then change the flash to that protocol.
> > 
> > In case the controller doesn't support 8D-8D-8D protocol, we would want 
> > to use 1S-1S-1S protocol so the flash is at least usable. Changing to 8D 
> 
> > mode before finding this out would make the flash unusable.
> > 
> 
> as my concern above.

I hope my answer above clears this up.

-- 
Regards,
Pratyush Yadav
