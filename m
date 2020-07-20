Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE52268D5
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgGTQVj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 12:21:39 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:57597 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732740AbgGTQVj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jul 2020 12:21:39 -0400
Received: from localhost (unknown [42.109.212.217])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 05B42100006;
        Mon, 20 Jul 2020 16:21:32 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:51:30 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, broonie@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        matthias.bgg@gmail.com, michal.simek@xilinx.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, boris.brezillon@collabora.com,
        nsekhar@ti.com
Subject: Re: [PATCH v10 12/17] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Message-ID: <20200720162130.hknyyclgndjokqly@yadavpratyush.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-13-p.yadav@ti.com>
 <5f9a93d0-833c-8976-c6d3-2043e65b1b66@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9a93d0-833c-8976-c6d3-2043e65b1b66@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor,

On 08/07/20 04:08PM, Tudor.Ambarus@microchip.com wrote:
> On 6/23/20 9:30 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > A Soft Reset sequence will return the flash to Power-on-Reset (POR)
> > state. It consists of two commands: Soft Reset Enable and Soft Reset.
> > Find out if the sequence is supported from BFPT DWORD 16.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.h | 1 +
> >  drivers/mtd/spi-nor/sfdp.c | 4 ++++
> >  drivers/mtd/spi-nor/sfdp.h | 2 ++
> >  3 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index 6338d32a0d77..79ce952c0539 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -26,6 +26,7 @@ enum spi_nor_option_flags {
> >         SNOR_F_HAS_SR_TB_BIT6   = BIT(11),
> >         SNOR_F_HAS_4BIT_BP      = BIT(12),
> >         SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
> > +       SNOR_F_SOFT_RESET       = BIT(14),
> >  };
> > 
> >  struct spi_nor_read_command {
> > diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> > index 7983ff431346..8e0741d8bfd3 100644
> > --- a/drivers/mtd/spi-nor/sfdp.c
> > +++ b/drivers/mtd/spi-nor/sfdp.c
> > @@ -616,6 +616,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
> >                 break;
> >         }
> > 
> > +       /* Soft Reset support. */
> > +       if (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_SOFT_RST)
> 
> this can be improved. There are multiple reset methods described and you're
> addressing just one of them.

Yes, it can be. But xSPI only cares about the 0x66 and 0x99 reset 
sequence and that is what I implemented. Others can be added if they are 
needed in the future. In addition, I don't have hardware that supports 
these resets so I can't test them. IMO if someone needs other reset 
modes, they should send a separate patch for it.

If you are worried about future work needed to support multiple soft 
reset modes, I can introduce a nor->soft_reset() hook that can be 
populated when parsing BFPT. But I think that is a bit premature. The 
work needed to do that is not a lot so I think we should hold off until 
the need really comes up.
 
> > +               nor->flags |= SNOR_F_SOFT_RESET;
> > +
> >         /* Stop here if not JESD216 rev C or later. */
> >         if (bfpt_header->length == BFPT_DWORD_MAX_JESD216B)
> >                 return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
> > diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> > index 6d7243067252..8ae55e98084e 100644
> > --- a/drivers/mtd/spi-nor/sfdp.h
> > +++ b/drivers/mtd/spi-nor/sfdp.h
> > @@ -90,6 +90,8 @@ struct sfdp_bfpt {
> >  #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD                (0x4UL << 20)
> >  #define BFPT_DWORD15_QER_SR2_BIT1              (0x5UL << 20) /* Spansion */
> > 
> > +#define BFPT_DWORD16_SOFT_RST                  BIT(12)
> > +
> >  #define BFPT_DWORD18_CMD_EXT_MASK              GENMASK(30, 29)
> >  #define BFPT_DWORD18_CMD_EXT_REP               (0x0UL << 29) /* Repeat */
> >  #define BFPT_DWORD18_CMD_EXT_INV               (0x1UL << 29) /* Invert */

-- 
Regards,
Pratyush Yadav
