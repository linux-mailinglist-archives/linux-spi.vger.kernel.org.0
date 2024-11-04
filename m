Return-Path: <linux-spi+bounces-5604-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D49BB529
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 13:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AB6B25E1D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB31B0F26;
	Mon,  4 Nov 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="WYe/PbbB"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE420433AB;
	Mon,  4 Nov 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725008; cv=none; b=EpNLGGVTzlu5zDpKTz2v6dbTeW+ixDwez1MCBpJVEESI9zj79Of9kX7vns2MXuMIdiuX4CwcREXuD/X1MZBcZ0h7FDY3Y8QpZFJmB4RHYRqGto5zsEx5ZMYcfhbCeK/w49n4ha/D4Tal7SCIB+dXXsVsuq8/tg8cECfgve5tVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725008; c=relaxed/simple;
	bh=gsAM6xvDAkDsKSf2kB2mFqYvNCWWdupMPv1OLEGLJpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QDtLDkL5nXZ4QrfxuHoUtAZ2kBdh2nW8yPSDxvUR2TUbC8V9upYRu4cyJThflUmNyFCHYSyRutlYaQnmO3GKTkvoViIefILzKmHRgGj4Mx6rfqKdS2eP0Ln+DUcUZ/iydqbmRodZOLKk3nJd4pnuYLFUU6Yb9aSbI5IBdP1K0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=WYe/PbbB; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3BA58A03F3;
	Mon,  4 Nov 2024 13:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=ZgJ5BTpIJ76vDQhoFyd1Z9xzbY8ER
	zsZQHOdaJr4nBE=; b=WYe/PbbB4ax4WTjf5h1/XMavmEchdcOLxZLN+8EWnhgUn
	DueBvAgkhickNU7PF0+4Ia6fY7E4i+Uoj/aNithZYWyMrD3uWzle+WjmiqohWp7v
	3mdQP7M01Fvv2WfIXbnAbsDUnlKt9vVfnBFFQcVZdPHZymknOxkUlNN75ynMVSIi
	t0CbUTjwRxZUjUoJeHEM1PFziOAg9yVIrJySx9tBcS/XLv3D7U918I5BJpESyBuU
	puIfXJY/Iba216Kg+HKtLI6i19fPj6GOypDDCVFRPe0/sGAAxBJP95TBMW9Zvbij
	1fWopBSIs6QB4MlIlm5cWnuWSlCCIS1gEExzEHQZgEzxGXx07J0kBQFlB28OtMhR
	uMvA0MKeduvvJMRhPxh1brpu/etGNM0HDZq7PldPj4zi4pRJSGas8Exf8a4u7kWc
	JUQHXL2K73LeiE+06dJuRkfkXGIKw/3hq/+6dmdU1BVGbVpxROEczfxffqtDy6ry
	LEU4hNdR2lgum0WDVlFVH3uEyovBewMXq4QmJf0FIS2crhMiEg3OtICIczSRdFev
	YxxtwWltqpxgl/LGEIWjUr6Rc8sXEEzxPBIKsGDAShdejkO2GE0e599N8cQjcDzh
	d5jwH0GaI9Rv4YJFDELMecBTOvubUS9+U9UdaUPzN7C0bBhaLOcdU5ZhLuAKzw=
Message-ID: <ad585127-9e3c-414a-84c2-c4ea3e6d3c7d@prolan.hu>
Date: Mon, 4 Nov 2024 13:56:40 +0100
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
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Mark Brown <broonie@kernel.org>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>
References: <20241030084445.2438750-1-csokas.bence@prolan.hu>
 <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
 <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
 <20241104-vanilla-operating-de19b033f0a8@thorsis.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241104-vanilla-operating-de19b033f0a8@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667267

Hi!

On 2024. 11. 04. 13:48, Alexander Dahl wrote:
> Hi,
> 
> Am Wed, Oct 30, 2024 at 01:37:52PM +0100 schrieb Csókás Bence:
>> Hi,
>>
>> On 2024. 10. 30. 12:09, Tudor Ambarus wrote:
>>> I think it's fine to split sama7g5 addition in smaller steps. But please
>>> add the sama7g5 support in the same patch set, otherwise this patch
>>> doesn't make sense on its own.
>>
>> Well, actually, we're using SAMA5D2. My goal was just to somewhat harmonize
>> upstream with the vendor kernel so that we may contribute other patches that
>> we have made on top of the latter, or in the future, take patches from
>> upstream and apply it to our vendor kernel-based tree. This patch was only
>> meant to lay the groundworks for future SAMA7G5 support. I can of course
>> send the "other half" of the original patch if needed, but I wouldn't want
>> it to hold up this refactor.
> 
> It would actually be better if vendor would bring their stuff
> upstream, so there's no need for a vendor kernel.  Did you talk to
> Microchip about their upstreaming efforts?  What was the answer?
> 
> Greets
> Alex

Agreed. Though in this case, the original patch *was* submitted by 
Microchip (by Tudor, originally) for upstream inclusion, but it was not 
merged. Hence this forward-port.
Link: 
https://lore.kernel.org/linux-spi/20211214133404.121739-1-tudor.ambarus@microchip.com/

Bence


