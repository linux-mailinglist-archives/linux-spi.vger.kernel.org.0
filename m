Return-Path: <linux-spi+bounces-7610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF889A8B23F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986615A10E6
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 07:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4A227E8C;
	Wed, 16 Apr 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KsXJmrz8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF4221F13;
	Wed, 16 Apr 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788873; cv=none; b=RHxnhwPhVgyJUOWx3j4sjR/ku5o/w/xxDayFVORrUZreaYrisZfbyA3Sh9oBaq8lWKXbz4KQatF6c0OKeX9433Ry299hSeTf/6dtoY7MTIzkHtuMrNVfeU8LfQ/dT+jPVdrzsH6oQlKRhS9kW1bA7d5R5BC18Y2vE59offk4vaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788873; c=relaxed/simple;
	bh=IIr/CJfIHxtPuwbupHvi4tuIt1QmK/DNk5uo9RXwJtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ojq0SxB7zB4wDxruTv3TiRDkMMssES4vzcHXuRAs1+4HU29Iqk1L9Y2PK0byfFil3SRLyaf4P6Db6KLjpI+VHHZ2O55D2pewzA13BALmGNl0y3r55J09WYAx0V0bmtdx9cixVV62CmXN9HXCo7X/UWD0a02mfe2jVTUYNBVWWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KsXJmrz8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G7Jtcv003492;
	Wed, 16 Apr 2025 07:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GUcdvfwZrnNZuV2T27/n0P6rv0AUJGdNVs2JM7mtqa0=; b=KsXJmrz8NW0iFw6l
	lFrg/RVIzvNpX4vYe/ZOkbT6WiLPDUm1hKVi3dybF+wCMK+U4Rix5eJ9fXtN36Bc
	biSKHo89pewJseDp0xtcgpm5l6iReJKRllSm9Wejh5ctfkzJetdZj+tTG2PCqHfC
	OH3FMrsgrFQ2/9vXUEKcWgZqudPN7E73TrLbcyT3019u11VC0sZuIgnyhqJoeJDk
	iSYb3Ey6dGmqeTL+Ag87ARD55nVWv+SYM//m7oC3jEz9Lfb57Mwsl9qhubAUzpd/
	eyg5j3Dmbzar0iexe6SWdqzfg3bkkIo2syWVQZLG8ShnxwWziBFc7vpqJ6JcKqJJ
	kBkHYQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wjq3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 07:34:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53G7YOwD030646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 07:34:24 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Apr
 2025 00:34:22 -0700
Message-ID: <c806bd59-9c16-4a19-83a6-c3b395a77925@quicinc.com>
Date: Wed, 16 Apr 2025 13:04:19 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: Add spi_bpw_to_bytes() helper and use it
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>
References: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
 <20250416062013.1826421-2-andriy.shevchenko@linux.intel.com>
 <db36c119-c6f6-42e9-b8a0-f09e9e5a2585@quicinc.com>
 <Z_9XrXweruMZ1LvE@smile.fi.intel.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <Z_9XrXweruMZ1LvE@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67ff5d81 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=kZJ_y26kylx110OhOT8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AGYd2QMrjDtgv4pV23m3nsUG3a2AFxro
X-Proofpoint-GUID: AGYd2QMrjDtgv4pV23m3nsUG3a2AFxro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160060

Thanks Andy !

On 4/16/2025 12:39 PM, Andy Shevchenko wrote:
> On Wed, Apr 16, 2025 at 12:33:24PM +0530, Mukesh Kumar Savaliya wrote:
>> On 4/16/2025 11:46 AM, Andy Shevchenko wrote:
> 
> Thanks for the prompt review, my answers below.
> 
> ...
> 
>>> +/**
>>> + * spi_bpw_to_bytes - Covert bits per word to bytes
>>> + * @bpw: Bits per word
>>> + *
>>> + * This function converts the given @bpw to bytes. The result is always
>>> + * power-of-two (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
>> Would it be good to say in 4 byte aligned /Multiples ?
> 
> It's not correct. The said wording describes the current behaviour.
> 
Sure.
>>> + * Returns:
>>> + * Bytes for the given @bpw.
>> Returns: Bytes for the given @bpw.
>> Good to keep in one line.
> 
> Aligned with the style of the other function in the same header, so I prefer to
> leave the style the same.
> 
Yes, i see.
>>> + */> +static inline u32 spi_bpw_to_bytes(u32 bpw)
>> u8 bpw ?
> 
> Nope. See below why.
> 
>> struct spi_device {
>> u8 bits_per_word;
>> }
> 
>> so arg should be u8.
> 
> It's aligned with the above bpw related function.
> Also note, that this helper might be moved to the global header at some point
> as some other subsystems may utilise it, so I don't want to limit this to u8.
> 
Okay, if plan to move to global header then it's fine.





