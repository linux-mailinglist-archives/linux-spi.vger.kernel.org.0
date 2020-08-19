Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCA249E3E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHSMjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Aug 2020 08:39:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38044 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgHSMjT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:39:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id i6so17955330edy.5;
        Wed, 19 Aug 2020 05:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hTw2sWzwayGISAZUjT4D4j7guwIbk9vIXMLy3pbTGZ8=;
        b=lwUUs6t0GAIvKdZ8aSPR/6WcaxQNRYvlhvCOvNafzPU3zpszpW09hmZ8Q0fD8qd0Rl
         /9sUUcl8616Z++DjxKtC+mGUWgw2Y2UI75XxlppAeP2GMKb9i4pVdNpo3eUm/+q30jvW
         n2DKGYCtdh/AnpbR9UqIH0/pjMWQiCDdvGJfNwVY6hIjdUrUfyZNq9naTiXrmed3me7f
         szZdaDhuBhrmQc4Uye2/4lnJquh6a8h1Dxr6HTixE/xrcAtBShc6wVn+giiyTML1SUkR
         7L58aLLpnZjjTx5l72AcBX1rO+dvOZicfreNGvhqEQ15RDkx2lj2BQgC1+NJoVZRm/Fy
         jRnA==
X-Gm-Message-State: AOAM5317xYmYajWCnIMAbdncY1qJ8z31iPflB/q5STv525hX69vW9I1B
        LERnaZVi0YtbLRwQNcQdjePEsdwfDw4maw==
X-Google-Smtp-Source: ABdhPJxuggSaXMQsbu/dUwHlom1r9VoEEuF9AbVt23Mco9Zgt7BiVixNMa23Yh6PfBFkA+lL78lGtQ==
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr23868240edz.115.1597840757786;
        Wed, 19 Aug 2020 05:39:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m13sm17919402edi.89.2020.08.19.05.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:39:17 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:39:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/8] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Message-ID: <20200819123914.GC18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123226eucas1p2f4be625abd7ddaac2f09bdf94395346b@eucas1p2.samsung.com>
 <20200819123208.12337-3-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-3-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:02PM +0200, Łukasz Stelmach wrote:
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

Add a quirk - why? There is here no commit msg, no explanation.

Best regards,
Krzysztof


> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index fb5e2ba4b6b9..8fe44451d303 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1372,6 +1372,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
>  	.tx_st_done	= 25,
>  	.high_speed	= true,
>  	.clk_from_cmu	= true,
> +	.quirks		=  S3C64XX_SPI_QUIRK_CS_AUTO,
>  };
>  
>  static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
> -- 
> 2.26.2
> 
