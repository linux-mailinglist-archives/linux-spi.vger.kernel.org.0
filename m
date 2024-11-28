Return-Path: <linux-spi+bounces-5861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B139DB930
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 15:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C11639D1
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5F1AA7AF;
	Thu, 28 Nov 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXjsJq5v"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56131AA1FE
	for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802781; cv=none; b=RjAWJQKfOzjbX5Xmr2IL7atfK8DzlkW+HgWcA/Pa1KrCNLd9szswkhlxE63EqTrOyPVo/1sITZXPSB5KeBfq3CP41k6HTpLR6wG75mXOn9RPhjsLypGdmpXDToGjVvhvkDo/XVIizskeXrABJcjMH4n9xCNLE19qjHuDiFq15DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802781; c=relaxed/simple;
	bh=8u4WHlHlXdoHUtL7x7iWsPFH1aFzthA492+VfAh+1hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVaxo7DrbKDbZds0MKkbVUZxLSLaBvOT202fIxteWy46hBt6fxb4LbLBYWSgGCetnTUbUrmSegO0hS5PenBIAJ4Rv89hLu8WKJh3LOk2MamERPqNrdJxyCRsr/4+bSgm+ccF6sITwIO0wlYC1kXaaprWtWfNjWQVIp2YWM3XqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dXjsJq5v; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df63230d0so859643e87.3
        for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2024 06:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732802778; x=1733407578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/o2zy7i5114Efr8+iIYf65CIfVuVv3coOHufvDEg/14=;
        b=dXjsJq5vgM8Pbww0oKbCMkIU4GUJU/t0b9FIJBS2UI/cGudHz0+iQUj6Xw4y8uqR+a
         fkKO+6cg5HMBYn0UuxKWMlHPo8JxWICeRQWJcKk0D8J2lEisCIebAANWXZB+p/xj++4v
         BfY1hensvnvI1xLpdFK0uuabJ7x8CWrbcTJ42ryd/UULc+Vi2K2tsaBBR7AoDa3swD61
         +dL6Ks90eVWpOQYDWWojNexNORILRTR6HKUkzPJJLxF+d4SE2lIMQUJ8VfMeGrmKA2sJ
         0E6MTyDOBog8hhrb+E6gnc5orWdE/g4ADU9NAsM4K92i+v4Xs1ssvLHoaidCtvNICvro
         ttEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732802778; x=1733407578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o2zy7i5114Efr8+iIYf65CIfVuVv3coOHufvDEg/14=;
        b=UXh+V/gSfvT87nSWGv1VLLeiY07h8w9i0VU7YfGqWAd0nMUg0T5GGmhdBHxQ4zMRsH
         Vlw8DDWymG/MMrH2u2o1N8xQ4nfE6RxqCzfJWOAcV5HQzf1KOY22nplW32MxE5jQgMAl
         1elrbzIHuboTnUGka9CsQdfswcr6YoXX/f2bM3K1Yl3QOxbsh3t0Xw9KrSF5PHjIPjP3
         09j6EP7cOxdq7AaqAhzJ3iP4pDnqBDohZFUYIkU/9FqHTs3PKEQOsPt42Dxxh4Psx4vm
         iVW30zR1qDrm24gOa3adyfPJqlzasP4gySNV3x0V1oGETz36XPsBnRX5eyDlSp1eqx5Z
         Is2g==
X-Forwarded-Encrypted: i=1; AJvYcCWDOF4gRDIVE7qwFC1Tq7WAZAmBPEYJps8/EBV4BSD/HpUNjDlCZThEdi0KSQDPvGboiYH+TsCDEkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4LWMvwYjjHdnxkuEM2AD3egDwbv9sOGF3e6IerFFu0acayNE
	iMWyWvk/QmqHLEfoS3SEgHb+bshM+pPtv2wIzPTe914VHY5vvIv1uxi2/8LZYRQ=
X-Gm-Gg: ASbGncsMizg/pb6DKEJgMmP0QkkZ3mWvJi//MUWwabOEoioSlWdyCKTtMlWJsfOOqt1
	bt9W3+DbasSw8wC1ACPyyFVtF4cG7Le37HIhLUlASF4G3TbYsF6oBvQ17BGBruOTdXlgWJiJaWF
	+DhNs28ZTRVVGeIHfGVoX4g7wxQAhNI+h97bWgoWw7lSvZc9rTMlben7K5ZXZ4hx8OWYRfLAkF9
	EjPxC7GUZPHArweBE0d+OiDmgXC9sfBgdGYnQhGhzgaX+s8KJNX7TICO4zzr3URfzJHWIn3k4xs
	vUhoh+/tRPF9OK9+1I6dqSu8HeD0EQ==
X-Google-Smtp-Source: AGHT+IFsOdfp2e1GEmTXUNNuiA5M1HdtsT/qwpeAjD8lPPqRXA9Imbs3wJner1XQ5fKID4zal6nk5A==
X-Received: by 2002:a05:6512:3c89:b0:53d:a2cb:349e with SMTP id 2adb3069b0e04-53df00c5ebamr4575727e87.4.1732802777846;
        Thu, 28 Nov 2024 06:06:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f1a7sm183496e87.165.2024.11.28.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:06:17 -0800 (PST)
Date: Thu, 28 Nov 2024 16:06:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Add immediate DMA support
Message-ID: <dou77hbrpdqsdlzx3ymco6fgbbmimimt6rrzzezghzmc3a2hle@fgdnpbmg6xsb>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-3-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128133351.24593-3-quic_jseerapu@quicinc.com>

On Thu, Nov 28, 2024 at 07:03:51PM +0530, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.
> 
> QCOM GPI DMA hardware supports an immediate DMA feature for data
> up to 8 bytes, storing the data directly in the DMA TRE buffer
> instead of the DMA buffer address. This enhancement enables faster
> SPI data transfers.
> 
> This optimization reduces the average transfer time from 25 us to
> 16 us for a single SPI transfer of 8 bytes length, with a clock
> frequency of 50 MHz.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 
> v1 -> v2:
>    - Moved the spi changes as patch2.
> 
>  drivers/spi/spi-geni-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 768d7482102a..53c8f6b7f3c5 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -472,11 +472,18 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>  		mas->cur_speed_hz = xfer->speed_hz;
>  	}
>  
> +	/*
> +	 * Set QCOM_GPI_IMMEDIATE_DMA flag if transfer length up to 8 bytes.
> +	 */
>  	if (xfer->tx_buf && xfer->rx_buf) {
>  		peripheral.cmd = SPI_DUPLEX;
> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>  	} else if (xfer->tx_buf) {
>  		peripheral.cmd = SPI_TX;
>  		peripheral.rx_len = 0;
> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;

NAK. Please finish discussions in the previous iteration before posting
new revision. Sending your responses together with sending next
iteration is a bad practice and is frowned upon (unless one agrees to
all the comments).

There was an open question here and your answer doesn't sound convincing
enough. Please continue discussion in v1.

>  	} else if (xfer->rx_buf) {
>  		peripheral.cmd = SPI_RX;
>  		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

