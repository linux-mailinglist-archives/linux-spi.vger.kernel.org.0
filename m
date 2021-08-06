Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6A3E2FBA
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbhHFTOo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 15:14:44 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56853 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbhHFTOm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 15:14:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 11D6860004;
        Fri,  6 Aug 2021 19:14:24 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:14:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 13/13] mtd: spinand: Add support for Winbond W35N01JW
 SPI NAND flash
Message-ID: <20210806211423.5c9d3e96@xps13>
In-Reply-To: <20210713130538.646-14-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-14-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:38
+0000:

> Winbond W35N01JW is SPI NAND flash supporting Octal DTR SPI protocol.

                     a

> Add op_vairants for W35N01JW, which include the Octal DTR read/write

variants

> page ops as well. Add W35N01JW's oob layout functions for the

                                   OOB

> mtd_ooblayout_ops. Add all op adjustments required for Octal DTR SPI
> mode using the adjust_op(). Finally, add an entry for W35N01JW in
> spinand_info table.
> 
> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> 

Maybe we can split this into two parts:
1/ support the chip
2/ add 8-D support

> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/winbond.c | 116 ++++++++++++++++++++++++++++++---
>  1 file changed, 107 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index 58cda07c15a0..5c2b9e61b624 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -16,6 +16,13 @@
>  
>  #define WINBOND_CFG_BUF_READ		BIT(3)
>  
> +#define WINBOND_BLK_ERASE_OPCODE	0xD8
> +#define WINBOND_PAGE_READ_OPCODE	0x13
> +#define WINBOND_PROG_EXEC_OPCODE	0x10
> +#define WINBOND_READ_REG_OPCODE_1	0x05
> +#define WINBOND_READ_REG_OPCODE_2	0x0F
> +#define WINBOND_READ_VCR_OPCODE		0x85
> +
>  /* Octal DTR SPI mode (8D-8D-8D) with Data Strobe output*/
>  #define WINBOND_IO_MODE_VCR_OCTAL_DTR	0xE7
>  #define WINBOND_IO_MODE_VCR_ADDR	0x00
> @@ -24,7 +31,7 @@
>  #define WINBOND_DUMMY_CLK_COUNT		12
>  #define WINBOND_DUMMY_CLK_VCR_ADDR	0x01
>  
> -static SPINAND_OP_VARIANTS(read_cache_variants,
> +static SPINAND_OP_VARIANTS(read_cache_variants_w25xxgv,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> @@ -32,14 +39,27 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
>  
> -static SPINAND_OP_VARIANTS(write_cache_variants,
> +static SPINAND_OP_VARIANTS(write_cache_variants_w25xxgv,
>  		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(true, 0, NULL, 0));
>  
> -static SPINAND_OP_VARIANTS(update_cache_variants,
> +static SPINAND_OP_VARIANTS(update_cache_variants_w25xxgv,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> +static SPINAND_OP_VARIANTS(read_cache_variants_w35n01jw,
> +		SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(0, 24, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants_w35n01jw,
> +		SPINAND_PROG_LOAD_OCTALIO_DTR(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants_w35n01jw,
> +		SPINAND_PROG_LOAD_OCTALIO_DTR(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
>  static int w25m02gv_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
>  {
> @@ -64,11 +84,40 @@ static int w25m02gv_ooblayout_free(struct mtd_info *mtd, int section,
>  	return 0;
>  }
>  
> +static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	if (section > 7)
> +		return -ERANGE;
> +
> +	region->offset = (16 * section) + 12;
> +	region->length = 4;
> +
> +	return 0;
> +}
> +
> +static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 7)
> +		return -ERANGE;
> +
> +	region->offset = (16 * section) + 2;
> +	region->length = 10;
> +
> +	return 0;
> +}
> +
>  static const struct mtd_ooblayout_ops w25m02gv_ooblayout = {
>  	.ecc = w25m02gv_ooblayout_ecc,
>  	.free = w25m02gv_ooblayout_free,
>  };
>  
> +static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
> +	.ecc = w35n01jw_ooblayout_ecc,
> +	.free = w35n01jw_ooblayout_free,
> +};
> +
>  static int w25m02gv_select_target(struct spinand_device *spinand,
>  				  unsigned int target)
>  {
> @@ -88,9 +137,9 @@ static const struct spinand_info winbond_spinand_table[] = {
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
>  		     NAND_ECCREQ(1, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_w25xxgv,
> +					      &write_cache_variants_w25xxgv,
> +					      &update_cache_variants_w25xxgv),
>  		     0,
>  		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
>  		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
> @@ -98,11 +147,22 @@ static const struct spinand_info winbond_spinand_table[] = {
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_w25xxgv,
> +					      &write_cache_variants_w25xxgv,
> +					      &update_cache_variants_w25xxgv),
>  		     0,
>  		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
> +	SPINAND_INFO("W35N01JW",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc),
> +		     NAND_MEMORG(1, 4096, 128, 64, 512, 20, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_w35n01jw,
> +					      &write_cache_variants_w35n01jw,
> +					      &update_cache_variants_w35n01jw),
> +		     SPINAND_HAS_OCTAL_DTR_BIT | SPINAND_HAS_POR_CMD_BIT |
> +		     SPINAND_HAS_CR_FEAT_BIT,
> +		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
> +
>  };
>  
>  static int winbond_spinand_init(struct spinand_device *spinand)
> @@ -183,9 +243,47 @@ static int winbond_spinand_octal_dtr_enable(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> +static void winbond_spinand_adjust_op(struct spi_mem_op *op,
> +				      const enum spinand_proto reg_proto)
> +{
> +	/*
> +	 * To support both 1 byte opcode and 2 byte opcodes, extract the MSB
> +	 * byte from the opcode as the LSB byte in 2 byte opcode is treated as
> +	 * don't care.
> +	 */
> +	u8 opcode = op->cmd.opcode >> (8 * (op->cmd.nbytes - 1));
> +
> +	if (reg_proto == SPINAND_OCTAL_DTR) {
> +		switch (opcode) {
> +		case WINBOND_READ_REG_OPCODE_1:
> +		case WINBOND_READ_REG_OPCODE_2:
> +			op->dummy.nbytes = 14;
> +			op->dummy.buswidth = 8;
> +			op->dummy.dtr = true;
> +			return;
> +
> +		case WINBOND_READ_VCR_OPCODE:
> +			op->dummy.nbytes = 16;
> +			op->dummy.buswidth = 8;
> +			op->dummy.dtr = true;
> +			return;
> +
> +		case WINBOND_BLK_ERASE_OPCODE:
> +		case WINBOND_PAGE_READ_OPCODE:
> +		case WINBOND_PROG_EXEC_OPCODE:
> +			op->addr.nbytes = 2;
> +			return;
> +
> +		default:
> +			return;
> +		}
> +	}
> +}
> +
>  static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
>  	.init = winbond_spinand_init,
>  	.octal_dtr_enable = winbond_spinand_octal_dtr_enable,
> +	.adjust_op = winbond_spinand_adjust_op,
>  };
>  
>  const struct spinand_manufacturer winbond_spinand_manufacturer = {

Thanks,
Miquèl
