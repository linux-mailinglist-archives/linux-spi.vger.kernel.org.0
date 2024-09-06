Return-Path: <linux-spi+bounces-4718-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F1396F207
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 12:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC892876D2
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6965E1C9ED5;
	Fri,  6 Sep 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eKjITH7L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95325153598;
	Fri,  6 Sep 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620297; cv=none; b=sdnCY2PaqddXWNcoRvJE67QnTN7Pox9K48N8Mx4Qj4EzNrntQSzibfOP34fO9HjqW2zjdmZB7kjhJnNxtP5DGroEAW+dZsDYES0rypkJz/va1q2QwojvDi/20Iyf6d+CXemDPnJTLzb8zUO4qGYqixL5Mbokyf/PVgh7fAtRGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620297; c=relaxed/simple;
	bh=6ur/vLN7UPpTErMEtIsh8fGBkugdDPr94m5+g3y8Q8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kxmsTohSctjn7WnrFKuRkWuRhxfA2D75T8RMqtUmthbEHMBoWxTbnRsb07LdXEvuZneIdyX9k04KG/OO1OP3NIUUe388FMWTIKcfsKZcbtiPs6KUxhhzv9u5BZG1OUZgNwhVVEMKp6sgPtb+XF6EwdzAAv/Owa57KGGYQL2lKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eKjITH7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4868YBdJ021611;
	Fri, 6 Sep 2024 10:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1h1SZiBxB2VqsNK+PGeZBrqAGT9gJtvjX46NECZ5Fck=; b=eKjITH7LBxCwh92r
	oRv8Ldspe8Yo0XlDBLT0x/e44ciXFNlvlFP+CDv8J/RUrW4fngLTg2wMBJiIMUOm
	a1SR4NrHNBC5CclfH4aL2crXY8kmS43YJQn01IBPxD1BK5DoYbAmrFsVfwPog08J
	u1INJfHOXEK3nIlwfFmQSzLzwNs7GZQsDcCytbRmb91pV8cBZD/M9B9ynokHTfZl
	efbWltVBTvU9z6riX0v8iLnV3ZYvOQLMHJmgd4roWDbl09GH/dYOy0S78jJPsGEo
	IP+xfFuQow6vntwZCACeMzQkGWnGNoAPvYoANeazEuiG1sDSKhn+8h+7H1oBvyXJ
	C3qdcg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu21me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 10:57:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 486AvcCv015839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 10:57:38 GMT
Received: from [10.216.59.178] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 03:57:36 -0700
Message-ID: <116e6eeb-bb58-47d3-b6e6-be1b38581a4c@quicinc.com>
Date: Fri, 6 Sep 2024 16:27:33 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: geni-qcom: Fix incorrect free_irq() sequence
To: Jinjie Ruan <ruanjinjie@huawei.com>, <broonie@kernel.org>,
        <vkoul@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>
References: <20240906031345.1052241-1-ruanjinjie@huawei.com>
 <20240906031345.1052241-2-ruanjinjie@huawei.com>
 <cff36a59-6f4f-4ae9-b5b9-e6e1ae822e41@quicinc.com>
 <2fd2b482-3d87-b95e-570a-10bee284d2da@huawei.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <2fd2b482-3d87-b95e-570a-10bee284d2da@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1z_qeyUYHrk4FVb9amwXx1KSOYjkNPHR
X-Proofpoint-ORIG-GUID: 1z_qeyUYHrk4FVb9amwXx1KSOYjkNPHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060079

Thanks !

On 9/6/2024 12:17 PM, Jinjie Ruan wrote:
> 
> 
> On 2024/9/6 12:27, Mukesh Kumar Savaliya wrote:
>> Hi Jinjie,
>>
>> On 9/6/2024 8:43 AM, Jinjie Ruan wrote:
>>> In spi_geni_remove(), the IRQ will still remain and it's interrupt
>>> handler
>>> may use the dma channel after release dma channel and before free irq,
>>> which is not secure, fix it.
>>>
>> What's the possibility of having irq if spi_geni_release_dma_chan(mas)
>> is completed ? As such controller is already unregistered so transfer
>> request can't come.
> 
> The irq is not freed, the IRQ can come and then it may enter the irq
> handler with the registered one.
> 
My question is about knowing source of interrupt at earlier place.
By just moving it above to spi_geni_release_dma_chan(), is there 
anything changing ?

>>> Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>    drivers/spi/spi-geni-qcom.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>> index 37ef8c40b276..fc2819effe2d 100644
>>> --- a/drivers/spi/spi-geni-qcom.c
>>> +++ b/drivers/spi/spi-geni-qcom.c
>>> @@ -1170,9 +1170,10 @@ static void spi_geni_remove(struct
>>> platform_device *pdev)
>>>        /* Unregister _before_ disabling pm_runtime() so we stop
>>> transfers */
>>>        spi_unregister_controller(spi);
>>>    +    free_irq(mas->irq, spi);
>>> +
>>>        spi_geni_release_dma_chan(mas);
>>>    -    free_irq(mas->irq, spi);
>>>        pm_runtime_disable(&pdev->dev);
>>>    }
>>>    
>>

