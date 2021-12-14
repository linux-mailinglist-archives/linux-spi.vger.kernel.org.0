Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E80474C4E
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhLNTxv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 14:53:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54344 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhLNTxv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 14:53:51 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BEJrJ48071964;
        Tue, 14 Dec 2021 13:53:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639511599;
        bh=prAuP7mo0lP220rcwOXoftwQEXyH1pVi5J9ELzETj+M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=G4ygR2h3C5W7GSGQEH4yQ9OioN623J5lc29taiP5ZrpLLNuw+pIakuJ5eXsESNfk+
         6nkXkbbbC8h8waEtBJRl4InMCDvpUUnlqcNUr0uquGp2W2DG5rcp3LpwR4zVKBmoCY
         hs8lUfTKof3G4SxlbQLhemtnaPh8/N6vJox8O8RQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BEJrJGX100307
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 13:53:19 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Dec 2021 13:53:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Dec 2021 13:53:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BEJrImq099166;
        Tue, 14 Dec 2021 13:53:18 -0600
Date:   Wed, 15 Dec 2021 01:23:17 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v5 04/13] spi: spi-mem: Create a helper to gather all the
 supports_op checks
Message-ID: <20211214195315.f7wr6ao6bdma47cn@ti.com>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
 <20211214114140.54629-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211214114140.54629-5-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

On 14/12/21 12:41PM, Miquel Raynal wrote:
> So far we check the support for:
> - regular operations
> - dtr operations
> Soon, we will also need to check the support for ECC operations.
> 
> As the combinatorial will increase exponentially, let's gather all the
> checks in a single generic function which takes a capabilities structure
> as input. This new helper is supposed to be called by the currently
> exported functions instead of repeating a similar implementation.

Nice! I think this is a very good idea.

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-mem.c       | 34 +++++++++++++++++++++++++---------
>  include/linux/spi/spi-mem.h |  8 ++++++++
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 37f4443ce9a0..4c6944d7b174 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -160,26 +160,42 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
>  	return true;
>  }
>  
> +static bool spi_mem_generic_supports_op(struct spi_mem *mem,
> +					const struct spi_mem_op *op,
> +					struct spi_mem_controller_caps *caps)
> +{
> +	if (!caps->dtr) {

Nitpick: Please turn the order of the if-else around:

  if (caps->dtr)
    ...
  else
    ...

> +		if (op->cmd.dtr || op->addr.dtr ||
> +		    op->dummy.dtr || op->data.dtr)
> +			return false;
> +
> +		if (op->cmd.nbytes != 1)
> +			return false;
> +	} else {
> +		if (op->cmd.nbytes != 2)
> +			return false;
> +	}
> +
> +	return spi_mem_check_buswidth(mem, op);
> +}
> +
>  bool spi_mem_dtr_supports_op(struct spi_mem *mem,
>  			     const struct spi_mem_op *op)
>  {
> -	if (op->cmd.nbytes != 2)
> -		return false;
> +	struct spi_mem_controller_caps caps = {
> +		.dtr = true,
> +	};
>  
> -	return spi_mem_check_buswidth(mem, op);
> +	return spi_mem_generic_supports_op(mem, op, &caps);
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
>  
>  bool spi_mem_default_supports_op(struct spi_mem *mem,
>  				 const struct spi_mem_op *op)

I know this would require a little bit more work from you, but can we 
make spi_mem_default_supports_op() accept the caps as a parameter? And 
drop spi_mem_dtr_supports_op() while we are at it? This would be a lot 
neater I think since we won't have lots of wrapper functions lying 
around.

>  {
> -	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
> -		return false;
> +	struct spi_mem_controller_caps caps = {};
>  
> -	if (op->cmd.nbytes != 1)
> -		return false;
> -
> -	return spi_mem_check_buswidth(mem, op);
> +	return spi_mem_generic_supports_op(mem, op, &caps);
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
>  
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 85e2ff7b840d..f365efcfb719 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -220,6 +220,14 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
>  	return mem->drvpriv;
>  }
>  
> +/**
> + * struct spi_mem_controller_caps - SPI memory controller capabilities
> + * @dtr: Supports DTR operations
> + */
> +struct spi_mem_controller_caps {
> +	bool dtr;
> +};
> +
>  /**
>   * struct spi_controller_mem_ops - SPI memory operations
>   * @adjust_op_size: shrink the data xfer of an operation to match controller's
> -- 
> 2.27.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
