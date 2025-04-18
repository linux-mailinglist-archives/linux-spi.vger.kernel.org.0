Return-Path: <linux-spi+bounces-7675-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B3A937C1
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776AE1780EF
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9A26A0FD;
	Fri, 18 Apr 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hxGQwJ/O"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11342C1A2;
	Fri, 18 Apr 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744982242; cv=none; b=O7wpavSVxjcnvSSjKN7Lm0W4h/UIgysy94cFkbHJKLu3TVFh5n7yfh86NlVbVRf5Rc0JbEj4DmGEHnH717abyAVjfrDAgCl20M3f+nrWFDkQFeNVncFEe0QNjfM6toWnLPjqcq/3FBQdi4j/3kUSSu/95ZamPlZ3wQSHCxSiO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744982242; c=relaxed/simple;
	bh=n0utsyMghaOj6Z5F0gjl4M6Pk3uj1acevUv1zi/cYLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AK5boVzV4ntfDoINslaKQbtqx3ypIHvFzFEooXEtUHI3Q2W7lB1DfTZ6a0FDjQrE/WEaQsCbEE4aBuzIOXleEGyKqDXxWJ9Ef1jZTRH3Gj3dyoVp5XEXxHA09y3TzBtrvnr+cMgUdnuK7jMFArJyjyU/DkTj5qxvMQJmMDM6d3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hxGQwJ/O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2PFO0008123;
	Fri, 18 Apr 2025 13:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m9D8vUJMZiZvxPh0ECvIefj34JxtipJ5vMqGMNe+u5M=; b=hxGQwJ/OzAb6bLah
	B2I3KmvKr0VZJ7UgkgSUUZSUl8pZGHV3CYMSg4607KJwoPZrJJhcqrvYyQpb7yLs
	T16DbgUzpZWfhXcs04YnnqUV3dTaHE/Kkx9h8ajLQKdI8tMpjm0oQST0tU9lvPgS
	jDjE7CzAtMwTYx/hC2GU+vVxGqOxd0H36v//9I+hDvNKplgVgrMzmCRucPF3t/sQ
	UQb8/QIjC+psph5HqaPBCaRfG8LidOQMyozolw9HSJKBkmz+s3akA1HdrX6W0ERP
	dBOCmVad6kp1eX9FTuExNBtETAuXUneMML3xljJUB0ppY6gTDKV7D0c+8ECXD8eq
	OQXDAQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk9vfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 13:17:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IDH4xO010429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 13:17:04 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Apr
 2025 06:17:01 -0700
Message-ID: <71dd2d77-9d20-4c8f-9735-a9256635a271@quicinc.com>
Date: Fri, 18 Apr 2025 18:46:58 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32-ospi: Fix an error handling path in
 stm32_ospi_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: <alexandre.torgue@foss.st.com>, <broonie@kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <mcoquelin.stm32@gmail.com>, <patrice.chotard@foss.st.com>
References: <2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr>
 <72f49447-5c99-4028-90cf-3f5cc11e8b53@quicinc.com>
 <e148faa8-6ee0-45bd-8cd8-37ea42a1de2a@wanadoo.fr>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <e148faa8-6ee0-45bd-8cd8-37ea42a1de2a@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=680250d1 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=8IxrUdWRUM5EU-Lu3hgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7uc3GSTUJv9cVxAOP8QcAl1G97B--19L
X-Proofpoint-ORIG-GUID: 7uc3GSTUJv9cVxAOP8QcAl1G97B--19L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180098



On 4/18/2025 5:50 PM, Christophe JAILLET wrote:
> Le 18/04/2025 à 14:09, Mukesh Kumar Savaliya a écrit :
>>
>>
>> On 4/18/2025 4:57 PM, Christophe JAILLET wrote:
>> [...]
>>> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
>>> index 668022098b1e..9ec9823409cc 100644
>>> --- a/drivers/spi/spi-stm32-ospi.c
>>> +++ b/drivers/spi/spi-stm32-ospi.c
>>> @@ -960,6 +960,10 @@ static int stm32_ospi_probe(struct 
>>> platform_device *pdev)
>>>   err_pm_enable:
>>>       pm_runtime_force_suspend(ospi->dev);
>>>       mutex_destroy(&ospi->lock);
>>> +    if (ospi->dma_chtx)
>>> +        dma_release_channel(ospi->dma_chtx);
>> why can't you move to devm_dma_request_chan ? No need to cleanup.
> 
> Unless I miss something obvious, this function does not exist.
> 
> CJ
> 
Yes, You are right. Seems the patch is yet not merged.

https://lore.kernel.org/all/20250115160244.1102881-1-csokas.bence@prolan.hu/T/ 

dma: Add devm_dma_request_chan()

Can ignore it for now.
>>> +    if (ospi->dma_chrx)
>>> +        dma_release_channel(ospi->dma_chrx);
>>>       return ret;
>>>   }
>>
>>
>>
> 


