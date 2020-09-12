Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669D267CC1
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 00:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgILWys (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 18:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgILWyp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 18:54:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349BC061573
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 15:54:44 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g96so11517845otb.12
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OMKklbN2lN6kWblqLp/KhqeIKTNslngE7aod6/EqkYU=;
        b=BXnhs5CgD7Qi0bV003nPQQzi2g0RSJU+U1mYiNoXq1BisWvFct3wAMcEHNd7RbyErm
         jdXkCPRMft+mhPfXMCRkzwF+yWYzRo4SYFh7Jz9jt+c82ek0sheOziLgDKz35okSoyyu
         zNZkMRdmmMUTl6OKS0XqDhrEz42U0Wg/SkX/TKIZD4voxNTrQoW9mjhilyZBWfvf6j3i
         q7xTIbDrrtvIbmtRKk/+N9R8tfVqq+7tToYSbt7eBvt3kLHzdvYRz1xg3KJmycIWRPeB
         PIeor2yVS4ZR8OJRgP1tIs+yhotJ5SJcA57eKcRdzqbnKE1nKigebdpkxAczI44p+730
         O1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OMKklbN2lN6kWblqLp/KhqeIKTNslngE7aod6/EqkYU=;
        b=dqmqaVw2YhjuVMnuw1vKtZEcC52fRVOcfpUKV5iiQCw9tuHM+JMMw4TVm2bYDpStK6
         y3sM3CYYqWdsk9FvFPpVq6BsGGmYbpd7O4MjGQaCYuyz02w11OstNg848gkzz+yl1gbS
         GvYN4LBB5Rehcdw7TyXyYHdVGw8aTmrBycwizY9Dbqef7aAXmZJb8IkLL+V4OiBQQyX4
         9rdkjsMZQGMQDOnOSv++lCY9jttPSmAWxigfYKVlCaVTX4v99FgLph73JfKvjV0JEHE8
         sQPbu6cS4VQbutOPcjSPi6YLwCNvHqIOgYhJx2hpCwqBULZmIcsW295PO8OKZm9tp6XR
         ASUA==
X-Gm-Message-State: AOAM530/oOC3UGvqD1OBjLu3miD4+hvppZFuhDbPqmSqWXVSV7sEBpHk
        sBPpdoLpEqsUy8EOoFEJ7PplIw==
X-Google-Smtp-Source: ABdhPJzzH8/SJznN9BD+Ma54S3fyH71aziEkswAQB/2ch5l2Blw054vnEiqnttpfgI8XjDgypypaSA==
X-Received: by 2002:a9d:66d4:: with SMTP id t20mr4850145otm.133.1599951283767;
        Sat, 12 Sep 2020 15:54:43 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id d26sm1025568otl.10.2020.09.12.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 15:54:43 -0700 (PDT)
Date:   Sat, 12 Sep 2020 17:54:40 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: spi-geni-qcom: Slightly optimize setup of
 bidirectional xfters
Message-ID: <20200912225440.GB3715@yoga>
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
 <20200912140730.3.Ided778fb4cd078e36c6b240d1b279cd7a534a313@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912140730.3.Ided778fb4cd078e36c6b240d1b279cd7a534a313@changeid>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat 12 Sep 16:08 CDT 2020, Douglas Anderson wrote:

> When setting up a bidirectional transfer we need to program both the
> TX and RX lengths.  We don't need a memory barrier between those two
> writes.  Factor out the __iowmb() and use writel_relaxed().  This
> saves a fraction of a microsecond of setup overhead on bidirectional
> transfers.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/spi/spi-geni-qcom.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 92d88bf85a90..6c7e12b68bf0 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -376,15 +376,22 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>  	len &= TRANS_LEN_MSK;
>  
>  	mas->cur_xfer = xfer;
> +
> +	/*
> +	 * Factor out the __iowmb() so that we can use writel_relaxed() for
> +	 * both writes below and thus only incur the overhead once even if
> +	 * we execute both of them.
> +	 */

How many passes through this function do we have to take before saving
the amount of time it took me to read this comment?

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +	__iowmb();
> +
>  	if (xfer->tx_buf) {
>  		m_cmd |= SPI_TX_ONLY;
>  		mas->tx_rem_bytes = xfer->len;
> -		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
> +		writel_relaxed(len, se->base + SE_SPI_TX_TRANS_LEN);
>  	}
> -
>  	if (xfer->rx_buf) {
>  		m_cmd |= SPI_RX_ONLY;
> -		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
> +		writel_relaxed(len, se->base + SE_SPI_RX_TRANS_LEN);
>  		mas->rx_rem_bytes = xfer->len;
>  	}
>  
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
