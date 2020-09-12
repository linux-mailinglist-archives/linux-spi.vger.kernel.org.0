Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865C267CD4
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgILXBv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 19:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgILXBt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 19:01:49 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499AC061757
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 16:01:48 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g96so11525175otb.12
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0m6aJ6IVMUWWmvAiynENtbggnVCLW+2icfqjSBWtS5I=;
        b=cFYUUX8ttmtgUclcC895P9U9pk0bPL832aNTBKLfyu65yPGoW/i+vFTdQuDFhMfFfH
         7O+tUdqA24+52JRHzHAECEXbIaBw3J/x0Hee5qeTDr95VOgkZcF2H6OG8Q6ZuVtQ/MVm
         QeuUUDNAj3RGIuVuzqcUFYWdiXr0b0opS4qowxRtyzaBSB1GK0Ghpp3efQw8wszjO4dD
         b/4wtXNy3raTll7T+QY3hReScmTXsmECKgobNwVG9BNvEyX/wotyUQUiGu7qj1AT1Ed4
         +WSc3DJIq8MVp2QU3poXvUHg7y3QUzqhsOQUtZVozVJn6K8h9VCxEq5Fc1PsV7vZd/tC
         6n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0m6aJ6IVMUWWmvAiynENtbggnVCLW+2icfqjSBWtS5I=;
        b=cXRrwW4bBzGkiK7F/q2mOFc3g/d1G8l/ODOn77/Mpgu2zKlJ/u9nuFZiEE8LPWh2Ye
         2Nguz3GpMQ6L9OOxt37axBmB7PBD7IfjM1ITkL6NuCYpnQ+BTo6Y9B7fcSk9UIw9AUTq
         D1j6tuTOTmHJoF0s97laWz3wKEakmLQktSR5+ebWI0D2M9nl/GAtVxz7VNGTa/Eja6fL
         U9g8V+tpJezISoL9Uj+65AKgeHcFZ//vvcSIbcZ9V5AvQfNlm12teArM0CNJU2XZ54C7
         YP4mPYXjAyxBUqce4fbb/c4CiRJemDjQAZPDu7vu3J1dLN/GPXrMqYoL7qwYHgg0g7Eb
         Hfug==
X-Gm-Message-State: AOAM532wDtVW56m/6pAEC56E39WpSil8wXCGp4OpLKjV5zqDbACB9sN3
        qP5s7HMM2cC3aTv6zU4cBYs7RQ==
X-Google-Smtp-Source: ABdhPJyBKUHUGYwT0cPFiyRRjTNn1lLbBfXouuQ4OCesRxxdK4vOmqUHjDeNe+gQF6t/HVtPvtqAEw==
X-Received: by 2002:a9d:2925:: with SMTP id d34mr5133656otb.140.1599951707066;
        Sat, 12 Sep 2020 16:01:47 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id 39sm1019630oto.67.2020.09.12.16.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 16:01:46 -0700 (PDT)
Date:   Sat, 12 Sep 2020 18:01:43 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: spi-geni-qcom: Don't program CS_TOGGLE again
 and again
Message-ID: <20200912230143.GC3715@yoga>
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
 <20200912140730.2.I33e571179986850b4ec17042e813d0b08fb1b9c1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912140730.2.I33e571179986850b4ec17042e813d0b08fb1b9c1@changeid>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat 12 Sep 16:08 CDT 2020, Douglas Anderson wrote:

> We always toggle the chip select manually in spi-geni-qcom so that we
> can properly implement the Linux API.  There's no reason to program
> this to the hardware on every transfer.  Program it once at init and
> be done with it.
> 
> This saves some part of a microsecond of overhead on each transfer.
> While not really noticeable on any real world benchmarks, we might as
> well save the time.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/spi/spi-geni-qcom.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 7f0bf0dec466..92d88bf85a90 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -290,6 +290,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>  {
>  	struct geni_se *se = &mas->se;
>  	unsigned int proto, major, minor, ver;
> +	u32 spi_tx_cfg;
>  
>  	pm_runtime_get_sync(mas->dev);
>  
> @@ -322,6 +323,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
>  
>  	geni_se_select_mode(se, GENI_SE_FIFO);
>  
> +	/* We always control CS manually */
> +	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> +	spi_tx_cfg &= ~CS_TOGGLE;
> +	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +
>  	pm_runtime_put(mas->dev);
>  	return 0;
>  }
> @@ -331,7 +337,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>  				u16 mode, struct spi_master *spi)
>  {
>  	u32 m_cmd = 0;
> -	u32 spi_tx_cfg, len;
> +	u32 len;
>  	struct geni_se *se = &mas->se;
>  	int ret;
>  
> @@ -350,7 +356,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>  	spin_lock_irq(&mas->lock);
>  	spin_unlock_irq(&mas->lock);
>  
> -	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
>  	if (xfer->bits_per_word != mas->cur_bits_per_word) {
>  		spi_setup_word_len(mas, mode, xfer->bits_per_word);
>  		mas->cur_bits_per_word = xfer->bits_per_word;
> @@ -364,8 +369,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>  	mas->tx_rem_bytes = 0;
>  	mas->rx_rem_bytes = 0;
>  
> -	spi_tx_cfg &= ~CS_TOGGLE;
> -
>  	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
>  		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
>  	else
> @@ -384,7 +387,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>  		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
>  		mas->rx_rem_bytes = xfer->len;
>  	}
> -	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>  
>  	/*
>  	 * Lock around right before we start the transfer since our
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
