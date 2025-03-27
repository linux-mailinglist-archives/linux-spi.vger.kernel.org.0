Return-Path: <linux-spi+bounces-7339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA902A72D79
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DEF188F5DC
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F2120E32A;
	Thu, 27 Mar 2025 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qq4ixooq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1EA20E327;
	Thu, 27 Mar 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070297; cv=none; b=gFR/u2/Q1b597j+gqNibjTwhcVBXgRMB/pLHNNoOYBd+rn4z45MwkC3KFl90Oi1wwhL/Hm1p+OMlZxEN4f3AYIsqMsCrbKIbzbjQW6MZTvJqSEVcqzYwvEoEyHjdwrlHo+1abmKp9KtLZlrAPoMQk5zm/jg2XHuP8UxWN8aL8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070297; c=relaxed/simple;
	bh=DVsxgEbsS305z/iQfasSuEkx0kuBk4XtdduDSR4LT/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L9KWu1u4FjHikFMWhgwcXgllx3qB9ayC9mSe1d22tPWg3H8aRotTd0aTwh6j3ckvrU32iOnRazZcuTP1QAU1uHE4jtlqZvDpNYzwMjsOeuBT2ACnAuilGeCjJyiiogXCELiGevINrJIcwG4JUInUmkv5rG4dHyHX3C54pGpvb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qq4ixooq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jIE2005506;
	Thu, 27 Mar 2025 10:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O+2bieIXA8WeKEzcm0BpS3Lzfvr897zZoGaEkY0UtgI=; b=Qq4ixooqoJeUlOaS
	1RQFlSjoAmUkUE06+XirVT2mVYb8JxIfRPEygG/XP2jDkR1eVD1A0FOn+C/LNKl5
	+/Ye3bj/xFUKD60cldodIpHfSa4ADN2O41lpz0nPZ19unapuAQ+P1BEU9xJaLO6J
	pi0yl/U0p8rhT9XgM3KJCQX+osxz7G5XJsBTCaw1S/Np3UXwaBqo9RgEAz6VBfIX
	0fcvMi7C4nXEEbdpeYs8m0kT9kBDmjk0QbAtcAYLwr7ncBnpupaz80Q49Ua5pK4V
	hMRUWaxjoIs0oQe3Xxz9lZ6zS7m1Xqtkqb9a1P6HPMk+sPtgyCpzoTYAWf+ZbkWb
	8Mqs5w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktenexa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:11:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52RAAiGG025177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 10:10:44 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 03:10:42 -0700
Message-ID: <1734ca66-bba7-4318-96af-8658874af907@quicinc.com>
Date: Thu, 27 Mar 2025 15:40:39 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
 <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
 <fbad733f-d034-4d63-ab82-ed867f0ed5d4@linaro.org>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <fbad733f-d034-4d63-ab82-ed867f0ed5d4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e52454 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=xXiMeSlKV-wmB5rnH6MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xAMnC-99BwejgnZk1wl3n23n6zvpgkcg
X-Proofpoint-ORIG-GUID: xAMnC-99BwejgnZk1wl3n23n6zvpgkcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270069

Thanks Tudor !

On 3/26/2025 8:18 PM, Tudor Ambarus wrote:
> 
> 
> On 3/26/25 2:25 PM, Mukesh Kumar Savaliya wrote:
>> Hi Mark, thanks for your comment.
>>
>> On 3/26/2025 6:34 PM, Mark Brown wrote:
>>> On Wed, Mar 26, 2025 at 02:09:54PM +0530, Mukesh Kumar Savaliya wrote:
>>>
>>>> This change introduces a new field `dtr_mode` in the `spi_transfer`
>>>> structure. The `dtr_mode` field allows protocol drivers to indicate if
>>>> Double Transfer Rate (DTR) mode is supported for a given transfer. When
>>>> `dtr_mode` is set to true, the SPI controller will use DTR mode
>>>> otherwise, it will default to single transfer mode.
>>>
>>>> The QSPI controller driver uses this flag and configures single or
>>>> double
>>>> transfer rate using the controller register.
>>>
>>> We should have a flag in the controller indicating if it supports this,
>>> and code in the core which returns an error if a driver attempts to use
>>> it when the controller doesn't support it.
>> Have added below in spi.h which can be set by client and controller
>> driver should be using it to decide mode.
>>
>> + bool        dtr_mode;
>>
>> since default it's false, should continue with SDR.
>> I believe for QSPI, it supports SDR or DDR, but it's not applicable to
>> standard SPI right ? So not sure in which case we should return an error ?
>>
> 
> Please check how spimem is dealing with DTR, same ideas shall be applied
> for spi transfers.
> 
Yes, i just got it. Have kept my proposal aligning to this. Looks 
similar to spi_mem_controller_is_capable(). Please review reply to Mark 
if that is matching expectations OR have more suggestion/corrections.
> Cheers,
> ta


