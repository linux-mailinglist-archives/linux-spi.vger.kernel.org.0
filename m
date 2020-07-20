Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C722696C
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbgGTQZS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 12:25:18 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59611 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbgGTQZL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jul 2020 12:25:11 -0400
X-Originating-IP: 42.109.212.217
Received: from localhost (unknown [42.109.212.217])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9F2B360007;
        Mon, 20 Jul 2020 16:25:04 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:54:56 +0530
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
Subject: Re: [PATCH v10 08/17] mtd: spi-nor: core: use dummy cycle and
 address width info from SFDP
Message-ID: <20200720162456.juud5ytn3tnbwloa@yadavpratyush.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-9-p.yadav@ti.com>
 <d4b5178e-debb-1397-caae-f20086f5c3fc@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b5178e-debb-1397-caae-f20086f5c3fc@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor,

On 08/07/20 04:03PM, Tudor.Ambarus@microchip.com wrote:
> On 6/23/20 9:30 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The xSPI Profile 1.0 table specifies how many dummy cycles and address
> > bytes are needed for the Read Status Register command in octal DTR mode.
> > Use that information to send the correct Read SR command.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 7d24e63fcca8..f2748f1d9957 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -357,6 +357,8 @@ int spi_nor_write_disable(struct spi_nor *nor)
> >  static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
> >  {
> >         int ret;
> > +       u8 addr_bytes = nor->params->rdsr_addr_nbytes;
> > +       u8 dummy = nor->params->rdsr_dummy;
> 
> no need to introduce local variables for a single dereference

Ok.
 
> > 
> >         if (nor->spimem) {
> >                 struct spi_mem_op op =
> > @@ -365,10 +367,21 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
> >                                    SPI_MEM_OP_NO_DUMMY,
> >                                    SPI_MEM_OP_DATA_IN(1, sr, 1));
> > 
> > +               if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
> > +                       op.addr.nbytes = addr_bytes;
> > +                       op.addr.val = 0;
> 
> isn't addr already initialized to 0?

Yes, it is. But I figured it won't hurt to be explicit about what we 
intend the address to be.

> > +                       op.dummy.nbytes = dummy;
> > +               }
> > +
> > +               spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> > +
> >                 ret = spi_mem_exec_op(nor->spimem, &op);
> >         } else {
> > -               ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
> > -                                                   sr, 1);
> > +               if (spi_nor_protocol_is_dtr(nor->reg_proto))
> > +                       ret = -ENOTSUPP;
> > +               else
> > +                       ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
> > +                                                           sr, 1);
> >         }
> 
> doesn't this belong to a previous patch?

It does. Will fix.
 
> > 
> >         if (ret)
> > @@ -388,6 +401,8 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
> >  static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
> >  {
> >         int ret;
> > +       u8 addr_bytes = nor->params->rdsr_addr_nbytes;
> > +       u8 dummy = nor->params->rdsr_dummy;
> > 
> >         if (nor->spimem) {
> >                 struct spi_mem_op op =
> > @@ -396,6 +411,12 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
> >                                    SPI_MEM_OP_NO_DUMMY,
> >                                    SPI_MEM_OP_DATA_IN(1, fsr, 1));
> > 
> > +               if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
> > +                       op.addr.nbytes = addr_bytes;
> > +                       op.addr.val = 0;
> > +                       op.dummy.nbytes = dummy;
> > +               }
> > +
> >                 spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> > 
> >                 ret = spi_mem_exec_op(nor->spimem, &op);

-- 
Regards,
Pratyush Yadav
