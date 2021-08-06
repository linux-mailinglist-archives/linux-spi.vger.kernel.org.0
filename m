Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263063E2FAC
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 21:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbhHFTJs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 15:09:48 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:47083 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhHFTJs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 15:09:48 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 43F5DCB227
        for <linux-spi@vger.kernel.org>; Fri,  6 Aug 2021 19:05:26 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AFE49C0003;
        Fri,  6 Aug 2021 19:05:01 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:05:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 09/13] mtd: spinand: Add support for write volatile
 configuration register op
Message-ID: <20210806210500.3ead1600@xps13>
In-Reply-To: <20210713130538.646-10-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-10-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:34
+0000:

> Volatile configuration register are a different set of configuration
> registers, i.e. they differ from the status registers. A different
> SPI instruction is required to write to these registers. Any changes
> to the Volatile Configuration Register get transferred directly to
> the Internal Configuration Register and instantly reflect on the
> device operation.
> 
> In Winbond W35N01JW, these volatile configuration register must be
> configured in order to switch to Octal DTR SPI mode.
> 
> Add support for writing to volatile configuration registers using a
> new WRITE_VCR_OP template.
> 
> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c    |  2 +-
>  drivers/mtd/nand/spi/winbond.c | 28 ++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 8711e887b795..f577e72da2c4 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -442,7 +442,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
>  		engine_conf->status = status;
>  }
>  
> -static int spinand_write_enable_op(struct spinand_device *spinand)
> +int spinand_write_enable_op(struct spinand_device *spinand)
>  {
>  	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
>  
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index 76684428354e..a7052a9ca171 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -7,6 +7,7 @@
>   *	Boris Brezillon <boris.brezillon@bootlin.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/mtd/spinand.h>
> @@ -114,6 +115,33 @@ static int winbond_spinand_init(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> +static int winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, u8 val)

Maybe a comment to tell people what vcr is?

> +{
> +	int ret;
> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),
> +					  SPI_MEM_OP_ADDR(3, reg, 1),
> +					  SPI_MEM_OP_NO_DUMMY,
> +					  SPI_MEM_OP_DATA_OUT(1, spinand->scratchbuf, 1));
> +
> +	*spinand->scratchbuf = val;
> +
> +	ret = spinand_write_enable_op(spinand);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_mem_exec_op(spinand->spimem, &op);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Write VCR operation doesn't set the busy bit in SR, so can't perform
> +	 * a status poll. Minimum time of 50ns is needed to complete the write.
> +	 * So, give thrice the minimum required delay.

Isn't there an official maximum time?

> +	 */
> +	ndelay(150);
> +	return 0;
> +}
> +
>  static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
>  	.init = winbond_spinand_init,
>  };
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index daa2ac5c3110..21a4e5adcd59 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -560,5 +560,6 @@ int spinand_match_and_init(struct spinand_device *spinand,
>  
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int target);
> +int spinand_write_enable_op(struct spinand_device *spinand);
>  
>  #endif /* __LINUX_MTD_SPINAND_H */




Thanks,
Miquèl
