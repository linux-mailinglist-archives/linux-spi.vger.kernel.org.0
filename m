Return-Path: <linux-spi+bounces-9658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F3B33AA1
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFA31B243E3
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77213286424;
	Mon, 25 Aug 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mx8WUkg6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49E18A6A7;
	Mon, 25 Aug 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113564; cv=none; b=u9bDSPL667pK8hXOKWY9Ws3EW1XyykcnbopNRQKQuH720P1DBYB7maaTuNlVi7b9l7+LM1t5l0xG9OrkgcD071KoyLV7jorl+AHMyeJ+xWLkz2oFjdZf5k9LlE0KH5bgd2I/gcgqQAp93SE9s6I2dqZOF/Yyzbb9lbx0lSmi8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113564; c=relaxed/simple;
	bh=dO75kfDvLNP5Wz6kBuCYf/Gwb1MrErZSkC0XR1qBIAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WeUmXlIyiZchPil1FLPnFefSmzFReQ/z8oukhCpXUDkTyWDLsykdKdxQ0XZ5L2MzaKciSDHAcOO2AxTAlsBXzFu8Vn+G191P8qxZXD4dyJBUubz0853CNKgyjC/JQ77UVfRWKhRknfudNqtwj3V3nj+csMCo6JKvlz4MbMz5yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mx8WUkg6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8W7mU025970;
	Mon, 25 Aug 2025 09:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mh220e+g6qgD6S6D71KRNsow1IYrGbMLFS6ZXi3T3E4=; b=Mx8WUkg6NPyU0OWB
	5VRQgA/ZBdwqGyPyG26yyypdcQQwD4rnKY/jIf9Oi0V0zCCQFY0o7iSHI2dSFkgv
	+2gYOQHz2PhbYMfSZDgWn0Lqw6jLUzD4DCd3SpYNTNBdLrpGjZymcEI4gk1/Bn3A
	9RpcQroKlwFrg7CMVrPyMbj41uwEtyNwJ5XsDCMgHVzZzHKb9ce3cCBb0s9mqS/r
	4GlHYUx1x9AxO6QGUPn0W/Xui9rmN9ww8oE27KDNSP+MSWvOHwzARaZKCkw2ZBH1
	ujINVIZueyeqiAupi5IHByAN+1FruSlyVd92MIsptjZ+rUW2eBWjy2nXH6w8otMp
	qN+VZw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unmgrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 09:19:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57P9J88P029731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 09:19:08 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 25 Aug
 2025 02:19:05 -0700
Message-ID: <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>
Date: Mon, 25 Aug 2025 17:19:03 +0800
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
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20250821044351-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JNc3JO8P6yjod7406IohdMIl0tBhS0-h
X-Proofpoint-ORIG-GUID: JNc3JO8P6yjod7406IohdMIl0tBhS0-h
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ac2a8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=BIS7xV68lBtj0k_KtVcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXzblrjuIjS2Lq
 EAZf3OLxHSfI7cHz5yXYS+00WawSGO8HZUaFkYJCdf6pRC4QAGNH7E/OV6sxLnUVNZtJxcMuGVQ
 6o6Tbu5Ys4PoLXiDaKM5LCuS1fRDmsM2cFa+tE89/LnOLzmA5FPodNmWkbKIBquZVjEwxj+XFIA
 UX4OZs8PCYDmvzjotkgxBsmwgC4SqfaJnj8iHBKl91WEvDW4EjQlBRcrER+GTxzt/wEJ6I1Folq
 Nm7h4Xll9cHrGO2fWwBWg277l9k40Q9lqTwLIt+bmCkEg4EbcisslPxeYX85OKHReqxtRqSN8Td
 2set/aPO7onzslwaebmfmxKhb4oBEyGESj5EFFNsnEIAaXc7DSoD6E/Jqca362I6ldznTiZGW4p
 xrZPUVJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031



On 8/21/2025 4:45 PM, Michael S. Tsirkin wrote:


>> +
>> +/* Sample data on trailing clock edge */
>> +#define VIRTIO_SPI_CPHA			_BITUL(0)
>> +/* Clock is high when IDLE */
>> +#define VIRTIO_SPI_CPOL			_BITUL(1)
>> +/* Chip Select is active high */
>> +#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
>> +/* Transmit LSB first */
>> +#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
>> +/* Loopback mode */
>> +#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
> 
> It is generally preferable to have an enum with just bit
> numbers.
> 
> 
> E.g.
> 
> enum {
> VIRTIO_SPI_F_CPHA = 0,
> }
> 
> 
> Userspace can add _BITUL wrappers itself if it
> wants.
> 
> 

Hi Michael,

Thank you for the suggestion regarding the bit definitions.

Would it be acceptable to keep the current macro definitions with 
_BITUL() because these macros are also used within the virtio SPI driver 
itself?

Looking forward to your guidance.

Best regards,
Haixu Cui



