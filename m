Return-Path: <linux-spi+bounces-8838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2DAEC303
	for <lists+linux-spi@lfdr.de>; Sat, 28 Jun 2025 01:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B083AB477
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D56928D82F;
	Fri, 27 Jun 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hYANnAIu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2E1F4727
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067387; cv=none; b=gMs5SZd5QUz9Xw+YRopcCn3vp163tZdJku9jC4fadQOdIlZTILL3l4BJbcPTWtrKfEYh/ZIHgEqW7A2rHUV+IgYzQNvTnbB1g66LyRQyq/26kCSaGYY7T2falf2cYU444n9DxbTtes+k0ZNoGxYxwYmuTXhNMXbCp+1eTnFR0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067387; c=relaxed/simple;
	bh=ecxNgGLJ0ceg2mw32I8PwtVd+Bs6zCvgfvPYi442IWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrOpuiqg+fFCUrAjdRZymF88/ewRCOuoRqRfQkZ8SwMUbOEMn6yQ0JdzkUe/CwgjABzsU79titcKnW5IVtHkCuVpRqA5eI458u+OWxJDJheCfOqRmBDusf3nSypolCj/6wrbo2878i5kHzKMeiXjgIeoudPrhpA9VgLomd4xzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hYANnAIu; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so1919198fac.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067384; x=1751672184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KS5+5awS+3+wXbArsBYmZlO0Z0GYxJERA5jSGiTS01k=;
        b=hYANnAIu/ShF1cngobKyZ3e/Ql0pBBO2g6du8ulNviUq/sgS+uDkdRDYNiYj8IqZes
         mkvOtUXrfVKtd1o+PqTHdkAKy2HNz0JHWqezB7qmDiwFCK7Sg6ypcirW1DJVUz3envoM
         jLcIgqcPrIih6rbSmkQg/5jWGus1J6Ak2f2s3mC6YS5trLBhrccSCB9z2k/YKmut3kia
         Hr/oTsEXBS2Gouz2/g+yGlafrE/hAgRhNDqMeJiUPVxTieYb1j/7XLnMiA0lpmpSnflB
         5UUuijkv1Zr8GMVKw8WecsdvkrGtIh0LbioLkJnlgupqPPt/2+xf+gG8bSGzvoju93en
         ax+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067384; x=1751672184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS5+5awS+3+wXbArsBYmZlO0Z0GYxJERA5jSGiTS01k=;
        b=g/WnrxM3vFxm6+uZJ8jbwLgZ0F4OB9eFbTSBZp17VBI4fX9qWm9UUqKadwGHdQ2ccA
         4KUJX+nX9OkNeYrruChuxZSQ1cGjaftNO4hO85f2/pqoC5R9EI4QNRLdd6cuGPWAmgzp
         WshrjdXBb4Kg11nIRjBvklaeJCDTJN+qRciMSVXKPF2RFzERpxnzsMmpkKT1saD2ZJKI
         56TsXTn8Rz2BYtSgFSc8I4xHMdwYc7CV7sJg7cRojKpS60S3OR15BV7fgPh+Q3+Lrt4r
         IIh0bI2VLjHEeA+gqgmQpdQKF2ioFqEfq1r6D/BpgN6SHZWGSyLhN1Qso6E004ejLdy1
         6A4w==
X-Forwarded-Encrypted: i=1; AJvYcCWq7wiXEOXyJSqwwPwXBVpFRVW/q5hotLlbKUd5gDeO1NIzGBIO5Khpcg3plMqVbdeCuSOMeuv2YdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXiwJcyFeFkE4AS7Mg6yIFnxPgRj2ePJ6seooduhhvAKGRGCr
	Ykqzxjn0/F0m6kPgQQFFAwmJ5c7im4mY6a4zFAD0xyWAtclBSG5dU9FUjMcWBFWtqv0=
X-Gm-Gg: ASbGnct/S2tCCioNlJizX7EavrgYAeLpDrwJ+c0k3W/O4uFnj2zlaxNU40PmerNCWa/
	HhJAgvwag6DHZyqfMRsyzUXPw7dnm/8Ehtj+Ea+o5VykqDMKc2DaA8PWOcr0gYzBhXO8lLUWfPh
	jqhIqL9tNumN6LBFiNFnviS+3/EsISAbVx/zhKAp8YuFhK6cKa7sLJgc5bIWF1Lg+xFTxsrzPAQ
	hf0W6oTCbRjom6FQcub7WGKEBoPyEy8cVbxNNVgmooHDsjJxMrI4AKVq+hcSzpdrxpcjfQ7bVpU
	VU1smRxRY/U2spMrnz8QzrN1T3RnECJMRL8e99i0romFGE/sBYsDdBVo9T77AtXuF0p/IAL+gKA
	nMhtk6Oq1mGF2/5xdeZ19/sIzWvNACGcH+Iyw
X-Google-Smtp-Source: AGHT+IEssFT0wZJYugWiw6Jgk1s5LByepHYNeiyjZJg6Qq+SSxEoPL/QLwyMcPPeh+MamQqKsKqBzg==
X-Received: by 2002:a05:6870:7905:b0:2ea:841f:773c with SMTP id 586e51a60fabf-2efed759ab7mr3742580fac.35.1751067384200;
        Fri, 27 Jun 2025 16:36:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4ef29absm1128704fac.14.2025.06.27.16.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 16:36:23 -0700 (PDT)
Message-ID: <c1ea7287-a1a8-4d77-97fd-f341d2412005@baylibre.com>
Date: Fri, 27 Jun 2025 18:36:21 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-3-0766f6297430@baylibre.com>
 <aFj6Dv1kKFe9ijvr@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aFj6Dv1kKFe9ijvr@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 1:54 AM, Andy Shevchenko wrote:
> On Fri, Jun 20, 2025 at 05:20:09PM -0500, David Lechner wrote:
>> Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
>> to bytes.
>>
>> This makes it more obvious what unit conversion is taking place.
>>
>> In once instance, we also avoid the temporary assignment to a variable
>> as it was confusing that reg_size was being used with two different
>> units (bits and bytes).
> 
> ...
> 
>> -	size = DIV_ROUND_UP(reset_length, 8);
>> +	size = BITS_TO_BYTES(reset_length);
>>  	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
>>  	if (!buf)
>>  		return -ENOMEM;
> 
> Hmm... On the rough glance this sounds like some kind of bitmap
> and hence bitmap_zalloc() (and other bitmap APIs), but I am not
> sure.
> 

I looked at it, but I don't think it is worth changing. It is
really counting clock cycles, not bits.

