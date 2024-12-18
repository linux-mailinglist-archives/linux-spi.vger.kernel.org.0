Return-Path: <linux-spi+bounces-6096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327DA9F5FF5
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784A7188C9F8
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15535FEED;
	Wed, 18 Dec 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRQU1olq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB56DDBB
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734509430; cv=none; b=rxLFNa0khakwNYoKk9YMjR5xWI27vVuegc2Iucq1ty+Xn2LZYNwQ+87p547zkXh5hlE9vvxNVSa4S912RgLMMywt9aHxq7snXRgPEJzHyj8tX0XhEs7t0QlisKHfQyV6lXMjh792La9S2qD0caTuNKAsvGfyPvBokyAZY4+x8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734509430; c=relaxed/simple;
	bh=3qYdbxzs4l8PkyLR3HR05KmhCYaxsRKTptcHhYhR4R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcRSaLeuurf1c2yFYusOFShXwiHaaspmF8aMXIrL0Bdu1X7UHKw5+1h9P/CAJpdT9IW7mSrdatF4LSDvaHk5W6jgo0kko2mENUcVQBMhqZ1gvFdxcKF4ZvSmRvH+uVHisQeNUNpXAHfKW8EWHmThPI7k6Jel22M6A1UgQ3/spME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRQU1olq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43621d27adeso42748725e9.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 00:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734509427; x=1735114227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReRS6j5G98M0X/vFFlnySn5FW2QTeseYmxkguIVGI1c=;
        b=BRQU1olq7iV0fsB0ju5bh081b26+sihAwnFbdagnmU7L3jzblZiRgbymeKNv9marXR
         xW+lLM44FTkjXT7XGEqObXswdRneAajQxBzNKHJ5I+b3qOzhhJ0A/eQSpG/FAIoYyvqn
         CxLao0neMmqGmKzaJWHLuI9jByn89HU+XvJbYkvTrQgnqINkY0dIPqV8ZO4AQ+xSAj1k
         6Y9tZztp1DDyp8E4Sw0io9C+YZe8C14I8Sja3B0H3SB83mMaxbS79KH3VqVpAw7aRR+y
         R4zOjN0fwSP1rZiWfJUM8hxl9M4RRkKg3JMqALoMkAgirpVvV2ZIdhnQ76/rAX5+k2Fz
         E/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734509427; x=1735114227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReRS6j5G98M0X/vFFlnySn5FW2QTeseYmxkguIVGI1c=;
        b=gvMsORFW7hnos2n/9sSkAjO/AxFvqDRp7gy1l0zzi7Mk+qrZ1dvimMN7X1ygb98Cmk
         lYwoDDNiLcvAuUQTIRiy1CLhu5NLA7cr1ltKaPqdSqOPoAb0o8jYk1a7pVIBGvUCOreF
         rpW6C4xnHfC/Wb6OkrWOE7hF8YXyZKa39WPzSSHnNrVdQ2rGWMEmbcgItqu4Z1QCZyq1
         0FrUJCEGkgG6vhtYLBTdwMjG9yYufMW/EmDOkCKfg4SO6abD7AXkqqmnxJFQtgU8tTJA
         2xTVMSqTtbBVSK3FxfU7G+mDAqcAHa1kCzFRd849J/BT2LVAyBmdlLWHsw0/aFnb37S4
         4x/w==
X-Forwarded-Encrypted: i=1; AJvYcCXnyGXqGkNAj7lnpfUfyDAHOesxZd4Vg86vDFcwjoXf9cJ9mQgSt3O8aTVJpm1vQuuJk6VPFFj6T9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/cbREbt/cilC4ktLtRsXj/mesYbmLpNNyFLZJtwoTpWqGH33
	8rNifTjyC8O2cWkMaLhvp5A7KfgN6Bbfx/ADW0OyjmbUV4kgjwAXL4JY2d4RK+I=
X-Gm-Gg: ASbGncucI6kXLLurYRPh5/llWI/O4uSQsA2VgBz2525KWbtyzKJPIzqNEuIhaecURpk
	idzChs+rz+3JR42cryLLOxaY7z58xCGczROMNtEZJHzOTLm+6adc0CL+eWNGlt2/dQf60i3Veap
	H2dXMqUD6+U/71d7jxEPYGmLV6KosLEge/VNTj6ofWWg0uDL6rW5QeAh7Ih+3dIEEW+4JfDeT6n
	LYcL3K6Gv9P9MYDNZvqgmtTYt/tuvEpyJKqg19VW7Z5syWv+ceqMqtFcLyIT2gp
X-Google-Smtp-Source: AGHT+IHW84IFMyteDGhzkZH0GrN3c/a3NXNaK9vu1e0nBtdfhB4NZmQJ8kHa4BkJv6X+V3GmJqPNWA==
X-Received: by 2002:a05:600c:1390:b0:436:346a:fa9b with SMTP id 5b1f17b1804b1-436553f35e7mr11377415e9.20.1734509427176;
        Wed, 18 Dec 2024 00:10:27 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b1e8sm12181355e9.30.2024.12.18.00.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 00:10:26 -0800 (PST)
Message-ID: <a31de602-9af1-4576-872c-6fbe1a622a30@linaro.org>
Date: Wed, 18 Dec 2024 08:10:24 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] mtd: spinand: Add support for read DTR operations
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-23-miquel.raynal@bootlin.com>
 <589d95d3-9153-475b-86f7-886ec41cd4f4@linaro.org>
 <87ed2blr8y.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87ed2blr8y.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 12:08 PM, Miquel Raynal wrote:
> Hi Tudor,
> 
> On 11/11/2024 at 14:35:23 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>>> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),	
>>
>> do we want some names to these hex values?
> 
> I honestly don't think we do because it would be totally redundant with
> the macro name, ie.

I agree. Thanks,
ta

