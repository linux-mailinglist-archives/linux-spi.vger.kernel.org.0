Return-Path: <linux-spi+bounces-6594-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A6A230D9
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 16:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092AA1888161
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABDE1E9B28;
	Thu, 30 Jan 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTfICIqA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DED1E98E7;
	Thu, 30 Jan 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249758; cv=none; b=tvCzjbqHv6U31Ayg670iwOffCrG7P96i9nzV2BqdFWzTcltpCjgTEpX9mtxYAWFDbBkVn9oGoT/fJxqGzC/L42lkFXQg8razUvK/U+y9mkAKf7DQz5VG4TD6t7BsDMSH0zBcmFFSuztgJPzhszLShG9iyU+wkuk9eA1mzxy4O0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249758; c=relaxed/simple;
	bh=1lENOrBuzaiptZUl0nwSS5uQHpvkdQsRgMkvtdCe9zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5SbiR0LzB+oNMW9JxSdOepEjHL+lA5zkidjNwJkVjEAgFJPYxabuJxSomFSgvsTKkDxRo+9lhfgDqkRFatZGm1D8plJc4nTd5bUCBEnCWoZazy0cjvgIJWiuelj1VDupuS1oh3hDqD0SFm/OJ7TynQkmoevVxGaazr4ItR92W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTfICIqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D10C4CED2;
	Thu, 30 Jan 2025 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738249758;
	bh=1lENOrBuzaiptZUl0nwSS5uQHpvkdQsRgMkvtdCe9zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HTfICIqAght9yWAmdjzfR2F+ZYURALpMimc125Z8vIm+FaoueBOUttObIOtGPeF2Q
	 ObESx7k5p/RF9JiLq+vZRnstwdXzIunARv30EjEGmC327ifhKeqYehk82D2fZgLaR5
	 hvfkSmGU5FuFX6o2SysNGkb5UYRinT1Sl/8aDJCQN62vKoJ3mPNVocxbZtSlZsTyfQ
	 vBHCPbLG2d/4weN7RE5bEU8E6HCvXER3xF+pHpm7M7kx+9JLI6boZNyvp37fO3D5zt
	 Di5nhZeJqCOk2xTTPRNaO/mXn5lohpj0PEe5Vl1ylKLHKbnIWqip6A091zhx9NNfoY
	 TmvXV+nEjrwQQ==
Message-ID: <899675e8-4c2e-4ff2-a6af-854e0ec29bb6@kernel.org>
Date: Thu, 30 Jan 2025 16:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] dt-bindings: memory-controllers: Add STM32 Octo
 Memory Manager controller
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 christophe.kerello@foss.st.com
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-4-patrice.chotard@foss.st.com>
 <20250129-hilarious-glittering-mustang-fb5471@krzk-bin>
 <3660580d-72eb-45ca-8240-55557e334e37@foss.st.com>
 <951e4d16-2bb2-44b1-99e7-dd28349f20aa@kernel.org>
 <02b947e3-dd5c-4ee8-bd65-5775923fe33f@foss.st.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <02b947e3-dd5c-4ee8-bd65-5775923fe33f@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2025 14:32, Patrice CHOTARD wrote:
> 
> 
> On 1/30/25 13:12, Krzysztof Kozlowski wrote:
>> On 30/01/2025 09:57, Patrice CHOTARD wrote:
>>>
>>>
>>> On 1/29/25 08:52, Krzysztof Kozlowski wrote:
>>>> On Tue, Jan 28, 2025 at 09:17:25AM +0100, patrice.chotard@foss.st.com wrote:
>>>>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>
>>>>> Add bindings for STM32 Octo Memory Manager (OMM) controller.
>>>>>
>>>>> OMM manages:
>>>>>   - the muxing between 2 OSPI busses and 2 output ports.
>>>>>     There are 4 possible muxing configurations:
>>>>>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>>>>>         output is on port 2
>>>>>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>>>>>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>>>>>         OSPI2 output is on port 1
>>>>>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>>>>>   - the split of the memory area shared between the 2 OSPI instances.
>>>>>   - chip select selection override.
>>>>>   - the time between 2 transactions in multiplexed mode.
>>>>>
>>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>> ---
>>>>>  .../memory-controllers/st,stm32-omm.yaml      | 190 ++++++++++++++++++
>>>>>  1 file changed, 190 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..7e0b150e0005
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>>>>
>>>>
>>>> Filename as compatible, so st,stm32mp25-omm.yaml
>>>>
>>>> You already received this comment.
>>>
>>> Sorry, i missed this update
>>>
>>>>
>>>>> @@ -0,0 +1,190 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32-omm.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: STM32 Octo Memory Manager (OMM)
>>>>> +
>>>>> +maintainers:
>>>>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>>>>> +
>>>>> +description: |
>>>>> +  The STM32 Octo Memory Manager is a low-level interface that enables an
>>>>> +  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
>>>>> +  function map) and multiplex of single/dual/quad/octal 		SPI interfaces over
>>>>> +  the same bus. It Supports up to:
>>>>> +    - Two single/dual/quad/octal SPI interfaces
>>>>> +    - Two ports for pin assignment
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: st,stm32mp25-omm
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 2
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  ranges:
>>>>> +    description: |
>>>>> +      Reflects the memory layout with four integer values per OSPI instance.
>>>>> +      Format:
>>>>> +      <chip-select> 0 <registers base address> <size>
>>>>
>>>> Do you always have two children? If so, this should have maxItems.
>>>
>>> No, we can have one child.
>>
>> For the same SoC? How? You put the spi@ in the soc, so I don't
>> understand how one child is possible.
> 
> Yes for the same SoC, in DTSI file, the both OCTOSPI child are declared 
> but are disabled by default.

But the child node is there anyway so are the ranges.

> 
> In the DTS board file, 0,1 or 2 OCTOSPI instance can be enabled depending of the board design.
> 
> In our case, on stm32mp257f-ev1 board, one SPI-NOR is soldered on PCB, so only one OCTOSPI 
> instance is needed and enabled.
> 
> Internally we got validation boards with several memory devices connected to OCTOSPI1 and 
> OCTOSPI2, in this case, both OCTOSPI instance are needed and enabled.

I could imagine that you would not want to have unused reserved ranges,
so that one indeed is flexible, I agree.

> 
>>
>>>
>>>>
>>>>> +
>>>>> +  reg:
>>>>> +    items:
>>>>> +      - description: OMM registers
>>>>> +      - description: OMM memory map area
>>>>> +
>>>>> +  reg-names:
>>>>> +    items:
>>>>> +      - const: regs
>>>>> +      - const: memory_map
>>>>> +
>>>>> +  memory-region:
>>>>> +    description: Phandle to node describing memory-map region to used.
>>>>> +    minItems: 1
>>>>> +    maxItems: 2
>>>>
>>>> List the items with description instead with optional minItems. Why is
>>>> this flexible in number of items?
>>>
>>> If only one child (OCTOSPI instance), only one memory-region is needed.
>>
>> Which is not possible... look at your DTSI.
> 
> It's possible. if one OCTOSPI is used (the second one is kept disabled), only
> one memory-region is needed.

Ack.

> 
>>
>>>
>>> Another update, i will reintroduce "memory-region-names:" which was 
>>> wrongly removed in V2, i have forgotten one particular case.
>>>
>>> We need memory-region-names in case only one OCTOSPI instance is 
>>> used. If it's OCTOCPI2 and the whole memory-map region
>>> is dedicated to OCTOSPI2 (OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
>>>
>>> We need to know to which OCTOSPI instance the memory region is associated
>>> with, in order to check "st,syscfg-amcr" 's value which must be coherent 
>>> with memory region declared.
>>>
>>> so i will add :
>>>
>>>   memory-region-names:
>>>     description: |
>>>       OCTOSPI instance's name to which memory region is associated
>>>     items:
>>>       - const: ospi1
>>>       - const: ospi2
>>>
>>
>> I don't think this matches what you are saying to us. Let's talk about
>> the hardware which is directly represented by DTS/DTSI. You always have
>> two instances.
>>
>>
> 
> We have 2 instances, but both not always enabled.
> In case only one is enabled, only one memory-region-names is needed.
> 
> We must know to which OCTCOSPI the memory-region makes reference to, in order
> to configure and/or check the memory region split configuration. That' swhy 
> the memory-regions-names must specify if it's the OCTOSPI1 or OCTOSPI2 instance.

Well, in that case two comments.
1. Above syntax does not allow you to skip one item. You would need:
items:
  enum: [ospi1, ospi2]
minItems: 1
maxItems: 2

2. But this points to other problem. From the omm-manager node point of
view, you should define all the resources regardless whether the child
is enabled or not. You do not skip some part of 'reg' if child is
missing. Do not skip interrupts, access controllers, clocks etc.
If some resource is to be skipped, it means that it belongs to the
child, not to the parent, IMO.
Therefore memory-region looks like child's property.

Imagine different case: runtime loaded overlay. In your setup, you probe
omm-manager with one memory-region and one child. Then someone loads
overlay enabling the second child, second SPI.

That's of course imaginary case, but shows the concept how the parent
would work.

It's the same with other buses in the kernel. You can load overlay with
any new child and the parent should not get new properties.



Best regards,
Krzysztof

