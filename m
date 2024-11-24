Return-Path: <linux-spi+bounces-5826-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E569D7723
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 19:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785B1283B0D
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7724C13BC0C;
	Sun, 24 Nov 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lHz+KnxC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D313774D
	for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471761; cv=none; b=UdD7g6j2YdV2UM6Torrl4TH/PAeEMdF59EwF8lR3hMVk9xWfA1fO6LrpKX05F0kKFjgVty1God13T9STMEVqI1A7LaVBfUp0QM4J+v2HgQGxjeubloCYt6AWjv3ZmWOESvPFaE8QGi3VL5EuMsOJpYf+E3zwtOqIEGAGCvEdjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471761; c=relaxed/simple;
	bh=OS2YgouWnleLhGzWzcMbkZozpJy4/ZIX9Yembq3gx0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP6Pw+MbfwcJUmsds57PCGLorxJk4UiX5f3CmZIWlCh61/IA4SlF2Vu+mQTAMg2bty7f7AAXV/PVmIyJPJ/+F2Yyou4W/KxCLdiem7IhhKozgIEeoBENtrWtC6EaBhhSHobyi7/pEDkw1zr/fK1HyIcYkzr8ioZRSh8hbWdKwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lHz+KnxC; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2969dc28d9eso2314485fac.0
        for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732471757; x=1733076557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbrpPqHdrj9PFgk+4Wq1DD8Ou4SpdLfhgD5wtbRIbGA=;
        b=lHz+KnxCxkeY/oHGKG3C5qzy7VCRCzBQ5BcizR9kBcbhq6gcTPHxcndobGevoazNnw
         bMhr7RKRSJtfWtdtrcdSl9vyjGZ+EuYWpN2bIThzyYz6h67vDkR3IrjF95r2D/m1SkiV
         974pk2Gi9UTDRVF0yTVMEFCulgl/k+0t0kbdd8JzE853lXIT/O2F3x411n1Q6y4VEcMc
         TQ4h4nuIBMvRT96a4bPyH1JMrSXl+OE3up8ge8WlBIfKPjdJAgVDG7Q7W4kPW4NkQZ41
         sw7FYFf/VB8UagQhLoBSqQiAQpzPsFL10ldW8jxTGurEdIfgL4ClRLQsyAuzhe4V+W/6
         tjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732471757; x=1733076557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbrpPqHdrj9PFgk+4Wq1DD8Ou4SpdLfhgD5wtbRIbGA=;
        b=R+8HHoKeIkLlTHOl+jiYy/v65Krs7b/Ia0+hi5xgCpbaUdyAqkqBEdcE+bjLWz4Urk
         MrYOcJHscLm3DsYsF7GG7+qRYXi21c7B9NfHUVHMxIYdxJcbjdBfFvJtDeZgDJfZUJ0M
         7iSXfSUHk01XP9ePeqOeTv4jfaWJkXOzsFPz+dIX35VG3q/izz0EE31nWJZ7Dc4EG4i+
         OM/Uy9jiRTo2iiKdNf5kniG3sQRQqFEAg4vMCvPgX/r5UDiMLAaxb8U7LZCuvhI5OvcE
         RLj77faoQ2lY86+KJEILwjGBdl8k45cXqZAaU6ikyMmkcXvXp7/BhcrQQ1J1QaMx4gWb
         oBPw==
X-Forwarded-Encrypted: i=1; AJvYcCUeYHrpRyVhtN5bO73CHL+LhSpsdujMAsW4EOvOS7MiFCnCvAHI+BAc+5DpZdUz+lWXyNb7mBx/x1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3JkwzcUkwaZM71iaZpmCL09551jHprChLp2GsxnBg5vK4wiF
	KHyfsm6QyfdCBPtTe4StOlE8oCqjtPbT9pztVHfrfTnrbrAaAdwC+om9cbEARSA=
X-Gm-Gg: ASbGncvrOjNkUPdVDbMRN6IxN40yuMIN/dJ8F+LeLHw48QpehkZczuS7+e3NM3v8+QI
	cpcwY3MfaPw0rZlEluyexaZy0DyD1tWRmScuTjo+gs0Lyz+VAQrSTAYro8rj1n91a68JltMQh0h
	Ryf4Xzp2AjQS3sgWOzxySP5No69mcKWA92PCKCpt64dej+mZ0J7f7LEz86f7JDk1an/pfXg/ypF
	FoL62Yr9WYZqkSZ5YdvCBgap5tLPYWD2uawNdTf2JIhpoeK7WnYNGumNR5bKtnc3Vze6WbGvfHm
	2tTjds29dF8=
X-Google-Smtp-Source: AGHT+IEzwEPi/bhzze+PgZn55mPBNYsjbszsxETt/PoHs+MoO7oND02el0mzU2DxDgU9xqYWs68w2w==
X-Received: by 2002:a05:6870:b01e:b0:296:73f2:b568 with SMTP id 586e51a60fabf-29720c25d7dmr8103617fac.19.1732471756869;
        Sun, 24 Nov 2024 10:09:16 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d882c61sm2348195fac.46.2024.11.24.10.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:09:15 -0800 (PST)
Message-ID: <97eecef3-78f8-4cce-b23d-b86957719bd4@baylibre.com>
Date: Sun, 24 Nov 2024 12:09:13 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] doc: iio: ad4695: add SPI offload support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-16-bea815bd5ea5@baylibre.com>
 <20241124173819.224b5940@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241124173819.224b5940@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/24 11:38 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:18:55 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Document SPI offload support for the ad4695 driver.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v5 changes: new patch in v5
>> ---
>>  Documentation/iio/ad4695.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
>> index 9ec8bf466c15..8009a0c272bc 100644
>> --- a/Documentation/iio/ad4695.rst
>> +++ b/Documentation/iio/ad4695.rst
>> @@ -47,6 +47,36 @@ In this mode, CNV and CS are tied together and there is a single SDO line.
>>  To use this mode, in the device tree, omit the ``cnv-gpios`` and
>>  ``spi-rx-bus-width`` properties.
>>  
>> +SPI offload wiring
>> +^^^^^^^^^^^^^^^^^^
>> +
>> +When used with a SPI offload, the supported wiring configuration is:
>> +
>> +.. code-block::
>> +
>> +    +-------------+         +-------------+
>> +    |    GP0/BUSY |-------->| TRIGGER     |
>> +    |          CS |<--------| CS          |
>> +    |             |         |             |
>> +    |     ADC     |         |     SPI     |
>> +    |             |         |             |
>> +    |         SDI |<--------| SDO         |
>> +    |         SDO |-------->| SDI         |
>> +    |        SCLK |<--------| SCLK        |
>> +    |             |         |             |
>> +    |             |         +-------------+
>> +    |         CNV |<-----+--| PWM         |
>> +    |             |      +--| GPIO        |
>> +    +-------------+         +-------------+
>> +
>> +In this case, both the ``cnv-gpios`` and  ``pwms`` properties are required.
>> +The ``#trigger-source-cells = <2>`` property is also required to connect back
>> +to the SPI offload. The SPI offload will have ``trigger-sources`` property
>> +with cells to indicate the busy signal and which GPx pin is used, e.g
>> +``<&ad4695 AD4695_TRIGGER_EVENT_BUSY AD4695_TRIGGER_PIN_GP0>``.
>> +
>> +.. seealso:: `SPI offload support`_
>> +
>>  Channel configuration
>>  ---------------------
>>  
>> @@ -158,6 +188,27 @@ Unimplemented features
>>  - GPIO support
>>  - CRC support
>>  
>> +SPI offload support
>> +===================
>> +
>> +To be able to achieve the maximum sample rate, the driver can be used with the
>> +`AXI SPI Engine`_ to provide SPI offload support.
>> +
>> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
>> +
>> +.. seealso:: `SPI offload wiring`_
>> +
>> +When SPI offload is being used, some attributes will be different.
>> +
>> +* ``trigger`` directory is removed.
>> +* ``in_voltage0_sampling_frequency`` attributes are added for setting the sample
>> +  rate.
>> +* ``in_voltage0_sampling_frequency_available`` attributes are added for querying
>> +  the max sample rate.
>> +* ``timestamp`` channel is removed.
>> +* Buffer data format may be different compared to when offload is not used,
>> +  e.g. the ``in_voltage0_type`` attribute.
>> +
>>  Device buffers
>>  ==============
>>  
>> @@ -165,3 +216,20 @@ This driver supports hardware triggered buffers. This uses the "advanced
>>  sequencer" feature of the chip to trigger a burst of conversions.
>>  
>>  Also see :doc:`iio_devbuf` for more general information.
>> +
>> +Effective sample rate for buffered reads
>> +----------------------------------------
>> +
>> +When SPI offload is not used, the sample rate is determined by the trigger that
>> +is manually configured in userspace. All enabled channels will be read in a
>> +burst when the trigger is received.
>> +
>> +When SPI offload is used, the sample rate is configured per channel. All
>> +all channels will have the same rate, so only one ``sampling_frequency``
> Double all.
>> +attribute needs to be set. Since this rate determines the delay between each
>> +individual conversion, the effective sample rate for each sample is actually
>> +the sum of the periods of each enabled channel in a buffered read. In other
>> +words, it is the value of the ``sampling_frequency`` attribute divided by the
>> +number of enabled channels. So if 4 channels are enabled, with the
>> +``sampling_frequency`` attributes set to 1 MHz, the effective sample rate is
>> +250 kHz.
> If you are exposing that as a single sampling_frequency I think we should be
> adjusting the frequency so it represents the same thing in both modes.

There are separate sampling frequency attributes per channel. I wrote
"attributes" to try to indicate this. But I was lazy and abbreviated the
attribute names. So I can fix that.

> 
> So divide by the number of channels (conversely run faster if more channels
> enabled).
> 
> Jonathan
>>
> 


