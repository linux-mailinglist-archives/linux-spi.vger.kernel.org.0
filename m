Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E42342C509
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhJMPou (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 11:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhJMPos (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 11:44:48 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE8C061764;
        Wed, 13 Oct 2021 08:42:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so4253110otb.1;
        Wed, 13 Oct 2021 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37hVPOd3BIfvxpW5fFUuBklEo2czP1RmXoKx7X0bcv4=;
        b=Jy5gzAES3gON/iVMPdegqj9JaQV3sbgnGhyzHkKRxU2R6RcDOP4hpvJ62nEH81JBhP
         DLK3ZMeVFdbUBRtwrNO85/FN4x66+MfZLLjWENuYUiM+sV5MEPJlboN2gUTLDArMpIxq
         KCNB62r6K42znXk5MppJnepvkqedLl/lrfIzikyG2J70nwRyW1XNYstnur9BIfpk7WfT
         qiUCZI+FkWxaw3uYfIlM9nD+D6j1QaIAjsNeBy2qadxlbQLYWEqTK6W9zSCeAOb7WK+P
         /gXXwsNeaRQU7VC1qfqQ9cBNNHPEGOhMGZHOZl8zjUgdz1iaYWqwunpcexCWzRVgGdW+
         aAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=37hVPOd3BIfvxpW5fFUuBklEo2czP1RmXoKx7X0bcv4=;
        b=IxyefYZYPMgJd0NsdHcnBHG3+iDAuTUCnIS7WfmS1F3ytGDDzV0u4vWRuaEuwVYytg
         cC+LJnkcJJwgTThWPdV43hjkVR8KmOmGKZ9TbVwj8jLLJbY5y4FVbmBQ5HbDlCIA1686
         0xav/bZN5vEyjQ+C7xYQLbuzm129q6unKAxBaAGOC1QQPT6KI2YP3O3HMdljbd2+yloR
         3Wn48cmge5hGEUuToGLPdyrOqZxa805GZVIpfmvtrq805v+L9bmAOWnpu6a8SfMwxXd4
         xdyAWiFPhs4uIWwmpzZy/X2Yvacqo04ivCfC5epxtG8yL78sMH2OPXQ51xnsRicjTyRW
         poKQ==
X-Gm-Message-State: AOAM5317zg00j34aje+6scEEyHnJHQbSCOvUnkpIgwpkcRH7BRfXwbBP
        vZYK/cfr063+MGUnkyG6DdQ=
X-Google-Smtp-Source: ABdhPJyLua6LzSe9PuJTTcxWZIrYhD4BTtmKXiQnqFeOYdIcgOpJS7+rWZst0dWr4lw08IIH6Mx1pQ==
X-Received: by 2002:a9d:750d:: with SMTP id r13mr31862806otk.264.1634139764172;
        Wed, 13 Oct 2021 08:42:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e28sm3228070oth.40.2021.10.13.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:42:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Oct 2021 08:42:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20: fix build with CONFIG_PM_SLEEP=n
Message-ID: <20211013154241.GA2356944@roeck-us.net>
References: <20211013144538.2346533-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013144538.2346533-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 13, 2021 at 04:45:23PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is another one of these warnings:
> 
> drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
>  1197 | static int tegra_slink_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Give it the same treatment as the other functions in this file.
> 
> Fixes: efafec27c565 ("spi: Fix tegra20 build with CONFIG_PM=n")
> Fixes: 2bab94090b01 ("spi: tegra20-slink: Declare runtime suspend and resume functions conditionally")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/spi/spi-tegra20-slink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index 713292b0c71e..33302f6b42d7 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1194,7 +1194,7 @@ static int __maybe_unused tegra_slink_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tegra_slink_runtime_resume(struct device *dev)
> +static __maybe_unused int tegra_slink_runtime_resume(struct device *dev)

That was actually done in efafec27c565. The error is the result of a bad
conflict resolution against 2bab94090b01, not a result of any of the
two patches listed in the Fixes: tags. So, yes, either this patch needs
to be applied in -next or the conflict resolution needs to be fixed.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
> -- 
> 2.29.2
> 
