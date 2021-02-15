Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EEF31B680
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 10:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBOJeh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 04:34:37 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:57140 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhBOJef (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 04:34:35 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 04:34:34 EST
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 11F9Nuvm020273
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 10:23:56 +0100
Received: from [139.22.41.241] ([139.22.41.241])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11F9NtlX003811;
        Mon, 15 Feb 2021 10:23:55 +0100
Subject: Re: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
To:     Dejin Zheng <zhengdejin5@gmail.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        jarkko.nikula@linux.intel.com, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210214145746.602770-1-zhengdejin5@gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d113b6f5-d234-452e-3e82-90c5237eff0e@siemens.com>
Date:   Mon, 15 Feb 2021 10:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210214145746.602770-1-zhengdejin5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14.02.21 15:57, Dejin Zheng wrote:
> Call to 'pci_free_irq_vectors()' are missing both in the error handling
> path of the probe function, and in the remove function. So add them.
> 
> Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/spi/spi-pxa2xx-pci.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index 14fc41ed2361..1ec840e78ff4 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -254,8 +254,10 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
>  	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
>  	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
>  					   c->max_clk_rate);
> -	 if (IS_ERR(ssp->clk))
> -		return PTR_ERR(ssp->clk);
> +	if (IS_ERR(ssp->clk)) {
> +		ret = PTR_ERR(ssp->clk);
> +		goto err_irq;
> +	}
>  
>  	memset(&pi, 0, sizeof(pi));
>  	pi.fwnode = dev->dev.fwnode;
> @@ -268,12 +270,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
>  	pdev = platform_device_register_full(&pi);
>  	if (IS_ERR(pdev)) {
>  		clk_unregister(ssp->clk);
> -		return PTR_ERR(pdev);
> +		ret = PTR_ERR(pdev);
> +		goto err_irq;
>  	}
>  
>  	pci_set_drvdata(dev, pdev);
>  
>  	return 0;
> +err_irq:
> +	pci_free_irq_vectors(dev);
> +	return ret;
>  }
>  
>  static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
> @@ -283,6 +289,7 @@ static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
>  
>  	spi_pdata = dev_get_platdata(&pdev->dev);
>  
> +	pci_free_irq_vectors(dev);
>  	platform_device_unregister(pdev);
>  	clk_unregister(spi_pdata->ssp.clk);
>  }
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks!
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
