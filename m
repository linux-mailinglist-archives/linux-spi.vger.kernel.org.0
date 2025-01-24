Return-Path: <linux-spi+bounces-6474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410FA1B9C6
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 16:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A143A612D
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532C15C120;
	Fri, 24 Jan 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3MDF16DF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CCC15853A;
	Fri, 24 Jan 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734151; cv=none; b=tmUH9uNGw5d2qMZO6JXhaF+/6ESiXTUmcYZYwMHhvvhLWVjVy+UbSABZdf19aIrdhWnS37ki4bgNXsSXDkU0K1LyZYDmZE63URTRDVpaaraWrBmoww51HWdvqZjG/Cx5OAxgRG4gm8dfH3R9ug7vvmBVGLINw5lxyJBcG0GlGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734151; c=relaxed/simple;
	bh=RqNFHHH0h3PTO8sZI6C57MdG3HTzwHNty4rY+W+JueE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uHoU+244KtZFDndPaDZ0GzLa587xQpEMZ98MGE2bq0l1vTx2NC17sjLvnU+xs1ts3HS7+iXvYCugRm/6kKSfD/+Q+8hlAb0E4qpm4TQcIkgUu05yM8OaYXyLOY46CF1xhuEHbtoQ8iyhNM396r05+eed4Vr1MXaKl2lrHOrkg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3MDF16DF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OEAmks028213;
	Fri, 24 Jan 2025 16:55:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rBdaNnlhvokSdl3jq5CVwCBTYYuQM85Gy29IkTWa4Ys=; b=3MDF16DFhk1bHL9X
	BfycQ9Ug8D5r+OJhyic+oq5FEC0RybAj/i1lTt8ehfRN+Qo+1RN6QESq7ZqXPNik
	08aF79/kwDIvd3Z0oY4Ad4gjgD+uX48ssZxZIQYsQNuaeWmn2WPCCIFgpMwLA94F
	73UxJOA2JKDJzbRj7NHaAOcV9C8U3z0ofqwYcv/ag14lJ26E5NETRqcLdAuV7mU6
	qNrSaLjZrWsHxB8/vPDJkoXOyAKkifF/dxV1WekHhKtlwKcqL+tG3mVpIm3ejczC
	JQblqR7xD23wsKEH6ZAI4CUAFJ/dWTCAX/Gfb1mwv6zZ+f6/+TEyYFIXHZJiGfmE
	Yc6ntg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44c7v8skt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:55:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9709B40048;
	Fri, 24 Jan 2025 16:54:09 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4555928DEC9;
	Fri, 24 Jan 2025 16:53:26 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 24 Jan
 2025 16:53:25 +0100
Message-ID: <9d6c7a30-e5ef-49c6-9158-22d1eb1518a3@foss.st.com>
Date: Fri, 24 Jan 2025 16:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: misc: Add STM32 Octo Memory Manager
 controller
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
 <20250122141037.953934-4-patrice.chotard@foss.st.com>
 <920a7917-e7ba-4380-8401-2de318e60b74@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <920a7917-e7ba-4380-8401-2de318e60b74@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01


On 1/22/25 16:22, Krzysztof Kozlowski wrote:
> On 22/01/2025 15:10, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Add bindings for STM32 Octo Memory Manager (OMM) controller.
>>
>> OMM manages:
>>   - the muxing between 2 OSPI busses and 2 output ports.
>>     There are 4 possible muxing configurations:
>>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>>         output is on port 2
>>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>>         OSPI2 output is on port 1
>>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>>   - the split of the memory area shared between the 2 OSPI instances.
>>   - chip select selection override.
>>   - the time between 2 transactions in multiplexed mode.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  .../bindings/misc/st,stm32-omm.yaml           | 194 ++++++++++++++++++
>>  1 file changed, 194 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/misc/st,stm32-omm.yaml
> 
> 
> All my other comments apply.
> 
> Also:
> This cannot be misc. Depending what this is, either dedicated subsystem
> like memory or soc.
> 

Ok i will migrate it to memory

> 
>>
>> diff --git a/Documentation/devicetree/bindings/misc/st,stm32-omm.yaml b/Documentation/devicetree/bindings/misc/st,stm32-omm.yaml
>> new file mode 100644
>> index 000000000000..ef8f5d2c526c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/st,stm32-omm.yaml
> 
> 
>> @@ -0,0 +1,194 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/st,stm32-omm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STM32 Octo Memory Manager (OMM)
>> +
>> +maintainers:
>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>> +
>> +description: |
>> +  The STM32 Octo Memory Manager is a low-level interface that enables an
>> +  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
>> +  function map) and multiplex of single/dual/quad/octal SPI interfaces over
>> +  the same bus. It Supports up to:
>> +    - Two single/dual/quad/octal SPI interfaces
>> +    - Two ports for pin assignment
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-omm
>> +
>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges:
>> +    description: |
>> +      Reflects the memory layout with four integer values per OSPI instance.
>> +      Format:
>> +      <chip-select> 0 <registers base address> <size>
>> +
>> +  reg:
>> +    items:
>> +      - description: registers
> 
> Well, why here is entirely different syntax? Anyway, useless
> description. Say something useful

ok

> 
>> +      - description: memory mapping
> 
> This is a bit better but still confusing. Memory mapping of what?
> Virtual memory? This is vague to me.

It's a memory map area, i will update to :

  reg:
    items:
      - description: OMM registers
      - description: OMM memory map area

> 
>> +
>> +  reg-names:
>> +    items:
>> +      - const: omm
>> +      - const: omm_mm
> 
> Not useful names. Drop prefixes and then you end up with empty first
> entry :/


Will replace by 
  reg-names:
    items:
      - const: regs
      - const: memory_map
> 
>> +
>> +  memory-region:
>> +    description: Phandle to a node describing memory-map region to be used.
> 
> Constraints.
> 
>> +
>> +  memory-region-names:
>> +    minItems: 1
> 
> Nope, you just said one phandle?

I made an error, it's not mandatory and can be up to 2 phandle.
will update as following: 

  memory-region:
    description: Phandle to a node describing memory-map region to be used.
    maxItems: 2



> 
>> +    items:
>> +      - const: mm_ospi1
>> +      - const: mm_ospi2
> 
> Drop redundant parts. If name is just 1 or 2, then just drop xxx-names

I will remove the memory-regions-names properties (a driver update is needed accordingly)

> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  access-controllers:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  st,syscfg-amcr:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      The Address Mapping Control Register (AMCR) is used to split the 256MB
>> +      memory map area shared between the 2 OSPI instance. The Octo Memory
>> +      Manager sets the AMCR depending of the memory-region configuration.
>> +      Format is phandle to syscfg / register offset within syscfg / memory split
>> +      bitmask.
>> +      The memory split bitmask description is:
>> +        - 000: OCTOSPI1 (256 Mbytes), OCTOSPI2 unmapped
>> +        - 001: OCTOSPI1 (192 Mbytes), OCTOSPI2 (64 Mbytes)
>> +        - 010: OCTOSPI1 (128 Mbytes), OCTOSPI2 (128 Mbytes)
>> +        - 011: OCTOSPI1 (64 Mbytes), OCTOSPI2 (192 Mbytes)
>> +        - 1xx: OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
>> +    items:
>> +      minItems: 3
>> +      maxItems: 3
>> +
>> +  st,omm-req2ack-ns:
>> +    description: |
>> +      In multiplexed mode (MUXEN = 1), this field defines the time in
>> +      nanoseconds between two transactions.
>> +
>> +  st,omm-cssel-ovr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Configure the chip select selector override for the 2 OCTOSPIs.
>> +      The 2 bits mask muxing description is:
>> +        -bit 0: Chip select selector override setting for OCTOSPI1
>> +          0x0: the chip select signal from OCTOSPI1 is sent to NCS1
>> +          0x1: the chip select signal from OCTOSPI1 is sent to NCS2
>> +        -bit 1: Chip select selector override setting for OCTOSPI2
>> +          0x0: the chip select signal from OCTOSPI2 is sent to NCS1
>> +          0x1: the chip select signal from OCTOSPI2 is sent to NCS2
>> +
>> +  st,omm-mux:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
>> +      The muxing 2 bits mask description is:
>> +        - 0x0: direct mode, default
>> +        - 0x1: mux OCTOSPI1 and OCTOSPI2 to port 1
>> +        - 0x2: swapped mode
>> +        - 0x3: mux OCTOSPI1 and OCTOSPI2 to port 2
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^spi@[a-f0-9]+$":
>> +    type: object
>> +    $ref: "/schemas/spi/st,stm32-ospi.yaml#"
> 
> Drop quotes.
> 
> Look at your other $ref and keep things consistent.

ok

Thanks
Patrice

> 
> Best regards,
> Krzysztof

