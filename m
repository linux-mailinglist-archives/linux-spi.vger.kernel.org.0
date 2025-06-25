Return-Path: <linux-spi+bounces-8761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152DAAE7CC8
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 11:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BF21893F42
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4246A2D9ED7;
	Wed, 25 Jun 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVSS5ONl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917729B237
	for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843147; cv=none; b=RNLCTAAwY/FZoEF8iIo9CYJiEi9lmZsqCFXqPPqCJx95mOTFVNh2y2ztHz7W+3OM9iE+BkzTd1XfLp9xklEOSipnZEjcrb+v1LCmxG/pGSFpLGiyW+/YUrh9CBj0d15m+cgNeqRFgMKwBLMq1kxRd1EhwUTMzStFhCb40vwV+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843147; c=relaxed/simple;
	bh=20e3PphxG30T3V+Zob/qx0IQxDG73Gud5foeaYVbVvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffv4rXNIlWEeH7wLTdV9tq+1H4x6O/ZFwuUs8AsHwvxA9ueX5GR5L2xg3PiQsByB2WWcZaHq2tfnoJhQ7quTdk+CqI1ZQHpUqtR9U5C11SCcnljxbfdQYjLiNtGdv9TzyKOEf2gkZJi5sbUVRTuddoSHyFT7CWr06tZm0P16TW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yVSS5ONl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so4857535e9.1
        for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750843143; x=1751447943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojAQtrqRfWE5uG2/EcUt6MJrN5Ulz0bDOzZRTcZgA5A=;
        b=yVSS5ONlgQZLL68PH2r2KmK7ETejyMcCm5wiF5j70L9Vqdb3h9BBcWEk2B9ZP7ufC0
         V53h6hyFMq6bEmwmovlKSZqLyLSD1O+ij+0VMJk6XrmfPUVTrusL/TaZT9y3miQ8C75k
         1n0cIRrqKg2F828yMfKfD+giWFjaQNY+5cUX36nZFNp0uklf6TyQTbYvKs5BXyOYyHvE
         6Lfh9KF/Ue6pfb+lDm+hirDnoK+x/tbgXf/Kh0e42jYU4VmvVXiauFRSy4E/KFXTmcdj
         7eXd4Gi6OuLPWK0zWIun3Snav05yV2b4V2nK+94bX7cg1HUUYHzlBbpMQ7/Jod6y8KO2
         zYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843143; x=1751447943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojAQtrqRfWE5uG2/EcUt6MJrN5Ulz0bDOzZRTcZgA5A=;
        b=tfMpOQ2T56XEdcj+v0H1MNL4AR8ItKHM4VfHDwLIv2ANO/xccdf6XZsH8cVBo66AGv
         nCvy1q6KQ3ViV7oP8ijEIqYlWyPmdz/niuw8KHgK3XG1xYEIzxn3qeEEIxApx9dpD5d1
         TnRyvL9n3jlkLWskXAz4MVDKMp3V1YFObJmeETdQPnLzXYLO4j2GducJdrQZp+GqIHD1
         PoJ1i05XlJuuffUZR8zm+eckKUgE8P1kSNNpGMWd18BCmbl+9juTNE/h+S5xt3qLiecF
         cUTYP/hbMnapNqhAkaAyh9DYXx2Px6YcdcVxzgW94Qx+gVMV+XRdfurdNcK8Ib/XFK7s
         zMnA==
X-Forwarded-Encrypted: i=1; AJvYcCUyAZrhRGM3rSa5B9+Gsk+XwQiVqFqMHB3NBIGjSNGnG+n4UVENUNVqxDuwQwQ8xuBXQLkfKkylFfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJS6pWtoo/vkpsp8YCBqgWG9Hh+4iZAHMaroODH6P3wac5bOa
	ojw11/WHwE+qmRk60NzUJ6P/FSclLxavKOHKQi0h2G+BpbAWL9C0k04u1woXg6nG49M=
X-Gm-Gg: ASbGncsjZ4EigUJI1tykhXaM4NuxQLiJ1uWS3yZq1ifsGvOvcmQtE2qsVplNk+pZOeh
	EJiKbNNgvdyeeJr7z8OSMYnCFwoHR6/TRY1IPT82x7Ky7aOpLNrZn70hdoCMA/whCpVb5VxNapF
	8HIPvOyt3+f2EtwhePNi0HuRgG9N0XXik/i3k8qOKP2eshBGj8BgF0+iGetzlx0IJX2KO3jLgcj
	CZsO0J9df3kuUiM8tXIC0Pvk16+xJenv1Ig1NzS7e+QIwWy1zUicoSMQz8UsY0QkTwlYLSyqcTh
	QMDFZxYaf4AiSp7t8GFozVptoif+Mn+IYLOe/ZvsTYnbs5mNY9FZr2RAyOqBp73b7IQ=
X-Google-Smtp-Source: AGHT+IHH7ZCWqc0u7ZgOrAL3WMonYTs/JRdAzK3sDu8U1/EewCY+ihQcjBc/zfznNgiZP8hFENkJ8Q==
X-Received: by 2002:a05:600c:450f:b0:43d:174:2668 with SMTP id 5b1f17b1804b1-4537b631db6mr57163895e9.0.1750843143517;
        Wed, 25 Jun 2025 02:19:03 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80693c6sm3957051f8f.41.2025.06.25.02.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 02:19:03 -0700 (PDT)
Message-ID: <0c6c78da-575a-4d29-a79a-3903aa801b42@linaro.org>
Date: Wed, 25 Jun 2025 10:19:02 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
To: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
 <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
 <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2025 6:16 pm, Arnd Bergmann wrote:
> On Tue, Jun 24, 2025, at 18:29, Frank Li wrote:
>> On Tue, Jun 24, 2025 at 11:35:33AM +0100, James Clark wrote:
>>> This will allow the build to succeed with !CONFIG_HAS_DMA, either due to
>>> a randconfig build test or when the target only uses one of the non-DMA
>>
>> I supposed you met kbuild error. If yes, can you add kbuild build report
>> tags.
> 
> Actually I would suggest making it a dependency on CONFIG_DMA_ENGINE
> instead of CONFIG_HAS_DMA, since that is the more relevant symbol.
> 

Makes sense.

> It would also be simpler to enforce this in Kconfig if we only
> care about users that use the DMA support.
> 
>        Arnd

But most of the devices supported by the driver don't do any DMA. That 
was the reason to stub them out rather than add the Kconfig depends.


