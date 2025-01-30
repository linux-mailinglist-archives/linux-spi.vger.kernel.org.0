Return-Path: <linux-spi+bounces-6592-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5BFA22D0C
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 13:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6BD166D9C
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F81C305A;
	Thu, 30 Jan 2025 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Xf4anVNW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258D1E0B82;
	Thu, 30 Jan 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738241122; cv=none; b=Eud3pe85NdM/4CVmw1LEZlIHv/OoxZQqCJc5VOU8tUu/khAwwRn3HHbs9rGgEo2FjOB7RTkW9WCsxRbjBEfXtnt4mYWBKCcmPDuAjqmPQ1rLi/Fnm3+k3XO0RXPqhooiyWIVrVDp44wEQek1IysjJ85JjWTfxRusgr76uffAteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738241122; c=relaxed/simple;
	bh=DZ7OhWamVOAQLcGbQsGGQ8bXE0p2z2sPoRkv7jPGuw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q5yTpI4JWOJ5qVrX5dLq6ThpUO/QlGOpCgSrRu2z5uHWzdVd1MV7GoURLoS0/dFe7RfFmDggMfKQTaIeEFBo5+EHXEVE2t38U+ypuC0otgkGulLH+0Dd0J3bFZVpYyUbNp6AIZ20SvW9wYq9JY8rrcNfvJNZE3tV4gLZckgf0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Xf4anVNW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCfHYh030056;
	Thu, 30 Jan 2025 13:44:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9hREfD9h0pyFa6Qh0S2jAB9bMfbE7Dv/kgHfimMyy6w=; b=Xf4anVNWbLdKR6tL
	p0daiYsMRYArJabcArI+84aYSLasTmT8sRaVYO0J5KO5tXyNVkdM1qe50TBwCZyv
	x/f/yVEsRhG/ZGxuSJUkLJIzX4S+88rohm7990nR3uRLt0QBHnaLOuiEdG0BA6h/
	3I8jWYmch5qKFAH1Hpi2okIh8hucv6T4VQGe5pf6OH7qxpQRkyaDiMO50nSpvRDg
	A8/IXObLAfeCr8XIcICq2AvqXamZo0q28jfTtZsL9ZvzuNSkJeV1JUkDyZI5jdjZ
	URQ+g8ZcwN7BHxazwd6gtUoQxOIyQICqxyk+A/0mSlpxlkuTcQg+LopviFb2d/hm
	c/4+Kw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44fy472c6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 13:44:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7DD514002D;
	Thu, 30 Jan 2025 13:43:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A4743B1A42;
	Thu, 30 Jan 2025 13:39:13 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 13:39:12 +0100
Message-ID: <1098622d-d9a6-428c-9bbe-1f0de5f3d113@foss.st.com>
Date: Thu, 30 Jan 2025 13:39:11 +0100
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
 <e3d01bce-a7d4-4690-8a2f-3bbb1ee5ccb7@foss.st.com>
 <20250129-feminize-spotlight-2cee53f8b463@spud>
 <5892e452-96e7-4945-a2dd-2e713d85d751@foss.st.com>
 <7323e5ae-21b7-43cc-aed2-e23cd528842e@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <7323e5ae-21b7-43cc-aed2-e23cd528842e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01



On 1/30/25 13:26, Krzysztof Kozlowski wrote:
> On 30/01/2025 11:28, Patrice CHOTARD wrote:
>> For example:
>>
>>  access-controllers:
>>     description: phandle to the rifsc device to check access right
>>       and in some cases, an additional phandle to the rcc device for
>>       secure clock control.
>>     items:
>>       - description: phandle to bus controller
>>       - description: phandle to clock controller
>>     minItems: 1
>>     maxItems: 2
>>
>>
>> make dt_binding_check DT_SCHEMA_FILES=st,stm32mp25-ospi.yaml
>>
>> Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml: properties:access-controllers: {'description': 'phandle to the rifsc device to check access right and in some cases, an additional phandle to the rcc device for secure clock control.', 'items': [{'description': 'phandle to bus controller'}, {'description': 'phandle to clock controller'}], 'minItems': 1, 'maxItems': 2} should not be valid under {'required': ['maxItems']}
>> 	hint: "maxItems" is not needed with an "items" list
>> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
>>   DTC [C] Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.example.dtb
>>
>> How can i indicate that at least one items is mandatory, the second one is optional and in the same
>> time describing the both items as required without getting the above error ? 
> 
> maxItems is redundant.

ok, it solves the issue

Thanks
Patrice


> 
> Best regards,
> Krzysztof

