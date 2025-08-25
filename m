Return-Path: <linux-spi+bounces-9655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A188B33988
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244FF1890827
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE03D2737FC;
	Mon, 25 Aug 2025 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wj2VKK1O"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BBA29CB3A;
	Mon, 25 Aug 2025 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110980; cv=none; b=EVCX5pEH1XcfZbuNG+2I7ofTGv7Vh/j/VLLNQhu34/hDK4tsbfFJ/FA3M4nEQWpRK3cvZMNOz/d8010/u8hDdYtWrkoyxYYMqRE/fPb+NBtgSNrOL9nAQXX8yXfZottrDVywRbHLIeJnVV4FjGgz2qQSg0dhTXhBEVr++I02Cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110980; c=relaxed/simple;
	bh=N8AlyFG48ldLOPuMuuo84h3wS2kvWS/OzqBxXhkwRVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EgJ5QfDRVChagc6n6oiD/qgc7Anrmjn0XC+O6GAEsnfV4QT+esoFdzoiXB2bJKPqjIqX1gKSstVxaO58xGDDioBt1QyvhXMbbZvwdoSfghnEWjpfFMR0Go87hKwvuq9A2Ae5fmV3V8j6jlHeYqgyIO2pTpqLfSpVtQnJ/xpnOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wj2VKK1O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8LOXC012253;
	Mon, 25 Aug 2025 08:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/kRFyxmzjEr5HfvUocTdiG44MWpyBTf/8L5FSDtj1w=; b=Wj2VKK1ORQgs7w7Y
	whdSMscooN9hBM4YHSKXFpDncZ5ptT2pNE5XHXzKd1bPOyBRFtqI1ycxuKQToccM
	TnFN2NqW+J0bvldmRH+oV1NvcDl75nBP/IHJxBehE+90usl6MrkEBzjCUlep/VRA
	UOJZF21hUZzyaSWFDyD5sbjIj7ywH/vLpo0QzdgiJkdGBYcklwaP2PVo5fhauFFE
	gKzr92VpEA+CCIQ7maJFlRtUBVQU3Z4JjAoypCNxFNnJfQwjzO/M/V+ELViU3rjU
	BlfoMBXlDvP0JOW8i19gzlmzgBmTeAd5w2WMS29qWsgIWL8JVfFUW+6L7qfy4Mq2
	azsJ8Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfceem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 08:36:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57P8a4Xi021720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 08:36:04 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 25 Aug
 2025 01:36:01 -0700
Message-ID: <4ae827e8-646a-4070-b06e-23bcd261ffcd@quicinc.com>
Date: Mon, 25 Aug 2025 16:35:58 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: <harald.mommer@oss.qualcomm.com>, <quic_msavaliy@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>,
        <quic_ztu@quicinc.com>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <aKXaI0SAAMaHMZM9@smile.fi.intel.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <aKXaI0SAAMaHMZM9@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXyNlrBp6yjebm
 IzR9ktbFM27L3Sfz0nOHhMdaYTQDdGS67TKIlTtdxsR/w4HOSHmU8ewXRMMpcleJAhkH0R5Qui7
 JDxfyiV1hwXUrsOmJsjWsY8zYPoDxpErsc3doHHRaFJ2BhXwJA5gSDyjyGYhOSreYtRW2Sio6NR
 Rtoe83UZjHfcP0JhqNBQqTYITtKmdYQziz6Mk4nUxQNLoC2Qctq/G9Z6qZFNJZVZ+qyY9rvuuLe
 p2Ncy5ToQYrRDAGJ2zGYOm62EwACPFWH4PnoFUwXiC7nXn7axzdmOo2sf7MoIpWJfkNrU9tqhru
 0fewU4HLMdsTqGYEi8UiYq9YMZZuIfRknOQagNOaYOUIbPL7te7AkI1N5wn0kAgvFC4/g9EYpcI
 OCKD3cnC
X-Proofpoint-GUID: YO7A1MnfLxAiMXeUnCx0GjysGtB39PKR
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ac2075 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=I6AEysREMBWARHdSJAkA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: YO7A1MnfLxAiMXeUnCx0GjysGtB39PKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/20/2025 10:22 PM, Andy Shevchenko wrote:
> On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
>> Add virtio-spi.h header for virtio SPI.
> 
> ...
> 
>> +/**
> 
> This is kernel-doc comment...
> 
>> + * struct virtio_spi_config - All config fields are read-only for the
>> + * Virtio SPI driver
> 
>> + */
> 
> ...
> 
>> +/*
>> + * @chip_select_id: chipselect index the SPI transfer used.
>> + *
> 
> But this one (besides having tons of unneeded blank lines) is not. Why is this
> inconsistency?
> 
>> + */
> 

Thank you for pointing out the inconsistency. I will update the comment 
to follow the kernel-doc format and remove the unnecessary blank lines.
This change will be reflected in the next patch version.

> ...
> 
>> +struct spi_transfer_result {
>> +#define VIRTIO_SPI_TRANS_OK	0
>> +#define VIRTIO_SPI_PARAM_ERR	1
>> +#define VIRTIO_SPI_TRANS_ERR	2
>> +	__u8 result;
>> +};
> 
> And this data type has no doc at all...
> 
Okay, will add definition for spi_tranafer_result.


