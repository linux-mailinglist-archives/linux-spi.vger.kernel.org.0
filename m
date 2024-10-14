Return-Path: <linux-spi+bounces-5227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE099C389
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23818284646
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EBC14B07A;
	Mon, 14 Oct 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb1QAJvA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1100B1474A4;
	Mon, 14 Oct 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895071; cv=none; b=I7Rf3i5VANAHFH5yyBGvr0qZHIqNALzoakzrUXXxWKJ4mZwAYVnjXqDXWKJz6w7bglL9DpW8I26PqWpvrbdgm42v22PzPgQ/s3QCPVVtZaMGdrOpq1sX5xQ6kC+N+5yZW23yd4eC2rtwZV8V7cN2DsG8ef9qSMIH7liewi9HYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895071; c=relaxed/simple;
	bh=sAS2+CLCIrNcSJuSiRhzOJEAziqoeifAxCd0Bp4fzPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgqxqyoRE209Vs8acCGUk39CMTCSfbzqxlbJCt0pD8GMTNCwG7bcLbDIP4aXCz10t/L7hZQvrpz5Qbfj5QI/Hb974nkXJfl4PC+PCLou4iui7tMtvvGtV3z72qhKSC6QV3BqHtGu75irr6nGYG/djKZiZ3CpMsDvnmu8tn/BQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb1QAJvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A389C4CEC3;
	Mon, 14 Oct 2024 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728895070;
	bh=sAS2+CLCIrNcSJuSiRhzOJEAziqoeifAxCd0Bp4fzPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kb1QAJvAMMbFR30zd8Oikxs0WV9+jZ88dAniWmS84fPvZKZqg0nVLZ/duNeWqesRX
	 DxWJHnaxjzDAPL3mCI1hHIpMEu8kuWKqbwQMxe2E38HDCnFp3nG8qhSuSYmqBrDUgA
	 BLXdOsPIussGPSJ239K0Slr/sQC2Yeull0dhVcvkNbxS6raOMbC3MXH/tMH/nu+q6O
	 2Aa03OEZejg+DN1Tq5kkAhGTj2ZtO0ynyfWf9D5cOyunlOs+CPVtvFXTjsncQPHGy3
	 dCpMdCDSEFcNy9zB3A4zq+vIIoPsJNMgwjJ2m2BsBgkLZp1UNgbjw8RlSX/IHRC0To
	 USGpci6XwYI1w==
Message-ID: <0eea6407-9477-4fe6-a37a-c7996ccaf706@kernel.org>
Date: Mon, 14 Oct 2024 10:37:46 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
 <20241006233347.333586-2-chris.packham@alliedtelesis.co.nz>
 <3tu6x2644lxvvbk74nv5qva7qupsvgxyxkwc5g5n7n4bh3mbwi@457wbps4kpns>
 <963a57ec-c09d-4a4e-b8b8-a89354cf3264@alliedtelesis.co.nz>
 <8bf08456-0780-4dfe-9153-37ef5d01285b@alliedtelesis.co.nz>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <8bf08456-0780-4dfe-9153-37ef5d01285b@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2024 22:49, Chris Packham wrote:
> 
> On 8/10/24 08:58, Chris Packham wrote:
>>
>> On 7/10/24 19:40, Krzysztof Kozlowski wrote:
>>> On Mon, Oct 07, 2024 at 12:33:45PM +1300, Chris Packham wrote:
>>>> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
>>>> controller supports
>>>>   * Serial/Dual/Quad data with
>>>>   * PIO and DMA data read/write operation
>>>>   * Configurable flash access timing
>>>>
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>> ---
>>>>   .../bindings/spi/realtek,rtl9300-snand.yaml   | 58 
>>>> +++++++++++++++++++
>>>>   1 file changed, 58 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml 
>>>> b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>>> new file mode 100644
>>>> index 000000000000..c66aea24cb35
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>>> @@ -0,0 +1,58 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/spi/realtek,rtl9300-snand.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
>>>> +
>>>> +maintainers:
>>>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>> +
>>>> +description:
>>>> +  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It 
>>>> supports
>>>> +  typical SPI-NAND page cache operations in single, dual or quad IO 
>>>> mode.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>> Why 9300 cannot be alone? What does 9300 mean even? Wildcards and family
>>> models are not allowed in general.
>>
>> The main thing about the RTL9300 is that that is what all the Realtek 
>> documents use to refer to these chips and the specific numbers are 
>> akin to the manufacturing part number that you'd actually order (maybe 
>> that's a bit of a stretch).
>>
>> The SoC/CPU block probably does exist as a separate silicon die that 
>> they connect to the different switch blocks in the chips that they 
>> sell but I don't think you can get "just" the SoC. There is every 
>> chance that we'll see that same SoC/CPU block pop up in new chips (I 
>> see references to a RTL9302D in some documents). I'd like to be able 
>> to support these chips using "rtl9300" but if that's violating the 
>> wildcard rule I can drop it.
>>
> Maybe it's helpful to think of the RTL9300 as the IP block that is 
> integrated into the RTL9301, RTL9302B, etc.

Yeah, it could work but we discourage this pattern. New devices from
930x might not be compatible with 9300 and then it is unclear what
"9300" actually mean.

The generic recommendation: please go with specific compatibles and use
one specific compatible as fallback for others.

Best regards,
Krzysztof


