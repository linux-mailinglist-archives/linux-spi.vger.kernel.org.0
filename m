Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9453839339E
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhE0QY4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 27 May 2021 12:24:56 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35653 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhE0QY4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 12:24:56 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D745CFF806;
        Thu, 27 May 2021 16:23:18 +0000 (UTC)
Date:   Thu, 27 May 2021 18:23:17 +0200
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
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v3 3/3] mtd: spinand: add SPI-NAND MTD resume handler
Message-ID: <20210527182317.38d5edc6@xps13>
In-Reply-To: <20210527161252.16620-4-patrice.chotard@foss.st.com>
References: <20210527161252.16620-1-patrice.chotard@foss.st.com>
        <20210527161252.16620-4-patrice.chotard@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Patrice,

+ Pratyush

<patrice.chotard@foss.st.com> wrote on Thu, 27 May 2021 18:12:52 +0200:

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
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Changes in v3:
>   - Add spinand_read_cfg() call to repopulate cache
> 
> Changes in v2:
>   - Add helper spinand_block_unlock().
>   - Add spinand_ecc_enable() call.
>   - Remove some dev_err().
>   - Fix commit's title and message.
> 
>  drivers/mtd/nand/spi/core.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 1f699ad84f1b..e3fcbcf381c3 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1099,6 +1099,38 @@ static int spinand_block_unlock(struct spinand_device *spinand)
>  	return ret;
>  }
>  
> +static void spinand_mtd_resume(struct mtd_info *mtd)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +	int ret;
> +
> +	ret = spinand_reset_op(spinand);
> +	if (ret)
> +		return;
> +
> +	ret = spinand_read_cfg(spinand);
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

Sorry for not being clear, but I think what Pratyush meant was that
you could create a helper doing all the common initializations between
spinand_init() and spinand_resume() and call it from these places to
avoid code duplication. His comment somehow outclassed mine as I only
focused on the unlock part (which I think is clearer anyway, please keep
it like that).

> +
>  static int spinand_init(struct spinand_device *spinand)
>  {
>  	struct device *dev = &spinand->spimem->spi->dev;
> @@ -1186,6 +1218,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
>  	mtd->_erase = spinand_mtd_erase;
>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
> +	mtd->_resume = spinand_mtd_resume;
>  
>  	if (nand->ecc.engine) {
>  		ret = mtd_ooblayout_count_freebytes(mtd);

Thanks,
Miquèl
