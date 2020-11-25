Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257882C405E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 13:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgKYMjk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 07:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKYMjj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 07:39:39 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE2C0613D4;
        Wed, 25 Nov 2020 04:39:39 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i17so2133437ljd.3;
        Wed, 25 Nov 2020 04:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vogu41GvnyEXsb76/iG5vdcVpgljETgqAkmSSwNYHVg=;
        b=H1sMEGYhdc3dNhoq1TM+TBIy1qV1Xhrjp1EOy1EibLKIsRwbgduuihCXNXpmu+r74L
         Jv6UsWKc4Q/APKsCtvHpKPqu1hKaHP28CHJ12YFT7zubb0hfddKKEMBvncGesjpfBRXn
         OyMQqi7MCafVnHJTxBMrm2qcEp98tN6p4vwmQt7IiJUti/Ws9oVFmzM4u6sR9rnytASL
         NFsxSWZK4TrCRl8fNqg7EVXg0HKkPx8IWvKn5WTpk7D/kBod4g1psejvVissu/i+6pQR
         p1aK4Mv5Jvtg1CRXiOLouq8jvmlqv0AG2LI0UijXZ7AATWKFVMmSD1fPP1cPWao2c/rN
         Opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vogu41GvnyEXsb76/iG5vdcVpgljETgqAkmSSwNYHVg=;
        b=a2qY2epl/OmePb3IkOjX+7o9HcHO0kOXsWFh62Heo2BjEno33aMsd9ybcZFc8H6gvw
         62MSCV1b9tRgHFTERrOwuP47GE0DgPpj7Jjz/KquaqowS2ig3ohlcIs6duV8rtsWk6uG
         3mNSyMtHBMO9vDlJRAorv3JyyYiBx0ltun7nxMj3xnwRx/a69GlZwhKQ/YQkXVKPp+tJ
         3TvfPPnPwwBTM2hpwRkIrNwL49gTW18YGSt2JiLtnEeDYcrXcx1heBf5jKkpu1H2Ds2T
         ZsiINwJiWO5Bt25HLkEaZw1et0/2Z1apcPfjCLrmcCKVEbhG3Pt8mnjgpJ6+ts+CKQk1
         BGcQ==
X-Gm-Message-State: AOAM532jSW/3Gvsciau6n+r8y04/i13ClDcMUgUZdJEvOt8rBXB4rVyl
        AMEdEver+S6eX6+kqMrL/4Q=
X-Google-Smtp-Source: ABdhPJySI50PIzXuSSEl4LVMjQ2iwkqW0T4br94Ukj0eXPmCxHgy1SQmWZYtzTsFt5anQw+QMNNeHQ==
X-Received: by 2002:a2e:a408:: with SMTP id p8mr1204776ljn.411.1606307977894;
        Wed, 25 Nov 2020 04:39:37 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id p8sm244854lfk.109.2020.11.25.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:39:37 -0800 (PST)
Date:   Wed, 25 Nov 2020 15:39:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Fix spi registration for controllers overriding
 CS
Message-ID: <20201125123935.akerf6mlgiwdemmm@mobilestation>
References: <20201120213414.339701-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120213414.339701-1-lars.povlsen@microchip.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Lars

On Fri, Nov 20, 2020 at 10:34:14PM +0100, Lars Povlsen wrote:
> When SPI DW memory ops support was introduced, there was a check for
> excluding controllers which supplied their own CS function. Even so,
> the mem_ops pointer is *always* presented to the SPI core.
> 
> This causes the SPI core sanity check in spi_controller_check_ops() to
> refuse registration, since a mem_ops pointer is being supplied without
> an exec_op member function.
> 
> The end result is failure of the SPI DW driver on sparx5 and similar
> platforms.
> 
> The fix in the core SPI DW driver is to avoid presenting the mem_ops
> pointer if the exec_op function is not set.

Thanks for sending the patch fixing the regression.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Fixes: 6423207e57ea (spi: dw: Add memory operations support)
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  drivers/spi/spi-dw-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 2e50cc0a9291..a0794eac2094 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -875,7 +875,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  		master->set_cs = dw_spi_set_cs;
>  	master->transfer_one = dw_spi_transfer_one;
>  	master->handle_err = dw_spi_handle_err;
> -	master->mem_ops = &dws->mem_ops;
> +	if (dws->mem_ops.exec_op)
> +		master->mem_ops = &dws->mem_ops;
>  	master->max_speed_hz = dws->max_freq;
>  	master->dev.of_node = dev->of_node;
>  	master->dev.fwnode = dev->fwnode;
> --
> 2.25.1
