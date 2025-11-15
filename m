Return-Path: <linux-spi+bounces-11233-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D46C6073C
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 15:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112FD3BFCFF
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9312F530A;
	Sat, 15 Nov 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX52ts+b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9572FD671
	for <linux-spi@vger.kernel.org>; Sat, 15 Nov 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763216117; cv=none; b=YK5sRXrIxXFRjvBE6QoMZnsmG5gOH12KhBD+tGl8cASyyWh11G/wTw+ISVWoLmUOiLE80bxqPJWCCTQw/+SjciBKXfyKI/oUMsT7FrnZZLM/XruVGYaNrqBKwrddcy3eYX2dv+MrJcuXuyyR++Kh82Q31JA/GcBexzLvdFiNGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763216117; c=relaxed/simple;
	bh=ImD59od9MeluZcpbFLndDPRpzNKsdKpQFwhjPxrMgrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXk8DbRYqJCtOef8A8N0/QIPYsjhsRqdTu2d6wtHr654iWRPVdBZa//NMoMISBLUQ/fvGoCd2LtB+CRgV/z+aysqeEkoyfugYZJuo8yvFWi+FgRtjxZsCVlTzUHd00YkYrs8kvjJmNQ4e+SydUXwZvGuYf34WVHIaS1B4M00exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX52ts+b; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc7665af914so1012955a12.0
        for <linux-spi@vger.kernel.org>; Sat, 15 Nov 2025 06:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763216115; x=1763820915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AglVNju5F5ASm8eRnDxFhe8j1E3mGA6E/8/xaKJ22q8=;
        b=ZX52ts+bGy8zf1rqF3/Lgr6aUytD7vrLqnXPF5hJdi3JFK1sJbpjMQPQmQ7HGZpWdA
         lokCislSC+qxRfoHIDCjxF0f0HAUBeIxfnRh3CFEpd999TK2xEcEn+aXWVA0ZelAM8Na
         b1fvniOjaoFOQDrzRYfbNrh0wd7+y60mFvvUgAotZQsJjuKo5R64YKJVBTIohl9JkUjp
         f6s+gI7SctXoAxQrtNpDEVWWdYX11uBhEaERnJU5L7HaijV2Gnp1xqUk8ib0eJvkS1nt
         Jcvk+V/cZJb2LRqSeBAqiLsR5nyCCzJvt0wR6yiQXhIjDkryMNdEtMotwkg558Pc9wGV
         4DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763216115; x=1763820915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AglVNju5F5ASm8eRnDxFhe8j1E3mGA6E/8/xaKJ22q8=;
        b=RTRLLY8YavhWO3c9RC70CfL5ZW/v5hQXNMI5DEkYi6W+hV7+RXOgi560il1o2xbNLw
         0sdNzFlnh0AMDxpD1aDjogyFmYnECyGoVprP71p757Ye0ut14poIAJnSPu5bt+LZzL41
         6gczm+wXi5H0SF/6gLc38SNIyOhc4g77ajMdb1KKksOihIbcRyPVQ6K7N4yytHoD01eC
         GQ71EGs3DinDRMDFdU94WxButG8f6yC7RtZAEK+yVnSWgZb0X5y2uUyRPWzbuuyKOP1O
         wPfCEV3b4BasnDCQTtpT2dfuPSwx47Z584E+HI0KMfrbs99BoGqMBC5ilXEWs88szjjD
         qIzw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1KyMJErFegrgwNA4ZNuNwePgxuOupTuDRoYDNj2UHQYoFRyT8h+VnpkF1EAbBUHvs+2M85PVCXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6b06IIyhfPON1OejI+RDGvWXGT3/sxOoyw8KdkkNM2y+l4/5
	/pXuXEaIqr1acDTiBVCbYttpaieAxIYp2kgQtJuGri1Kv5AD4Xa8YgyL
X-Gm-Gg: ASbGncuZGVP37NVytjHiNseyV0N9RATZc9fXmvsdmY/LRKZa7Bhc5kx0mdRhHhB2tXw
	zCaeISGnpk4CYxW3tQM01Y90nwSPbJ2L/7oOIQnQEVPmCfEEv69rvzvO0GHwKc+9pxNWKEEEOMl
	TdCzc9r6rTpHNlYGIZPUiS9MDe/wfcYNIMo97M7lKC+oON8GiN0s8CRL1HqKA+x1h3h78dn/q/G
	UXJ9LAdOvG0fOq4MRj9G2+wBZDGnFdpH3ovhIGJfB0IMMhON108FFvCstwMFZQRF3SUZ48zWule
	HZH0FTtau32n5epY4iaUrabdWMFvmFzNmXQUOYVGMRw7SP3EEI034qp9DXY3Od1dlUYLW60NE94
	63/BsEgI9l+GYmZ955dJXqvLWVSgJsEaesrPljPvr2UZCn2TfqcLhs9aRKuD9R0mIlXqCPEahJ5
	3Z+gPkqTH2OleMz6ry6jd6
X-Google-Smtp-Source: AGHT+IFKAiVMACqWqHRdvMgpkXEzHiVdm+GUjObMloIFV/+a55GT2gp8hKLsLhFfO3WyMZdmDKvNRA==
X-Received: by 2002:a05:7022:ff41:b0:11a:51a8:ec9 with SMTP id a92af1059eb24-11b41703d71mr3141025c88.29.1763216115074;
        Sat, 15 Nov 2025 06:15:15 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11b80fd6790sm7353512c88.10.2025.11.15.06.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 06:15:14 -0800 (PST)
Date: Sat, 15 Nov 2025 11:16:34 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
Message-ID: <aRiLQn4F9U4WrWaF@debian-BULLSEYE-live-builder-AMD64>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>
 <aRNSc1GEz0UNx17i@debian-BULLSEYE-live-builder-AMD64>
 <0e59d92f-7b3c-4ff6-b3ad-7fae2ded9b77@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e59d92f-7b3c-4ff6-b3ad-7fae2ded9b77@baylibre.com>

On 11/12, David Lechner wrote:
> On 11/11/25 9:12 AM, Marcelo Schmitt wrote:
> > Hi David,
> > 
> > The updates to spi-engine driver look good.
> > Only one comment about what happens if we have conflicting bus modes for the
> > offload case. Just to check I'm getting how this is working.
> > 
> 
> ...
> 
> >> @@ -284,6 +316,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
> >>  			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
> >>  			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
> >>  		}
> >> +
> >> +		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
> >> +		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
> >> +			switch (xfer->multi_bus_mode) {
> >> +			case SPI_MULTI_BUS_MODE_SINGLE:
> >> +			case SPI_MULTI_BUS_MODE_STRIPE:
> >> +				break;
> >> +			default:
> >> +				/* Other modes, like mirror not supported */
> >> +				return -EINVAL;
> >> +			}
> >> +
> >> +			/* If all xfers have the same multi-bus mode, we can optimize. */
> >> +			if (multi_bus_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
> >> +				multi_bus_mode = xfer->multi_bus_mode;
> >> +			else if (multi_bus_mode != xfer->multi_bus_mode)
> >> +				multi_bus_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
> > 
> > Here we check all xfers have the same multi-bus mode and keep the mode that has
> > been set. Otherwise, we set this conflicting mode and the intent is to generate
> > SDI and SDO mask commands on demand on spi_engine_precompile_message(). OTOH,
> 
> s/spi_engine_precompile_message/spi_engine_compile_message/
> 
> Probably just a typo, but just to be clear, the "on demand" bit happens in the
> compile function rather than precompile.

Yes, I wanted to say spi_engine_compile_message() but miss pasted the other when
replying.

> 
> > if all xfers have the same multi-bus mode, we can add just one pair of SDI/SDO
> > mask commands in spi_engine_trigger_enable() and one pair latter in
> > spi_engine_trigger_disable(). I guess this is the optimization mentioned in the
> > comment.
> > 
> Your understanding is correct.

Awesome. Thanks for clarifying that out.

