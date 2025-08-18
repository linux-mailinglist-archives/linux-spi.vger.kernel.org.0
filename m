Return-Path: <linux-spi+bounces-9508-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A593B2AC02
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 17:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E63117F0BD
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876F35A2B2;
	Mon, 18 Aug 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cYEqHqx6"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBB35A2AC
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529043; cv=none; b=UKIKL14olaIXf5wrHboxZOH0JurTc/maSFn7t3TOGt3DQ1Zo6UqOyryEHn9OgDz7idC+XlOsVOv7+a4s/7d7nJ7MRt+00AJ+KNT4Tiu/d5+FzGvVA47RhjCrAg9396djxGNZydL7NTWBrcG4dwJTwAfD6NCYQgdbd/2s59TKljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529043; c=relaxed/simple;
	bh=EtpwQWSiJMe0N0G9xdPULlAZaQP/BS5/BHcWMwdb+eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quQLXMx7cHdNC8YeEEU/9eruoY1HlM/ys7Xaeerxf1yAfthe1nQ7xfBhS0LbgGA5BBCvxNLrfUcNUlbvDeTtb5CZGMQ5+7QMwlbf4/LqS6lsYsUnMNgK5N26gEpFLAjBLkUhnbnLA/DABWlbNtoEhrXsjlJKlxPxjeN81XZUXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cYEqHqx6; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a3b69b8-e868-49c8-a0ca-c448ee3cd488@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755529036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnKB1/Ufaqgg4Uj8GyIwDI8Vao4ATbv9GiVbMHy8WVA=;
	b=cYEqHqx6zmsFWzI1DlT26wxFXuVBrL8Y04M0JduHYf20UEoKf3C4ZGl/okEeKg2iMlPMzc
	ABfD0lBg/TUR6igtOjna9ThcFbkwt0iWhjWPnuEZ/EY1bdm76sbVYyLvUohMvhjpZ3sybL
	1n9RWwZDZRaAJ1ePZ6MfkhaOa6WOPjU=
Date: Mon, 18 Aug 2025 10:56:50 -0400
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/15/25 11:49, David Lechner wrote:
> On 6/16/25 5:00 PM, Sean Anderson wrote:
>> From: David Lechner <dlechner@baylibre.com>
>> 
>> Add a spi-buses property to the spi-peripheral-props binding to allow
>> specifying the SPI bus or buses that a peripheral is connected to in
>> cases where the SPI controller has more than one physical SPI bus.
>> 
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v2:
>> - New
>> 
>>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> index 8fc17e16efb2..cfdb55071a08 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> @@ -89,6 +89,16 @@ properties:
>>      description:
>>        Delay, in microseconds, after a write transfer.
>>  
>> +  spi-buses:
>> +    description:
>> +      Array of bus numbers that describes which SPI buses of the controller are
>> +      connected to the peripheral. This only applies to peripherals connected
>> +      to specialized SPI controllers that have multiple SPI buses on a single
>> +      controller.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
> 
> Finally have some hardware to test this series with using 2 or 4 buses.
> I found that we also need an absolute max here to make the bindings checker
> happy. 8 seems sensible since I haven't seen more than that on a peripheral.
> We can always increase it if we find hardware that requires more buses.
> 
> 	maxItems: 8

What is the error you get without this?

--Sean


