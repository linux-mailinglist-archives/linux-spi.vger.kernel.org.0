Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84415460B66
	for <lists+linux-spi@lfdr.de>; Mon, 29 Nov 2021 01:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376286AbhK2AJP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Nov 2021 19:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376338AbhK2AHP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Nov 2021 19:07:15 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95BC0613F3
        for <linux-spi@vger.kernel.org>; Sun, 28 Nov 2021 16:02:25 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id w23so30373200uao.5
        for <linux-spi@vger.kernel.org>; Sun, 28 Nov 2021 16:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cihXymsmUHJPK/TpycI3whj34mwZgsGQNeETMeNkJkk=;
        b=A+6uTg6zy+dwEI5PlIIpWiF2rMrmbofCwCiqCH/7CP/80MhgTVENmzWcvh4Diqj+Ie
         /2ubJqhwm1368bdKEm9reQWqTZU5Vy06xQvQ93JT/xW3m4+aB5PKn2U5pCNfyaic4h3R
         8erLzb9MCcpeEq+A6TBsKEdrGmUoFE+5L2v9mlTYbT43XHw5Dfi0ZuTjJ12YGmbTCfTf
         NLKjiWH6UDOlwieUTnpPVrkFDtGiC2BybQXegG0QVXH6CUUEE37EzEXH4LsN2s0/4i5s
         ut3QilvvGkj8xv6cIGWHXvraMX0CitgLXjfnYgWOmODMsV/5vGoqgrpfeB3gJ/6jiXSV
         kZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cihXymsmUHJPK/TpycI3whj34mwZgsGQNeETMeNkJkk=;
        b=1yWA7Ky+//Xe2TzFTGaszYDch8UhUA40piM4BL5aEXJc1iNih7yYzpn+6UVbzmcSrc
         LggfQSrT4hAffDVoTW7Y5TLN/axBUDnnMJUTWzNH76tntULWwwZgLZdaOBBHsPI9WWvk
         eiMQ800lU25LLrIV844AC/3Biu9hP4F+MHIwWBPuwkJ7YQq2Pmv4YG+zppQQOUvhPtSj
         MLUGhzlBt9eOgmrQ2YZVTqdqItAY4jkIq+gU5bpdr4nmI6bEy/na9ZM/aBMfwRIC/1nf
         UGskRWjTp7AKNovK5f0jjucoOaW3qRpeI+B8FGIooU5qb4fTlLUYCE8HKoeF81X95k24
         HNaQ==
X-Gm-Message-State: AOAM531UKGuw/CnumTK/lr+zYrAOkGHKIuRCUugmDNlVIlbbB0D1l1TQ
        Qq3zjpFCpkY2L08rOK5kaatsXyfh40rToGRoOxsIUw==
X-Google-Smtp-Source: ABdhPJzTha2H8BfgE7HV7+donkkXjIIjVJN8XihiGCGrL8G93mKkssc06T4yjvwHNsvW874Lx0jSDZPZN8X+FZeb+5A=
X-Received: by 2002:a05:6102:f10:: with SMTP id v16mr30028063vss.86.1638144144481;
 Sun, 28 Nov 2021 16:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20211127223253.19098-1-semen.protsenko@linaro.org> <20211127223253.19098-9-semen.protsenko@linaro.org>
In-Reply-To: <20211127223253.19098-9-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 29 Nov 2021 02:02:13 +0200
Message-ID: <CAPLW+4mrxLrjr3B+DrCQP_2B-+sqH3A_P=NP9he22c_MmnFLpg@mail.gmail.com>
Subject: Re: [PATCH 8/8] spi: Make SPI_S3C64XX=y impossible when EXYNOS_USI_V2=m
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 28 Nov 2021 at 00:33, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> When S3C64XX SPI is encapsulated in USIv2 block (e.g. in Exynos850),
> USIv2 driver must be loaded first, as it's preparing USI hardware for
> particular protocol use. Make it impossible for spi-s3c64xx driver to be
> built-in when USIv2 driver is built as a module, to prevent incorrect
> booting order for those drivers.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

This patch is not needed, please ignore it.

>  drivers/spi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index b2a8821971e1..fbdf901248be 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -761,6 +761,7 @@ config SPI_S3C24XX_FIQ
>  config SPI_S3C64XX
>         tristate "Samsung S3C64XX/Exynos SoC series type SPI"
>         depends on (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST)
> +       depends on EXYNOS_USI_V2 || !EXYNOS_USI_V2
>         help
>           SPI driver for Samsung S3C64XX, S5Pv210 and Exynos SoCs.
>           Choose Y/M here only if you build for such Samsung SoC.
> --
> 2.30.2
>
