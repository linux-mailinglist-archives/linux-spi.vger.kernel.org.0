Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3D429DDF
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhJLGmy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 02:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhJLGmx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 02:42:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92C9C061570;
        Mon, 11 Oct 2021 23:40:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 202531F40F0B;
        Tue, 12 Oct 2021 07:40:51 +0100 (BST)
Date:   Tue, 12 Oct 2021 08:40:47 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>
Subject: Re: [PATCH v2 03/14] mtd: spinand: Patch spi_mem_op for the SPI IO
 protocol using reg_proto
Message-ID: <20211012084047.6381ddce@collabora.com>
In-Reply-To: <20211011204619.81893-4-a-nandan@ti.com>
References: <20211011204619.81893-1-a-nandan@ti.com>
        <20211011204619.81893-4-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 Oct 2021 02:16:08 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Currently, the op macros in spinand.h don't give the option to setup
> any non-array access instructions for Dual/Quad/Octal DTR SPI bus.
> Having a function that patches the op based on reg_proto would be
> better than trying to write all the setup logic in op macros.
> 
> Create a spimem_patch_op() that would patch cmd, addr, dummy and data
> phase of the spi_mem op, for the given spinand->reg_proto. And hence,
> call the spimem_patch_op() before executing any spi_mem op.

I'm honestly not sure this rule will stand over time, and patching
operations at submission time has a cost (ok, it's negligible compared
to the IO duration, but still), so I'd rather see this done statically
with all relevant macros taking an extra dtr argument.

> 
> Note: In this commit, spimem_patch_op() isn't called in the
> read_reg_op(), write_reg_op() and wait() functions, as they need
> modifications in address value and data nbytes when in Octal DTR mode.
> This will be fixed in a later commit.

See, that's what I'm talking about.

> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index d82a3e6d9bb5..11746d858f87 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -20,6 +20,49 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>  
> +/**
> + * spinand_patch_op() - Helper function to patch the spi_mem op based on the
> + *			spinand->reg_proto
> + * @spinand: the spinand device
> + * @op: the spi_mem op to patch
> + *
> + * Set up buswidth and dtr fields for cmd, addr, dummy and data phase. Also
> + * adjust cmd opcode and dummy nbytes. This function doesn't make any changes
> + * to addr val or data buf.
> + */
> +static void spinand_patch_op(const struct spinand_device *spinand,
> +			     struct spi_mem_op *op)
> +{
> +	u8 op_buswidth = SPINAND_PROTO_BUSWIDTH(spinand->reg_proto);
> +	u8 op_is_dtr = SPINAND_PROTO_IS_DTR(spinand->reg_proto);
> +
> +	if (spinand->reg_proto == SPINAND_SINGLE_STR)
> +		return;
> +
> +	op->cmd.buswidth = op_buswidth;
> +	op->cmd.dtr = op_is_dtr;
> +	if (spinand->reg_proto == SPINAND_OCTAL_DTR) {
> +		op->cmd.opcode = (op->cmd.opcode << 8) | op->cmd.opcode;
> +		op->cmd.nbytes = 2;
> +	}
> +
> +	if (op->addr.nbytes) {
> +		op->addr.buswidth = op_buswidth;
> +		op->addr.dtr = op_is_dtr;
> +	}
> +
> +	if (op->dummy.nbytes) {
> +		op->dummy.buswidth = op_buswidth;
> +		op->dummy.dtr = op_is_dtr;
> +		op->dummy.nbytes <<= op_is_dtr;
> +	}
> +
> +	if (op->data.nbytes) {
> +		op->data.buswidth = op_buswidth;
> +		op->data.dtr = op_is_dtr;
> +	}
> +}
> +
>  static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  {
>  	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
> @@ -343,6 +386,7 @@ static int spinand_write_enable_op(struct spinand_device *spinand)
>  {
>  	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
>  
> +	spinand_patch_op(spinand, &op);
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> @@ -353,6 +397,7 @@ static int spinand_load_page_op(struct spinand_device *spinand,
>  	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
>  	struct spi_mem_op op = SPINAND_PAGE_READ_OP(row);
>  
> +	spinand_patch_op(spinand, &op);
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> @@ -477,6 +522,7 @@ static int spinand_program_op(struct spinand_device *spinand,
>  	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
>  	struct spi_mem_op op = SPINAND_PROG_EXEC_OP(row);
>  
> +	spinand_patch_op(spinand, &op);
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> @@ -487,6 +533,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
>  	unsigned int row = nanddev_pos_to_row(nand, pos);
>  	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
>  
> +	spinand_patch_op(spinand, &op);
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> @@ -533,6 +580,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
>  		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
>  	int ret;
>  
> +	spinand_patch_op(spinand, &op);
>  	ret = spi_mem_exec_op(spinand->spimem, &op);
>  	if (!ret)
>  		memcpy(buf, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
> @@ -545,6 +593,7 @@ static int spinand_reset_op(struct spinand_device *spinand)
>  	struct spi_mem_op op = SPINAND_RESET_OP;
>  	int ret;
>  
> +	spinand_patch_op(spinand, &op);
>  	ret = spi_mem_exec_op(spinand->spimem, &op);
>  	if (ret)
>  		return ret;

