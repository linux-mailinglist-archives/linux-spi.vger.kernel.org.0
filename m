Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46AD368F22
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhDWJBC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 05:01:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43068 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWJBC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 05:01:02 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lZrfg-0005L5-Nr; Fri, 23 Apr 2021 11:00:20 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     broonie@kernel.org, Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk, Jon Lin <jon.lin@rock-chips.com>
Subject: Re: [PATCH v1 2/8] spi: rockchip: add compatible string for rv1126
Date:   Fri, 23 Apr 2021 11:00:18 +0200
Message-ID: <10186800.nitPUkWRp2@diego>
In-Reply-To: <20210423084155.17439-2-jon.lin@rock-chips.com>
References: <20210423084155.17439-1-jon.lin@rock-chips.com> <20210423084155.17439-2-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jon,

Am Freitag, 23. April 2021, 10:41:49 CEST schrieb Jon Lin:
> Add compatible string for rv1126 to applications for potential
> applications.
> 
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
>  drivers/spi/spi-rockchip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 52d6259d96ed..dae0281f6ba8 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -911,7 +911,9 @@ static const struct dev_pm_ops rockchip_spi_pm = {
>  };
>  
>  static const struct of_device_id rockchip_spi_dt_match[] = {
> -	{ .compatible = "rockchip,px30-spi", },
> +	{ .compatible = "rockchip,px30-spi",   },

unrelated change with the add "space" at the end

> +	{ .compatible = "rockchip,rv1108-spi", },
> +	{ .compatible = "rockchip,rv1126-spi", },

it seems the list was sorted alphabetically, so rv* comes after rk*
which is probably why the rv1108 was at the bottom and rightfully so.


Heiko

>  	{ .compatible = "rockchip,rk3036-spi", },
>  	{ .compatible = "rockchip,rk3066-spi", },
>  	{ .compatible = "rockchip,rk3188-spi", },
> @@ -921,7 +923,6 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
>  	{ .compatible = "rockchip,rk3328-spi", },
>  	{ .compatible = "rockchip,rk3368-spi", },
>  	{ .compatible = "rockchip,rk3399-spi", },
> -	{ .compatible = "rockchip,rv1108-spi", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
> 




