Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1735E3D11A8
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhGUOM7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 10:12:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33782 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhGUOM6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jul 2021 10:12:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LErYuV063063;
        Wed, 21 Jul 2021 09:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626879214;
        bh=AxRFfl1KWtjGMwXpDCKTpUH0BCBjea+MCAKLdEJs7nE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=c7Kp0re0DOtlmDe0ZbBk+1vHrfHw0FReJ1Wd4p5lr2Wre3tsPpscP1qhi+aBeIvY1
         8+uar3qNzjKq8WHIGZJdtpVlLuFXwaSXNLKpn/BQu1ZeZYSPsHF3dyuWJFYwYIU4j2
         s49mbozb9wXGMQ7lU8Eq4WZWFDkvLE0h1HrAjafw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LErYaN090166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 09:53:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 09:53:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 09:53:33 -0500
Received: from [10.250.234.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LErV8C105095;
        Wed, 21 Jul 2021 09:53:32 -0500
Subject: Re: [PATCH v2 2/2] spi: cadence-quadspi: Fix check condition for DTR
 ops
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20210716232504.182-1-a-nandan@ti.com>
 <20210716232504.182-3-a-nandan@ti.com>
From:   "Nandan, Apurva" <a-nandan@ti.com>
Message-ID: <c6bb03ff-1192-5276-4034-4a021e4f6923@ti.com>
Date:   Wed, 21 Jul 2021 20:23:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716232504.182-3-a-nandan@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 17-Jul-21 4:55 AM, Apurva Nandan wrote:
> buswidth and dtr fields in spi_mem_op are only valid when the
> corresponding spi_mem_op phase has a non-zero length. For example,
> SPI NAND core doesn't set buswidth when using SPI_MEM_OP_NO_ADDR
> phase.
> 
> Fix the dtr checks in set_protocol() and suppports_mem_op() to
> ignore empty spi_mem_op phases, as checking for dtr field in
> empty phase will result in false negatives.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index a2de23516553..1cec1c179a94 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -325,7 +325,15 @@ static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
>  	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
>  	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
>  	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
> -	f_pdata->dtr = op->data.dtr && op->cmd.dtr && op->addr.dtr;
> +
> +	/*
> +	 * For an op to be DTR, cmd phase along with every other non-empty
> +	 * phase should have dtr field set to 1. If an op phase has zero
> +	 * nbytes, ignore its dtr field; otherwise, check its dtr field.
> +	 */
> +	f_pdata->dtr = op->cmd.dtr &&
> +		       (!op->addr.nbytes || op->addr.dtr) &&
> +		       (!op->data.nbytes || op->data.dtr);
>  
>  	switch (op->data.buswidth) {
>  	case 0:
> @@ -1228,8 +1236,15 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
>  {
>  	bool all_true, all_false;
>  
> -	all_true = op->cmd.dtr && op->addr.dtr && op->dummy.dtr &&
> -		   op->data.dtr;
> +	/*
> +	 * op->dummy.dtr is required for converting nbytes into ncycles.
> +	 * Also, don't check the dtr field of the op phase having zero nbytes.
> +	 */
> +	all_true = op->cmd.dtr &&
> +		   (!op->addr.nbytes || op->addr.dtr) &&
> +		   (!op->dummy.nbytes || op->dummy.dtr) &&
> +		   (!op->data.nbytes || op->data.dtr);
> +
>  	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
>  		    !op->data.dtr;
>  
> 

Hi Mark,

Could you please have a look, I fixed the comments as you suggested.

Thanks and regards,
Apurva Nandan
