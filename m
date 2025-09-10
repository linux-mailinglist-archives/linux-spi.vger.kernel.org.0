Return-Path: <linux-spi+bounces-9958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD2B50C70
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 05:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F1C4443F5
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E126B761;
	Wed, 10 Sep 2025 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MibgBMdj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDE26B0AE;
	Wed, 10 Sep 2025 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476284; cv=none; b=t//uNwK8Du1+kC/MatOB0y3Z8J57puvRW/YgXpjVZByjBAEFdSpBZPrR6Q2WiL9PpA3+iwLdr1GrVGSV2MH8G4oCZSDXIeterx+1dWT4hjmW5YP+el/9gow/KegC15sngRKpKevzlIiZ2VCQN/s28aY7JAqUFBAgRAu0gTsX69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476284; c=relaxed/simple;
	bh=qxZNqAZix6rwCEO0rBimeWyzxV2m1XdT0a7sLYWurxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hMFDENoFCpFGP99/A5lTsxEoIgS/OCsDp5l7ShEMoQdVeia9TNrkTpz2Fu14i/RLq380TgJ69/7rtGiT/m1QILeJHHcs+2tlNdQVsjVcuJ/UZQcvI7BIpsh7whCOvvSM7Xt62uKhhClFzqjQCTEUq8g3AuBdxI06HRLl9eAGeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MibgBMdj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589I0MBu002266;
	Wed, 10 Sep 2025 03:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D5mdBHAqEXHP7zlYREqKopUuLf7On5DXG2WXrZu8RVQ=; b=MibgBMdj2rnv/Is6
	mCtkBK8uL5pTvQ+lYsBpOZON/O13aDYk0Was/mqg2/zgCkbnPtBY5ozOFLHu6385
	qWGXKwEP36fPK6myZjZELLJHksMItWbKE4z7SoPBdY7fPKBNIFMSCpUbnUHI3KIy
	SYjhFTIJXAU5b4Y8ixuSsXWaUbeljcAfFP+XZReezKrmSN3xRIKiVgGaTIjUmvGZ
	mhpKOveXcFGjvX8alFDkOnneKA3D0WjWx8MOzTBsfzCqmgAY5u1uXDpFyRughY57
	kyPUYqa0HuDQaWoybr0or/P8BALgeJV4Vji45ySka7HMkmKCs7YbtdVxcpxXuMcr
	hqxXjA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg2ann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 03:51:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58A3p83a010036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 03:51:08 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 9 Sep
 2025 20:51:05 -0700
Message-ID: <b9e9b4e5-7004-471b-a067-b6bacda2a0ca@quicinc.com>
Date: Wed, 10 Sep 2025 11:51:03 +0800
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
 <5dcabe90-c25b-4af5-b51f-5cda7113b5f4@quicinc.com>
 <aLgYLS6Lr5O2cIhK@smile.fi.intel.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <aLgYLS6Lr5O2cIhK@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t34zmPoYWIF5cJKlrOhIOy2qKnYExiFs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX9z2qHvHq5kR5
 wqw9Z65HogeBamBnVnLn1mXtaqVt09thac5Td7IMssI1Grq+LdvG5AIXoxZ4mlZUqBHkqb/UdZE
 2f7BxaGzUdzX72XGGPpPac6lmm4Zb6CYR5pM6s3iRUh30EbWdJnag6mMf5G7YJiCLbT0hgiUX5r
 le1+/0ovkTOqnmsmedqp5mKDX8F+cUDgb+QihfNmhwFKuBT4KKHyQmV2rLU+0mUOVlz786Yagbi
 jMrZin/Ot9WKAZkQKq2rmpQmzD438i4RQUtgK2BJwTmt7GzSn17C+6UMeuYmhobXrLQ4cueMuvN
 DJwcViw8nyu/CG27gF98L22fJF3gf6ZyJDZfarjjO6FYSdIWfM57737TEEZLqmO36LC8cJCwJEL
 t4rz8Vph
X-Proofpoint-GUID: t34zmPoYWIF5cJKlrOhIOy2qKnYExiFs
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c0f5ad cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=4kCC11VFAAAA:8
 a=FwAf4IJFFU_psRvsp1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=i1DTqe_zuw-yvs4WsNz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035



On 9/3/2025 6:27 PM, Andy Shevchenko wrote:
> On Wed, Sep 03, 2025 at 05:04:46PM +0800, Haixu Cui wrote:
>> On 9/1/2025 8:07 PM, Andy Shevchenko wrote:
>>> On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
>>>> This is the virtio SPI Linux kernel driver.
> 
> ...
> 
>>>> +#include <linux/completion.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/spi/spi.h>
>>>> +#include <linux/stddef.h>
>>>
>>> A lot of headers are still missing. See below.
>>
>> This driver compiles successfully, and I believe all required definitions
>> are resolved through indirect inclusion. For example, since I included
>> virtio.h, there is no need to explicitly include device.h, scatterlist.h or
>> types.h.
>>
>> I avoided redundant #includes to keep the code clean and minimal.
>>
>> If there are any essential headers I’ve overlooked, please feel free to
>> highlight them—I’ll gladly include them in the next revision.
> 
> The rationale is described on https://include-what-you-use.org/.
> 

Hi Andy,

Thanks for your feedback and for pointing me to the iwyu guidelines.

I've experimented with the iwyu tool, and while for spi-virtio.c I 
noticed that it recommends header that is not directly to the code - 
such as vdso/cache.h - and occasionally suggests re-include header like 
linux/spi/spi.h that is already present.

iwyu is a power tool expecially in application-level development for C++ 
projects where header dependencies are more straightforward. However it 
seems iwyu may not yet be fully suited for analyzing Linux kernel due to 
its complexity and conditional inclusions.

Additionally, I’ve verified that the driver compiles successfully with 
both gcc and clang, which indicates that all required definitions are 
either directly or indirectly resolved.

I appreciate your guidance and will continue to refine the patch with 
clarity and maintainability in mind.

Best Regards
haixu Cui



