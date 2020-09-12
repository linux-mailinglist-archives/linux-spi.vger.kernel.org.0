Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8D267CE4
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 01:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgILXJ5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgILXJy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 19:09:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBB1C061573
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 16:09:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w25so10333942otk.8
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEj25auNRfoFs7fGBIclA3iB7k0sYk51VrLB+0yDItQ=;
        b=zFiZPyOHU6K9fCyvzETj/V58HgaEc/7wTNUFlNllONtwgCArpJkW0yzLCmTfQf/mgx
         n0nNCW1I4aCXkXC9oy7JhAv124+wTeIH0uQsKH5Yg7FCPAJ/jexB93WgQU4o0b1idWWz
         fWAoO1X+ElA3xylI5IRoKuNDMEEJfERoV+afQDE4ShNZuNkiigtMCegv/Dj2wpqat8kU
         D36KzLGA0oarBc2q+ws9+jjIiNF1rueTSzmGCXeqEi34/bWJFqd8m/W8dskdGDoud3uE
         syhLIEcxQs2PRgQ/5z/ToKSDnZ7IeeJ+CMJN7B2Dw8hSLX0hwqQel3QWWozjiJuxqTNv
         b6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEj25auNRfoFs7fGBIclA3iB7k0sYk51VrLB+0yDItQ=;
        b=M4OXUahhecWxoqzIQWmu9o3qgszgU0Br4I/KHSgorJRIIinJcg5s7LDjf+w+RzWoFA
         gBDyLJbHZGxdStmHo5OgnFJPlvvOAHzt5nHV2PoTFpn9eessx7rhtSuJqna9Cl/Knh/+
         4EVXa4U2lnnagCudNfjyH+p8Bz6iqta+oNn02SrXTUKORpfzD483OF4HbTMiQdEVVVaf
         +kKtCATHY7HCLceftSfWQ3eynLYVwmQExbwXNP3B+LBxO5kYjddBAxAcOVuDB0HFa4jL
         Z07OZ4oC3lAlEalhsc0yOGGu+jefSlQA80jDzH9HtzGQQuxELlSQ/wW6lny0GIX4t3/o
         qTuQ==
X-Gm-Message-State: AOAM533SY//T00qDBlzXZ8RTPBmn07AYv0DCa5F59hO8+iUB1lvLAHlN
        YEpRXkAwI27B0jQfcAB+jjzAmg==
X-Google-Smtp-Source: ABdhPJydetN/XWpZLUARm5JZNKin7Bw37YYgSrC6SDL1wVD+gXWstu8ytCYfVDP6eeUAs+6wzoHMjQ==
X-Received: by 2002:a05:6830:c3:: with SMTP id x3mr4862450oto.235.1599952193178;
        Sat, 12 Sep 2020 16:09:53 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id t84sm994652oif.32.2020.09.12.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 16:09:52 -0700 (PDT)
Date:   Sat, 12 Sep 2020 18:09:50 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, swboyd@chromium.org,
        Akash Asthana <akashast@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Don't wait to start 1st transfer if
 transmitting
Message-ID: <20200912230950.GD3715@yoga>
References: <20200912111716.1.Ied5e843fad0d6b733a1fb8bcfb364dd2fa889eb3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912111716.1.Ied5e843fad0d6b733a1fb8bcfb364dd2fa889eb3@changeid>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat 12 Sep 13:17 CDT 2020, Douglas Anderson wrote:

> If we're sending bytes over SPI, we know the FIFO is empty at the
> start of the transfer.  There's no reason to wait for the interrupt
> telling us to start--we can just start right away.  Then if we
> transmit everything in one swell foop we don't even need to bother
> listening for TX interrupts.
> 
> In a test of "flashrom -p ec -r /tmp/foo.bin" interrupts were reduced
> from ~30560 to ~29730, about a 3% savings.
> 
> This patch looks bigger than it is because I moved a few functions
> rather than adding a forward declaration.  The only actual change to
> geni_spi_handle_tx() was to make it return a bool indicating if there
> is more to tx.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/spi/spi-geni-qcom.c | 167 +++++++++++++++++++-----------------
>  1 file changed, 86 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 0dc3f4c55b0b..49c9eb870755 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -326,6 +326,88 @@ static int spi_geni_init(struct spi_geni_master *mas)
>  	return 0;
>  }
>  
> +static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
> +{
> +	/*
> +	 * Calculate how many bytes we'll put in each FIFO word.  If the
> +	 * transfer words don't pack cleanly into a FIFO word we'll just put
> +	 * one transfer word in each FIFO word.  If they do pack we'll pack 'em.
> +	 */
> +	if (mas->fifo_width_bits % mas->cur_bits_per_word)
> +		return roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_word,
> +						       BITS_PER_BYTE));
> +
> +	return mas->fifo_width_bits / BITS_PER_BYTE;
> +}
> +
> +static bool geni_spi_handle_tx(struct spi_geni_master *mas)
> +{
> +	struct geni_se *se = &mas->se;
> +	unsigned int max_bytes;
> +	const u8 *tx_buf;
> +	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
> +	unsigned int i = 0;
> +
> +	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
> +	if (mas->tx_rem_bytes < max_bytes)
> +		max_bytes = mas->tx_rem_bytes;
> +
> +	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
> +	while (i < max_bytes) {
> +		unsigned int j;
> +		unsigned int bytes_to_write;
> +		u32 fifo_word = 0;
> +		u8 *fifo_byte = (u8 *)&fifo_word;
> +
> +		bytes_to_write = min(bytes_per_fifo_word, max_bytes - i);
> +		for (j = 0; j < bytes_to_write; j++)
> +			fifo_byte[j] = tx_buf[i++];
> +		iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
> +	}
> +	mas->tx_rem_bytes -= max_bytes;
> +	if (!mas->tx_rem_bytes) {
> +		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static void geni_spi_handle_rx(struct spi_geni_master *mas)
> +{
> +	struct geni_se *se = &mas->se;
> +	u32 rx_fifo_status;
> +	unsigned int rx_bytes;
> +	unsigned int rx_last_byte_valid;
> +	u8 *rx_buf;
> +	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
> +	unsigned int i = 0;
> +
> +	rx_fifo_status = readl(se->base + SE_GENI_RX_FIFO_STATUS);
> +	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * bytes_per_fifo_word;
> +	if (rx_fifo_status & RX_LAST) {
> +		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
> +		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
> +		if (rx_last_byte_valid && rx_last_byte_valid < 4)
> +			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
> +	}
> +	if (mas->rx_rem_bytes < rx_bytes)
> +		rx_bytes = mas->rx_rem_bytes;
> +
> +	rx_buf = mas->cur_xfer->rx_buf + mas->cur_xfer->len - mas->rx_rem_bytes;
> +	while (i < rx_bytes) {
> +		u32 fifo_word = 0;
> +		u8 *fifo_byte = (u8 *)&fifo_word;
> +		unsigned int bytes_to_read;
> +		unsigned int j;
> +
> +		bytes_to_read = min(bytes_per_fifo_word, rx_bytes - i);
> +		ioread32_rep(se->base + SE_GENI_RX_FIFOn, &fifo_word, 1);
> +		for (j = 0; j < bytes_to_read; j++)
> +			rx_buf[i++] = fifo_byte[j];
> +	}
> +	mas->rx_rem_bytes -= rx_bytes;
> +}
> +
>  static void setup_fifo_xfer(struct spi_transfer *xfer,
>  				struct spi_geni_master *mas,
>  				u16 mode, struct spi_master *spi)
> @@ -398,8 +480,10 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>  	 * setting up GENI SE engine, as driver starts data transfer
>  	 * for the watermark interrupt.
>  	 */
> -	if (m_cmd & SPI_TX_ONLY)
> -		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
> +	if (m_cmd & SPI_TX_ONLY) {
> +		if (geni_spi_handle_tx(mas))
> +			writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
> +	}
>  	spin_unlock_irq(&mas->lock);
>  }
>  
> @@ -417,85 +501,6 @@ static int spi_geni_transfer_one(struct spi_master *spi,
>  	return 1;
>  }
>  
> -static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
> -{
> -	/*
> -	 * Calculate how many bytes we'll put in each FIFO word.  If the
> -	 * transfer words don't pack cleanly into a FIFO word we'll just put
> -	 * one transfer word in each FIFO word.  If they do pack we'll pack 'em.
> -	 */
> -	if (mas->fifo_width_bits % mas->cur_bits_per_word)
> -		return roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_word,
> -						       BITS_PER_BYTE));
> -
> -	return mas->fifo_width_bits / BITS_PER_BYTE;
> -}
> -
> -static void geni_spi_handle_tx(struct spi_geni_master *mas)
> -{
> -	struct geni_se *se = &mas->se;
> -	unsigned int max_bytes;
> -	const u8 *tx_buf;
> -	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
> -	unsigned int i = 0;
> -
> -	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
> -	if (mas->tx_rem_bytes < max_bytes)
> -		max_bytes = mas->tx_rem_bytes;
> -
> -	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
> -	while (i < max_bytes) {
> -		unsigned int j;
> -		unsigned int bytes_to_write;
> -		u32 fifo_word = 0;
> -		u8 *fifo_byte = (u8 *)&fifo_word;
> -
> -		bytes_to_write = min(bytes_per_fifo_word, max_bytes - i);
> -		for (j = 0; j < bytes_to_write; j++)
> -			fifo_byte[j] = tx_buf[i++];
> -		iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
> -	}
> -	mas->tx_rem_bytes -= max_bytes;
> -	if (!mas->tx_rem_bytes)
> -		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> -}
> -
> -static void geni_spi_handle_rx(struct spi_geni_master *mas)
> -{
> -	struct geni_se *se = &mas->se;
> -	u32 rx_fifo_status;
> -	unsigned int rx_bytes;
> -	unsigned int rx_last_byte_valid;
> -	u8 *rx_buf;
> -	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
> -	unsigned int i = 0;
> -
> -	rx_fifo_status = readl(se->base + SE_GENI_RX_FIFO_STATUS);
> -	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * bytes_per_fifo_word;
> -	if (rx_fifo_status & RX_LAST) {
> -		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
> -		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
> -		if (rx_last_byte_valid && rx_last_byte_valid < 4)
> -			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
> -	}
> -	if (mas->rx_rem_bytes < rx_bytes)
> -		rx_bytes = mas->rx_rem_bytes;
> -
> -	rx_buf = mas->cur_xfer->rx_buf + mas->cur_xfer->len - mas->rx_rem_bytes;
> -	while (i < rx_bytes) {
> -		u32 fifo_word = 0;
> -		u8 *fifo_byte = (u8 *)&fifo_word;
> -		unsigned int bytes_to_read;
> -		unsigned int j;
> -
> -		bytes_to_read = min(bytes_per_fifo_word, rx_bytes - i);
> -		ioread32_rep(se->base + SE_GENI_RX_FIFOn, &fifo_word, 1);
> -		for (j = 0; j < bytes_to_read; j++)
> -			rx_buf[i++] = fifo_byte[j];
> -	}
> -	mas->rx_rem_bytes -= rx_bytes;
> -}
> -
>  static irqreturn_t geni_spi_isr(int irq, void *data)
>  {
>  	struct spi_master *spi = data;
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
