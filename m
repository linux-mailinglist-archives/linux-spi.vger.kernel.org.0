Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF32B3FAF
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 10:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKPJYk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 04:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgKPJYj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 04:24:39 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C2C0613D1
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 01:24:39 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so3030974pfb.9
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 01:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+yksa/L/+O/IgdR91ydcBfWFIPXBuS75+yDTd5UP+s=;
        b=gXltbHYZFSKk18EC26Ru7n9PknIiEOdJ2O+cT/vCIPlOHUCfJqi9YdOqw7xsvSNoBg
         MVzBkiImO+1jrabMHyeelgBpZjgoxB68Jzf8D6yRLpUwFtwof81LxHJBtIohMEyf9EC2
         YW6iKO56lePLu4l1zmeBAtINBrLJzg5odeOXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+yksa/L/+O/IgdR91ydcBfWFIPXBuS75+yDTd5UP+s=;
        b=JmhxDcbKjzoHufBIAn+6x1BNIxpUFmtFBvTp5lMO/1UE+TVq52lOa0HAUcSk5SDoTh
         wzB1afFA/osfauy8vfbhR5SZojJsiuIR2Q8gA89C058d0Jx1+m+7pDYnfffKyn82rn25
         5dGBI74TUiVwYxNB92kIVLhqCfy0ChZOxh+iqoU0uGl55Av1zQFef9pzT5GFtLZF2z1p
         wjEJp/jIiR4X3JQqLmMkOUOhJU5RMB1XB+wZXwPrnbafkhvvc9/Ub/tUaHnXwJjRPoeA
         6GOl1EGYWKmvyhx8ymCxH3R0DV2H5Ghpyna/kRQsTHKCRecrRbSdjpks5cwSxVqTUe4I
         8cSA==
X-Gm-Message-State: AOAM532guROrlFweczD9e3mwW+NU6CM23mU7nOdhY0dVku0EWxDYIEt7
        U/IdkXUnnPWTTZeFq2ZIKDf/woHf+I8xCGKo+sbWrw==
X-Google-Smtp-Source: ABdhPJxnG8c6YKbLRbp3hBZ10giLjivBjhq+YC6gIMq+1Ad5c5KvK5LrvLXI/LpkaZc2VBbaRYxZE9YglNEVs/M6lNY=
X-Received: by 2002:a65:4905:: with SMTP id p5mr11516053pgs.299.1605518678986;
 Mon, 16 Nov 2020 01:24:38 -0800 (PST)
MIME-Version: 1.0
References: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com> <1605084902-13151-2-git-send-email-bayi.cheng@mediatek.com>
In-Reply-To: <1605084902-13151-2-git-send-email-bayi.cheng@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 16 Nov 2020 17:24:28 +0800
Message-ID: <CAATdQgCk6cmD35AQ_pHvotA+Mh8tEiYnHkQVzr5L7ZrpU18z1Q@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: add axi clock control for MT8192 spi-nor
To:     Bayi Cheng <bayi.cheng@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 11, 2020 at 4:55 PM Bayi Cheng <bayi.cheng@mediatek.com> wrote:
>
> From: bayi cheng <bayi.cheng@mediatek.com>
>
> MT8192 spi-nor is an independent sub system, we need extra control axi
> bus clock for it. Add support for the additional axi clock to allow it
> to be configured appropriately.
>
> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>

Tested-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/spi/spi-mtk-nor.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index b97f26a..bf2d0f9 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -103,6 +103,7 @@ struct mtk_nor {
>         dma_addr_t buffer_dma;
>         struct clk *spi_clk;
>         struct clk *ctlr_clk;
> +       struct clk *axi_clk;
>         unsigned int spi_freq;
>         bool wbuf_en;
>         bool has_irq;
> @@ -672,6 +673,7 @@ static void mtk_nor_disable_clk(struct mtk_nor *sp)
>  {
>         clk_disable_unprepare(sp->spi_clk);
>         clk_disable_unprepare(sp->ctlr_clk);
> +       clk_disable_unprepare(sp->axi_clk);
>  }
>
>  static int mtk_nor_enable_clk(struct mtk_nor *sp)
> @@ -688,6 +690,13 @@ static int mtk_nor_enable_clk(struct mtk_nor *sp)
>                 return ret;
>         }
>
> +       ret = clk_prepare_enable(sp->axi_clk);
> +       if (ret) {
> +               clk_disable_unprepare(sp->spi_clk);
> +               clk_disable_unprepare(sp->ctlr_clk);
> +               return ret;
> +       }
> +
>         return 0;
>  }
>
> @@ -746,7 +755,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
>         struct spi_controller *ctlr;
>         struct mtk_nor *sp;
>         void __iomem *base;
> -       struct clk *spi_clk, *ctlr_clk;
> +       struct clk *spi_clk, *ctlr_clk, *axi_clk;
>         int ret, irq;
>         unsigned long dma_bits;
>
> @@ -762,6 +771,10 @@ static int mtk_nor_probe(struct platform_device *pdev)
>         if (IS_ERR(ctlr_clk))
>                 return PTR_ERR(ctlr_clk);
>
> +       axi_clk = devm_clk_get_optional(&pdev->dev, "axi");
> +       if (IS_ERR(axi_clk))
> +               return PTR_ERR(axi_clk);
> +
>         dma_bits = (unsigned long)of_device_get_match_data(&pdev->dev);
>         if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(dma_bits))) {
>                 dev_err(&pdev->dev, "failed to set dma mask(%lu)\n", dma_bits);
> @@ -794,6 +807,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
>         sp->dev = &pdev->dev;
>         sp->spi_clk = spi_clk;
>         sp->ctlr_clk = ctlr_clk;
> +       sp->axi_clk = axi_clk;
>         sp->high_dma = (dma_bits > 32);
>         sp->buffer = dmam_alloc_coherent(&pdev->dev,
>                                 MTK_NOR_BOUNCE_BUF_SIZE + MTK_NOR_DMA_ALIGN,
> --
> 1.9.1
>
