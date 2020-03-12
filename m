Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2E182FB4
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 12:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCLL6x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 07:58:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46334 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgCLL6x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 07:58:53 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so5327057iom.13;
        Thu, 12 Mar 2020 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPc++VDXh8pTtJPadUpADozZEFlA9OiPEeVtI98+2V0=;
        b=eyg/wYE1qqMif80Ei6JWFUB7+exwdL5wQwEaAuk6ovH0TfGmz9aFTj1jbHB700ZhBD
         16qksPZCpsWnx/o7u063JgGYhwktoCCvuifWUdm9leIkVlL6hWeQveGVOyuZIEiO3CV8
         jU1PCQ+m9rB8+Wz3trB/8G5YJbiAnWOE5zXj3NcPLJPLeC6u5ox9HjHN4aJzz4VkMB+f
         53Z0u1KlgzaPq8q1kWg/k6VP7qrzemfgHXTLTvE+CRxQx1t0W0Q50C1HDuhvnc85OBdT
         2ggDRANMwETmt6bZVDcRHkLdDdJRq4728+exbpAHGFrk6emoFnfbHVwNChTHhsvpU3vf
         1aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPc++VDXh8pTtJPadUpADozZEFlA9OiPEeVtI98+2V0=;
        b=UsXpnqNkJPI9QKAjYSe+2vMGGmNIgVvYk/jSOxLKn3MwoMLc/tS/R1b2Jw4XcRX3Or
         7fmuagp5b0qIaYYVgRz4uJDeJ6iO2l2bb5EbDa2n+IwZigymT2378YJqbDHqDtsA5o6I
         ONfznVX1xQFBewZPZx5hs0caYkh6mbCUsO4oXLhHlbvkGXwg5iElu8kLiVvKzzexjaDt
         52B8BWgFHMaf503Jceeb53twClo+B4vee1KN+pyyVSfjygPXCDaLF21VorloWM9OY0BS
         o2NXquobxihkxI8xv/mmK+sopPkab4mUUdmflS9DEj90zpZRSOWdFdPkkN+AIe9TPJKv
         8dEg==
X-Gm-Message-State: ANhLgQ1JgGpeoVgs0GVvjRCgSP7pYC+G8YtY2qsE36ETKRNokLQHS/kQ
        c7efOfhxJLR0SeyUWNvacO+L2mkTGV8VbOKHfeI=
X-Google-Smtp-Source: ADFU+vs5s7ScOpNx7hc8xTMV8CjJaZqVFEqIBlNwkoPbuxbjRMc1H3X1CBBKkPsnLLDEx6buNYObDrAAQO10zWdHCpA=
X-Received: by 2002:a6b:ef0f:: with SMTP id k15mr7177031ioh.43.1584014331993;
 Thu, 12 Mar 2020 04:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113154.GC20562@mwanda>
In-Reply-To: <20200312113154.GC20562@mwanda>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 12 Mar 2020 06:58:31 -0500
Message-ID: <CAHCN7xKSc7spZyq=mySWHDmSrGMkQo8FYRbn-NzYRa7iB-0BoQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 12, 2020 at 6:32 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The platform_get_resource_byname() function returns NULL on error, it
> doesn't return error pointers.
>
> Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The commit message for commit d166a73503ef ("spi: fspi: dynamically
> alloc AHB memory") is not very good.  Why is it necessary to allocate
> the AHB memory dynamically instead of during probe?  Also I suspect that
> Adam should have recieved authorship credit for that patch.

It wasn't my patch, I just pulled it in from NXP's repo.  The true
author is Han Xu.  When I pulled in the series from NXP, I found the
flexSPI on the i.MX8MM to become functional, and my company has a
board with a qspi flash on it.

adam

>
>  drivers/spi/spi-nxp-fspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 019f40e2917c..1ccda82da206 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -1019,8 +1019,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>
>         /* find the resources - controller memory mapped space */
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
> -       if (IS_ERR(res)) {
> -               ret = PTR_ERR(res);
> +       if (!res) {
> +               ret = -ENODEV;
>                 goto err_put_ctrl;
>         }
>
> --
> 2.20.1
>
