Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53420278424
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgIYJgU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbgIYJgU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 05:36:20 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4285C0613CE
        for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2020 02:36:19 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j3so1034750vsm.0
        for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2020 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CopwlfwvxR6TDA4NEpPReJrXwzQ2YdaVXCfZyj+KeI8=;
        b=gQDqhM1EBxhhdAdupXGC+mi8HP42zIBAb+/5WouwU0pwYgc43PjnSIDyqhNXoJBgwE
         nA9S7PMscej5cgQCrvf55Dp29QyMHvwUDUtmdsjDRjaEHcRFBhd7dmLwMWl9mvoH7sp/
         4lRasNIvYZAFCtIP9ZaogcqOJXzEYU/4iYpzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CopwlfwvxR6TDA4NEpPReJrXwzQ2YdaVXCfZyj+KeI8=;
        b=kL8MtWTA28j/2hZz5mQ3vyspx+FeBlSk/VYoyjX/KZa7eWbCfyOGYPbmTRKKLK6/9v
         QwP5G8JF2jTWrfGbr2k+N1Ns7lIRxk7PRga10yc8bTOlbUHBdPWD9dLOzy3secoaG/1j
         VP/RElSYKomvf6zLX6dKCK+54Aoq7r4EfTpGbIksxOMyOE2IuffeSv+T+YMBLry9HAeB
         r4Ijd9TuVYgCgHtrcY5yxn2Vm+RnFHG9oaUzpzvncC4RMpkssTC3jnTocm8YeCZto8d5
         seAqy9/Rp9D68tn0ph4JbWrYDghOkIuNV3TJj7X/uYc0CUUNKJwvwfJ1hc76QeBBrKm6
         GA3g==
X-Gm-Message-State: AOAM532PjCpVkQ36CaE2FkA4BDGzSGUz6Foaa2SitB1u/JQD3O2JO6wB
        2nvR5xUeJibX1W0QRNWCC5v916m7JgKdkW03/TLHOA==
X-Google-Smtp-Source: ABdhPJxdJedhGCUBzFfJjDuMt5UWKrHFjl71MnBQbIp5LNRnu+DHrChmvGin2RNOLR4c+TakRNBVwDRVvnRZRQt2lqc=
X-Received: by 2002:a67:b917:: with SMTP id q23mr2061999vsn.37.1601026578879;
 Fri, 25 Sep 2020 02:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.2.I48d59ef5398f3633c6ebbab093da6b4b06495780@changeid>
In-Reply-To: <20200925145255.v3.2.I48d59ef5398f3633c6ebbab093da6b4b06495780@changeid>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 25 Sep 2020 17:36:08 +0800
Message-ID: <CAATdQgB4Z2msO_RuOuVMLaXYrR7WnGsSQbjOWMTFWT7PCjH+PA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] spi: spi-mtk-nor: fix mishandled logics in
 checking SPI memory operation
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 25, 2020 at 2:54 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Fix a bug which limits its protocol availability in supports_op().
>
> Fixes: a59b2c7c56bf ("spi: spi-mtk-nor: support standard spi properties")
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---

This is also duplicated work of https://patchwork.kernel.org/patch/11797723/,
I'm going to drop this patch in v4.

>
> (no changes since v1)
>
>  drivers/spi/spi-mtk-nor.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index 6e6ca2b8e6c8..0f7d4ec68730 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -211,28 +211,24 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
>         if (op->cmd.buswidth != 1)
>                 return false;
>
> +       if (!spi_mem_default_supports_op(mem, op))
> +               return false;
> +
>         if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
> -               switch(op->data.dir) {
> -               case SPI_MEM_DATA_IN:
> -                       if (!mtk_nor_match_read(op))
> -                               return false;
> -                       break;
> -               case SPI_MEM_DATA_OUT:
> -                       if ((op->addr.buswidth != 1) ||
> -                           (op->dummy.nbytes != 0) ||
> -                           (op->data.buswidth != 1))
> -                               return false;
> -                       break;
> -               default:
> -                       break;
> -               }
> +               if ((op->data.dir == SPI_MEM_DATA_IN) && mtk_nor_match_read(op))
> +                       return true;
> +               else if (op->data.dir == SPI_MEM_DATA_OUT)
> +                       return (op->addr.buswidth == 1) &&
> +                              (op->dummy.nbytes == 0) &&
> +                              (op->data.buswidth == 1);
>         }
> +
>         len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
>         if ((len > MTK_NOR_PRG_MAX_SIZE) ||
>             ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
>                 return false;
>
> -       return spi_mem_default_supports_op(mem, op);
> +       return true;
>  }
>
>  static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
> --
> 2.28.0.681.g6f77f65b4e-goog
>
