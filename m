Return-Path: <linux-spi+bounces-8482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A37AD76B1
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 17:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D476A188C319
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0469B2036EC;
	Thu, 12 Jun 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0uJ5zFI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA6298994
	for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742600; cv=none; b=QzT7uZrnSesxeaCxBx3vwVu2uVsQ/loQpmPP1SpMuhPYWGojIXZpmiLt6hjBzRmqlFf3ZTNGXN8ZBcnctEVq0kUxnH8EUlk4NY+cgFIbXgCE0q3/sL2R8gUADaqP7Wa2K941drzW1w/CGRXuutEUqzYV41LZdiskrzixyOeprpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742600; c=relaxed/simple;
	bh=gfSkNsEDvHrBasjkaxzkBzgE2ArloUcp9iGt4cd2kgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZzPs17L3bBgsZFhkmyoqH1p9p4gYobt7MfhhmUZHuDHygsgU14rBqbMXX1v2xVT2jIcssZbVZsd0hUDZmzCva0HVzrJ6zL0nCX9aI3xDT7FbWxeRwaNV2A4JLkv9u8JQTgfQIWzU25AQ6Mc2Age844JTi3eJNf9UMIE8LyeIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0uJ5zFI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so9296665e9.0
        for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749742597; x=1750347397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ljv00glv7rh1spp86bQ43dOcZbrTy283SQsKA4sfY=;
        b=B0uJ5zFI/qhkH6ZrotjI+p6mYc8oiiN0iJaErTcXODlXLahWjRW1sUH766I928tt/z
         6TzRS5lI8mxv78CmC6F9KIgriOoYPu/ZVDcEHu9ybqWMNKCaenU5i9ubSZgCNgYja0/x
         8AR4ya/sTLRZ0AdummyK8u+Nd6uabmLEs9P8ZCWkgnTi/KbVnTooGFhXvGu6bOsBqJNx
         5wqtjwhYqG7wVW9prTzlHCckaIXzpsSKuhaUZUKlGc8HLwCn0N+KUnT6XalTc8DCJ8sZ
         VAQiievyRPz/qJFb2fR2FPyloJbMoLV1OjXD7F6PNgcR5aPZJwQrSF0QsSvwFBJlBCR8
         GDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749742597; x=1750347397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ljv00glv7rh1spp86bQ43dOcZbrTy283SQsKA4sfY=;
        b=NOCZubnAKL0Py91mDObsMieuSgsbAu7GL6I2xWjsQd48eqaK3/bANRX61n1Pd1br6O
         PI1A4/jI1i4pijrc3Tm/zyl46xB7hIUmowd88/8DuRU8jq0Xit9BGD96gLY7nE1ZNIcZ
         3nZw/WN0SrtfhKJk/myvKT/jBycLm8lsT1mtd4yd+xYEKXuiOyjC4WRzX3SJ1ZDCCSE2
         OTUUBlKReigzQ9CT6WIBWoBtOFNUTvAKcUblVICCl2UAWErEGej10zwQ5o2NtPpmbQYa
         Fs4aIkt5W97pCXpQlIEN6M5pK3C9lhqs2oaSPIc4xGrEvH8CjxzwY/QzfuWG+R/Sc/oM
         OtQA==
X-Forwarded-Encrypted: i=1; AJvYcCXHlaWCE+Se6rnElsoT/iXX/Z07nSbVRH9Yg2FVaoaR2Rk0xJcT23lgU7dtDYjJPrRd3l/ikXxN1Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Zz7ZrTuOj6byNsyrgjpGqVsjqt+9BV5pZno4qtV2SP/ft/Sb
	jiHG2SLHDhWPbqA6cF5M8HOiX8OpBtiKwl3M9SJTLxycWu+t4DvlFyIrFdaRTyWzqkU=
X-Gm-Gg: ASbGncvuZFTsV9kPouH6twed2azu/W0Cp8IhRPPfecPJMFe3hARvGGH+pQZRr2Kvjj/
	UAPysKz99Kgseu8thnCT0Y3Hhq5+5PEsDyCEp4/6/I8pYfLn7D8dTu0q8RhFdgXimqBA32k7wLD
	uO/MkYTzIwO6XHSWo8ckrHMqQKKLqjH59xGj0pfgjzr+3PSeZflSUpAnKPruMagXsUHWlNZYCWt
	aNHOxA9JGMpipeVOzfdiok9A734iPYHh0lxoyGj/mtKy7JWOwFuWZCOxV+58LpbFOX/h34yOA5f
	r5bj8QyL6NuPqa7E4IyV/OWlAEUZTx0H3KesiZRr/yU3B9RoGL55ViNMUMqJV3md2s8=
X-Google-Smtp-Source: AGHT+IFSR8e8jVVCJqCvh7kcoUQB+Aw0Y24SkOD/mG2mZV1+q1ECgdVeqvoTrAvrNH8EzxirHatO2g==
X-Received: by 2002:a05:600c:1ca8:b0:442:ccfa:18c with SMTP id 5b1f17b1804b1-4532b941335mr36533255e9.32.1749742597338;
        Thu, 12 Jun 2025 08:36:37 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea17d7sm24007395e9.10.2025.06.12.08.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:36:36 -0700 (PDT)
Message-ID: <7e4bcfe4-cf79-4b21-865d-a1248e09ffee@linaro.org>
Date: Thu, 12 Jun 2025 16:36:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
 <20250612143644.cmw6d4iiootipafp@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250612143644.cmw6d4iiootipafp@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2025 3:36 pm, Vladimir Oltean wrote:
> On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
>>> FWIW, the XSPI FIFO performance should be higher.
>>
>> This leads me to realise a mistake in my original figures. My head was stuck
>> in target mode where we use DMA so I forgot to force DMA in host mode to run
>> the performance tests. The previous figures were all XSPI mode and the small
>> difference in performance could have been just down to the layout of the
>> code changing?
>>
>> Changing it to DMA mode gives figures that make much more sense:
>>
>> Coherent (4096 byte transfers): 6534 kbps
>> Non-coherent:                   7347 kbps
>>
>> Coherent (16 byte transfers):    447 kbps
>> Non-coherent:                    448 kbps
>>
>>
>> Just for comparison running the same test in XSPI mode:
>>
>> 4096 byte transfers:            2143 kbps
>> 16 byte transfers:               637 kbps
> 
> So to be clear, the 'non-coherent' test was done just with patch 2
> applied, or also with 3?

The whole set, and then the non-coherent patch reverted.


