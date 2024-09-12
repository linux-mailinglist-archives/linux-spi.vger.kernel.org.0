Return-Path: <linux-spi+bounces-4794-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6095976154
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 08:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D301C22C9D
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DB18BB89;
	Thu, 12 Sep 2024 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hvGEfIkR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC932189F20;
	Thu, 12 Sep 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121939; cv=none; b=pj9LzStBRL4PpR0mRtCSQGO5Gd4mPlXd2i/NibHbjsUfFnMFiMFg0PWE3wmAmQ0VEi+9aa0hA7dDmVPt6tk0Kg2DMff1gD5hg21WMNKDsx9IoZNSJ20lj0flC4u4aK4BBwY//0HuIjmOuSZM8KhHps82qkJ/yoJWoki92rtb6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121939; c=relaxed/simple;
	bh=aizWbA2LabtwDk1tx+RW3EiHD254TxdEs6qeqX43M6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nEDNw5+xFQJHrsOJmxYW6QcNcNoOLS60L9foPbuJxE5b2+TGfwRI7A6Qt7UXBT8EeGVdRUTlkNYuGi6nG4eJpekmdJxRenUiOZi000KhASVFVxL4tM2NNlCDRvQurS78ofSc0K66KDRyRHPX2XgH9mECx3kPhmhJIzeWtMHLo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hvGEfIkR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C2L3Hc000707;
	Thu, 12 Sep 2024 06:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bcpWMPBrKfFYTh0DDOkCavKCNrnvqAK6zb2Ig0d+Fkk=; b=hvGEfIkRisWXRd0N
	YqyA4I3BGzw3JDSi8A7i/Z0RiCuM0qDIUQjWPRcTeqSnZGjTqgHA2Yrs4CSn+svi
	XVrDQCSoIzNcxE6F6M/bcw+Ui0+u3KWxn64PSJkaoKiVugXxUWVY+1buIULlF7j0
	y7aEUM/9tBvH4979YZ29/nNUuVjrYrwGV3DIRk9iXHjR3v7kVthHRpts0iuf32Ap
	idM9cfc0+K52kC5ocachOabEIh05fULmqJ6yyEyp8+uV/hTimy1CWtHUrenRW1tg
	Nc9AkjrSwRqbgek2n7xtZ4LeyMPacgIDGWICFs/Ugxuab3p04LJbHdSfkLlkOfZZ
	m7QT7w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpv0wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 06:18:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48C6IZ0f028712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 06:18:35 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 23:18:30 -0700
Message-ID: <25975ae0-a8b3-a633-f3ee-c338de7a09a4@quicinc.com>
Date: Thu, 12 Sep 2024 11:48:27 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 0/8] Add QPIC SPI NAND driver
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
 <5169761b-422d-70ab-ba53-a898cb7bfa2f@quicinc.com>
 <20240903150826.749b8560@xps-13>
 <bb1397c3-2327-e211-f7eb-cac4b126424e@quicinc.com>
 <20240910094120.19348fea@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240910094120.19348fea@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IkTYh_XMnR4e3VNSGJGPxyNdcCA3yKzG
X-Proofpoint-GUID: IkTYh_XMnR4e3VNSGJGPxyNdcCA3yKzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=905 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120043



On 9/10/2024 1:11 PM, Miquel Raynal wrote:
> Hi,
> 
>>>>>     >>       I have addressed your comments to v6 and further posted till v8.
>>>>        Could you please let me know if this is fine.
>>>>        and how to get this merged ?
>>>
>>> There are still kernel test robot reports, so this means there are
>>> issues in your code that I don't need to point out explicitly, but I am
>>> actively waiting for them to be fixed.
>>
>> I have fixed most of the sparse warnings after converting __le32 to u32.
>> However am not able to address the following sparse warnings
>>
>> 	drivers/mtd/nand/raw/qcom_nandc.c:1401:29: sparse: warning: cast to restricted __le32
>> 	drivers/mtd/nand/raw/qcom_nandc.c:1587:30: sparse: warning: cast to restricted __le32
>> 	drivers/mtd/nand/raw/qcom_nandc.c:1588:31: sparse: warning: cast to restricted __le32
>> 	drivers/mtd/nand/raw/qcom_nandc.c:1589:34: sparse: warning: cast to restricted __le32
>> 	drivers/mtd/nand/raw/qcom_nandc.c:2479:47: sparse:    got restricted __le32 [usertype]
>> 	drivers/mtd/nand/raw/qcom_nandc.c:2480:47: sparse:    got restricted __le32 [usertype]
>> 	drivers/mtd/nand/raw/qcom_nandc.c:2616:25: sparse: warning: cast to restricted __le32
>> 	drivers/mtd/nand/raw/qcom_nandc.c:2672:32: sparse: warning: cast to restricted __le32
> 
> The rule is: you cannot add new warnings.
> 
> For existing warnings in the driver, I'd anyway advise to solve them.
> Without the actual code I cannot help.
I have fixed all the warnings and posted next revision.
> 
> Thanks,
> Miquèl

