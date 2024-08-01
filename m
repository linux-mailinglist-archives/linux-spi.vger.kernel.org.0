Return-Path: <linux-spi+bounces-4124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD7F94528A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 20:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5228A1F23DB6
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F513D89C;
	Thu,  1 Aug 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HOnLLR9X"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340113D63A;
	Thu,  1 Aug 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535510; cv=none; b=sOt7De1TIxdi2x6vVoNnNC5Ah2Ap2jnZK3IsApWfXO+uPnahsIZOqeYuYVgOXmdqorWLn25PEDkjJ0IdqLZQQMUmzIu6Ias6wV32+pt1I8hKSIgS5Aso+yzejnfIIA3ooh6Zrgv4owQRiBEBhBABcAI8BxA1Q0wwlp5qHofMVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535510; c=relaxed/simple;
	bh=JQaGnDvmk/eH49aIh6Pmq8xbttq3olRoqsnPrZXpSXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UijWJWpkhgbEiJQDDlqpPfIGgkwLJMgMTySuOB+/UsUfg6fP/+wY7XKNyU5CMgfkgUz2SFWLU2JXflkQ9zg/INEJDYoWmkMoe7SVQrYOr3cG6tZYgBle2SHJdeMf8UnYtdrg4gykzS009OGql3dEczCjlT4wJ+dN2R5nUv+navo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HOnLLR9X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722535507;
	bh=JQaGnDvmk/eH49aIh6Pmq8xbttq3olRoqsnPrZXpSXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HOnLLR9Xp9B+bYNE4eGIP+B+t7dahIZmxw6U7kafUV/U0g0oMR6q05CRIwB9vq2/D
	 L2Itl1pYxo4M9x/j0UkIcSgpFvScjnK8cMbnl2sm5LwwtqSGaVxpKvbOjEK2qjtepY
	 bdoOznSIUUzKsG1YEuDUGawfulvR9Y+0AvMu7olzGpw4wMG5FKp+CufnztS4N52H5I
	 KBjlvDj1ZlxvvQ/6LgBQqneQVW0T3GXre3xNEIOHwen2emdwbdyt53uZREgw2WMi4Z
	 CCjf3ESRu+9v9ggMLsEfoOxF5dVLFUk+jTFD1LCAbaQtSXEYt2M7kda3qGzYvHN8dr
	 5L4kH+UJWuMXA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F38437804C8;
	Thu,  1 Aug 2024 18:05:06 +0000 (UTC)
Message-ID: <20c5ee69-3510-4c15-aa40-6d61c64d8ef1@collabora.com>
Date: Thu, 1 Aug 2024 21:05:03 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
 Urja <urja@urja.dev>, linux-rockchip@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, stable@vger.kernel.org
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
 <c4d6da27-3b23-4a96-bad0-17f2392287ef@collabora.com>
 <22969419.5W6oEpyPa8@diego>
 <wad5fdqxwoq2wy35wbhwk5jinpgyz6xmxnt5aqddci777qctsd@qay2lr2ubkws>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <wad5fdqxwoq2wy35wbhwk5jinpgyz6xmxnt5aqddci777qctsd@qay2lr2ubkws>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/1/24 20:52, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Aug 01, 2024 at 07:41:44PM GMT, Heiko Stübner wrote:
>> Am Donnerstag, 1. August 2024, 17:31:33 CEST schrieb Dmitry Osipenko:
>>> On 7/30/24 21:05, Sebastian Reichel wrote:
>>>> +	/*
>>>> +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
>>>> +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
>>>> +	 * handler, so we are using the prepare handler as a workaround.
>>>> +	 * This should be removed once the Rockchip SPI driver has been
>>>> +	 * adapted.
>>>> +	 */
>>>> +	if (is_spi)
>>>> +		pwr_off_mode = SYS_OFF_MODE_POWER_OFF_PREPARE;
>>>
>>> This prevents the syscore_shutdown() step from execution. Is it better
>>> than not powering off?
>>>
>>> I'd rather skip registration of the power-off handlers in a case of SPI :)
>>
>> Or blasphemous thought, we could live with the warning-splash for a bit.
>>
>> From Sebastian's log I assume the WARNING comes from the
>> wait_for_completion() in spi_transfer_wait(), and I guess the transfer
>> with the poweroff command itself will already have happened then?
>>
>> So the device is most likely still powered off in that case?
>> Not sure how much of "bad taste" that thought is though ;-)
> 
> Yes, as far as I could see it works fine (the splash from the commit
> message is from exactly this solution running on RK3588 EVB1 and the
> board was powered off properly as far as I can tell). But it felt a
> bit strange to knowingly introduce an error splash in a fix intended
> for being backported to the stable trees, so I switched to the current
> version before sending.

Can you add a busy-wait to the SPI driver TX func for the case where
it's invoked with a disabled interrupts? That could be a better
workaround, silencing the warning and keeping power-off working properly.

-- 
Best regards,
Dmitry


