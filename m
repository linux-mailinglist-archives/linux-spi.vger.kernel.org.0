Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E49435356
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhJTTC0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 15:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTTC0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 15:02:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80BFC06161C;
        Wed, 20 Oct 2021 12:00:11 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id q189so14139660ybq.1;
        Wed, 20 Oct 2021 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNr9F6JvH0GbbDGqwID6DFFMzTyOKUSN9izQ49lsVLg=;
        b=UR37eV4h50lhfSuqmWD0bz5mh4NK6Rw7V9Kg1lZn5CXxfPCcTon0I7BZx9wkLuIcGo
         5vyeRRz3gcAGZLpxBnZF/K3T1EJ9ur7aOcFSjBr0foGMPrdI6EG8H0wM9lWTxtIl54/U
         O9xM33pL4i8sVTUHJAB7XBQmItfsX7JNRbk+tnCkbJz4v4PBdTFrOlQiNuYw7U3JDHHx
         JHmYWfGJvBGHxBy7AoWXh4rleRlQnj3ZdVS6Tbb6DDDIKX/GToUIGdv2cFVcTOHWettV
         7CXtjXEaeY1TrKQVEWyoVu88NVHWNt6fsWVUmetep/o685iQH3ODjZXF+Dn51HGGPg7C
         EbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNr9F6JvH0GbbDGqwID6DFFMzTyOKUSN9izQ49lsVLg=;
        b=1pFSXLCYzQCuU4V535cDKwMow0NHoW5QZ5BnkHJ+zSiYUPlWBGkx6lhYGMVa8ivGtv
         tjrorhZD+RX+KMJeTBzxJnWyg3x7oQhGaxv+/tAmnZ32+AiY5fS2E8CODhHwT2r5aeQP
         2K7ynUNVEnCTX70V1szNzQRGmHyCjHGtpt8dUvpkaAnX+JGjOs3BfYkkUbZ+lL5fT9LE
         LrI1BjKld98ZPJGW1BdUgzKugUaYNf55pb08ZBCHbT8jpejLqvQBe2qDdppdBAmym9pV
         mHw5vEm0BKqAdolX9u5Znun3BbjyroKMlAS33ssxdG0TdplbvAyADY1dEi4c8BVGMBe4
         cscQ==
X-Gm-Message-State: AOAM532rS7kDYqBiHRCe1ghvEO/U9NJXJtjFNeN2HbfRaEO5d4R9Lkpq
        6NGQn2L8dN6i8x939om5vupHs68Myxw8bkc0/6I=
X-Google-Smtp-Source: ABdhPJxLwG3KXYpAMR7Z/nD1q21KaUOGOzi7O3gOgHkOFe72xfm1MSB1BdsIOHgS/h5jp9TIQZVhoEj35zKMYqaQTyU=
X-Received: by 2002:a25:7415:: with SMTP id p21mr950727ybc.78.1634756410070;
 Wed, 20 Oct 2021 12:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211018073413.2029081-1-yangyingliang@huawei.com>
In-Reply-To: <20211018073413.2029081-1-yangyingliang@huawei.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Wed, 20 Oct 2021 15:00:00 -0400
Message-ID: <CAC=U0a2i5NXdWHYg5TevXZ24ujuLpx0-2631XViXHkBVhZAZzA@mail.gmail.com>
Subject: Re: [PATCH -next] spi: bcm-qspi: Fix missing clk_disable_unprepare()
 on error in bcm_qspi_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 18, 2021 at 3:26 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Fix the missing clk_disable_unprepare() before return
> from bcm_qspi_probe() in the error handling case.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>


> ---
>  drivers/spi/spi-bcm-qspi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> index 6cf7cff5edee..f3de3305d0f5 100644
> --- a/drivers/spi/spi-bcm-qspi.c
> +++ b/drivers/spi/spi-bcm-qspi.c
> @@ -1602,7 +1602,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
>                                                &qspi->dev_ids[val]);
>                         if (ret < 0) {
>                                 dev_err(&pdev->dev, "IRQ %s not found\n", name);
> -                               goto qspi_probe_err;
> +                               goto qspi_unprepare_err;
>                         }
>
>                         qspi->dev_ids[val].dev = qspi;
> @@ -1617,7 +1617,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
>         if (!num_ints) {
>                 dev_err(&pdev->dev, "no IRQs registered, cannot init driver\n");
>                 ret = -EINVAL;
> -               goto qspi_probe_err;
> +               goto qspi_unprepare_err;
>         }
>
>         bcm_qspi_hw_init(qspi);
> @@ -1641,6 +1641,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
>
>  qspi_reg_err:
>         bcm_qspi_hw_uninit(qspi);
> +qspi_unprepare_err:
>         clk_disable_unprepare(qspi->clk);
>  qspi_probe_err:
>         kfree(qspi->dev_ids);
> --
> 2.25.1
>
