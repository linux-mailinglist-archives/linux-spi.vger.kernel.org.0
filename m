Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501F03E2FA9
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 21:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhHFTGc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 15:06:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46075 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbhHFTGb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 15:06:31 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 40AC760003;
        Fri,  6 Aug 2021 19:06:11 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:06:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 10/13] mtd: spinand: Add octal_dtr_enable() for Winbond
 manufacturer_ops
Message-ID: <20210806210609.0fd94b9e@xps13>
In-Reply-To: <20210713130538.646-11-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-11-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:35
+0000:

> Add implementation of octal_dtr_enable() manufacturer_ops for Winbond.
> To switch to Ocatl DTR mode, setting programmable dummy cycles and
> SPI IO mode using the volatile configuration register is required. To
> function at max 120MHz SPI clock in Octal DTR mode, 12 programmable
> dummy clock cycle setting is required. (Default number of dummy cycle
> are 8 clocks)
> 
> Set the programmable dummy cycle to 12 clocks, and SPI IO mode to
> Octal DTR with Data Strobe in the VCR. Also, perform a READ ID
> operation in Octal DTR SPI mode to ensure the switch was successful.

Commit title should contain "winbond:" (same for the previous patch and
possibly next ones as well).

> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/winbond.c | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index a7052a9ca171..58cda07c15a0 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -16,6 +16,14 @@
>  
>  #define WINBOND_CFG_BUF_READ		BIT(3)
>  
> +/* Octal DTR SPI mode (8D-8D-8D) with Data Strobe output*/
> +#define WINBOND_IO_MODE_VCR_OCTAL_DTR	0xE7
> +#define WINBOND_IO_MODE_VCR_ADDR	0x00
> +
> +/* Use 12 dummy clk cycles for using Octal DTR SPI at max 120MHZ */
> +#define WINBOND_DUMMY_CLK_COUNT		12
> +#define WINBOND_DUMMY_CLK_VCR_ADDR	0x01
> +
>  static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> @@ -142,8 +150,42 @@ static int winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, u8 val)
>  	return 0;
>  }
>  
> +static int winbond_spinand_octal_dtr_enable(struct spinand_device *spinand)
> +{
> +	int ret;
> +	struct spi_mem_op op;
> +
> +	ret = winbond_write_vcr_op(spinand, WINBOND_DUMMY_CLK_VCR_ADDR,
> +				   WINBOND_DUMMY_CLK_COUNT);
> +	if (ret)
> +		return ret;
> +
> +	ret = winbond_write_vcr_op(spinand, WINBOND_IO_MODE_VCR_ADDR,
> +				   WINBOND_IO_MODE_VCR_OCTAL_DTR);
> +	if (ret)
> +		return ret;
> +
> +	/* Read flash ID to make sure the switch was successful. */
> +	op = (struct spi_mem_op)
> +		SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x9f9f, 8),
> +			   SPI_MEM_OP_NO_ADDR,
> +			   SPI_MEM_OP_DUMMY_DTR(16, 8),
> +			   SPI_MEM_OP_DATA_IN_DTR(SPINAND_MAX_ID_LEN,
> +						  spinand->scratchbuf, 8));
> +
> +	ret = spi_mem_exec_op(spinand->spimem, &op);
> +	if (ret)
> +		return ret;
> +
> +	if (memcmp(spinand->scratchbuf, spinand->id.data, SPINAND_MAX_ID_LEN))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
>  	.init = winbond_spinand_init,
> +	.octal_dtr_enable = winbond_spinand_octal_dtr_enable,
>  };
>  
>  const struct spinand_manufacturer winbond_spinand_manufacturer = {




Thanks,
Miquèl
