Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576DB2C3FAB
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgKYMOy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 07:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYMOy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 07:14:54 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A5C0613D4;
        Wed, 25 Nov 2020 04:14:53 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i17so2057915ljd.3;
        Wed, 25 Nov 2020 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gc4qMJXhyMRQIhW7uEhJjTGAKZr58S2+Yff/bL5CKfw=;
        b=aQKjaBEpeAeb6ZLZ17pm9DV8Yu0vy67SxJ+5DD1ssG9wouS3ZRkXMX3EpDGWBHQADp
         pJNr2c7o2gTNKwfG+3a4PliR36t49LMWvq1PTsmUMU4zVmumc4nGxnBes50fCH6ItjFm
         1nDsqevMKyyaZ1ms5f2beyvnZr8SsltvkDte21eB2VPvEq+dr9PqrCmUWQk87Ril29Aq
         n59xXxhH26E5j+m4w8EGnYWQS3tY4NlJYLceABykfG17vWKLSXAomeHu34FrKT2jVZXO
         QraytfXvW5a5UxpbQvjLlJAI3vVG7C9tBX/KYZT5OhkHcJ5xvb7ThkeLx807WlCBwojx
         2zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gc4qMJXhyMRQIhW7uEhJjTGAKZr58S2+Yff/bL5CKfw=;
        b=W3ca2JaiOZmHRsn8nSZjLPfeUesUFyQ12x02BVRIu53hGfmJbtycCICxIF+c4Q20IK
         zbnpOzj49NjK75kmSov12dX2U8fQMXEn6NRzOJyfpPR9hJHAW+0rCn0alBOUTnUu1Fju
         l4avD1PXm/tc898JOYzK1/i3sPDKhmaljw3RVBh3hIW7mOKSE5jNmMGmkiRD4kFoLN78
         cGoc0SLnXg8pOtAA4c3B/Get3BRYVJTW7On9589l0RH0Z+OEMHdfZlk4Kj7h09HV1pjY
         tp1u8C6KpLOfs0EKAwdzEDyt4prRtUUULsDppdoirCJkZAO2O126UCXrIZzUqomndrRx
         9gsw==
X-Gm-Message-State: AOAM5331WryQXSuzZMr4BZJ4cl4qlNviS3LTWzRW6LjlPqmkut06jWl3
        Jo33TCnESzcX1RjV3mWJ6KaNf4sBm9Q=
X-Google-Smtp-Source: ABdhPJxfIWnpCCWCpWtrUH6h++e+Sk8TU4Cd/XwdW8ZZ04C0PJQKGJ+oe+/Y18R2BWeP9ZTxK0ZblA==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr1213755ljc.175.1606306492472;
        Wed, 25 Nov 2020 04:14:52 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id w3sm224227ljm.37.2020.11.25.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:14:51 -0800 (PST)
Date:   Wed, 25 Nov 2020 15:14:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: fixed missing resource_size
Message-ID: <20201125121449.zo2njliv4typz4ca@mobilestation>
References: <1606114975-31362-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606114975-31362-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 23, 2020 at 03:02:55PM +0800, Tian Tao wrote:
> fixed the coccicheck:
> drivers/spi/spi-dw-bt1.c:220:27-30: ERROR: Missing
> resource_size with mem.

Thanks, Tian!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/spi/spi-dw-bt1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index f382dfad..da4f4d8 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -217,7 +217,7 @@ static int dw_spi_bt1_sys_init(struct platform_device *pdev,
>  	if (mem) {
>  		dwsbt1->map = devm_ioremap_resource(&pdev->dev, mem);
>  		if (!IS_ERR(dwsbt1->map)) {
> -			dwsbt1->map_len = (mem->end - mem->start + 1);
> +			dwsbt1->map_len = resource_size(mem);
>  			dws->mem_ops.dirmap_create = dw_spi_bt1_dirmap_create;
>  			dws->mem_ops.dirmap_read = dw_spi_bt1_dirmap_read;
>  		} else {
> -- 
> 2.7.4
> 
