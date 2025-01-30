Return-Path: <linux-spi+bounces-6583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC80A229EA
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D36F3A2962
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90CE1B3950;
	Thu, 30 Jan 2025 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="neJk4e8F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EB1459F7;
	Thu, 30 Jan 2025 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227420; cv=none; b=R2WVtGLxUFPoW0gQHnlOpIPWO2gv2R2tSMWQaWA0t3+Tb6k8kDP3hVa+3zCAdmMP8LMUfzQ9IrvkGAa7mkS/KsqrbFo/zw2a1BJmjKjVCkStBULGBWlFLLNnTDM7QoyWN5V7a9CvpB5gCcMKru/yIBkNdBI2l6Gdp2lvyPXLDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227420; c=relaxed/simple;
	bh=M9roGvymV6bq03xrzax4BNoeWMtIDfHpmWenQYdxemw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=siEaLOWIubpJ/yJLUhESs6iFjpu6x2Bv5sd8qNSOiYvgoEzZ6Y/2EIAfi0TPPdJCkt2tnBIyT5eXyNxsMZgN0rvxlRM0llsy16jJbCkFsxZQqb+Vdh42u0GIazL6sL1+WM7fW8e8RlYqmjb4ki3BVnvLs1aTpjPaOZQPIGvyyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=neJk4e8F; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U6QBVh019628;
	Thu, 30 Jan 2025 09:56:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	EzcyMoLNvtKxLHNHjczcsoR+W7/fDhlAI5vFIoUcVSo=; b=neJk4e8FK6tYF+Ad
	nZVB/yh2Q9xUNrnMqDr28yaYonhcm2KYV5ISdfmAPhrU5gUgXXC+mkyKX8EvL5p0
	VjoBCwUOMAZ/ADTEU4HQ8h0kjcoQIc20QMXQC8UHCDWS0ke+BwJPJIWIjJJqjVb0
	hLLeQHAjwXdSO6aM5VBtdtMzleOR+xEe3E5lFYmTvvd/HaBawDQVoPpogg1jAE9d
	CHOxGdkj1ez2zHWpaP9ZYadaswP6UOoewFMxiEb6RdPV/HTWXsgq04ZxG2z53a9G
	NkWLMN1hiGpE5HZO9BGasSqec8BEozdO/YRrSSkvnaptqRyOjiIQ7vXQUsl6OsGZ
	YZSByQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44f26x6w4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:56:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9EE874002D;
	Thu, 30 Jan 2025 09:54:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BEB2C27EEB1;
	Thu, 30 Jan 2025 09:51:29 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 09:51:28 +0100
Message-ID: <98f9bdfa-5107-412a-8b9b-41f8135954fc@foss.st.com>
Date: Thu, 30 Jan 2025 09:51:28 +0100
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
 definitions=2025-01-30_05,2025-01-29_01,2024-11-22_01



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
ok

> 
>>       Memory region to be used for memory-map read access.
> 
> I don't think that's a good explanation, sorry. Why's a memory-region
> required for read access?

The OCTOSPI interface support 3 functional modes: 
  _ indirect
  _ automatic polling status
  _ memory-mapped

256MB are reserved in the CPU memory map for the 2 OCTOSPI instance.
This area is used when OCTOSPI1 and/or OCTOSPI2 operate in memory-mapped
mode. In this mode, read access are performed from the memory device using
the direct mapping.

Thanks
Patrice

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

