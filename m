Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56B24E7FB
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHVOyi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Aug 2020 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgHVOyg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 10:54:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701AC061575
        for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2020 07:54:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w14so3489702eds.0
        for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2020 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mbzm5gpuiwO9tFrWmdPpY3arq5Fa+qKMjnEd29bPLpQ=;
        b=FQkQhG808JI0eCeL5TQ57rNtCCg1AYXnUaZ+z+bIXDm0JphY/3kTObu2x7RD3HTTTE
         J/4DdcSBvZEl3HzlW99RxNL4Ctxtq7j2efM5diD9FiLMYPYVjnlCzbrlPS7Reu+anrxL
         fbO+3Lp90y+V28Qscu0lHKi06nifW+YbDpIJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mbzm5gpuiwO9tFrWmdPpY3arq5Fa+qKMjnEd29bPLpQ=;
        b=V6jK6poVZ7ReVT1oFqsijDuTcdDxqnL6qMrXnU8SRzsrdOVE9LMKV46nVZt+URx5r8
         OGHbaM+By3pYxNaVlN1WZqPZSig9UA6hf0ftuhQI/w59RMESd96WfWkpmhXdN79hSJ8I
         GtHoeVtaPkjmBCTSunjUNcrN17KNXq1a3nj+w0FpmIUL0JGXOFThNyWP538sTCMGRor8
         My3JCb85Qh+qn4KlTOxFb3j99z2Knv3i0OZ2leqfb8++IQcjQBfRaAjRlkuwVRLprJ7O
         LrZzrvXiggTh4a/Byok+qd/5u0LH0P+N22ZGfutP2nnYCNV1fj1mQxgQ19H3gXbh/HoJ
         NWoA==
X-Gm-Message-State: AOAM533PrSaUJhr8BPrR+O9tp73rz6/2jLESuMI7ZDlU0iDiTFuhNMeK
        un7UGIAYU/v2F+gv8IJDGkz0QW4sAgP0cg==
X-Google-Smtp-Source: ABdhPJwtOHzG24ZC7TDsxJ4rp64JkPe+zyII7TIvU05gSA4Dz/cB2ODuUiMc7e997rssxwZpwW8iVw==
X-Received: by 2002:a05:6402:17c2:: with SMTP id s2mr7392288edy.188.1598108074196;
        Sat, 22 Aug 2020 07:54:34 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id p1sm2979965edu.11.2020.08.22.07.54.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 07:54:33 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id r15so4482048wrp.13
        for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2020 07:54:32 -0700 (PDT)
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr7016601wrn.385.1598108072233;
 Sat, 22 Aug 2020 07:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2@eucas1p2.samsung.com>
 <20200821161401.11307-1-l.stelmach@samsung.com> <20200821161401.11307-8-l.stelmach@samsung.com>
In-Reply-To: <20200821161401.11307-8-l.stelmach@samsung.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sat, 22 Aug 2020 16:54:19 +0200
X-Gmail-Original-Message-ID: <CAAFQd5DKCsDOQXcaAqB0h8V8rdo_EcBevgkPO1LzU7FZJ+r_hg@mail.gmail.com>
Message-ID: <CAAFQd5DKCsDOQXcaAqB0h8V8rdo_EcBevgkPO1LzU7FZJ+r_hg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
To:     linux-spi@vger.kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 6:14 PM =C5=81ukasz Stelmach <l.stelmach@samsung.co=
m> wrote:
>
> cur_speed is used to calculate transfer timeout and needs to be
> set to the actual value of (half) the clock speed for precise
> calculations.
>
> Cc: Tomasz Figa <tfiga@chromium.org>

As we talked on IRC, Lukasz forgot to add:

Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>

Would be nice if it could be added when (and if) applying.

> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 02de734b8ab1..89c162efe355 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driv=
er_data *sdd)
>                 ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
>                 if (ret)
>                         return ret;
> +               sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
>         } else {
>                 /* Configure Clock */
>                 val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
> --
> 2.26.2
>
