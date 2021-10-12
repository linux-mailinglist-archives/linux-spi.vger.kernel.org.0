Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61A7429E32
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 08:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhJLG4r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 02:56:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhJLG4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 02:56:41 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E611E1F410A6;
        Tue, 12 Oct 2021 07:54:38 +0100 (BST)
Date:   Tue, 12 Oct 2021 08:54:35 +0200
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
Subject: Re: [PATCH v2 05/14] mtd: spinand: Add adjust_op() in
 manufacturer_ops to modify the ops for manufacturer specific changes
Message-ID: <20211012085435.1aedfb7f@collabora.com>
In-Reply-To: <20211011204619.81893-6-a-nandan@ti.com>
References: <20211011204619.81893-1-a-nandan@ti.com>
        <20211011204619.81893-6-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 Oct 2021 02:16:10 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Manufacturers might use a variation of standard SPI NAND flash
> instructions, e.g. Winbond W35N01JW changes the dummy cycle length for
> read register commands when in Octal DTR mode.
> 
> Add new function in manufacturer_ops: adjust_op(), which can be called
> to correct the spi_mem op for any alteration in the instruction made by
> the manufacturers. And hence, this function can also be used for
> incorporating variations of SPI instructions in Octal DTR mode.

Okay, so now we have reg accesses differing between vendors in DTR.
Looks like we should have an OP-table for non-IO commands too (similar
to the op_variants mechanism we have for IO commands), at least when
operating in DTR. The reg access path would just end up doing:

	struct spi_mem_op op =
		spinand->templates[spinand->protocol][cmd];

This way you get rid of all this live-patching/vendor-specific
adjustment (which is likely to get more and more complex since flash
vendors have a tendency of diverging from the common behavior), and
everything gets initialized at probe time.

> 
> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 3 +++
>  include/linux/mtd/spinand.h | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 4da794ae728d..8e6cf7941a0f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -61,6 +61,9 @@ static void spinand_patch_op(const struct spinand_device *spinand,
>  		op->data.buswidth = op_buswidth;
>  		op->data.dtr = op_is_dtr;
>  	}
> +
> +	if (spinand->manufacturer->ops->adjust_op)
> +		spinand->manufacturer->ops->adjust_op(op, spinand->reg_proto);
>  }
>  
>  static void spinand_patch_reg_op(const struct spinand_device *spinand,
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index f6093cd98d7b..ebb19b2cec84 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -257,6 +257,8 @@ struct spinand_devid {
>  /**
>   * struct manufacurer_ops - SPI NAND manufacturer specific operations
>   * @init: initialize a SPI NAND device
> + * @adjust_op: modify the ops for any variation in their cmd, address, dummy or
> + *	       data phase by the manufacturer
>   * @cleanup: cleanup a SPI NAND device
>   *
>   * Each SPI NAND manufacturer driver should implement this interface so that
> @@ -264,6 +266,8 @@ struct spinand_devid {
>   */
>  struct spinand_manufacturer_ops {
>  	int (*init)(struct spinand_device *spinand);
> +	void (*adjust_op)(struct spi_mem_op *op,
> +			  const enum spinand_proto reg_proto);
>  	void (*cleanup)(struct spinand_device *spinand);
>  };
>  

