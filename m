Return-Path: <linux-spi+bounces-2981-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17298CAE56
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 14:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E407282296
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A66CDAF;
	Tue, 21 May 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OKnzGjWb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A428E7;
	Tue, 21 May 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294716; cv=none; b=FCwFPyvXd9LBcPzWs3KDrr86ryUxOq96mGBY6SR1wmVauPrlv4+BYXJzsNjprxgV1NSGuGGlhymHHjGuYamtIiewdOmgy3O5Goqki1iJWI2i1sB/KtZa4bKu/JuKi0H1kcs95d9cIcdRs7NH0GAHai/54A3/W8YztwHlZxCSsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294716; c=relaxed/simple;
	bh=2VUP4B/6QYT/IYsnqmX+BdABbHu7lo+RmKillgVoklM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CJ9PTo3Pq1OKouz2N/AMZaBazA8qAkvRwL7okC2S/5BiqvYSL2SxkU5SxQTQc1xVsmRSTOw2Zb1i3ttHwvrpyYC5Oyd53kkMItfilCHI+TA0MWmrqP7tJe7ESR0i6vSnt26cKuYgpflAGZ7dtrkj8UNShIhPFgUiMO6N4gmn0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OKnzGjWb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L3aVf6030616;
	Tue, 21 May 2024 12:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IlNoFCAo5nlH1H6C7luAGx5l0cpdPI2BaL3sVZ5ChUQ=; b=OK
	nzGjWb/xQ3SL22yP1AOVCAM5+gVyAZHPnyFuj1TYnDxBCWe9hxm887WNawshFbrb
	14Cs9hjVRCPM1sqYfqvsCuqM8lsc1bcgwxyUb617i5zi0WfqTsDCartXQgriQ/la
	fM/t3979B0oaUnOcqjha2f3/TSlAUzAZomXqe8JoRMSsx/O3Cbby/Dz0xDCwkI8N
	cY4aB1zAEIujCe9PvtSCrwV05APVYRDc5wWOwURfeCaoXufo892lAELuU4iNDaSF
	wuyz5yt2cmcWNyrERzFHhakhzX78lQDoNVsRrTWnjPrQA9NvCoC3U//DS9YdZRH7
	Fk6YfjoSTnGl99RYbIsA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pr2nqmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 12:31:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44LCVbnB004681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 12:31:37 GMT
Received: from [10.216.52.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 05:31:30 -0700
Message-ID: <abead689-de3f-eed1-fcd8-6347a2518ce6@quicinc.com>
Date: Tue, 21 May 2024 18:01:27 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 4/8] drivers: mtd: nand: Add qpic_common API file
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
 <20240521105532.1537845-5-quic_mdalam@quicinc.com>
 <38517491-678e-4aba-ad5a-f7cb7519ef1c@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <38517491-678e-4aba-ad5a-f7cb7519ef1c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L6mg3MFywzwiotuHjWfx-Ee_7MeP3vZ4
X-Proofpoint-GUID: L6mg3MFywzwiotuHjWfx-Ee_7MeP3vZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=802 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210094



On 5/21/2024 5:24 PM, Krzysztof Kozlowski wrote:
> On 21/05/2024 12:55, Md Sadre Alam wrote:
>> Add qpic_common.c file which hold all the common
>> qpic APIs which will be used by both qpic raw nand
>> driver and qpic spi nand driver.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>> Change in [v6]
>>
> 
> This is v6, but you still keep prefixing in the subject as "drivers".
> Drop it finally from all your patches.
  Sorry, Will correct in next patch.
> 
> Best regards,
> Krzysztof
> 

