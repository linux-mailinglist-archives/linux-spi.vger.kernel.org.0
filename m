Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793A33E2F92
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhHFS7F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 14:59:05 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59659 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhHFS7E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 14:59:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B461740003;
        Fri,  6 Aug 2021 18:58:46 +0000 (UTC)
Date:   Fri, 6 Aug 2021 20:58:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 07/13] mtd: spinand: Allow enabling Octal DTR mode in
 the core
Message-ID: <20210806205845.03dd97c9@xps13>
In-Reply-To: <20210713130538.646-8-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-8-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:32
+0000:

> Enable Octal DTR SPI mode, i.e. 8D-8D-8D mode, if the SPI NAND flash
> device supports it. Mixed OSPI (1S-1S-8S & 1S-8S-8S), mixed DTR modes
> (1S-1D-8D), etc. aren't supported yet.
> 
> The method to switch to Octal DTR SPI mode may vary across
> manufacturers. For example, for Winbond, it is enabled by writing
> values to the volatile configuration register. So, let the
> manufacturer's code have their own implementation for switching to
> Octal DTR SPI mode. Mixed OSPI (1S-1S-8S & 1S-8S-8S), mixed DTR modes
> (1S-1D-8D), etc. aren't supported yet.

You can drop the final sentence which is a repetition of the previous
paragraph.

> Check for the SPI NAND device's support for Octal DTR mode using
> spinand flags, and if the op_templates allow 8D-8D-8D, call
                                         allows

> octal_dtr_enable() manufacturer op. If the SPI controller doesn't
> supports these modes, the selected op_templates would prevent switching

                                                  will

> to the Octal DTR mode. And finally update the spinand reg_proto
> if success.

  on

> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 46 +++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h |  3 +++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 1e619b6d777f..19d8affac058 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -256,6 +256,48 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
>  			       enable ? CFG_QUAD_ENABLE : 0);
>  }
>  
> +static bool spinand_op_is_octal_dtr(const struct spi_mem_op *op)
> +{
> +	return  op->cmd.buswidth == 8 && op->cmd.dtr &&
> +		op->addr.buswidth == 8 && op->addr.dtr &&
> +		op->data.buswidth == 8 && op->data.dtr;
> +}
> +
> +static int spinand_init_octal_dtr_enable(struct spinand_device *spinand)
> +{
> +	struct device *dev = &spinand->spimem->spi->dev;
> +	int ret;
> +
> +	if (!(spinand->flags & SPINAND_HAS_OCTAL_DTR_BIT))
> +		return 0;
> +
> +	if (!(spinand_op_is_octal_dtr(spinand->op_templates.read_cache) &&
> +	      spinand_op_is_octal_dtr(spinand->op_templates.write_cache) &&
> +	      spinand_op_is_octal_dtr(spinand->op_templates.update_cache)))
> +		return 0;
> +
> +	if (!spinand->manufacturer->ops->octal_dtr_enable) {
> +		dev_err(dev,
> +			"Missing ->octal_dtr_enable(), unable to switch mode\n");

I don't think we want an error here. Perhaps a debug or info call, but
no more.

> +		return -EINVAL;
> +	}
> +
> +	ret = spinand->manufacturer->ops->octal_dtr_enable(spinand);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to enable Octal DTR SPI mode (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	spinand->reg_proto = SPINAND_OCTAL_DTR;
> +
> +	dev_dbg(dev,
> +		"%s SPI NAND switched to Octal DTR SPI (8D-8D-8D) mode\n",
> +		spinand->manufacturer->name);
> +	return 0;
> +}
> +
>  static int spinand_ecc_enable(struct spinand_device *spinand,
>  			      bool enable)
>  {
> @@ -1189,6 +1231,10 @@ static int spinand_init_flash(struct spinand_device *spinand)
>  	if (ret)
>  		return ret;
>  
> +	ret = spinand_init_octal_dtr_enable(spinand);
> +	if (ret)
> +		return ret;
> +
>  	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 35816b8cfe81..daa2ac5c3110 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -271,6 +271,7 @@ struct spinand_devid {
>   * @init: initialize a SPI NAND device
>   * @adjust_op: modify the ops for any variation in their cmd, address, dummy or
>   *	       data phase by the manufacturer
> + * @octal_dtr_enable: switch the SPI NAND flash into Octal DTR SPI mode
>   * @cleanup: cleanup a SPI NAND device
>   *
>   * Each SPI NAND manufacturer driver should implement this interface so that
> @@ -280,6 +281,7 @@ struct spinand_manufacturer_ops {
>  	int (*init)(struct spinand_device *spinand);
>  	void (*adjust_op)(struct spi_mem_op *op,
>  			  const enum spinand_proto reg_proto);
> +	int (*octal_dtr_enable)(struct spinand_device *spinand);
>  	void (*cleanup)(struct spinand_device *spinand);
>  };
>  
> @@ -348,6 +350,7 @@ struct spinand_ecc_info {
>  
>  #define SPINAND_HAS_QE_BIT		BIT(0)
>  #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
> +#define SPINAND_HAS_OCTAL_DTR_BIT	BIT(2)
>  
>  /**
>   * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure




Thanks,
Miquèl
