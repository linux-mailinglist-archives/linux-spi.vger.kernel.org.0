Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C65BF516
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 05:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiIUDxd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 23:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiIUDx0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 23:53:26 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EF7CA98
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 20:53:18 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3454b0b1b6dso50177637b3.4
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=stLV5DPlT6+UAI63Lj7LC5z4UPLEtli+2l7Jq5YsPy8=;
        b=em2XymzmfBHR2OOLe4aq+FL3KFtt9ooiMqJrLeeHNz6tR3gUmo1puSer77bMDOYrTj
         PjEePgW9ge+Z/s4DS2tDB3t8CpmmmYNi+UaRjKQro0VrkVvPV6DBoH4K3l1KvSJi3pNs
         eTF1rXivJ5V8nDVQ+HNxZMICa9Os5G2n8UkSPYslF5Lwvinhgy2AlGfbJoBlsGRZjOTu
         n4DAQMxtIv+DLqKFS38B9hsQjui+8qdZEtFVfN/psMJOkTTqJr64XskiN+ZCPFJuJlV7
         9vpn8TQsT8ZgEgLox2L+oFqJNQZ5PRpDdXy1i7G+qb+gsZqbIKBeuxAsyEjOwi60MvP1
         Sg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=stLV5DPlT6+UAI63Lj7LC5z4UPLEtli+2l7Jq5YsPy8=;
        b=B41AfA0OXebj7HoCIvCqG5EKDWzTgh7R0sfp93Qw/5WqsFMZ7ccMEPv7kO+pEaUbWy
         1YEVONvPOWJb7kKLaZCgIqAZMpnhnQNGOwUMfbCuOw+ZvF8PjdNEs6UjKIMOWLITTK1Y
         Mg6OkC/JGNVqgn7aWmbh17lQZz3Cr0KDDtgrcCHs5Bfsuauw/JB4BXWh3UM+7+kGOQq2
         d1X+t33YEduavtwO31ciw+DecrXuh3HrdnJujaSAnYYdnof6YkTcutcnGA2GrRHAL8ZQ
         k95C+e7iNxk/Voc0Cd9l6GdOTJs3h98C/1cHwtP7tHUvvp2DNgB+B7chXz8ngZv7Yyaz
         QIYg==
X-Gm-Message-State: ACrzQf0EU9GXFU9tT3PnmwGSP4xJHN2jw+Y2rttVAg4fihGZnXP/1frV
        s1xO9vlELnlHjEG9tv/8WmPU3xxJIJernXlry6o=
X-Google-Smtp-Source: AMsMyM6TJummNnNb1YJ9JCQ+LuD57iQUh39Vx3QJG4udvhps3LwBACfBcNp52LLTvGYhTeaYNi0MvegF4DQaU3vLOLI=
X-Received: by 2002:a81:5790:0:b0:348:9584:bf4b with SMTP id
 l138-20020a815790000000b003489584bf4bmr22928177ywb.483.1663732397200; Tue, 20
 Sep 2022 20:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220920114448.2681053-1-yangyingliang@huawei.com>
In-Reply-To: <20220920114448.2681053-1-yangyingliang@huawei.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 20 Sep 2022 20:53:05 -0700
Message-ID: <CAMo8BfJ-LE55ELT7SGK6HJU=EyVZ1pYz7bR-66+EH=+6L4sEMw@mail.gmail.com>
Subject: Re: [PATCH -next] spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 20, 2022 at 4:37 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Switch to use devm_spi_alloc_master() to simpify error path.

Typo: simplify.

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/spi/spi-xtensa-xtfpga.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
> index fc2b5eb7d614..2fa7608f94cd 100644
> --- a/drivers/spi/spi-xtensa-xtfpga.c
> +++ b/drivers/spi/spi-xtensa-xtfpga.c
> @@ -83,7 +83,7 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
>         int ret;
>         struct spi_master *master;
>
> -       master = spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
> +       master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
>         if (!master)
>                 return -ENOMEM;
>
> @@ -97,30 +97,24 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
>         xspi->bitbang.chipselect = xtfpga_spi_chipselect;
>         xspi->bitbang.txrx_word[SPI_MODE_0] = xtfpga_spi_txrx_word;
>         xspi->regs = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(xspi->regs)) {
> -               ret = PTR_ERR(xspi->regs);
> -               goto err;
> -       }
> +       if (IS_ERR(xspi->regs))
> +               return PTR_ERR(xspi->regs);
>
>         xtfpga_spi_write32(xspi, XTFPGA_SPI_START, 0);
>         usleep_range(1000, 2000);
>         if (xtfpga_spi_read32(xspi, XTFPGA_SPI_BUSY)) {
>                 dev_err(&pdev->dev, "Device stuck in busy state\n");
> -               ret = -EBUSY;
> -               goto err;
> +               return -EBUSY;
>         }
>
>         ret = spi_bitbang_start(&xspi->bitbang);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "spi_bitbang_start failed\n");
> -               goto err;
> +               return ret;
>         }
>
>         platform_set_drvdata(pdev, master);
>         return 0;
> -err:
> -       spi_master_put(master);
> -       return ret;
>  }
>
>  static int xtfpga_spi_remove(struct platform_device *pdev)

There's a call to spi_master_put in the xtfpga_spi_remove,
IIUC this call must be dropped too.

-- 
Thanks.
-- Max
