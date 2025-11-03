Return-Path: <linux-spi+bounces-10973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12480C2B01E
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7FEC4ED357
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41142FD69A;
	Mon,  3 Nov 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KubTNhK5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687A2FD665;
	Mon,  3 Nov 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165233; cv=none; b=EKdkPS5gGTL7IHWoBgXLYwy+u3he+U1gBdB0o2raVieZCwXr0RMSPfjqkPt8lYkvATSc/zy3mE4m4YxZq8nRmvVycCK6cP0w4WLIVBMBhyqgVadbZbXFVG2xW5wffEtysYeLbnbyc6/6DPJZVfUrzjh/r9Xoxwqv+vktSoxBZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165233; c=relaxed/simple;
	bh=/OQsET2xvFD951RyDdz77w1a6W8AD8LiQnRlUdUtVJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHaVCpgo75TWwWVFRJEGvpTmTJX8zGgbM9JHAH5e0+GttXSBslH/dWuq+xKgyPws0auUMRNopx7gCKxByZSWr05ywCZbIZfizxGR8EMobmu5eByUFUgK6eGO+rN5Bn5Tj12YzBCAJKf0bQH94nvflQRsV5NigWq7aeaDE2+XZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KubTNhK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F1FC4CEE7;
	Mon,  3 Nov 2025 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762165233;
	bh=/OQsET2xvFD951RyDdz77w1a6W8AD8LiQnRlUdUtVJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KubTNhK5mppAn1Y9Mq5wbGCeiG3nW3Ryzs/hu194Y4WXAFedihRAlgr+BZ5o6WM+n
	 3bhAd+uMi1C71lfwD30VRfv987Y4+fHti7QZ3efzChAs5WBVjYVWauoPI3nFj/+0N6
	 6qOULxo4kY2Oxlnc8DI3Wj5Wajj2COCUukBLUH3m6VEqa4K/RGAB75hGs/cwCF/bWg
	 DNXWklqqavH7wb2IMkVdDaohwhCZV9Fg7/iH2umvnOJf38rO5Q9LUsVObMO16xuV5h
	 AJ+1iSDsjvhBsLDfvmHL+6sn0HTqFbt/xMgg0helMz80A4x3I35uqjPv+9L2t75Xt/
	 8yaLY4MvakcqA==
Message-ID: <af07a18b-cfc8-47d1-ac5a-b343cbfe0f36@kernel.org>
Date: Mon, 3 Nov 2025 11:20:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20251102190921.30068-1-hansg@kernel.org>
 <aQh3RJQ95jTx7VYO@smile.fi.intel.com>
 <f8dc0e8b-bbdc-4ac6-9ebc-c633bda24403@kernel.org>
 <aQiATDzxEIKBytXw@smile.fi.intel.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aQiATDzxEIKBytXw@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3-Nov-25 11:13 AM, Andy Shevchenko wrote:
> On Mon, Nov 03, 2025 at 10:57:44AM +0100, Hans de Goede wrote:
>> On 3-Nov-25 10:35 AM, Andy Shevchenko wrote:
>>> On Sun, Nov 02, 2025 at 08:09:21PM +0100, Hans de Goede wrote:
>>>> Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
>>>> acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
>>>> on the SPI device.
>>>>
>>>> If there is no driver for the SPI device then the move to spi_probe()
>>>> results in acpi_dev_gpio_irq_get() never getting called. This may
>>>> cause problems by leaving the GPIO pin floating because this call is
>>>> responsible for setting up the GPIO pin direction and/or bias according
>>>> to the values from the ACPI tables.
>>>>
>>>> Re-add the removed acpi_dev_gpio_irq_get() in acpi_register_spi_device()
>>>> to ensure the GPIO pin is always correctly setup, while keeping the
>>>> acpi_dev_gpio_irq_get() call added to spi_probe() to deal with
>>>> -EPROBE_DEFER returns caused by the GPIO controller not having a driver
>>>> yet.
>>>
>>> Even before following the link to some papering over module via the link below
>>> I wondered, if the I²C case should be covered as well. The
>>> https://github.com/alexpevzner/hotfix-kvadra-touchpad refers to I²C enabled
>>> touchpads.
>>>
>>>> Link: https://bbs.archlinux.org/viewtopic.php?id=302348
> 
> ...
> 
>>> I'm not against the SPI fix, but is it confirmed that it really fixes the issue?
>>
>> Yes Mark and I got an offlist email bisecting this to the:
>>
>> Fixes: d24cfee7f63d ("spi: Fix acpi deferred irq probe")
>>
>> commit (on a stable kernel series) and a later email confirming that this
>> patch fixes it.
> 
> Shouldn't we use Closes in this case instead of Link?

I guess so.

>> It seems that leaving the fingerprint reader enable pin (the first GPIO
>> listed in _CRS which is an output only pin, is likely the enable pin)
>> floating is causing these issues. So in a way the acpi_dev_gpio_irq_get()
>> fixing this by forcing the enable pin to no longer float is a bit of
>> luck. But things did work before d24cfee7f63d ("spi: Fix acpi deferred irq probe")
>> so we need this to fix a regression
> 
> Yeah, fixing a regression is good thing, but not papering over the issue.

I agree in principle, but this is a quick and safe way to fix
the regression, where as the generic fix you describe below is
likely months away and also has significant risks of causing
regressions in various places, see below.

>> and as you indicate it seems
>> like a good idea in general and maybe we should also do this for i2c.
> 
>> As for doing something similar for I2C devices, that is an interesting
>> question. Even though it is possible I'm not aware of any i2c-devices
>> which have a userspace driver like SPI/USB fingerprint readers do,
>> so on i2c I would expect probe() to always get called. So I'm not sure
>> it is necessary there.
> 
> Reading the problem statement (the second paragraph) I lean towards
> a generic solution residing somewhere in drivers/acpi/scan.c (like
> acpi_init_device_object() / acpi_bus_attach() calls), although I don't
> see a quick way how to achieve this. It seems would require a bit of
> refactoring to allow ACPI glue code to call specific subsystem calls
> or making a GPIOLIB to provide some "early" initialisation flow(s).

I guess that you want to do the direction and bias init on all
GPIOs listed in _CRS, at least for devices with status == present ?

I was wondering about the same thing, but ACPI tables are full
of, well, erm, garbage in various places so I'm afraid that doing
this for all GPIO _CRS resources is likely to cause a whole lot
of pain.

Typically the firmware already sets up the direction + bias
of all used pins. I'm pretty sure the BIOS-es have some GPIO
init table especially for this somewhere.

Now those init-tables may have bugs, but I'm seriously worried
about the implication of doing the direction + bios setup for
all _CRS GPIO entries. I have simply seen too much non sense
devices (with _STA returning 0x0f) listing GPIOs also actually
used elsewhere to think this is a good idea.

Regards,

Hans


