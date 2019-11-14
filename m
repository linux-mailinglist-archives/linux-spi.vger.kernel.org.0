Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0BFC084
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2019 08:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfKNHGV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Nov 2019 02:06:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9088 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNHGV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Nov 2019 02:06:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dccfceb0000>; Wed, 13 Nov 2019 23:06:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 23:06:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 23:06:20 -0800
Received: from [10.26.11.169] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 07:06:16 +0000
Subject: Re: [PATCH 8/9] spi: tegra114: Use dma_request_chan() directly for
 channel request
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
 <20191113094256.1108-9-peter.ujfalusi@ti.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4ae959a4-a765-9c3b-4e61-53b7a830709a@nvidia.com>
Date:   Thu, 14 Nov 2019 07:06:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113094256.1108-9-peter.ujfalusi@ti.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573715179; bh=O3S9WaOKKI8E/ud37EWOPglhG3Icsp9xJ8jj8/OQi1E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cb9TCc3Z7tKrnDFsXLJQYsm9tpJ8Z7S6An5gWt1EPn+WMz/lRb5TqUYweDM8CsVAc
         WQWR81o+eDbZDTi+bEAQWKu/PLzmFUfYlR1TS5h+DeOrA3Ni6RZjbONLtRHtkXN9aA
         erJCNYCV7Nj8peQCCUXatzYGKlR5VEuhFaQRb47QfcgaXPHaFGG4qos6ZSJ/LAB3W8
         IvOIDzH+LxOUwLIbApTzcJtwJOfUUEEhoT4x/cdcm9jnfYzKlKC7QblMRwY6Q3RLRF
         SlQ7P76dBSG0g4kMU2Z5hpve9mspAATyMOoJ4CQAfAuxO7PT3Ia0ohTbTXvbqR0lIY
         ShbyGc4bVB9Zg==
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
>  drivers/spi/spi-tegra114.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index e6a450d9b4f0..fc40ab146c86 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -666,8 +666,7 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
>  	dma_addr_t dma_phys;
>  	int ret;
>  
> -	dma_chan = dma_request_slave_channel_reason(tspi->dev,
> -					dma_to_memory ? "rx" : "tx");
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
