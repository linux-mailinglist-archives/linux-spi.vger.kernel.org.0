Return-Path: <linux-spi+bounces-11447-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C08C77018
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 03:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57E0F4E5191
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1C276025;
	Fri, 21 Nov 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lDLXx4Yl"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC261F4CBB;
	Fri, 21 Nov 2025 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692227; cv=none; b=oku6sfMgH/0CfE627QWjjumXkWQ5wrZK5qtA2tWxkGCxbU3YPz4gpz5jBvcEaOXe85rcKJWdwodWaEvpaOgILv2lZd1fowsPr6ngtBrnX+gjsg1Bb2wz7isMJnGW4D7b4y21eB/gXs+KzUqvv3SBlGHEAQbLJ6/10G6ITJZ/9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692227; c=relaxed/simple;
	bh=bqBKBDPF0s8RKZWNq6H3WEM3BK+3rP5gSzs4iEnpWik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Au+GXVKBzq7orWX8BnPKCB8DFqCB/wIT+yDYcsTmSfiK+e0jDVXvBOWlAL0Y53fnQAHpy+uOjGfmKnTf14/3T3Zh/MX/JCKQH8B9KG3x51609Ga3ilW5C2wgWmr9sloVuBQzn2IKWyDtcw/m/Xs2n4Rs1EIlsnYECu5VaAqk5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lDLXx4Yl; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4508c3b6-ba93-4219-8fc6-e3005d35a426@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763692222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+Fl+CJP9jYMP5QlwgRxTU2QZZiCdvVhzVTdP3WoJRs=;
	b=lDLXx4YlERKE3i+pORCM8MTlQAvbgyJRVF8f7mya9nJDpaHwY8dYbIyDuR3r6MkjXkJH6G
	WzGqOUeaWXB8unxvcPaniQ/rtpRFs1atNr5Td11u1kf4hvsS/ZEOCfw/U07/uW0CAnEKJy
	bHZp/O8fcMKJBjA4Ip+Gjazo+7Q44tM=
Date: Fri, 21 Nov 2025 10:29:59 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] mfd: sprd-sc27xx: Move poweroff/reboot support to
 the parent MFD driver
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
 Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
 <6286c547-2710-4854-a58f-8f3aa1dfc91e@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Cixi Geng <cixi.geng@linux.dev>
In-Reply-To: <6286c547-2710-4854-a58f-8f3aa1dfc91e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 19/11/2025 14:33, Baolin Wang wrote:
> CC Cixi.
>
> On 2025/11/11 03:08, Otto Pflüger wrote:
>> Registers for powering off the system are present in all SC27xx-series
>> PMICs, although their locations vary between the specific PMIC models.
>> On systems using these chips, the PMIC can always power off the system
>> and is usually the only chip capable of doing this. Similarly, the PMICs
>> (except for SC2731) contain a reset register that can always be used to
>> restart the system.
>>
>> There is an existing sc27xx-poweroff driver, but it currently only works
>> on SC2731 and is not probed anywhere since it is missing an OF match
>> table and is not instantiated by the MFD driver. Reboot for SC2731 is
>> implemented in drivers/spi/spi-sprd-adi.c, which is not really an
>> appropriate location for PMIC-specific code.
>>
>> Since a separate device tree node for the poweroff support would not
>> provide anything useful (see [1]) and passing platform-specific data
>> between drivers is unnecessarily complex for such a simple feature,
>> reimplement the poweroff functionality in the main MFD driver. While at
>> it, add support for the newer SC2730 PMIC and its hardware reset
>> register.
>>
>> Reboot is special because it requires storing the reboot mode. Move the
>> existing code for this from the SPI bus driver to the MFD driver.
>>
>> [1]: 
>> https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/
>>
>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>> ---
>
> Overall, it looks reasonable to me, but I cannot test your patchset 
> right now due to the lack of hardware. Cixi (who is from Unisoc), 
> could you help test this patchset? Thanks.

the patchset test reboot function on ums512 is ok.

Tested-by: Cixi Geng <cixi.geng@linux.dev>



