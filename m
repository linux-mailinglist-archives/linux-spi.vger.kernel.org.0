Return-Path: <linux-spi+bounces-6405-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF21A15515
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 17:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E172E3A2ADC
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6519D080;
	Fri, 17 Jan 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mCBvrnrT"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8613B59B;
	Fri, 17 Jan 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133096; cv=none; b=Y86SLCwgHNBAaGyjjqJhi35GgJ1MutVNyQlG85gDxcGk3Ke8ZsS652ubMY/HF13gKwlp2XVxfZmIGgXqq47IgQMmuD5O0r3WNxMyqRIN5oMk3qbSnmy3I64im9B7K7YSGiIQixm6FA2BwKuugJwa5fpm98XvuJeNfYpKqifgD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133096; c=relaxed/simple;
	bh=0JOZr8EUR1npbbi4GZGuKuOXTSGY/ju/y7Y3hwptfNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yh+EDrMPbhWVcskuvnGIQnXxVe0vtIuYbMdSGLtjBGSJFz+6v2Vpz9j2BolruHT2R4Q6N0zvYMthHH0mrMv5OTdN/sdsMdo97VKlmH9iwfsX5SZt5TSzq/vLph6hXi+U5DBIoI1hBZzyxa8U8kG2y81EzrON7sRlYddiedmbtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mCBvrnrT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6368CA0391;
	Fri, 17 Jan 2025 17:58:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=SwpBCZYjZQUYzonRW4i4
	psjh5ZJtuC6Q4o9DAWvS0JY=; b=mCBvrnrT1iAwYU150vnasj7r3w66S3m3cr6t
	fJ+Ytn2EjzGkPsSxHHLYU0LGZAa2m9Dj2sLTwCKoNRbbv6Oqew2ww6kLt/haRG7C
	9Toq5FyUPHf4cAuE6jUwofuZYU070Uopabo4CVYyV2mIvBYWec1oaA+oPLAcPTVY
	wj8danFo6ag+fTxv6QMayMkdB8TC33czq4hSKbFWfZKijcpfeMCLXp6LIKwxOLT5
	j2dDdWM75BnQQX5FqlzAqDzC0b742WOfYp6Qn/HrTMwIQPTSUYd6iODbYmKuSlCg
	8MopwKCoIEbv+EW8oyjp6mRqB1LVvSiIlPR9Dc9NfhvA6wAMnxLe9kRy65W1ha+U
	xcIRhWbqmG2ACdj/x0cf+CnTUe5U8ka6yC+1l9VLZ03aAulUPXjEOZuWw7W9C1/i
	Fk3PYg/pNno7zzSH1soxs3Zh3G3Yjh9iSXUhT3IXW83krRnMX/AEPR1mL8aTaWhY
	gU0xF6SHPR2wSLbzZgMgOFlS+gLxvnosYYswZ8b+DfgvNz/f/tZFN/Jsg0t8t3L9
	RvrDCSDiQVjlpU21RvAbsCNIDoWQXyikjNHk3zcHevlAdzx9XeZEGHvGRPwUk31e
	KsNOLBmoXJT/x6xO4OKN/yyF3sPBmQzfyvgcV3P5tzl9F6+V6acIpXSbCfoA3olV
	elQ+TXE=
Message-ID: <43194819-3aea-4541-900d-381fb27ebcc9@prolan.hu>
Date: Fri, 17 Jan 2025 17:58:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] spi: atmel-quadspi: Use `devm_dma_request_chan()`
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
References: <20250115160244.1102881-1-csokas.bence@prolan.hu>
 <20250115160244.1102881-3-csokas.bence@prolan.hu>
 <c0bf43cf-895c-4a0e-b771-39481b6bc024@sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <c0bf43cf-895c-4a0e-b771-39481b6bc024@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485264726B

Hi,

On 2025. 01. 15. 20:58, Mark Brown wrote:
> On Wed, Jan 15, 2025 at 05:02:40PM +0100, Bence Csókás wrote:
>> Leave releasing of DMA channels up to the devm
>> facilities. This way we can eliminate the rest
>> of the "goto ladder".
> 
> You've not copied me on the rest of the series so I don't know what's
> going on with dependencies.  When sending a patch series it is important
> to ensure that all the various maintainers understand what the
> relationship between the patches as the expecation is that there will be
> interdependencies.  Either copy everyone on the whole series or at least
> copy them on the cover letter and explain what's going on.  If there are
> no strong interdependencies then it's generally simplest to just send
> the patches separately to avoid any possible confusion.

I did not originally create a cover letter, but now I made one, that 
should make it clearer, that this series is mainly about the 3rd and 4th 
patch, sent to you and the SPI list, and the former two only add the new 
APIs they use, to the respective subsystems.

Bence


