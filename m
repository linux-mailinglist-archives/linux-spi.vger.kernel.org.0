Return-Path: <linux-spi+bounces-958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAC584579D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA31D1F231AE
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357D5CDE0;
	Thu,  1 Feb 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="csYSDLT4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC89160869
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790266; cv=none; b=QtD3Y+ah2DYEtylVQ/LQ7Cn0VPRORHCtB27DzCz+DfcfrSTkQKfYf0dtthPQxNhvPSuWzAsnzIUarNc08A9nnALNa0Lj3B2X+9V3xbW4kYLoc1uQPzi3oV56/euL8rMmmTShzgW9/kUpOaWKEo3EMVkgMGeZbMYgmBCHMOsyCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790266; c=relaxed/simple;
	bh=aKy710s1cSgaX0y8tu+RkSJjiC2NUYrN1kDsjLmWPiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CMSNm6k6B17XbvQmS1QWXIiq8y9/vpNTw15S+/M/wHrokKZqY5Fc4/OQDwNBMm/A5WrCD3GvcRNxeCCTElYCtxBhMEF3AUbhRvFMR2t/tspFxcJnN4iW955yKPOTkwNdHz+TtQg7RP2eJ70GtEgEJjhrganLAWuFyLbOc+e4zPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=csYSDLT4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411CKrSA017922;
	Thu, 1 Feb 2024 13:23:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=F/rOSrW+a/ZqA8DHiCyanTm3mjkwrDiOTsDGyObWwR8=; b=cs
	YSDLT4teAvFD9g8dTcKheRo27UhDezpPdfOHpUaaE/dljojm7IjkEwt//FO9HBzf
	PEZf3GFmo+bCyj8ipM7gwgyLA6UmLnWYg68haOsmvqWPOrpL6N0u4ivqvD9rEl9e
	F/zcDMGBvohGNjQQROWDf3YK8DiLSGnmYhw9CLDDLkaR2VL/rj7XQuYdwbW3BXNg
	VaFl3Olb+ykJOJddCfGSc1YXoD32hVizMN6xZ8+bAkwWi0dHzSf0mF4TQ1qsZ2m/
	H4X0xCkESdOKDvQ1RhqZ5s5uMb9s9YemQfDOwDtUtAL7qdbek2refYX1L3Gx3Goc
	bPrUNLxaps87WttwZEEg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vvr4m589r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 13:23:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 35A62100053;
	Thu,  1 Feb 2024 13:23:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B970264D76;
	Thu,  1 Feb 2024 13:23:44 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 1 Feb
 2024 13:23:43 +0100
Message-ID: <cfe84e34-1dc0-459a-a347-e559718b4d75@foss.st.com>
Date: Thu, 1 Feb 2024 13:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mtd: hyperbus: Add support for Infineon S26Hx-T
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Raghavendra, Vignesh"
	<vigneshr@ti.com>, <tkuw584924@gmail.com>,
        <linux-mtd@lists.infradead.org>, <sergei.shtylyov@cogentembedded.com>,
        <geert+renesas@glider.be>, Mark Brown
	<broonie@kernel.org>,
        Christophe KERELLO <christophe.kerello@foss.st.com>
CC: <pratyush@kernel.org>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <d-gole@ti.com>, <Bacem.Daassi@infineon.com>,
        Takahiro
 Kuwano <Takahiro.Kuwano@infineon.com>,
        Boris Brezillon
	<boris.brezillon@collabora.com>,
        "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
References: <cover.1680663252.git.Takahiro.Kuwano@infineon.com>
 <d94273b2-9516-2b80-308f-9fd1fdd2b4d5@linaro.org>
 <158830c6-d492-4967-a543-c0f5f8428d8b@linaro.org>
 <2bcf6646-b7ce-48c9-8a9b-0634c3fb40e9@ti.com>
 <508196d4-a533-47c9-bf6e-5718364c8d54@linaro.org>
 <c75f33ce-d7a8-46db-aeab-f4406f3d9cf9@foss.st.com>
 <09b1e193-8a87-4f29-a1d5-8dfd370b03a1@linaro.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <09b1e193-8a87-4f29-a1d5-8dfd370b03a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_01,2024-01-31_01,2023-05-22_02



On 2/1/24 13:02, Tudor Ambarus wrote:
> 
> 
> On 2/1/24 10:46, Patrice CHOTARD wrote:
>>
>>
>> On 1/22/24 09:13, Tudor Ambarus wrote:
>>>
>>>
>>> On 1/22/24 06:25, Raghavendra, Vignesh wrote:
>>>>
>>>>
>>>> On 1/22/2024 11:41 AM, Tudor Ambarus wrote:
>>>>> + Sergei, Geert, Mark & linux-spi
>>>>>
>>>>> Hi, Sergei,
>>>>>
>>>>> On 23.05.2023 07:22, Tudor Ambarus wrote:
>>>>>> Hi, Takahiro, Vignesh,
>>>>>>
>>>>>>
>>>>>> On 07.04.2023 09:11, tkuw584924@gmail.com wrote:
>>>>>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>>>>
>>>>>>> This sereis adds support for Infineon S26HL-T/S26HS-T flash family.
>>>>>>> https://www.infineon.com/dgdl/Infineon-S26HS01GTGABHM020-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7f2a768a017f52f2f5182c91
>>>>>>>
>>>>>>> This family supports two interface modes, SPI mode and Hyperbus mode. The mode
>>>>>>> can be switched at rutime. The default mode is selected by ordering option
>>>>>>> and non-volatile user configuration. In hyperbus mode, the device is compatible
>>>>>>> with S26KL-S/S26KS-S hyperflash family that supports hyperbus only so one of
>>>>>>> use cases of S26Hx-T is replacement of (or migration from) S26Kx-S. This patch
>>>>>>> set focuses on particular usage that the device is pre-configured as hyperbus
>>>>>>> mode for compatibility with S26Kx-S.
>>>>>>
>>>>>> I'm questioning the overall hyperbus software architecture, not your
>>>>>> patches per se. IMO hyperbus framework should have been written on top
>>>>>> of SPIMEM and the controllers be placed in drivers/spi/. So I'd first
>>>>>> address the SPIMEM adoption before adding/accepting new support. Would
>>>>>> love to hear more from Vignesh.
>>>>>>
>>>>>
>>>>> RPC is the only multi IO SPI controller that's upstreamed and capable of
>>>>> dealing with hyperflashes, but there are others which are not upstreamed
>>>>> yet (microchip).
>>>>>
>>>>> Struct ``struct rpcif_op`` [1] duplicates the contents of ``struct
>>>>> spi_mem_op`` [2] which could have been avoided if hyperflash driver was
>>>>> extended with SPI MEM support. This way the RPC hyperbus driver, which
>>>>> is an SPI controller, could have been moved to drivers/spi.
>>>>>
>>>>> Sergei, do you remember why we haven't used SPI MEM for hyberbus since
>>>>> the beginning? Was it something that we aimed for in a future patch set?
>>>>>
>>>>> Thanks,
>>>>> ta
>>>>>
>>>>> [1]
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/memory/renesas-rpc-if.h?h=mtd/for-6.8#n22
>>>>>
>>>>> [2]
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/linux/spi/spi-mem.h?h=mtd/for-6.8#n99
>>>>>
>>>>
>>>> The initial hyperflash predates opening up of HyperBus protocol and
>>>> inclusion of it in xSPI spec. First gen Flashes followed CFI specification
>>>> and hence made sense to make use of cfi_cmdset_0002.c
>>>>
>>>> We did have a discussion on extending spi_mem to support xSPI profile 
>>>> 2.0 during the RPC_IF [3] [4].
>>>>
>>>> Overall, both Controllers and Flashes have moved away from CFI parallel 
>>>> flash protocol over to xSPI / SPI NOR flash protocol (profile 2.0), so I 
>>>> agree with Tudor's assessment that we need to move towards spi_mem in 
>>>> longer term. So
>>>>
>>>
>>> Good, thanks Vignesh! I'll study a bit more and let you know about the
>>> progress on this topic.
>>
>> Hi All
> 
> Hi,
> 
>>
>> At STMicroelectronics we got an OSPI block which is supporting both OSPI and HyperBus protocol
>> similarly to the mentioned RPC-IF.
>>
>> This means that we intend to split our implementation in 3 drivers as RPC-IF:
>>   _ backend driver including common source code to OSPI and HyperBus
>>   _ OSPI frontend driver
>>   _ HyperBus frontend driver
>>
>> Following this discussion thread, we are wondering if it will be the right direction to 
>> choose in order to propose this implementation to MTD mailing list.
> 
> I think the right direction would be to have hyperflash on top of
> SPIMEM, and the SPI controller under drivers/spi.


To be more precise, when you say "would be to have", you mean you will NAK 
an implementation in 3 drivers as RPC-IF ?

Patrice

>>
>> Have you an idea about time scale regarding the HyperBus migration over spi-mem ?
>>
> 
> No, sorry. It's at best effort from my side. Happy to review proposals
> though.
> 
>> Thanks
>> Patrice
>>
>>
>>>
>>> Cheers,
>>> ta
>>>
>>>> a) Extend spi_mem_op to support xSPI profile 2.0 transaction template
>>>> b) HyperBus layer can then either be a adapter from CFI to spi_mem for CFI
>>>> compliant devices. And  be subsumed completely within SPI NOR for SFDP
>>>> compliant devices.
>>>> c) Move the existing controllers over to new framework.
>>>>
>>>>
>>>> [3] https://lore.kernel.org/all/b8224f46-fc2e-de35-0a90-a2a86cacb489@ti.com/
>>>> [4] https://lore.kernel.org/all/20200220084927.7a411d40@collabora.com/
>>>>
>>>
>>> ______________________________________________________
>>> Linux MTD discussion mailing list
>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/

