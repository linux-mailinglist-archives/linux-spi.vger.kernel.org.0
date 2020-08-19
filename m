Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD12249EA0
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHSMtp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Aug 2020 08:49:45 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34267 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgHSMtp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:49:45 -0400
Received: by mail-ej1-f65.google.com with SMTP id o23so26173946ejr.1;
        Wed, 19 Aug 2020 05:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8dBUU0Q21El3kg2jckdztSie/u5vjySYPFsHaaaxqE4=;
        b=aowkI0wdiZo5eNbJqbNd5DD0BbD0D6Vu6YNhzSe49fxzsdsK4ZjYB8/EwK30TK6C+L
         wog14BSdGbpKYp9BJ6pPcJqepuDw4s71C705c7ZWY2N+L5huvPvKRMLKNz2AYXxxs5lY
         /uRUYUP3LNLJEJiHusvqOTgdracu3dWkYUUohpY+Y6CTFGhGDV/xzWaxCYQ7kR0tygqQ
         ZooJP5NyidMYhi94g6952j+aSrXOcM0jC+AjBIEtBG12Bnrw79s7OISuJQLu9tI2S5bM
         Y5S3zlZqHceRUn8X+x9srAmg93D7Lyh6RM0B9Xd/b7moXBmvXZMXzzfR7q8gjilmlp+I
         qHzA==
X-Gm-Message-State: AOAM530XxB6tbAIUgOCgqxeMXz30uf7LeOTORcHj1MT7SbwopCltnwhC
        o5ZqcXG3UvFP6yMUNY7pC9M=
X-Google-Smtp-Source: ABdhPJwy4yfwjOFogEcaLGnuwIXtds88I8TK5q6CoVDJRuHTnx/Axp937fjZo4CNQzAIXBPAB9WNUQ==
X-Received: by 2002:a17:906:8510:: with SMTP id i16mr8060277ejx.76.1597841383455;
        Wed, 19 Aug 2020 05:49:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id g9sm16778134edk.97.2020.08.19.05.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:49:42 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:49:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 7/8] spi: spi-s3c64xx: Increase transfer timeout
Message-ID: <20200819124940.GG18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123228eucas1p19ac7fc04dec52c733ab9c770e91f6ace@eucas1p1.samsung.com>
 <20200819123208.12337-8-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-8-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:07PM +0200, Łukasz Stelmach wrote:
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

Why? Everything works fine and suddenly minimum timeout is 100 ms?

Best regards,
Krzysztof

> ---
>  drivers/spi/spi-s3c64xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 27d77600a820..27db1e0f6f32 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -464,7 +464,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
>  
>  	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
>  	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
> -	ms += 10; /* some tolerance */
> +	ms = (ms * 10) + 30;    /* some tolerance */
> +	ms = max(ms, 100);      /* minimum timeout */
>  
>  	val = msecs_to_jiffies(ms) + 10;
>  	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
> -- 
> 2.26.2
> 
