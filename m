Return-Path: <linux-spi+bounces-6588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D6A22BAF
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375461888350
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4541D1BC07A;
	Thu, 30 Jan 2025 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kpOfO+1y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20F1BAEDC;
	Thu, 30 Jan 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233361; cv=none; b=mXIYC3z31+7kT40NqTFR4J4FvEuJSwc0svnqjG2ZPvnKBRpx1eQnxR9Zifd1TAeGWuXbkCzhPHFrsMCqtMKguJyck1AJmGoWj/x44eVTSoofHCVAHaqYXTHutb4xMsy9GZPnhfK2FFNfBXeIitU3VnnKLuM+iDzLIH+f89+mkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233361; c=relaxed/simple;
	bh=5z+wRZpEqX+kPlqNVCC+pt8qUvz4Qd6q/gFCEFIg6rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bdfC6rnMUcQLYRfJVVsgw8B6QUswJXGNzlt+w7yoLcZ5TmaERh/oAfjddHWUELKBRAgIC9fxZmxj0MAAfrT1/Et+2DFzVhgC6+10kiicnh4I+BhJUzir6iS8oO2OqyMm7Av+n7FtdepPX0Zim2jQCZXP2g7cnxPMnhTe3HU1VBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kpOfO+1y; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9u2rq019131;
	Thu, 30 Jan 2025 11:35:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	sx5gkR4IdqbzkIS+yns0BVsIJ+yIRuR2yrsyI1GNxUI=; b=kpOfO+1yAXvW6VCy
	xVneHeQHTWmVyj/8j+5so/BUnZEOWlj5h396a97h7i5md0VRDu3UhJcP1ejuF5co
	43bXlW4YcxgFfIUHK6rtVPepb87tc6wyHlh87zZkKeR5ki4kDByVG/a/JA778Epr
	m3UEQ3eJOyrlpu0T55RHwGkxnxX0aO+Up/WsGWvaMv1l8Slxas4MjO89P+JFGKN4
	LcyiPAwgPaas/uEPNXYKinQM4jdULde++zMPazcww08Gn2FDpuqPju/Orxsd2DLK
	IhDOs5WQWh3MVXJmyzSDfOOn3mpyql2ykNEp45cUn+dBMf8Aw3nk4H2wx3AwnDur
	bvNklA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44g5jxrpxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:35:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4060F4002D;
	Thu, 30 Jan 2025 11:34:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4DF328A872;
	Thu, 30 Jan 2025 11:28:17 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 11:28:16 +0100
Message-ID: <5892e452-96e7-4945-a2dd-2e713d85d751@foss.st.com>
Date: Thu, 30 Jan 2025 11:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add STM32 OSPI controller
To: Conor Dooley <conor@kernel.org>
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
 <20250128081731.2284457-2-patrice.chotard@foss.st.com>
 <20250128-panama-manly-a753d91c297c@spud>
 <e3d01bce-a7d4-4690-8a2f-3bbb1ee5ccb7@foss.st.com>
 <20250129-feminize-spotlight-2cee53f8b463@spud>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250129-feminize-spotlight-2cee53f8b463@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01



On 1/29/25 18:53, Conor Dooley wrote:
> On Wed, Jan 29, 2025 at 06:40:23PM +0100, Patrice CHOTARD wrote:
>> On 1/28/25 19:02, Conor Dooley wrote:
>>> On Tue, Jan 28, 2025 at 09:17:23AM +0100, patrice.chotard@foss.st.com wrote:
>>>> +  memory-region:
>>>> +    maxItems: 1
>>>
>>> Whatever about not having descriptions for clocks or reg when there's
>>> only one, I think a memory region should be explained.
>>
>> ok i will add :
>>
>>     description: |
> 
> The | isn't needed here.
> 
>>       Memory region to be used for memory-map read access.
> 
> I don't think that's a good explanation, sorry. Why's a memory-region
> required for read access?
> 
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  resets:
>>>> +    items:
>>>> +      - description: phandle to OSPI block reset
>>>> +      - description: phandle to delay block reset
>>>> +
>>>> +  dmas:
>>>> +    maxItems: 2
>>>> +
>>>> +  dma-names:
>>>> +    items:
>>>> +      - const: tx
>>>> +      - const: rx
>>>> +
>>>> +  st,syscfg-dlyb:
>>>> +    description: phandle to syscon block
>>>> +      Use to set the OSPI delay block within syscon to
>>>> +      tune the phase of the RX sampling clock (or DQS) in order
>>>> +      to sample the data in their valid window and to
>>>> +      tune the phase of the TX launch clock in order to meet setup
>>>> +      and hold constraints of TX signals versus the memory clock.
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>
>>> Why do you need a phandle here? I assume looking up by compatible ain't
>>> possible because you have multiple controllers on the SoC? Also, I don't
>>
>> Yes, we got 2 OCTOSPI controller, each of them have a dedicated delay block
>>  syscfg register.
> 
> :+1: 
> 
>>> think your copy-paste "phandle to" stuff here is accurate:
>>>       st,syscfg-dlyb = <&syscfg 0x1000>;
>>> There's an offset here that you don't mention in your description.
>>
>> I will add it as following:
>>
>>   st,syscfg-dlyb:
>>     description:
>>       Use to set the OSPI delay block within syscon to
>>       tune the phase of the RX sampling clock (or DQS) in order
>>       to sample the data in their valid window and to
>>       tune the phase of the TX launch clock in order to meet setup
>>       and hold constraints of TX signals versus the memory clock.
>>     $ref: /schemas/types.yaml#/definitions/phandle-array
>>     items:
>>       - description: phandle to syscfg
>>       - description: register offset within syscfg
> 
> :+1:
> 
>>>> +  access-controllers:
>>>> +    description: phandle to the rifsc device to check access right
>>>> +      and in some cases, an additional phandle to the rcc device for
>>>> +      secure clock control
>>>
>>> This should be described using items rather than a free-form list.
>>
>>   access-controllers:
>>     description: phandle to the rifsc device to check access right
>>       and in some cases, an additional phandle to the rcc device for
>>       secure clock control
>>     items:
>>       - description: phandle to bus controller or to clock controller
>>       - description: access controller specifier
>>      minItems: 1
>>      maxItems: 2
> 
> These updates look fine to me.

I got an issue with access-controllers property.

i can't list the 2 items (the second one is optional) and use minItems and maxItems.

For example:

 access-controllers:
    description: phandle to the rifsc device to check access right
      and in some cases, an additional phandle to the rcc device for
      secure clock control.
    items:
      - description: phandle to bus controller
      - description: phandle to clock controller
    minItems: 1
    maxItems: 2


make dt_binding_check DT_SCHEMA_FILES=st,stm32mp25-ospi.yaml

Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml: properties:access-controllers: {'description': 'phandle to the rifsc device to check access right and in some cases, an additional phandle to the rcc device for secure clock control.', 'items': [{'description': 'phandle to bus controller'}, {'description': 'phandle to clock controller'}], 'minItems': 1, 'maxItems': 2} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
  DTC [C] Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.example.dtb

How can i indicate that at least one items is mandatory, the second one is optional and in the same
time describing the both items as required without getting the above error ? 


On other yaml files, for examples 
/usb/dwc2.yaml 
spi/st,stm32-qspi.yaml
spi/st,stm32-spi.yaml
sound/st,stm32-i2s.yaml
st,stm32-spdifrx.yaml
sound/st,stm32-sai.yam
serial/st,stm32-uart.yaml
rng/st,stm32-rng.yaml
regulator/st,stm32-vrefbuf.yaml
mfd/st,stm32-timers.yaml
.....

The only yaml given description is :

access-controllers:
  minItems: 1
  maxItems: 2

Thanks
Patrice

