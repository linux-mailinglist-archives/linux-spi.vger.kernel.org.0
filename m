Return-Path: <linux-spi+bounces-6827-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD0A3576E
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 07:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD4C1890D48
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 06:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B943204C0B;
	Fri, 14 Feb 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALffev6/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8418A6D5
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515991; cv=none; b=JiW27nS2EaHSijqW/bsT1w3vX2PHIoReAFM3uia06wPg8hSWKMFg+CE60Xwfw25ui92aTAMBBJ8Ke8uEUuu3tcURFWpgJOKM79lleXluzAt5JgBduXVMXR91izPiPjBAJx0oJo3xiVA1+7CbfWjQlW+n/HFW8ArWE6hR/RUeru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515991; c=relaxed/simple;
	bh=pfdkkHyh2t3osDFLju+T4VzcDn1ZPpl25CDRF3LIv9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gCDi1rK4md9U2/h6wuDarx6YN9oZr6gzg2eOyOnhwdidzC88OkHIR/3+JcAOck2NyiAXGSG0/QoXtc4X8TktdPQ6I5PCx1MsyQPQRNCBMzcZMDXBvyOfBOc07vRzhvT+4E7PPmWxllx9t8+7q7FsxYYuWPrV5NySsv7BsJv40iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ALffev6/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso2968611a12.3
        for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 22:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739515988; x=1740120788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00T2ImKqG2q8X/m5/Khez9kmb7XoPbfhx8Bnox/fhX8=;
        b=ALffev6/MPXYX8SjyyVK0HhjbbEqDz0avxA3sv2oxkeUkpXpPPIP7vyHRrJQVlT83d
         wzNq0hTeUAnDXVXsk4yna1kHO8IoGZ/AbhDNHdVeqtiu7AtSkmfZOfolfhd4RzGEQ58X
         y4r4845r3G550/C8Ax1U2qO+ytceM3lS6k+HFhVe1BzHHQUm81GFlD5OGXM/XsWLkk0H
         5xQAJAvd1J8fpWssoUEFFBosbBcy1c+dwQy8xkQ3qUS+F+NQEmGMHFRn11lN+UhjkO2h
         GjG2i8P1VxizhH6f2M1ruEgEaLcdlRfp2kYL8o53J/ISn3SA+cGGBTlfIIMmS4AlUXh1
         d2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515988; x=1740120788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00T2ImKqG2q8X/m5/Khez9kmb7XoPbfhx8Bnox/fhX8=;
        b=RGij1+U6HKvupH9u1vy/2GGAzyzN6xoeZTtTwK1V6bdCttek0ikpYCncZuVEUHKSta
         utJ6+at0N7K1kGlZKqiYIL/kbK8QvuO98lERemPwi5Y7etjuFEVQ+ils2Te4wQ0sxHK8
         Kbtnax6E9FR0IAuPuVI+BldLgOVydACbxRRbODen0xsLKqwhKXncyM3ZNCM3Ag9wDpud
         2SLExeK6D3o0ue9yWlWWUjfxGg9iaSeB7M6rYN2FKNJYA1y5jm9Gis5EkyIm5IF69Zff
         9H8heASPTYx6R5YeJD71tdiedB+4MMj/RS6lIjzvO/1Vqpmk1oIa1N+5M223h+QZO9RT
         ynpg==
X-Forwarded-Encrypted: i=1; AJvYcCVGuWILsDnuK1cDWQJg/Z0Uh4BqRpzvSEAlIeuVReg1+60WOlLpOfCsSyFCWMoR7V2lFyept4Wp5Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRADWqRsfDPFakh7bpefiDLjRUaUwMNwPUg2ONOHYU8xa7EiFY
	9m3jRoBI5FXo5kuQ5lTy1OFGPyrQmNnduM259zx51ojcyG6a897gE1NidfTqDSY=
X-Gm-Gg: ASbGncsf/pxmKOd4s0MY81+OHYH2xb9oazdF8HFK58J86AfCT2zelUanZLzodI+RFxT
	m31fAPfsQHzZGE5KHnMrzV5cfzRKvpPztmE+WkYMqXJJLLbcIepbPQVvqurlHAkJcuTt3cUpPzj
	tnFrK/ZLdTu0Py8pnm4d2x2Od3knsBFuUKBcyTDqvGgkh/A3BugvZbu3fXg820+E/lkI6xZvTHe
	gTOOl3030WfqHOpgKl0WpzJfuWVwQpkP7dbHDOZLQSs2GG0h3zqC9lYzExLk0tPHUwI+QV9baNh
	8V31Yw24PKbol5JydXyM+bri
X-Google-Smtp-Source: AGHT+IGXgRThBo7whBqMDD6umXjpqv2Cx6RqhrMtLSVb4XCNTRlLfTHBJzqRYVPktZC+1NWyeqaxJQ==
X-Received: by 2002:a05:6402:4025:b0:5da:b64:e5d4 with SMTP id 4fb4d7f45d1cf-5dec9fad55bmr6890118a12.25.1739515988458;
        Thu, 13 Feb 2025 22:53:08 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287c7fsm2379602a12.70.2025.02.13.22.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:53:07 -0800 (PST)
Message-ID: <4dcf3258-5e98-4f6d-bce0-e79c36f1f8ca@linaro.org>
Date: Fri, 14 Feb 2025 06:53:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
 <Z67VP6zMwFcqFurH@droid-r8s>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Z67VP6zMwFcqFurH@droid-r8s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/25 5:31 AM, Denzeel Oliva wrote:
> On Fri, Feb 14, 2025 at 04:33:40AM +0000, Denzeel Oliva wrote:
>> Changes in v3:
>> - Reordered fifo_depth handling in s3c64xx_spi_probe() so that the DT
>>   property takes precedence over the default value in port_config.
>>   This allows node-specific FIFO depths to be applied correctly while
>>   preserving a fallback.
> 
> Showing evidence:
> [    0.339111] s3c64xx-spi 10920000.spi: spi bus clock parent not specified, using clock at index 0 as parent
> [    0.339119] s3c64xx-spi 10920000.spi: number of chip select lines not specified, assuming 1 chip select line
> [    0.339467] s3c64xx-spi 10920000.spi: registered host spi0
> [    0.339589] s3c64xx-spi 10920000.spi: Samsung SoC SPI Driver loaded for Bus SPI-0 with 1 Targets attached
> [    0.339597] s3c64xx-spi 10920000.spi:        IOmem=[[mem 0x10920000-0x1092002f]]     FIFO 256bytes
> -------------------------------------------------------------------------------------------------------------
> [    0.587452] s3c64xx-spi 10650000.spi: spi bus clock parent not specified, using clock at index 0 as parent
> [    0.587462] s3c64xx-spi 10650000.spi: number of chip select lines not specified, assuming 1 chip select line
> [    0.587847] s3c64xx-spi 10650000.spi: registered host spi1
> [    0.587986] s3c64xx-spi 10650000.spi: Samsung SoC SPI Driver loaded for Bus SPI-1 with 1 Targets attached
> [    0.587997] s3c64xx-spi 10650000.spi:        IOmem=[[mem 0x10650000-0x1065002f]]     FIFO 64bytes
> 

Why does this prove that the IP works?

Can you do a loopback test? See drivers/spi/spi-loopback-test.c

