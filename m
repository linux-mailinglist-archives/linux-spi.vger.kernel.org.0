Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5891EBD84
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFBOAf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBOAe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 10:00:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05EC08C5C0;
        Tue,  2 Jun 2020 07:00:33 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id e125so6253185lfd.1;
        Tue, 02 Jun 2020 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQjaC1xCI2dfpZan+5KWwPWqlT4N6CVI5CYUzC/YfCk=;
        b=C4PFWgMMsPkeuD0aU2b1PhywPv60JLQj6vwv2tCKyeUIY1tZXTw5OMfEkd/LCH96I+
         OGE8g+akc8c2SMW0b7t/4Xy6dcLfnuyQHMv8ewbaIFtgRPdBPCOUmH9npw4923JqnvTx
         0U0P2+kEIdVecEJWWDhcEaBSCRdx5FmlmeRzbiy8il1T7SneHE7luSm/y7xeWAdOPNKr
         R0cJYZOAtv8N6dVpJjKaPa9ksqb1AYKzCrbaMe6KIa/QlHihqTR74M1PALGo6BItp2Jn
         69FMfSMaYYZ4NMkRNbGPNedjrYQpzMtNZqRIWFX7cDiV/3NAfbR14DsVyFOxAWLZfqkI
         pLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQjaC1xCI2dfpZan+5KWwPWqlT4N6CVI5CYUzC/YfCk=;
        b=rKUvHjn+o3mIUDFm9SX83H7G1ZQcIjOWCXtvR286tQlt+qf6w4ERJQcm3+mKvi3BMd
         f8+pGtmVWn+2cE13fQeOPULKZQUtBPGvqnzHJnjEmIaOo20jDxVfg2sdHtEnnLJIoqjH
         I/GyxNeNhzQ5m6daLXjE4S+rzKF1ScQEkFeHVXxvMaVzP+7aTVtGTVcCCvLaGheVAuvp
         sqhcopSZDnCm4kGLMNLWn1p7CDSCpmwy8IZ9bvp1K9NVP6lfpgJ4BoIaJdwKocvU3e+B
         MMdH7M/zBHJKlm//jKpPuxXklPTgJOMvorbHsx5fPGr4SfFX+nuasHHfbcL0LRcanK/D
         866A==
X-Gm-Message-State: AOAM531GXOSt/3ekwyru2kB7AQZP3Nwr/r4JlHATb/Wwuta3bFWRgeY3
        OhC6vhNUIXD6AUN7bkd/xgPipPilqGyIP+I8uvBqcgAq
X-Google-Smtp-Source: ABdhPJxSqQO5b8QV8MPWeXmo9RJ1BHb/flfWWjvc5KOiPlHrSepjUdchcC0obnTB3fTVcZDYojmtbijtE0dDR07TdJo=
X-Received: by 2002:ac2:5b9e:: with SMTP id o30mr14041813lfn.153.1591106431562;
 Tue, 02 Jun 2020 07:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602051959.60440-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200602051959.60440-1-navid.emamdoost@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 2 Jun 2020 21:59:45 +0800
Message-ID: <CADBw62qrEutxcaEHg=C-tjVe7vQGwW_7kTVwN-fyohoGnQ903w@mail.gmail.com>
Subject: Re: [PATCH] spi: sprd: call pm_runtime_put if pm_runtime_get_sync fails
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Jun 2, 2020 at 1:20 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> Call to pm_runtime_get_sync increments counter even in case of
> failure leading to incorrect ref count.
> Call pm_runtime_put_noidle if pm_runtime_get_sync fails.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Looks good to me. Thanks
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/spi/spi-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
> index 6678f1cbc566..860032af4b98 100644
> --- a/drivers/spi/spi-sprd.c
> +++ b/drivers/spi/spi-sprd.c
> @@ -1018,6 +1018,7 @@ static int sprd_spi_remove(struct platform_device *pdev)
>         ret = pm_runtime_get_sync(ss->dev);
>         if (ret < 0) {
>                 dev_err(ss->dev, "failed to resume SPI controller\n");
> +               pm_runtime_put_noidle(&pdev->dev);
>                 return ret;
>         }
>
> --
> 2.17.1
>


-- 
Baolin Wang
