Return-Path: <linux-spi+bounces-7799-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9F2AA1062
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3EF1B65B03
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24116221554;
	Tue, 29 Apr 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xq96v4dV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F40221553
	for <linux-spi@vger.kernel.org>; Tue, 29 Apr 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940303; cv=none; b=ZUhFX11CoJx3etzWwQbvoRWW1YescrsjcdyFEPFE64Y+O/7BHpi/WEiS97TylSVsRI7SB7cdZyaUaMD7Arxe9pSRL5Qaa1FXuIPncGVzHDyONLMeL4D6ZDn604MBhiL8Qmg8ggfv5/E3xmV9O4TUZYDhcneNGutXnGIoGgzSKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940303; c=relaxed/simple;
	bh=ldKd10krlA78evFCxJgwnrK37951xs9UWGwck0m+pDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oThFJsJIwIAQeYxzn3MddJK4Hcna5Wrnz2EPil8ETM1GbPkQdNOJlxIZIkRRzKBrNpPU36nWOt6M08PfG2vgostHSI/SACnkK19+xRGijSbYo0FYUAiypM28SadG3teEgd/PSBQT7kbO/b8HQ8XaSvgkjRwnPAFXFnLH77nSeso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xq96v4dV; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72ecb4d9a10so3696565a34.3
        for <linux-spi@vger.kernel.org>; Tue, 29 Apr 2025 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745940299; x=1746545099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPAzV2ZOk26TsSDij37Rr7O1oaKM6YOsipFaIWd8kEc=;
        b=xq96v4dVhAcOMKnQWPBm3vfBjJpDeAJYRZFtQ8F23goEwKCyo5sBNY7s4rAkgRsNve
         M6O3QA9XgBGdZ8EvYevu+ljCvpqHAen9znJ0e/gMOdrwdonlGlAqvFLIgFSQReARlAeQ
         +BxeVd/hDO2eyUZZ6LW9CDsMa6pXjtn9YBYblAQ8sNb9XqAowat/JxisVgcI8Bx+H30u
         KijHbcVPKg945m2qnFZshQe34buxs0VaIOIkfc0EzDWn6ExQ/w/MCaD3eg35VX910f5N
         h3w6vkawr4Jnteks1HAf2pnAKlQe6ertMTQGXZyi0OmduYRZUjIpEITe3Jfey1udGO1k
         1Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745940299; x=1746545099;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPAzV2ZOk26TsSDij37Rr7O1oaKM6YOsipFaIWd8kEc=;
        b=APXJEMBwPZ83G1lNK2EGnmht0IXcWPHsMiVVAyY1ge9D+BYM9OuB39Wz15SbEPyTtt
         RJ6ONiYxYKNYllAvW9kVlZGicLZYizY55Xn2vlsOk0ii76A+qJ1o8fze5WnAiMAjGuQQ
         GeSYVxEMnlft320EZ5GTOyNlPecLN3Cm1InAu7w3LUa/iawIJRELJ8SaIVxsA+jJdWU8
         ffh5brRcMB2VhwMWnz+KxYSNnCEp8vbD4TSEEcqgwUhKbxb2UttVKuAHZLGj2jb5D5LQ
         lkhASe7tz3TkxWZeLgsI4CTFxAdoO2/keREf2H50xZxW8qXdTPC84tgU/y2Hnlrqf7g8
         n5jQ==
X-Gm-Message-State: AOJu0YzYRsIBZg/kUd3EsC6vUeZR63PZGh7CY2lzkrPqGj4j+Npo+QRB
	eq+BMKDF7mtVcHBs0bZSjEy09iqSCsJ0yLJ66wJP8SPjLqcVVt0RhgKAd6uN00c=
X-Gm-Gg: ASbGnctiB288l9CUU4M0c6u3jrd+kIw6US6NmhnERubC87Oj7L5krk9eSnIRV9cTg3U
	smTREROHRBvbbHUVqTkUUcyecFiWxpp9/kVKzkWAt9yne8miDNbsw/yi8TN+XkttgS7BuhshTb1
	eJ8TdD5D6e4JUWMm4gSqCtmQf7HrWb5QlcTvvTMk5JtmHqSlQo8FztNi7o60+3w749UWzq2QVT2
	25090RLI51nG/cQAx6wjHF74CRzMAB92XuHCL81spNjEXdD06awbrxrAqQRtERQ8zgx+QydIIwJ
	Q28iJKEnBn2gHu+rwRnFVI/pQgLFyg+Vk9dyFYJBp24BQsgi7UJKyP7vO0QycZ9KL3UZt9BoeH7
	/okXPv6acJ82w+WELtw==
X-Google-Smtp-Source: AGHT+IHV8z5DUUnExvDSgZL6FaXo2YhcZKSNUqk85shvOA8OWZ08jAI2WXlheo2Tot5Jrj3K8B5uww==
X-Received: by 2002:a05:6830:6186:b0:72f:ff7b:6a6 with SMTP id 46e09a7af769-7308a52b7bfmr2010072a34.16.1745940299540;
        Tue, 29 Apr 2025 08:24:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b312566sm320171a34.59.2025.04.29.08.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 08:24:59 -0700 (PDT)
Message-ID: <f68231bc-6546-4eaf-a8b2-fc31add33a1f@baylibre.com>
Date: Tue, 29 Apr 2025 10:24:57 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: axi-spi-engine: don't repeat mode config for
 offload
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
 <20250428-adi-main-v1-2-4b8a1b88a212@baylibre.com>
 <ca7708856683596894b5fb9cfd6caa164535a50a.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <ca7708856683596894b5fb9cfd6caa164535a50a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/29/25 4:08 AM, Nuno Sá wrote:
> Hi David,
> 
> The whole series LGTM but I do have a small concern (maybe an hypothetical one)
> in this one...
> 
> 
> On Mon, 2025-04-28 at 15:58 -0500, David Lechner wrote:


...

>> +
>> +	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
>> +		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>> +
>> +	writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
>> +					    priv->spi_mode_config),
>> +		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>> +
>> +	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
>> +		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>> +
> 
> I would assume that SPI_ENGINE_CMD_SYNC(0) + SPI_ENGINE_CMD_SYNC(1) should be
> executed in order by the core? I think all this relaxed API's don't give any
> guarantee about store completion so, in theory, we could have SYNC(0) after
> SYNC(1). Even the full barrier variants don't guarantee this I believe [1].
> There's ioremap_np() variant but likely not supported in many platforms. Doing a
> read() before SYNC(1) should be all we need to guarantee proper ordering here.
> 
> Or maybe this is all theoretical and not an issue on the platforms this driver
> is supported but meh, just raising the possibility.
> 
> 
> [1]: https://elixir.bootlin.com/linux/v6.12-rc6/source/Documentation/driver-api/device-io.rst#L299
> 

The way I am reading this, relaxed isn't "no barriers", just "weaker barriers".
Quoting from the linked doc:

	On architectures that require an expensive barrier for serializing
	against DMA, these “relaxed” versions of the MMIO accessors only
	serialize against each other, but contain a less expensive barrier
	operation.

So that sounds like we should not have a problem to me. (And if there is a
problem, then it would affect other parts of the driver, like when we load
the fifos with tx data in a loop.)


