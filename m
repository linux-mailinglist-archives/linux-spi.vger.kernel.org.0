Return-Path: <linux-spi+bounces-5145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C86994462
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C493A2842DA
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC218B482;
	Tue,  8 Oct 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJVa9inC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119E158205
	for <linux-spi@vger.kernel.org>; Tue,  8 Oct 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380085; cv=none; b=n317HdBBPe3iW5qKo4t78MnsaU47XVyh6KjCW71RXoW4LzTN/qw603oXKrKxgZz3zcvgoR2MA53LkVrWpx4oxKqkCnA1z0Vn99HbDoXjF1jd1RtaQWE9HT761A4ue7RlRFVjQVNVNFKXdz+zRyDkELcmF4JuJ7DoEfRsatuFFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380085; c=relaxed/simple;
	bh=HWBIIpb0I0EYke4W3rFcSXL6PavJ5v8RK/W0/e8tJ1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IGQ2+roZCeBzrZU4Gkv/jC57wNQOlyulj7BytD3NPEiBepN3suwjmTILzyOluJsP8ep65aq08xpQYrD3iNSwUELC/4r+DMeD89+BORT05gAMDIpUw+yFL8EHWNJOHZZm6WteaV9+o7fLTzggFu0cy06wJgTDykoK/NWl07JX7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJVa9inC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccd81de57so3592392f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 08 Oct 2024 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728380081; x=1728984881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkUrttCQ5fOL6PrH7JQH+jh3uBvnwDTVVw6+ImTwc5Y=;
        b=VJVa9inCMkPUxJvC9P+47tLm28df6RSRHhgaRv9+ETdEGXmBsrjMavDl1D5e+JyBOb
         NycOeAPsUaCJB8Urqwq+Ke1ArqVFmvbwbvtyb0Dpr31udoefZGuNp70U/bWjUgqsKW3M
         Oe4WrYAOWUdphQI/h8zLlZlwMDBaceDkjby0JSb12opq05P5tabmTAzvFQI5xxx0WB8n
         EtbSmMOBKjDUWeX8F9dShLxzBcxUzedOSa7M/DZ7H3kyC3L9w/w/wQRvnRE0QU03q6/a
         MPKQ+kDMzGFGq+5H+BOhN4qOJSi4V5pfltdCa4KUn4b6caeWqLECB4ewL5/WBrIK17gM
         3QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380081; x=1728984881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkUrttCQ5fOL6PrH7JQH+jh3uBvnwDTVVw6+ImTwc5Y=;
        b=unayGDv2VjNNJTywpB2aQarvBo4HNaEVyYgXvQWlJq9hof7y8J18tL3T+qi6vPzXI9
         VMNLZQt23WamC/sYq+3EiobixKMsnRNjQdhzqwaiO3dH8DzrZpvEn7r14WJEw1AdxUMT
         FPdobqfeOP6Sfs1Lk4qTsh28rvLkdAzaFcUgJUddVp8aR4k3Im8l9EzHRWDkC8z0O9So
         m85bd3CAB0w+IPq7XkrDq+byYN7EQizHGCs1js07jlZjh703SXebs2LWagOBPwZhH+l9
         uhHL38eBdYY58jTCeXjiyH34+l0TY/QOm3OxqYE8GmSOiuj/0EpuvTVTdRUIGDPWu7Xa
         ABLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqYdi5fQcEOLuIERVWhwzGETebtrbA/sfIU2aAzfLjqAgk6+9nLM+vaK5ngnMVyEp/sP0VvZb1JpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemLIjizM66GLJBxpjI6ORqt+T5dgBvdEYOS/Ana41xbliaAyw
	geOUdAf81IepbBeTpwK2fVQGBvusYGQVcUmMZlv90I+iQMyGhv8idin5a9urf+k=
X-Google-Smtp-Source: AGHT+IHEZnWRQz4AvycE7TbZa8Wd4RxN1heiXUIFm7/Zn/w1b4DSiaXxZ4pg1k8jYTnHuFOlEzBQTw==
X-Received: by 2002:a05:6000:2a83:b0:37d:2e73:fbcb with SMTP id ffacd0b85a97d-37d2e73fd07mr1031436f8f.2.1728380081173;
        Tue, 08 Oct 2024 02:34:41 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89eda21esm103923195e9.46.2024.10.08.02.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:34:40 -0700 (PDT)
Message-ID: <1c525e43-d71c-4c4a-a8ac-96627cd6ea7e@linaro.org>
Date: Tue, 8 Oct 2024 10:34:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-quadspi: Print the controller version and used
 irq
To: Mihai Sain <mihai.sain@microchip.com>, broonie@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008083226.51163-1-mihai.sain@microchip.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241008083226.51163-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mihai,

On 10/8/24 9:32 AM, Mihai Sain wrote:
> Add support to print the controller version and used irq
> similar to other at91 drivers (spi, twi, usart).
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  drivers/spi/atmel-quadspi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 95cdfc28361e..757f07132585 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -687,6 +687,8 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
> +	dev_info(&pdev->dev, "AT91 QSPI Controller version %#x (irq %d)\n",
> +		 atmel_qspi_read(aq, QSPI_VERSION), irq);

This pollutes the console. Better to add a dev_dbg if you care.
And irq number doesn't bring too much value as you can see it in dt,
isn't it?

Cheers,
ta

