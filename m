Return-Path: <linux-spi+bounces-9152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBBDB0D0C5
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jul 2025 06:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144F2188B4F8
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jul 2025 04:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD823FC52;
	Tue, 22 Jul 2025 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SDY32tfS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF81A0BDB;
	Tue, 22 Jul 2025 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157126; cv=none; b=DmOEBiCrDLpE2tFuBUh+ZzcjatwSYTy6Sxt41ybGnDAMTKsmLopmnLaQHrs3XfNXzW9UP9DQ7q3Vp/2OlFokA89tK5gq4lgWMeMUoYgv5UBpzcbfMv+rf7r0R8Hojplemfv6IqnWX8eYnGHDQS3uErGoPCmAFMfnCTnqvvjkxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157126; c=relaxed/simple;
	bh=K55yD1Ma6eC2A9HLm8c2k7UNaTufGqyNoR229HTD7Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCBJ+KgZEG37eZjonP9eDxOlOWkBXH05+rhqv2fXrijx8RbnNdiSmiFh+wnnZB0/az+jYVMjeZNNsRwNC3fvGStnFB45il3+AFncZXs7ZVwhHGvezMb08LyaitLOcrNIhgvBTL3037d+VtDmGO5bjJ1b+WemP0Cmvr93QG5g+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SDY32tfS; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 824221026E02A;
	Tue, 22 Jul 2025 06:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753157121;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=m7b5hGarLAQZ7wJX3z+HKwupNShCIskH0D5h01nt0B4=;
	b=SDY32tfSFz9zqLNKR+pX3Uk/W/Xzd5ZVXPEe2q4ZUeHX9EYBDOu+y3zT0mwKenJdgN3v+0
	5+MD523v3CJvOvs2LVpxJ7xzUTuZYyCiqaUxeKBa83xzMdTf3e1G7Lgbmytn0OFHvKh0bS
	JMDz4IVw0Ztc628Hbc0RqGVbYBg3Hi9SQrB8eSKCk84hsLWAkde6tW86HY5+rGgI0dZlFH
	yl7LppaXBVsN8EMt1+4CQMcmvXcWfXSep+IFQIUyHspcOlre4bdBSWZrjan7oheXBckaNp
	lFByEhJrXrlDnVH2AR+Im6UKjYKVFrvAMEQR8T3N2t261YXDOWPGTXVfrNVTzw==
Message-ID: <8a8106ea-83d3-e02a-9ae7-ea4a66e4c248@denx.de>
Date: Tue, 22 Jul 2025 06:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: (subset) [PATCH v1 0/3] spidev: introduce trivial abb sensor
 device
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrei Lalaev <andrey.lalaev@gmail.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Grant Peltier <grantpeltier93@gmail.com>, Guenter Roeck
 <linux@roeck-us.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20250719063355.73111-1-hs@denx.de>
 <175311337130.327079.7374455187420344577.b4-ty@kernel.org>
 <d677ecd9-42d6-43fe-8fe1-a5afd4d270e2@kernel.org>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <d677ecd9-42d6-43fe-8fe1-a5afd4d270e2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Krzysztof,

On 21.07.25 18:24, Krzysztof Kozlowski wrote:
> On 21/07/2025 17:56, Mark Brown wrote:
>> On Sat, 19 Jul 2025 08:33:51 +0200, Heiko Schocher wrote:
>>> This series introduces the changes needed for trivial spi
>>> based sensors from ABB, currently operated from userspace.
>>>
>>> The last patch adds the spidevices to the DTS files, already
>>> in mainline.
>>>
>>> make dtbs_check showed no errors/warnings for the dts files
>>>
>>> [...]
>>
>> Applied to
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>>
>> Thanks!
>>
>> [1/3] dt-bindings: trivial-devices: Document ABB sensors
>>        commit: aad2f87cbcab56b322109d26d7b11842a09df91f
>> [2/3] spi: spidev: Add an entry for the ABB spi sensors
>>        commit: d60f7cab7c04944a79af16caa43c141e780a59c6
>>
> 
> 
> That's unexpected, Mark. Patches received two objections/comments and I
> don't think discussion was resolved.
> 
> ABB is huge company, probably making hundreds or more of sensors. The
> patchset basically claims that all of them work with spidev. It does not
> providing any model names or details, so it seems really incomplete to
> call them trivial devices.

I do not know how many different sensors they have, nor if that department can
speak for the whole company...

What I have as information is:
https://lore.kernel.org/linux-spi/2477dc64-92a0-9dc9-d168-56646d0d796e@denx.de/

and I get no more information about them currently. May I should
add some sort of trivial into compatible name? Something like

"abb,spi-trivial-sensor"
or
"abb,spidev-trivial-sensor"

which makes it clearer, that only ABB trivial sensor, controlled through spidev
driver, is connected here?

Looking into definiton of "trivial devices" in
Documentation/devicetree/bindings/trivial-devices.yaml
"""
description: |
   This is a list of trivial I2C and SPI devices that have simple device tree
   bindings, consisting only of a compatible field, an address and possibly an
   interrupt line.
"""

which fits exactly, as they even have nothing more than the SPI lines
connected to the carrier board(s).

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

