Return-Path: <linux-spi+bounces-5556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A49B632D
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 13:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124831F215CF
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E81E570B;
	Wed, 30 Oct 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="rkhoYq2w"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B011E4928;
	Wed, 30 Oct 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291881; cv=none; b=ldRQc8/DVhS2z1hCdh0cTn85pDgI593WNiZSKKMz9FeTxOfgZbRvk7QupWI5aPtrcXIQMp2v+CabcbyhYdDtQWEMEuOb1H3LLsrkNzRyklKeNzQb/4kDKlUvJA6aIZiR8fXgPTGvuJWBydaMtbCVrIhNksBU+5T2CqfIZ41kqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291881; c=relaxed/simple;
	bh=1cxDQrDX+MgLwWrT/qj9xtMoo3zBblGDpJ6YsnHfvtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=obi+UwEQzxyk7gWo4WaxH3DWj/VnVUp91nIkicqxCt/Ju/W/Kviw5L6Oc5wip2Sg/SukygkktGEhf4YZSCdGMi8PZrgXaUwUhtOL9F1GC/+ZiWF3Nwc0VR+8DsTmzkVlTBT4jKu7SqC8RdSGvfDfIV7xPzo2wLMLhzFKAwp+OZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=rkhoYq2w; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 48E56A079B;
	Wed, 30 Oct 2024 13:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=8Tt0KmwBKy/brL1yb3XR
	sgRfkqeOXAgFzAXAMIUDuIo=; b=rkhoYq2wiq4yOyIxugIPnDQW7aGSusB4MJ0a
	xclfnc9qmJznHvVOCoGxDo0tnsBUN+tzP0LSdPu7pxb3MZYONMDalqyW5xp1U8zT
	PBvbDSEMtsNKzQFxN7BwuXVo7w8fKYJOQ18DLQB1I8g0ilSBw6WdBx2e6pXkAdiB
	HhzVhFEFY6zIhcCpJfWAgEwQgsOQMKaevpBOdPtY0tRsHG6yqiA7q/QCa6cuuCzG
	P8xxL1GQprsVm9EKum/mygh3rmVOn/n4JPcsZ7ZyuQ7y/4RA59JIzWeKQmiWcoE5
	01z3zhRWo29sTOiJAY5O8o3Rx0ZMgSGLiLCrB2TJdustAYMQLk0OHzDItwIEdFs2
	lnwglRaSDgd2QR9XMLy2n1Tnid9G5JKV15DBg3OgNh3YTooChMhtGasuZIVJOIyw
	ntxUW0povSR6nAriqFgfLDGxn2fYioVdsyUiw/5eXjBlrtmqZ+E0umteQkMiwzbx
	tG0jCj7/nmTjzb6LvIq4nBrZqT9CEsqfwpvd1N/NLnkwtNXEblJzo0kf7o3LpKfX
	tWGbUtIb2jqKCMf3C7yCK72Li/sKb++2Mkf9qfp91Q6WgntSk6LWDkLIrIyCQ3mt
	Zn4N/UF2CsOvBTVliC4jHP2x1RQoJemF5Wp8y8qgzeodwaGZDgNofyTeOlYEyEEp
	VL48g0U=
Message-ID: <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
Date: Wed, 30 Oct 2024 13:37:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support
 newer SoC families
To: Tudor Ambarus <tudor.ambarus@linaro.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Varshini Rajendran <varshini.rajendran@microchip.com>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
References: <20241030084445.2438750-1-csokas.bence@prolan.hu>
 <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667761

Hi,

On 2024. 10. 30. 12:09, Tudor Ambarus wrote:
> I think it's fine to split sama7g5 addition in smaller steps. But please
> add the sama7g5 support in the same patch set, otherwise this patch
> doesn't make sense on its own.

Well, actually, we're using SAMA5D2. My goal was just to somewhat 
harmonize upstream with the vendor kernel so that we may contribute 
other patches that we have made on top of the latter, or in the future, 
take patches from upstream and apply it to our vendor kernel-based tree. 
This patch was only meant to lay the groundworks for future SAMA7G5 
support. I can of course send the "other half" of the original patch if 
needed, but I wouldn't want it to hold up this refactor.

> Also, if you think you significantly changed the code of authors, I
> think it's fine to overwrite the authorship. Otherwise, try to keep the
> authorship and specify your contributions above your S-o-b tag.

I don't know if it counts as "significantly changed", I split out parts 
of a patch that were relevant for our device, and made small adjustments 
to make it correctly apply to master. I didn't find a descriptive enough 
tag for this, so I just went with Cc:, but if so desired, I could change 
it to a S-o-b, Co-authored-by, Suggested-by etc.

Bence


