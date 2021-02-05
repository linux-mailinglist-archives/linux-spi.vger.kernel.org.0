Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBB310884
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 10:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBEJ4l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 5 Feb 2021 04:56:41 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:40905 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBEJyh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 04:54:37 -0500
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id ABA973C0760
        for <linux-spi@vger.kernel.org>; Fri,  5 Feb 2021 09:49:52 +0000 (UTC)
Received: from xps13 (aputeaux-654-1-105-144.w90-2.abo.wanadoo.fr [90.2.4.144])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9DA9A100004;
        Fri,  5 Feb 2021 09:47:40 +0000 (UTC)
Date:   Fri, 5 Feb 2021 10:47:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     zhengxunli <zhengxunli@mxic.com.tw>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, ycllin@mxic.com.tw,
        juliensu@mxic.com.tw
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Message-ID: <20210205104736.2771074c@xps13>
In-Reply-To: <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
        <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

zhengxunli <zhengxunli@mxic.com.tw> wrote on Fri,  5 Feb 2021 17:36:47
+0800:

> The ocatflash is an xSPI compliant octal DTR flash. Add support
> for using it in octal DTR mode.
> 
> Enable Octal DTR mode with 20 dummy cycles to allow running at the
> maximum supported frequency of 200Mhz.
> 
> Try to verify the flash ID to check whether the flash memory in octal
> DTR mode is correct. When reading ID in OCTAL DTR mode, ID will appear
> in a repeated manner. ex: ID[0] = 0xc2, ID[1] = 0xc2, ID[2] = 0x94,
> ID[3] = 0x94... Rearrange the order so that the ID can pass.
> 
> Signed-off-by: zhengxunli <zhengxunli@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 121 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 9203aba..7498978 100644
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
> +#define SPINOR_REG_MXIC_CR2_DC		0x00000300	/* For setting dummy cycles */
> +#define SPINOR_REG_MXIC_DC_20		0x0		/* Setting dummy cycles to 20 */
> +#define MXIC_MAX_DC			20		/* Maximum value of dummy cycles */
> +
>  static int
>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>  			    const struct sfdp_parameter_header *bfpt_header,
> @@ -33,6 +43,113 @@
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

I am still not convinced by this constant value.

The rest looks good to me.


Thanks,
Miquèl
