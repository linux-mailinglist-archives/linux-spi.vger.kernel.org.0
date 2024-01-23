Return-Path: <linux-spi+bounces-666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3928396B9
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 18:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0001C23775
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98806811E9;
	Tue, 23 Jan 2024 17:45:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A5880056;
	Tue, 23 Jan 2024 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031927; cv=none; b=J8fc6+yHmF3nlNr7W6DrX0K4gPfmHWEP5eucYw4s3MvOafPabDC7BATq9YldkgNqCpZJfEIQN8rE6UA3Mefl8iYYtJIZJcAc31j88r9CR+2jhhZJ6HTszbWG1zIc+S8yptXbOQmcgugeFvxu+8CZEagXilqUSWhW6wh6tOm0rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031927; c=relaxed/simple;
	bh=zlU95aLkeoIPXzeIB/V3X3YFOZP6ePz6r7snUDRfkbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cs60KD821DACTU3cg8+D9Wj55LmEuttQbM9JSfJlCjcAq+rhu47XY0ycFRxAbUbRFQAHKf+k0c78o3st5pTikB33xRehoyJyWNnfo/RetFdU0GVMH/40Jxbohyb+GGjFyyrcpy76F8zNKrahxsafdspgm2y1JpySV397dkn1F2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1681FB;
	Tue, 23 Jan 2024 09:46:08 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CEB63F5A1;
	Tue, 23 Jan 2024 09:45:21 -0800 (PST)
Message-ID: <97fcde65-9eb0-44e1-a87a-caa308d1998b@arm.com>
Date: Tue, 23 Jan 2024 17:45:20 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: dt-bindings: spi-rockchip: restrict num-cs
Content-Language: en-GB
To: Johan Jonker <jbx6244@gmail.com>, Luis de Arquer <ldearquer@gmail.com>,
 broonie@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <acc4ff4b-811a-4a6d-8f58-9d8da3be40bb@gmail.com>
 <d6fc0ad6-ce20-4604-89e5-2598dc3fc0a6@gmail.com>
 <344a3de8-7f10-46f0-9524-dca58ceda671@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <344a3de8-7f10-46f0-9524-dca58ceda671@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/01/2024 10:49 am, Johan Jonker wrote:
> 
> 
> On 1/23/24 10:17, Luis de Arquer wrote:
>> On 1/22/24 23:59, Johan Jonker wrote:
>>> In the driver spi-rockchip.c max_native_cs is limited to 4 and the
>>> default num-cs property is 1. Restrict num-cs in spi-rockchip.yaml.
>>>
>>
> 
>> Doesn't num-cs include gpio chip selects too?
>> I have a setup with num-cs = <12> which uses non-native cs-gpios just fine
> 
> Given that bindings and Linux drivers capabilities are 2 separate things.

Er, that's the whole point - bindings and drivers *are* separate things, 
and bindings do not describe drivers. Not least since the fundamental 
model is to have one canonical binding for multiple different drivers to 
consume.

There seems to be some ambiguity as to whether the common "num-cs" 
property is supposed to describe the number of dedicated hardware 
chipselects or the total number including additional GPIOs, but either 
way this change appears to be objectively wrong - if it's the former 
than the comment in the driver plus a survey of a few TRMs implies that 
the maximum number of hardware lines is 2; if it's the latter then 
obviously it's valid for a platform to wire up 3 or more additional 
GPIOs as desired, and for a DT to accurately describe that, regardless 
of whether any particular consumer happens to support it yet or not. For 
example, AFAICS the U-Boot and FreeBSD drivers for Rockchip SPI appear 
not to support GPIO chipselects at all.

Thanks,
Robin.

> However this document has also a purpose that must notify mainline maintainers if users submit bogus DT values.
> Currently that limit is set to 4 in the mainline driver.
> You are free to submit a real board file/patch serie afterwords as proof for review with 12 spi chips and then adjust this limit and increase ROCKCHIP_SPI_MAX_CS_NUM.
> 
> Johan
> 
>>
>> Luis
>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> ---
>>>    Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> index e4941e9212d1..00d555bcbad3 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> @@ -65,6 +65,11 @@ properties:
>>>          - const: tx
>>>          - const: rx
>>>
>>> +  num-cs:
>>> +    default: 1
>>> +    minimum: 1
>>> +    maximum: 4
>>> +
>>>      rx-sample-delay-ns:
>>>        default: 0
>>>        description:
>>> -- 
>>> 2.39.2
>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

