Return-Path: <linux-spi+bounces-5690-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3D9C6C30
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 10:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EACE28B8B0
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98121FA84D;
	Wed, 13 Nov 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fQNHDJuv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D01F9A8A;
	Wed, 13 Nov 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491807; cv=none; b=bKfFa3jim+U1In8ThG+7kFxcZeUxX4Aa+S6GzfCb1V/3Huu2w7+cc42270ITWp7aeqWOBJ1d5C3XtTdnR9BRs5QTzNiRbX3upSpNP4wz97LFfXI1GzBJ8VN0Wl/Aad0w6xzRHH2TquDuN9ViySdXY1+HtGI2jK5zdDGvDT6QccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491807; c=relaxed/simple;
	bh=QNkWweQcIEY/zPAKNEy904/QZRONi9TgTrBv8B2e3FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SWy6LZX6Ay4mCH1IJXN+f88lIo9rXmVUGVv+b0kwdFYdef7pTVDK4aOQZRAHZSH+Oyx0xIT37L7Q3GrJzzLI5TlM9MeP6K8WiroaeFXwwgNUY4hLDWzRU6jvMCZFRJgxyQ5gSEwhEKiSYed/n6Fy4NPc7FtgK3X0Z88f2nATmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fQNHDJuv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9bKUY017153;
	Wed, 13 Nov 2024 09:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EvNtgJl1mKwo5mTwwA6QMCNpCNq78hZ69wzyqL9tjcU=; b=fQNHDJuvtZDg+djr
	h5/WkaNSN5ROcLPUQlkSdcMwLFr4XdVJ+rFW1dB1uOUQulffdZCs0gssxu8FuzFb
	ucSYsj4bFTiY1FueLJdgIJQBlFA/eXKDUhFtShAnfHs/xw8jx99Dk9YKhFnPtUK0
	+vuFTILkIn3Ng9auJn/kvRW7lakeWJT/LsDx/MpNNH5XkjIaw4WXVWcxdlmFInOC
	UUzmOc9t4Fxpe+QininPD5H8fSYxB3jcBF+LWOgl21L5QX2hbWguVDSj0yzHxmR7
	CqT9AnDbb519mei4NOArvK7BDutR3FezxLB9pvlbh7YTGLZs+m2kk0wcSXzf/39r
	7GxI0w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t118ab9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 09:56:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD9uXG6017805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 09:56:33 GMT
Received: from [10.152.197.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 01:56:28 -0800
Message-ID: <cdd25fe8-3d12-7460-93e8-a18dd121dc49@quicinc.com>
Date: Wed, 13 Nov 2024 15:26:25 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v13 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241030121919.865716-1-quic_mdalam@quicinc.com>
 <20241030121919.865716-3-quic_mdalam@quicinc.com>
 <871pzh397j.fsf@bootlin.com>
 <374ea155-0970-38bd-470f-cc440ca0bab5@quicinc.com>
 <87bjyjsds3.fsf@bootlin.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <87bjyjsds3.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: isZzNuTSru7Tk9uTY21uYlkwmy7yDKwh
X-Proofpoint-GUID: isZzNuTSru7Tk9uTY21uYlkwmy7yDKwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=976 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130087



On 11/13/2024 2:37 PM, Miquel Raynal wrote:
> Hello,
> 
> On 12/11/2024 at 17:45:07 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
> 
>> On 11/12/2024 12:00 AM, Miquel Raynal wrote:
>>> On 30/10/2024 at 17:49:13 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>>>
>>>> cleanup qcom_nandc driver as below
>>> Perform a global cleanup of the Qualcomm NAND controller driver with
>>> the
>>> following improvements:
>> Ok
>>>>
>>>> - Remove register value indirection api
>>> API
>> Ok
>>>
>>>>
>>>> - Remove set_reg() api
>>> API
>> Ok
>>>
>>>>
>>>> - Convert read_loc_first & read_loc_last macro to function
>>> functions
>> Ok
>>>
>>>>
>>>> - Renamed multiple variables
>>> Rename
>> Ok
> 
> In general when the main answer is "okay", you can probably just say a
> sentence like "thanks for the comments I'll take them into account",
> without answering to each and every comment. This way, it will be easier
> for me to catch if you have further remarks.
Sorry, I will take care this from next revision onward.
> 
> 
> Thanks,
> Miquèl

