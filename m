Return-Path: <linux-spi+bounces-9828-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C8B3CEDC
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36BDD4E056D
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912332D9EF8;
	Sat, 30 Aug 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pygJbV/c"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE8274B2E
	for <linux-spi@vger.kernel.org>; Sat, 30 Aug 2025 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579689; cv=none; b=P3VqEZjP00erDOJkKU+o4MZyiOzC7lxmUXzPf9IG2C6G5qi58IXGZ7mZ7PylviKNaj1FOliL0LymgTjTza0MY4vfJLh5bmFi4SOM3CdRscbN33x8pMZXUMymgXsT2feYDgHxcwOlOxIevhrVSBVDOhoCqdLg+kS7GrYvcifC3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579689; c=relaxed/simple;
	bh=DD7DefC7ukvmx58D5ApAi7pdjLyBv9rq18lNqvOe6SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jW+MVmnEGyvviRCTbeZ87UIT0CRTBD97kU4TfHkvPeSwp1j43Pt3H0RIdUTOPGetQ/7YKmoWnwvDsQfZodezoshfKfCeRGw8tueQuGFNYh2yGDT6xgurLzDWqxIRfi6VE9DPYiLorOKdeLxQ+p7UyHk678Tn348eitdxHTTWIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pygJbV/c; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74382048b8cso1911106a34.3
        for <linux-spi@vger.kernel.org>; Sat, 30 Aug 2025 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756579686; x=1757184486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5Xj0H0mStsxJLJCOC7FKJU4x7mcdP/yvgXS7VpGPqg=;
        b=pygJbV/cmRCl2gp5is4lbAEo+shZTs+uU/0Tevdv3PB7xhuT8wYLDv7J6q9m/V8usU
         ClzzGE8LwibTPI5XT5bNJmAkEFGBiKpvxg6Qy1LHDUvSuGk5jUfdpp/TUhrZ2LT/1MpS
         6tt7v1nBWWHdib2lbhPMrSTloYPY6Pm4fWDdnDsmOKlDLFdNX14Kslzhc9oSQ683dBYf
         Y6r0FJD+htAbbbu4BrLHoXrV156+9BVat5T2a7YLyqfJ8fB6z421ievhoZ5NQfx3oW8+
         XXSpILOROwL2PifqXS3WP+Jtn4R0AcBywl/hv10IBQRvUHmpLibtPThT9OKGTPeBdZqT
         UryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579686; x=1757184486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Xj0H0mStsxJLJCOC7FKJU4x7mcdP/yvgXS7VpGPqg=;
        b=qt9e4DjSbVTM5sFd5JZhkSbTFBuJ7ApdEp4vCupnA5A+55nrdVan7y9eBiiAU3rYj6
         +FTibwVHsKnAxMB1PPHP3XuZPn9skaOzMLTLAgYIKat+vQm1wOhvifdl7l4p+s4Yp7fV
         YWdoWhUyLd1tRlOTo/q+Av6UaeXyTsWTY17H5zzcKiiWam2zj4+RK8voYFMgOPupLFMm
         Cx/n3/MojB/JaJiurQw2JcAEokc42M1VjQdW8KvslZnbPBU/h3XqH/8kPVxJtWLpCLwN
         gAdRj+SKbx0vM7Lw9pDcPAhKHUVliCGlsHtM+DGSJsNGaopg/ZQjH4v80KUt540AjglZ
         uTaw==
X-Forwarded-Encrypted: i=1; AJvYcCVNadJkcs9lB3HM4IZJ9//9GVVNScaAcmFr/MhCbbYLMbsGF4DMvzKASJ7p+VGdNj0dI0Qx6T/w4Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyP0A5Hl/prL5IXInfInSbZH6R4ykRck7/0Ieakc3FGqedfQP8
	fGAQfVsYILuM7pKBDGEMrQv+7EZRDySh6GW3EbMmL/J8fW7+uTacHT4GFqg+yV35l+s=
X-Gm-Gg: ASbGnctRdU6fKnPhC8BBWv3KMjcklL1FOmHbO+9rH58M5PPfU4f5EG2JUWNd+2LKyld
	WEQgZBOHebLNoEGXQLsl0KNQJ/TkOWcxuAaz4IfYvoqsG2Euz6thNhgnnok6M9pt/T+hgFgnlJY
	4FSyc+sx94pF/BfEAtaLvYBkPwy6/b2HqNls6j9HcW0Z+17m2QWRYL+zGhYdAxWI/Olrm0PoNFa
	Wr4NMMUEXaZwutZJ6nLglxcSRk4218gjO/hf858nRQzD45xHVthXtQGM4R39z11YwGRHuPNzvTI
	vtzrdWT36KE5U4H5ZjvMEWolCAt9xebbTYrM/1KuBr/ehfqTabQI43UIbyA1TWHsoiXQjBY5vdX
	MtsOhJO/s6KyMqRHTIeWgxQ9Zjsa6sbm41Q5mLdb+ImkIjicJtbZ50BAiIVExFS8NTWj/DefCky
	a0TggjAHvM+Q==
X-Google-Smtp-Source: AGHT+IGSev9qbLSBhI0IZugbu8NAy2nFpxdYwCkrkjiUPJ2fDHLmRW1GmCDslyXrxwFppSI9n0uNbQ==
X-Received: by 2002:a05:6808:1889:b0:437:cfa1:73bd with SMTP id 5614622812f47-437f7d03adcmr1220355b6e.22.1756579685636;
        Sat, 30 Aug 2025 11:48:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437ffedd355sm21206b6e.12.2025.08.30.11.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 11:48:04 -0700 (PDT)
Message-ID: <97f20435-e4b9-49c5-ab02-b67a8112f0ee@baylibre.com>
Date: Sat, 30 Aug 2025 13:48:03 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] iio: adc: ad4030: Fix _scale for when oversampling
 is enabled
To: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <f9d40e8deb3d17a41b4fd6ecc1b8ac92275f0078.1756511030.git.marcelo.schmitt@analog.com>
 <20250830194308.32def0e5@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250830194308.32def0e5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/25 1:43 PM, Jonathan Cameron wrote:
> On Fri, 29 Aug 2025 21:40:24 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
>> Previously, the AD4030 driver was using the number of scan realbits for the
>> voltage channel to derive the scale to millivolts. Though, when sample
>> averaging is enabled (oversampling_ratio > 1), the number of scan realbits
>> for the channel is set to 30 and doesn't match the amount of conversion
>> precision bits. Due to that, the calculated channel scale did not correctly
>> scale raw sample data to millivolt units in those cases. Use chip specific
>> precision bits to derive the correct channel _scale on every and all
>> channel configuration.
>>
>> Fixes: dc78e71d7c15 ("iio: adc: ad4030: remove some duplicate code")
>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Hi Marcelo
> 
> I was assuming that when this said 'averaging' it actually meant
> summing (there is a note about using the upper precision bits to get the same
> scaling which is what we'd expect it were simply summing over X samples).
> 
> So given that we don't divide back down to get the original scaling I'm
> not following how this works.

I had the same feeling. I have some hardware I can test later this week.


