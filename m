Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973C13E2F65
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbhHFSn4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 14:43:56 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42887 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhHFSny (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 14:43:54 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 8AC7A1BF205;
        Fri,  6 Aug 2021 18:43:35 +0000 (UTC)
Date:   Fri, 6 Aug 2021 20:43:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 04/13] mtd: spinand: Fix odd byte addr and data phase in
 read/write reg op and write VCR op for Octal DTR mode
Message-ID: <20210806204334.5fedea42@xps13>
In-Reply-To: <20210713130538.646-5-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-5-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:29
+0000:

> In Octal DTR SPI mode, 2 bytes of data gets transmitted over one clock
> cycle, and half-cycle instruction phases aren't supported yet. So,
> every DTR spi_mem_op needs to have even nbytes in all phases for
> non-erratic behaviour from the SPI controller.
> 
> The odd length cmd and dummy phases get handled by spimem_setup_op()
> but the odd length address and data phases need to be handled according
> to the use case. For example in Octal DTR mode, read register operation
> has one byte long address and data phase. So it needs to extend it
> by adding a suitable extra byte in addr and reading 2 bytes of data,
> discarding the second byte.
> 
> Handle address and data phases for Octal DTR mode in read/write
> register and write volatile configuration register operations
> by adding a suitable extra byte in the address and data phase.
> 
> Create spimem_setup_reg_op() helper function to ease setting up
> read/write register operations in other functions, e.g. wait().
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 2e59faecc8f5..a5334ad34f96 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -65,12 +65,27 @@ static void spinand_setup_op(const struct spinand_device *spinand,
>  	}
>  }
>  
> +static void spinand_setup_reg_op(const struct spinand_device *spinand,
> +				 struct spi_mem_op *op)

Same remark about the naming. In fact I believe we could have this
logic in _setup_op() (or whatever its name) and add a specific
parameter for it?

> +{
> +	if (spinand->reg_proto == SPINAND_OCTAL_DTR) {
> +		/*
> +		 * Assigning same first and second byte will result in constant
> +		 * bits on ths SPI bus between positive and negative clock edges

                           the

> +		 */
> +		op->addr.val = (op->addr.val << 8) | op->addr.val;

I am not sure to understand what you do here?

> +		op->addr.nbytes = 2;
> +		op->data.nbytes = 2;
> +	}

Space

> +	spinand_setup_op(spinand, op);
> +}
> +
>  static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  {
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
> -						      spinand->scratchbuf);
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg, spinand->scratchbuf);

You can do this, but in a different commit.

>  	int ret;
>  
> +	spinand_setup_reg_op(spinand, &op);
>  	ret = spi_mem_exec_op(spinand->spimem, &op);
>  	if (ret)
>  		return ret;
> @@ -81,10 +96,10 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  
>  static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
>  {
> -	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
> -						      spinand->scratchbuf);
> +	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg, spinand->scratchbuf);

Same here.

>  
> -	*spinand->scratchbuf = val;
> +	spinand_setup_reg_op(spinand, &op);
> +	memset(spinand->scratchbuf, val, op.data.nbytes);
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> @@ -547,6 +562,7 @@ static int spinand_wait(struct spinand_device *spinand,
>  	u8 status;
>  	int ret;
>  
> +	spinand_setup_reg_op(spinand, &op);
>  	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
>  				  initial_delay_us,
>  				  poll_delay_us,

Thanks,
Miquèl
