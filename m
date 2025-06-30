Return-Path: <linux-spi+bounces-8916-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CDAEDF33
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EDD188F2AB
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012A28B4FD;
	Mon, 30 Jun 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v8diNR3H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533928A73F
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290444; cv=none; b=hT0p7WsDxcFcbwZ33knIoiF4pm5UR9531oMdd4564LvYSwcGfoqgpPBNx2HMCa5gH/H3CerNLjpTHD4tKYE/ft2JTu7eW66epZGPGMXOwtmjwUjh/m17LZgA7fBRH8UwQUBHcEhN0dQjZEkd0H1wddjIqIM3IQ9SclNxPeb5x/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290444; c=relaxed/simple;
	bh=+OYEUNuuqfT76DUEXC9cb8th/BNnZVNtFEhDcL9FgBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpM/zy0cI7qLPBDSVAR6mJr2804YRFcuNgYwXOnbu/03lArw6HPIFsYtuG2vhd3M3txyYLYssufcXijPpDvTZGG9zUuuZhqQ0DBuM1HB3YV+ryaVrK1gvkAeRji2aqGpUmCOszgqWViGQG+P3FUQ9rUoyHQ0jOLlfENjLlns8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v8diNR3H; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-400fa6eafa9so3082014b6e.1
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751290442; x=1751895242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BiiBnavNW6W4WxDDv13yLMK/TA99VJbY73iccUOu8o=;
        b=v8diNR3HsU3PDvWM/sNs4zmM8sIO1GHPl+Ku3+XOFYDi8aWK/kcRyCACuKux2Splt/
         bm0uq4yaKt5qeSApXvNk/KJgsZxS+pfLZ7lE1TGp6tE9h54VYaM9x1tbPfi++3X5u5Xk
         kml4V/8LJG1vWB01KONJQkbluOkF7X7IlwI/w9Z5zey+QgdDnxNwLxeesGecs32FVOZ1
         WAzI0BZPJlSQStnAbYoSduibF1GWOQhUh7qPOKfdydr2Y3unto86xIXRvas7P+y0aOKu
         zvAQmlNwNKBYEuXHtmR5b5NdVTldXG+Fl7T9/5B1s/GYvulieNz+IGpR6BDbHi4M05WC
         y8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290442; x=1751895242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BiiBnavNW6W4WxDDv13yLMK/TA99VJbY73iccUOu8o=;
        b=IronhvltMdvrlfGds6h8DaiFghSJG2D43yxLwBWRWsfM8L1nooC9DTdDxeBPxWW9iy
         CBd2jH7PiJVmab2nkR23teFTRbb/JxKCfJYEsZ5umjTuRNO9lAvlwe4vKZoXPANQTIxm
         G06N0/LT7akTJ/ZO+MI0DytGPtKo8sZjgL8uN5FZPMLu4ERFxQAUphK5FvowKglQKGEp
         scL2uskVlddvUu0PCDIIky0vBaOAhHuUlgj/d1Qo7b/cQddWVRLx9m8p2qkMpAk9wFf+
         xGE8Y9MOsK0sCFkWxy3KNVH1TGVEnFggRM9MijuFYoVs8nlyS0sA78PnC0pzc4K2UhO6
         x3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUEVrNHe09AP+uQw/78oRJwewmEH3mYaZw+06+e5F8unNm8AcJOJY9vbr+A7dkO0M5Q24+LcRAW+lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/1XbC5PjmL9tizmHzXg/wckVJCB8otql98vFf5Rok90J5NHH
	AUAHrd4ATF+1rmUNuBYr6UUbcai10j/nhp9fC7aECibnLo9H5KZjRy6H0H1McN3I1C8=
X-Gm-Gg: ASbGncvoAYygZkgYdRMHuQNbeCWzn0Ej7S2vjeGCoPnoW8j9VmXM9kDEuHjHXsq5kmE
	/oBxb9CIV2C0c2SYVQ1TV2Tm+i34wckJTPXyoR5j83fp2lMS4U9YTCyN9zESAmQmdgDkYWTJg5h
	89QPePIInS4CnPUuu7lRwLTxIZIMQ3qBkTaEtzzb07Fp5qeAY1ns8t0r7l9Ce6hnKthFVVvDBND
	rVrVlNxrNdFlnEoPClzk0jHsWbBUKFUFO3hDT5NFavfU8kl1naauvLhwFwAskdMXiEY8E7nAX+0
	pBQL5LQxkxagrjJPqR2hZELptcLg+Ey+boZspUj5mI95w2NGoRa4Kdu+vAL0mymeRd9hhsfOwQZ
	lkSIhfOtKYrRMFKCE3fO8VpR6EVPEQlaJlzjKO3k=
X-Google-Smtp-Source: AGHT+IHwwHp/hPBSXiWOFPICfvksDPCGUtg2Iq6Zl8mO+cjrCNlALoXBQc3229XEU/HYM2O/8w7obg==
X-Received: by 2002:a05:6808:80c9:b0:3fe:af08:65b5 with SMTP id 5614622812f47-40b33ea62f0mr11211317b6e.37.1751290441614;
        Mon, 30 Jun 2025 06:34:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4876:5a0d:2fea:6208? ([2600:8803:e7e4:1d00:4876:5a0d:2fea:6208])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8474dadsm1077151eaf.5.2025.06.30.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:34:01 -0700 (PDT)
Message-ID: <e4c7296d-6afe-4edb-b26f-44218e660a80@baylibre.com>
Date: Mon, 30 Jun 2025 08:33:59 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
 <20250628155643.7c18e023@jic23-huawei> <aGJR_YyW5tCMjxUD@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aGJR_YyW5tCMjxUD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 3:59 AM, Andy Shevchenko wrote:
> On Sat, Jun 28, 2025 at 03:56:43PM +0100, Jonathan Cameron wrote:
>> On Fri, 27 Jun 2025 18:40:00 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
> 
> ...
> 
>>> -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
>>> +	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);
>>
>> Ah. You do it here. Fair enough and no problem wrt to patch 1 then.
> 
> Hmm... Should the second 8 be something like sizeof(unsigned long lone) for
> semantic distinguishing with 8-bit bytes?
> 

Yeah, I considered to use sizeof(s64) to match the next line, but it
it seems like a separate change, so in the end I decided against doing
it in this patch and it seems too small of a thing for a separate patch.

