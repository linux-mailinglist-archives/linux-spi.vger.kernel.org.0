Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525393CB339
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 09:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhGPH3x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 03:29:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43522 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhGPH3w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 03:29:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16G7QmhU128001;
        Fri, 16 Jul 2021 02:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626420408;
        bh=oU+d2k/3WH1n/HimaCkMZ+UTLhg08B4yYaY/fPrkE0Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=zG8mE1sRyTIoOJW9cWuFk4CKfVOMiMsThINxkmwiriR0N73DG+2jyp5YLxXZPEKkt
         X+f6N326S8x90t27LL9mczaq4SIX2ffuSiOGpgl8UeKMOLA6cmtF2131KZcAz4//pW
         I0617aW2SsOBASAtpoUu3R+anSwsOhc7wZI92djw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16G7Qma9125076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 02:26:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 02:26:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Jul 2021 02:26:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16G7Ql9b076917;
        Fri, 16 Jul 2021 02:26:48 -0500
Date:   Fri, 16 Jul 2021 12:56:46 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
CC:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v4 2/2] spi: spi-cadence-quadspi: Fix division by zero
 warning
Message-ID: <20210716072644.a2qz345zphakoq4e@ti.com>
References: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
 <958bb93b-db83-b685-5fa1-8e5dc40a5975@nskint.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <958bb93b-db83-b685-5fa1-8e5dc40a5975@nskint.co.jp>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/07/21 03:08AM, Yoshitaka Ikeda wrote:
> Fix below division by zero warning:
> - The reason for dividing by zero is because the dummy bus width is zero,
>   but if the dummy n bytes is zero, it indicates that there is no data transfer,
>   so we can just return zero without doing any calculations.
> 
> [    0.795337] Division by zero in kernel.
>    :
> [    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
> [    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_exec_op+0x3b0/0x3f8)
> 
> Fixes: 7512eaf54190 ("spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1")
> Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>

Thanks.

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> ---
>  drivers/spi/spi-cadence-quadspi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 7a00346ff9b9..d62d69dd72b9 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -309,6 +309,9 @@ static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
>  {
>  	unsigned int dummy_clk;
>  
> +	if (!op->dummy.nbytes)
> +		return 0;
> +
>  	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
>  	if (dtr)
>  		dummy_clk /= 2;
> -- 
> 2.32.0

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
