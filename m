Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7128CF47
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgJMNjk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 09:39:40 -0400
Received: from mailout12.rmx.de ([94.199.88.78]:48441 "EHLO mailout12.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbgJMNjk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 09:39:40 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout12.rmx.de (Postfix) with ESMTPS id 4C9c932nCCzRw7v;
        Tue, 13 Oct 2020 15:39:35 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4C9c822gQxz2TTMg;
        Tue, 13 Oct 2020 15:38:42 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.60) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Oct
 2020 13:58:03 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Date:   Tue, 13 Oct 2020 13:58:02 +0200
Message-ID: <1687325.7ZoAM7eIpP@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20201012140753.GF12463@pengutronix.de>
References: <20201009042738.26602-1-ceggers@arri.de> <6367849.hfWVFoRi9M@n95hx1g2> <20201012140753.GF12463@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.60]
X-RMX-ID: 20201013-153852-4C9c822gQxz2TTMg-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Monday, 12 October 2020, 16:07:53 CEST, Sascha Hauer wrote:
> On Fri, Oct 09, 2020 at 09:48:29AM +0200, Christian Eggers wrote:
> 
> 525c9e5a32bd introduced pm_runtime support for the i.MX SPI driver. With
> this pm_runtime is used to bring up the clocks initially. When CONFIG_PM
> is disabled the clocks are no longer enabled and the driver doesn't work
> anymore. Fix this by enabling the clocks in the probe function and
> telling pm_runtime that the device is active using
> pm_runtime_set_active().
> 
> Fixes: 525c9e5a32bd spi: imx: enable runtime pm support
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/spi/spi-imx.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 38a5f1304cec..c796e937dc6a 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1674,15 +1674,18 @@ static int spi_imx_probe(struct platform_device
> *pdev) goto out_master_put;
>  	}
> 
> -	pm_runtime_enable(spi_imx->dev);
> +	ret = clk_prepare_enable(spi_imx->clk_per);
> +	if (ret)
> +		goto out_master_put;
> +
> +	ret = clk_prepare_enable(spi_imx->clk_ipg);
> +	if (ret)
> +		goto out_put_per;
> +
>  	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
>  	pm_runtime_use_autosuspend(spi_imx->dev);
> -
> -	ret = pm_runtime_get_sync(spi_imx->dev);
> -	if (ret < 0) {
> -		dev_err(spi_imx->dev, "failed to enable clock\n");
> -		goto out_runtime_pm_put;
> -	}
> +	pm_runtime_set_active(spi_imx->dev);
> +	pm_runtime_enable(spi_imx->dev);
> 
>  	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
>  	/*
> @@ -1719,8 +1722,12 @@ static int spi_imx_probe(struct platform_device
> *pdev)
> 
>  out_runtime_pm_put:
>  	pm_runtime_dont_use_autosuspend(spi_imx->dev);
> -	pm_runtime_put_sync(spi_imx->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_disable(spi_imx->dev);
> +
> +	clk_disable_unprepare(spi_imx->clk_ipg);
> +out_put_per:
> +	clk_disable_unprepare(spi_imx->clk_per);
>  out_master_put:
>  	spi_master_put(master);

With this patch applied, my system (!CONFIG_PM) doesn't freeze anymore when 
the spi-imx driver is loaded.

Thank you very much!

Tested-by: Christian Eggers <ceggers@arri.de>
[tested for !CONFIG_PM only]
Cc: stable@vger.kernel.org  # 5.9.x only



