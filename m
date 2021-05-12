Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5037EDC1
	for <lists+linux-spi@lfdr.de>; Thu, 13 May 2021 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhELUqb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 May 2021 16:46:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44208 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354110AbhELSQj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 May 2021 14:16:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CIF6dD074881;
        Wed, 12 May 2021 13:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620843306;
        bh=FsEv88/8/UTVetcMYrNgOhBSultjjTeZkT50z0PO73g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oMKwY5YsO13iIsJ6jNC+0EPCRUySY5/JDvYoF7mLaSeVpLLrwloXDjMk83xZohf+4
         0DfrlkyhDM/U/756kRpdwfcvFD2UOeT7ivB8Vxeb6M1IzXuyiXTYgdvPnkoDw+FrVk
         D6IPCVDHKC0ClvPWyrV0d7DNHgUToF7wloOasQ4U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CIF6vN042400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 13:15:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 13:15:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 13:15:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CIF4QK070120;
        Wed, 12 May 2021 13:15:05 -0500
Date:   Wed, 12 May 2021 23:45:04 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <broonie@kernel.org>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Message-ID: <20210512181502.gktrfbezxrw25snz@ti.com>
References: <1620634836-13181-1-git-send-email-zhengxunli@mxic.com.tw>
 <1620634836-13181-2-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1620634836-13181-2-git-send-email-zhengxunli@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/05/21 04:20PM, Zhengxun Li wrote:
> The octaflash is an xSPI compliant octal DTR flash. Add support
> for using it in octal DTR mode.
> 
> Try to verify the flash ID to check whether the flash memory in octal
> DTR mode is correct. When reading ID in OCTAL DTR mode, ID will appear
> in a repeated manner. ex: ID[0] = 0xc2, ID[1] = 0xc2, ID[2] = 0x94,
> ID[3] = 0x94... Rearrange the order so that the ID can pass.
> 
> The octaflash series can be divided into the following types:
> 
> MX25 series : Serial NOR Flash.
> MX66 series : Serial NOR Flash with stacked die.(Size larger than 1Gb)
> LM/UM series : Up to 250MHz clock frequency with both DTR/STR operation.
> LW/UW series : Support simultaneous Read-while-Write operation in multiple
> 	       bank architecture. Read-while-write feature which means read
> 	       data one bank while another bank is programing or erasing.
> 
> MX25LM : 3.0V Octal I/O
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7841/MX25LM51245G,%203V,%20512Mb,%20v1.1.pdf
> 
> MX25UM : 1.8V Octal I/O
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7525/MX25UM51245G%20Extreme%20Speed,%201.8V,%20512Mb,%20v1.0.pdf
> 
> MX66LM : 3.0V Octal I/O with stacked die
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7929/MX66LM1G45G,%203V,%201Gb,%20v1.1.pdf
> 
> MX66UM : 1.8V Octal I/O with stacked die
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7721/MX66UM1G45G,%201.8V,%201Gb,%20v1.1.pdf
> 
> MX25LW : 3.0V Octal I/O with Read-while-Write
> MX25UW : 1.8V Octal I/O with Read-while-Write
> MX66LW : 3.0V Octal I/O with Read-while-Write and stack die
> MX66UW : 1.8V Octal I/O with Read-while-Write and stack die
> 
> About LW/UW series, please contact us freely if you have any
> questions. For adding Octal NOR Flash IDs, we have validated
> each Flash on plateform zynq-picozed.
> 
> Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 172 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 42c2cf3..00ddecc 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -8,6 +8,12 @@
>  
>  #include "core.h"
>  
> +#define SPINOR_OP_RD_CR2		0x71		/* Read configuration register 2 */
> +#define SPINOR_OP_WR_CR2		0x72		/* Write configuration register 2 */
> +#define SPINOR_REG_MXIC_CR2_MODE	0x00000000	/* For setting octal DTR mode */
> +#define SPINOR_REG_MXIC_OPI_DTR_EN	0x2		/* Enable Octal DTR */
> +#define SPINOR_REG_MXIC_SPI_EN		0x0		/* Enable SPI */
> +
>  static int
>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>  			    const struct sfdp_parameter_header *bfpt_header,
> @@ -32,6 +38,72 @@
>  	.post_bfpt = mx25l25635_post_bfpt_fixups,
>  };
>  
> +/**
> + * spi_nor_macronix_octal_dtr_enable() - Enable octal DTR on Macronix flashes.
> + * @nor:		pointer to a 'struct spi_nor'
> + * @enable:		whether to enable Octal DTR or switch back to SPI
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +	struct spi_mem_op op;
> +	u8 *buf = nor->bouncebuf, i;
> +	int ret;
> +
> +	/* Set/unset the octal and DTR enable bits. */
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	if (enable)
> +		*buf = SPINOR_REG_MXIC_OPI_DTR_EN;
> +	else
> +		*buf = SPINOR_REG_MXIC_SPI_EN;
> +
> +	op = (struct spi_mem_op)
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
> +			   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_MODE, 1),
> +			   SPI_MEM_OP_NO_DUMMY,
> +			   SPI_MEM_OP_DATA_OUT(1, buf, 1));

This would fail to disable 8D mode after my patch [0] is applied. See 
patch 1/6 and 2/6 on how I solved the problem for Micron and Cypress 
flashes.

> +
> +	if (!enable)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret)
> +		return ret;
> +
> +	/* Read flash ID to make sure the switch was successful. */
> +	op = (struct spi_mem_op)
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
> +			   SPI_MEM_OP_ADDR(enable ? 4 : 0, 0, 1),
> +			   SPI_MEM_OP_DUMMY(enable ? 4 : 0, 1),
> +			   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, buf, 1));
> +
> +	if (enable)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nor->info->id_len; i++)
> +		if (buf[i * 2] != nor->info->id[i])
> +			return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void octaflash_default_init(struct spi_nor *nor)
> +{
> +	nor->params->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
> +}
> +
> +static struct spi_nor_fixups octaflash_fixups = {
> +	.default_init = octaflash_default_init,

So the post-sfdp fixup was not needed at all. Nice!

> +};
> +
>  static const struct flash_info macronix_parts[] = {
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> @@ -86,6 +158,106 @@
>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "mx66lm2g45g", INFO(0xc2853c, 0, 64 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66lm1g45g", INFO(0xc2853b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66lw1g45g", INFO(0xc2863b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lm51245g", INFO(0xc2853a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lw51245g", INFO(0xc2863a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lm25645g", INFO(0xc28539, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25lw25645g", INFO(0xc28639, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66um2g45g", INFO(0xc2803c, 0, 64 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66uw2g345g", INFO(0xc2843c, 0, 64 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66uw2g345gx0", INFO(0xc2943c, 0, 64 * 1024, 4096,
> +				 SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +				 SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66um1g45g", INFO(0xc2803b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66um1g45g40", INFO(0xc2808b, 0, 32 * 1024, 4096,
> +				SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +				SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx66uw1g45g", INFO(0xc2813b, 0, 32 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25um51245g", INFO(0xc2803a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw51245g", INFO(0xc2813a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw51345g", INFO(0xc2843a, 0, 16 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25um25645g", INFO(0xc28039, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw25645g", INFO(0xc28139, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25um25345g", INFO(0xc28339, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw25345g", INFO(0xc28439, 0, 8 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw12845g", INFO(0xc28138, 0, 4 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw12a45g", INFO(0xc28938, 0, 4 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw12345g", INFO(0xc28438, 0, 4 * 1024, 4096,
> +			       SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			       SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw6445g", INFO(0xc28137, 0, 2 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },
> +	{ "mx25uw6345g", INFO(0xc28437, 0, 2 * 1024, 4096,
> +			      SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_4B_OPCODES)
> +		.fixups = &octaflash_fixups },

I don't see any ID collisions here, so all good.

>  };
>  
>  static void macronix_default_init(struct spi_nor *nor)

Apart from the 8D-8D-8D register write comment above, the patch looks 
good to me.

[0] https://lore.kernel.org/linux-mtd/20210506191829.8271-5-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
