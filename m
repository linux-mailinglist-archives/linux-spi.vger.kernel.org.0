Return-Path: <linux-spi+bounces-8706-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D774AE30B7
	for <lists+linux-spi@lfdr.de>; Sun, 22 Jun 2025 18:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1310D3B1DFB
	for <lists+linux-spi@lfdr.de>; Sun, 22 Jun 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C9B1F4261;
	Sun, 22 Jun 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Cek2Rca"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685CC219FC
	for <linux-spi@vger.kernel.org>; Sun, 22 Jun 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608867; cv=none; b=h54iME3lVMAT/N65fMbce1FKmq6/Of2eOoxR3i/ygN+9dl2EcpJDo6a9g7KwPSe9QAI9/vp4+4W4zlekn1G7Q3wGE4MNJBKzLH+gHPcWjio2G3L90gaH3hXkZKzpBRU8hOaJN6mCbTk6sd+9FAms+ETMqJ91muZJeDavpb56T4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608867; c=relaxed/simple;
	bh=E4rFypkPIrk7vg0K520K6GmgIY8PC6BjosDROkARYXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnHucos4/BvBYEPC5j/6FWFtFiBAmpYxVqwnhwTfN+99rvIvGm7sd/wc5y3nSdJooklErETUeOKjjLhzf/X+3Y3qbEYAGS5tzyLFrli0514Wh6cEBb0wMixinD56yc7DUvZQSe2eDptW+tVb9B3EtR0AbJj96dsR8P8d1HOYgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Cek2Rca; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-400fa6eafa9so2571624b6e.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Jun 2025 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750608863; x=1751213663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RT55BdTQMsSqQTGnDjBdNFy42bnLM9kJKWOx56hzQ1A=;
        b=2Cek2RcabWnqywSSBWimNtiF2CrvFqWJTQc1N8NFIlnfqjFoWRcrgZJQ3BlXwrIKeA
         4prNiMII4GBcXkyGdWiQ6vSd0GzFL5RbZuTJNkXuWa8VHVEzI7DO1e0v23+XN5YiBUNW
         VRezCx0d1fAJ2P0Dk9FSUDSeVbmcCFwqpRa5+zcrWTXR896C/hfxwxtQg1VFx7gIVbXA
         kXyIsEdyrA0G8N/cMrmschusgo+e8xs0hyYoRY3MmO1Y5uinSt4gyFlTkGZtmj0SGzp4
         gE8ONpq3cVXKsF4fCBKPNMMFOBTZr01+3hZR2DFtU7+ApgjcSmGeVbrNepSDzuIc6nNG
         +mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750608863; x=1751213663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RT55BdTQMsSqQTGnDjBdNFy42bnLM9kJKWOx56hzQ1A=;
        b=dIikPhETY7jDCmmJZ8M2KHdzz9Cs9aHlr16E2dKVLdJhItxlSS+w9WqtDcIlfG0Wu9
         QFpekUrmXZ6o/c0/9P2rORvXXY/McYtKVFC39wy/BV5IyMQdH4r1kgyS9LLy6eSYASmD
         jwM6X8r8kEFkvrEZS9oFzq2SEPrBbnDAtxgYcq39j6mtwrX1oMYi2XN2mgcytzpkRn6u
         uoUNaAmJT1id2haqQvn8Ey5y7EjYsU3bZnxaFDXxNS36U+P7pMCkwTlgt8BaAURRAEtF
         fns26XuW8D5i62RvZWvrQ9HNTFph6LfXo78sL7t83XSM8BokKl5bWn3slHhSCY6ZVHzJ
         wUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxKDbEVQiw0pMUwcgRgKPSbR2eZKtyYJkB9nGOY4addRJR6chN7WwUvw3EtmMKIkz31VVBbPr5whw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNl+0to7v9Jm6yUhXfHz3brUzoqImw919zx6m4pC5SJS1pB5M
	pvEp/s7nOHW5+bNo9V/lYUp1ICEaEz7mChx8GKXNRTMWtfRM3gd977Ff5lBqn8n63SU=
X-Gm-Gg: ASbGnctw8bIGmzKICTaNLz6+ntIXUwYRGKWzPMPaC57OqY6gfnLcAgv9t5MxkF97A5X
	RjeCB68VsxefLJvjXDOpjTJpeIgphNUWRnxI2YtgUvs7vlkA1n/XJJRQ3u6Xaqn/DMVK30QWKE3
	ugOuVBsAvfmJr9AAcYndjxlsu1SyI37vdGfqkpg6Yb34eG5SdiE/cE+hyFgjfpDaGS3Cn7FzBKU
	jxnuZhaH+hKHz0i4A7ZocabqxpIFdQI4KFw3+iWdpOtG1MjM+Lye9rtwXB6+JMKm4v25nxGtkQQ
	DfsqZSSvY4GZp46tcxnhqsU/goWJd/Wd/7YG9xshZMPap6SfWekZEuAiUxzKh5ENhxITZSelfJB
	Z5Y1PvelJBPfbKYbRN5TzOB5dDE5WbFWcdwgKFIA=
X-Google-Smtp-Source: AGHT+IGsvJy3BWTWHSAyPkEPTBTxxziw2HN/QGBf2hFT6oQ7sBwQLlzrgTMkODdA9iou2mDpphfKRg==
X-Received: by 2002:a05:6808:1207:b0:406:6e31:18a1 with SMTP id 5614622812f47-40ac6eea095mr7296063b6e.2.1750608863396;
        Sun, 22 Jun 2025 09:14:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a78a:24a9:21db:1532? ([2600:8803:e7e4:1d00:a78a:24a9:21db:1532])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40adc0842b6sm417298b6e.8.2025.06.22.09.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 09:14:22 -0700 (PDT)
Message-ID: <fb7c3825-89d5-4ae2-a19f-c527b0b000b4@baylibre.com>
Date: Sun, 22 Jun 2025 11:14:20 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>
 <20250622160054.31cc5103@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250622160054.31cc5103@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/25 10:00 AM, Jonathan Cameron wrote:
> On Fri, 20 Jun 2025 17:20:14 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add SPI offload support to the ad_sigma_delta module.
>>

...

>> @@ -670,7 +700,8 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
>>  	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
>>  	    ad_sd_disable_irq(sigma_delta)) {
>>  		complete(&sigma_delta->completion);
>> -		iio_trigger_poll(sigma_delta->trig);
>> +		if (sigma_delta->trig)
> 
> Is this defensive or can we actually get here with out a trigger?
> I would have thought in the offload case (so no trigger here) we'd not call this
> function at all.  Mind you, can't we get here with no trigger when doing
> a calibration or simple read normally?  

The difference is that with SPI offload, sigma_delta->trig is NULL
but without SPI offload, it is never NULL. iio_trigger_poll() doesn't
check for NULL and would crash with NULL pointer dereference.

During calibration and single conversion the poll function isn't
attached to the trigger, so I guess that is why it didn't really
hurt to call iio_trigger_poll() in that case.

> 
>> +			iio_trigger_poll(sigma_delta->trig);
>>  
>>  		return IRQ_HANDLED;
>>  	}
> 
> 


