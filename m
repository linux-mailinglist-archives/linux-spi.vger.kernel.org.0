Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08BC1EF138
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 08:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFEGKT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 02:10:19 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17274 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFEGKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 02:10:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed9e1680002>; Thu, 04 Jun 2020 23:08:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 23:10:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 23:10:19 -0700
Received: from [10.26.75.201] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 06:10:16 +0000
Subject: Re: [PATCH] spi: tegra20-sflash: call pm_runtime_put in case of
 pm_runtime_get failure
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <smccaman@umn.edu>
References: <20200602044049.17378-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9fffd3eb-3e96-7abd-b5ff-9cf01f4f4ef7@nvidia.com>
Date:   Fri, 5 Jun 2020 07:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602044049.17378-1-navid.emamdoost@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591337320; bh=EKFZ7Q61dWsOII8i+yLowyby25pEgFm/0n03Sh7qxzs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=liTuqd65mcSB9xFZz1dJY9qdgpXLpjb+AQ5kKXKSePQPnEKysXbmKDb7k0MPleGza
         F5IyltbqvV82LFHZjv/aQrEzUmYPletOuWdPwddLz9d2MbohAaWhLJLtR+paNi1ift
         Ay/jCEymGDk7w8ONWA8F4HJiPzdt6A35NlPMkrDWYDZWLFSX2cr+aS+sOTNKmnWti/
         7Z1j/UbPJ65e0RcViUhFpkYEyzm/v4XRdj/nni9GjoT7kP8P5+0OQdhW32cdXEwzfa
         qsCRlyTWuTlR4mpSKF/3iXclSoiBePSeNQ0bx3baxkZb5gLDcmixB34J6u44Oq2zBy
         qjEaKT+tg5QPA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 02/06/2020 05:40, Navid Emamdoost wrote:
> The counter is incremented via pm_runtime_get even in failure case.
> To correct the counter call pm_runtime_put in case of failure, too.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/spi/spi-tegra20-sflash.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
> index 514429379206..33c34f9c2021 100644
> --- a/drivers/spi/spi-tegra20-sflash.c
> +++ b/drivers/spi/spi-tegra20-sflash.c
> @@ -552,6 +552,7 @@ static int tegra_sflash_resume(struct device *dev)
>  
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
> +		pm_runtime_put(dev);
>  		dev_err(dev, "pm runtime failed, e = %d\n", ret);
>  		return ret;
>  	}

There is another instance of this in this driver that needs fixing.

Jon

-- 
nvpublic
