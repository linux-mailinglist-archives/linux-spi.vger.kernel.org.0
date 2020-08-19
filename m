Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74698249E96
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHSMsj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Aug 2020 08:48:39 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:42452 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgHSMsh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:48:37 -0400
Received: by mail-ej1-f68.google.com with SMTP id g19so26097503ejc.9;
        Wed, 19 Aug 2020 05:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XfTWVsSwjI65UWFf8mFq+y/lWsZWshehQWdU+KFwzuU=;
        b=HKzMBdh+PxyjxnrUOI6ZeqHAslPkTLw8gDc4YiBgR8EIqyzfrX4fbeRGVfz+JNRPx0
         DfT/nBraFeSHPztXPTWiIwSxiemI4l5abcmLOgHGoVvDXGHKHoW0TmP28Zc7cRB6XY5e
         0RhtohupN6lxLEWCgslG/LJ0Os1DTOp6UfN5u2KS5Kt3Pqyj0mjsARXQ6sgYk3nrth0l
         f0E9reNcEWQYg9ob3r9abBRk7C0LQdWYYLeDnZlWSvBuJXdtBVBaBrRCIsHrp3/9Knzz
         g7hMla0MMX82O8kER2jlXE4HN/XCmVccuQwBR/73i8KcSPufQWYWPzGlvKXh6JJrLQre
         ebSw==
X-Gm-Message-State: AOAM533SXQe+NUeAGJCrD16bN7f0IVvhNid67x4w6hXaP+1lGVHzp4+f
        8Ve+R9e3lEgTaACznBX7yT8=
X-Google-Smtp-Source: ABdhPJzZe31W/+8QBDGcHi1xcG1tLh3FVP1X/kz/OeUtmPGjjH2C8BtqdYDfN27v2jUrKeIpCLdHcw==
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr24102300ejx.246.1597841315755;
        Wed, 19 Aug 2020 05:48:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m26sm19793213ejn.92.2020.08.19.05.48.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:48:35 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:48:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 6/8] spi: spi-s3c64xx: Check return values
Message-ID: <20200819124833.GF18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123227eucas1p11ec027714c16d5a66c89c6ef1f7b3604@eucas1p1.samsung.com>
 <20200819123208.12337-7-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-7-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:06PM +0200, Łukasz Stelmach wrote:
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Oh, come on, stop fixing the same local issue without fixing bigger
picture... or at least documenting why bigger picture does not have to be
fixed and simple 'return' is enough.

That's the third, same fix for the same problem.

https://lore.kernel.org/lkml/20190314064202.14864-1-kjlu@umn.edu/
https://lore.kernel.org/lkml/20170207204520.h2eo3yn5kge56lk7@kozik-lap/

Best regards,
Krzysztof

> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 505789f91fdf..27d77600a820 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -273,6 +273,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>  	struct s3c64xx_spi_driver_data *sdd;
>  	struct dma_slave_config config;
>  	struct dma_async_tx_descriptor *desc;
> +	int ret;
>  
>  	memset(&config, 0, sizeof(config));
>  
> @@ -296,11 +297,22 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>  
>  	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>  				       dma->direction, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
> +			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
> +		return;
> +	}
>  
>  	desc->callback = s3c64xx_spi_dmacb;
>  	desc->callback_param = dma;
>  
>  	dma->cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(dma->cookie);
> +	if (ret) {
> +		dev_err(&sdd->pdev->dev, "dmaengine_submit() failed %d", ret);
> +		return;
> +	}
> +
>  	dma_async_issue_pending(dma->ch);
>  }
>  
> -- 
> 2.26.2
> 
