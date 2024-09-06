Return-Path: <linux-spi+bounces-4714-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723696E8A0
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 06:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FF11F239BF
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 04:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E33CF73;
	Fri,  6 Sep 2024 04:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LXdZDmjc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11682819;
	Fri,  6 Sep 2024 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596925; cv=none; b=d7M1vk9hDNgG+FkhhlvFabtWtv5JYCU7LHjl7K+00EVPyrasQ1krnUV8NI0pUtOM8ba4vEM/C8gXWKVKdE+jzRjYglmq+XSBLwtE/4JzGaoFGC7uUuMA4DybQW8vgoQYBneyguMAS8q7zyRz0xvoP1NKYKIHhsUzMjMJVwZaJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596925; c=relaxed/simple;
	bh=WDuJISel46vWLI1jWXJI6bu/hEc7qoZi6WNem3yYtyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dEcifNFHyiF/F52gvyA5J4S42/+lDtBn+Ny28uSIiQG05NQ6dBcmQ8fg8B9KKGLd+bPdOJwRZRzzeWzHHNED10cH/MZnGGC1FzbUDK7T/9EwuTSSTsgJTO2Hf9BC8yUYrfKWFTjPGbdPBnJOis6SV0J6bIZE91fFR4DXn56Y7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LXdZDmjc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQW5U008676;
	Fri, 6 Sep 2024 04:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgeP7TvK94F2W7v7Vnlh9CSLa5BNQBPQYvF2llEWitk=; b=LXdZDmjcJOXDkrbT
	wbvqxYEcBogqRtPOQ3nc1gVmVhjOgNoCAWEtiPAGPDb0BVdFy2/ufa4dZQPuAp+b
	feh0BjEPwf3S9aHMHqLVOFkZOH6B0qOKplVoYqbDuWFUz69Y4k+fd+l1DgTxiBHX
	vat8OD9DNTXXXkpPC1OiGqlkV8gY7Uo8jHH3eK2oYO7GAGD40T06rW90pz7v+Oo5
	j7oQQMLipLBMgeNPPT82EJdp2PCxKWr+Y9FmBbGotz6vbsVklznsiIoptLO5+WHW
	jtqm/qFt/ILPjXzmWpT8gTn8o39WztQLNUzZ39mEpZpKd7fbEdxm4b/ORzr44hqu
	hxOckA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhx212su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 04:28:03 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4864S2gE003038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 04:28:02 GMT
Received: from [10.216.59.178] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 21:27:59 -0700
Message-ID: <cff36a59-6f4f-4ae9-b5b9-e6e1ae822e41@quicinc.com>
Date: Fri, 6 Sep 2024 09:57:35 +0530
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
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20240906031345.1052241-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7tdZ8ytzo-pxkpXs8jhtFGi6uhrl5y20
X-Proofpoint-GUID: 7tdZ8ytzo-pxkpXs8jhtFGi6uhrl5y20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=915 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060030

Hi Jinjie,

On 9/6/2024 8:43 AM, Jinjie Ruan wrote:
> In spi_geni_remove(), the IRQ will still remain and it's interrupt handler
> may use the dma channel after release dma channel and before free irq,
> which is not secure, fix it.
> 
What's the possibility of having irq if spi_geni_release_dma_chan(mas) 
is completed ? As such controller is already unregistered so transfer 
request can't come.
> Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 37ef8c40b276..fc2819effe2d 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -1170,9 +1170,10 @@ static void spi_geni_remove(struct platform_device *pdev)
>   	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
>   	spi_unregister_controller(spi);
>   
> +	free_irq(mas->irq, spi);
> +
>   	spi_geni_release_dma_chan(mas);
>   
> -	free_irq(mas->irq, spi);
>   	pm_runtime_disable(&pdev->dev);
>   }
>   

