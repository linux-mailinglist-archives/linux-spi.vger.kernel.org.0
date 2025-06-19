Return-Path: <linux-spi+bounces-8675-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C8AE0B49
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482A41BC6AD7
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6926A08F;
	Thu, 19 Jun 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o1oiWiCk"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEB2BCF5;
	Thu, 19 Jun 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350061; cv=none; b=kSoagPiIZcKH1PRrksytwzpmJsvHZduMIx2Z3sVcw1Yik0XSJArZVGurWLUG02JaKF//k+vwkqK+w092jSVH9NfHglOUQhK0jPl5fHJv102/aQV0j2uNv3P7s1LE/byIrfYYFJvHInoV4Vm7BL8h1q/X+mE54YXQvIHOfXrkXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350061; c=relaxed/simple;
	bh=kPDfthMkxPFZanpnkw6rTYC0wNDIoDrAboTw+WSvhVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijvfrvyzFnR9GH5Hp3Wls9CVQW9WBb10CEAxs+TSYPXkYvuu1ldQJz5YZA/IfXs9xQaQBmkttss3QhyHSB+wBmxf48yyOeBIdPhsDvS0nCh6kKYvQ2pYTA0gQY4W+ur/ZsQQfrIF6lzOy/45aQRSisN33D1RuYP0Kw8DuEjAP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o1oiWiCk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdeb54e8-0624-42de-bac2-25b151c37872@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750350057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkIvAdIcknw7YGYgEy5AX0Ny3blQrj6I2SRgxFMhm0A=;
	b=o1oiWiCkmefm2k4pQhom1x13NN1mCxQEtwKqsY3LCg6R4zNo35wUI0HWjTuwvq/8KnittX
	DeTTv5QzBnpQWEuCfN2xouE7HmqFtOhD6r12vrIIG4x2pDVOLkYtApUapK6vkLJaKzNzr5
	tcf1+D5gXnfFpQwHkNsoRBOyjU+nZYc=
Date: Thu, 19 Jun 2025 12:20:53 -0400
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: zynqmp-qspi: Add example dual
 upper/lower bus
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-3-sean.anderson@linux.dev>
 <2588bb7f-2a3a-4001-ab1b-6d9bd57b545b@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2588bb7f-2a3a-4001-ab1b-6d9bd57b545b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/25 14:27, David Lechner wrote:
> On 6/16/25 5:00 PM, Sean Anderson wrote:
>> Add an example of the spi-buses property showcasing how to have devices
>> on both the upper and lower buses.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v2:
>> - New
>> 
>>  .../bindings/spi/spi-zynqmp-qspi.yaml         | 22 ++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> index 02cf1314367b..c6a57fbb9dcf 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> 
> 
> In addition to changing the example, we could also extend the
> spi-buses property for this controller since we know this controller
> has 2 buses.
> 
>   properties:
>     ...
> 

OK, but this property is for the slaves not the master. I'm not sure what the right incantation is.

>     spi-buses:
>       description: 0 is the "lower" bus, 1 is the "upper" bus
>       maxItems: 2
>       items:
>         enum: [0, 1]
> 
> Not sure what to do about the default though since as discussed elsewhere,
> this controller needs the default bus number to be the CS number for
> backwards compatibility rather than `default: [0]` as is specified in the
> previous patch.
> 
> I suppose we could leave default out of the generic binding and leave it
> up to each individual controller to decide how to handle that.
> 
>> @@ -69,7 +69,7 @@ examples:
>>        #address-cells = <2>;
>>        #size-cells = <2>;
>>  
>> -      qspi: spi@ff0f0000 {
>> +      qspi: spi-controller@ff0f0000 {
> 
> It seems more common to have spi@ rather than spi-controller@.
> Is there a push to change this in general?

iirc I got a warning when running dt_binding_check. I can re-test this...

--Sean

