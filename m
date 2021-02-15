Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB931B9E5
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 14:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhBONAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 08:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBONAL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Feb 2021 08:00:11 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB39C061574;
        Mon, 15 Feb 2021 04:59:30 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so3688354plh.12;
        Mon, 15 Feb 2021 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjQm6VWQH7mIte464uPNivedS2oqlvmv6uSqqL0T9lQ=;
        b=o0kZriQEKbi7W+qLmZ2OuESkRKnZHmDUKSrDVQc0Vova5/24Zjcm0LEV/8yirceLm3
         e2PVdEAAVkidj0M/47ojtmWC0mN8xL5rHcd8ic+0E2QCcxL4ooCIyUfqHo9pO5pYG9sq
         kcSgA+zmyE4oArRWp6FRfRsKbhQXDm1mDyTxySJlYL4pF7nSlCqvJDrKaPWYmIncAcRR
         GpI4Cp6RAYY3xkACRZE+qttf7z9x63whfNq4ZAqEh+FYwc4dQlncrQ00y/RXxTuxOX1s
         cXTePQL3gp7rEy8gRw7NEkYLYqiro4+GzVqQ28vNMPCGhxbeTnvxTHh6E+0ZKp5ackrL
         XB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjQm6VWQH7mIte464uPNivedS2oqlvmv6uSqqL0T9lQ=;
        b=U9/GDKRroeSr2QOq+eKwzpFsj78imwXK+JV4OQvDx++pRrPtmJS8pX93N41pL9IZq7
         sTAkgmnmJT8Aglwp3bjgB5mYUb9JwmSgJNx1j+ea34a+xnLvcZT1SB61KEqSIdi5T4U6
         eUtVYBnJD+egDxRBVOEUp+qR8y/53d0Ht7uMoG+0DOIh6+sCrtej5BQJtH3w+3jZQGjj
         S+fvDxowJ6nERZEirVkdI9buajfsN69Oqhh5Q/aGtiySAqY14kxGmDdYLmJsISIrFLjY
         AG5iLjLgJnanUU9tJ/PPOfmrYtt0YhMmtKz95eKb2MaRfF1fQN8RlfArRCUetDqMOg+W
         H0uA==
X-Gm-Message-State: AOAM531ujCAfHZ4cU+kajYQTMXfbu+r7kUEfpTGPQhTHmeSIcw5kbtuo
        UM+vCBV06KGOiWpFZKEmLrQ=
X-Google-Smtp-Source: ABdhPJxdzTgnVN8Hw9Xer6nPDOGeKcD3e8gCd5btKdztZIzNyiwt1IeKobk1N8kWra1X1halDVVwQA==
X-Received: by 2002:a17:902:a581:b029:e3:480a:9779 with SMTP id az1-20020a170902a581b02900e3480a9779mr8532413plb.74.1613393969935;
        Mon, 15 Feb 2021 04:59:29 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id s21sm17540571pga.12.2021.02.15.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:59:29 -0800 (PST)
Date:   Mon, 15 Feb 2021 20:59:27 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org, jan.kiszka@siemens.com,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: pxa2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
Message-ID: <20210215125927.GA618796@nuc8i5>
References: <20210215124429.618582-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215124429.618582-1-zhengdejin5@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Feb 15, 2021 at 08:44:29PM +0800, Dejin Zheng wrote:

Hi All:

I'm very sorry forgot to add change list in patch v2.

v1 -> v2:
	* modify subject name  pca2xx-pci to pxa2xx-pci.
	* add jan and Jarkko's review tag.

Dejin

> Call to 'pci_free_irq_vectors()' are missing both in the error handling
> path of the probe function, and in the remove function. So add them.
> 
> Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
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
> -- 
> 2.25.0
> 
