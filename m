Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101E5280760
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgJATEb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 1 Oct 2020 15:04:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJATEb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 15:04:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id j2so6787210eds.9;
        Thu, 01 Oct 2020 12:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zeKkzOX/+f78pYSz0OLOk3y5ar+5SxhA4XaANsejuqI=;
        b=WxMx/HklkyA35zspKb0bf7CuO4q4U1nSngVixgVe8oCnwGVa1d7qAojg4hw4UmUmBZ
         rov7225/KGwdm+VwJuB1TcCLc4McdiHiYJ62f4W5s3jpUaLfQkvrDu9mE4w9R7r5hKFq
         3IKc6L/vNQJeVvE1Pw63ZLEncPSli2kCwthdB4nKymAQNb5BrIUU3W64qynkJa7m+Wrb
         ruOZykdInc0wy+HcnpaxfR3MAbi6WY7HAINbiMKrxRvybLD5kiI0UNGr7Gxzn7rvIOWI
         oAvgvC8nb0R7GgUw9dvsZ+Z+nE1b3Nss7OHgsEHVKUbhdt6i1HN/le1FXrJABbkq1rzd
         lSfQ==
X-Gm-Message-State: AOAM530JV7KgXjPW84ns0GwZysEpn9BoM2J0vjXkxleVfa4EkcKmHHFV
        x2PNlkXSsmG4jZhVwUefAP4=
X-Google-Smtp-Source: ABdhPJzdaSsfnbSSZ0vh0B/dL310BWawpBjIkqwzgh8zCQqZCuSXaF3SIl4fg0+e51sUW5gkikTpTA==
X-Received: by 2002:a50:d517:: with SMTP id u23mr2626565edi.338.1601579067753;
        Thu, 01 Oct 2020 12:04:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id 12sm1640686edw.50.2020.10.01.12.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 12:04:25 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:04:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 RESEND 2/9] spi: spi-s3s64xx: Add
 S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
Message-ID: <20201001190423.GB11048@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <20201001152148.29747-1-l.stelmach@samsung.com>
 <CGME20201001152246eucas1p2fb22ab55c276d76c4508142842c90ab8@eucas1p2.samsung.com>
 <20201001152148.29747-3-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201001152148.29747-3-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 01, 2020 at 05:21:41PM +0200, Łukasz Stelmach wrote:
> Fix issues with DMA transfers bigger than 512 bytes on Exynos3250. Without
> the patches such transfers fail.
> 
> The vendor kernel for ARTIK5 handles CS in a simmilar way.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 26c7cb79cd78..22bf8c75580a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1379,6 +1379,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
>  	.tx_st_done	= 25,
>  	.high_speed	= true,
>  	.clk_from_cmu	= true,
> +	.quirks		=  S3C64XX_SPI_QUIRK_CS_AUTO,

I spotted now: you have here double space after '='.

Best regards,
Krzysztof
