Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0516224E744
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 14:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHVMCL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 08:02:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34634 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgHVMCK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 08:02:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so4292125wrw.1;
        Sat, 22 Aug 2020 05:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p0ZOKsEqxYq/dPyLynSj5muBJYzE12r6/FPqjVWhV2g=;
        b=SVTdbNm3laPeYq9J/L5nbIO9qS17jbprrBBWgsVNpINIB5N81nK6sHfzZ4zRzKhiII
         aZuGDeo73a8NJ06lpN2LqIIPQ/BLgcZRTSLNvYnqcLGB10RvXOxQh0P2uidhn3Kq3yep
         b0TmloQtrm0Q478ti6jFpGMWGpTAONWyduR2Bpl/dZ/PjAt6sXQK3gB9rWTMk9iz0n5V
         gU45gy1dxz/pN8FXcqB2dXrpzI2NYQZkRd9W9FKJLLk81PnGfKKuPAXWWJeX6No7OtOE
         +PUHjhD+dEHvAtJ+E2hqloSipOTeZ8dtCP7B+Me7fSzkYeJCJgmK1IUxD5inFj3+PosH
         t23Q==
X-Gm-Message-State: AOAM532IhAm65vjsSTzNJLd4DGCctZZ9OcEgIn2qiParsf3ChidA0mgY
        Hf7Az6BeVt0jThKaKep3wukNHI+6X0A=
X-Google-Smtp-Source: ABdhPJy5UUAZ3T9VbAJOJ37DrVQjyWvVvEecaUSRg9dpRET6qAoAdpQ0JXGawzzsyd5oN9xtEV1S2Q==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr1711828wrn.294.1598097728326;
        Sat, 22 Aug 2020 05:02:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id t12sm2980175wrm.61.2020.08.22.05.02.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:02:07 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:02:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 2/9] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO
 for Exynos3250
Message-ID: <20200822120205.GB20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161405eucas1p20aad659cd41bc4f56d5123d3c63394f0@eucas1p2.samsung.com>
 <20200821161401.11307-3-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-3-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:13:54PM +0200, Łukasz Stelmach wrote:
> This and the previous patch fix issues with DMA transfers bigger than

"Fix issues with DMA..."

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> 512 bytes on Exynos3250. Without the patches such transfers fail.
> 
> The vendor kernel for ARTIK5 handles CS in a simmilar way.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
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
>  };
>  
>  static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
> -- 
> 2.26.2
> 
