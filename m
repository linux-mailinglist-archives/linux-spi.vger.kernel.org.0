Return-Path: <linux-spi+bounces-11079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A67C3AE1C
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 13:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EEA94E8BB5
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C273093D3;
	Thu,  6 Nov 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRcHpc5w"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B12D9ED9;
	Thu,  6 Nov 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431804; cv=none; b=EqylDfXFUXWe7+/xRWn93QhQvIHvguL6FHTuZXbmZu7w3uTL8i82b58kckNQQiaHIJsJC0x4/jnoRAafiFionoHo2QWX/nkvVwgl1lOJy3PRaXAEyOQSbXyYoUkGOp3x+b0m/eZkkAqwNY4GbF9x2gMVW7a5q0kgFcE5mAM8AKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431804; c=relaxed/simple;
	bh=CfdplLLZ3uS6sdtTkc+Ag4tdALAgrLAPud/T2gMLCkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGX2LunwnLyiAjNtGqAt8yb67PG+FkYy/cqcCBS1fMqd12ZH1W1/AEMDy3wAtvNaoovHZPNO9X09Q13u2gtQWOJ0MCLXRoIKPq6ALWNYb0WGWpjm2mMh5vTEQcb3aK3FqFfu/LzdsSguJxjpQHQpME4w8pBn7Rvn+K6/L64MCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRcHpc5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD58C4CEFB;
	Thu,  6 Nov 2025 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762431804;
	bh=CfdplLLZ3uS6sdtTkc+Ag4tdALAgrLAPud/T2gMLCkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MRcHpc5wJhgA7lSN/x7KuT8cVuTptJQFtzF0vO1pdrmH02Z0uq/FggTUHew0CWAsf
	 bVEBo3bC4d5CwYMsZGyNCAtmkBwJYECoMWdDfWbFbfLk7KPm01qOLSyaQUk6P06mnd
	 qEK2aQTKWQSP4Kw8aCTb/9jooyBfD7j4oIz87jjxzVuaMqcZ6xfT7uoBNqvbEi3Do7
	 HyrPbxuCnegUyqoR0byL+w93pkPxAoAz+6vW67dS2zHRq8VV2pzYvKYj/liOAC9pbX
	 kzawL5EIKScetv1eYD0Dt2DylYEfvngde+8PCfOXNqo4C78T/mXzPIkN4S4OVepTHH
	 3dgxV8l/n8CBw==
Message-ID: <935e8578-1c25-4015-bd6e-a41cd0f07c81@kernel.org>
Date: Thu, 6 Nov 2025 13:23:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20251102190921.30068-1-hansg@kernel.org>
 <176242886085.2357454.1138821772017853306.b4-ty@kernel.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <176242886085.2357454.1138821772017853306.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 6-Nov-25 12:34 PM, Mark Brown wrote:
> On Sun, 02 Nov 2025 20:09:21 +0100, Hans de Goede wrote:
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
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: Try to get ACPI GPIO IRQ earlier
>       commit: 3cd2018e15b3d66d2187d92867e265f45ad79e6f

Thank you.

I believe that Andy's Reviewed-by was intended for a v2 with extending
the comment with an extra paragraph with something like:

"TODO: ideally the setup of the GPIO should be handled in a generic manner
in the ACPI/gpiolib core code".

Since you've already merged this now l'll prepare a follow-up patch
to extend the comment with that info.

Regards,

Hans




