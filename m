Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8641C1EF133
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 08:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgFEGJL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 02:09:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12904 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgFEGJK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 02:09:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed9e1790001>; Thu, 04 Jun 2020 23:08:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 23:09:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jun 2020 23:09:09 -0700
Received: from [10.26.75.201] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 06:09:06 +0000
Subject: Re: [PATCH] spi: tegra114: missing put on pm_runtime_get_sync failure
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <mccamant@cs.umn.edu>
References: <20200602045506.40574-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f928fb02-47d7-b6f9-6198-bd549d6ac6b5@nvidia.com>
Date:   Fri, 5 Jun 2020 07:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602045506.40574-1-navid.emamdoost@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591337337; bh=Fs5owMcBXZxBEaKBbscTgxeCUWoaivJ3Phc/NIsnyRA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pT7K+wZxTxAM/7Fb/3IhfkqXAJjNb8HdOJ8Fo2q+92NqX/+HJ09awi4kcZJvoCcup
         7W8bIKNxyWNXUa59jz+N2/L746R7Acm1dva9z6HdRYG8TEpiH6AhCN2k6YpQGiz4UJ
         7hlv0uO4OTkx3lINoHLtJdgRp63wRkxr8/km/em+Zm7VkMSTXLN97oRXZcJMI8BriF
         6BTHlzUwl3gGgB15bsJ5KwIRwGZJRy8mK4DV2hHFVG9+hqK324dzqpjLjbiZKAST6n
         jRVIbHYRGmQeuIPFwnsVuLCHBteUUveQFwsJZFtZeR/oaDu1PtLQ+YRl0Tp8brpRUR
         U0s+MaSlg7Tbg==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 02/06/2020 05:55, Navid Emamdoost wrote:
> the call to pm_runtime_get_sync increments the counter even 
> in case of failure leading to incorrect ref count.
> Call pm_runtime_put if pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/spi/spi-tegra114.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index 83edabdb41ad..dccd2ac1a975 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -974,6 +974,7 @@ static int tegra_spi_setup(struct spi_device *spi)
>  		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
>  		if (cdata)
>  			tegra_spi_cleanup(spi);
> +		pm_runtime_put(tspi->dev);
>  		return ret;
>  	}
>  
> @@ -1398,6 +1399,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
>  	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
> +		pm_runtime_put(&pdev->dev);
>  		goto exit_pm_disable;
>  	}

I am wondering if it is better we use put_sync() here to ensure that
this happens before we exit the probe.

Jon

-- 
nvpublic
