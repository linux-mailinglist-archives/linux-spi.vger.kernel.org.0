Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21DB36BD65
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 04:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhD0ChI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 22:37:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42510 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhD0ChH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 22:37:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13R2a8q0059902;
        Mon, 26 Apr 2021 21:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619490968;
        bh=ZtkCbY7cgaOOqgqO30NLX6AA5bk9hbOtxWFGkTki0cU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hxTgyRdPxjkHlzJKpfioLRJE6UNoPytQ1Gn8QcqtVH0snz8rbVrdkwueL2oDZzbBx
         mD0IuuZYTPZlesSU//CpquRnd+XV0Eytd44Jvz0hgY5YqbcH+tRKr4xmU8ovdekqrt
         yijKJsAzS2uh1/4dxE/wRiRQzNZWHbgh2awMFIVo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13R2a8v1032691
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 21:36:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 21:36:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 21:36:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13R2a7JI078532;
        Mon, 26 Apr 2021 21:36:07 -0500
Date:   Tue, 27 Apr 2021 08:06:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <broonie@kernel.org>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: macronix: add support for Macronix
 octal dtr operation
Message-ID: <20210427023604.vamgepl4myrhpiwu@ti.com>
References: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
 <1618900179-14546-2-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1618900179-14546-2-git-send-email-zhengxunli@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 20/04/21 02:29PM, Zhengxun Li wrote:
> The ocatflash is an xSPI compliant octal DTR flash. Add support

Typo. s/ocatflash/octaflash/

> for using it in octal DTR mode.
> 
> Enable Octal DTR mode with 20 dummy cycles to allow running at the
> maximum supported frequency of 200Mhz.

Which octaflash is that? The flash datasheets you have linked in patch 2 
either have a max supported frequency of 133 MHz or 250 MHz.

> 
> Try to verify the flash ID to check whether the flash memory in octal
> DTR mode is correct. When reading ID in OCTAL DTR mode, ID will appear
> in a repeated manner. ex: ID[0] = 0xc2, ID[1] = 0xc2, ID[2] = 0x94,
> ID[3] = 0x94... Rearrange the order so that the ID can pass.

Ok. I don't see this mentioned in the datasheet but the timing diagram 
seems to imply this.

> 
> Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 117 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 42c2cf3..881eaf8 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -8,6 +8,16 @@
>  
>  #include "core.h"
>  
> +#define SPINOR_OP_RD_CR2		0x71		/* Read configuration register 2 */
> +#define SPINOR_OP_WR_CR2		0x72		/* Write configuration register 2 */
> +#define SPINOR_OP_MXIC_DTR_RD		0xee		/* Fast Read opcode in DTR mode */
> +#define SPINOR_REG_MXIC_CR2_MODE	0x00000000	/* For setting octal DTR mode */
> +#define SPINOR_REG_MXIC_OPI_DTR_EN	0x2		/* Enable Octal DTR */
> +#define SPINOR_REG_MXIC_OPI_DTR_DIS	0x1		/* Disable Octal DTR */

This would switch the flash to 8S-8S-8S mode, which isn't all that much 
better than 8D-8D-8D (it is a stateful mode, you need to know beforehand 
that the flash is in this mode before you can use it properly). I think 
"disabling" octal DTR should mean switching back to the default 
(1S-1S-1S) mode.

> +#define SPINOR_REG_MXIC_CR2_DC		0x00000300	/* For setting dummy cycles */
> +#define SPINOR_REG_MXIC_DC_20		0x0		/* Setting dummy cycles to 20 */
> +#define MXIC_MAX_DC			20		/* Maximum value of dummy cycles */
> +
>  static int
>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>  			    const struct sfdp_parameter_header *bfpt_header,
> @@ -32,6 +42,113 @@
>  	.post_bfpt = mx25l25635_post_bfpt_fixups,
>  };
>  
> +/**
> + * spi_nor_macronix_octal_dtr_enable() - Enable octal DTR on Macronix flashes.
> + * @nor:		pointer to a 'struct spi_nor'
> + * @enable:		whether to enable or disable Octal DTR
> + *
> + * This also sets the memory access dummy cycles to 20 to allow the flash to
> + * run at up to 200MHz.

For some flashes it is 250 MHz and for some it is 133 MHz. More on this 
below...

> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +	struct spi_mem_op op;
> +	u8 *buf = nor->bouncebuf, i;
> +	int ret;
> +
> +	if (enable) {
> +		/* Use 20 dummy cycles for memory array reads. */
> +		ret = spi_nor_write_enable(nor);
> +		if (ret)
> +			return ret;
> +
> +		*buf = SPINOR_REG_MXIC_DC_20;

I've looked at both the 133 and 250 MHz parts. In both, the default 
dummy cycles are already 20. This can be skipped. This way you also 
don't have to say in comments whether this enables 133 MHz or 250 MHz 
operation (again, I don't get where the 200 MHz comes from...).

The chip manufacturer chose sane defaults for the dummy cycle value. 
Let's reap the benefits and reduce the code we have to maintain.

> +		op = (struct spi_mem_op)
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
> +				   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_DC, 1),
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +		if (ret)
> +			return ret;
> +
> +		ret = spi_nor_wait_till_ready(nor);
> +		if (ret)
> +			return ret;
> +
> +		nor->read_dummy = MXIC_MAX_DC;

I don't see SFDP values listed in the datasheet. Since the flash is 
supposed to be xSPI compliant, it should have a Profile 1.0 table. Does 
the Profile 1.0 parser correctly select 20 dummy cycles for this flash? 
If yes, there is no need for this.

> +	}
> +
> +	/* Set/unset the octal and DTR enable bits. */
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	if (enable)
> +		*buf = SPINOR_REG_MXIC_OPI_DTR_EN;
> +	else
> +		*buf = SPINOR_REG_MXIC_OPI_DTR_DIS;
> +
> +	op = (struct spi_mem_op)
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),

I see that the flash uses inverted 2nd byte for opcode in 8D mode. I 
assume this is discovered correctly via SFDP.

> +			   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_MODE, 1),

4 byte addressing is used for this command even in 1S-1S-1S mode. Ok.

> +			   SPI_MEM_OP_NO_DUMMY,
> +			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +
> +	if (!enable)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);

When disabling, the op would be in 8D-8D-8D mode so having a data length 
of 1 would be invalid. This is currently the case even in the patches 
that I sent for Micron and Cypress.

I am not sure what the correct fix for this is though. One option is to 
send the same byte twice, but I remember that on the Cypress flash the 
second byte over-writes the register at the next address. I'm not sure 
how Macronix flashes handle the second byte. Can you check what the 
behavior for your flash is when you write 2 bytes to the register?

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

Ok.

> +
> +	return 0;
> +}
> +
> +static void octaflash_default_init(struct spi_nor *nor)
> +{
> +	nor->params->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
> +}
> +
> +static void octaflash_post_sfdp_fixup(struct spi_nor *nor)
> +{
> +	/* Set the Fast Read settings. */
> +	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> +	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
> +				  0, MXIC_MAX_DC, SPINOR_OP_MXIC_DTR_RD,
> +				  SNOR_PROTO_8_8_8_DTR);
> +
> +	nor->cmd_ext_type = SPI_NOR_EXT_INVERT;

Shouldn't this be discovered via BFPT DWORD 18?

> +	nor->params->rdsr_dummy = 4;
> +	nor->params->rdsr_addr_nbytes = 4;

Shouldn't these two be discovered via the Profile 1.0 table?

In general, avoid hard-coding values that can be discovered through 
SFDP. The device usually knows more about itself than we do.

> +}
> +
> +static struct spi_nor_fixups octaflash_fixups = {

Hm, I don't like this unreferenced variable here. In fact, you should
merge patch 1 and 2 into a single patch. This would combine things in a 
single neat commit, including the links to datasheets. This will make it 
easier for future archaeologists digging around with git blame to find 
some more info about the flash.

> +	.default_init = octaflash_default_init,
> +	.post_sfdp = octaflash_post_sfdp_fixup,
> +};
> +
>  static const struct flash_info macronix_parts[] = {
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> -- 
> 1.9.1

That's an ancient version of Git you're using there ;-)

Overall, I like the direction this patch is taking, but lots of minor 
things to polish out.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
