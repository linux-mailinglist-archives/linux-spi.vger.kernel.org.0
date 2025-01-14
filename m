Return-Path: <linux-spi+bounces-6354-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE456A10D45
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DD91881E01
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52121F8F1B;
	Tue, 14 Jan 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="EpdVhTLJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839C1F9F68;
	Tue, 14 Jan 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874845; cv=none; b=kTgFViuwBuobf+XAYHYQYzLLw5mBHtMz/+MeRILw6kAnN8OnMTDs6g73Qe8SDblHr+Vu5Vaf3n2x+rAA0v0IRnOjbVL06bGW8uJK5d9/kGq5peBoZMIyH5HLx2d2m5DOnRwsjWBv2bHyxKluAK6c9RyU0+99WeXH1kbRD/wbXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874845; c=relaxed/simple;
	bh=kxkViMVZ2uFzL1LXRczmX5URVGAFX8qbvAWZz6ZprAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t+X459x9aJlAImsKDS8/6ppm73Uqmc/fd7QaX570K78nrEzkSUEKO6/Nv6Rd4mjTqVZk5ggN9s5wdiHT89AcUAq8lwi5fCwrmtLS6gwVs5yxYSpeXRpbtI8pMxMv6H1eJdcOXeAx1d9Xu9BlMU8a5s037B6Sy/kLarTb41Z4ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=EpdVhTLJ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D0233A0D95;
	Tue, 14 Jan 2025 18:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=fN2wxgO6KjU8jGjesmYRbI6NryNjN
	DPOxGwMPjOWvw8=; b=EpdVhTLJGQ42e1dPZG2pGmw6RYKjWs6NQIEnbEcpDy9mL
	JcvU11Sa5smWoFantBKLGJaa0/TcsO5m1gqAKST8Y0lQrCzGp8WZbuHWYjlqocy0
	clAQzGmKmmZTONdGUiz57HLQ6pLb1Q/q9p6kwxHuzeKlhlC4TpPateT8b09PqE1A
	wZNPm3wzJyzlvDNIabuKapdnECGH4AIDnVzNcvsiKu7azc0GiiX/9tcGcsSkZZ/5
	i3XkISFgtIKqZQgBIO/bKm8/Sdy7MOnIFD1N4ne2sKw7LS+Q38K+OebrlQ0FBB3j
	eQi1FVZDxQw3bZvvFpFTHncZmhuAJKg8GVJ/ofDuqfgD2cvypnGUf8ytEYsgKYIR
	sYBLpQgsRjeGIn7j8FvBBtuLRjBadHU6H0kL2bgY0dCF+ytJaadC2nCmRL09OEUG
	Hic5l4NVlumPq6z0mwjOaSoaSfefic05L7AEfE0S2FcVwun0SHs67RuWeMSyfDFW
	DstLmYAIGvXlsHvycKmudm+94RwRTgzJlZmepPOtCWyW40TMxyid2oKNhLPmy6jr
	KsuCyMl4KEsUPAZVwxOWyiidr8VyVnLQJgy99Y0oHg/GEZY9oai1v60kCoYS1dTp
	mAhoeoRRhv9HE0YYX3UwbAZw8CecQvSMeO8lhISRP36oARgbyG0a9PcamHuocM=
Message-ID: <47481ae7-6d27-4101-8f3f-b1b7b456b905@prolan.hu>
Date: Tue, 14 Jan 2025 18:13:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: atmel-quadspi: Add support for sama7g5 QSPI
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Tudor Ambarus <tudor.ambarus@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Tudor Ambarus <tudor.ambarus@linaro.org>, "Jinjie
 Ruan" <ruanjinjie@huawei.com>
References: <20241128174316.3209354-1-csokas.bence@prolan.hu>
 <20241128174316.3209354-3-csokas.bence@prolan.hu>
 <20250109-carat-festivity-5f088e1add3c@thorsis.com>
 <20250110-married-program-83bc1a997ce8@thorsis.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250110-married-program-83bc1a997ce8@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852647167

Hi,

On 2025. 01. 10. 11:40, Alexander Dahl wrote:
>> This function atmel_qspi_sama7g5_transfer() seems to be called from
>> atmel_qspi_exec_op() through ops->transfer() only.  I think the two
>> lines in the error handling of atmel_qspi_reg_sync() lead to
>> unbalanced calls of pm_runtime_xxx.  Compare with
>> atmel_qspi_transfer() which has no calls to pm_runtime, everything is
>> covered by atmel_qspi_exec_op() in this case where the pm_runtime
>> calls surround ->set_cfg() and ->transfer().  Right?
> 
> This problem has been addressed in downstream kernel (linux4sam) by
> Claudiu Beznea back in 2023 already:
> 
> https://github.com/linux4sam/linux-at91/commit/e59f646f516088fdab6d8213d8acda0c1063ec21
> 

You are correct. I have picked it and will submit it on the ML shortly.

>> The whole call tree from atmel_qspi_sama7g5_setup() downwards is not
>> covered by pm_runtime get and put calls, although heavily doing i/o.
>> Further down in atmel_qspi_setup() there's a write to QSPI_SCR which
>> seems to be handled correctly.
> 
> Same for this:
> 
> https://github.com/linux4sam/linux-at91/commit/5ff0e74c1d548599fe85113e2f1817cb8a052b15
> 
> Some hunks of that seem to have made it to upstream, not sure?

Yes, it seems to be an amalgam of patches from mainline, and original work.

> Maybe Microchip should upstream those fixes, now that SAMA7G5 support
> was ported to mainline?

I would prefer that as well.

> Greets
> Alex
> 


