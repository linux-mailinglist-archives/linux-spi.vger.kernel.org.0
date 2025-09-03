Return-Path: <linux-spi+bounces-9873-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5182B415BD
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 09:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC341B23602
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62C2D6E64;
	Wed,  3 Sep 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fkWe1baj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7D2D3EC9;
	Wed,  3 Sep 2025 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882851; cv=none; b=mlIM44W6OT+f6Tp39YVfUBiIiQsCJyM0t+wwPmU7qjuqnqtglDntPbAmbq+MoRTpJCCPVA2R1My80daPJ99aoJ7eExhHr0N0MHjHLKG8eMWUrt18GCQbx+L3kPgmgh4KuOHrXIPSCg0CrzKp0KtT9JP6w0ofzb+YSNfCsc+z2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882851; c=relaxed/simple;
	bh=4WOcmsJ1ltApDp57ZzrYgfeS6xmB1ybhbMhEjEAEp48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qoA8nlrX24tAgA23oR9LDQRnathZ+j7gjPh32pTD91pnLhae0vO07yCsusSEVUrfY0kGUldc9wDjkNWg7g7Ff1EBo/DjjBPHr/CzD6yEL5cE6o0xF4jyVad5rmzpNdG2VQFe53ZeoZBDnAWqPyKrpIqEtR1l8sD6NK+He5VYf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fkWe1baj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5831TCGt023427;
	Wed, 3 Sep 2025 07:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0B7furphkdJFWVi3RfqTepuGiQOg1Vrgr5nYqmWysRs=; b=fkWe1bajvUTIwSG+
	BWsTYZrcJp1HpotYlV1AUhqWO6vIfay8oAGocYFRrXzArVswkZrGgpHCYZ7Rr2tw
	JiymTz3dBozq237089qy5Io7D/HnLxS7qIy+zmEdihKnpB8Nlfg1MnxorXrKKQNs
	VOej5+EgQ5pZGvS06F3cRIa2RI09UP1EPHo7ZzWkE4z1ZlDYKq8zdMUItNRMxK+U
	3Z4MlEAEeHMllQ+c5bvH7+dQGIV1eO+pAiC7tC6ZPEaazaljZC2NJW3H4QoKUpoH
	WsXmB+TtAxDBD2pC9DzAnuXP5Z557Ze+O3d56UBQ2/1l9+zCHNH1+TK4KIRWmdcT
	AfyW7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpaq42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 07:00:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58370VtB027441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Sep 2025 07:00:31 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 3 Sep
 2025 00:00:26 -0700
Message-ID: <59a714eb-8c2e-4c6a-8c9f-f90e11d848cb@quicinc.com>
Date: Wed, 3 Sep 2025 15:00:23 +0800
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
X-Proofpoint-GUID: b-X9GZFnG_VHSZ64rqKhKpTgh1bqkTSu
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b7e790 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=kBQPIZexwyFoi4fVXFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: b-X9GZFnG_VHSZ64rqKhKpTgh1bqkTSu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX/O6zdZErx7cN
 8qruV6MpzMpe2DxCiz2BOMmhJL5Rh3hdXr1y2gRlDvuIUOGIr3b3Q8gZsFNllUC02Wk6uOs9vFk
 bEYM9YMIIH2SpMGxep3vDgXomeVweZjn4NkVWO4m+Lkr5199Ydxxmg8wJtlri8AYuU72Pv+CBh1
 aqh1XytznGl3kD4kO6WdVaJNNKy8u7QLqRILnpLncqtdiAd1b/XW9ynUPRWlWmAJGXbrjyWPNx7
 qieOIrZYho3e6T0ngZyB7ECwQMh6D+kRYrAhSUVensDM9/EfGDeIeIVwtKYiZQia5KIHx/OKQHF
 AtIKBQfCJCYJZjkJgtSCERuBGjjiqnXX1Hy5TLmwXuWTxfZiW31gaHezVcXIypPLAkenAMkKY1F
 FuvdFkTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001



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

Thanks & BR



