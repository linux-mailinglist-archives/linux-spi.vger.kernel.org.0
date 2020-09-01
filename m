Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF15259F02
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 21:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgIATM5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Sep 2020 15:12:57 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46785 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgIATM4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Sep 2020 15:12:56 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 41664C0003;
        Tue,  1 Sep 2020 19:12:52 +0000 (UTC)
Date:   Tue, 1 Sep 2020 21:12:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
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
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 03/11] spi: atmel: Simplify with dev_err_probe()
Message-ID: <20200901191252.GL3204668@piout.net>
References: <20200901152713.18629-1-krzk@kernel.org>
 <20200901152713.18629-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901152713.18629-3-krzk@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/09/2020 17:27:05+0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/spi/spi-atmel.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 2cfe6253a784..7c68d5cdbdc6 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -513,9 +513,8 @@ static int atmel_spi_configure_dma(struct spi_master *master,
>  
>  	master->dma_tx = dma_request_chan(dev, "tx");
>  	if (IS_ERR(master->dma_tx)) {
> -		err = PTR_ERR(master->dma_tx);
> -		if (err != -EPROBE_DEFER)
> -			dev_err(dev, "No TX DMA channel, DMA is disabled\n");
> +		err = dev_err_probe(dev, PTR_ERR(master->dma_tx),
> +				    "No TX DMA channel, DMA is disabled\n");
>  		goto error_clear;
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
