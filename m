Return-Path: <linux-spi+bounces-6261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8A0A07027
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 09:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74DC3A7E44
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E0215048;
	Thu,  9 Jan 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="E/hDMvN/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m118218.qiye.163.com (mail-m118218.qiye.163.com [115.236.118.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168E1FDA;
	Thu,  9 Jan 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411706; cv=none; b=NtkEyDuMxaA8+A7X9/ECSicwFHm8w7GrZ6Wl2ciVtT4lcomEe6FsbNeUNGUwcQXi54gEkWlIUCJ9X2ReVMZqbJxOrdeDAg+BqIitpHQ9iSKiezSYa8zB5WWUjlEh+BYFa1BzySfUaNW6gwLkA/Sneibr96XIsVCN3+S/4HaycEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411706; c=relaxed/simple;
	bh=NqzLcPlpqhkfndWgeMeGNURYs9eGLiDvXTR+G5cTBuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul4piWtz3M8yVtIYiA2OCPxELXH6lgX0XP671BizLtBV96NIFmYZBzk3sd7+/DPJ/9k++h0+QmXfDw2vrp0NbLSGYLMLRsReGJXO5RutzgOM4D2ep7hxBu7eWx2odo+9AFVtTJ7dmM6PVSHA64X1JPuWS7Re72RgL6kvAs8VZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=E/hDMvN/; arc=none smtp.client-ip=115.236.118.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.2.32] (unknown [125.77.104.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 83580805;
	Thu, 9 Jan 2025 16:29:44 +0800 (GMT+08:00)
Message-ID: <1a8ce846-bae7-4087-ba7c-2cc5be541be9@rock-chips.com>
Date: Thu, 9 Jan 2025 16:29:44 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: rockchip-sfc: Add rockchip,fspi compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
References: <20250107154755.2037197-1-jon.lin@rock-chips.com>
 <20250107154755.2037197-2-jon.lin@rock-chips.com>
 <1ef2ece5-f4ed-46ca-9bf5-75f898565a62@kernel.org>
From: Jon Lin <jon.lin@rock-chips.com>
In-Reply-To: <1ef2ece5-f4ed-46ca-9bf5-75f898565a62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGhkaVk8fQx8dT05CSEpJGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSU5VTExVSktPVUpLQllXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
X-HM-Tid: 0a944a2f0c2109d9kunm83580805
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODo6Ajo4CzISFwsBCBcRAjJL
	FxlPFD5VSlVKTEhNT0pKSENOQk9KVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlKSU5VTExVSktPVUpLQllXWQgBWUFKSktCNwY+
DKIM-Signature:a=rsa-sha256;
	b=E/hDMvN/uXfDVXVtLxHo1yiWP5wjgZs/7u4vsuJhgy4ioXLgcRGjAz6ZAv9ux34uZXrvKsU/jiZF1i6TrzQfyF0mQIJ79pk+4HjZROAxrsn+n1H6Fc7JepyYkxB9mgzZHO7sGCPVQ0kcDu93CBDUWL4fmG4oDqY0NJ6owKg5dms=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qdKQdu0yqkEFNpHjhxt/s1/3Z7lTuPUmfZCAiVLRWwE=;
	h=date:mime-version:subject:message-id:from;

On 2025/1/8 15:03, Krzysztof Kozlowski wrote:
> On 07/01/2025 16:47, Jon Lin wrote:
>>
>> diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
>> index 59de351499a0..88fbde27925e 100644
>> --- a/drivers/spi/spi-rockchip-sfc.c
>> +++ b/drivers/spi/spi-rockchip-sfc.c
>> @@ -808,6 +808,7 @@ static const struct dev_pm_ops rockchip_sfc_pm_ops = {
>>   };
>>   
>>   static const struct of_device_id rockchip_sfc_dt_ids[] = {
>> +	{ .compatible = "rockchip,fspi"},
>>   	{ .compatible = "rockchip,sfc"},
> I don't understand why you are adding generic compatible which is not
> even used. Use proper SoC specific compatibles and fallbacks when
> applicable (see writing bindings document).
> 

Thanks for the reminder. These two submissions are indeed redundant 
submissions at present and are not recommended to be merged.

It is indeed necessary to add submissions like rockchip,rkxxxxx-fspi 
when there are specific SOC requirements, and attach the associated priv 
data.

The merging of this submission is suspended.

> Best regards,
> Krzysztof
> 
> 


