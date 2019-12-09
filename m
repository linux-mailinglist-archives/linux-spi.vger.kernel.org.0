Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33561167D5
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 08:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLIH6E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 02:58:04 -0500
Received: from twhmllg4.macronix.com ([211.75.127.132]:56641 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLIH6E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 02:58:04 -0500
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id xB97utox087481;
        Mon, 9 Dec 2019 15:56:55 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 7F169E8107F195952257;
        Mon,  9 Dec 2019 15:56:55 +0800 (CST)
In-Reply-To: <3f514579-d3a4-1319-a55a-265a3f1ce00e@ti.com>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw> <1573808288-19365-3-git-send-email-masonccyang@mxic.com.tw> <3f514579-d3a4-1319-a55a-265a3f1ce00e@ti.com>
To:     "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH 2/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
MIME-Version: 1.0
X-KeepSent: FE6363DF:95763BC3-482584CB:002A47E5;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFFE6363DF.95763BC3-ON482584CB.002A47E5-482584CB.002BAA8C@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 9 Dec 2019 15:56:57 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/12/09 PM 03:56:55,
        Serialize complete at 2019/12/09 PM 03:56:55
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com xB97utox087481
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Vignesh,

> 
> On 15/11/19 2:28 pm, Mason Yang wrote:
> > According to JESD216C (JEDEC Basic Flash Parameter Table 18th DWORD)
> > Octal DTR(8D-8D-8D) command and command extension (00b: same, 01b: 
inverse)
> > to add extension command mode in spi_nor struct and to add write_cr2
> > (Write CFG Reg 2) for 8-8-8/8D-8D-8D mode sequences enable.
> > 
> 
> But I don't see any code setting "nor->ext_cmd_mode" based on BFPT?
> 
> Any new feature that we add to spi-nor should make use of autodiscovery
> feature made possible by SFDP tables. Could you modify the patch to
> discover capabilities supported by flash and opcodes to be used from
> SFDP table?

Got it but our device will return a empty SFDP table.

> 
> 
> > Define the relevant macrons and enum to add such modes and make sure
> > op->xxx.dtr fields, command nbytes and extension command are properly
> > filled and unmask DTR and X-X-X modes in 
spi_nor_spimem_adjust_hwcaps()
> > so that DTR and X-X-X support detection is done through
> > spi_mem_supports_op().
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 159 
++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/mtd/spi-nor.h   |  58 +++++++++++++--
> >  2 files changed, 206 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c 
b/drivers/mtd/spi-nor/spi-nor.c
> > index 7acf4a9..4cdf52d 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -320,6 +320,23 @@ static ssize_t spi_nor_spimem_read_data(struct 
spi_nor 
> *nor, loff_t from,
> >     /* convert the dummy cycles to the number of bytes */
> >     op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > 
> > +   if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
> > +      op.cmd.nbytes = 2;
> 
> Can we get this info from SFDP too?
> 
> > +
> > +      if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
> > +         op.cmd.ext_opcode = ~nor->read_opcode;
> > +      else
> > +         op.cmd.ext_opcode = nor->read_opcode;
> > +
> > +      if (spi_nor_protocol_is_8D_8D_8D(nor->read_proto)) {
> > +         op.dummy.nbytes *= 2;
> 
> > +         op.cmd.dtr = true;
> > +         op.addr.dtr = true;
> > +         op.dummy.dtr = true;
> > +         op.data.dtr = true;
> 
> Can we have a macro for this initialization?

okay, will fix it.

> 
> 
> > +      }
> > +   }
> > +
> >     return spi_nor_spimem_xfer_data(nor, &op);
> >  }
> > 
> > @@ -367,6 +384,21 @@ static ssize_t spi_nor_spimem_write_data(struct 
spi_nor
> *nor, loff_t to,
> >     if (nor->program_opcode == SPINOR_OP_AAI_WP && 
nor->sst_write_second)
> >        op.addr.nbytes = 0;
> > 
> > +   if (spi_nor_protocol_is_8_8_8(nor->write_proto)) {
> > +      op.cmd.nbytes = 2;
> > +
> > +      if (nor->ext_cmd_mode == EXT_CMD_IS_INVERSE)
> > +         op.cmd.ext_opcode = ~nor->program_opcode;
> > +      else
> > +         op.cmd.ext_opcode = nor->program_opcode;
> > +
> > +      if (spi_nor_protocol_is_8D_8D_8D(nor->write_proto)) {
> > +         op.cmd.dtr = true;
> > +         op.addr.dtr = true;
> > +         op.data.dtr = true;
> > +      }
> > +   }
> > +
> >     return spi_nor_spimem_xfer_data(nor, &op);
> >  }
> > 
> > @@ -404,6 +436,30 @@ static int read_sr(struct spi_nor *nor)
> >                 SPI_MEM_OP_NO_DUMMY,
> >                 SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> > 
> 
> This is not based on the latest tree.
> 
> > +      if (spi_nor_protocol_is_8_8_8(nor->read_proto)) {
> > +         op.cmd.buswidth = 8;
> > +         op.addr.buswidth = 8;
> > +         op.dummy.buswidth = 8;
> > +         op.data.buswidth = 8;
> > +         op.cmd.nbytes = 2;
> > +         op.addr.nbytes = 4;
> > +         op.dummy.nbytes = 4;
> > +         op.addr.val = 0;
> 
> This is not scalable... There will be bunch of if...else ladders when we
> want to support other X-X-X modes... Can't these be derived from
> nor->reg_proto? And then borrow the logic from 
spi_nor_spimem_read_data()?
> 

Got it !

> 
> Could you have a look at Boris's initial submission to add 8-8-8 mode at
> https://patchwork.kernel.org/cover/10638055/ ?
> You could use that series as the base for your changes/additions.

Got it.
My idea is to support 8D-8D-8D mode with a minimum patches because 
there is no define for 1D-1D-1D, 2D-2D-2D and 4D-4D-4D mode in JEDEC 
if I am right.

> 
> I am fine if you want to call 2nd byte of opcode as ext_opcode
> 
> Regards
> Vignesh
> 

thanks for your time & comments.
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

