Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5028124E77D
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHVMnb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 08:43:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46249 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgHVMna (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 08:43:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id r15so4284381wrp.13;
        Sat, 22 Aug 2020 05:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WBNSRxvyAb/qQZAkHTrrLM5INeMErpw4ZMaPgiAVFYc=;
        b=NPGRsV3lU9KQ/PJOVDEAWuy9khYOyotMACJOnIMgyIGDcqFHtU3xwev68NCn61pLV4
         KkOw/+kpzX3i6DDmpfZPXTkCgazlYZmOPCT9kzdGis6E82u8IGg2qDrPSV71W9uqD4Tm
         BudUSdiy2eSkuLYKJb9Jkrd96H+q//e95A/4oaM6gBAob5D53XV/gSjz7mQvgaRP/t2F
         J+4nh+a2dqvX+03WpoNlluqYPc5IaQ01v3rPUKLzUVr+GwYVbfie6fkf9m5q8Gg+1IL2
         4JUJZXM1LY80m3I0gSlHlAGPTYO3E4LUMA5ReELM3phWeHhVhVc4qQ0M7SwxVgjG3x4N
         TCrw==
X-Gm-Message-State: AOAM530mZoGY5tVy84yjNtQdoubpRTOM7gB7/PKxLoBQG/XJBWou08dC
        nIkq2uXwqm2eZsRVjVoOUS8=
X-Google-Smtp-Source: ABdhPJwdJA/5sEK6TGoZ7ND8qtNuotIocdqMiW4JOZohKvT3Lpi0KdwHGvSd1Cm5w504EjRKD/ptuQ==
X-Received: by 2002:adf:c64d:: with SMTP id u13mr7206988wrg.114.1598100208370;
        Sat, 22 Aug 2020 05:43:28 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id d14sm11074673wre.44.2020.08.22.05.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:43:27 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:43:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Message-ID: <20200822124325.GF20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2@eucas1p2.samsung.com>
 <20200821161401.11307-8-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-8-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:13:59PM +0200, Łukasz Stelmach wrote:
> cur_speed is used to calculate transfer timeout and needs to be
> set to the actual value of (half) the clock speed for precise
> calculations.

If you need this only for timeout calculation just divide it in
s3c64xx_wait_for_dma(). Otherwise why only if (cmu) case is updated?

You are also affecting here not only timeout but
s3c64xx_enable_datapath() which is not mentioned in commit log. In other
words, this looks wrong.

Best regards,
Krzysztof

> 
> Cc: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 02de734b8ab1..89c162efe355 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
>  		if (ret)
>  			return ret;
> +		sdd->cur_speed = clk_get_rate(sdd->src_clk) / 2;
>  	} else {
>  		/* Configure Clock */
>  		val = readl(regs + S3C64XX_SPI_CLK_CFG);
> -- 
> 2.26.2
> 
