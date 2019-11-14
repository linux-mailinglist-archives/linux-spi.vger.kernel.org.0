Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220EBFC086
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2019 08:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfKNHGj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Nov 2019 02:06:39 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5961 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNHGj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Nov 2019 02:06:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dccfcc60000>; Wed, 13 Nov 2019 23:05:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 23:06:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 23:06:38 -0800
Received: from [10.26.11.169] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 07:06:34 +0000
Subject: Re: [PATCH 9/9] spi: tegra20-slink: Use dma_request_chan() directly
 for channel request
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <broonie@kernel.org>,
        <radu_nicolae.pirea@upb.ro>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <linus.walleij@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <andi@etezian.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <kgene@kernel.org>,
        <krzk@kernel.org>, <linux-tegra@vger.kernel.org>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-10-peter.ujfalusi@ti.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <45f7645b-0272-cbfa-51ed-0e75844f180d@nvidia.com>
Date:   Thu, 14 Nov 2019 07:06:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113094256.1108-10-peter.ujfalusi@ti.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573715143; bh=IthYYP0v5yyasYpHTwN5FlnHy/Du3BXnlBVhiOd+EC0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ff9Fjmm0AKXSeC1pnL+HyneQlQA2mLiYUk7rrPwx4Q/rBvCFvW63vqG22rMQLxBvP
         HT/rcFOoBLLswFyE+8rxVdBb8BuCHGFH3k3aqFaOtUbn0ruhKj7l4LJ2eLt/2ceYYX
         C+7z/9HBY4JL/IDLZGiyVNaQ9c5OWV/fe55DPvDypxYLoH4qmVL5sbvrJToB744tMg
         fHB4blgBbNPeKbADcUacMSJsC00g1ER5vU67F5lAbt7OcQSfjzM+p/KMnGDTliFXF9
         T44/Uoz+w5Euc0s+gfFHshspjv8S95EVjdFn7rCJXktdMnoO7V8xeqgexbw28u1noZ
         LRdDRGpeKmWUA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 13/11/2019 09:42, Peter Ujfalusi wrote:
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/spi/spi-tegra20-slink.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index 111fffc91435..51573f41ed12 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -599,8 +599,7 @@ static int tegra_slink_init_dma_param(struct tegra_slink_data *tspi,
>  	int ret;
>  	struct dma_slave_config dma_sconfig;
>  
> -	dma_chan = dma_request_slave_channel_reason(tspi->dev,
> -						dma_to_memory ? "rx" : "tx");
> +	dma_chan = dma_request_chan(tspi->dev, dma_to_memory ? "rx" : "tx");
>  	if (IS_ERR(dma_chan)) {
>  		ret = PTR_ERR(dma_chan);
>  		if (ret != -EPROBE_DEFER)
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
