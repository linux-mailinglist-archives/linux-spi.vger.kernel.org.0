Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FFC392B4A
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhE0KCI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 06:02:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49422 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhE0KCH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 06:02:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14RA0I9q048827;
        Thu, 27 May 2021 05:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622109618;
        bh=yllhb6T/ZjUJw0h6DWNoAvUmFdqdIc4o5sqdU2Agvb8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=D7x35cR0S6rAw+r1IFeXtz1lsSReYmfPybhUHdM57cMUdHgNy2KoLNog7GyRFIWN9
         aA4yiLxSuKH1TTvUspzOkrnpfaDPd9dtoes4ecor6TDs7UUj3W3AgIdXDnaTWkeoeU
         46yTrDJeWGpU6ZbC+3RCfVZq4ClGtWS5HM/t7vUA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14RA0IEB057541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 05:00:18 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 05:00:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 05:00:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14RA0HXm042965;
        Thu, 27 May 2021 05:00:18 -0500
Date:   Thu, 27 May 2021 15:30:17 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <patrice.chotard@foss.st.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: mtd: spinand: add spi nand mtd resume handler
Message-ID: <20210527100015.abxcroi23zyvcyzk@ti.com>
References: <20210526153016.32653-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210526153016.32653-1-patrice.chotard@foss.st.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26/05/21 05:30PM, patrice.chotard@foss.st.com wrote:
> From: Christophe Kerello <christophe.kerello@foss.st.com>
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
> This patch adds spi nand mtd PM handlers for resume ops.
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
> +			ret);
> +		return;
> +	}
> +
> +	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to updtae the OTP (err = %d)\n",
> +			ret);
> +		return;
> +	}

Since you have reset the flash, this cache is invalid. You should reset 
the cache and re-populate it before using it in any way.

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
> +}
> +

Most of these seem to be copied from spinand_init(). I think it is 
better to create a common function that can be called from both 
spinand_init() and spinand_mtd_resume(). This way when someone adds 
something new to the init procedure, like support for some other modes, 
they won't have to remember to update it in two places.

>  static int spinand_init(struct spinand_device *spinand)
>  {
>  	struct device *dev = &spinand->spimem->spi->dev;
> @@ -1167,6 +1222,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
>  	mtd->_erase = spinand_mtd_erase;
>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
> +	mtd->_resume = spinand_mtd_resume;

Is it possible that the userspace can use this mtd device before the 
resume is finished? Is there a way to temporarily "pause" or unregister 
an mtd device?

>  
>  	if (nand->ecc.engine) {
>  		ret = mtd_ooblayout_count_freebytes(mtd);

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
