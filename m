Return-Path: <linux-spi+bounces-2655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10668B6C5F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CDC1F21BA4
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AD45025;
	Tue, 30 Apr 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2DTlniL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7F4086B
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464061; cv=none; b=j481JtMJYvI/1BlCLc/kWeUTNfyW42Ws8LptOP4fBiQwLZxlZ1LGjitR73YPcDB4ICOHWQCPmykhJjoQQa7nLukL4YdyRUo/JJOfgf942tduHyC9Np1RL8OMYN/x809eAWvVfZqmrVbwyAvnWDEYOV7709rPqLAcQ7Bu1ZJ/X8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464061; c=relaxed/simple;
	bh=dPf4UEqQCw2LaZ1eeiZsJ6PiGpuZaLeZZkNPI+mQXUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxF/L1GJ3qKsO8AXBZNpAz1u4cb+b14gkb3oo2MkwbLglBv0djBz0TDzt8Kc+MHkcQKSvRzfQA/TNT3EP+MiY5j6o+rEt7Zfv2DTRaHTZlE1/3SZnWeEj1KMXCz0WvJVFvfAd4ZQCxPwJo+hozugdD/bxi8D72aRv4Gj1TyGI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2DTlniL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d3a470d5so6654029e87.3
        for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714464058; x=1715068858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl/4sYkUY2PAAIjugPUNoG61Eymx4LWnwcn+JNq28QQ=;
        b=N2DTlniLrJ8oQcd41+5aK5ED144ztX4Y7ubfWXU8Y9+viQdgopLPLqwFuOvt9yL3Hu
         kKcy3F3sK6YGw37ktfhRgySdhpNde8TiCqA0ymX2n01f9F8VTiQd+jqAn0EWppDnPJ9u
         kwhLo/TfeGdDCHLSfzbqMRrqd2qHGE/UJxzxI+PgHniBII/Yk0NXySf1LAV/+S7RbCia
         gLMIm7cEb8qUSoYY8fEiBJYz8Pu6b4c8tKKt3OhxXIIsasiCpyXko9rmn1hwumO2enZZ
         dI0D7IsJmNV/VUj7FM2+FNUKInD/uB6MP97aPH/TOtQv7zsjc3Zz+mFUzW/ZT8EG9gUB
         55sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464058; x=1715068858;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl/4sYkUY2PAAIjugPUNoG61Eymx4LWnwcn+JNq28QQ=;
        b=bUJQaS5XPpjoUG7i4s6zE9EJ4Se7Bnu8aCIXmdxX3FV6BHr+zHxcNVz7IunGiENWmn
         in48TmNN568VacU5GimM7YUj1BcYriqQG6UiqlgY78N50RaacJCh6s9YNjklxNU3acuO
         JMTsfxgWLK+jwlncsdNTjmdbyBZeV6OKNLmHeWAXFjxLiuQ8NUbYp1JuYHQi16Qv21Gc
         GdN8KrFmgcPDBn5TEq15K6y4O+tAJfYrmsgb+nGNZMlBPvMfV+XfFXRMvdf2dSAEVizc
         NyKySP9+Gm8jqUpwO34iVaghFOTx9ZK75DMm3W+EIKnxVnu0ySUFLXDIm6q/Tc5TGSKc
         M7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTOmklJs9hFzvee0gRYLKwhhEGE2iGNb5Sqd0bI29U61prYfhly5HfA1EstGHq7dSywQngpE+S8FiKLlQWfLkrCalg4fGOQD2H
X-Gm-Message-State: AOJu0YwzYfKsCQNqIEsojUlza/dIh47GLYjQMxyCZuPJUktyh8CJqQAJ
	J/0xJWtGrM14yfiBFj68gIb/J11MkQdIrWCqoopuNsVYudnN0SanXwJQYzoaCIk=
X-Google-Smtp-Source: AGHT+IHUNmed0l6wwAy40uJ3RW4/qBxqxBAs5tWbO8jcSaVCNn2pSO4jliO2sfooQY5m3+A7q2U+qQ==
X-Received: by 2002:a05:6512:1328:b0:51c:8b45:c9fb with SMTP id x40-20020a056512132800b0051c8b45c9fbmr9768612lfu.69.1714464057560;
        Tue, 30 Apr 2024 01:00:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g2-20020a170906348200b00a51da296f66sm14746948ejb.41.2024.04.30.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 01:00:56 -0700 (PDT)
Message-ID: <2dc18bdd-0c82-47a2-b87d-b69028f3b251@linaro.org>
Date: Tue, 30 Apr 2024 10:00:54 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
To: Witold Sadowski <wsadowski@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "pthombar@cadence.com" <pthombar@cadence.com>,
 Piyush Malgujar <pmalgujar@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-5-wsadowski@marvell.com>
 <16a4a58c-cae6-4b62-859b-3661c052468a@linaro.org>
 <CO6PR18MB40989F97F92C9A37C6BA896DB01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CO6PR18MB40989F97F92C9A37C6BA896DB01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 16:30, Witold Sadowski wrote:
>>>
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id cdns_xspi_acpi_match[] = {
>>> +	{
>>> +		.id = "cdns,xspi-nor",
>>> +		.driver_data = (kernel_ulong_t) &cdns_driver_data,
>>> +	},
>>> +	{
>>> +		.id = "mrvl,xspi-nor",
>>> +		.driver_data = (kernel_ulong_t) &mrvl_driver_data,
>>
>> UEFI provides compatibles for ACPI? I think that's first such format in
>> the kernel.
> 
> Yes, that code is not doing what was expected.
> Current usage scenario in ACPI mode is:
> xSPI block with HID PRP0001, and additional compatible package set to
> correct compatible string
> With that approach only issue(in ACPI mode) is with matching device
> with data field from of_device_id. It looks like there are functions
> to match that when DTB is used, but in ACPI mode it fails.
> I believe solution is to traverse dev->driver->of_match_table manually
> To match device name with correct compatible data structure.
> That will be included in next patchset.

PRP0001 should be handled by regular of_device_id table, of course
assuming your kernel has build-in CONFIG_OF.

Best regards,
Krzysztof


