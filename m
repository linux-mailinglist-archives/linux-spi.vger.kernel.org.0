Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54CF44F46A
	for <lists+linux-spi@lfdr.de>; Sat, 13 Nov 2021 19:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhKMSJi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Nov 2021 13:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKMSJh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Nov 2021 13:09:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C42CC061766;
        Sat, 13 Nov 2021 10:06:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r4so4066667edy.12;
        Sat, 13 Nov 2021 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLcfdyTHe9NOudKy20oo+4ysh6d9/7hXZc1PwES07Hk=;
        b=HSBrSGn//fOBSw09UqM7fnku+3jc7Q0ypSGWpgVyhc8KMqv+6MK5UfoeAw6a+WgRqp
         +2OWF4dxQ+c7QlLVjXc1PJnwdfJ0nQFGeU6iBqHGuDTK6LJ2OitG1WAUl/JIcuEx8ztb
         9fmaH8qq1CSo2ADbaMvnCTI84YpIZW0HUuKZHrDL8ufZnV6X4nRegyQ18Zx72o3qnVt4
         v9zXZ3g+eQDZ+z84bxjyutgeu4C0lWyaLcfuXvN8PIFES45WK8E6io7VgGTk/B+yRMUv
         r/SQkmgE5Mh9l0UUiOEGy58BoA5A99M+zpEwX3BTY/gmOQxXUH20missjwWBooi7rJRN
         6JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLcfdyTHe9NOudKy20oo+4ysh6d9/7hXZc1PwES07Hk=;
        b=JQHl20N8qJ6XtqTSM3poIC+6LwpwTY/gwFkjVb2dKJ5hHocKso1uU/N3Z2BkG7iDLr
         rSIOqlphewR6PNCTO+Vcr+gJjf/wQYPrjPYreIpLmaQdK67LDXtKwr6PlIJZ075MTQG0
         xR52pJ5BYqdWYvbyFOJrIhJFNvKSdBzkpXyQBLmKLVTSUGVgiv8Dq7XlmVA/S4HpdQIx
         8gJGBBXucA4iY8i+AEwXtuDHUB0j9eyWAEwDcl8yx4dA6SDXU9zFAt6xN5OS8XPSieMG
         YwUUfNsfP/LfFybKZshJ1A5t8VMuJKK+hUsmRx7CbDTVwHSunuFZM+V2aY6VlnQd72k6
         MV3g==
X-Gm-Message-State: AOAM5307nFfRHk6cydc1qJYj1BM84O1DGbmtlAyif5wH2PPbQJV6pcC1
        0OfhH+HVJaZpl597MJFvhHsHuDwqLOE=
X-Google-Smtp-Source: ABdhPJzP+MSc4o6eBId9sHxq5itP8ifkgitYwxfibRql21mpD4ZMKSSeTCyVkZoebb52P6ivf8Vg2Q==
X-Received: by 2002:a17:907:60ca:: with SMTP id hv10mr31361887ejc.500.1636826803608;
        Sat, 13 Nov 2021 10:06:43 -0800 (PST)
Received: from skbuf ([188.25.175.102])
        by smtp.gmail.com with ESMTPSA id z6sm4850453edc.53.2021.11.13.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 10:06:43 -0800 (PST)
Date:   Sat, 13 Nov 2021 20:06:42 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-dspi: use devm_spi_alloc_master()
Message-ID: <20211113180642.7doe6dc5iotw5yez@skbuf>
References: <20211110161754.3312805-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110161754.3312805-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 10, 2021 at 05:17:54PM +0100, Michael Walle wrote:
> Commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
> fixed the use-after-free by manually allocating memory. Nowadays, since
> commit 5e844cc37a5c ("spi: Introduce device-managed SPI controller
> allocation"), there is a devres version of spi_alloc_master() for exactly
> this purpose. Revert the commit which introduced the manual allocation
> and use the new devm_spi_alloc_master().
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Btw, using the devm_ version of spi_controller_register() doesn't seem to

you mean spi_register_controller.

> be a good idea, see commit 8d559a64f00b ("spi: stm32: drop devres version
> of spi_register_master").

And you mention this because? The dspi driver doesn't use
devm_spi_register_controller(). In fact, if it could be made to not use
devres at all, I couldn't be happier. At this stage, the devres wrappers
for SPI are doing more harm than good.

>  drivers/spi/spi-fsl-dspi.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index fd004c9db9dc..29f8a596c8ee 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1227,17 +1227,11 @@ static int dspi_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	bool big_endian;
>  
> -	dspi = devm_kzalloc(&pdev->dev, sizeof(*dspi), GFP_KERNEL);
> -	if (!dspi)
> -		return -ENOMEM;
> -
> -	ctlr = spi_alloc_master(&pdev->dev, 0);
> +	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
>  	if (!ctlr)
>  		return -ENOMEM;
>  
> -	spi_controller_set_devdata(ctlr, dspi);
> -	platform_set_drvdata(pdev, dspi);
> -
> +	dspi = spi_controller_get_devdata(ctlr);
>  	dspi->pdev = pdev;
>  	dspi->ctlr = ctlr;
>  
> @@ -1373,6 +1367,8 @@ static int dspi_probe(struct platform_device *pdev)
>  	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
>  		ctlr->ptp_sts_supported = true;
>  
> +	platform_set_drvdata(pdev, ctlr);
> +

Why do you feel a need to change the drvdata from "dspi" to "ctrl"?

>  	ret = spi_register_controller(ctlr);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "Problem registering DSPI ctlr\n");
> @@ -1396,7 +1392,8 @@ static int dspi_probe(struct platform_device *pdev)
>  
>  static int dspi_remove(struct platform_device *pdev)
>  {
> -	struct fsl_dspi *dspi = platform_get_drvdata(pdev);
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
>  
>  	/* Disconnect from the SPI framework */
>  	spi_unregister_controller(dspi->ctlr);
> -- 
> 2.30.2
> 

