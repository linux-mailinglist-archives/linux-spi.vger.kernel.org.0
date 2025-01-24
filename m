Return-Path: <linux-spi+bounces-6473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE6A1B9C2
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5681516D436
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2914D430;
	Fri, 24 Jan 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f1wVHLp8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F78157485;
	Fri, 24 Jan 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734151; cv=none; b=qnBTKsuj1YLIHmZSD5+WU35yuXKQxe1LnF0Pz7oCJ7Ze1K4qrjid5E3gOdvhai+AYHVPGmAD1GisGdFa5iEQdpFNKzfYpJ/Tu2dTvrR/znPMnRBmurg4xhJJmS4qORhndOV1KLXa/QqW/ozV1If1TMwlzJdLtewdTc+RxqpVhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734151; c=relaxed/simple;
	bh=GJ+IrJMpepIUs0ylPLxUpeAwiilnO65BRtpk+vxXIx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JztIwp1X2zvi0ZFJq61RAVkic2djzGfnQi7gs3UWoWUVPuvpE1sB8Cgqs2UFTBa6wx2H30einCA+PSir44sqsPY/esqLtHYQB2yBaiReBNpBaQfNiVeEMTCmyNy4ivVivhH895fhSm5pWIwIABuug1Djpn2NTnWZuvKo8Ue/uN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f1wVHLp8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ODxYEi020373;
	Fri, 24 Jan 2025 16:55:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uaG9qa70VJUtRqCzfAg/ikd241yTHwjVfiONCnLuAOQ=; b=f1wVHLp8U2S3Es8D
	A2T+wuU/bjuhSr9oPF0AO8l+LCmGauZB+2fSIWqQSIz5SO3b7YG0HVwP38CXVp6m
	b1/45E3b06hFLuSpXH2Xm5qIVnWre2NUcIRckFt/Vw5QlIfo1RvoycFaL+7sX+jM
	4yPEJdv58N+v++kFWQ/DHPzCvi+M6UjhKK2HOUFMMBGFIukrLHnqsqLDrUOXokEg
	8bSk+x1rlO1Wc9PWmmgkZ8LUCTfjIogJOElZMesxQk8rE58UY0DSK1tfnSCX1gHT
	QT3RhR9XZQ4zvEkyRj78bRZ/6rnPccMn2qXGZpU/RSR9kYeI7PW/Ax0zEV4Kvx82
	NGn/3A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44cc7x8dns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:55:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B0F640046;
	Fri, 24 Jan 2025 16:54:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4AB9428DA13;
	Fri, 24 Jan 2025 16:53:06 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 24 Jan
 2025 16:53:05 +0100
Message-ID: <2d712420-c8ed-4bf9-83ec-348f71aa1ce9@foss.st.com>
Date: Fri, 24 Jan 2025 16:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: spi: Add STM32 OSPI controller
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250122141037.953934-1-patrice.chotard@foss.st.com>
 <20250122141037.953934-2-patrice.chotard@foss.st.com>
 <ea4ca423-c75d-468c-b5b2-673cd58e42c9@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ea4ca423-c75d-468c-b5b2-673cd58e42c9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01



On 1/22/25 16:18, Krzysztof Kozlowski wrote:
> On 22/01/2025 15:10, patrice.chotard@foss.st.com wrote:
>> ---
>>  .../bindings/spi/st,stm32-ospi.yaml           | 109 ++++++++++++++++++
>>  1 file changed, 109 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-ospi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-ospi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-ospi.yaml
>> new file mode 100644
>> index 000000000000..bf16252f85fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-ospi.yaml
> 
> 
> Use compatible as filename.

Ok

> 
>> @@ -0,0 +1,109 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/st,stm32-ospi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32 Octal Serial Peripheral Interface (OSPI)
>> +
>> +maintainers:
>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>> +
>> +allOf:
>> +  - $ref: spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-ospi
>> +
>> +  reg:
>> +    description: registers
> 
> That's not helping. Please take a look how other bindings do it.
> maxItems instead or you need to list the items with meaningful description.

ok, will use maxItems

> 
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
> 
> Drop *cells.

ok

>> +
>> +  memory-region:
>> +    maxItems: 1
>> +    description: Phandle to a node describing memory-map region to be used
> 
> Drop description, redundant. Say something useful - the purpose - or
> just maxItems if purpose is obvious.

ok, i will add 
      - description: phandle to OSPI block reset
      - description: phandle to delay block reset

> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 2
> 
> You need to list and describe the items.

ok

> 
>> +
>> +  dmas:
>> +    items:
>> +      - description: tx DMA channel
>> +      - description: rx DMA channel
> 
> maxItems: 2 is enough, because names define what these are

ok

> 
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +
>> +  st,syscfg-dlyb:
>> +    description: |
>> +      Use to set the OSPI delay block within SYSCFG to:
> 
> Phandles to what? Describe also the destination device.
> 
>> +        Tune the phase of the RX sampling clock (or DQS) in order
> 
> Unneeded indentation.
> 
>> +        to sample the data in their valid window.
>> +        Tune the phase of the TX launch clock in order to meet setup
>> +        and hold constraints of TX signals versus the memory clock.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      minItems: 2
>> +      maxItems: 2
> 
> Your example has only one item, so probably you wanted one more items
> with description. Now you miss one of matrix constraints.

My fault, only one item is required.

> 
> git grep -C 8 phandle-array
> (e.g. some sram or syscon examples)
> 
> 
> 
>> +
>> +  access-controllers:
>> +    minItems: 1
>> +    maxItems: 2
> 
> List the items.

i will update as following:
  access-controllers:
    - description: phandle to the rifsc device to check access right.
    - description: phandle to the rcc device for secure clock control
    minItems: 1
    maxItems: 2

> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
> 
> Drop cells

ok

> 
>> +  - clocks
>> +  - interrupts
>> +  - st,syscfg-dlyb
>> +
>> +unevaluatedProperties: false
>> +
> 
> 
> 
> Best regards,
> Krzysztof

