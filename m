Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3100F40FE15
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 18:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbhIQQob (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 12:44:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40548 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhIQQoa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 12:44:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18HGguOr096260;
        Fri, 17 Sep 2021 11:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631896976;
        bh=F1z5iBqEvqCrmXyP8jDS18dtW3nIzY7sJIz18RBbWFw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qt0Nh3KLzR1fhhnYqFwMCrJM/C1qHUudmidql8Xn5FLSLvG7+8ra650DEXopi3GmE
         9cAkkUxHKjwK2/h9XK0C/c+AV4cN6YEk9/3LrkB1A1eE8RBULQJYogemKwxLfyBJ6B
         sVeRpVZcXp0Vxyzq1lnl/mRc9YDqPZfXi+0uSXSg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18HGguNO113957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Sep 2021 11:42:56 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Sep 2021 11:42:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Sep 2021 11:42:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18HGg1eB062022;
        Fri, 17 Sep 2021 11:42:02 -0500
Date:   Fri, 17 Sep 2021 22:12:01 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
CC:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH] spi: Fixed division by zero warning
Message-ID: <20210917164159.n75ccthyvfrud2i7@ti.com>
References: <OSZPR01MB70049C8F56ED8902852DF97B8BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB70049C8F56ED8902852DF97B8BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yoshitaka,

On 08/09/21 05:29AM, Yoshitaka Ikeda wrote:
> The reason for dividing by zero is because the dummy bus width is zero,
> but if the dummy n bytes is zero, it indicates that there is no data transfer,
> so there is no need for calculation.
> 
> Fixes: 7512eaf54190 ("spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1")

You are right, there is no need for this.

> Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
> ---
>  drivers/spi/atmel-quadspi.c  | 2 +-
>  drivers/spi/spi-bcm-qspi.c   | 3 ++-
>  drivers/spi/spi-mtk-nor.c    | 2 +-
>  drivers/spi/spi-stm32-qspi.c | 2 +-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 95d4fa32c299..92d9610df1fd 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -310,7 +310,7 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
>  		return mode;
>  	ifr |= atmel_qspi_modes[mode].config;
>  
> -	if (op->dummy.buswidth && op->dummy.nbytes)
> +	if (op->dummy.nbytes)
>  		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
>  
>  	/*
> diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> index a78e56f566dd..0d95fe54b3c0 100644
> --- a/drivers/spi/spi-bcm-qspi.c
> +++ b/drivers/spi/spi-bcm-qspi.c
> @@ -395,7 +395,8 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
>  	if (addrlen == BSPI_ADDRLEN_4BYTES)
>  		bpp = BSPI_BPP_ADDR_SELECT_MASK;
>  
> -	bpp |= (op->dummy.nbytes * 8) / op->dummy.buswidth;
> +	if (op->dummy.nbytes)
> +		bpp |= (op->dummy.nbytes * 8) / op->dummy.buswidth;

This is a legitimate fix. The other 3 won't make much of a difference in 
practice but are good changes regardless IMO.

Acked-by: Pratyush Yadav <p.yadav@ti.com>

>  
>  	switch (width) {
>  	case SPI_NBITS_SINGLE:
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index 41e7b341d261..5c93730615f8 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -160,7 +160,7 @@ static bool mtk_nor_match_read(const struct spi_mem_op *op)
>  {
>  	int dummy = 0;
>  
> -	if (op->dummy.buswidth)
> +	if (op->dummy.nbytes)
>  		dummy = op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth;
>  
>  	if ((op->data.buswidth == 2) || (op->data.buswidth == 4)) {
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index 27f35aa2d746..514337c86d2c 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -397,7 +397,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
>  		ccr |= FIELD_PREP(CCR_ADSIZE_MASK, op->addr.nbytes - 1);
>  	}
>  
> -	if (op->dummy.buswidth && op->dummy.nbytes)
> +	if (op->dummy.nbytes)
>  		ccr |= FIELD_PREP(CCR_DCYC_MASK,
>  				  op->dummy.nbytes * 8 / op->dummy.buswidth);
>  
> -- 
> 2.33.0

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
