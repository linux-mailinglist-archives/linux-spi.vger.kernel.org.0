Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983492F2C80
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 11:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404540AbhALKSc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Jan 2021 05:18:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52596 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404478AbhALKSb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Jan 2021 05:18:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10CAGc5i073361;
        Tue, 12 Jan 2021 04:16:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610446598;
        bh=i4Npid+bip9qbNU502qVBCP5QWh3Vi1iAJKNBxu+M+I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YNgbunyhB6FxE4dtYfnmQjWdTRJJAlMEwuCPtvBp17QSJuWEUagetUHL0DuwxSvsM
         j46nm2NQkaSWfLknkgxbzfSXeonZTKVLeD0ZGSIS8kul96BeiQ6cPosw91qEaI3xFG
         vPzisrGty9G3+n5cPfLpx9YPLsEvGZFAsUZzDMEo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10CAGcxg005877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 04:16:38 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 04:16:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 04:16:37 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10CAGbhI103211;
        Tue, 12 Jan 2021 04:16:37 -0600
Date:   Tue, 12 Jan 2021 15:46:36 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 1/1] spi: cadence-quadspi: Fix a compilation warning for
 64-bit platform
Message-ID: <20210112101634.ikmhj4au6eogkhoq@ti.com>
References: <20210112100637.747-1-thunder.leizhen@huawei.com>
 <20210112100637.747-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210112100637.747-2-thunder.leizhen@huawei.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Zhen,

On 12/01/21 06:06PM, Zhen Lei wrote:
> The __typecheck() requires that the two arguments of max() must be of the
> same type. For the current max(), the type of the first parameter "len" is
> size_t. But the type of size_t is not fixed, it's "unsigned int" on 32-bit
> platforms and "unsigned long" on 64-bit platforms. So both the suffix "U"
> and "UL" are not appropriate for the second constant parameter. Therefore,
> forcible type conversion is used.
> 
> Fixes: 8728a81b8f10 ("spi: Fix distinct pointer types warning for ARCH=mips")
> Fixes: 0920a32cf6f2 ("spi: cadence-quadspi: Wait at least 500 ms for direct reads")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 576610ba11184c6..eb40b8d46b56b0c 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
> 
>  	dma_async_issue_pending(cqspi->rx_chan);
>  	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
> -					 msecs_to_jiffies(max(len, 500U)))) {
> +				 msecs_to_jiffies(max_t(size_t, len, 500)))) {

I sent a patch with this exact fix already [0]. It has made it in Mark's 
for-next branch.

[0] https://lore.kernel.org/linux-spi/20210108181457.30291-1-p.yadav@ti.com/

>  		dmaengine_terminate_sync(cqspi->rx_chan);
>  		dev_err(dev, "DMA wait_for_completion_timeout\n");
>  		ret = -ETIMEDOUT;
> --
> 1.8.3
> 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
