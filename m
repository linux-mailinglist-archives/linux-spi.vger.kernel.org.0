Return-Path: <linux-spi+bounces-9874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79172B4198E
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286643A4AB1
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08981E0DCB;
	Wed,  3 Sep 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F5S+mAiT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80E279DA3;
	Wed,  3 Sep 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890308; cv=none; b=a2aJECHDzM4XWrGwdxvaKhniPtap3ySSJJPDvyq73A4SLuwhS6SeVC6c5XVBOjpWH0NnEG8BxCwUDgaWFPs/YyrX7V7fcHfqwTMQIL3/EbyT+V+MMDgPJmoAXDViFGXZ8/i2RBcP4RFfogT66YceF8EkjyMdaowo0CvD4n8z1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890308; c=relaxed/simple;
	bh=/gl1pC0ant5pqVySdCbuGf8+Zrlw2CgAa4mXi19kCCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rnya4RzttA7TjXZSb18vbALB+pyBeAeFY+wQh9ARJlEWQiRJydX/tbbF8bTnSheSLuMYIu90SLGJC1v1Ziar/sWGmkpAM1Jh1PHBw9e/MsqJpCCErs2sMCndHtxc8ZN0BwS/OiDh6wZRdjVxoTq+sfYCZ9PtwrU5Bk9pKZGOp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F5S+mAiT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832AIYO018247;
	Wed, 3 Sep 2025 09:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gmRmEkgcNzLuKUfrQpEH/3+Ar2RdGFpAR8GYLm9tkWI=; b=F5S+mAiTDUJI3yg0
	gJtUZqnSxZIIUZD9dkzRl6f8IpO3wlr+EXSzLePQuDlOBAR+TRNyZAxHCgkBW4Y0
	f9KqouTLU1zfBUlIK/bBLCwL4y4BRKV28t2scMsGXv5qIvEj64TpgDPkVc9Nd78h
	pMm+6zGkJbpmi3TKDs57srC/gEdP47qFSq9TcZYR1codQg1OS1Q/Z91Dj/QbowrW
	K7QNRVdQdfItIspqgNI2iyxLA+bfUbqH3eCU/5hbado9dEZXDkzc3THtUSvMSVCq
	jYufYGDCo7J5CaFaeTrIKeXlI2j9NjirrEj0j9aXdALZoLg5IViiYl5uaTQ9e8N+
	N3x8lw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvwcnhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 09:04:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58394rvG006086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Sep 2025 09:04:53 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 3 Sep
 2025 02:04:49 -0700
Message-ID: <5dcabe90-c25b-4af5-b51f-5cda7113b5f4@quicinc.com>
Date: Wed, 3 Sep 2025 17:04:46 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: <harald.mommer@oss.qualcomm.com>, <quic_msavaliy@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>,
        <quic_ztu@quicinc.com>, <virtualization@lists.linux-foundation.org>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX/V0t6H98yX/B
 GKjOY/4ryhNwz5m1gDWXb0Jpxb4yQPOljmrTsqj5dwV7+Baxk7g+bpkaURkg3n0ycfHMpwJPHy2
 mjmDJaYtm42Ps+9SqLeHxc5yjXZD5B6jl0Yg1Y/iioMrv68Zp8ll+2T1TiGrubPAB2M1Sip2a9K
 a3t6ZYKTd/BHiuVq8x+x+W0jx8Kle2WO5gac6CjkVJCTp2yCFrQITy6UJMYfWzblsDQ+OGTpmhJ
 DWM2TBQXYpf6qcd/JbiZpYTIwAklzDtsV81iudHrkBHpRrizswutMCTRoyD1VtcXPkQzlizFupJ
 xyb9dJHrnHrz3rjGO3vMNj3XDHn9iBo0NQoz3t9gLL5yFWWoA0d0sUFz5Wr7m6JSVymJx1ceanc
 +lKTdluZ
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b804b6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=t5LXkfIdq2p3eZCY7hcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K2QkfUzmOwVrHfZYiRY392QYy3McBx61
X-Proofpoint-ORIG-GUID: K2QkfUzmOwVrHfZYiRY392QYy3McBx61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024

Hi Andy,

On 9/1/2025 8:07 PM, Andy Shevchenko wrote:
> On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
>> This is the virtio SPI Linux kernel driver.
> 
> ...
> 
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/stddef.h>
> 
> A lot of headers are still missing. See below.
> 
> ...
> 

This driver compiles successfully, and I believe all required 
definitions are resolved through indirect inclusion. For example, since 
I included virtio.h, there is no need to explicitly include device.h, 
scatterlist.h or types.h.

I avoided redundant #includes to keep the code clean and minimal.

If there are any essential headers I’ve overlooked, please feel free to 
highlight them—I’ll gladly include them in the next revision.



> 
>> +static int virtio_spi_transfer_one(struct spi_controller *ctrl,
>> +				   struct spi_device *spi,
>> +				   struct spi_transfer *xfer)
>> +{
>> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
> 
>> +	struct virtio_spi_req *spi_req __free(kfree);
> 
> This is incorrect template. It's one of the exceptions when we mix code and
> definitions...
>> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
> 
> ...so this should be
> 
> 	struct virtio_spi_req *spi_req __free(kfree) =
> 		kzalloc(sizeof(*spi_req), GFP_KERNEL);
> 
> (or on one line if you are okay with a 100 limit).
> 

I plan to update the code as follows:

struct virtio_spi_req *spi_req __free(kfree) = NULL;
spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
if(!spi_req)
     return -ENOMEM;

This follows the pattern used in 
virtio_net(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/virtio_net.c?h=v6.17-rc4#n3746)

I'd like to check if this style is acceptable here, thanks.



> 
>> +	if (ret || bus_num > S16_MAX)
> 
> + limits.h
> 
>> +		ctrl->bus_num = -1;
>> +	else
>> +		ctrl->bus_num = bus_num;
> 
> But why do we need this property at all? And where is it documented in the
> device tree bindings?

I’ve reviewed other SPI drivers in the kernel, and it seems that bus_num 
is not a required property in most cases. I’ll remove the related code 
in the next revision.

Thanks again.

BR
Haixu Cui






