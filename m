Return-Path: <linux-spi+bounces-7758-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328CBA9C0DF
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 10:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2D1BA648F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546B1F4180;
	Fri, 25 Apr 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XjLh26n0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4B17A2EE;
	Fri, 25 Apr 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569486; cv=none; b=pf4KvANT4fNgMsq1TmEQ/7/BjkmoiroGR55T0lnjZhhDaeMSPOwn9JOSWJNvS0Q9WxgkOZax1uDphtCeKjpBIJzqm8AqF4aiklwimQ8CabiGTOh26vQtbs/fZFtC5gP8eNLd0DGFyh3cKWqiCKGgZtJTmzp+P5sXQIdLiikuVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569486; c=relaxed/simple;
	bh=y3FIw1yf6CxTKgXqqzjUJyHjFCNWKaMz/A+rwrSBnOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OhCTMFZKIlH7GKkZ2v9UTPHp6v5aCuiLK56K7jVyEpFaqDx6jwWi2W5W5340phFHJG/NSuh85kfJPCuzbEKqBhlWEYAYMHUjkBEPHKGsjRMEnyzMRC9lOAQx0TD2FoP75w/6M/IVxbFq3CTzBJoVCrVEzS5KD7f/E0Z7XE9GgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XjLh26n0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P17bIW021884;
	Fri, 25 Apr 2025 08:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3z2u93IMM61dt3LtP8YnjyiJqyMMoKMVOZ4AM0j4dbU=; b=XjLh26n0HV+KnGSN
	ruz34bjeXpT18T6xOh5Zehv0gtm5WeF869WTfyykPU/CSXnbApozE3zuCdyn9T3P
	GTQTBodsri3Pc6aLGnP/cvyFw7UKcrdSxIlAb3dvCqrnQmc5IsolKWm3qKJnzX8x
	QbVOr4zgH2qHuH+tBekXIgRyv3YkZRkNMyXncYcVZUsm7rHosSjhEIp9SNSwqAkC
	v6a6AkB99L6a/oTgtnWCCf2NWp5L6h4VVa47+oEK+1izt4eo0G/lst2h5rTvLkVa
	T6dxS0HyL1V6XZMLtc59BeXMHibJ0Zms/7CeeDjIYxgRrR8PFPrclwxutw677ac1
	i+WTzg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5g8py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 08:24:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53P8OVnk011102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 08:24:31 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 01:24:28 -0700
Message-ID: <ea936063-2a24-406d-a7c6-f832a72d5da5@quicinc.com>
Date: Fri, 25 Apr 2025 16:24:25 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/3] virtio-spi: Add virtio-spi.h
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.oasis-open.org>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-3-quic_haixcui@quicinc.com>
 <f6f087f9-83c9-452e-9a0f-f8743b8c71c2@quicinc.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <f6f087f9-83c9-452e-9a0f-f8743b8c71c2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA2MCBTYWx0ZWRfX1Vzj0zbWraq/ DvR/rdrHLv8QkqMDhulZVV+KeLDbBaYYM+dM7Lf71cpJUZDtK9vtcCKKNmgzepRcPoI83h/kK+m UZvT38CdlGU/KJuWnI4gOd8EpjN8AkLHbvbuk7Dr5VlziIbyxy3F3Cx5ojkC6bqD7VzNphKwZfu
 t0MIEjvQVxrJjRcTLeZClA9CV86BwR+LjtucAEx8Y5oJNZgmUZOJv5hMxNH1I5irCbf1ta0nSty fjPs8jY9MYlNTH8hhkt6whV83CaYcvJ7JjK+Qvlzfzklpoim8hf04Lwd1rkOKEiqMWnhv9fAcGz vwnLrQPJymO5iFTmqKtBl4XoYlNDfuaGKGq6ByEdBFSJoAczdXjh3A5eutq5bAHQ1elF9EEv6Dq
 X7zP7iCrz4XryAhNY4pvp007GSZ75VpiPASsQttLds86g/hH5jOzAVIPkVkGlkkP7bm1BWnr
X-Proofpoint-GUID: 9Kia3sZ35YcgA_zUhuVkaDoQj3SuIOb9
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=680b46c0 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=mMmorrnVjBH16NRd3KEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9Kia3sZ35YcgA_zUhuVkaDoQj3SuIOb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=849
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250060

Hi Mukesh,


>> + * @mode_func_supported: indicates the following features are 
>> supported or not:
> mode_func_supported[b'6-0] : something like this may help to know size 
> of this variable.

I noticed the suggestion to use [b'6-0] to indicate the actual size of 
the mode_func_supported variable. However I haven't seen notation like
[b'6-0] used in Linux kernel.

And I think the definition of its bitfield below could clearly indicates 
that 7 bits of mode_func_supported are used. Could we keep the current 
description as it is?

>> + *   bit 0-1: CPHA feature
>> + *     0b00: invalid, should support as least one CPHA setting
>> + *     0b01: supports CPHA=0 only
>> + *     0b10: supports CPHA=1 only
>> + *     0b11: supports CPHA=0 and CPHA=1.
>> + *   bit 2-3: CPOL feature
>> + *     0b00: invalid, should support as least one CPOL setting
>> + *     0b01: supports CPOL=0 only
>> + *     0b10: supports CPOL=1 only
>> + *     0b11: supports CPOL=0 and CPOL=1.
>> + *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
>> + *     supported, chipselect active low should always be supported.
> You mean to say "chipselect active low is default supported" ?
> 
> Just thinking instead of keeping always supported, can we mentione as 
> default supported ?

Yes, will update as "chipselect active low is supported by default".

> 
>> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
>> + *     MSB first should always be supported.
> MSB first is default supported ?

Yes.

>> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for 
>> supported,
>> + *     normal mode should always be supported.
> we can reverse the write up for all "always be supported"
> 
> bit 6: if not specified, normal mode is supported by default. if set 1, 
> specifies loopback mode.

Sure, your statement is indeed clearer and more accurate, I will update 
in next patch.


>> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL (1 << 0)
>> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD (1 << 1)
>> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL (1 << 2)
> Can use BIT(x) ?
Will update the code accordingly:
#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL    BIT(0)
#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD    BIT(1)


Really Appreciate.

Best Regards
Haixu Cui


