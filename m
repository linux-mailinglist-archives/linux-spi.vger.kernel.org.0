Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EB429E91
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhJLH1S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 03:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhJLH1P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 03:27:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F22C061745;
        Tue, 12 Oct 2021 00:25:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 904081F42FFF;
        Tue, 12 Oct 2021 08:25:11 +0100 (BST)
Date:   Tue, 12 Oct 2021 09:25:08 +0200
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
Subject: Re: [PATCH v2 11/14] mtd: spinand: Perform Power-on-Reset on the
 flash in mtd_suspend()
Message-ID: <20211012092508.1647047b@collabora.com>
In-Reply-To: <20211011204619.81893-12-a-nandan@ti.com>
References: <20211011204619.81893-1-a-nandan@ti.com>
        <20211011204619.81893-12-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 Oct 2021 02:16:16 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> A soft reset using FFh command doesn't erase the flash's configuration
> and doesn't reset the SPI IO mode also. This can result in the flash
> being in a different SPI IO mode, e.g. Octal DTR, when resuming from
> sleep. This could put the flash in an unrecognized SPI IO mode, making
> it unusable.
> 
> Perform a Power-on-Reset (PoR), if available in the flash, when
> performing mtd_suspend(). This would set the flash to clean
> state for reinitialization during resume and would also ensure that it
> is in standard SPI IO mode (1S-1S-1S) before the resume begins.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 9b570570ee81..60408531979a 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1316,6 +1316,11 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
>  	int ret;
>  
>  	spinand->reg_proto = SPINAND_SINGLE_STR;
> +	/*
> +	 * PoR Reset (if available by the manufacturer) is performed at the suspend
> +	 * time. Hence, those flashes remain in power-on-state at this point, in a
> +	 * standard SPI IO mode. So, now the core unanimously performs a soft reset.
> +	 */
>  	ret = spinand_reset_op(spinand);
>  	if (ret)
>  		return;
> @@ -1327,6 +1332,21 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
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

I suspect you need to implement the spi_mem_driver.shutdown() method
and do a PoR in that case too. If the device doesn't support the PoR
command, we should at least switch back to the 1-1-1-STR mode manually.

> +
>  static int spinand_init(struct spinand_device *spinand)
>  {
>  	struct device *dev = &spinand->spimem->spi->dev;
> @@ -1399,6 +1419,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_erase = spinand_mtd_erase;
>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
>  	mtd->_resume = spinand_mtd_resume;
> +	mtd->_suspend = spinand_mtd_suspend;
>  
>  	if (nand->ecc.engine) {
>  		ret = mtd_ooblayout_count_freebytes(mtd);

