Return-Path: <linux-spi+bounces-6849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3549A3961C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D27A3BA7F9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B722FE0A;
	Tue, 18 Feb 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ibz22OBm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37822E3EA;
	Tue, 18 Feb 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868159; cv=none; b=gA2JfeJH0X93k/pIuN03hBjHwm1L4FUE++JcOaLL26Y+qOCC30fqRd+lc5KXhN5+/XIwA5mWAuuNgnmzDQOwsmJluIaV0fzILj1f9FCdolNWKewpdv9HQiI5rwOatULy3QndvLk/dkQvFlSmX5f+hvESlDnffttA9SGhqWqCm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868159; c=relaxed/simple;
	bh=8C1EJRRVd22x/9mu6auZ+la3X+ou4V+ayeu8ZUNVuEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r2oCJAhixio4RLJBn1NdS3bBxAJqm8zTGdRiW3IZvowy2R7Rt8fKe5rkOoC79B/t0KEPhy7Vgh/Cv8dSt8Eeo5JMtztP9uNXbELrkbfcNDszXA+hL0jhcTMTI7VtvXWdIiXD2GYmgQZw+qEIypDwaZekim/Jdf4bFYQ7TGtJRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ibz22OBm; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I8ERDf013018;
	Tue, 18 Feb 2025 09:41:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	m+3/1tyVa1Qn4CQ2/7kBF87oG9qDd6zKjpbib5cEEhE=; b=Ibz22OBmZ62P3bGD
	d9E/xAJHN3cUuLw6amZCi2WWuYjp70NmQobfeWx0UUlMYN3KpuVUe6u1hoM0qaAE
	9SgLRIBxnVmEiUgdp6UrOsHvA052TQEQhIpkR0zY8M5GdkP8d9XsV+9eShy8yn1A
	bvBdCsUoezygapIyhY5BxOckyFjaN3SNjKdR9BetHfFXiw27JnOYrA7PRk3WY679
	yvfANtotS6xK1YwFXOr8PmEW0JQND75PIzBoaw4a3jEoF9i+OTyPWheb5zcHx3Y7
	wKdFKVykqQ5c6ym7Np1M1SbG1oDYAH7U2leUlpW8tiESvHiI8NHicGX4uF6iRXte
	nK+SRg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44tkttu4rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 09:41:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D30AE40044;
	Tue, 18 Feb 2025 09:40:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7E7C2F80C7;
	Tue, 18 Feb 2025 09:39:32 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 09:39:32 +0100
Message-ID: <ad738b22-7d09-4734-a546-759c23222925@foss.st.com>
Date: Tue, 18 Feb 2025 09:39:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: spi: Add STM32 OSPI controller
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann
	<arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
 <20250210131826.220318-2-patrice.chotard@foss.st.com>
 <67fe157ce8ca3c3c4e08451da52f7c94f73439b2.camel@pengutronix.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <67fe157ce8ca3c3c4e08451da52f7c94f73439b2.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01



On 2/17/25 10:17, Philipp Zabel wrote:
> On Mo, 2025-02-10 at 14:18 +0100, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Add device tree bindings for the STM32 OSPI controller.
>>
>> Main features of the Octo-SPI controller :
>>   - support sNOR / sNAND / HyperRAM™ and HyperFlash™ devices.
>>   - Three functional modes: indirect, automatic-status polling,
>>     memory-mapped.
>>   - Up to 4 Gbytes of external memory can be addressed in indirect
>>     mode (per physical port and per CS), and up to 256 Mbytes in
>>     memory-mapped mode (combined for both physical ports and per CS).
>>   - Single-, dual-, quad-, and octal-SPI communication.
>>   - Dual-quad communication.
>>   - Single data rate (SDR) and double transfer rate (DTR).
>>   - Maximum target frequency is 133 MHz for SDR and 133 MHz for DTR.
>>   - Data strobe support.
>>   - DMA channel for indirect mode.
>>   - Double CS mapping that allows two external flash devices to be
>>     addressed with a single OCTOSPI controller mapped on a single
>>     OCTOSPI port.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  .../bindings/spi/st,stm32mp25-ospi.yaml       | 105 ++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
>> new file mode 100644
>> index 000000000000..5f276f27dc4c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
>> @@ -0,0 +1,105 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/st,stm32mp25-ospi.yaml#
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
>> +    maxItems: 1
>> +
>> +  memory-region:
>> +    description:
>> +      Memory region to be used for memory-map read access.
>> +      In memory-mapped mode, read access are performed from the memory
>> +      device using the direct mapping.
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    items:
>> +      - description: phandle to OSPI block reset
>> +      - description: phandle to delay block reset
> 
> Are you positive that these will only ever have to be reset together?
> Otherwise I'd add a reset-names property just in case.

Yes i confirm that these both reset are reset together.

Thanks
Patrice

> 
> regards
> Philipp

