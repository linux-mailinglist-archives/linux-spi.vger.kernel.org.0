Return-Path: <linux-spi+bounces-5532-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867499B418A
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 05:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1064AB21563
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 04:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244821DE4FF;
	Tue, 29 Oct 2024 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZVJCnqAE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5514900E;
	Tue, 29 Oct 2024 04:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730175422; cv=none; b=kP3MuKg3F1LC/5p4SZNCVZLcsg34Qz8G0hTWDEQJo1CNoWXvHrSPiYEBhXTXHpMEOv/Krlzd4380QMvDtPCCWOUjaojJzJSeMkVDxpaMV8ZE16oivH75dRPaUQKHERob5gUYrphKi7iZDrToZTOMhWrY6JBRnREB8xmWfX6iVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730175422; c=relaxed/simple;
	bh=ohYcq3Jzmdd1CqCu9i+x+Cn4uF+NoxzmAWODMcVhynA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TOS+mgqajoNFCmIMGcn6W4zgZm5JuyeMz9pPpO+45uNQ/cJXLLtqAqpytTUGUcMM/zknBpqdU3754RHhMDmx9mhZ5Vd/cT+qgY9HO8LWpNRqwTd4pQKIfdRWWkoF9dSMaug4Yc78SUM8xmZYQsLaT4CdJMh3Y3Uf6z8Xz7xaFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZVJCnqAE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SIFADo010194;
	Tue, 29 Oct 2024 04:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWAg+RtxfDkBXJrBxaZJA2nuf2JO7cnYiwXzb8lU/Lo=; b=ZVJCnqAER0rYPNNU
	MYJRyl8RPHbsjfwhxJntLx95blYm9x3o7RNqrIVPJXCUIpT/p9mv/7tVmmslP39I
	2BbE+NMHSnD5vLMPDflXW2yCfnRmA6QmB7ERrVdBF6AHj7+Rn0WPiEN1ssUr3Z+o
	cOJuF1UU4tKeCzpbaXWPQkX/6o00DnkUf0d7QcmX6AMslS6oQLQCZyu3PCv+Xicj
	fLrD1L1jBaH9phM64B2wP0kRgqd3uAQtWeFPVoivFO2J6ndyYfS8WPfu9mJjOO1s
	0Y3ibwDzdQQ0DH9SdUeYhzJv0PmXuo8TsGTdpe2I/T2thQLOUeLThrOmZg9083mK
	STSvEg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8f52y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 04:16:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49T4Gf2P006827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 04:16:41 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Oct
 2024 21:16:36 -0700
Message-ID: <f56d0181-2796-e185-f2b4-c9cea8bf8daf@quicinc.com>
Date: Tue, 29 Oct 2024 09:46:33 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v12 4/8] mtd: nand: Add qpic_common API file
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241021115620.1616617-1-quic_mdalam@quicinc.com>
 <20241021115620.1616617-5-quic_mdalam@quicinc.com>
 <41db541a-4de1-409b-bfec-7b9456fc200f@quicinc.com>
 <4c239c07-799c-b910-c6e0-ff717202ceb0@quicinc.com>
 <dcdd870b-c4b8-4bb8-9c08-82474cc4d872@quicinc.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <dcdd870b-c4b8-4bb8-9c08-82474cc4d872@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VkcB9iZLWmYReGgSOPJeTo8msJPCaB6V
X-Proofpoint-ORIG-GUID: VkcB9iZLWmYReGgSOPJeTo8msJPCaB6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=925 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290031



On 10/25/2024 11:57 PM, Jeff Johnson wrote:
> On 10/21/2024 9:39 PM, Md Sadre Alam wrote:
>>
>>
>> On 10/21/2024 11:49 PM, Jeff Johnson wrote:
>>> On 10/21/24 04:56, Md Sadre Alam wrote:
>>> ...
>>>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>>>> new file mode 100644
>>>> index 000000000000..570ab59ca12b
>>>> --- /dev/null
>>>> +++ b/drivers/mtd/nand/qpic_common.c
>>>> @@ -0,0 +1,757 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
>>>
>>> I'm surprised you aren't adding a 2024 Qualcomm Innovation Center copyright
>> qpic_common.c file is derived from drivers/mtd/nand/raw/qcom_nandc.c file
>> so I am retaining the Copyright from the drivers/mtd/nand/raw/qcom_nandc.c file
> 
> If you have a derived file then you should retain the copyright of the
> original but then also add current copyright for all changes made on top of
> the original file.
Ok, will update in next revision.
> 

