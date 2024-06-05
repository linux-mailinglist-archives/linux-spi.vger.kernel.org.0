Return-Path: <linux-spi+bounces-3253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B658FD37E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5893F1C22B16
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 17:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DDB15351A;
	Wed,  5 Jun 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="erRnJep5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3517559
	for <linux-spi@vger.kernel.org>; Wed,  5 Jun 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607024; cv=none; b=ZmEYvjNdVo0bUiVgnCx24ZHwXByHp461xg3QjB7ZC4Fjlet7Hywv6mMvuhKP3Eh9LlSU3/6IRi7n08HQ4Dx0amau2hfatzXgyOR08fZlJ9njV/tIHJSHRYzrKMiP0HiYSUtkp1IWEvTsQcKAddAMQ3ASeGPrpvoz/Eq1DBxP9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607024; c=relaxed/simple;
	bh=CXzt17zcdptbt4BYuot7hQJfn4AKErAZ8XcgY5+S1rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoDjuKwpxjwaHQoRi514/Nxk2qyedPXY5esI+jpwkSr1AzwhrfQlGYO048heubEbqtMguKUtOQZnuR22DUa0Ak/h/27dOCwzPj8o57evKUHZRFgMl+qoXwPqr3tugOUV7xIKVPo9gYIxuyTrhaSSzkaXjNLmu0UJJ3Nhb+kxyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=erRnJep5; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b970a97e8eso1414476eaf.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Jun 2024 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717607020; x=1718211820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4a0+ecZleYjFXSGL5bL6k9ooCZXlJHeeje7JkdFAgc=;
        b=erRnJep5PGmPrSPH+IR5GspEtinpStrdDwxLgJh6SMCcnAXA1MJpI+hHmEddkumFI4
         8oWYnk1TxaqzXkUUPcZu34lr7c0rreBkckbSqGjB3uawPjJZaAWtAWOzDuHZD+hiZJHE
         6Qt7XGWIF5uq24X2wClbREdKFx9Zsr0NZs+lEWVXZ9Dfmr5LbrX3o6fGHBqsP/kUiYWm
         F6LjvCVB0LFyvZeDme7bDS8wygd3k1hB6XEM0ouFDbYiWFAXiTyYj9PsNWx9G6a3M7j/
         nHFAli+rSPOo2NDaaByPATgjzuMJEsq0RAmgIMMeu+iCSEO1NFaqDYAY4bSdQzdoNt56
         t/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717607020; x=1718211820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4a0+ecZleYjFXSGL5bL6k9ooCZXlJHeeje7JkdFAgc=;
        b=HYSviVaJgJGenPMuCp7rKKPTPS4Wgo5iAxNIl6+ydxtCr8SmJyvltiYOr/Km5c9xmY
         b2mLFTtA11XNjyV3OUwaISAC/QBEormWvV6MbQKSQlVADon/QUj2/bwFg+hv2wfsKJ+j
         w94TjiMaj3xOlJUifu0zRvpBZ6HRXfT01+oPpBlTJUmrzEwjSCz2mQIAn3UJnKTLxvlY
         +O/QovqmlwJMHwak3KbQvVjs/PK6dDx2HGjV1UgFsOLMuVY+TB4YBC83oHbYD7xWVkIu
         DZHWQSEWRN4v3V/UHUertrLSjjXTmddmK8yuDsp9L+8Esv+TMVsPpj3CkXphN4dGrieP
         qyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm6YTpYvTF7/TZbbTzAQAB5B26JyX8BzktFYEt6Y/DQH3Yf839JjU4CLewWDyCmgVMfb/Sc3uZCIA0I/AHI771WjhLqVqfpgDy
X-Gm-Message-State: AOJu0YxHUz8cPngfs2Nk6y+nw8ShzuPScPN08e29yBCT5LeSgJ57vwmB
	bOy+DIcR5aMlEmsB+3MJ0nC4/9T1L3tVrx1zfDyx4MTi3U61RfC72infu7qTgeI=
X-Google-Smtp-Source: AGHT+IEvzG/n/greZ/wSv8VPzHO80/DJZkSvumJN6Zi3ihQX8MKAO4NUq8gdiCwMpluFFpve4nP0pg==
X-Received: by 2002:a05:6820:2212:b0:5b9:fc9f:6a6c with SMTP id 006d021491bc7-5ba78d3b48cmr3465485eaf.0.1717607020326;
        Wed, 05 Jun 2024 10:03:40 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba788e3f14sm496330eaf.42.2024.06.05.10.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 10:03:39 -0700 (PDT)
Message-ID: <ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
Date: Wed, 5 Jun 2024 12:03:38 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI idle
 configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 5:43 PM, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 0aa31d745734..549f03069d0e 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -41,6 +41,7 @@
>  #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
>  #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
>  #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
> +#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)
>  
>  #define SPI_ENGINE_INST_TRANSFER		0x0
>  #define SPI_ENGINE_INST_ASSERT			0x1
> @@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
>  		config |= SPI_ENGINE_CONFIG_CPHA;
>  	if (spi->mode & SPI_3WIRE)
>  		config |= SPI_ENGINE_CONFIG_3WIRE;
> +	if (spi->mode & SPI_MOSI_IDLE_HIGH)
> +		config |= SPI_ENGINE_CONFIG_SDO_IDLE;
> +	if (spi->mode & SPI_MOSI_IDLE_LOW)
> +		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE;
>  
>  	return config;
>  }
> @@ -645,7 +650,8 @@ static int spi_engine_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	host->dev.of_node = pdev->dev.of_node;
> -	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE | SPI_MOSI_IDLE_LOW
> +			  | SPI_MOSI_IDLE_HIGH;
>  	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>  	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
>  	host->transfer_one_message = spi_engine_transfer_one_message;

I think we need a version check instead of setting the flags unconditionally
here since older versions of the AXI SPI Engine won't support this feature.

