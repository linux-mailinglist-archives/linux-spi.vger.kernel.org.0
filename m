Return-Path: <linux-spi+bounces-10971-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF17C2AE3A
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 10:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEA81892421
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618062F9DBC;
	Mon,  3 Nov 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCWE8zDV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311692FABF9;
	Mon,  3 Nov 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163868; cv=none; b=Lca6WOWO69owtI5HyffIvyg0K5QDbpeltGr0RKqaYTAT/LUz5d3t96s1iqyebUaVodkUD6nd/FgSp0ru8ikkxZfQUp4Zk/xr4EGiH0N69xXbboqZEHpR45BmzrD9DC0WHRftz16nQyb8C5lTnajPxwq5TPhVGqo8EH9mSSwyikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163868; c=relaxed/simple;
	bh=tQJW9d/dyn2Pn4aWTpR7XBvFl5Scj4xudR01U54UyB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEdFx62r5HI9vzWnx69wPVC4U48mz3wqqktwl709MleDHTfAvOmMW8Ppw0Y/u4/B/nn9pXZyFf+6FFwwxB9ZPMa6AbShnw4Sr7+EjPY6llU//565jnchTJz9O0wurhAXZvcvckcHhdMJS0RF0FbyewRft7O3rXe/NPTmU1q6AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCWE8zDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8742FC4CEE7;
	Mon,  3 Nov 2025 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762163867;
	bh=tQJW9d/dyn2Pn4aWTpR7XBvFl5Scj4xudR01U54UyB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCWE8zDVDqBxsuAvXh/gZPeQSRhVF1idQy5B2U9OGGq99RrWd1xYprYmfAffkJDNC
	 A4WK8e5UW8nzmB7WyZwiyd+93EkJQ7VwrMnzDg3su7Gd2wpk5j0344NWOE9lV9w2S4
	 sIhiNKgG8Axoj+CDWOcEkWLIg+s2Hcj8n1fDhoerJXusm+6LdpCdhyVfRK8A5U+vOI
	 9Xik1N5kcHcLvNO2oJH9/I6MAmeJ3q/RS3gHV89TG2f3P0oNRIojMSwiA+LchQ3J90
	 kcXjtsCG+caa5c/Jl0Y3DL7DnJt8ao/+j9bFBPOq0p9rjyeDyyPqbre0/oI4SIOfqT
	 Ft1Tn7DmOqDYQ==
Message-ID: <f8dc0e8b-bbdc-4ac6-9ebc-c633bda24403@kernel.org>
Date: Mon, 3 Nov 2025 10:57:44 +0100
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
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aQh3RJQ95jTx7VYO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3-Nov-25 10:35 AM, Andy Shevchenko wrote:
> On Sun, Nov 02, 2025 at 08:09:21PM +0100, Hans de Goede wrote:
>> Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
>> acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
>> on the SPI device.
>>
>> If there is no driver for the SPI device then the move to spi_probe()
>> results in acpi_dev_gpio_irq_get() never getting called. This may
>> cause problems by leaving the GPIO pin floating because this call is
>> responsible for setting up the GPIO pin direction and/or bias according
>> to the values from the ACPI tables.
>>
>> Re-add the removed acpi_dev_gpio_irq_get() in acpi_register_spi_device()
>> to ensure the GPIO pin is always correctly setup, while keeping the
>> acpi_dev_gpio_irq_get() call added to spi_probe() to deal with
>> -EPROBE_DEFER returns caused by the GPIO controller not having a driver
>> yet.
> 
> Even before following the link to some papering over module via the link below
> I wondered, if the I²C case should be covered as well. The
> https://github.com/alexpevzner/hotfix-kvadra-touchpad refers to I²C enabled
> touchpads.
> 
>> Link: https://bbs.archlinux.org/viewtopic.php?id=302348
> 
> ...
> 
> I'm not against the SPI fix, but is it confirmed that it really fixes the issue?

Yes Mark and I got an offlist email bisecting this to the:

Fixes: d24cfee7f63d ("spi: Fix acpi deferred irq probe")

commit (on a stable kernel series) and a later email confirming that this
patch fixes it.

It seems that leaving the fingerprint reader enable pin (the first GPIO
listed in _CRS which is an output only pin, is likely the enable pin)
floating is causing these issues. So in a way the acpi_dev_gpio_irq_get()
fixing this by forcing the enable pin to no longer float is a bit of
luck. But things did work before d24cfee7f63d ("spi: Fix acpi deferred irq probe")
so we need this to fix a regression and as you indicate it seems
like a good idea in general and maybe we should also do this for i2c.

As for doing something similar for I2C devices, that is an interesting
question. Even though it is possible I'm not aware of any i2c-devices
which have a userspace driver like SPI/USB fingerprint readers do,
so on i2c I would expect probe() to always get called. So I'm not sure
it is necessary there.

Regards,

Hans



