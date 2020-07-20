Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4783D226773
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 18:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgGTQLs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 12:11:48 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36421 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387800AbgGTQLf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jul 2020 12:11:35 -0400
Received: from localhost (unknown [42.109.212.217])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D6FE810000E;
        Mon, 20 Jul 2020 16:11:27 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:41:23 +0530
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
Subject: Re: [PATCH v10 13/17] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Message-ID: <20200720161123.dth4rzziidpx5pmb@yadavpratyush.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-14-p.yadav@ti.com>
 <ccc128f1-2e7b-e64f-c958-ad5cc272085a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc128f1-2e7b-e64f-c958-ad5cc272085a@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor,

On 08/07/20 04:10PM, Tudor.Ambarus@microchip.com wrote:
> On 6/23/20 9:30 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Perform a Soft Reset on shutdown on flashes that support it so that the
> > flash can be reset to its initial state and any configurations made by
> > spi-nor (given that they're only done in volatile registers) will be
> > reset. This will hand back the flash in pristine state for any further
> > operations on it.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c  | 42 +++++++++++++++++++++++++++++++++++++
> >  include/linux/mtd/spi-nor.h |  2 ++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 4a1f6b343534..27ad9bab06dc 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -40,6 +40,9 @@
> > 
> >  #define SPI_NOR_MAX_ADDR_WIDTH 4
> > 
> > +#define SPI_NOR_SRST_SLEEP_MIN 200
> > +#define SPI_NOR_SRST_SLEEP_MAX 400
> > +
> >  /**
> >   * spi_nor_get_cmd_ext() - Get the command opcode extension based on the
> >   *                        extension type.
> > @@ -3201,6 +3204,41 @@ static int spi_nor_init(struct spi_nor *nor)
> >         return 0;
> >  }
> > 
> > +static void spi_nor_soft_reset(struct spi_nor *nor)
> > +{
> > +       struct spi_mem_op op;
> > +       int ret;
> > +
> > +       op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 8),
> > +                       SPI_MEM_OP_NO_DUMMY,
> > +                       SPI_MEM_OP_NO_ADDR,
> > +                       SPI_MEM_OP_NO_DATA);
> > +       spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> > +       ret = spi_mem_exec_op(nor->spimem, &op);
> > +       if (ret) {
> > +               dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> > +               return;
> > +       }
> > +
> > +       op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRST, 8),
> > +                       SPI_MEM_OP_NO_DUMMY,
> > +                       SPI_MEM_OP_NO_ADDR,
> > +                       SPI_MEM_OP_NO_DATA);
> > +       spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> > +       ret = spi_mem_exec_op(nor->spimem, &op);
> > +       if (ret) {
> > +               dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> > +               return;
> > +       }
> > +
> > +       /*
> > +        * Software Reset is not instant, and the delay varies from flash to
> > +        * flash. Looking at a few flashes, most range somewhere below 100
> > +        * microseconds. So, sleep for a range of 200-400 us.
> > +        */
> > +       usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
> > +}
> > +
> >  /* mtd resume handler */
> >  static void spi_nor_resume(struct mtd_info *mtd)
> >  {
> > @@ -3220,6 +3258,10 @@ void spi_nor_restore(struct spi_nor *nor)
> >         if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
> >             nor->flags & SNOR_F_BROKEN_RESET)
> >                 nor->params->set_4byte_addr_mode(nor, false);
> > +
> > +       if (nor->info->flags & SPI_NOR_OCTAL_DTR_READ &&
> 
> Why this limitation? Can't we make the software reset available for all
> the modes?

Because I wrote the function spi_nor_soft_reset() from the perspective 
of xSPI support, and the xSPI spec only cares about the 8D-8D-8D version 
of the soft reset.

BFPT says we can execute it on 1, 2, 4, or 8 wires depending on the mode 
so I guess we can support a generalized version as well. Will fix.

> > +           nor->flags & SNOR_F_SOFT_RESET)
> > +               spi_nor_soft_reset(nor);
> >  }
> >  EXPORT_SYMBOL_GPL(spi_nor_restore);
> > 
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index cd549042c53d..299685d15dc2 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -51,6 +51,8 @@
> >  #define SPINOR_OP_CLFSR                0x50    /* Clear flag status register */
> >  #define SPINOR_OP_RDEAR                0xc8    /* Read Extended Address Register */
> >  #define SPINOR_OP_WREAR                0xc5    /* Write Extended Address Register */
> > +#define SPINOR_OP_SRSTEN       0x66    /* Software Reset Enable */
> > +#define SPINOR_OP_SRST         0x99    /* Software Reset */
> > 
> >  /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
> >  #define SPINOR_OP_READ_4B      0x13    /* Read data bytes (low frequency) */

-- 
Regards,
Pratyush Yadav
