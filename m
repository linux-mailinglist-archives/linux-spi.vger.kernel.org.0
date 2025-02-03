Return-Path: <linux-spi+bounces-6603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3343A25747
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681E73A7F4F
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5CC2010F2;
	Mon,  3 Feb 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Gksx7lmO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94641201024;
	Mon,  3 Feb 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579811; cv=none; b=m2yWvNnbGWjwygL4+JmfCZDUeFQmYtDdM/2iPpwcBJWgNKCWgmA8bu5gSegFVC3m1HDsdpvhtL/FgawHj/rVFpUwihWMB4cOtjGJf+q1mlmEzWfSsYE00aeF1UjZb2dABLnhn/EEn9vSwK45BOkEGNB1C0vLJmbL/6JcIdQ7AVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579811; c=relaxed/simple;
	bh=5qRyOo7fHFJsMsHnJpp1aN1BupFN+2ztnDkgaiRY52Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y5o+TdNeoORcQp03e6q8NgVKLmDA1PwsBq8GnGci1NFo/MH7e8T/C+S1CBXD7EJoBtILwmOJ9II2zJ1sqvcJB2rsNYs96kltTldsTEDjdVkyr7SG+fy04/pXTX9iGRQGIdV2XkSsdzVvIJEkj1IyiKwpyu0ZMs/xtc/F71AHuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Gksx7lmO; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5139s138007606;
	Mon, 3 Feb 2025 11:49:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0/GZYONbUw+vHeMUT3pjzlV0AgWUAJmiWS+nOFrfPdE=; b=Gksx7lmOQcxX3Vk/
	U2ofqLNErlG+UfG6pHP3undf8l87Fz+YP1U3LVYoczH3yEk0UxPjD01XhExw+yy2
	N37yVBm2Ak0rlmj7F+KG9OKKLmbdamjK4y+7IHC02Q1/q43MagQ9lV1Begqaz5kO
	Vhm+uIsIXZBaSsaQ4O4yaF1usXLCRyW0kwIUWtiQ6YoFOlk9NJONEznPt2whFkfj
	nO785vJpW5W6tRefOp2wXex2PQSfJjInTaiod1aX3i/tHRpBM4yPQP/9R3cHXemO
	fH7utGp4z6NmyF2I4R+AhluCmLevi77LdMrbXbGH4uEvaYgA8cSs62XpzGWlZdX2
	cFj03A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44jujv881h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 11:49:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F11C4002D;
	Mon,  3 Feb 2025 11:48:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DBB652501EC;
	Mon,  3 Feb 2025 11:46:42 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 11:46:41 +0100
Message-ID: <6ed4fa56-e7ee-4b6b-951b-61a92be5c6c2@foss.st.com>
Date: Mon, 3 Feb 2025 11:46:40 +0100
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
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <899675e8-4c2e-4ff2-a6af-854e0ec29bb6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_04,2025-01-31_02,2024-11-22_01



On 1/30/25 16:09, Krzysztof Kozlowski wrote:
> On 30/01/2025 14:32, Patrice CHOTARD wrote:
>>
>>
>> On 1/30/25 13:12, Krzysztof Kozlowski wrote:
>>> On 30/01/2025 09:57, Patrice CHOTARD wrote:
>>>>
>>>>
>>>> On 1/29/25 08:52, Krzysztof Kozlowski wrote:
>>>>> On Tue, Jan 28, 2025 at 09:17:25AM +0100, patrice.chotard@foss.st.com wrote:
>>>>>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>>
>>>>>> Add bindings for STM32 Octo Memory Manager (OMM) controller.
>>>>>>
>>>>>> OMM manages:
>>>>>>   - the muxing between 2 OSPI busses and 2 output ports.
>>>>>>     There are 4 possible muxing configurations:
>>>>>>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>>>>>>         output is on port 2
>>>>>>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>>>>>>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>>>>>>         OSPI2 output is on port 1
>>>>>>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>>>>>>   - the split of the memory area shared between the 2 OSPI instances.
>>>>>>   - chip select selection override.
>>>>>>   - the time between 2 transactions in multiplexed mode.
>>>>>>
>>>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>> ---
>>>>>>  .../memory-controllers/st,stm32-omm.yaml      | 190 ++++++++++++++++++
>>>>>>  1 file changed, 190 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..7e0b150e0005
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>>>>>
>>>>>
>>>>> Filename as compatible, so st,stm32mp25-omm.yaml
>>>>>
>>>>> You already received this comment.
>>>>
>>>> Sorry, i missed this update
>>>>
>>>>>
>>>>>> @@ -0,0 +1,190 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32-omm.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: STM32 Octo Memory Manager (OMM)
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  The STM32 Octo Memory Manager is a low-level interface that enables an
>>>>>> +  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
>>>>>> +  function map) and multiplex of single/dual/quad/octal 		SPI interfaces over
>>>>>> +  the same bus. It Supports up to:
>>>>>> +    - Two single/dual/quad/octal SPI interfaces
>>>>>> +    - Two ports for pin assignment
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: st,stm32mp25-omm
>>>>>> +
>>>>>> +  "#address-cells":
>>>>>> +    const: 2
>>>>>> +
>>>>>> +  "#size-cells":
>>>>>> +    const: 1
>>>>>> +
>>>>>> +  ranges:
>>>>>> +    description: |
>>>>>> +      Reflects the memory layout with four integer values per OSPI instance.
>>>>>> +      Format:
>>>>>> +      <chip-select> 0 <registers base address> <size>
>>>>>
>>>>> Do you always have two children? If so, this should have maxItems.
>>>>
>>>> No, we can have one child.
>>>
>>> For the same SoC? How? You put the spi@ in the soc, so I don't
>>> understand how one child is possible.
>>
>> Yes for the same SoC, in DTSI file, the both OCTOSPI child are declared 
>> but are disabled by default.
> 
> But the child node is there anyway so are the ranges.

if both child are disabled, omm-manager should be disabled as well, 
omm-manager alone makes no sense.

> 
>>
>> In the DTS board file, 0,1 or 2 OCTOSPI instance can be enabled depending of the board design.
>>
>> In our case, on stm32mp257f-ev1 board, one SPI-NOR is soldered on PCB, so only one OCTOSPI 
>> instance is needed and enabled.
>>
>> Internally we got validation boards with several memory devices connected to OCTOSPI1 and 
>> OCTOSPI2, in this case, both OCTOSPI instance are needed and enabled.
> 
> I could imagine that you would not want to have unused reserved ranges,
> so that one indeed is flexible, I agree.
> 
>>
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +  reg:
>>>>>> +    items:
>>>>>> +      - description: OMM registers
>>>>>> +      - description: OMM memory map area
>>>>>> +
>>>>>> +  reg-names:
>>>>>> +    items:
>>>>>> +      - const: regs
>>>>>> +      - const: memory_map
>>>>>> +
>>>>>> +  memory-region:
>>>>>> +    description: Phandle to node describing memory-map region to used.
>>>>>> +    minItems: 1
>>>>>> +    maxItems: 2
>>>>>
>>>>> List the items with description instead with optional minItems. Why is
>>>>> this flexible in number of items?
>>>>
>>>> If only one child (OCTOSPI instance), only one memory-region is needed.
>>>
>>> Which is not possible... look at your DTSI.
>>
>> It's possible. if one OCTOSPI is used (the second one is kept disabled), only
>> one memory-region is needed.
> 
> Ack.
> 
>>
>>>
>>>>
>>>> Another update, i will reintroduce "memory-region-names:" which was 
>>>> wrongly removed in V2, i have forgotten one particular case.
>>>>
>>>> We need memory-region-names in case only one OCTOSPI instance is 
>>>> used. If it's OCTOCPI2 and the whole memory-map region
>>>> is dedicated to OCTOSPI2 (OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
>>>>
>>>> We need to know to which OCTOSPI instance the memory region is associated
>>>> with, in order to check "st,syscfg-amcr" 's value which must be coherent 
>>>> with memory region declared.
>>>>
>>>> so i will add :
>>>>
>>>>   memory-region-names:
>>>>     description: |
>>>>       OCTOSPI instance's name to which memory region is associated
>>>>     items:
>>>>       - const: ospi1
>>>>       - const: ospi2
>>>>
>>>
>>> I don't think this matches what you are saying to us. Let's talk about
>>> the hardware which is directly represented by DTS/DTSI. You always have
>>> two instances.
>>>
>>>
>>
>> We have 2 instances, but both not always enabled.
>> In case only one is enabled, only one memory-region-names is needed.
>>
>> We must know to which OCTCOSPI the memory-region makes reference to, in order
>> to configure and/or check the memory region split configuration. That' swhy 
>> the memory-regions-names must specify if it's the OCTOSPI1 or OCTOSPI2 instance.
> 
> Well, in that case two comments.
> 1. Above syntax does not allow you to skip one item. You would need:
> items:
>   enum: [ospi1, ospi2]
> minItems: 1
> maxItems: 2
> 

ok

> 2. But this points to other problem. From the omm-manager node point of
> view, you should define all the resources regardless whether the child
> is enabled or not. You do not skip some part of 'reg' if child is
> missing. Do not skip interrupts, access controllers, clocks etc.
> If some resource is to be skipped, it means that it belongs to the
> child, not to the parent, IMO.

I didn't get your point. 

The resource declared in omm-manager's node pnly belongs to omm-manager
(reg/clocks/resets/access-controllers/st,syscfg-amcr/power-domains), regardless 
there are 1 or 2 children. None of them can be skipped.

If omm-manager has no child enabled, omm-manager must be disabled as well in DT.

> Therefore memory-region looks like child's property.
> 
> Imagine different case: runtime loaded overlay. In your setup, you probe
> omm-manager with one memory-region and one child. Then someone loads
> overlay enabling the second child, second SPI.
> 
> That's of course imaginary case, but shows the concept how the parent
> would work.
> 
> It's the same with other buses in the kernel. You can load overlay with
> any new child and the parent should not get new properties.
> 

In case of runtime loaded overlay, if a second child is added with an associated 
memory-region, omm-manager must be unbind/bind to :
  _ check the added child's access rights.
  _ take into account the added child's memory-region configuration (to set 
    the syscfg-amcr register accordingly) 

Thanks
Patrice

> 
> 
> Best regards,
> Krzysztof

