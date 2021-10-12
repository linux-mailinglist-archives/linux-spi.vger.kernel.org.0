Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB17429DDC
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhJLGlP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 02:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhJLGlP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 02:41:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37637C061570;
        Mon, 11 Oct 2021 23:39:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 074CA1F43331;
        Tue, 12 Oct 2021 07:39:11 +0100 (BST)
Date:   Tue, 12 Oct 2021 08:39:06 +0200
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
Subject: Re: [PATCH v2 02/14] mtd: spinand: Add enum spinand_proto to
 indicate current SPI IO mode
Message-ID: <20211012083906.30c50009@collabora.com>
In-Reply-To: <20211011204619.81893-3-a-nandan@ti.com>
References: <20211011204619.81893-1-a-nandan@ti.com>
        <20211011204619.81893-3-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 Oct 2021 02:16:07 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Unlike Dual and Quad SPI modes flashes, Octal DTR SPI NAND flashes
> require all instructions to be made in 8D-8D-8D protocol when the
> flash is in Octal DTR mode. Hence, storing the current SPI IO mode
> becomes necessary for correctly generating non-array access operations.
> 
> Store the current SPI IO mode in the spinand struct using a reg_proto
> enum. This would act as a flag, denoting that the core should use
> the given SPI protocol for non-page access operations.
> 
> Also provide basic macros for extracting buswidth and dtr mode
> information from the spinand_proto enum.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c |  2 ++
>  include/linux/mtd/spinand.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 2c8685f1f2fa..d82a3e6d9bb5 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1155,6 +1155,7 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
>  	struct spinand_device *spinand = mtd_to_spinand(mtd);
>  	int ret;
>  
> +	spinand->reg_proto = SPINAND_SINGLE_STR;
>  	ret = spinand_reset_op(spinand);
>  	if (ret)
>  		return;
> @@ -1181,6 +1182,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	if (!spinand->scratchbuf)
>  		return -ENOMEM;
>  
> +	spinand->reg_proto = SPINAND_SINGLE_STR;
>  	ret = spinand_detect(spinand);
>  	if (ret)
>  		goto err_free_bufs;
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6988956b8492..f6093cd98d7b 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -140,6 +140,31 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
>  
> +#define SPINAND_PROTO_BUSWIDTH_MASK	GENMASK(6, 0)
> +#define SPINAND_PROTO_DTR_BIT		BIT(7)
> +
> +#define SPINAND_PROTO_STR(__buswidth)	\
> +	((u8)(((__buswidth) - 1) & SPINAND_PROTO_BUSWIDTH_MASK))
> +#define SPINAND_PROTO_DTR(__buswidth)	\
> +	(SPINAND_PROTO_DTR_BIT | SPINAND_PROTO_STR(__buswidth))
> +
> +#define SPINAND_PROTO_BUSWIDTH(__proto)	\
> +	((u8)(((__proto) & SPINAND_PROTO_BUSWIDTH_MASK) + 1))
> +#define SPINAND_PROTO_IS_DTR(__proto)	(!!((__proto) & SPINAND_PROTO_DTR_BIT))
> +
> +/**
> + * enum spinand_proto - List allowable SPI protocol variants for read reg,
> + *			write reg, blk erase, write enable/disable, page read
> + *			and program exec operations.
> + */
> +enum spinand_proto {

s/spinand_proto/spinand_protocol/

> +	SPINAND_SINGLE_STR = SPINAND_PROTO_STR(1),
> +	SPINAND_DUAL_STR = SPINAND_PROTO_STR(2),
> +	SPINAND_QUAD_STR = SPINAND_PROTO_STR(4),
> +	SPINAND_OCTAL_STR = SPINAND_PROTO_STR(8),
> +	SPINAND_OCTAL_DTR = SPINAND_PROTO_DTR(8),

Why not have a contiguous enum listing all the modes? Are you extracting
the buswidth from these values?

> +};
> +
>  /**
>   * Standard SPI NAND flash commands
>   */
> @@ -407,6 +432,9 @@ struct spinand_dirmap {
>   *		   this die. Only required if your chip exposes several dies
>   * @cur_target: currently selected target/die
>   * @eccinfo: on-die ECC information
> + * @reg_proto: select a variant of SPI IO protocol (single, quad, octal or
> + *	       octal DTR) for read_reg/write_reg/erase operations. Update on
> + *	       successful transition into a different SPI IO protocol.
>   * @cfg_cache: config register cache. One entry per die
>   * @databuf: bounce buffer for data
>   * @oobbuf: bounce buffer for OOB data
> @@ -438,6 +466,8 @@ struct spinand_device {
>  
>  	struct spinand_ecc_info eccinfo;
>  
> +	enum spinand_proto reg_proto;
> +

I guess this mode will apply to all sort of commands, not just reg
accesses, so why not name it protocol or mode?

>  	u8 *cfg_cache;
>  	u8 *databuf;
>  	u8 *oobbuf;

