Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025663599CD
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDIJtr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhDIJtq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Apr 2021 05:49:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A036C061761
        for <linux-spi@vger.kernel.org>; Fri,  9 Apr 2021 02:49:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u7so677585plr.6
        for <linux-spi@vger.kernel.org>; Fri, 09 Apr 2021 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=78GGtwGvapnO+jnjlzI1npvFGtKC6G2M/8UgM+liQQ4=;
        b=XcPV9uGtP1a8z4GE4ArPC/hRsZO6o7yUALRutQVUYrPPoeZg60xsSS9slESPAYTog9
         Uw4/nL1ztWcdaqeeHbJRaizw0bvdEr3pCK5xz/f8CkKDhK7+mFqIIAaZ/blS56mo7ncP
         tXcaCF++Wr3WaDcyAvkpnRo4LIZPw1TvAzzyNUfT2EOu41V3ncIL9jRyq0uUfeHbR0+G
         CyBKqpz5WulK4sJL1h4oiljLwMB/B4FtzY7VBhMFqP9/R03zS5sT52Oj1RWRPx/mZRXY
         CHHZOiCnO5FQrlFW2Hdta7ikmWLIDm3WZfIt34CxXocYcddoTsc0eZ1pQM7xYu75BWMC
         R+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=78GGtwGvapnO+jnjlzI1npvFGtKC6G2M/8UgM+liQQ4=;
        b=QPbK5shDqGGll3QbjGKzmx3OlAWbx7fHADL+0yq6HXeL/4LgzTrED4L+97lhrW0r/8
         U9F9lQuiZdbfRzYDPdaE6G9Vr4fd0BE8XQdXECv+EJGTKv72XffHO0r1llD2JKRe4+YJ
         8lwmTMEcSTgs5510zMmhf5NmibuqKKAXN5eBK7aQTPMsUDaj4EfhVi9xp8ymrfPKLAm+
         +O7n59TKWr6089vWLXe1r0NlJgrC6/QJttsbw4LxlkQGFDqLcr+wLx+yDAhGR4v2DuXK
         KL9nV6K3/42SaXTimyrgkuISe2xvbUd0zgCrOMqqM0Xxk1PGWJQD5dbYeZsCP+G/U4ih
         rumQ==
X-Gm-Message-State: AOAM531ra3L3A6anv1aFRhA7czGdAKcdxfMAtfbq9ShZqRI1ThZs0i2o
        N7AWQ/2wfY2ZYM8mYehMpNS6
X-Google-Smtp-Source: ABdhPJwrAMnYAY800AYz0bfP2kXwbBNzxp7kxmC5rNiBISaiEbCbWPL1j072AIpnrKEaUkldZWNveg==
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id x23-20020a1709028217b02900e62875b1d9mr11765002pln.70.1617961771079;
        Fri, 09 Apr 2021 02:49:31 -0700 (PDT)
Received: from work ([103.77.37.131])
        by smtp.gmail.com with ESMTPSA id m1sm1890829pjk.24.2021.04.09.02.49.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Apr 2021 02:49:30 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:19:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Wang Li <wangli74@huawei.com>
Cc:     broonie@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] spi: qup: fix PM reference leak in spi_qup_remove()
Message-ID: <20210409094927.GB31856@work>
References: <20210409095458.29921-1-wangli74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409095458.29921-1-wangli74@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 09, 2021 at 09:54:58AM +0000, Wang Li wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Li <wangli74@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/spi/spi-qup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 8dcb2e70735c..d39dec6d1c91 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -1263,7 +1263,7 @@ static int spi_qup_remove(struct platform_device *pdev)
>  	struct spi_qup *controller = spi_master_get_devdata(master);
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(&pdev->dev);
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.17.1
> 
