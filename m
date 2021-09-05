Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A4401086
	for <lists+linux-spi@lfdr.de>; Sun,  5 Sep 2021 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhIEPU1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 Sep 2021 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhIEPU1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 5 Sep 2021 11:20:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD581C061575;
        Sun,  5 Sep 2021 08:19:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l18so6795524lji.12;
        Sun, 05 Sep 2021 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4q769ttMr72WDXmPnXR8+wSwY2ZYZkFr5o8TURYWeMk=;
        b=jDPHkoG2sZv1ra0Hfdz7nuwbfLrrVlNSSeoqLTGAHfFtQelH5sDkS8NnZVUrqM2oAZ
         a0kAPAsSfMDOFYcL+X3RCmiDQbmy18aysZEVvdyuiAJSBYSENsAe33i/LX3oR6g+kRkg
         9YxrMY6Ju/B+RY6Jz1UdGz2nwLFuOHheCa2uc2e0RE2q4ReWaNHYd+I1HqIY9IV3Al57
         UmsZC6PEbvCZj43sjnKDMcu15M9y7QNOTdvbqpg5MCyJEf5P3lJDQ8bPyMDbnmmO26/X
         wcvlfUDKfaKTc/Przd+flwPjF/z6NB6cEEEBS1P8qw1XB1fiX/HSohmaNkRDh5gjTrbS
         GXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4q769ttMr72WDXmPnXR8+wSwY2ZYZkFr5o8TURYWeMk=;
        b=k3uKiyg9f1H19POY6f1p/VfAsfV0bUl9LC1mseQ0IpVAGPF9dd6sXLCpjPGZdMN624
         /evDEhwZo64eF05uBBbv5dTJXH+3zJITL/8VIX+1fPI/zB599OK3D0VeLuYbOfHjQk1g
         ZJhmU22zSmIXn0YrRW4rOJdjkrmgJqeJXPxv6BVA2y7iZCPRgdKPyckcVSnjkD1dHXt3
         MBOjl23zm8yTlc5qrrh1uDboR35js36k/FpObQREUu/uC2jINaGlIha+j0lBHvwEbfWS
         W0Hf9Zd7UsxWSam/zV3wbtZQ5TvarBOcEmy8Dgxb7Ucv6qnJMKY2DmkWOxevzoeD4c7P
         919g==
X-Gm-Message-State: AOAM531KCX0nuyxq/nIy6LZsWFaYtN+OXpGdnk/+BEOd5lPSXdZl7chm
        h3LRwRYjH72RTfP040SRJ1s=
X-Google-Smtp-Source: ABdhPJx0zFAmBYZmPFGcyEGHSPJuJaTYTT/7Py8bqorlNEraTIeptEr1EyxWjszRfsWNijA9eJGQIA==
X-Received: by 2002:a05:651c:1190:: with SMTP id w16mr7015249ljo.327.1630855161981;
        Sun, 05 Sep 2021 08:19:21 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id c19sm680045ljn.75.2021.09.05.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 08:19:21 -0700 (PDT)
Date:   Sun, 5 Sep 2021 18:19:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     mahesh.r.vaidya@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v1] spi: dw: Enable Autosuspend delay for SPI DesignWare
Message-ID: <20210905151919.znaftqnzsuqd4n5f@mobilestation>
References: <20210903212758.22038-1-mahesh.r.vaidya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903212758.22038-1-mahesh.r.vaidya@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Sep 04, 2021 at 05:27:58AM +0800, mahesh.r.vaidya@intel.com wrote:
> From: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
> 
> Enable and set Autosuspend delay for SPI DesignWare driver.
> The number 1000 ms for the autosuspend delay was picked a bit
> arbitrarily, so if someone has measurements showing a better
> value we could easily change this.
> 
> Signed-off-by: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 3379720cfcb8..8b588ce9c16b 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -33,6 +33,8 @@ struct dw_spi_mmio {
>  	struct reset_control *rstc;
>  };
> 
> +#define SPI_DW_DEFAULT_AUTOSUSP_VAL		1000
> +
>  #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
>  #define OCELOT_IF_SI_OWNER_OFFSET		4
>  #define JAGUAR2_IF_SI_OWNER_OFFSET		6
> @@ -309,6 +311,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  			goto out;
>  	}
> 

> +	/* Set initial autosuspend default delay value and enable */
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_DW_DEFAULT_AUTOSUSP_VAL);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);

Seems reasonable, but doesn't it need to be reverted in the remove
callback? Like it's done in the spi-imx.c driver for instance by
calling the pm_runtime_dont_use_autosuspend() method.

>  	pm_runtime_enable(&pdev->dev);
> 
>  	ret = dw_spi_add_host(&pdev->dev, dws);
> @@ -319,6 +325,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  	return 0;
> 
>  out:

> +	pm_runtime_put_noidle(&pdev->dev);

This doesn't seem like related to the subject, thus needs to be
submitted as a separate patch with fixes tag if it fixes some another
problem. Additionally it isn't balanced with the pm_runtime_get*()
method invocation. Am I missing something?

-Sergey

>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(dwsmmio->pclk);
>  out_clk:
> --
> 2.17.1
> 
