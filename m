Return-Path: <linux-spi+bounces-7899-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A28AA9A53
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 19:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908661899EEF
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8941926B2AE;
	Mon,  5 May 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K7kdvSAD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE626A0FC
	for <linux-spi@vger.kernel.org>; Mon,  5 May 2025 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465712; cv=none; b=UOaQWcusaicBih/9ZglQoVDKMf5VNN/kFPSZHgc0x6PLVrUaub7yZmH40ne7U/ZeJvr+sSo3szzdYtS5tghHqRFkVdR6/+hQV3EbSUgjoZil2yU7zwlveOrXJdQGJ2kbbEXr3v2YFn3L1+U3C4mCRdrfpTs/WA7Wr4T3IoXuRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465712; c=relaxed/simple;
	bh=jcGEKN2FQmLYABFrgCfyNuY3i79lchvxrUlZtZoKNYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYZYhxaQE+hjZT7cicQ08OBDZJcPtjFypFhgC8t5Q1hAK/oCJhzqzc/tYyIDl93x4aXsP6qCTHR4eGT5/B3wWJQkUjau6uzli91g4cfaZ7ajzVSENrlaJr5HWyYV/SJX0KDWvX397ZCSgWckS6/yb4EGqxK394YJ0L49A8BSKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K7kdvSAD; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72c3b863b8eso1225519a34.2
        for <linux-spi@vger.kernel.org>; Mon, 05 May 2025 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746465709; x=1747070509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVMb9oF5CEf/GpTXbkBHrDWFxgCwTjNlgPwnh4zqIU=;
        b=K7kdvSADgbh5WKqOoV0ictJAo4+XJkhJuOzEjOPJxHzFkfVPD4IDU3ihxXft8gSfEJ
         j8N4o0+QA6uinEdgMoVJLxPNbNVxnqxqwUTnpRfYb7YTRc1vUKoWJgozqF9sm/Bis2GU
         Pofw1VvzmATH3N3dQuMz+5Xa2yje8PkW/9UgVctXF65S2U8Yr4r1sBqxJRlZwkSzWKI4
         Q8Jsm7NE3ofShY5JnLtTZ/BYVrkP3vXVhjiP7sFpzQ6owq4ckXmVYGe9y5d3UeT1yk5D
         rXzDDVLaMiqmrQTyNmokFYKYBmsAgxuqiX9h3oBtI0DDi1EBmsa1ROeedR7RKvEV7goA
         N15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465709; x=1747070509;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVMb9oF5CEf/GpTXbkBHrDWFxgCwTjNlgPwnh4zqIU=;
        b=Fan1rjuYHkEKEDwcpjQj5HtXbZKXZTpSBgvzlLYTdVIxcVma4EaPFVf8044r9guC21
         aw09yRQIvxy+2Q8XtkJgqrMwPWjWutHx4FB5jtv6Yi8O6Un+YGlkqF+7nXdgEKI5ewhU
         65cHhB5prWXuMJ6IeGpX6piWFt9uRj1638SMiKUMe6J9HJYar4h/DV5Apd00/Lp0OBJM
         UwFe2wNB1QmbpdNYnRfp0lIewExRIqyjJZXgWGuwgVSD3Im9bBtZhTE02Ak2w006CmLV
         9IEXJTZnUacGSw1kax89LSoIGpFFHvh+cLYrF6pnU4dEw6lNmDRS+Dez6nT5JJzgR9Jt
         7UQg==
X-Forwarded-Encrypted: i=1; AJvYcCUDXYcrexOVhkKHwNMkw06szEhDXNHrxVgIIrrc50lVDXbXwIiJtL+Tp4ln2NZAblFs2M8fuiU13NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WcR48juRRdCe+lZ2slITcwRWflb7QuYwP8iLox2yGdAuSd3Z
	1p2uaJghHfyI0FYn6H9ixKZIxPDKqSHeEGXA0W+9qy5pOupFoZ2BRbZkHq65e8Y=
X-Gm-Gg: ASbGncv7KiDSrAGLMxi80Of4UnMZSQORXDneL61TGmyQdKlhn97sb439rWrzKHSsq84
	Bc/oN5xE1FQKZT5zJD0T3nq7yGxYrQS79VQSDjETNqooU2njYhH+DeHpHXUExEFrtkA4hurdixr
	GqLimt54OHX022XXhOvJAuLiUpkM62L1XTkwteSKtKqQmoA+LrTbqYyqhGsdxA896vwSZXG+pVl
	1vQVFuqmxMrc/EXZ+7torNgDm5OjKjAf7wt21SqRbW9itXgVpW+Gwcwvs2xKPl+KHYJgnkXnxjD
	QhjY/fAIdSfOiTwiq8hPsJOBIkSKdeVu1jenLipAhPUqH5t54XJGeFg6PqGZVH+Nbq80FmVILg7
	8caLNlJs6LYZdDyk=
X-Google-Smtp-Source: AGHT+IFcxApnoYjUY0w6idtC1pck4OIRHQ/tTPu3UVsNzFkW+p8gRi5HDRVw03HtHe1u6yZcOoXfUw==
X-Received: by 2002:a05:6870:4790:b0:2d5:2191:c8b3 with SMTP id 586e51a60fabf-2dae861a902mr5241443fac.29.1746465709654;
        Mon, 05 May 2025 10:21:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2151:6806:9b7:545d? ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa1207873sm2127468fac.38.2025.05.05.10.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 10:21:49 -0700 (PDT)
Message-ID: <b5a5a8a6-bb8a-44f0-ba94-7657aba83311@baylibre.com>
Date: Mon, 5 May 2025 12:21:48 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] clk: clk-axi-clkgen: fix coding style issues
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
 <20250505-dev-axi-clkgen-limits-v4-7-3ad5124e19e1@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505-dev-axi-clkgen-limits-v4-7-3ad5124e19e1@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/25 11:41 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> This is just cosmetics and so no functional changes intended.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c | 74 +++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index d8634d1cb401fff2186702354ecda7b4fcda006f..63b7b7e48f8fa00842ce4cf2112ce7a89fa25dae 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
> +#include <linux/types.h>
>  
Might as well sort the rest alphabetically while we are cleaning things up.


