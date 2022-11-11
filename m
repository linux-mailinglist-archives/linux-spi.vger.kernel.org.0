Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0622862579D
	for <lists+linux-spi@lfdr.de>; Fri, 11 Nov 2022 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiKKKGj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Nov 2022 05:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiKKKGi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Nov 2022 05:06:38 -0500
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 02:06:35 PST
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA06A6AF
        for <linux-spi@vger.kernel.org>; Fri, 11 Nov 2022 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=rwZFGE+odeYZ0/nsoz5j/VA2O3yvrR3aAWh6ZtclErI=;
        b=SabqUCihNkMbRbhGDBYNjbpv1dv0C14JQwTpxt5rt2YpfqjJA8elnB4TpJFd0UlTx+HFOPL+pKKDZ
         9aPiKs2v4DOqs2uWE6C19TxJwYgK9GrnLLGm2DWJ0GWQRtXsojazObBLTdR+CULMS9jQGMxs2S5OWZ
         JrXUyn5xK0cQIbDHVz0R4Hnzwnd8bJLQz1OH4Ikrh0dthuTvmRyA8dF6fLqVM/iKDN6dT8nobJCIQR
         wYJ1gMftAr+KsFU9c7q+NNYx9mtPOcv3UasmL52z14eO9LpfU5BHlzs5Bo9MGTbiMej4QgN3rpVeZ3
         a8QM0/zpXUEUxtVBWBfmEAhXh8XVSYw==
X-MSG-ID: 4648b2fc-61a6-11ed-b61c-0050569d3a82
Date:   Fri, 11 Nov 2022 10:50:28 +0100
From:   David Jander <david@protonic.nl>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     broonie@kernel.org, mkl@pengutronix.de, linux-spi@vger.kernel.org,
        frieder.schrempf@kontron.de, stable@kernel.org
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Message-ID: <20221111105028.7d605632@erd992>
In-Reply-To: <20221111003032.82371-1-festevam@gmail.com>
References: <20221111003032.82371-1-festevam@gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Nov 2022 21:30:32 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> This reverts commit 07e7593877882fbd07c55b26b7dcf88760449323.
> 
> Since commit 07e759387788 ("spi: spi-imx: add PIO polling support") it is
> no longer possible to do successful SPI NOR programming on
> imx8mm-kontron-n801x-som, even though the copy operation returns no errors
> to the user.
> 
> After programming the SPI NOR flash from Linux, the board fails to
> boot from SPI NOR, leading to an unbootable system.
> 
> Revert it to fix the regression.

Thanks for letting us know of this bug. I just tested latest mainline on an
i.MX6Q board I have with SPI NOR flash, and it seems to work fine without this
revert, so I guess there is something different about your situation that
breaks this. I'd like to know what it is and fix it rather than revert this
patch which is very valuable for a lot of applications.

Could you help me find out more about what is happening?
Are we talking about arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi?
What are the specific symptoms (besides not booting)? What is the content of
NOR flash after erasing and programming a new image? Is it empty or are
contents just incorrect or randomly corrupted? Does erase work?
Are you using SDMA? If so, what firmware version?
Do you still have problems if you set polling_limit_us to 0?
Do you still have problems if you set polling_limit_us to a very big number,
lets say 1000000?

The effect of this patch is that it will cause short SPI transfers to have a
lot less latency than without this patch, so could it be that we are looking
at a timing related bug in the MTD driver, or some other timing issue?
Your SPI clock is 80MHz, but the datasheet of the MACRONIX MX25R1635F
specifies a maximum clock of 33MHz. Is your NOR flash chip capable of this
clock-rate?

> Cc: stable@kernel.org
> Fixes: 07e759387788 ("spi: spi-imx: add PIO polling support")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/spi/spi-imx.c | 66 -------------------------------------------
>  1 file changed, 66 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index a4bda03d3a8e..b946d98a8d66 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -31,12 +31,6 @@ static bool use_dma = true;
>  module_param(use_dma, bool, 0644);
>  MODULE_PARM_DESC(use_dma, "Enable usage of DMA when available (default)");
>  
> -/* define polling limits */
> -static unsigned int polling_limit_us = 30;
> -module_param(polling_limit_us, uint, 0664);
> -MODULE_PARM_DESC(polling_limit_us,
> -		 "time in us to run a transfer in polling mode\n");
> -
>  #define MXC_RPM_TIMEOUT		2000 /* 2000ms */
>  
>  #define MXC_CSPIRXDATA		0x00
> @@ -1490,54 +1484,6 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
>  	return 0;
>  }
>  
> -static int spi_imx_poll_transfer(struct spi_device *spi,
> -				 struct spi_transfer *transfer)
> -{
> -	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
> -	unsigned long timeout;
> -
> -	spi_imx->tx_buf = transfer->tx_buf;
> -	spi_imx->rx_buf = transfer->rx_buf;
> -	spi_imx->count = transfer->len;
> -	spi_imx->txfifo = 0;
> -	spi_imx->remainder = 0;
> -
> -	/* fill in the fifo before timeout calculations if we are
> -	 * interrupted here, then the data is getting transferred by
> -	 * the HW while we are interrupted
> -	 */
> -	spi_imx_push(spi_imx);
> -
> -	timeout = spi_imx_calculate_timeout(spi_imx, transfer->len) + jiffies;
> -	while (spi_imx->txfifo) {
> -		/* RX */
> -		while (spi_imx->txfifo &&
> -		       spi_imx->devtype_data->rx_available(spi_imx)) {
> -			spi_imx->rx(spi_imx);
> -			spi_imx->txfifo--;
> -		}
> -
> -		/* TX */
> -		if (spi_imx->count) {
> -			spi_imx_push(spi_imx);
> -			continue;
> -		}
> -
> -		if (spi_imx->txfifo &&
> -		    time_after(jiffies, timeout)) {
> -
> -			dev_err_ratelimited(&spi->dev,
> -					    "timeout period reached: jiffies: %lu- falling back to interrupt mode\n",
> -					    jiffies - timeout);
> -
> -			/* fall back to interrupt mode */
> -			return spi_imx_pio_transfer(spi, transfer);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  static int spi_imx_pio_transfer_slave(struct spi_device *spi,
>  				      struct spi_transfer *transfer)
>  {
> @@ -1587,7 +1533,6 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  				struct spi_transfer *transfer)
>  {
>  	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
> -	unsigned long hz_per_byte, byte_limit;
>  
>  	spi_imx_setupxfer(spi, transfer);
>  	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
> @@ -1599,17 +1544,6 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  	if (spi_imx->slave_mode)
>  		return spi_imx_pio_transfer_slave(spi, transfer);
>  
> -	/*
> -	 * Calculate the estimated time in us the transfer runs. Find
> -	 * the number of Hz per byte per polling limit.
> -	 */
> -	hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
> -	byte_limit = hz_per_byte ? transfer->effective_speed_hz / hz_per_byte : 1;
> -
> -	/* run in polling mode for short transfers */
> -	if (transfer->len < byte_limit)
> -		return spi_imx_poll_transfer(spi, transfer);
> -
>  	if (spi_imx->usedma)
>  		return spi_imx_dma_transfer(spi_imx, transfer);
>  

Best regards,

-- 
David Jander
Protonic Holland.
