Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4517A227EE7
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgGULaE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 07:30:04 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35689 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGULaD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 07:30:03 -0400
Received: from localhost (unknown [106.76.68.110])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B83E924000E;
        Tue, 21 Jul 2020 11:29:54 +0000 (UTC)
Date:   Tue, 21 Jul 2020 16:59:51 +0530
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
Subject: Re: [PATCH v10 05/17] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200721112951.rngfk7njubcsahzp@yadavpratyush.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-6-p.yadav@ti.com>
 <fbb3d7e7-75ed-dbf6-a975-2ae871bc9fbf@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb3d7e7-75ed-dbf6-a975-2ae871bc9fbf@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor,

On 07/07/20 05:37PM, Tudor.Ambarus@microchip.com wrote:
> Hi, Pratyush,
> 
> On 6/23/20 9:30 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Double Transfer Rate (DTR) is SPI protocol in which data is transferred
> > on each clock edge as opposed to on each clock cycle. Make
> > framework-level changes to allow supporting flashes in DTR mode.
> > 
> > Right now, mixed DTR modes are not supported. So, for example a mode
> > like 4S-4D-4D will not work. All phases need to be either DTR or STR.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c  | 305 ++++++++++++++++++++++++++++-------- 
> >  drivers/mtd/spi-nor/core.h  |   6 +
> >  drivers/mtd/spi-nor/sfdp.c  |   9 +-
> >  include/linux/mtd/spi-nor.h |  51 ++++--
> >  4 files changed, 295 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 0369d98b2d12..22a3832b83a6 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -40,6 +40,76 @@
> > 
> >  #define SPI_NOR_MAX_ADDR_WIDTH 4
> > 
> > +/**
> > + * spi_nor_get_cmd_ext() - Get the command opcode extension based on the
> > + *                        extension type.
> > + * @nor:               pointer to a 'struct spi_nor'
> > + * @op:                        pointer to the 'struct spi_mem_op' whose properties
> > + *                     need to be initialized.
> > + *
> > + * Right now, only "repeat" and "invert" are supported.
> > + *
> > + * Return: The opcode extension.
> > + */
> > +static u8 spi_nor_get_cmd_ext(const struct spi_nor *nor,
> > +                             const struct spi_mem_op *op)
> > +{
> > +       switch (nor->cmd_ext_type) {
> > +       case SPI_NOR_EXT_INVERT:
> > +               return ~op->cmd.opcode;
> > +
> > +       case SPI_NOR_EXT_REPEAT:
> > +               return op->cmd.opcode;
> > +
> > +       default:
> > +               dev_err(nor->dev, "Unknown command extension type\n");
> > +               return 0;
> > +       }
> > +}
> > +
> > +/**
> > + * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem op.
> > + * @nor:               pointer to a 'struct spi_nor'
> > + * @op:                        pointer to the 'struct spi_mem_op' whose properties
> > + *                     need to be initialized.
> > + * @proto:             the protocol from which the properties need to be set.
> > + */
> > +void spi_nor_spimem_setup_op(const struct spi_nor *nor,
> > +                            struct spi_mem_op *op,
> > +                            const enum spi_nor_protocol proto)
> 
> There's not much to set for the REG operations.
> 
> > +{
> > +       u8 ext;
> > +
> > +       op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(proto);
> > +
> > +       if (op->addr.nbytes)
> > +               op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> > +
> > +       if (op->dummy.nbytes)
> > +               op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> > +
> > +       if (op->data.nbytes)
> > +               op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
> 
> How about getting rid of the above and
> 
> > +
> > +       if (spi_nor_protocol_is_dtr(proto)) {
> 
> introduce a spi_nor_spimem_setup_dtr_op() just for the body of this if?

What benefit do we get with that other than skipping a couple of if() 
checks? The downside is that we would have to then replicate all this 
code to assign buswidth everywhere, including in spi_nor_read_sr() and 
spi_nor_read_fsr() adding to more boilerplate.

If we change anything about spi-mem ops in the future we would then 
again have to hunt and peck all places where we create spi-mem ops and 
update them.

For example, I was recently experimenting with a mechanism to tell 
controllers the maximum supported frequency for an op (xSPI says read 
SFDP should support at least 50MHz operation so we want to make sure 
controllers don't exceed that speed). A max speed of 0 would mean 
controllers can go as fast as they wish (how it is done currently). 
Having a central function to set up ops made it a 1 line change to set 
the speed to 0 for all ops, and then we can set it to 50MHz for read 
SFDP. The same thing without it would have me copying that line in 10-15 
places.

So unless there are any significant reasons to avoid having this, I 
think it is a good idea to keep it.

> > +               /*
> > +                * spi-mem supports mixed DTR modes, but right now we can only
> > +                * have all phases either DTR or STR. IOW, spi-mem can have
> nit: SPIMEM
> > +                * something like 4S-4D-4D, but spi-nor can't. So, set all 4
> nit: SPI NOR
> > +                * phases to either DTR or STR.
> > +                */
> > +               op->cmd.dtr = op->addr.dtr = op->dummy.dtr
> > +                              = op->data.dtr = true;
> > +
> > +               /* 2 bytes per clock cycle in DTR mode. */
> > +               op->dummy.nbytes *= 2;
> > +
> > +               ext = spi_nor_get_cmd_ext(nor, op);
> > +               op->cmd.opcode = (op->cmd.opcode << 8) | ext;
> > +               op->cmd.nbytes = 2;
> > +       }
> > +}
> > +
> >  /**
> >   * spi_nor_spimem_bounce() - check if a bounce buffer is needed for the data
> >   *                           transfer
> > @@ -104,14 +174,12 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
> >         ssize_t nbytes;
> >         int error;
> > 
> > -       /* get transfer protocols. */
> > -       op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
> > -       op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
> > -       op.dummy.buswidth = op.addr.buswidth;
> > -       op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
> > +       spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
> 
> Here we would keep the code as it were.
> > 
> >         /* convert the dummy cycles to the number of bytes */
> >         op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > +       if (spi_nor_protocol_is_dtr(nor->read_proto))
> > +               op.dummy.nbytes *= 2;
> 
> And replace these 2 lines with:
> 	if (spi_nor_protocol_is_dtr(nor->read_proto))
> 		spi_nor_spimem_setup_dtr_op(nor, &op, nor->read_proto)
> > 
> >         usebouncebuf = spi_nor_spimem_bounce(nor, &op);
> > 
> > @@ -169,13 +237,11 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
> >         ssize_t nbytes;
> >         int error;
> > 
> > -       op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
> > -       op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
> > -       op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
> > -
> >         if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
> >                 op.addr.nbytes = 0;
> > 
> > +       spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
> > +
> >         if (spi_nor_spimem_bounce(nor, &op))
> >                 memcpy(nor->bouncebuf, buf, op.data.nbytes);
> > 
> > @@ -227,10 +293,16 @@ int spi_nor_write_enable(struct spi_nor *nor)
> >                                    SPI_MEM_OP_NO_DUMMY,
> >                                    SPI_MEM_OP_NO_DATA);
> > 
> > +               spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> For the reg operation we can get rid of the extra checks that were in
> spi_nor_spimem_setup_op and simply do:
> 
> 		if (spi_nor_protocol_is_dtr(proto))
> 			spi_nor_spimem_setup_dtr_op()
> 
> > +
> >                 ret = spi_mem_exec_op(nor->spimem, &op);
> >         } else {
> > -               ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
> > -                                                    NULL, 0);
> > +               if (spi_nor_protocol_is_dtr(nor->reg_proto))
> > +                       ret = -ENOTSUPP;
> > +               else
> > +                       ret = nor->controller_ops->write_reg(nor,
> > +                                                            SPINOR_OP_WREN,
> > +                                                            NULL, 0);
> 
> Would you introduce helpers for the controller ops, like Boris
> did in the following patch?
> https://patchwork.ozlabs.org/project/linux-mtd/patch/20181012084825.23697-10-boris.brezillon@bootlin.com/
> 
> How about spi_nor_controller_ops_read_reg()
> and spi_nor_controller_ops_write_reg() instead?

It would get rid of the boilerplate so I think it is a good idea.

> cut
> 
> > @@ -1144,7 +1291,11 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
> >                                    SPI_MEM_OP_NO_DUMMY,
> >                                    SPI_MEM_OP_NO_DATA);
> > 
> > +               spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
> > +
> >                 return spi_mem_exec_op(nor->spimem, &op);
> > +       } else if (spi_nor_protocol_is_dtr(nor->write_proto)) {
> > +               return -ENOTSUPP;
> >         } else if (nor->controller_ops->erase) {
> >                 return nor->controller_ops->erase(nor, addr);
> >         }
> 
> here you would need a helper: spi_nor_controller_ops_erase()

Ok.
 
> cut
> 
> > @@ -2368,12 +2517,16 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
> >         struct spi_nor_flash_parameter *params = nor->params;
> >         unsigned int cap;
> > 
> > -       /* DTR modes are not supported yet, mask them all. */
> > -       *hwcaps &= ~SNOR_HWCAPS_DTR;
> > -
> >         /* X-X-X modes are not supported yet, mask them all. */
> >         *hwcaps &= ~SNOR_HWCAPS_X_X_X;
> > 
> > +       /*
> > +        * If the reset line is broken, we do not want to enter a stateful
> > +        * mode.
> > +        */
> > +       if (nor->flags & SNOR_F_BROKEN_RESET)
> > +               *hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);
> 
> A dedicated reset line is not enough for flashes that keep their state
> in non-volatile bits. Since we can't protect from unexpected crashes in
> the non volatile state case, we should enter these modes only with an
> explicit request, i.e. an optional DT property: "update-nonvolatile-state",
> or something similar.

I wrote this patch with the assumption that we won't be supporting 
non-volatile configuration as of now. In the previous discussions we 
came to the conclusion that it is not easy to detect the flash if it 
boots in any mode other than 1S-1S-1S [0]. So if we update non-volatile 
state, the flash would be useless after a reboot because we won't be 
able to detect it in 8D mode. It doesn't matter if the reset line is 
connected or not because it will reset the flash to the non-volatile 
state, and we can't detect it from the non-volatile state.

> For the volatile state case, we can parse the SFDP SCCR map, save if we
> can enter stateful modes in a volatile way, and if yes allow the entering.

If we are not support volatile configurations, the reset line is enough 
to take care of unexpected resets, no? I don't see any need to parse 
SCCR map just for this.

> Do the flashes that you played with define the SFDP SCCR map?

FWIW, the Cypress S28HS512T flash does but the Micron MT35XU512ABA does 
not.
 
> > +
> >         for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
> >                 int rdidx, ppidx;
> > 
> > @@ -2628,7 +2781,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
> >                  * controller directly implements the spi_nor interface.
> >                  * Yet another reason to switch to spi-mem.
> >                  */
> > -               ignored_mask = SNOR_HWCAPS_X_X_X;
> > +               ignored_mask = SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR;
> >                 if (shared_mask & ignored_mask) {
> >                         dev_dbg(nor->dev,
> >                                 "SPI n-n-n protocols are not supported.\n");
> > @@ -2774,11 +2927,25 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
> >                                           SNOR_PROTO_1_1_8);
> >         }
> > 
> > +       if (info->flags & SPI_NOR_OCTAL_DTR_READ) {
> 
> Why do we need this flag? Can't we determine if the flash supports
> octal DTR by parsing SFDP?

For Cypress S28HS512T, we can since it is xSPI compliant. We can't do 
that for Micron MT35XU512ABA since it is not xSPI compliant.

> > +               params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> > +               spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
> > +                                         0, 20, SPINOR_OP_READ_FAST,
> > +                                         SNOR_PROTO_8_8_8_DTR);
> > +       }
> > +
> >         /* Page Program settings. */
> >         params->hwcaps.mask |= SNOR_HWCAPS_PP;
> >         spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
> >                                 SPINOR_OP_PP, SNOR_PROTO_1_1_1);
> > 
> > +       /*
> > +        * Since xSPI Page Program opcode is backward compatible with
> > +        * Legacy SPI, use Legacy SPI opcode there as well.
> > +        */
> > +       spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
> > +                               SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
> > +
> 
> This looks fishy. You haven't updated the hwcaps.mask, these pp settings never
> get selected?

The problem here is that I don't see any field/table in SFDP that can 
tell us {if,which} 8D-8D-8D program commands are supported. The xSPI 
spec says that "The program commands provide SPI backward compatible 
commands for programming data...".

So we populate the 8D page program opcodes here (and in 4bait parsing) 
using the 1S opcodes. The flashes have to enable the hwcap in fixup 
hooks.

As an alternative, maybe we can introduce the SPI_NOR_OCTAL_DTR_PP flag 
that can enable the hwcap here? Thoughts?

> >         /*
> >          * Sector Erase settings. Sort Erase Types in ascending order, with the
> >          * smallest erase size starting at BIT(0).
> > @@ -2886,7 +3053,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
> > 
> >         spi_nor_manufacturer_init_params(nor);
> > 
> > -       if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
> > +       if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > +                                SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ)) &&
> >             !(nor->info->flags & SPI_NOR_SKIP_SFDP))
> >                 spi_nor_sfdp_init_params(nor);
> > 
> > @@ -2948,7 +3116,9 @@ static int spi_nor_init(struct spi_nor *nor)
> >                 return err;
> >         }
> > 
> > -       if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
> > +       if (nor->addr_width == 4 &&
> > +           !(nor->info->flags & SPI_NOR_OCTAL_DTR_READ) &&
> 
> Why is the Octal DTR read exempted?

It is based on the assumption explained below that 8D mode will always 
use 4-byte addresses so we don't need to explicitly enable 8D mode. 
Although I think maybe we should exempt all flashes that support DTR 
mode?

> > +           !(nor->flags & SNOR_F_4B_OPCODES)) {
> >                 /*
> >                  * If the RESET# pin isn't hooked up properly, or the system
> >                  * otherwise doesn't perform a reset command in the boot
> > @@ -3007,6 +3177,9 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
> >  {
> >         if (nor->addr_width) {
> >                 /* already configured from SFDP */
> > +       } else if (spi_nor_protocol_is_dtr(nor->read_proto)) {
> > +                /* Always use 4-byte addresses in DTR mode. */
> > +               nor->addr_width = 4;
> 
> Why? DTR with 3 byte addr width should be possible too.

Should it be? What would happen to the half cycle left over? Do we then 
start the dummy phase in the middle of the cycle? We would also have to 
start the data phase in the middle of a cycle as well and end the 
transaction with half a cycle left over.

AFAIK, the controller I tested with (Cadence QSPI) does not support 
this. Similarly, the two flashes this series adds support for, Cypress 
S28HS512T and Micron MT35XU512ABA, don't support 3-byte address in 8D 
mode. I'm not sure if there are any flashes or controllers that do.
 
> >         } else if (nor->info->addr_width) {
> >                 nor->addr_width = nor->info->addr_width;
> >         } else if (nor->mtd.size > 0x1000000) {
> 
> Cheers,
> ta

[0] https://lore.kernel.org/linux-mtd/20200228093658.zc3uifqg4zruokq3@ti.com/

-- 
Regards,
Pratyush Yadav
