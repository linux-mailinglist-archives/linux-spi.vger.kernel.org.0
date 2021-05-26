Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA8391C3F
	for <lists+linux-spi@lfdr.de>; Wed, 26 May 2021 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhEZPoB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 26 May 2021 11:44:01 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56195 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhEZPn7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 May 2021 11:43:59 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B4F50100007;
        Wed, 26 May 2021 15:42:25 +0000 (UTC)
Date:   Wed, 26 May 2021 17:42:24 +0200
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
Subject: Re: mtd: spinand: add spi nand mtd resume handler
Message-ID: <20210526174224.2b8714fc@xps13>
In-Reply-To: <20210526153016.32653-1-patrice.chotard@foss.st.com>
References: <20210526153016.32653-1-patrice.chotard@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

<patrice.chotard@foss.st.com> wrote on Wed, 26 May 2021 17:30:16 +0200:

> From: Christophe Kerello <christophe.kerello@foss.st.com>

Would you mind to use "add SPI-NAND MTD resume handler" as title? (with
upper case letters)

> After power up, all SPI NAND's blocks are locked. Only read operations
> are allowed, write and erase operations are forbidden.
> The SPI NAND framework unlocks all the blocks during its initialization.
> 
> During a standby low power, the memory is powered down, losing its
> configuration.
> During the resume, the QSPI driver state is restored but the SPI NAND
> framework does not reconfigured the memory.
> 
> This patch adds spi nand mtd PM handlers for resume ops.

ditto             ^^^^^^^^^^^^

> SPI NAND resume op re-initializes SPI NAND flash to its probed state.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/mtd/nand/spi/core.c | 56 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 17f63f95f4a2..6abaf874eb3f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1074,6 +1074,61 @@ static int spinand_detect(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> +static void spinand_mtd_resume(struct mtd_info *mtd)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +	struct nand_device *nand = mtd_to_nanddev(mtd);
> +	struct device *dev = &spinand->spimem->spi->dev;
> +	int ret, i;
> +
> +	ret = spinand_reset_op(spinand);
> +	if (ret)
> +		return;
> +
> +	ret = spinand_init_quad_enable(spinand);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to initialize the quad part (err = %d)\n",

quad part? what about "Failed to resume the quad state" or something
alike?

> +			ret);
> +		return;
> +	}
> +
> +	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to updtae the OTP (err = %d)\n",

update

> +			ret);
> +		return;
> +	}
> +
> +	ret = spinand_manufacturer_init(spinand);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to initialize the SPI NAND chip (err = %d)\n",
> +			ret);
> +		return;
> +	}
> +
> +	/* After power up, all blocks are locked, so unlock them here. */
> +	for (i = 0; i < nand->memorg.ntargets; i++) {
> +		ret = spinand_select_target(spinand, i);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to select the target (err = %d)\n",
> +				ret);
> +			return;
> +		}
> +
> +		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to unlock block (err = %d)\n",
> +				ret);
> +			return;
> +		}
> +	}

I bet this would deserve a helper as this is the exact same peace of
code that is being run in spinnand_init()?

At the very least I think that spinand_ecc_enable(spinand, false);
should be called.

Ideally, a resume operation should be provided by ECC engines, but that
can be added later.

> +}
> +
>  static int spinand_init(struct spinand_device *spinand)
>  {
>  	struct device *dev = &spinand->spimem->spi->dev;
> @@ -1167,6 +1222,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
>  	mtd->_erase = spinand_mtd_erase;
>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
> +	mtd->_resume = spinand_mtd_resume;
>  
>  	if (nand->ecc.engine) {
>  		ret = mtd_ooblayout_count_freebytes(mtd);

Thanks,
Miquèl
