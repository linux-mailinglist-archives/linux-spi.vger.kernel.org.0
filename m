Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B624E740
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHVMB1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 08:01:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52642 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgHVMB0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 08:01:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id x5so4172362wmi.2;
        Sat, 22 Aug 2020 05:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bPouFZMIl7dlHwQoDaxlb/Nq4wtVCEDrmFr3ebXaAIM=;
        b=l9gzW/BWHb8fmrsHN4ZkWsslyiB6i73egwzcGCrvzZEzBj0DZXnVnacONUbvDjpE74
         fzFaT1DUgwcbk3ziLnLXHCpCXySNj0h74Og9QtUS8rocUDJnx9ssR8TwpsZT04QpMp93
         8kyyIaVhGIgTga+WoKrzmDzcryGIaPuqJYZ6ufb0m4dlpsCRWjzSalN7uXWuwnEwhCJ3
         ZFvXZ3ePtDj0SZ0I+y4lC0ELLEk7pe11L7YKO3q5/5braxHzllOLYUQ0WQVCdcVatKsg
         J5M8+Jlz8ZJ9vXGFIUlXRZHPYU8Y/VSMzCP+X49eUMNYZ2teqYwOOGS12tm4vh3cZAf7
         3Gcw==
X-Gm-Message-State: AOAM531OSkGIzv5Y4XIdwvbUPbS12X2nJUoNHCo/Pr5wtlFXy4AgG0lI
        R9keu5ouQhhZy4L/kT6lh6I=
X-Google-Smtp-Source: ABdhPJz8YNXzvqgyYb9UZGsKJDnt9kosXNPfPc3M7afStiua+EoML1ySc0g9dWYlQxwULI4DhYxdGg==
X-Received: by 2002:a05:600c:2d1:: with SMTP id 17mr7391901wmn.15.1598097683955;
        Sat, 22 Aug 2020 05:01:23 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id t14sm10442478wrv.14.2020.08.22.05.01.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:01:23 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:01:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Message-ID: <20200822120121.GA20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161405eucas1p1d43a5970c6a26389cd506aab5f986bc8@eucas1p1.samsung.com>
 <20200821161401.11307-2-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-2-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:13:53PM +0200, Łukasz Stelmach wrote:
> This and the next patch fix issues with DMA transfers bigger than

Just:
"Fix issues with DMA transfers..."

The order of patches could change when applying and backporting.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> 512 bytes on Exynos3250. Without the patches such transfers fail
> to complete. This solution to the problem is found in the vendor kernel
> for ARTIK5 boards based on Exynos3250.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 924b24441789..26c7cb79cd78 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -685,11 +685,11 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>  		sdd->state &= ~RXBUSY;
>  		sdd->state &= ~TXBUSY;
>  
> -		s3c64xx_enable_datapath(sdd, xfer, use_dma);
> -
>  		/* Start the signals */
>  		s3c64xx_spi_set_cs(spi, true);
>  
> +		s3c64xx_enable_datapath(sdd, xfer, use_dma);
> +
>  		spin_unlock_irqrestore(&sdd->lock, flags);
>  
>  		if (use_dma)
> -- 
> 2.26.2
> 
