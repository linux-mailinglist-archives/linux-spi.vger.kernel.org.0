Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EFD260BF7
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgIHH2K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIHH2I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Sep 2020 03:28:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F0C061573;
        Tue,  8 Sep 2020 00:28:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so16222585wmi.1;
        Tue, 08 Sep 2020 00:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Z6Wg0SnwD/AXrAjVsevt8UVjOEN4t/lHztjh1vqIpc=;
        b=XS64cDdEhGlawiJh6LVQuM8ykQpy7fKVkJGEf9EAbve3bo1jpw4oCC4GRgsloDDnh6
         79IovVrRwEZTq0mrnScg98VKa+IjpWfYHULNtY5xWIvmUN3msVhp6bKexlE+JOCKWfZQ
         OdDDDHqkWDjMPimfhUw1iFLXZvY9XhED6DfnCI3hLP2Gk8NX4pQsuFBvCNOJ40gzF15l
         NrzkgFpq7tOHaadAH1MMSA5SD34+0jmY3Q+QU5mAYoHM+5M+pOAKwjQUlfGgpd61bXnz
         U9xQWgk/ISvqizVv/NOPyhFXkcHw+hxFiKuB684hwNJrExcYkAwUCMVVEjFrwMANVigs
         j3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Z6Wg0SnwD/AXrAjVsevt8UVjOEN4t/lHztjh1vqIpc=;
        b=I5ZwNHS3eTar69AwfW7H6vuw12neM4JxQM6ygLNMnfILde0ex2+UcHHpztYK3Uzuwo
         pkHf3hbsDwhtLZEYuokkwctVvuY0q5oWzJs+OT7gtnXg1VJuN+R2lfKfkZACwxmRsaHm
         NYSqVr+dGXt5gQEs4CYJnC4YrC0dlKPBjBOiRPPcW8P59/fUGrHFYqtYEQopVcmUFK8I
         zA6ElhmS9+zNqjmhnFnyGWEofCM5PPXOoWSO8/UUefu1aFi8BbN9kZaKBPkxRsUpUfe9
         cYpxJBvZ0uHDb89HULxAdGDtK0iNQc9T4lXvm9A/2Axcmgz+gRIjR1bqj++u7Qz0fSz+
         CIuQ==
X-Gm-Message-State: AOAM5304vi5ZPEjoxREbFtaB+SCz5tc4FB8Ipk9S8jxTTQYHQVZS64YX
        BiOsxUwiqESSsHRo2QKGwVxwweyV9AF5h6m8498=
X-Google-Smtp-Source: ABdhPJwjK6sbs60PL5NK/eMKpIpeDVHYFaKbJBQcyNs8eO310GkWIw1SY87k3/I7sILHPffB+UnJxM8R7saP0utO1yc=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr2903235wmh.152.1599550086040;
 Tue, 08 Sep 2020 00:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200901152713.18629-1-krzk@kernel.org> <20200901152713.18629-2-krzk@kernel.org>
In-Reply-To: <20200901152713.18629-2-krzk@kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 8 Sep 2020 15:27:29 +0800
Message-ID: <CAAfSe-v4o-9zQZOSgQfAU-C4ruJU7BJdHRe4ikghx7AFgh1qgg@mail.gmail.com>
Subject: Re: [PATCH 02/11] spi: sprd: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 1 Sep 2020 at 23:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/spi/spi-sprd-adi.c |  5 +----
>  drivers/spi/spi-sprd.c     | 17 +++++------------
>  2 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
> index 127b8bd25831..392ec5cfa3d6 100644
> --- a/drivers/spi/spi-sprd-adi.c
> +++ b/drivers/spi/spi-sprd-adi.c
> @@ -504,10 +504,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
>                         dev_info(&pdev->dev, "no hardware spinlock supplied\n");
>                         break;
>                 default:
> -                       dev_err(&pdev->dev,
> -                               "failed to find hwlock id, %d\n", ret);
> -                       fallthrough;
> -               case -EPROBE_DEFER:
> +                       dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
>                         goto put_ctlr;
>                 }
>         }
> diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
> index 0443fec3a6ab..635738f54c73 100644
> --- a/drivers/spi/spi-sprd.c
> +++ b/drivers/spi/spi-sprd.c
> @@ -553,22 +553,15 @@ static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
>  static int sprd_spi_dma_request(struct sprd_spi *ss)
>  {
>         ss->dma.dma_chan[SPRD_SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
> -       if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_RX])) {
> -               if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]) == -EPROBE_DEFER)
> -                       return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
> -
> -               dev_err(ss->dev, "request RX DMA channel failed!\n");
> -               return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
> -       }
> +       if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_RX]))
> +               return dev_err_probe(ss->dev, PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]),
> +                                    "request RX DMA channel failed!\n");
>
>         ss->dma.dma_chan[SPRD_SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
>         if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_TX])) {
>                 dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
> -               if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]) == -EPROBE_DEFER)
> -                       return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
> -
> -               dev_err(ss->dev, "request TX DMA channel failed!\n");
> -               return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
> +               return dev_err_probe(ss->dev, PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]),
> +                                    "request TX DMA channel failed!\n");
>         }
>
>         return 0;
> --
> 2.17.1
>
