Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C72CFD20
	for <lists+linux-spi@lfdr.de>; Sat,  5 Dec 2020 19:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgLESTd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Dec 2020 13:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgLERoD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Dec 2020 12:44:03 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2B6C02B8FD;
        Sat,  5 Dec 2020 08:25:29 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so10176270ljj.6;
        Sat, 05 Dec 2020 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9duhZaGLGup/Gcg7smZusGoOzvqsEs/5CXT1xRoRr8=;
        b=bcZx2skoObx/49S8PQE7YpjkenciUZdo63+1ky8xS01KtpfKH07o5ZYWfpk52c4mIV
         /jncACoGO6ps+0DpMYZKtBMuQKfCtTtwtkmkcOmUT6xAXaEMxDz/DrsK3DY74KFdpcQ7
         bpeqdIkY9W98k0H/LJhaoUuinlXKPTvwcdbMgtgE6x2HWK+xROOQwUA4hYNaBAAOshBW
         +TqOKohLbRRoNLl9ljCsKlvTXB7/VYBNm23DvifQw46is7lSXiOk7B58a6HWTJZtNcqI
         GDlsCOkEUbKCAWJk9MraQH0liCazJoBktI9pOUXfQiU3hzyTqCSavGDnOFXNe1dKTy/1
         AeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9duhZaGLGup/Gcg7smZusGoOzvqsEs/5CXT1xRoRr8=;
        b=AHzRxPkaChg3i4h++J8mEpF+0V95MfiATxrtjc3kSUknxBVWQbGYU7j13aQqaXl1qJ
         RINMCdSKFvaHDtOzsxCM/C4Z8bqT6qql+jwUzzF2PnSRd845KIZVkat/Hz5mP4HiqGZj
         Yrn2WihP5W0zVVWLDRfkwd1WoEe/RkTjo7YsjiekJPtTkQhtddBjMM4bA6smKoSFFtQH
         x3eD4y2eRrF7jE8fyoLLHY7lhlznasHWk5T2DAxMN50J4LJpqK29YDC/5aD9k3wTieIp
         u+1zUe4gZJJhBD/oS1JQtBOYwiswWcUi6gOa+x4IRw7Pxefl3z5N9BnOSzLVlF6SckdG
         5BWA==
X-Gm-Message-State: AOAM531WHmiFvoU78WymO8JSo3ucCw8EpHEyigRhJ9F1NedS3OKp1x33
        T4ilAUNypBZLeQ2v5irnO37FxXwZK6k=
X-Google-Smtp-Source: ABdhPJwZvClhmY7HYHgJ4x98bsfedJ+Ru75ADlNFHKOOteqppE2sTMs7UFz0Mh/WQX/kMI3MmaaQxg==
X-Received: by 2002:a2e:5018:: with SMTP id e24mr1783018ljb.425.1607185528390;
        Sat, 05 Dec 2020 08:25:28 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id y63sm2324381lff.196.2020.12.05.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 08:25:27 -0800 (PST)
Date:   Sat, 5 Dec 2020 19:25:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Fix error return code in dw_spi_bt1_probe()
Message-ID: <20201205162525.5k35z3b4brdnfjxh@mobilestation>
References: <1607071357-33378-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607071357-33378-1-git-send-email-zhangchangzhong@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Zhang

On Fri, Dec 04, 2020 at 04:42:37PM +0800, Zhang Changzhong wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Thanks for the patch. Definitely

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/spi/spi-dw-bt1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index f382dfad..c279b78 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -280,8 +280,10 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
>  	dws->bus_num = pdev->id;
>  	dws->reg_io_width = 4;
>  	dws->max_freq = clk_get_rate(dwsbt1->clk);
> -	if (!dws->max_freq)
> +	if (!dws->max_freq) {
> +		ret = -EINVAL;
>  		goto err_disable_clk;
> +	}
>  
>  	init_func = device_get_match_data(&pdev->dev);
>  	ret = init_func(pdev, dwsbt1);
> -- 
> 2.9.5
> 
