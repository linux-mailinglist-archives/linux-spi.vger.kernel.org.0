Return-Path: <linux-spi+bounces-9246-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D926B16D1F
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E17179B31
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81DA207A16;
	Thu, 31 Jul 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GOK/9s7M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB311D618A
	for <linux-spi@vger.kernel.org>; Thu, 31 Jul 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949113; cv=none; b=pzwFpsC3/YC7W7SDFhrx8Mc5V+ZwsN8SfO798mJylydPOgJsVdxtUfDhArmfmHiyNg4Oy8E1oBAWqXPcw9iPVnr/43H9LHpMDgcRTVD2d5VZ461wMOqSNPqoyWoIa3iXY7k3fqd7qBB5DsOXZP9vpHAZrnZj1ytD5XKLzmgbEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949113; c=relaxed/simple;
	bh=6bi4kRFwbYfyE28UT2me0jvb3Oreb7wCirpdwwV3Gso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ5PZUBj6lkklwzh1tUCp4uxBYb5i5xtnRBOjb6R9D7OcbCDXvz1eXmJk4iXw5c2ivGjpcomaBXJs9IO5p65tAoHJThNdJuo+jcbZDycRanpb03X3RWxkFHVIiAqQTU/ClNFaPDl/0nqPLfBL3U3B1tEyNyCH1t/1SzVRAxCXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GOK/9s7M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-454f428038eso995085e9.2
        for <linux-spi@vger.kernel.org>; Thu, 31 Jul 2025 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753949110; x=1754553910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GiWR9YBkQCBk6u1BEFYqq7bF5Tp24tb8A8i+jcDSHqs=;
        b=GOK/9s7M4IR+kgqShpE31nJt8j2ZH3iU4C+GllNjX9mN1+swh8Vg25JRhLfkAKPh78
         IdNEbaFb5M5hVisK3nqq5WX2a67aaIwYkEiKP43OtfAQX/kSpX/ZMLRcyo99UhUZSIgD
         Nj3S8CDa95DPptI3X60aIsPVVRMdBpTs/wm8WuN2U/Fildo1NcJ1dxkoszZd4PJwWEgY
         pRBsxdTShVlsmCro7A2MM0uvgawAMvn8qXeHp/zAWQ5CDw8tdVz+m9AaWH3kI9W/gSBh
         O9jqTkbaFeQ2aNyWJNXVARsMSnn7aLV7OMLXn5i8fEMHMk08sQ4/ZUOHYJcl/tePwvrQ
         v9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949110; x=1754553910;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiWR9YBkQCBk6u1BEFYqq7bF5Tp24tb8A8i+jcDSHqs=;
        b=edU68L5vJrv+u6Jrqo7TKL0avOd5soa3rc5KcCrqjH53W98bkmZLmwdF/GFc5rkt8Y
         7+6hcY5gLAGC50XkZZFdiELjW3WchLZkUKHBQc/5IqmdONOscdw5ODFfddQNg8lWgpli
         JbaNdBMQSMVSANxh9aDJo5eSR/9wyYyZDxuIGDgw0Sy2JCC0vUzMXyCupJqAqP6Afx4R
         4jv3Knrc+eXAfowES96i1+MfQHfXMpctenKTwawZW5/0rbWvB0I/WEW4frvIfdQ+LJd3
         mGy3hky+Czxy+5wCKFtf/Hvxsz3oWoGH5Tv8UUKFGI5A2Nk1so1yZDHc82b9VysY9t/Y
         EdDA==
X-Forwarded-Encrypted: i=1; AJvYcCUq2qtA/OXq3+WZE+/3IP3wV4s7AHadKxT7lmtsWShDBE4BVj7G2VS61xsK88TzTbrQW5oPjTLbe4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6CVYWcrmGZwAc/dLerUyCOyGHdI7FrGfqKpzhv4WktToLoXIQ
	o7ZMVpVmUKZkb9DcKjzXHkjuxJKSmrdP3fK0O4zfoAwh4Yny+O4XMqz331QaETsM6X8=
X-Gm-Gg: ASbGnct6rM8oO5cDZ8oYhRcIO/qrxwUG+pBuq7Joep5M5miYyoLImtzSxYqeONbxonS
	pSxtHT1daoq9UopfPZa0vJEreYD3V/cunLf1rJ5nerxbk91eX7SJAJ4yDHgZSpUQaMkFPbqja7m
	ooW8iqQd99765fAg3xAWXxAg1LtopMvezQG6vlMF0V8qc6EstwRjbldtbQDDt1xPJTJlHq6twN3
	Fn5JAcZzuB13w7d5S3K4zTttFxGmJN1Puqc2a2NFpr1bWGN7jSxORbAEXEqTVy+7JmoO31YiePs
	84Mv7+N/fcWc96I/kVfiETTeTaPrdUwMba8EBYMy66kepbduxw7TBDhOfw9pFnnQJXCeX393aJj
	Fh9362LAl/uP7Iuc/SQCrIugNPzeylA==
X-Google-Smtp-Source: AGHT+IH/541SBqMgVRMwq19FcxpTJ84aTjtwL21hMdK7WasoI4YZqc/Qb8aQtoiT1F7mEW4j9xyVmQ==
X-Received: by 2002:a05:600c:8b83:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-45892bbf78cmr68783845e9.18.1753949110073;
        Thu, 31 Jul 2025 01:05:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm1527560f8f.66.2025.07.31.01.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 01:05:09 -0700 (PDT)
Message-ID: <bac5390f-725a-43db-a2b6-17a68d0d733c@tuxon.dev>
Date: Thu, 31 Jul 2025 11:05:07 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v8 00/10] arm64: lan969x: Add support for
 Microchip LAN969x SoC
To: Vinod Koul <vkoul@kernel.org>, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 catalin.marinas@arm.com, will@kernel.org, olivia@selenic.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, andi.shyti@kernel.org,
 lee@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, arnd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
 o.rempel@pengutronix.de, daniel.machon@microchip.com,
 Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
 <175327377884.189941.15214972441246653208.b4-ty@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <175327377884.189941.15214972441246653208.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Vinod,

On 23.07.2025 15:29, Vinod Koul wrote:
> 
> On Wed, 02 Jul 2025 20:35:58 +0200, Robert Marko wrote:
>> This patch series adds basic support for Microchip LAN969x SoC.
>>
>> It introduces the SoC ARCH symbol itself under the ARCH_MICROCHIP symbol
>> which allows to avoid the need to change dependencies of the drivers that
>> are shared for Microchip SoC-s in the future.
>>
>> DTS and further driver will be added in follow-up series.
>>
>> [...]
> 
> Applied, thanks!
> 
> [08/10] dma: xdmac: make it selectable for ARCH_MICROCHIP
>         commit: e56982021f5303b2523ac247e3c79b063459d012

As this one depends, as well, on the first 3 patches in the series (Robert,
please correct me if I'm wrong), and there are still discussions ongoing,
can you please drop it until all is clear on the first 3 patches?

Otherwise, applying only this patch will lead to AT91 XDMAC driver not
being built for SAMA5{D2, D3, D4}, SAMA7{G5, D65} SoCs. Linux is not
booting on SAMA7G5 SoC only with this patch applied.

Thank you,
Claudiu


