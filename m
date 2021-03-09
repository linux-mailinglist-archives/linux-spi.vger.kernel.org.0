Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51756331DE3
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 05:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCIE2d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 23:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCIE2N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 23:28:13 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59DDC06175F
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 20:28:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y13so5173413pfr.0
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 20:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+8YOxcfUeJ6df3e8CyV/VT9IvcELWSikbdkoM3b6Ug=;
        b=WPQTHGnSeREz9wSvHz9r2PrjIKMMEsp2yhjGN3B/a/X0/KqBnUNKB/YUejoBWSnPph
         ZAn8jlYWvfHr3LGNSSUXIspLawzHepuruNXmTdqcvG81J++aulzAoyHuQ5RY7PMClzQ9
         RvKxmf9JhuAYeCtd2JLVA+B8+AykXOjYoCrkGEwcJRjd8y89IaTKuXG4Ieo7aZIhremy
         nD0czU60gNDUv92hVYvqxb/8f0H8pg1Ccq43PVnWbeqF8oFoG/dXK1Ebk44IDS4coatb
         Vc3b8v2jgU3hTIC4AztvqPODlan1X18N8QJZSz+Sp8xsussgSNIE0rO4obq/a6jd8Nat
         KOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+8YOxcfUeJ6df3e8CyV/VT9IvcELWSikbdkoM3b6Ug=;
        b=R11Eshg+A6Snsd1khPBJOhDckKvNiATRevszGfRSFk8cZ9/GFjK1pqhTSIkmJplx0s
         qquhJ3bniWOoTpkmpFwk3g8Vbhg8h8U7/l5SKNm3SE9Nz5rALCaV/keja9I7NgCAW8/s
         jZ4o+0adRbvXwtNw8jHULmXfqJLxvhd95kqbyikP3pJScG+NJExpfkB2uNMV05G5nbA3
         OGN3oIqGcJHnSKJ2zrZcO+zANXKXxiiLVEAes7/DzGAblFLSa394hAzVZ65p14pNACt5
         /dFwUe5HCCQrkobzybnV367vCPAesdc1AnjWan8aAALzYdGTqabu+0OZ9V3Fxpi2PFJs
         jNww==
X-Gm-Message-State: AOAM5302r+72iu3eflMCFd7WU6uk8SBxb3A5CNuRdY4ttw1nQEa7Hesw
        NMWYGiqkGeqGYrg4lfTAPdjyeA==
X-Google-Smtp-Source: ABdhPJxLhPHdVshVOVKrFuQWBus/qDOL4qzrr0c6GqxPCA+N0GE32fx4ze30gezz4TNI4bi2Zd3iNg==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr23409013pgl.37.1615264092034;
        Mon, 08 Mar 2021 20:28:12 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id g2sm11719102pfi.28.2021.03.08.20.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 20:28:11 -0800 (PST)
Date:   Tue, 9 Mar 2021 09:58:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com
Subject: Re: [PATCH 06/10] staging: greybus: spilib: use 'spi_delay_to_ns'
 for getting xfer delay
Message-ID: <20210309042809.dgop5dli36z27sj2@vireshk-i7>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
 <20210308145502.1075689-7-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308145502.1075689-7-aardelean@deviqon.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08-03-21, 16:54, Alexandru Ardelean wrote:
> The intent is the removal of the 'delay_usecs' field from the
> spi_transfer struct, as there is a 'delay' field that does the same
> thing.
> 
> The spi_delay_to_ns() can be used to get the transfer delay. It works by
> using the 'delay_usecs' field first (if it is non-zero), and finally
> uses the 'delay' field.
> 
> Since the 'delay_usecs' field is going away, this change makes use of the
> spi_delay_to_ns() function. This also means dividing the return value of
> the function by 1000, to convert it to microseconds.
> To prevent any potential faults when converting to microseconds and since
> the result of spi_delay_to_ns() is int, the delay is being computed in 32
> bits and then clamped between 0 & U16_MAX.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/staging/greybus/spilib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
> index 672d540d3365..30655153df6a 100644
> --- a/drivers/staging/greybus/spilib.c
> +++ b/drivers/staging/greybus/spilib.c
> @@ -245,6 +245,7 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
>  	/* Fill in the transfers array */
>  	xfer = spi->first_xfer;
>  	while (msg->state != GB_SPI_STATE_OP_DONE) {
> +		int xfer_delay;
>  		if (xfer == spi->last_xfer)
>  			xfer_len = spi->last_xfer_size;
>  		else
> @@ -259,7 +260,9 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
>  
>  		gb_xfer->speed_hz = cpu_to_le32(xfer->speed_hz);
>  		gb_xfer->len = cpu_to_le32(xfer_len);
> -		gb_xfer->delay_usecs = cpu_to_le16(xfer->delay_usecs);
> +		xfer_delay = spi_delay_to_ns(&xfer->delay, xfer) / 1000;
> +		xfer_delay = clamp_t(u16, xfer_delay, 0, U16_MAX);
> +		gb_xfer->delay_usecs = cpu_to_le16(xfer_delay);
>  		gb_xfer->cs_change = xfer->cs_change;
>  		gb_xfer->bits_per_word = xfer->bits_per_word;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
