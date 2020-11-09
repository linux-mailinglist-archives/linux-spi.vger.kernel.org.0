Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2B2AC61B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 21:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgKIUpL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 15:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIUpK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 15:45:10 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FEDC0613CF;
        Mon,  9 Nov 2020 12:45:09 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id h23so7588215ljg.13;
        Mon, 09 Nov 2020 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xleOeNICgG0vwSm5hJnysiXKM3yQ5B3QY8UUY+zBMgU=;
        b=BtJOr3n+oEvi29MidTbCXT7DDDOg8dn1y7D7gereDVMHC0EljuUpu8DAvhNHjMQGyZ
         zIjF8HCv+xW8ZAUP8dVlP/fJeHcnM34A0S2ZBY9pDiQsQUdGeQPr6ADaATbSQ228YWz+
         XXXayw7srrvzjZyicsNXxFgY/ODh9gsl9QeLuSzRyVD5jNxWdFrVoH0SctAS/fPhJUUl
         gtr2mqPgWcbj6XsYK2QKg3PK0D916/M5ZX63w6Lp62o5kJ7HHOzW3z8wp2D7xyQqXO31
         AYmznFJbrt15o3POcJzyYrcONEHVFRqEvCFGctEmOTbU/elIWynnQy4IpnmB0qo6RuVX
         Ci4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xleOeNICgG0vwSm5hJnysiXKM3yQ5B3QY8UUY+zBMgU=;
        b=JW1Xt0/VHvxTJs1Jux4Ax/D35o93EYB+yKyi5OkcO/UsdUKxde8BJGwRZMh5jmxyuG
         geM0Qxgl1p0exPh/EH8d93hVsblr1YkzAnbx4fYBm49P0lHiK0zns5Q5fOIWZGUyZOen
         ge0jYcfXpB9DLLjezFSwz2UUMqr+8pwW5+six6AsiEpIuIMBzA7UtALR+uzJomMAHKE4
         pDQIxJuoCsoTeQgAroE1Xc+7ChAJ+ezruxEanUbzmhyMo87lhkNOspB7MGKivT3N1t6e
         LZ589aRoPSIyBrewrcwZPq2pDj2FXGC9LxwaP8bfIE/5FO85kFXjZEDVPQF8rNVZBs0/
         2dUw==
X-Gm-Message-State: AOAM532AKMDOdOqYu6INfc9cbX4dKDJu+OGRyv6E69/ykK6Ug0VbbSPM
        h9UFj9cf+pC2kGV+zqeG0mClKlXpu7UoFS50
X-Google-Smtp-Source: ABdhPJwPfo9KB6YtEoJkeHK76OC4rgJuIhLlDo2MBXl0lJDnZj3HCkxJEr0CD312vs0esIJMUMVsEA==
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr6453285ljj.250.1604954707454;
        Mon, 09 Nov 2020 12:45:07 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id v22sm251076ljd.9.2020.11.09.12.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:45:06 -0800 (PST)
Date:   Mon, 9 Nov 2020 23:45:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 05/32] spi: dw: Introduce DW_SPI_CAP_POLL_NODELAY
Message-ID: <20201109204504.npjdxnxgzkngif3s@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-6-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-6-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:13:53PM +0900, Damien Le Moal wrote:
> On slow systems, i.e. systems with a slow CPU resulting in slow context
> switches, calling spi_delay_exec() when executing polled transfers
> using dw_spi_poll_transfer() can lead to RX FIFO overflows. Allow
> platforms to opt out of delayed polling by introducing the
> DW_SPI_CAP_POLL_NODELAY DW SPI capability flag to disable
> the execution of spi_delay_exec() in dw_spi_poll_transfer().

Please, have a more thorough problem review. Rx FIFO shouldn't
overflow even for the CPUs with slow context switch. If it does, then
most likely there is a bug in the code. So it's not a good idea to
work it around by introducing a dts-property in any case.

Just to note in case of our hardware no matter what CPU frequency I
specified (it can be varied from 200MHz to 1500MHz), there have never
been seen the Rx FIFO overflow error even with heavy background tasks
executed. I am really puzzled why some context switch causes the error
in your case...

As I said in another thread, some logical MMC-SPI drivers errors may
happen if the native CS is utilized...

On the other hand, if you have a DMA-engine utilized together with
your controller and the Tx DMA-channel is tuned to work faster than
the Rx DMA-channel, then the Rx FIFO overflow will eventually happen.
So replacing the DMA-based transfers with the poll- or IRQ-based ones
shall indeed solve the problem. But the better solution would be to
balance the DMA-channels priority if your DMA-controller is capable of
doing that.

-Sergey

> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-core.c | 12 ++++++++----
>  drivers/spi/spi-dw.h      |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index c2ef1d8d46d5..16a6fd569145 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -385,14 +385,18 @@ static int dw_spi_poll_transfer(struct dw_spi *dws,
>  	u16 nbits;
>  	int ret;
>  
> -	delay.unit = SPI_DELAY_UNIT_SCK;
> -	nbits = dws->n_bytes * BITS_PER_BYTE;
> +	if (!(dws->caps & DW_SPI_CAP_POLL_NODELAY)) {
> +		delay.unit = SPI_DELAY_UNIT_SCK;
> +		nbits = dws->n_bytes * BITS_PER_BYTE;
> +	}
>  
>  	do {
>  		dw_writer(dws);
>  
> -		delay.value = nbits * (dws->rx_len - dws->tx_len);
> -		spi_delay_exec(&delay, transfer);
> +		if (!(dws->caps & DW_SPI_CAP_POLL_NODELAY)) {
> +			delay.value = nbits * (dws->rx_len - dws->tx_len);
> +			spi_delay_exec(&delay, transfer);
> +		}
>  
>  		dw_reader(dws);
>  
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 48a11a51a407..25f6372b993a 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -130,6 +130,7 @@ enum dw_ssi_type {
>  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
>  #define DW_SPI_CAP_DWC_SSI		BIT(2)
>  #define DW_SPI_CAP_DFS_32		BIT(3)
> +#define DW_SPI_CAP_POLL_NODELAY		BIT(4)
>  
>  /* Slave spi_transfer/spi_mem_op related */
>  struct dw_spi_cfg {
> -- 
> 2.28.0
> 
