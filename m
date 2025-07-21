Return-Path: <linux-spi+bounces-9146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69352B0C61F
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2B5434BC
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569092D6617;
	Mon, 21 Jul 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WAORxm88"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4955227;
	Mon, 21 Jul 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107745; cv=none; b=V+RRdnwg8WBXdxmIiu6bAvclVou9d0y7eyViOxfF48inC15/rD5cPOmixTOAsiFLHGoeh2UkM0HhyrGqVf7SgJIC0ilDoBTxCkxU4m/cZdDy0yQ29bPCrJmSLyWeHPvbBnOx5E9MoGi2AwWWLFK6PcTG+BX5nl69XK/jh9Zz4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107745; c=relaxed/simple;
	bh=oDy7UzkFzgzPxI3UJSjSR0GcOLA3VSfw2hi54qQq820=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqIso2h4z1FGnTgR4zrxECZz5NW7aCgi2LnPo/NV+YkngbDps5gKIxQ1IQOBKhuds4uQWzK8ob5LyevysnIwOjixsgQAXVM1cJu0C7JfZ5joNO99HP6o11CFWqsJs3Ns3NMGmgRfUYdC6n3LJi0SJIckwcnKZvo6lefvjRGOfpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WAORxm88; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68C461027235A;
	Mon, 21 Jul 2025 16:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753107734;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dIsc6hFBt27O44doVUiL9FU5pBOtVG/J+2i8b4k8GLo=;
	b=WAORxm88+wekMznNLYR0mDtKVCRI/sMIPRor3IscLGNV/hpMwY3zQobd6SJNQ/+bd4UOku
	rISEEt0E/QBkCT5J7Yfq2erw12kTpPEIrvV+VvFQ42QOKQsvVgqCpQw4oEiIh+2WkoeNmt
	bmP+e46yfnGyjqEys+Q3UYNQYj//+5Hvdri5hMDy9oGfWgbY65dNrf2m0sub/HpJDEE9AJ
	BGtWyGXYcLZs/QBbIfWZJUbcXywD0r8A+NcIW1VptztPVr+q2/ARvpFnFj2zLs16LFczKW
	Jh1rCGINIuUnaLWJSd9jFSBR8B9hwzkt65W0eSEqGrwtLYfBwxytPfbVp3m6lQ==
Message-ID: <2477dc64-92a0-9dc9-d168-56646d0d796e@denx.de>
Date: Mon, 21 Jul 2025 16:22:38 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 1/3] dt-bindings: trivial-devices: Document ABB sensors
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrei Lalaev <andrey.lalaev@gmail.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Grant Peltier <grantpeltier93@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, devicetree@vger.kernel.org
References: <20250719063355.73111-1-hs@denx.de>
 <20250719063355.73111-2-hs@denx.de> <20250720021151.GA931647-robh@kernel.org>
 <c972dcba-ec99-47e4-ad19-18ebe97dfdd0@roeck-us.net>
From: Heiko Schocher <hs@denx.de>
Reply-To: hs@denx.de
In-Reply-To: <c972dcba-ec99-47e4-ad19-18ebe97dfdd0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Guenther, Rob,

On 20.07.25 05:25, Guenter Roeck wrote:
> On 7/19/25 19:11, Rob Herring wrote:
>> On Sat, Jul 19, 2025 at 08:33:52AM +0200, Heiko Schocher wrote:
>>> Add documentation for spi based ABB sensors, which are
>>> currently operated from userspace.
>>
>> What is userspace? That has nothing to do with bindings.
>>
> 
> Taking one step further back ... what are "spi based ABB sensors" ?
> 
> Guenter
> 
>> Please provide some details about this h/w and convince me it is
>> trivial.

This sensors are fully controlled through spidev driver, with a simple
register based interface and they have no other connections as the SPI
lines, so they only need a compatible entry.

bye,
Heiko


>>
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>> ---
>>>
>>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml 
>>> b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> index 27930708ccd5..25260c2b81df 100644
>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> @@ -30,6 +30,8 @@ properties:
>>>       items:
>>>         # Entries are sorted alphanumerically by the compatible
>>>         - enum:
>>> +            # ABB register based spi sensors
>>> +          - abb,spi-sensor
>>>               # Acbel fsg032 power supply
>>>             - acbel,fsg032
>>>               # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over 
>>> Temperature Pin
>>> -- 
>>> 2.20.1
>>>

-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

