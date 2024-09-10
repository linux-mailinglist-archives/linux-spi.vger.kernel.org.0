Return-Path: <linux-spi+bounces-4762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF75972973
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 08:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5451C23E0F
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 06:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6A175D5A;
	Tue, 10 Sep 2024 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IORkB/U2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A81386DF;
	Tue, 10 Sep 2024 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949349; cv=none; b=Qz8fJwZW1o9vV4EBAy72PJ/4BqPU0lYBvga8IO+v+czVacJpj0PjVKmzGTlWNm7sReSfy/Uy05nAHdR7aQyPYfupq1POziFqIe0TpI4R6+rB8QjzvuYl62uNWIcUdMgzFFrDSuMmZTrYC6b4si/htW/Lka9o1kV9jAfFX6pLIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949349; c=relaxed/simple;
	bh=wDXVRRb9fFqnNG/e2J9iPFDPeNe6iKxKjeCSX7UbCTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OuzK2F5ttW8VYItjRBjqlYHG1AS2iS/55AcU5N0E6o4awoI1UYipHUfLxuNUUM14A7n7e4jHjDEu6tHo1heNXReJX/NS+0SvSNIBti9AoHYAPAuAnsbVs9pLpxLWKIwkoYQDZxqB2K2kKzzPEM2q4qZBmQ84dsLkM86/ycM8HHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IORkB/U2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A3mI8H028083;
	Tue, 10 Sep 2024 06:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	abGkKzVbCFyg6JdPil4boqV7m6mzwnRG4sSLRPcCDkU=; b=IORkB/U2GEXb5SAd
	66NTftFHUvLgYmCnfdAD/rUZJIng9zk7Ay7VZDHzvF2ooDb3IJY3yUpe+Xz71Np7
	zthM8eHN040D1RS+y8Un161tvNpUB2SNERtDQ8da+bV0DD3YxawDt1Sx/9HokC6T
	C/qkPCUC0MZKnYYnPCurNyXQJSh9cjNPtPEug7g7dCXF4cvXWaS4YSH3MG/bqi4x
	dPuDsheJcb/JlUIrMk+ky1UJ/bl0q1nq6wqNXf8rLYWQj34EmNNH1v78Tr/u+u+z
	vLpCA+Jcvuyh+VqsGeV1WWORXSNwnZUztETDrVe04CgP1+g3qrpHw6iEG5z3wonP
	PEeFGQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5rcwjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 06:21:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48A6LiPU025302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 06:21:44 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 23:21:39 -0700
Message-ID: <bb1397c3-2327-e211-f7eb-cac4b126424e@quicinc.com>
Date: Tue, 10 Sep 2024 11:51:27 +0530
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
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240903150826.749b8560@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mRLGbG3WlngwSJ0VTAdjQSQVj9PbpP2f
X-Proofpoint-ORIG-GUID: mRLGbG3WlngwSJ0VTAdjQSQVj9PbpP2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409100046



On 9/3/2024 6:38 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Tue, 3 Sep 2024 14:45:15 +0530:
> 
>> Hi Miquel,
>>
>> On 8/20/2024 4:12 PM, Md Sadre Alam wrote:
>>> v8:
>>>    * Fixed compilation warning reported by kernel test robot
>>>    * Added "chip" description in nandc_set_read_loc_first()
>>>    * Added "chip" description" in nandc_set_read_loc_last()
>>>    * Changed data type of read_location0, read_location1,
>>>      read_location2, read_location3, addr0, addr1, cmd, cfg0,
>>>      cfg1, ecc_bch_cfg, ecc_buf_cfg, clrflashstatus, clrreadstatus,
>>>      orig_cmd1, orig_vld to __le32 to fix compilation warning.
>>>    * Included bitfield.h header file in spi-qpic-snand.c to
>>>      fix compilation warning
>>>    * Removed unused variable "steps" variable from
>>>      qcom_spi_ecc_init_ctx_pipelined()
>>>    
>>       I have addressed your comments to v6 and further posted till v8.
>>       Could you please let me know if this is fine.
>>       and how to get this merged ?
> 
> There are still kernel test robot reports, so this means there are
> issues in your code that I don't need to point out explicitly, but I am
> actively waiting for them to be fixed.

I have fixed most of the sparse warnings after converting __le32 to u32.
However am not able to address the following sparse warnings

	drivers/mtd/nand/raw/qcom_nandc.c:1401:29: sparse: warning: cast to restricted __le32
	drivers/mtd/nand/raw/qcom_nandc.c:1587:30: sparse: warning: cast to restricted __le32
	drivers/mtd/nand/raw/qcom_nandc.c:1588:31: sparse: warning: cast to restricted __le32
	drivers/mtd/nand/raw/qcom_nandc.c:1589:34: sparse: warning: cast to restricted __le32
	drivers/mtd/nand/raw/qcom_nandc.c:2479:47: sparse:    got restricted __le32 [usertype]
	drivers/mtd/nand/raw/qcom_nandc.c:2480:47: sparse:    got restricted __le32 [usertype]
	drivers/mtd/nand/raw/qcom_nandc.c:2616:25: sparse: warning: cast to restricted __le32
	drivers/mtd/nand/raw/qcom_nandc.c:2672:32: sparse: warning: cast to restricted __le32

These warnings are seen with existing kernel code too. For example

	drivers/mtd/ftl.c:299:39: sparse: warning: cast to restricted __le32
	drivers/mtd/ftl.c:387:23: sparse:    got restricted __le32 [usertype]

Hence, can these be ignored as false positives and post the next version of the patches.
Kindly advice.

Thanks
Alam

