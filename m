Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6AF45EFB9
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 15:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349548AbhKZOTO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 09:19:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50568 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353623AbhKZORN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 09:17:13 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9818B1F46965;
        Fri, 26 Nov 2021 14:13:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637936039; bh=OkjA0UT408kvnapFvRVa4gDg+bEFbY4fEYND/wcVexI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OMQy5+tKdAI+07wt6nO5wleTsWCJwNtKqy6AS9agKlKy3qpoyN0dHhYc8cPN9ipRF
         RaOV7LHgru6yEivr6L1Yho0y+hj8rW7qTgdYRMXPJOXrPoHIDhQoV8dSBxvxgSksQC
         +7r+WcgFFe5rl9X+W4B7yUBqAQaJ5Gou/HNLsLme9VvKg+eCyBC6npjYOgF1G+pDWF
         UosJ8GVnns9srg2lPnUUC3G8kIAkNlxANh9RBcaZUjBuZDAvKAS3768Kvd5tjUdW3O
         25Bv3hZ/2tOjHI8Yk/fnrVm8BoVR5ChCNQnr/IJVZW2830O8q8s7P7ulm3cKmQmOyg
         jSJHPbh/E89sw==
Date:   Fri, 26 Nov 2021 15:13:52 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 15/20] mtd: spinand: Create direct mapping
 descriptors for ECC operations
Message-ID: <20211126151352.3bdd2c1a@collabora.com>
In-Reply-To: <20211126113924.310459-16-miquel.raynal@bootlin.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
        <20211126113924.310459-16-miquel.raynal@bootlin.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Nov 2021 12:39:19 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> In order for pipelined ECC engines to be able to enable/disable the ECC
> engine only when needed and avoid races when future parallel-operations
> will be supported, we need to provide the information about the use of
> the ECC engine in the direct mapping hooks. As direct mapping
> configurations are meant to be static, it is best to create two new
> mappings: one for regular 'raw' accesses and one for accesses involving
> correction. It is up to the driver to use or not the new ECC enable
> boolean contained in the spi-mem operation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/spi/core.c | 28 ++++++++++++++++++++++++++--
>  include/linux/mtd/spinand.h |  2 ++
>  include/linux/spi/spi-mem.h |  3 +++

I'd split that patch in 2: one adding the ecc_en field to spi_mem_op
and the other one using it in spinand.

>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 7027c09925e2..10ccffb6bf0d 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -381,7 +381,10 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
>  		}
>  	}
>  
> -	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> +	if (req->mode == MTD_OPS_RAW)
> +		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> +	else
> +		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
>  
>  	while (nbytes) {
>  		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
> @@ -452,7 +455,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  			       req->ooblen);
>  	}
>  
> -	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> +	if (req->mode == MTD_OPS_RAW)
> +		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> +	else
> +		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
>  
>  	while (nbytes) {
>  		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
> @@ -866,6 +872,24 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
>  
>  	spinand->dirmaps[plane].rdesc = desc;
>  
> +	info.op_tmpl = *spinand->op_templates.update_cache;
> +	info.op_tmpl.ecc_en = true;
> +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> +					  spinand->spimem, &info);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);
> +
> +	spinand->dirmaps[plane].wdesc_ecc = desc;
> +
> +	info.op_tmpl = *spinand->op_templates.read_cache;
> +	info.op_tmpl.ecc_en = true;
> +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> +					  spinand->spimem, &info);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);
> +
> +	spinand->dirmaps[plane].rdesc_ecc = desc;
> +

Direct mappings are not free (they might reserve a piece of MMIO
address space depending on the spi-mem controller implementation), so
I'd recommend creating those mapping only when strictly needed, that
is, when dealing with a pipelined ECC.

>  	return 0;
>  }
>  
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6988956b8492..3aa28240a77f 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -389,6 +389,8 @@ struct spinand_info {
>  struct spinand_dirmap {
>  	struct spi_mem_dirmap_desc *wdesc;
>  	struct spi_mem_dirmap_desc *rdesc;
> +	struct spi_mem_dirmap_desc *wdesc_ecc;
> +	struct spi_mem_dirmap_desc *rdesc_ecc;
>  };
>  
>  /**
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 85e2ff7b840d..3be594be24c0 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -94,6 +94,7 @@ enum spi_mem_data_dir {
>   *		 operation does not involve transferring data
>   * @data.buf.in: input buffer (must be DMA-able)
>   * @data.buf.out: output buffer (must be DMA-able)
> + * @ecc_en: error correction is required
>   */
>  struct spi_mem_op {
>  	struct {
> @@ -126,6 +127,8 @@ struct spi_mem_op {
>  			const void *out;
>  		} buf;
>  	} data;
> +
> +	bool ecc_en;
>  };
>  
>  #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\

