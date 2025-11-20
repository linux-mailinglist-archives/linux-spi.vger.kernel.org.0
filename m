Return-Path: <linux-spi+bounces-11370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4316DC72B60
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B5CE42C922
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6D5302758;
	Thu, 20 Nov 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErQuyRNN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECD2848A8
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625936; cv=none; b=aVfaQNqT0kf7OyfZfK749QNl8UrTv8wqv6LTxFtDjNySsvdaYKn+jkTbANQrjDVcSrbJ2CJRkhhgQvGhopskr/0UwxJ89ek1eUrc/W/cbFIig4RHP5qimAGuU+DrM885tRqoB9sBzN31AHZoLMfklVQL1t++TqRB7v9FBgI2yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625936; c=relaxed/simple;
	bh=4odYw6lphQIVkI4BWQ65rxrqQM+lFn8fevTKJ7zCzLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQYLYe4tuGuGHLDCfnTUDZ2b7+qMFN7voXStxFjDlAguvp4OHMJQJaySIqfhdz0iEe5P7EWQhi7culpH9L05Z/Ibq1Y7ZX1QeWmPt2fJQcUcjXs19hnQ2uo2i6zd1hVMBJqGZMGp77GkVOW7G1S2BBXS/6khscMQDZexxUcDFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErQuyRNN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3b29153fso299007f8f.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763625931; x=1764230731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PztCW99nsI9W45kahbPszZ32SfHFrWK98zZmX/7wnE=;
        b=ErQuyRNNcb6IDLy16q4sUp5N+Yt3iNGVi7dYIzl0Fls2aB1hfQY8Om7QElBASP4AOZ
         aDEnDetBWsenMiKepIqOxXYDrsQsqhaYNYuZUcRPIFADFmLitj1rtOPnsleVrW9n7jeb
         Tnmk8AsI9BAZGABA568fcCCRPYTV5c/GeuVzZDbjD7tZlIohqNYNspvFYSQz/rXsuxad
         OjSL20YtAkZ9sEKelcrrDQN0pzVb2OF8nkhTP95uXghKHvQ9tNEJ/ij2vS8XLFvXD6ZH
         TGKOP32AunkMiJx0Ji/sRMXvaKpAoy43nUzTBjsIF+DbxWQpO98De8/oVY1p/VXWaYE9
         qd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763625931; x=1764230731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PztCW99nsI9W45kahbPszZ32SfHFrWK98zZmX/7wnE=;
        b=pfKtl36x88fds/C2Di0ezRb+not7EvwDUO4WzAsTGT3yP4HmvtpfhF+t3lpjhT83IJ
         uROfjPOP8tn7sP0R1esveHZO5XXrPFgSjD+rj+daM8YP5pf61ezJIcUlP56dpubZPgCk
         XauG0n9jjEclDPLo1M8BVbvSH5NwklAwqQOwhPO7DJoklh2/L/W7qLlwRUKDGGP3BN38
         SwIcxvTSCfkm/bHIIt7XHtOxJMrR1na+o0Kx38KFAl4Z/jAZc5rnxjMoKA3YmOxpXoXz
         m5Ldqpg0M1Q+kcR7W35fFiaXVsSmnMIoHuXO7cnYiLU/PhXQy2mPFfwHw9BsZgPyN60L
         hUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIqia9RxRCKtqABEBp/VjRIpmCWdvns/4IPrS3hN7gwinawM1AiV6dEF7zcapIjh3XtZHttEOADGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUnUtOzKzvZnoiAyfF/2FokB05jZwqDYmtuTT5ybcOIXEnsWy
	8HuQpsmUdXUl6gJzL/GUmNBfryURkzXl4SWq3iQn2SnjXU9nabSRSVcKxgFIx6C+Fvg=
X-Gm-Gg: ASbGnctRFOoP/hT/sCfp0/y9CSuqifB6kNo5wskXnmvYCKSgB545jnsyWJ/NldnSnC8
	PnGMh1ubKx9yHuP2/UKuUos22+liFsoyr0JL17J616c+ulkxL/Jwhsu9kRRIZzqox9TLJxhOwQA
	To5AKvKVoInjlgVhQWhw3qtvSTWP5BZBvGHO2hzg0egrr7Nzp2weuUWhfgVI+juLnC+d0kqLoMF
	kGiqBeMJLCfWJkHtkPWqRQME+MTDHy/Zf4lYYNiBFvgiYv4+/YPSMjb+vYFDbDCkX7lBVuUNn7K
	OrtU2D/WzyUwC6IvTPzaj9hdsUBI+uIKMKxBCMErzZpAmiWDpcCCau21UXMh5JXJPhme8wSNvF4
	R1omznOvuxKbJIu8XO5DoJZT0q/KsN7ci2+B3a8eYdxIVrGxQ6HYXumsGkHwuyNtUCguDsuexJH
	XbyWjrtbWmp65S1yIB
X-Google-Smtp-Source: AGHT+IE5v+9a80Zn9J2fmQEfUzMbSA47PM8PvbAZc/vWxwU72hK4Du32I64ZpwzSWFiC0CaXw3Jplw==
X-Received: by 2002:a05:6000:26d0:b0:42b:3023:66a6 with SMTP id ffacd0b85a97d-42cbb2aa131mr1087403f8f.40.1763625931093;
        Thu, 20 Nov 2025 00:05:31 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm4477241f8f.10.2025.11.20.00.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 00:05:30 -0800 (PST)
Message-ID: <f8981eae-3f1b-48e6-b74c-95810af3e5f0@linaro.org>
Date: Thu, 20 Nov 2025 10:05:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/28] mtd: spinand: Fix kernel doc
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-4-be42de23ebf1@bootlin.com>
 <efb8bba5-8805-4c95-ba1b-3bde46a4e528@linaro.org>
 <87v7j6aqlr.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87v7j6aqlr.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 7:18 PM, Miquel Raynal wrote:
> On 05/11/2025 at 16:57:39 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>>> The @data buffer is 5 bytes, not 4, it has been extended for the need of
>>> devices with an extra ID bytes.
>>>
>>> Fixes: 34a956739d29 ("mtd: spinand: Add support for 5-byte IDs")
>>
>> no fixes tag for documentation.
>>
>> with that:
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>
>> (commit msg can be updated to smth like "update kernel doc comment"
>> too)
> 
> I partially disagree. Tell me if I'm wrong, but may I guess that you
> have backports in mind? As opposed to backporting comment fixes which


yes, I was thinking on stable rules, where trivial fixes like this,
are not accepted. But you didn't cc stable, so I think that's fine.

> might not make much sense indeed, _fixing_ a comment makes sense. We
> know that stable maintainers, even though they ask people to Cc stable
> for backports, they automatically pick with the help of AI almost any
> commit with a Fixes tag. I believe it is wrong to not mark such commit
> and even change the title (because "fix" in the title may also lead to
> an automatic backport) to circumvent their tooling. The tooling must
> adapt, not the accuracy of the commits. Plus, backporting this kind of
> commit is harmless, so I wouldn't care too much?

okay

