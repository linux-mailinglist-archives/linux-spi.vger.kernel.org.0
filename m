Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC01EF116
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgFEGCp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 02:02:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12532 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEGCp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 02:02:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed9dff90000>; Thu, 04 Jun 2020 23:02:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 23:02:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 23:02:45 -0700
Received: from [10.26.75.201] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 06:02:42 +0000
Subject: Re: [PATCH] spi: tegra20-slink: add missing pm_runtime_put
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <smccaman@umn.edu>
References: <20200602052602.91374-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <555a3d93-ea24-a633-2ea4-904fcd8fd8a2@nvidia.com>
Date:   Fri, 5 Jun 2020 07:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602052602.91374-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591336953; bh=mppFNzTH6LZ5rq9HNWYw/2EXLZTDgKQIdkoIRo40OzY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=erAw05C/uAFBnKnBPShjFQiFW54fajoyweUFrcpn2gwxnEmRgNdUc+VSIuIMvak93
         7gZHxe1opyXZ+dOGJjk0ayQ9o0LPFAEHun9iBmFxdijBkRF2Gw/N5Q8WAR/Bf4SjPS
         yXckO92hQuz5bv/E7rs8Kt7ZQ9n9V+WDUSht7d4pRdtDOuKd0TdB9M8Agdv7XFkZ/A
         SPKBsYyC8SpYXGcP6ek4KANfyXaGzMU4eyRF0PGEkC5aNaCpJqii4SA/VnVaAaAruV
         F3iFCbyoXJshW5qzX4yhsgaLAh098kTJp1WydRYs7XSUa83gSxCrzYYjbPXX02wPi7
         rQPL5Oa+7jXgQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 02/06/2020 06:26, Navid Emamdoost wrote:
> Call to pm_runtime_get_sync increments counter even in case of
> failure leading to incorrect ref count.
> Call pm_runtime_put if pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/spi/spi-tegra20-slink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index 7f4d932dade7..0675b36d647b 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1192,6 +1192,7 @@ static int tegra_slink_resume(struct device *dev)
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "pm runtime failed, e = %d\n", ret);
> +		pm_runtime_put(dev);
>  		return ret;
>  	}
>  	tegra_slink_writel(tspi, tspi->command_reg, SLINK_COMMAND);

Please squash this patch with the other 2 that are fixing the same
issues in the same driver.

Jon

-- 
nvpublic
