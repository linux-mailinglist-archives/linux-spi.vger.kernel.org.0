Return-Path: <linux-spi+bounces-9872-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40688B415AC
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 08:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA5716D7AB
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 06:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E22D8370;
	Wed,  3 Sep 2025 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k8sZGatY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B61E2307;
	Wed,  3 Sep 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882597; cv=none; b=kbbhragRI6S1ShsEvl7outAfT665VOVWnmBXCwEQRsZ+EOEuhVDOba4klBl87p+K3V/8HTlPfGctrjEmsewqtTVQTuMQKoWB3dR3RE6YjH29bduJI5niLzel6AcH7B2hztYlAe5PB+XAnduyeCAb/OiihVVgmG/vExwdzQulfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882597; c=relaxed/simple;
	bh=2rAWH629rl76XImlLDLPDHuK8WZBa2LW1tWWTqbRllA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j3owAYLay6fMlwlHeg9BdsSSNDRksqPxocYCUeUkUGynQIwcptJOJr4YiwLTkZAS2gVmK/wU1NrzCSZppiuyojZkbLsVCjIjBgjcMK3zJwJDx44E9T+69eh6svz736eXyA/utwF5eRSGnjBDyRlx1vDWY5QHKBHkTUp0NUGqlDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k8sZGatY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832EwLa001379;
	Wed, 3 Sep 2025 06:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyEnSBBjTdBbkEycTIVxjeFThBtLY+79HWKX9Dyuypc=; b=k8sZGatYyxwqjqt+
	GzHpevdVS28Gzb1y4uAYeSAV6GiPlfLclxvi6WLnfTC2SwQRXt9LIDx/gWkwYB+q
	gdquWJhGRHjjR+N4c+G6IF/K26e2DnmbEugzn9gUdYe6/aFWzhEv7nr13sOtgt8+
	rWg7riyIHfb6PKyfM8LjxP9VT0zD/V6RbiGH077TazNy/R+K4mgLapVM3AvlGGnB
	1WWPrKBdr5lsrhaH37GyaFA+oYZ2B+Xmk8ujKdlmma9iaNug1ux3lyr4epnZD8xU
	/k7G2n4q5D5F/kns7R7JEus9b5MZvSPHSGpbQ3tjDAB/cqVXNRG2UBrvOB2z4NJK
	snPEjg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy6d55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 06:56:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5836uDnn006086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Sep 2025 06:56:13 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 2 Sep
 2025 23:56:10 -0700
Message-ID: <764e77e2-303f-4603-8819-ec3116c85c02@quicinc.com>
Date: Wed, 3 Sep 2025 14:55:40 +0800
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
 <20250821044351-mutt-send-email-mst@kernel.org>
 <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>
 <20250828063350-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20250828063350-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b7e68e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=kBQPIZexwyFoi4fVXFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WwvxrEx_Rhz5oGp7mLCNuRFvNTXVgrwV
X-Proofpoint-ORIG-GUID: WwvxrEx_Rhz5oGp7mLCNuRFvNTXVgrwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXxtCXCHjAlBDE
 n1ctMdVtgKfNEY/HaoOnUme4ZuPhfXsDVf6DfNu+0tzSiYKMA9XWq0AzTamIqtGasmplgIvzzEZ
 VcpDTeut79QuGb4Az3XLPdhXyBkZDwfPWH9EUayU7L3y1a9bUk/oW05peEJoxDti7ngDDIgNks0
 S7AZVU0x3dSPjxbowAS8KA0duea8+7M1uBIfNIU4LferZNWRFmP+pRJRZDypoKNo8XM2YsZfIkJ
 aif7NFbJdOAY/hL7nb927ttymGtcE27CZ/upzwtHSJ9bU6RqgDrtXdZ65aTRFC99dbzvf571+h5
 7bk8hq+AtymPbRnAg2BknKYIxAGDAtPjrL6mHXwJ/kb3sdVz9/jPvlB3AK5pKHaliYDCfLiMYTu
 BN14PJkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101


On 8/28/2025 6:34 PM, Michael S. Tsirkin wrote:
> On Mon, Aug 25, 2025 at 05:19:03PM +0800, Haixu Cui wrote:
>>
>>
>> On 8/21/2025 4:45 PM, Michael S. Tsirkin wrote:
>>
>>
>>>> +
>>>> +/* Sample data on trailing clock edge */
>>>> +#define VIRTIO_SPI_CPHA			_BITUL(0)
>>>> +/* Clock is high when IDLE */
>>>> +#define VIRTIO_SPI_CPOL			_BITUL(1)
>>>> +/* Chip Select is active high */
>>>> +#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
>>>> +/* Transmit LSB first */
>>>> +#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
>>>> +/* Loopback mode */
>>>> +#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
>>>
>>> It is generally preferable to have an enum with just bit
>>> numbers.
>>>
>>>
>>> E.g.
>>>
>>> enum {
>>> VIRTIO_SPI_F_CPHA = 0,
>>> }
>>>
>>>
>>> Userspace can add _BITUL wrappers itself if it
>>> wants.
>>>
>>>
>>
>> Hi Michael,
>>
>> Thank you for the suggestion regarding the bit definitions.
>>
>> Would it be acceptable to keep the current macro definitions with _BITUL()
>> because these macros are also used within the virtio SPI driver itself?
>>
>> Looking forward to your guidance.
>>
>> Best regards,
>> Haixu Cui
>>
> 
> 
> move them to the .c file if you want them.
> 

Hi Michael,
I've observed that other virtio drivers - such as virtio-i2c and 
virtio-net - commonly define feature bits directly in their headers and 
use them in their drivers.

To maintain alignment with those drivers and ensure consistency in 
usage, I’d prefer to retain the current macro-based approach for 
defining feature bits.

Do you think this would be reasonable in this case?

thanks

