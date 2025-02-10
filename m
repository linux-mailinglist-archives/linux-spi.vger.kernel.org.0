Return-Path: <linux-spi+bounces-6740-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4AA2F83D
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320DB1889018
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6025744B;
	Mon, 10 Feb 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iuum56RK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CC1F4625
	for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214607; cv=none; b=dXOyjcSDhnxCJE3UhrjAUoeKmlKS+LwCR+hjxvLJcRZ5vuRIjlAX/r9FN2DfG9LQYeCJdGYnwfFBhQLAlADgpIiXpnfmbYLSonODZLB1nYByqzt3JPa/DeKKdoQuyv3qLzW0V0fzwuvyajaDgnBHO5eIbzLV+fw5LCZDScS4f8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214607; c=relaxed/simple;
	bh=CYo3UFbDzM8ZMZrElug1khaiQNjus0j78zyH9dROJUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jc30oICPvvzV540bqUDAVdMhAmvnXJI2RRervjNONwTHtTifiu4v6vR7GYOpE8ZdWdtrMLjLqff35IYegDiWvwcsOpCho+hzlWjKkbsUXbYhnloTouEN1pfZtJWS1wnABiZso8FN/WMdl5/tQfWwczsE5SLFnAG75v5T5L/ZCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iuum56RK; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b86e13e978so1089263fac.2
        for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 11:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739214602; x=1739819402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vsAtouGNhuNZjNhxNxCI7WHMHLo2qB21REbxiQgCzo=;
        b=iuum56RK6V7l3nyAAZ/YZBbyPArS5UaCDXYrqlKcJULBMh80IxG9mD6QHvZSUnzLCc
         AYbCFf73DttoMvhiOxGp1zNPodJ/Rurop7+J0A7wGg1TqjDTl/nlTJ2vwelbdrBc4vk5
         UAIA6MxcBRQGm9nOkyOvL9elvIU7v9L6/z3DkBX3oSzA/KT8pil4WWeoVFRKvcr6BHbt
         mLSvnoqYFnxMHVHOBrMuK0XR4IQxS/ISvlkzk232MPYDYOLRrodfmTLDFpbaR1anai/J
         K/LX7OlTi2gbuEHgR+jbmJsRb8t6+GvTnP6Hftw563w2f6XUJLyvZ8A3WHvbMCYbxupW
         M1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214602; x=1739819402;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vsAtouGNhuNZjNhxNxCI7WHMHLo2qB21REbxiQgCzo=;
        b=r37qKq5LWCRitDFAsCl1+x8plRNntSEWGEBVCQUNHcpbHC7XM3Ho3L80F2D5PSyVNL
         nAG2LC2r7AFn7ezQR6KgGaCCCj+Bt1BbZIMBPzrJtxLS3tWUV3ghFO7gPfsu9kkHtIih
         6W5K0bvvnWRG9R6gwSwpzDkVCnUs07KoTAGOYYw2ydfcGgn8TSqb+W/2vIqOWxnj4y7Y
         b0sNnjfZdqbVE5mRMsbLdOPEnoI0AfyrotZcDnSuKfKJ0DRlLgecBvxkIFESamhL7xWg
         RbUi6GbcEzxftx5jQS2B9Kb5BPMrBBMIdxDu1EX9SdOli9IOvRV8n909YRfbImRS2gFR
         XryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE0shwDodcf85HNXe9pp6bqcFZgVoVVCQXEM7TVH9pbtVxfO0hIoHKWA6/jnkOA4idcGx0Q8pYlnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpbdLJAH94LoT/TYR4iuOcfadgjxsNG/bUJLR4qeZi4xa6/ek
	5sqCmK8y1NZBdR69nysIT9Ahpya4YkACIz7QGmVZXAb5E4OVMVECtgV1nfJ5X/c=
X-Gm-Gg: ASbGncu0cb+uMx1XUagutAP8ZVHn0cOOI5mg7XcttKsflk2BhUHXG/LicDAO74hj7eI
	iUKWyRPiXOvXqi4wXISSBuJ3kSd3B20LWDl0XOVyzSwciiUjIjsxc73LmDpGPwQS5d+LISfcVr3
	KpSzxqdStErFwwxnVkKrYA5zi2c1mEmTO+cvJv2PvXH70+hEvkcnxeqeSImSRjuuYKPudUPcQBx
	JKvQ2IoAL2kdct8+dD5avKyHA278jgQfKtTA0jm4N+Nfdr3+q3MDFkUXzsjvd3NeN4+cA1e6CF5
	z+BqwQwFM1jKpGEGxhUOTVT5BQxifPJyIDRwTsxkxZ7GIH9EiuhJ
X-Google-Smtp-Source: AGHT+IHER7vdDXVtlvelU+DDmdTY5CqQ89uA26Q9f+nFEBSkTZX9vzApNRcfKwxK+awhn+jiq0oREw==
X-Received: by 2002:a05:6870:b250:b0:295:eb96:9fd4 with SMTP id 586e51a60fabf-2b8b57813camr542383fac.11.1739214602443;
        Mon, 10 Feb 2025 11:10:02 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8262be143sm2669307fac.48.2025.02.10.11.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:10:01 -0800 (PST)
Message-ID: <f989c3d7-0fc0-40f0-8548-4d5dd1a336ac@baylibre.com>
Date: Mon, 10 Feb 2025 13:09:59 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/17] iio: adc: ad7944: add support for SPI offload
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-11-e48a489be48c@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-11-e48a489be48c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 2:09 PM, David Lechner wrote:
> Add support for SPI offload to the ad7944 driver. This allows reading
> data at the max sample rate of 2.5 MSPS.
> 

...

> ---
>  drivers/iio/adc/Kconfig  |   1 +
>  drivers/iio/adc/ad7944.c | 291 ++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 276 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a3e8ac569ce4c6b6b30b48acb265d530aa98e89c..995b9cacbaa964d26424346120c139858f93cdcd 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -360,6 +360,7 @@ config AD7923
>  config AD7944
>  	tristate "Analog Devices AD7944 and similar ADCs driver"
>  	depends on SPI
> +	select SPI_OFFLOAD
>  	select IIO_BUFFER

I missed adding

	select IIO_BUFFER_DMAENGINE

Closes: https://lore.kernel.org/oe-kbuild-all/202502082251.NuHT15R7-lkp@intel.com/

>  	select IIO_TRIGGERED_BUFFER
>  	help



