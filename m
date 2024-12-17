Return-Path: <linux-spi+bounces-6087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED39F4F93
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FCF7A36DA
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D51E1F759E;
	Tue, 17 Dec 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PPU2Y2U/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019581F7574
	for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449765; cv=none; b=A3HNcSFvmb0WSiW4K5Mg3PeeELfXvSKf9RWPBJAgixf2cewDLeWldtmHC5nba1LNwB2qIeHBNKRS0j9k01+Tc7n0021EvDMe24lRmXUMOfzWEXMLVTf6ZPEqZsT+dkT0btsqq+EDlF13oG5AWEtmRlr6pRsqtN03evGL3nVsQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449765; c=relaxed/simple;
	bh=Cfm9tPZMQuiDcp8WcnIHSSo2kAMsYiiKt/FMI+6TXQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+o+u8F/V2wmeRfmr6QMbhFCF4e1J4dMHgVKHWtizn9S379sVm0McMsgthrLFXfRYv0VOWuEYSaBGaK0nz0JAUUiuGSGLP1IZP45rMk58r4n2XR2RZdXOv8wW/Js3ccOrSZSxnOsMof6ycgRcdrMoUHPiqeWkb6wrq3M6MP3aV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PPU2Y2U/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e2766994bso2390578a34.3
        for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734449762; x=1735054562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hSccYkNiVo5Ab7I2cIln/5c0RMqcFycYPtpUe98zEE=;
        b=PPU2Y2U/EkWg1+Xnuj8cdx/1XPrW0dZj2TY/BZkpz6jLspAj0RZNLro9vBsQoRNruC
         TZwS7vEkbkBwuKE70CwgJjgxkbioEvygkQFIqWNqfZD+i85ZBxNsIXLL7KNYEn/GAD+U
         48dMvgvloDXw9/6/vu5ut6qZL+Mc+wXoZ3k4L2EDtHMO7q0nGjEOs+9hpuVrdW2XLKwo
         zAbnh6DzZBzdSBIcFbpvuG78w46eAEsnUtTZirEk/rfMC+/pVtLOj60bDvVBqHo94uH5
         Gh0r28fEqCDHRNeOoBJFMf3Y5obqFllTUAOGAh8WFblEamhDf4OE4ryr5004gT3mgePZ
         j+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449762; x=1735054562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hSccYkNiVo5Ab7I2cIln/5c0RMqcFycYPtpUe98zEE=;
        b=S26ab0K8+u5KASZtL2f3DEATa+BvntDw5gQqj/paGYa1PbTMek+LZOwui6KdDrn0jM
         9236D3WVTxCyoMwnvcb+d6Hliy6NHYmvHowIIE8axZN0EKQb5RuIS54Ecxoqs9cVShwM
         M273NTlS0623/GZRaHo8o0xZ44s2WJPIx1QFEM9f4Gf7tY+2whyWFK0kGx3nfUklgOav
         oqEBQAW0mi9Z7KIpLWsJYFqeANIxyr3lFMWPI7+yxeSd3Mkmhlkl14Ffyiw+cqJgLdsS
         Frh1nb5xLEvKLH3dPCisKW9PPu7O2dlXB5NbKrKuDGiHHvM8iux/UMl1b5wziyP6w87s
         EDtA==
X-Forwarded-Encrypted: i=1; AJvYcCVsp6iq2WdvMq3ElpgHI8y/Fp1/MrSlkBDtRmUFKUm6dGfft1hVeJthGetk0ixiGqj4FG7Kk1jKHuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAtKOrUtW7zpXCRT4X51xuMhnhCCGJSwK25uKPK8sadPLqlg9
	bZgWrr+ALMoPeHW/7gTXQDWDk5inCVTsDf1l7Ej+9B34rGW4WfoOxXXd92cvH6c=
X-Gm-Gg: ASbGncu4smIUoTkbUpfglOQVEXxE/d3WPvDp/8oRlq98AJhfeVHWi0jDs2oOcpZ4E7O
	lq2Fsf271Tsbyl0FfW09wl4rHTNZt8lXuVO4HEgk8rWPqxn1StqJPbjNwUtcT8Zvx2Bn/qRHNk2
	wBMxwMYRHQrzc7h+YQylOmVg4W0KXfHIbiEvOnK+VmZOe3fGnsM9m0UOHsdEXs8ueuPRC21DScO
	74CGarTMqNOW+X/jThWZj6qBD+Gh8c1l62jAp9FXeMzP+nOoAOdqB74QvOPBWsWUTQBZWrlihe8
	aP4eZJ3rtKykUTLHvA==
X-Google-Smtp-Source: AGHT+IH/2b6LqFTsioT5QNM6/l8WG+PKjU9zlTFidwxxoump2J5Z1nfbAzJbXJkDBI/fgk1AuuDE9Q==
X-Received: by 2002:a05:6830:3890:b0:71d:50f0:afc5 with SMTP id 46e09a7af769-71e3ba3afbfmr11522547a34.21.1734449761967;
        Tue, 17 Dec 2024 07:36:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48307815sm2069053a34.9.2024.12.17.07.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:36:01 -0800 (PST)
Message-ID: <8dc22c7a-f1d2-483e-8b69-cb5dc494feae@baylibre.com>
Date: Tue, 17 Dec 2024 09:35:59 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/17] spi: offload: add support for hardware triggers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
 <20241211-dlech-mainline-spi-engine-offload-2-v6-2-88ee574d5d03@baylibre.com>
 <225da1bc0f0b9407c3f7b3374cbbbf6cc6b43aa6.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <225da1bc0f0b9407c3f7b3374cbbbf6cc6b43aa6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/24 5:30 AM, Nuno Sá wrote:
> On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
>> Extend SPI offloading to support hardware triggers.
>>

...

>> +static struct spi_offload_trigger
>> +*spi_offload_trigger_get(enum spi_offload_trigger_type type,
>> +			 struct fwnode_reference_args *args)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	bool match = false;
>> +	int ret;
>> +
>> +	guard(mutex)(&spi_offload_triggers_lock);
>> +
>> +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
>> +		if (trigger->fwnode != args->fwnode)
>> +			continue;
>> +
>> +		match = trigger->ops->match(trigger, type, args->args, args-
>>> nargs);
>> +		if (match)
>> +			break;
>> +	}
>> +
>> +	if (!match)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	guard(mutex)(&trigger->lock);
>> +
>> +	if (!trigger->ops)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	if (trigger->ops->request) {
>> +		ret = trigger->ops->request(trigger, type, args->args, args-
>>> nargs);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +	}
>> +
>> +	kref_get(&trigger->ref);
> 
> maybe try_module_get() would also make sense...

Even if a module had more than one trigger? Or do you mean
in addition to the kref_get()?

> 
>> +
>> +	return trigger;
>> +}
>> +
>> +/**
>> + * devm_spi_offload_trigger_get() - Get an offload trigger instance
>> + * @dev: Device for devm purposes.
>> + * @offload: Offload instance connected to a trigger.
>> + * @type: Trigger type to get.
>> + *
>> + * Return: Offload trigger instance or error on failure.
>> + */
>> +struct spi_offload_trigger
>> +*devm_spi_offload_trigger_get(struct device *dev,
>> +			      struct spi_offload *offload,
>> +			      enum spi_offload_trigger_type type)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	struct fwnode_reference_args args;
>> +	int ret;
>> +
>> +	ret = fwnode_property_get_reference_args(dev_fwnode(offload-
>>> provider_dev),
>> +						 "trigger-sources",
>> +						 "#trigger-source-cells", 0,
>> 0,
>> +						 &args);
> 
> I guess at some point we can add these to fwlinks?
> 

Yes. Although we'll need to investigate how it would affect
leds since they use the same binding. So perhaps we can save
that for later since the rest of this series seems ready now.


