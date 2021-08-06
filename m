Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2A3E2FB4
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhHFTMw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 15:12:52 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54441 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhHFTMw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 15:12:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BA6AF1C0005;
        Fri,  6 Aug 2021 19:12:32 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:12:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 12/13] mtd: spinand: Perform Power-on-Reset when
 runtime_pm suspend is issued
Message-ID: <20210806211231.5c569939@xps13>
In-Reply-To: <20210713130538.646-13-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-13-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:37
+0000:

> A soft reset using FFh command doesn't erase the flash's configuration
> and doesn't reset the SPI IO mode also. This can result in the flash
> being in a different SPI IO mode, e.g. Octal DTR, when resuming from
> sleep. This would render the flash in an unusable state.

              could put the falsh in?

> Perform a Power-on-Reset (PoR), if available in the flash, when
> suspending the device by runtime_pm. This would set the flash to clean

I think runtime_pm is something else.

> state for reinitialization during resume and would also ensure that it
> is in standard SPI IO mode (1S-1S-1S) before the resume begins.

Please add a comment about this to explain why we don't do this reset
at resume time.

> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 608f4eb85b0a..6fb3aa6af540 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1329,6 +1329,21 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
>  	spinand_ecc_enable(spinand, false);
>  }
>  
> +static int spinand_mtd_suspend(struct mtd_info *mtd)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +	int ret;
> +
> +	if (!(spinand->flags & SPINAND_HAS_POR_CMD_BIT))
> +		return 0;
> +
> +	ret = spinand_power_on_rst_op(spinand);
> +	if (ret)
> +		dev_err(&spinand->spimem->spi->dev, "suspend() failed\n");
> +
> +	return ret;
> +}
> +
>  static int spinand_init(struct spinand_device *spinand)
>  {
>  	struct device *dev = &spinand->spimem->spi->dev;
> @@ -1401,6 +1416,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_erase = spinand_mtd_erase;
>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
>  	mtd->_resume = spinand_mtd_resume;
> +	mtd->_suspend = spinand_mtd_suspend;
>  
>  	if (nand->ecc.engine) {
>  		ret = mtd_ooblayout_count_freebytes(mtd);


Thanks,
Miquèl
