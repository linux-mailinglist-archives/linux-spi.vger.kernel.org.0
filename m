Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F2B3F4A2C
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhHWMAj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Aug 2021 08:00:39 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:43702 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhHWMAj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Aug 2021 08:00:39 -0400
Received: by mail-vs1-f54.google.com with SMTP id j186so10889242vsc.10;
        Mon, 23 Aug 2021 04:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMRXnqBVA9CZEqnX3UVE4nmccCLqccIYzxKtXkgnlzg=;
        b=SLhzmdzQL3v5+oCQzsrGT1kcd6R4JsEubAqdGmYZuLBXcB9m04PDNZGCpMTYFxR6x9
         3qq+rAP/oKNeoYab9ss8f7Vs5dczX73OYkN5f6WAmL4YQ3NttFI16w3wZv74EDd5ao/A
         NTQ3SvLZ8nkv9QamX23nIh3O1TvSs9anM5rN4AkjX3wvRs95H0xAiHBTlY8TaC3k4lUZ
         nJAckMPdwwCszPRneRATJSvm6G7eIG7B7LICz36uNRwq6Ly7QYOzdJGHDN1Zctw98KYW
         uRWBSDNU9eLtmAawG6Ao+xB57l4kh/eCxuoJJPGh+uGszHk7TsBSZN4R8m/6iqvT2UXY
         wPAA==
X-Gm-Message-State: AOAM532S8MRT6ApaKa5wG1NbNh6WwjmsYTPWvBsSo3YbBydHpjDYvjCn
        xU5vKarmGOTT21Ih3x6tPbRHio0ZvVWL7squ+d4=
X-Google-Smtp-Source: ABdhPJzD25RT28be79TeoWOfxhPVTeZC2RLR71pr/rQh0tohR21TJiJw9gIz0Xwj+B2v/w5AIug9k3/GO0LwM2g8GaA=
X-Received: by 2002:a67:c789:: with SMTP id t9mr23561585vsk.60.1629719996239;
 Mon, 23 Aug 2021 04:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210818165604.22127-1-zhengxunli.mxic@gmail.com>
In-Reply-To: <20210818165604.22127-1-zhengxunli.mxic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Aug 2021 13:59:45 +0200
Message-ID: <CAMuHMdWUVVnZXc4iXrkpyLFpr9w5X-EzuwvvFGQYAp+0=ZJbqw@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix missing setting address
To:     Zhengxun <zhengxunli.mxic@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        zhengxunli <zhengxunli@mxic.com.tw>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

CC sergey's new address

On Wed, Aug 18, 2021 at 10:57 AM Zhengxun <zhengxunli.mxic@gmail.com> wrote:
> In the RPC manual mode, if the data direction is not set
> (such as the flash erase command), the address misses the
> setting.
>
> Signed-off-by: Zhengxun <zhengxunli.mxic@gmail.com>
> ---
>  drivers/memory/renesas-rpc-if.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> index 45eed659b0c6..9dd27c6307f7 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -482,6 +482,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
>                 }
>                 break;
>         default:
> +               regmap_write(rpc->regmap, RPCIF_SMADR, rpc->smadr);
>                 regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
>                 regmap_write(rpc->regmap, RPCIF_SMCR,
>                              rpc->smcr | RPCIF_SMCR_SPIE);
> --
> 2.17.1
