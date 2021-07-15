Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0D33CA7C6
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbhGOS4N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 14:56:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34184 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbhGOSzx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jul 2021 14:55:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16FIqnbh087495;
        Thu, 15 Jul 2021 13:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626375169;
        bh=oOhcsRb4MdVEa4qNUlXy/o15RNo8STdLol5qitp0hIQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xxs9nUcB93F6p9Cx4M12+fQOeKZwCjXoyCw7n5OcPvsBpY/kN6p82Ri79SgJ477Fu
         6fcxGCtY5MQ2uyzyhSgLm2AZOF3sIkF9Upz6Ya2h/oWYVnULfD37wuLDcoZkGUsTmz
         1U8AZQlR/Fj+SyMAaZjvca3V/qoFbzlKIAIZvm30=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16FIqnGb065687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jul 2021 13:52:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 13:52:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Jul 2021 13:52:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16FIqm4T073354;
        Thu, 15 Jul 2021 13:52:49 -0500
Date:   Fri, 16 Jul 2021 00:22:48 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
CC:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v3] spi: spi-cadence-quadspi: Fix division by zero warning
Message-ID: <20210715185248.2ms4yjx24n5v4nef@ti.com>
References: <ed989af6-da88-4e0b-9ed8-126db6cad2e4@nskint.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed989af6-da88-4e0b-9ed8-126db6cad2e4@nskint.co.jp>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15/07/21 04:21PM, Yoshitaka Ikeda wrote:
> Fix below division by zero warning:
> - Added an if statement because buswidth can be zero, resulting in division by zero.
> - The modified code was based on another driver (atmel-quadspi).
> 
> [    0.795337] Division by zero in kernel.
>    :
> [    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
> [    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_exec_op+0x3b0/0x3f8)

Please add a fixes tag.

Fixes: 7512eaf54190 ("spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1")

> 
> Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
> ---
> v2:
> - Fix commit message.
> v3:
> - repost.
> 
>  drivers/spi/spi-cadence-quadspi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 7a00346ff9b9..13d1f0ce618e 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -307,11 +307,13 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
>  
>  static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
>  {
> -	unsigned int dummy_clk;
> +	unsigned int dummy_clk = 0;

I think you can just do:

  if (!op->dummy.nbytes)
	return 0;

and leave the rest same.

I don't think we should have to check for buswidth here, even though it 
is the one causing divide-by-zero. Any op with positive dummy nbytes but 
with 0 buswidth is invalid. That should be rejected by the SPI MEM core 
or the supports_op(), so it should never even get here.

>  
> -	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
> -	if (dtr)
> -		dummy_clk /= 2;
> +	if (op->dummy.buswidth && op->dummy.nbytes) {
> +		dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
> +		if (dtr)
> +			dummy_clk /= 2;
> +	}
>  
>  	return dummy_clk;
>  }
> -- 
> 2.32.0

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
