Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84929A88CA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 21:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfIDO2o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 10:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729809AbfIDO2o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Sep 2019 10:28:44 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C1F2341D;
        Wed,  4 Sep 2019 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567607322;
        bh=L76A2ZvdZ49vwh9gPyzYANOjIS9WVsZyi57kx5mf8cQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szOhtdy3pm0hmLpuZGMow2vaeDvOjEj/9NcUKl3Ye865Ae8MB/Tl+Sip/dXvPxb9B
         72hiCdJ/0l/oVbxrbyiOYabDzUdSAJFpf80udg8QExAsVR84ISBvUwLj6bCfquTzob
         rRp/OA3BeXbrfH/12rQnn4/Hm5WjoM800DRgrq64=
Received: by mail-lf1-f49.google.com with SMTP id r134so15222441lff.12;
        Wed, 04 Sep 2019 07:28:42 -0700 (PDT)
X-Gm-Message-State: APjAAAXKsHSWA8QBIvUCi2NhiaW9xiys6xDkf8a0nO3ITrHh+iN4Xd9T
        jvAfLq8FBPhlkyKV666hx0eZp2YqKOel4DQWN5Y=
X-Google-Smtp-Source: APXvYqycXOQpNE+apc0JPS11KQSp+RmtxHn6Ng9LQDVcy4lQi5wxS8ZrsQ1N6swmH4iFFIYS5iVQwDmEz/WmDjOTj6U=
X-Received: by 2002:a19:c649:: with SMTP id w70mr24808672lff.33.1567607320399;
 Wed, 04 Sep 2019 07:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190904135918.25352-1-yuehaibing@huawei.com> <20190904135918.25352-26-yuehaibing@huawei.com>
In-Reply-To: <20190904135918.25352-26-yuehaibing@huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Sep 2019 16:28:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
Message-ID: <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use devm_platform_ioremap_resource()
 to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     broonie@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, eric@anholt.net, wahrenst@gmx.net,
        shc_work@mail.ru, agross@kernel.org, khilman@baylibre.com,
        matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org,
        Andi Shyti <andi@etezian.org>, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 4 Sep 2019 at 16:00, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>

This tag does not look real... First of all where is the report?
Second, it was reported by coccinelle.
Reported-by should be use to give real credits.

Best regards,
Krzysztof

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/spi/spi-s3c24xx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
> index aea8fd9..2d6e37f 100644
> --- a/drivers/spi/spi-s3c24xx.c
> +++ b/drivers/spi/spi-s3c24xx.c
> @@ -487,7 +487,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>         struct s3c2410_spi_info *pdata;
>         struct s3c24xx_spi *hw;
>         struct spi_master *master;
> -       struct resource *res;
>         int err = 0;
>
>         master = spi_alloc_master(&pdev->dev, sizeof(struct s3c24xx_spi));
> @@ -536,8 +535,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>         dev_dbg(hw->dev, "bitbang at %p\n", &hw->bitbang);
>
>         /* find and map our resources */
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       hw->regs = devm_ioremap_resource(&pdev->dev, res);
> +       hw->regs = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(hw->regs)) {
>                 err = PTR_ERR(hw->regs);
>                 goto err_no_pdata;
> --
> 2.7.4
>
>
