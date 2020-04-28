Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5F1BB93F
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgD1IyW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 04:54:22 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44813 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgD1IyW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Apr 2020 04:54:22 -0400
X-Originating-IP: 42.109.192.12
Received: from localhost (unknown [42.109.192.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C66A41C002A;
        Tue, 28 Apr 2020 08:54:15 +0000 (UTC)
Date:   Tue, 28 Apr 2020 14:24:01 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     masonccyang@mxic.com.tw
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        Pratyush Yadav <p.yadav@ti.com>, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Message-ID: <20200428085401.574wmo6qddmumd7q@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
 <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
 <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On 28/04/20 02:14PM, masonccyang@mxic.com.tw wrote:
> 
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

I didn't mean apply my patches directly. I meant more along the lines of 
edit your patches to work on top of my series. It should be as easy as 
adding your flash's fixup hooks and its octal DTR enable hook, but if my 
series is missing something you need (like complete Profile 1.0 parsing, 
which I left out because I wanted to be conservative and didn't see any 
immediate use-case for us), let me know, and we can work together to 
address it.
 
> I quickly went through your patches but can't reply them in each your 
> patches.
> 
> i.e,.
> 1) [v4,03/16] spi: spi-mem: allow specifying a command's extension
> 
> -                                u8 opcode;
> +                                u16 opcode;
> 
> big/little Endian issue, right? 
> why not just u8 ext_opcode;
> No any impact for exist code and actually only xSPI device use extension 
> command.

Boris already explained the reasoning behind it.
 
> 2) [v4,08/16] mtd: spi-nor: parse xSPI Profile 1.0 table
> 
> need extract more data from xSPI profile 1.0 table and no other specific 
> setting. 

Not sure what you mean by "no other specific setting".
 
> 3) [v4,11/16] mtd: spi-nor: enable octal DTR mode when possible
> 
> +static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +                int ret;
> +
> +                if (!nor->params->octal_dtr_enable)
> +                                return 0;
> +
> +                if (!(spi_nor_get_protocol_width(nor->read_proto) == 8 ||
> +                      spi_nor_get_protocol_width(nor->write_proto) == 8))
> +                                return 0;
> +
> +                ret = nor->params->octal_dtr_enable(nor, enable);
> +                if (ret)
> +                                return ret;
> +
> +                if (enable)
> +                                nor->reg_proto = SNOR_PROTO_8_8_8_DTR;
> +                else
> +                                nor->reg_proto = SNOR_PROTO_1_1_1;
> +
> +                return 0;
> +}
> +
> 
> it seems you enable device in Octal mode after SPI-NOR Framework is 
> already
> in Octal protocol.
> Driver should set device by SPI 1-1-1 mode to enter Octal mode and then 
> setup
> Read/PP command and protocol by spi_nor_set_read/pp_setting() for Octal 
> mode,
> right ?

No. We need to setup Read and PP settings first. The overall flow is 
that we first run spi_nor_setup(). This will perform a "negotiation" 
between the controller and the flash to find out a common protocol they 
both support, and then change to that protocol in spi_nor_init(). Even 
if the flash supports octal DTR protocol, we can't use if if the 
controller doesn't. That is why we want to first select the protocol in 
the framework, and only then change the flash to that protocol.

In case the controller doesn't support 8D-8D-8D protocol, we would want 
to use 1S-1S-1S protocol so the flash is at least usable. Changing to 8D 
mode before finding this out would make the flash unusable.

-- 
Regards,
Pratyush Yadav
