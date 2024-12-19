Return-Path: <linux-spi+bounces-6120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56F9F780F
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB20163BCA
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1911A221455;
	Thu, 19 Dec 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="jmQoZNUT"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DF149DF4;
	Thu, 19 Dec 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599404; cv=none; b=Ecb5K0lPf2US8upY65CcpdLmTc16m9vyO1lJQVSV7N3RkDQHjrngxEII4fSfpdIRJHogtYrwqF1j9J5eQNK1544cmqBQiqXlzI7+7Uvbhz7/L9Y/CeEHk43Qge6DCmYCgX31TBU9G6kPQBpSwbuSJCWFD6Ct7EylwwIbJkm8rV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599404; c=relaxed/simple;
	bh=VC2FpbnZYj1Ez2mpdU/ToRdPgEr6S+ZWKRU/D3CFgF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b1e5iyzjNCnJ86T0AIsIRe/AM9dXqDIiPoI58/5OnKcIabUJN/LeY5GI5tLDghmUWRg0CT5MhiSUhtbP8Rqxl+d+j5MQApEvpkszvCWjk1kZmbcf7PWoBBmub9fqakmQkp7BrWjGyindPA3KgEESdtDxaVL4O/m0xgR4U/kfXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=jmQoZNUT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 36265A05FF;
	Thu, 19 Dec 2024 10:09:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=uXdk9iXBjbSglfglNMlC
	e1O5qHEJC/mlI8TGpLrLN0o=; b=jmQoZNUTN1K0TmOO9Vccf83zEYA1Ylaf0Zkk
	xSkEtKMlPmVnhVLCCfJCo47AhxrA3tjdD2f6RBfZ+iJV0vMpDvQBzdLkl6j4tgbT
	wA3vwh5Tq69Ays6SEs2zaqXhj3jir00nj7qNA2qZlygbRZUNuWFiUUPgJf9dsRpU
	sEIJf9uGe9urF7KqyDdW47cz3CLaP5cbZOB6to7k+mcrCE0QEOXCNIjWxpmtjHKY
	YPqhTwGiPIKPt6u/Rh4UGRO19qKCtoLttE1I69P4wGbGKWb9+0zEpNK57E0VsTAf
	2IxapyW18AeQam1NHt/IeT3nGwGK2I8GPA9mQ/hExnHCjJHV8UYvgB7DnQccx9fl
	dwhgXVSg2fTXPkMF0oW46M4MJdpR4tllW+NvCq5jeqWisDaeWN3AgIvkHwyb2nBf
	c9z4pIDntf7SO/Dxu90Af2YfIfu1eXmFO2P/nODpejUAvXzOF18aTv29DvTv6JJC
	niafqNOp/81D65EehWmjcb8eBZ1rR7oH27WkSgiR1dMH0RdAMxxboKTrdgfRP5wk
	pca7IeDSoooYd8jkKzWKqmJSfrsJ0T86cVEytXYNytEpROtez39GE84Oo5TejgIl
	ns4kZlITv1HYPzqbo0+4/m4L+9QpBxFvcWKgs3ZYfXJhsanstNvBzhn4YGYWoLWv
	TQ66iAA=
Message-ID: <72874aa6-22c7-40a6-83bb-1ace0f3aec73@prolan.hu>
Date: Thu, 19 Dec 2024 10:09:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-qspi: Memory barriers after memory-mapped I/O
To: Mark Brown <broonie@kernel.org>
CC: Piotr Bugalski <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<Hari.PrasathGE@microchip.com>, <Mahesh.Abotula@microchip.com>,
	<Marco.Cardellini@microchip.com>, <stable@vger.kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20241218165850.378909-1-csokas.bence@prolan.hu>
 <b1661e3f-cc62-489b-a4f8-9964ccf65fae@sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <b1661e3f-cc62-489b-a4f8-9964ccf65fae@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948556D706B

Right. I originally planned on splitting it into a cover letter and then 
the patch, but I guess everything can just go into the msg. Dropping the ---

Bence

On 2024. 12. 18. 18:01, Mark Brown wrote:
> On Wed, Dec 18, 2024 at 05:58:49PM +0100, Bence Csókás wrote:
> 
>> However, the current documentation makes no mention to
>> synchronization requirements in the other direction, i.e.
>> after the last data written via AHB, and before the first
>> register access on APB.
>>
>> ---
>>
>> Fixes: d5433def3153 ("mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi")
>> Cc: Hari.PrasathGE@microchip.com
>> Cc: Mahesh.Abotula@microchip.com
>> Cc: Marco.Cardellini@microchip.com
>> Cc: <stable@vger.kernel.org> # c0a0203cf579: ("spi: atmel-quadspi: Create `atmel_qspi_ops`"...)
>> Cc: <stable@vger.kernel.org> # 6.x.y
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
>> ---
> 
> Your signoffs and whatnot need to go before the --- so they don't get
> cut off by tools, any any ancilliary stuff should go after.


