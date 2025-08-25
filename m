Return-Path: <linux-spi+bounces-9657-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CBDB33A4A
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4869A1898622
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC392C1584;
	Mon, 25 Aug 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eZjpN/BL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99D2C0F60;
	Mon, 25 Aug 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113189; cv=none; b=sx1r9qcCqYIgPlbjA65WVu+RUZeDoLAOWNlguLExhr8C8ENL7g0vLkojyqsIwns2NwEucb91W73rlBaiQ8VTAs6PEY1DHlWVeDOqK/kxve+BMmr8lZidxksu1DZRVh92NUMtl/9HKQE8P+wm3/oRsM3I97/aJ5hBizGdHtzr3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113189; c=relaxed/simple;
	bh=mVWUtEdz/NSNAg9iYBwu0F2436Dwq18jeTu37FpqBxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NiE3EHLj1AdEyMmwwl849njWd4oEkCG2YqBCNewwphSt6Nk6NqjYBJkHn1/Ng9y0pBca+y2Rw390eexPKEwNeXNv/bXAQQIhccapge7rCmnV7K7pJG22XI+UpXT5FKSvTU4KYBVD8tGsoXNziB0YqgT0EeDutFcr7Mngqxzugg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eZjpN/BL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8hJGx027329;
	Mon, 25 Aug 2025 09:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7UlZd2NA1oIFIP3xjkmXUAOxd+BQ3c+04gk0jxHffMk=; b=eZjpN/BLburw/U1a
	k+10U22/I3h/yaSIB1FKpzCWM5ZxniEOjKFQNrkviRLKi95WkAv2Ida8Mv8mDyh4
	nVEexcrIfIT4LcUv26o6zn5zhbesBGe25rGB5A4+qE505nYMkOvFYKYN1S1ywqNI
	bxbpPOPXRmD5dUJ+sV2Tqw9NLZYPipD5zy5bQ22Gd1O5NMo+AGyyjmb2O6Z8xjbh
	V3P3VfJ/R+XwHLe+qll2z4JFw2KLuaoXlkfPcMJMPKiz3mWcMn7rwHM26gp/YEzF
	cc0apGPUAVyCrdVcULPRMLTM5v7yrsB99YOiN1jtzAK3nuMr1oPlMqd5XvJg4Rp+
	i5kUiA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unmg2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 09:12:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57P9CopC031564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 09:12:50 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 25 Aug
 2025 02:12:47 -0700
Message-ID: <42806aa8-8cf1-476e-b775-50859fe0e7f1@quicinc.com>
Date: Mon, 25 Aug 2025 17:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>, <quic_ztu@quicinc.com>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <20250821044231-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20250821044231-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tmB35FfMM6EwZS0epbHQGlYIaL3atDFj
X-Proofpoint-ORIG-GUID: tmB35FfMM6EwZS0epbHQGlYIaL3atDFj
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ac2913 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=Z4Rwk6OoAAAA:8 a=65UapY6Dq9Cd7O_TsGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX/RCwqUGj+Twn
 gRrvNkKFXNaO/6q6wM4dghOnf6SvtLFToiUQb8HYPm3euolZFZ7qRj4bwWGipWlhuozq53we7Lj
 YvzME6Gh6UkGplhjSTTdwEHy7trW7y/TvQFF02NVK3QiReUyMKqsl9M82szi4GGfbE+vBO8w0hC
 86ODO4PgcR4T1QY5HJ74KIPTBydxeF0KN/VwVHnev+NCXOiVZzUvnqKkMjGvdl8WXvQTySdLlXu
 1MxuMusj/aaWeqh7Ei76s5jJnqbJiy5O8d/yc5X7/U0p36RN7x/zexKOvx7qrpAPp0ztQz5gKNk
 fxqjsOzQGtqf9S4UN2vuBxRwhMwNg8Pnw3bCrE85Imek4Q1PBlava6aWmL/Odp+wRD6szLQmFZS
 hW4UsRXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031


On 8/21/2025 4:42 PM, Michael S. Tsirkin wrote:
> On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
>> Add virtio-spi.h header for virtio SPI.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> ---
>>   MAINTAINERS                     |   5 +
>>   include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>>   2 files changed, 190 insertions(+)
>>   create mode 100644 include/uapi/linux/virtio_spi.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index daf520a13bdf..3e289677ca18 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -26760,6 +26760,11 @@ S:	Maintained
>>   F:	include/uapi/linux/virtio_snd.h
>>   F:	sound/virtio/*
>>   
>> +VIRTIO SPI DRIVER
>> +M:	Haixu Cui <quic_haixcui@quicinc.com>
>> +S:	Maintained
>> +F:	include/uapi/linux/virtio_spi.h
>> +
> 
> I would add a mailing list:
> 
> virtualization@lists.linux-foundation.org
> 
> 

Hi Michael,

Thank you for the suggestion to add a mailing list to the MAINTAINERS entry.

I noticed that other VIRTIO drivers, such as VIRTIO BALLOON, are 
currently using virtualization@lists.linux.dev rather than 
virtualization@lists.linux-foundation.org.

Just to confirm—should I use virtualization@lists.linux.dev for 
consistency, or is virtualization@lists.linux-foundation.org the updated 
preferred list?

Appreciate your guidance!

Best regards,
Haixu Cui


