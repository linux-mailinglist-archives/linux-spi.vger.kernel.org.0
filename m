Return-Path: <linux-spi+bounces-6154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51D9FB969
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 06:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8C618828B4
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 05:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134813D297;
	Tue, 24 Dec 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ludezCFR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669B4C62;
	Tue, 24 Dec 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735016908; cv=none; b=d23xBeXtjXIOviJ+ZJFqooI/d3sNPxiROk8s/Z78FElbHjiVz6z3jfFWdlB8DmVz2fY5iJU/VOgwmKBWZQjxW5ColBA+yD4c/vS/or5VlZHwokWMAxAix1G1v3NJDghPZqEZJqjHgaZS4kXpbwPjsOKzXl+3/LP4DlaJVPT/tEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735016908; c=relaxed/simple;
	bh=RBuSwjae7IQlPCvoNRQ8SFTlXALTBttx0amabbPK7HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fT427FZDoV/Qc4DN/aKpaUJM2wZM342u8UE/1/uoCkTA/0oa37JVzmwEwlJD1RzUGeOFHn2+gFe06nGIRBHc1dJCB7Cl+7IaYbDxFbWkNgQn2X5bNzu2U1iYHZrioN0DWP2QpT2UxMqIlYwr2P03TfNs/CRFLFrle571VBOrCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ludezCFR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO4T9no002423;
	Tue, 24 Dec 2024 05:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Or765rq803BulnmGwYC6lg6plwc6SPFaXTcn2gUF2EU=; b=ludezCFRctrsgWKS
	QWVKx8zHte7E24I8pVd5ubaqPP3/JCvdtWAg6JdPA+VZLzDkJphixHACvukqlOLC
	fDYVRp0j9oBMC/D0Ul1iWV9uEhiWUl6puW631ewoaE2HPzm3Px1utnfswMX5YQAL
	hS9pLT8osWDtn33zDSdGIamxAE947TgKsAgB6gyu87xDgFsuZLrpKOnUPP3d9ft1
	4cizxMQmG1HZhvBF2dlQJXt/Cu4ByGEvTec9J+sUl/5Tw3RYWucyPXnWz/m6Wd2T
	cHnRL2SdfyzfMTyOW0HOdN8kN6+SyCqe3rArMpzEWHbBAMLhRN/ZOR9BcvPW4Glj
	g2LnPw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qnxxg3wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 05:08:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BO5873D007492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 05:08:07 GMT
Received: from [10.50.31.100] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Dec
 2024 21:08:01 -0800
Message-ID: <c6d05aa3-95f2-83d3-ef20-75305f928992@quicinc.com>
Date: Tue, 24 Dec 2024 10:37:58 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v14 0/8] Add QPIC SPI NAND driver
To: Miquel Raynal <miquel.raynal@bootlin.com>, <broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <richard@nod.at>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
 <87mshe58gq.fsf@bootlin.com> <87o712qki7.fsf@bootlin.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <87o712qki7.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YnaAL2S88cmyIimwO3UJ2ZVAcUndI6AU
X-Proofpoint-ORIG-GUID: YnaAL2S88cmyIimwO3UJ2ZVAcUndI6AU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412240038



On 12/24/2024 12:44 AM, Miquel Raynal wrote:
> Hi Mark,
> 
>>> v14:
>>>   * Updated commit message
>>>   * Fix spelling mistake
>>>   * Remove "inline" from multiple APIs from qcom_nandc.c file
>>>   * Move '|' in qcom_param_page_type_exec() APIs at the end of line
>>
>> I guess it is now time to move on, I can apply patches 2-5 and share an
>> immutable tag.
> 
> Do you want an immutable tag or will you wait the next cycle to apply
> the spi patches?

Please share the tag. Will apply the remaining patches (and resolve 
conflicts, if any) and ensure they work as expected.

Thanks
Alam.

>> However, due to the frequent inconsistencies observed
>> during the lifetime of this patchset, we might be slightly more
>> conservative than usual and split the patches over two kernel
>> releases. I fear there might be annoying fixes on the mtd side needed
>> because of some side effects. Without these, the spi tree might have
>> broken qcom support for several weeks. What do you think?
>>
>> Cheers,
>> Miquèl

