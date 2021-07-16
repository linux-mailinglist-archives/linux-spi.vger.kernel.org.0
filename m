Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0763CB33B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhGPHav (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 03:30:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33858 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhGPHav (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 03:30:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16G7RlHg060486;
        Fri, 16 Jul 2021 02:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626420467;
        bh=RNfr0OhMRKLvkLe8LwsQdRr+TSvGCqTg4hp48Xk/1fc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iANpHh+DUfRO+EXdykNfsAyVzOU2j37rRlYA2E16goPkhV4vjdKp+1VEAhEHmLVEf
         it+rYobOTnkh80c7sRwFXkqfOzxX78rv1al0ybYdK5v2NxmALJaRIKG9Zh66cI+9ED
         kOh91udlycEbHnxSzqwNXUkqGTsBBH7Ill8i2wh4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16G7RlMM009432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 02:27:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 02:27:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Jul 2021 02:27:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16G7Rkam012643;
        Fri, 16 Jul 2021 02:27:46 -0500
Date:   Fri, 16 Jul 2021 12:57:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
CC:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v4 1/2] spi: spi-cadence-quadspi: Revert "Fix division by
 zero warning"
Message-ID: <20210716072743.5fvcw4d52cvnqo2i@ti.com>
References: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
 <760be709-74d1-14cc-fecf-433786e123aa@nskint.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <760be709-74d1-14cc-fecf-433786e123aa@nskint.co.jp>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/07/21 03:07AM, Yoshitaka Ikeda wrote:
> Revert to change to a better code.
> 
> This reverts commit 55cef88bbf12f3bfbe5c2379a8868a034707e755.

I don't think this is needed since your earlier version was not applied 
to the SPI tree in the first place. Patch 2 alone should be enough.

> ---
>  drivers/spi/spi-cadence-quadspi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 13d1f0ce618e..7a00346ff9b9 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -307,13 +307,11 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
>  
>  static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
>  {
> -	unsigned int dummy_clk = 0;
> +	unsigned int dummy_clk;
>  
> -	if (op->dummy.buswidth && op->dummy.nbytes) {
> -		dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
> -		if (dtr)
> -			dummy_clk /= 2;
> -	}
> +	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
> +	if (dtr)
> +		dummy_clk /= 2;
>  
>  	return dummy_clk;
>  }
> -- 
> 2.32.0

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
