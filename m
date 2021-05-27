Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31455392A1D
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhE0IzY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 27 May 2021 04:55:24 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38391 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhE0IzX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 04:55:23 -0400
X-Greylist: delayed 87667 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 04:55:23 EDT
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7F6EAC000D;
        Thu, 27 May 2021 08:53:47 +0000 (UTC)
Date:   Thu, 27 May 2021 10:53:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v2] mtd: spinand: add SPI-NAND MTD resume handler
Message-ID: <20210527105346.315cf125@xps13>
In-Reply-To: <20210527084959.1548-1-patrice.chotard@foss.st.com>
References: <20210527084959.1548-1-patrice.chotard@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Patrice,

<patrice.chotard@foss.st.com> wrote on Thu, 27 May 2021 10:49:59 +0200:

> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> After power up, all SPI NAND's blocks are locked. Only read operations
> are allowed, write and erase operations are forbidden.
> The SPI NAND framework unlocks all the blocks during its initialization.
> 
> During a standby low power, the memory is powered down, losing its
> configuration.
> During the resume, the QSPI driver state is restored but the SPI NAND
> framework does not reconfigured the memory.
> 
> This patch adds SPI-NAND MTD PM handlers for resume ops.
> SPI NAND resume op re-initializes SPI NAND flash to its probed state.
> 
> It also adds a new helper spinand_block_unlock() which is
> called in spinand_init() and in spinand_mtd_resume().
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Changes in v2:
>   - Add helper spinand_block_unlock().
>   - Add spinand_ecc_enable() call.
>   - Remove some dev_err().
>   - Fix commit's title and message.
> 
>  drivers/mtd/nand/spi/core.c | 62 +++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 17f63f95f4a2..f77aeff11f43 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1074,6 +1074,55 @@ static int spinand_detect(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> +static int spinand_block_unlock(struct spinand_device *spinand)
> +{
> +	struct device *dev = &spinand->spimem->spi->dev;
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	int ret = 0, i;
> +
> +	for (i = 0; i < nand->memorg.ntargets; i++) {
> +		ret = spinand_select_target(spinand, i);
> +		if (ret)
> +			return ret;
> +
> +		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}

Please insert this helper (and use it in the probe) in a separate
patch, so that patch 2/2 only implements the _resume hook.

> +
> +static void spinand_mtd_resume(struct mtd_info *mtd)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +	struct nand_device *nand = mtd_to_nanddev(mtd);
> +	struct device *dev = &spinand->spimem->spi->dev;
> +	int ret;
> +
> +	ret = spinand_reset_op(spinand);
> +	if (ret)
> +		return;
> +
> +	ret = spinand_init_quad_enable(spinand);
> +	if (ret)
> +		return;
> +
> +	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> +	if (ret)
> +		return;
> +
> +	ret = spinand_manufacturer_init(spinand);
> +	if (ret)
> +		return;
> +
> +	ret = spinand_block_unlock(spinand);
> +	if (ret)
> +		return;
> +
> +	spinand_ecc_enable(spinand, false);
> +}
> +
>  static int spinand_init(struct spinand_device *spinand)
>  {
>  	struct device *dev = &spinand->spimem->spi->dev;
> @@ -1137,15 +1186,9 @@ static int spinand_init(struct spinand_device *spinand)
>  	}
>  
>  	/* After power up, all blocks are locked, so unlock them here. */
> -	for (i = 0; i < nand->memorg.ntargets; i++) {
> -		ret = spinand_select_target(spinand, i);
> -		if (ret)
> -			goto err_manuf_cleanup;
> -
> -		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
> -		if (ret)
> -			goto err_manuf_cleanup;
> -	}
> +	ret = spinand_block_unlock(spinand);
> +	if ret)

I doubt this as even be build-tested :)

> +		goto err_manuf_cleanup;
>  
>  	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
>  	if (ret)
> @@ -1167,6 +1210,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
>  	mtd->_erase = spinand_mtd_erase;
>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
> +	mtd->_resume = spinand_mtd_resume;
>  
>  	if (nand->ecc.engine) {
>  		ret = mtd_ooblayout_count_freebytes(mtd);

Thanks,
Miquèl
