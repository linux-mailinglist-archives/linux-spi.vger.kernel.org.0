Return-Path: <linux-spi+bounces-12368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEE5D1F59E
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 15:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D5C3040659
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E72D6E73;
	Wed, 14 Jan 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIag13BS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D12D3A7B
	for <linux-spi@vger.kernel.org>; Wed, 14 Jan 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400083; cv=none; b=kV1lrr2meAXsEy5Vleqhm5PZkM+C7HFoyCEWm63YSsSggSLs+iViCt0PycltTb8ZbwFi6h7vM04zKo48n7jdVu2Q0+NY0g6p1RxNkYwlT64cbQHHCO1abU8ANNpadyzNt1fRdiSOFyPl7gRwKKAozp8cJcOB+6YhPXsvIFqLlwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400083; c=relaxed/simple;
	bh=qrtUkzUvAu/GybEKdOHSy5+pyZma5Pf7dEV9LqKAr2s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF68aS3qlYIqhVmiHTzroAelEDYoBn/xVoreL/dIUkDmaC67B6OHnWFzJ7/ncCwcCTX8fNRUQUkKnIsy9fpadTCJjT7AeBfzG3tXwAV/10HX0B7RWDoo4Te2sC679bs+w7kXpy+Jhas3bkG2QV1b9yl3zvKYA20WDRAQ0vTRu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIag13BS; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c537a42b53so28515185a.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Jan 2026 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400081; x=1769004881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngcbeZxEgHt+JNZ+WGmatkfACIVP9YV9ttrHXNi6YxE=;
        b=HIag13BS41+0HEm+oowtl8xM9GWnAxFrlxF80AQu5wJBeo0mcOxvVGr3avLxbqvejz
         2e1YAdhGJQX8GrDUKccN01CJtEfXcmji3yhgTtgVnO6C3If/EXJy7k8IBhUkBVNsj4Fn
         GY4J6UMYjdUEVymGvh+Jxc/DdsfUqd04y9hRoZyokzMqtUfqhmYcX/sh6q3NBpEo1pBv
         eBrgu/3owA2wXs0mTHu4FNckUgagWmk+NYTOK/v4WPjHSfbgJKFpFnpnWHmSfLpQU0V/
         FCIxfTynz86ay9jXrZ/NkUJTfzM2tfFSbbFshqoRQvMu49n6ttUYBc0nAFi00rc/79xv
         oWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400081; x=1769004881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngcbeZxEgHt+JNZ+WGmatkfACIVP9YV9ttrHXNi6YxE=;
        b=m7896DS8d7K1NSaraXfs+YgWCYke3xfrjHV1XjN9CiemkkNi/rUoXTMmPGTogFtBpU
         J+6KCYt8DSzuiVq2ZMapiSrX+JEMdr/7KL/BnEFagbLZIouf9UqpvghN4MYIjh1fbANm
         UmMyGAcjR2Ha0g675JXOgzJMQh76vIJVOyU5pt6hKzMBwJPKp5SS9pHF7B9QaAGa+oj5
         8dbk+k0ENEzAwCjgUJZwopr1JtgtkMjBg6uoX1o2f9xNcCabiMPcJuHBoT4yzH2nbl/b
         o2LPP8SJpMYMg1IzP1t4p5Nwc44rMFohP8UNa3tSi5DW99krTeJDR6w9OuNuRCBYCkIQ
         7htA==
X-Gm-Message-State: AOJu0YzWsqyf6+dpB5DDY8cbAmf/8EauucEj6oju5Gdnr3auJyHHcoJh
	VwU2rWa5TLnRyGyqKvdunuIyKkoN2LIqhCXcKQFftsrzZcwycNPpXZFu
X-Gm-Gg: AY/fxX5d/7FVzzVci5Ff4/7PAGatFWy3u/++klMRbFj9DJhWM0xegTTxrg/VUKlbcy6
	NDuqTpuSqR9o7FWM8+XPDwuMDQv4dSYSkR+KZCjVHtAFPV4Y5JuFRrf0hzBIw3pjpZM4p+sjRUc
	nFwEUQ1OejEvG0CAr8RIB4Vzzg0IPvJ5qTbB/flA2UQAO8wHokAmRr2Ia5BgJX+wh3rbGdiVGFR
	UAdfg1trnBYBYKOy/nCr72JMhrGYQvGbMUWjlF0soQwfMfbmMPlsp13xQGcW9SXgDDK874frh7Y
	qY0tL9sHmOK16UBhJpjRDHTS2T05QiU1YGzJ29PwRhjAgOwpiNNl96+DfC1acyrYbz2T5XJK9wk
	c5MOR3/5sgB8jVg+4awebWd1PBlHZO2SPBLVf+riRNj/tnSZurwQQldLLtUku8jXRVyyA6wlHG4
	hYhZ0n/hmktOy3FOqbtyuFBdjeP+b8MO37ExtLY/O98+JhUCh7seWDI80UA8Lp+CI4m6jBgxSzu
	g+e
X-Received: by 2002:a05:620a:372a:b0:8c5:2eb9:7be8 with SMTP id af79cd13be357-8c52fb9a133mr375377585a.47.1768400081038;
        Wed, 14 Jan 2026 06:14:41 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cdfb0sm179880536d6.6.2026.01.14.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:14:40 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 14 Jan 2026 14:14:35 +0000
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com, 
	fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	broonie@kernel.org
Cc: linux-spi@vger.kernel.org, michal.simek@amd.com, 
	cix-kernel-upstream@cixtech.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: spi-cadence: supports transmission with
 bits_per_word of 16 and 32
Message-ID: <fu4ujdxwlhyhuwjtsiebje5pyc32rfs52vo2gyy7nay2krkxeh@wpls44xdfgy4>
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
 <20251031073003.3289573-3-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031073003.3289573-3-jun.guo@cixtech.com>

On 25/10/31 03:30PM, Jun Guo wrote:
> The default FIFO data width of the Cadence SPI IP is 8 bits, but
> the hardware supports configurations of 16 bits and 32 bits.
> This patch enhances the driver to support communication with both
> 16-bits and 32-bits FIFO data widths.
> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>

...

> +static inline void cdns_spi_writer(struct cdns_spi *xspi)
> +{
> +	u32 txw = 0;
> +
> +	if (xspi->txbuf && !IS_ALIGNED((uintptr_t)xspi->txbuf, xspi->n_bytes)) {
> +		pr_err("%s: txbuf address is not aligned for %d bytes\n",
> +		       __func__, xspi->n_bytes);
> +		return;
> +	}
> +
> +	if (xspi->txbuf) {
> +		switch (xspi->n_bytes) {
> +		case CDNS_SPI_N_BYTES_U8:
> +			txw = *(u8 *)xspi->txbuf;
> +			break;
> +		case CDNS_SPI_N_BYTES_U16:
> +			txw = *(u16 *)xspi->txbuf;
> +			break;
> +		case CDNS_SPI_N_BYTES_U32:
> +			txw = *(u32 *)xspi->txbuf;
> +			break;
> +		default:
> +			pr_err("%s invalid n_bytes %d\n", __func__,
> +			       xspi->n_bytes);
> +			return;
> +		}
> +		cdns_spi_write(xspi, CDNS_SPI_TXD, txw);
> +		xspi->txbuf = (u8 *)xspi->txbuf + xspi->n_bytes;
> +	}

cdns_spi_write(xspi, CDNS_SPI_TXD, txw) needs to be called regardless of xspi->txbuf.
Otherwise, there will be no clock for the read operation to work.
This is a bug I am seeing on a Zedboard running on 6.19

kind regards,

Rodrigo Alencar

