Return-Path: <linux-spi+bounces-6587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94382A22B15
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EBF3A5BF2
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0651B87C9;
	Thu, 30 Jan 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="iQmcYJuX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965411B85D6;
	Thu, 30 Jan 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231163; cv=none; b=Dhu57PcCrFW+L2e7dW3gE3SyfUEUwxmTREUGa96mfBWL8Slm192SiH3fjHXBU/2Wim0HakZCEzTO00DNBtQ7nDhxJjkhEoTOhfBwmRzU//vubj3ax/WV+hymE8F6j4r+qc9br0lVObILAQCXlIbqw7x5PEsKNHTCmVqRBAeOEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231163; c=relaxed/simple;
	bh=SOzxqNj0iiBRjOA4XLQF4MiMn47NGAnB8stx7mbLGBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EyUq3vNssZvnDMSQgRxNZY0AiFHCPnSZ9z8depdBlUe0nYbGWC3knTXe6X65PUcyRquo8UmeCtAyLK7uab1pgpADVyZSdPulPmrVN7+fwFJv5szmTnpd7vcuKxHMxDDTdfMyqcDiJvmnSjHtd3VWkszBE8scLhX1Nznkd2p/inI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=iQmcYJuX; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9tuFE006037;
	Thu, 30 Jan 2025 10:58:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Sqonxp9aXTn3c2hsrTLPYeaBVLsx7H/jkmUhYlzq4ac=; b=iQmcYJuXQcC9F7mV
	72ZONSqhy/flHR0oif4Mkm/ITMki91Csklg3bGJNu/RI/iHHSvfc1dTrtfR/ksGm
	FjrQgTATxVd4KfiifJ3BTnds9W0Tyjs2CH5qNUPEqWAnQsdyMuyML+E1Toa0ai4w
	I3p0ioH/Bo3RSDYsxT+n02qUkQJBlSdEFUDEurnLplVmW4nwIRbYweq7GIx7YTz5
	mPew0rg7UZ1q2N9SsNEurvL/sV8jxd0p67ivOwrSaybYfXRuQZ42VtwQH9siMVcQ
	SC2ZhijLos4wQcn7Xq8eRON16pjxxJ5e0EOCNkrWIhCig45ZYXaUglhW7ZHYcIkD
	5Nt8Eg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44fy471jdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:58:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A74564002D;
	Thu, 30 Jan 2025 10:57:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F9F72EC5C3;
	Thu, 30 Jan 2025 10:48:08 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 10:48:07 +0100
Message-ID: <bbdf57b8-60e7-4f73-b597-edbbee641fcb@foss.st.com>
Date: Thu, 30 Jan 2025 10:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add STM32 OSPI controller
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
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
 <20250129-annoying-flawless-porpoise-47daed@krzk-bin>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250129-annoying-flawless-porpoise-47daed@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01



On 1/29/25 08:40, Krzysztof Kozlowski wrote:
> On Tue, Jan 28, 2025 at 06:02:27PM +0000, Conor Dooley wrote:
>>> +  st,syscfg-dlyb:
>>> +    description: phandle to syscon block
>>> +      Use to set the OSPI delay block within syscon to
>>> +      tune the phase of the RX sampling clock (or DQS) in order
>>> +      to sample the data in their valid window and to
>>> +      tune the phase of the TX launch clock in order to meet setup
>>> +      and hold constraints of TX signals versus the memory clock.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>
>> Why do you need a phandle here? I assume looking up by compatible ain't
>> possible because you have multiple controllers on the SoC? Also, I don't
>> think your copy-paste "phandle to" stuff here is accurate:
>>       st,syscfg-dlyb = <&syscfg 0x1000>;
>> There's an offset here that you don't mention in your description.
> 
> This needs double items: and listing them with description, instead of
> free form text.

ok, i will remove most of ths text description and update as following :

  st,syscfg-dlyb:
    description: configure OCTOSPI delay block.
    $ref: /schemas/types.yaml#/definitions/phandle-array
    items:
      - description: phandle to syscfg
      - description: register offset within syscfg

Thanks
Patrice
> 
> Best regards,
> Krzysztof
> 

