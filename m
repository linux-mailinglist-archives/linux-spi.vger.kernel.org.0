Return-Path: <linux-spi+bounces-6850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8484A397FB
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 11:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F871632D0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C522FF47;
	Tue, 18 Feb 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="D0H00fvI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063222E418;
	Tue, 18 Feb 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872945; cv=none; b=TSpQx/dzNtjKydIaZ2WYw5jXlnSN+IoChZn7u0vKM1rX9D8rhedMmPJGh1hUlZGsk3/V4taC66hlCyHFjFWLWyMXYZmJyeDbPdZZdqYfLtjarDFLQs8VB/dqs4AH9i+EgwCuhHlc/GCn5w/hj+lnc2P+SvuUBofEIig9amGzMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872945; c=relaxed/simple;
	bh=KcYf2uC2/W7sQaR55x+wPX1K7PZeTePGGmDYjov+33Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z5drQaIGx1sf2GZaEUu6SLxF9Gc4ryJYZUy/V4yH+k+/QPaWEUMCLFiZgrLkVpzNxrUTWNvrVQ0C0oX41TkIk6suhxQduWCRbRS7qYkk1kRUCugVOsy3U12jWqlaSDNpVCxyJ4Vi37h9Jw9n6cuCUm1O1BsZU/8tSPrx342UFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=D0H00fvI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I94PEF032546;
	Tue, 18 Feb 2025 11:01:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	z3wEKkLu5QCqpmQjBX/R1HGC8LIFTH2BqVnQP1sjqLY=; b=D0H00fvIP3QIekZK
	zmcNw2hxSvyJ63GJgCKeaFJHyAkaymoqU8byOStBxukUNjVDkmDV6rHdgE6H271Z
	qOYDVxpJ7B2kc2WK7BbmCCxGQEdCUGHEr6p2Vq0qwIkgQraZmVCXqNaX1vIFqMxV
	YalAPaALoY9wXaCaRWZcCB3kFHqRpCgmqzOIAwF6+GL+A+rYJM6ugbOA0i9RgCzw
	kRuD3z3pczuM0itP5OQrUR6Y/yBE2dLx39R+KsyzG6nZSU2oB2C4shacURfM0B2d
	0FwQ7TgI83joO3CEEoUD0KjvVEbOhKtUtTbJzGI7S9XsY+0bJgIu0zF1xJkfg0iX
	wAO3qw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44tm1ub3ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:01:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D07F540046;
	Tue, 18 Feb 2025 11:00:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E8D73AF671;
	Tue, 18 Feb 2025 10:58:23 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 10:58:22 +0100
Message-ID: <5dde0e21-eddb-4bbf-a246-a2760792eb59@foss.st.com>
Date: Tue, 18 Feb 2025 10:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] dt-bindings: memory-controllers: Add STM32 Octo
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
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
 <20250210131826.220318-4-patrice.chotard@foss.st.com>
 <20250213-adorable-conscious-pogona-4114cf@krzk-bin>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250213-adorable-conscious-pogona-4114cf@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01



On 2/13/25 09:00, Krzysztof Kozlowski wrote:
> On Mon, Feb 10, 2025 at 02:18:21PM +0100, patrice.chotard@foss.st.com wrote:
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
>>  .../memory-controllers/st,stm32mp25-omm.yaml  | 201 ++++++++++++++++++
>>  1 file changed, 201 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
>> new file mode 100644
>> index 000000000000..c897e6bf490d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
>> @@ -0,0 +1,201 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32mp25-omm.yaml#
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
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  reg:
>> +    items:
>> +      - description: OMM registers
>> +      - description: OMM memory map area
>> +
>> +  reg-names:
>> +    items:
>> +      - const: regs
>> +      - const: memory_map
>> +
>> +  memory-region:
>> +    description: |
>> +      Memory region shared between the 2 OCTOSPI instance.
>> +      One or two phandle to a node describing a memory mapped region
>> +      depending of child number.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  memory-region-names:
>> +    description: |
>> +      OCTOSPI instance's name to which memory region is associated
>> +    items:
>> +      enum: [ospi1, ospi2]
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  access-controllers:
>> +    maxItems: 1
>> +
>> +  st,syscfg-amcr:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      The Address Mapping Control Register (AMCR) is used to split the 256MB
>> +      memory map area shared between the 2 OSPI instance. The Octo Memory
>> +      Manager sets the AMCR depending of the memory-region configuration.
>> +      The memory split bitmask description is:
>> +        - 000: OCTOSPI1 (256 Mbytes), OCTOSPI2 unmapped
>> +        - 001: OCTOSPI1 (192 Mbytes), OCTOSPI2 (64 Mbytes)
>> +        - 010: OCTOSPI1 (128 Mbytes), OCTOSPI2 (128 Mbytes)
>> +        - 011: OCTOSPI1 (64 Mbytes), OCTOSPI2 (192 Mbytes)
>> +        - 1xx: OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
>> +    items:
>> +      - description: phandle to syscfg
>> +      - description: register offset within syscfg
>> +      - description: register bitmask for memory split
>> +
>> +  st,omm-req2ack-ns:
>> +    description: |
>> +      In multiplexed mode (MUXEN = 1), this field defines the time in
>> +      nanoseconds between two transactions.
> 
> default: ?

Yes, i will add the default value

> 
>> +
>> +  st,omm-cssel-ovr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Configure the chip select selector override for the 2 OCTOSPIs.
>> +      - 0: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS1
>> +      - 1: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS1
>> +      - 2: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS2
>> +      - 3: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS2
>> +    minimum: 0
>> +    maximum: 3
> 
> default: ?

ditto

> 
>> +
>> +  st,omm-mux:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
>> +      - 0: direct mode, default
> 
> Don't repeat constraints in free form text.
> 
ok

>> +      - 1: mux OCTOSPI1 and OCTOSPI2 to port 1
>> +      - 2: swapped mode
>> +      - 3: mux OCTOSPI1 and OCTOSPI2 to port 2
>> +    minimum: 0
>> +    maximum: 3
> 
> default: ?

i will add the default value as well

Thanks 
Patrice

> 
> None of them are required, so usually we expect defaults.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

