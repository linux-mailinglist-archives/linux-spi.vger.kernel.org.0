Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A953C2782B9
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgIYI1L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYI1L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 04:27:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F8EC0613CE;
        Fri, 25 Sep 2020 01:27:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l16so1528747ilt.13;
        Fri, 25 Sep 2020 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrY0n+Lxp4Ps0vKWrqg8qzPispapVC5K8BCl7226S1Y=;
        b=T0fhmfBTGttasq8Kei96OjnUWqoXnD1EhQm31QUfLpIDhsjWLMFk9PV2pa+s0Hdg4A
         fjPpdwt7ABi70fGaUKKmKv2bZFl1TX1+6zeJIsfMkkdroMBVgloDbus7BReFk/VnR6SK
         U3/FeQaNf+VwOjhpb7jEHXM9O0kdlPRDgdL57bNQPOItMru8HlJjVYwQ+N+2344BnMPn
         VLAi5RiU3HyfXVpuXxk7zerjlavpgg2bAlP3+3cJTt25Ft9WDn+uxWyPYbRLNm7Ai0Pc
         vXXXfPvNhZtFZkSVRsZBYd2w5ycRNts4T71gXQtVVij69COOyaOfL2kzw9iAAtRqdG7F
         mAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrY0n+Lxp4Ps0vKWrqg8qzPispapVC5K8BCl7226S1Y=;
        b=qMeJyPa4fO89sO7aVdN+57AjvY9VAlC995fcW8sLf9bCympoZrPP6pPZxLxIhjy7g+
         +cuSCLdBkZGvqnFZzrr9bThrnCk6vkigordvUX+X6HDEnw4jONyMaYlRPAo8iSxRCZ1E
         8FUdgCCm85KL7/gpCUsds2wwyio4RrnC1NiAxEZE1uTjIT77BruegSICKfAqJJhLNuzx
         56OtoAUrGtmZKCtPC2+KWRx0lN3OhUkuLU7V1SCQMV3hYNe4CSjFDn6C4e3Hp1fUkV4b
         xhY++rqNdUiVVSdkIa04esl6SulsPPvDKojoHPl7VfbNEraJoV+ukFIUVHV9fjzgiq7h
         akAg==
X-Gm-Message-State: AOAM533LNusq2Fm1nAdJ7eFltG5rrPtGMhRYUCmizaGxRl4UC3lWrEDf
        l5xtGow+wjqgm4vzVbC4hsZb87Q3Nkag1i576F4=
X-Google-Smtp-Source: ABdhPJzfUq4g2hUm0yylW2BZjBYzZffhnMg9JFRt8eQ2YfVzP7n3YGn8DdvLynY3V96ZCJFM7lK9ybFe7wDfCGFFvXY=
X-Received: by 2002:a92:910:: with SMTP id y16mr2375456ilg.22.1601022430617;
 Fri, 25 Sep 2020 01:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.5.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
In-Reply-To: <20200925145255.v3.5.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 25 Sep 2020 16:26:59 +0800
Message-ID: <CAJsYDV+EifAeMKEGwi0oH6A5EvPN8tMZQ+oqY5JGe=+kqzjMLw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spi: spi-mtk-nor: support 36bit dma addressing
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On Fri, Sep 25, 2020 at 2:56 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> This patch enables 36bit dma address support to spi-mtk-nor.
> Currently this is enabled only for mt8192-nor.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/spi/spi-mtk-nor.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index 8dbafee7f431..35205635ed42 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -78,6 +78,8 @@
>  #define MTK_NOR_REG_DMA_FADR           0x71c
>  #define MTK_NOR_REG_DMA_DADR           0x720
>  #define MTK_NOR_REG_DMA_END_DADR       0x724
> +#define MTK_NOR_REG_DMA_DADR_HB                0x738
> +#define MTK_NOR_REG_DMA_END_DADR_HB    0x73c
>
>  /* maximum bytes of TX in PRG mode */
>  #define MTK_NOR_PRG_MAX_SIZE           6
> @@ -106,6 +108,7 @@ struct mtk_nor {
>         unsigned int spi_freq;
>         bool wbuf_en;
>         bool has_irq;
> +       bool high_dma;
>         struct completion op_done;
>  };
>
> @@ -305,6 +308,11 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
>         writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
>         writel(dma_addr + length, sp->base + MTK_NOR_REG_DMA_END_DADR);
>
> +       if (sp->high_dma) {
> +               writel(dma_addr >> 32, sp->base + MTK_NOR_REG_DMA_DADR_HB);
> +               writel((dma_addr + length) >> 32, sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
> +       }

I remembered kbuild test robot reported a warning on this on 32-bit platforms
in your v1. [0]
I don't know what's the fix for this though :(

[0] https://marc.info/?l=linux-spi&m=159982425706940&w=2
-- 
Regards,
Chuanhong Guo
