Return-Path: <linux-spi+bounces-950-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ECE8455BF
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1671328437B
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620373A1C3;
	Thu,  1 Feb 2024 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Md/UJugu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1A15CD54
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784437; cv=none; b=C1KL8NghfCXImyEjnpHyA1fVGK5ZkBhYpr2DtT0NjGpAWjBYCoiFGl3jW1VT0KcuI6bDGKhX5xH7ybDIVndHy4woTGm+LhD7tcDqem++rcO9Fe2xsMZnGKheL9BtjlMPnxeCIGbOdQjbEi+/fGIXg9ltqyCxd9wLOE8Ont5Cv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784437; c=relaxed/simple;
	bh=JKEfYmTZhogZpjb1yt2pSzrzPrpedRZiiA8Nn8W0hRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oxMp3Zmd0p2qN+j7d4IbqpLvSuRbNJePj+QNA/TzNxz0ypxooK7WvAcNKMZ064HHTJY3WS3UQtbFazM4lJNz/fd0qBqp76nYlob+VchzPwvxrG8Kp/RVS6KRWe9nhKFIT0w9laT8KUoM7gOk0CltyfrYoufLTk4qwPydPYZCjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Md/UJugu; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4117ln3P012513;
	Thu, 1 Feb 2024 11:46:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=yR3T7Qd/gHHnMMnYrKUioHGTtJWAAP6ehWRW92w/wQo=; b=Md
	/UJuguH4oCMt6H0/usJ/cEF97+nKtbE5oNcTdTO0j2nhpxQ+QkUPKXnXpoXuNKM9
	DtSogsztj6IhzmKHYQMF8AMHM1JiZ+sdORGxtAphJ8fUlyYUpE8k0f19mLQtcs5C
	L8vuUWPDXqfkAuMlNg2BwS0WPtlaVaNFiM5C89r7Ie7iiGC2GOaWiXVrmeOYbdxU
	OA5NOvqztKbwEQPxiF3xhHFldBJQGVzWLmK3n97voxuURw15vYoAbqmySjDHwfOJ
	CQakhXRdEpRSqttf4fs0ipPxB2cBj/oeC57gg+U8Gs3dJYjrFuweDYsuTkvrRyIf
	TsnLBbQH9yTPNCYS0xsw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vwdnp219r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 11:46:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E62DE10005D;
	Thu,  1 Feb 2024 11:46:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D344523C6B9;
	Thu,  1 Feb 2024 11:46:26 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 1 Feb
 2024 11:46:25 +0100
Message-ID: <c75f33ce-d7a8-46db-aeab-f4406f3d9cf9@foss.st.com>
Date: Thu, 1 Feb 2024 11:46:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mtd: hyperbus: Add support for Infineon S26Hx-T
Content-Language: en-US
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
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <508196d4-a533-47c9-bf6e-5718364c8d54@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02



On 1/22/24 09:13, Tudor Ambarus wrote:
> 
> 
> On 1/22/24 06:25, Raghavendra, Vignesh wrote:
>>
>>
>> On 1/22/2024 11:41 AM, Tudor Ambarus wrote:
>>> + Sergei, Geert, Mark & linux-spi
>>>
>>> Hi, Sergei,
>>>
>>> On 23.05.2023 07:22, Tudor Ambarus wrote:
>>>> Hi, Takahiro, Vignesh,
>>>>
>>>>
>>>> On 07.04.2023 09:11, tkuw584924@gmail.com wrote:
>>>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>>
>>>>> This sereis adds support for Infineon S26HL-T/S26HS-T flash family.
>>>>> https://www.infineon.com/dgdl/Infineon-S26HS01GTGABHM020-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7f2a768a017f52f2f5182c91
>>>>>
>>>>> This family supports two interface modes, SPI mode and Hyperbus mode. The mode
>>>>> can be switched at rutime. The default mode is selected by ordering option
>>>>> and non-volatile user configuration. In hyperbus mode, the device is compatible
>>>>> with S26KL-S/S26KS-S hyperflash family that supports hyperbus only so one of
>>>>> use cases of S26Hx-T is replacement of (or migration from) S26Kx-S. This patch
>>>>> set focuses on particular usage that the device is pre-configured as hyperbus
>>>>> mode for compatibility with S26Kx-S.
>>>>
>>>> I'm questioning the overall hyperbus software architecture, not your
>>>> patches per se. IMO hyperbus framework should have been written on top
>>>> of SPIMEM and the controllers be placed in drivers/spi/. So I'd first
>>>> address the SPIMEM adoption before adding/accepting new support. Would
>>>> love to hear more from Vignesh.
>>>>
>>>
>>> RPC is the only multi IO SPI controller that's upstreamed and capable of
>>> dealing with hyperflashes, but there are others which are not upstreamed
>>> yet (microchip).
>>>
>>> Struct ``struct rpcif_op`` [1] duplicates the contents of ``struct
>>> spi_mem_op`` [2] which could have been avoided if hyperflash driver was
>>> extended with SPI MEM support. This way the RPC hyperbus driver, which
>>> is an SPI controller, could have been moved to drivers/spi.
>>>
>>> Sergei, do you remember why we haven't used SPI MEM for hyberbus since
>>> the beginning? Was it something that we aimed for in a future patch set?
>>>
>>> Thanks,
>>> ta
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/memory/renesas-rpc-if.h?h=mtd/for-6.8#n22
>>>
>>> [2]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/linux/spi/spi-mem.h?h=mtd/for-6.8#n99
>>>
>>
>> The initial hyperflash predates opening up of HyperBus protocol and
>> inclusion of it in xSPI spec. First gen Flashes followed CFI specification
>> and hence made sense to make use of cfi_cmdset_0002.c
>>
>> We did have a discussion on extending spi_mem to support xSPI profile 
>> 2.0 during the RPC_IF [3] [4].
>>
>> Overall, both Controllers and Flashes have moved away from CFI parallel 
>> flash protocol over to xSPI / SPI NOR flash protocol (profile 2.0), so I 
>> agree with Tudor's assessment that we need to move towards spi_mem in 
>> longer term. So
>>
> 
> Good, thanks Vignesh! I'll study a bit more and let you know about the
> progress on this topic.

Hi All

At STMicroelectronics we got an OSPI block which is supporting both OSPI and HyperBus protocol
similarly to the mentioned RPC-IF.

This means that we intend to split our implementation in 3 drivers as RPC-IF:
  _ backend driver including common source code to OSPI and HyperBus
  _ OSPI frontend driver
  _ HyperBus frontend driver

Following this discussion thread, we are wondering if it will be the right direction to 
choose in order to propose this implementation to MTD mailing list.

Have you an idea about time scale regarding the HyperBus migration over spi-mem ?

Thanks
Patrice


> 
> Cheers,
> ta
> 
>> a) Extend spi_mem_op to support xSPI profile 2.0 transaction template
>> b) HyperBus layer can then either be a adapter from CFI to spi_mem for CFI
>> compliant devices. And  be subsumed completely within SPI NOR for SFDP
>> compliant devices.
>> c) Move the existing controllers over to new framework.
>>
>>
>> [3] https://lore.kernel.org/all/b8224f46-fc2e-de35-0a90-a2a86cacb489@ti.com/
>> [4] https://lore.kernel.org/all/20200220084927.7a411d40@collabora.com/
>>
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

