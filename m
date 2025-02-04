Return-Path: <linux-spi+bounces-6617-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2484A26D1D
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 09:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A11883E04
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAA2066D3;
	Tue,  4 Feb 2025 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RSvmR7FK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E470820;
	Tue,  4 Feb 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657183; cv=none; b=DLtUmA5yLwl3FQEtLcmTtQnv8MHu8kZAp1kN3wv6XseNhm6oX6CwSzAACScio6YmLvO+a9HJ9cOGPoTiiAyyz9prptpsPCpBp1RDwtk/ApOgyxCvri0W2OMKfu23Y8IA5e07zgNdktW4kUedan7SSgJbic1OERNgglXpYWX5+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657183; c=relaxed/simple;
	bh=M7zxArYMTcwOuzQ+xChRUeaLiOYMmjjUGPm4Sq7Jg+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ConAUl28bf0p4mOy0EF7o/snsy7adhheGlB4sq8c9Et4cL3cAu3S03HLdb32v5vFzItkMKSz4J2NitubJ4o0oKbl6eHDWnVrvvptUiN5jteu8kmVQuHSMjD+xdw+1UFKLPeYQwjnNnFJHBwntUIgc+OW0+g64ifiXA1aaHRGa7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RSvmR7FK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5147Zm7c014899;
	Tue, 4 Feb 2025 09:19:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6MeYU+3uv6k6Cssp1ZC7j+z+Esroz7pYxNOescKL69w=; b=RSvmR7FKbjuUC1Sp
	KXTrFERd3CP+4m2VHDVLi/JNNDDDPO1haj1NCaLI+m/iQPKFtUejsTz1sWEhbS33
	wSz52AepKxrXsixvTiFyA+EbNa99/3H4lJ35CvNO4W6jOlrRIkpgD3DOjWCHpX+u
	x3HBKTxMS59nU8pGDanxyaXEpu2yVxXvOnZPPoJc5tolrNioK1VHExbSlclVU8e/
	bOzPyqdGiOwsvmkG1cWq09xRSC5qI1QVfFJQUb/enH4RRxxQVXYkUeTd0hZolhgw
	5DwrBpKz0gwShPCnjWA7+yOVghtFHSOVQuTRbPPGi+xepe7jOcjYVfHV5qqO1zfx
	94jKYQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44jn0fnfv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 09:19:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4156840054;
	Tue,  4 Feb 2025 09:17:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 33BA9278A68;
	Tue,  4 Feb 2025 09:16:25 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 09:16:24 +0100
Message-ID: <5f5f66a7-92ff-4a5c-9ad5-d113814da0b0@foss.st.com>
Date: Tue, 4 Feb 2025 09:16:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] dt-bindings: memory-controllers: Add STM32 Octo
 Memory Manager controller
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-4-patrice.chotard@foss.st.com>
 <20250129-hilarious-glittering-mustang-fb5471@krzk-bin>
 <3660580d-72eb-45ca-8240-55557e334e37@foss.st.com>
 <951e4d16-2bb2-44b1-99e7-dd28349f20aa@kernel.org>
 <02b947e3-dd5c-4ee8-bd65-5775923fe33f@foss.st.com>
 <899675e8-4c2e-4ff2-a6af-854e0ec29bb6@kernel.org>
 <6ed4fa56-e7ee-4b6b-951b-61a92be5c6c2@foss.st.com>
 <6a639549-f8c8-4e36-8cfe-839f247780bb@kernel.org>
 <9073411a-38aa-4f82-95f5-474b0c3efed7@foss.st.com>
 <59b38b53-44c6-40ba-9344-de6de89532f6@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <59b38b53-44c6-40ba-9344-de6de89532f6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01



On 2/4/25 08:50, Krzysztof Kozlowski wrote:
> On 04/02/2025 08:29, Patrice CHOTARD wrote:
>>>>>>>>>> @@ -0,0 +1,190 @@
>>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>>>> +%YAML 1.2
>>>>>>>>>> +---
>>>>>>>>>> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32-omm.yaml#
>>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>>> +
>>>>>>>>>> +title: STM32 Octo Memory Manager (OMM)
>>>>>>>>>> +
>>>>>>>>>> +maintainers:
>>>>>>>>>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>>>>>> +
>>>>>>>>>> +description: |
>>>>>>>>>> +  The STM32 Octo Memory Manager is a low-level interface that enables an
>>>>>>>>>> +  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
>>>>>>>>>> +  function map) and multiplex of single/dual/quad/octal 		SPI interfaces over
>>>>>>>>>> +  the same bus. It Supports up to:
>>>>>>>>>> +    - Two single/dual/quad/octal SPI interfaces
>>>>>>>>>> +    - Two ports for pin assignment
>>>>>>>>>> +
>>>>>>>>>> +properties:
>>>>>>>>>> +  compatible:
>>>>>>>>>> +    const: st,stm32mp25-omm
>>>>>>>>>> +
>>>>>>>>>> +  "#address-cells":
>>>>>>>>>> +    const: 2
>>>>>>>>>> +
>>>>>>>>>> +  "#size-cells":
>>>>>>>>>> +    const: 1
>>>>>>>>>> +
>>>>>>>>>> +  ranges:
>>>>>>>>>> +    description: |
>>>>>>>>>> +      Reflects the memory layout with four integer values per OSPI instance.
>>>>>>>>>> +      Format:
>>>>>>>>>> +      <chip-select> 0 <registers base address> <size>
>>>>>>>>>
>>>>>>>>> Do you always have two children? If so, this should have maxItems.
>>>>>>>>
>>>>>>>> No, we can have one child.
>>>>>>>
>>>>>>> For the same SoC? How? You put the spi@ in the soc, so I don't
>>>>>>> understand how one child is possible.
>>>>>>
>>>>>> Yes for the same SoC, in DTSI file, the both OCTOSPI child are declared 
>>>>>> but are disabled by default.
>>>>>
>>>>> But the child node is there anyway so are the ranges.
>>>>
>>>> if both child are disabled, omm-manager should be disabled as well, 
>>>> omm-manager alone makes no sense.
>>>
>>>
>>> Yes, it is obvious, but how is this related?
>>
>> As described in the commit message, OMM manages the muxing of the 2 OSPI buses 
>> (its 2 child), that's the relation.
> 
> Again, nothing related to our discussion.
> 
> You claim you can have only one child and we do not talk about child
> disabled status here. So show me the product which have second address
> space removed from *the SoC*.
> 
>>
>> Do you want i add this directly in yaml file ?
> 
> 
> No, I want the answer when is it possible to have only one ranges. What
> such DTSI would represent - what real world hardware.

On our SoCs, there are always physically 2 OSPI instances, but one or two
instance can be enabled in the DT.

So we always have 2 ranges :

  ranges:
    description: |
      Reflects the memory layout with four integer values per OSPI instance.
      Format:
      <chip-select> 0 <registers base address> <size>
    minItems: 2
    maxItems: 2

Thanks 
Patrice


> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> In the DTS board file, 0,1 or 2 OCTOSPI instance can be enabled depending of the board design.
>>>>>>
>>>>>> In our case, on stm32mp257f-ev1 board, one SPI-NOR is soldered on PCB, so only one OCTOSPI 
>>>>>> instance is needed and enabled.
>>>>>>
>>>>>> Internally we got validation boards with several memory devices connected to OCTOSPI1 and 
>>>>>> OCTOSPI2, in this case, both OCTOSPI instance are needed and enabled.
>>>>>
>>>>> I could imagine that you would not want to have unused reserved ranges,
>>>>> so that one indeed is flexible, I agree.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +  reg:
>>>>>>>>>> +    items:
>>>>>>>>>> +      - description: OMM registers
>>>>>>>>>> +      - description: OMM memory map area
>>>>>>>>>> +
>>>>>>>>>> +  reg-names:
>>>>>>>>>> +    items:
>>>>>>>>>> +      - const: regs
>>>>>>>>>> +      - const: memory_map
>>>>>>>>>> +
>>>>>>>>>> +  memory-region:
>>>>>>>>>> +    description: Phandle to node describing memory-map region to used.
>>>>>>>>>> +    minItems: 1
>>>>>>>>>> +    maxItems: 2
>>>>>>>>>
>>>>>>>>> List the items with description instead with optional minItems. Why is
>>>>>>>>> this flexible in number of items?
>>>>>>>>
>>>>>>>> If only one child (OCTOSPI instance), only one memory-region is needed.
>>>>>>>
>>>>>>> Which is not possible... look at your DTSI.
>>>>>>
>>>>>> It's possible. if one OCTOSPI is used (the second one is kept disabled), only
>>>>>> one memory-region is needed.
>>>>>
>>>>> Ack.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Another update, i will reintroduce "memory-region-names:" which was 
>>>>>>>> wrongly removed in V2, i have forgotten one particular case.
>>>>>>>>
>>>>>>>> We need memory-region-names in case only one OCTOSPI instance is 
>>>>>>>> used. If it's OCTOCPI2 and the whole memory-map region
>>>>>>>> is dedicated to OCTOSPI2 (OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
>>>>>>>>
>>>>>>>> We need to know to which OCTOSPI instance the memory region is associated
>>>>>>>> with, in order to check "st,syscfg-amcr" 's value which must be coherent 
>>>>>>>> with memory region declared.
>>>>>>>>
>>>>>>>> so i will add :
>>>>>>>>
>>>>>>>>   memory-region-names:
>>>>>>>>     description: |
>>>>>>>>       OCTOSPI instance's name to which memory region is associated
>>>>>>>>     items:
>>>>>>>>       - const: ospi1
>>>>>>>>       - const: ospi2
>>>>>>>>
>>>>>>>
>>>>>>> I don't think this matches what you are saying to us. Let's talk about
>>>>>>> the hardware which is directly represented by DTS/DTSI. You always have
>>>>>>> two instances.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> We have 2 instances, but both not always enabled.
>>>>>> In case only one is enabled, only one memory-region-names is needed.
>>>>>>
>>>>>> We must know to which OCTCOSPI the memory-region makes reference to, in order
>>>>>> to configure and/or check the memory region split configuration. That' swhy 
>>>>>> the memory-regions-names must specify if it's the OCTOSPI1 or OCTOSPI2 instance.
>>>>>
>>>>> Well, in that case two comments.
>>>>> 1. Above syntax does not allow you to skip one item. You would need:
>>>>> items:
>>>>>   enum: [ospi1, ospi2]
>>>>> minItems: 1
>>>>> maxItems: 2
>>>>>
>>>>
>>>> ok
>>>>
>>>>> 2. But this points to other problem. From the omm-manager node point of
>>>>> view, you should define all the resources regardless whether the child
>>>>> is enabled or not. You do not skip some part of 'reg' if child is
>>>>> missing. Do not skip interrupts, access controllers, clocks etc.
>>>>> If some resource is to be skipped, it means that it belongs to the
>>>>> child, not to the parent, IMO.
>>>>
>>>> I didn't get your point. 
>>>>
>>>> The resource declared in omm-manager's node pnly belongs to omm-manager
>>>> (reg/clocks/resets/access-controllers/st,syscfg-amcr/power-domains), regardless 
>>>> there are 1 or 2 children. None of them can be skipped.
>>>
>>> That's not true, you skip ranges and memory region.
>>
>> If i have correctly understood, you want a constraint on range and memory-regions properties ?
>> Is it what you expect ?
>>
>>   ranges:
>>     description: |
>>       Reflects the memory layout with four integer values per OSPI instance.
>>       Format:
>>       <chip-select> 0 <registers base address> <size>
>>     minItems: 1
>>     maxItems: 2
>>
>>   memory-region-names:
>>     description: |
>>       OCTOSPI instance's name to which memory region is associated
>>     items:
>>       enum: [ospi1, ospi2]
>>     minItems: 1
>>     maxItems: 2
>>
> 
> 
> Best regards,
> Krzysztof

