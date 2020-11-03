Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8ED2A3EC0
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 09:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCIS6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 03:18:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7578 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgKCIS6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 03:18:58 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQN3K2VvszLt2m;
        Tue,  3 Nov 2020 16:18:53 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 16:18:52 +0800
Subject: Re: [PATCH v2] spi: bcm63xx-hsspi: fix missing
 clk_disable_unprepare() on error in bcm63xx_hsspi_resume
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201103074911.195530-1-miaoqinglang@huawei.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <0da24e5e-cf85-7994-4429-15ecc9a7cdf7@huawei.com>
Date:   Tue, 3 Nov 2020 16:18:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201103074911.195530-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



ÔÚ 2020/11/3 15:49, Qinglang Miao Ð´µÀ:
> Fix the missing clk_disable_unprepare() before return
> from bcm63xx_hsspi_resume in the error handling case when
> fails to prepare and enable bs->pll_clk.
> 
> Fixes: 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>   drivers/spi/spi-bcm63xx-hsspi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
> index 9909b18f3..1f08d7553 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -494,8 +494,10 @@ static int bcm63xx_hsspi_resume(struct device *dev)
>   
>   	if (bs->pll_clk) {
>   		ret = clk_prepare_enable(bs->pll_clk);
> -		if (ret)
> +		if (ret) {
> +			clk_disable_unprepare(bs->clk);
>   			return ret;
> +		}
>   	}
>   
>   	spi_master_resume(master);
> 
Hi Mark and Florian,

I made a careless mistake for adding v2 as subject-prefix, this patch is 
the base version actually.

Sorry about that.

Thanks.
