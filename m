Return-Path: <linux-spi+bounces-7903-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C78AA9C2B
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21017A3419
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DA25C6E5;
	Mon,  5 May 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="snbSOG35"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8811BEF8C;
	Mon,  5 May 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471748; cv=none; b=WHQTx6GCA5q+qRmgWlXYR3yUgaJsbOpwTE9RPoT3Kqi9wru+QECrPNFZfGx6toWOZqhdi6fjXw0fXb86ROkn6rrNqmqsFUZb5As0HNGpkhPJuVz6DiQVuVc/XmmRh2i0jo2o3vTUjM26UAuW3xgoYTliH53zuBdwIgy9xAN+0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471748; c=relaxed/simple;
	bh=5Ocka9NXimvK/4LAht1ULSkY1xlJ9KYEYW2PzYVXnQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RWkmyGnm8fT39ZzN/Pn3pZXAnpuWpLPj3RKkWYAlDsgxtQ4JoUUmEGpxCt2HkgSIdbN+M+faxqtpcB4asqmuNb8QreA0wmhZ1W4pFnYT1FF9XNUs48bU+UVWRMqwdZCX/VtzFocJoL/jeHzwN100H8mr8X3Rrpra4vtfVyyFbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=snbSOG35; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 28873A05E5;
	Mon,  5 May 2025 21:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=AJYT6ZXuMuODnWTrjnxZ
	jizwjH0vp02GLwvaZErh7mQ=; b=snbSOG35oaQvBdSf6VaV1gV/6zvxxxNyHKQW
	tYw6RhTVHkK16mjkL/r7Db6oPOAhB7rbSd69JFIMNKZM5W6W3zY82sSfQxjdrfbP
	zGnsYbHor5ZonPp9VxpNY8P7sHV2Unt7H7YIaur10jdUVGlDRsmJx2jYDFlOxSLM
	x1NSP5TJ1GEDjnYv19WaXXTSnudSOXqCdOKid5FSj0AGkWhCpM3QHzr3VdMEIEpG
	KBRUMScbM8WdW2axJN2IETyUho7EtH0JMNZLLkpS6YRQ5uAsm2ZzipNod33gcBSu
	iSeMgV8kkwtOcgUR7hWmdVCunD51Tzl3Sk+wZiuvE7OhAIaXm/5Vq3G6hhHpvtNH
	4HxxxorIKW4Hr4GsBwsqvT8tIeoDJfCgZM9kO0lVxtNhZAhYZdv0rxY09AYyj9v2
	kXlhf1nPW4suPKjnzAj3eCVBW5ntxb2zK/u96KHxpbJJDPdhBrhkHlxG/JJWeY9u
	NU+HeQWU1mQvYMqoWyBi0Qb2BTZny5q+Da6nQ8S9E4bL82q8jsfTQXfadCafQixV
	VfRPSOQb4SlJDtjrI2Apqzh8aB2D+yxkfFe6VKcbizZJUIgEOApW3G/duWIDKj9u
	cysUJL3KeJsMu2KudAxIKI7M+ioEfj9HKSfM5H4gldEm7xaybxzWPs3ovo9iIW94
	Rmov+kU=
Message-ID: <8dadb7ae-1a7d-48d4-8dbd-40f6d9f35a6d@prolan.hu>
Date: Mon, 5 May 2025 21:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] pm: runtime: Add new devm functions
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Len
 Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, "Alexander
 Dahl" <ada@thorsis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Pavel Machek <pavel@kernel.org>
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
 <20250327195928.680771-3-csokas.bence@prolan.hu>
 <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
 <b38b27d4-c3d3-450c-8634-2e07f393a76c@prolan.hu>
 <CAJZ5v0hRsXw45utNMEhLB=i56tsJDz8AvYfV2stPbtRHh09HUg@mail.gmail.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAJZ5v0hRsXw45utNMEhLB=i56tsJDz8AvYfV2stPbtRHh09HUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94853667166

Hi Rafael,

On 2025. 04. 29. 13:08, Rafael J. Wysocki wrote:
>> Did this end up being applied?
> 
> Just applied as 6.16 material, I'll let you know when the tag to pull
> from is ready.
> 
> Thanks!
> 

Thank you! In the meantime, I submitted the DMA cleanup part as well, 
for now rebased onto pm-next, but there seems to be no diff between it 
and dma-next in the relevant files (drivers/dma/dmaengine.c and 
drivers/spi/atmel-quadspi.c).

Bence


