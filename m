Return-Path: <linux-spi+bounces-4530-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A996A04F
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D5E1C23332
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0D13CFA5;
	Tue,  3 Sep 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPkkoc7b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B813F43B;
	Tue,  3 Sep 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373378; cv=none; b=HZVdl6Ys0KurK8Vp5k2OeM4g6I44FvwmdOwK7jBB7KXWiUN9pKdjuVmEb/Cfh05xzQ28JDXFZAoU5ciYqAPj+/ZFS6AJI5zLrpWIwzRvk7l4Tnsm07FxvJL+7K4reGPRRLV+/TINEB+/hOEVu9eZ3NCtO0b8Hgsktvik6X+LVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373378; c=relaxed/simple;
	bh=2G38JyYAiYuwQ/PJ/PSFTe3pd18vrq+YXe8lpCcykEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qaSyOhI2zF0C00NP3FBO7X4B2WtIMc55dqEnkuU/1UD462IaUeuhlGdXEJlfe1hS/vo+37a8ZXTP467CRUuAJDalnEvGnJIFBjhHD8SWY0rCmxLzI5yg4wLZNqcDecIFM4d1wwbgsVWzuwfVTbd1JYwQwPQRbdEtiANnxKJOXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPkkoc7b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483BJZQO018884;
	Tue, 3 Sep 2024 14:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5X5QFp29hmQ7by+9qCpUoFC+TAzM7t4IqLCLAuIpOTE=; b=gPkkoc7bp40UJapE
	X7PfAT3pqWVLbGb4bc5RujGXS38oqPup31do8NZhBRKgJaZrF7wtDgwOn0cKtw4/
	LOpxMnAXbrtTQpnjaQGn3cE2BwkDD2T5icoOuVZ7b8hCFaJSQNsC5eyrmtcKHDZU
	zNeJgMUY+hVcYaqYZLoAlzCb5IPlACFatRyB6nHTmA/SrM37pXDfeT2O4jNUzvZm
	VascZVMDjj0x52vFsR5GoIZuGxz9hOwr8OaXSppbbuTaGdETjcqqHCxSzA4qD23T
	W3E01byOSK9p/FZDZqrdBpwJ1z7nRo/1c/29VN8BDjKSTECdBijq3BtRaKBWXkhx
	blbwLQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt4rfnra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 14:22:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 483EMYMt025782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 14:22:34 GMT
Received: from [10.216.9.110] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 07:22:29 -0700
Message-ID: <57a810e0-c072-7792-1f5f-3ddbeb0c97a3@quicinc.com>
Date: Tue, 3 Sep 2024 19:52:25 +0530
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
To: Krzysztof Kozlowski <krzk@kernel.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
 <5169761b-422d-70ab-ba53-a898cb7bfa2f@quicinc.com>
 <fed18a8f-446f-4d61-a9ce-4c5e09bf0aaa@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <fed18a8f-446f-4d61-a9ce-4c5e09bf0aaa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rttAid4ooQgcOR3iwRLcnkjL--9ZVPR3
X-Proofpoint-ORIG-GUID: rttAid4ooQgcOR3iwRLcnkjL--9ZVPR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030117



On 9/3/2024 7:14 PM, Krzysztof Kozlowski wrote:
> On 03/09/2024 11:15, Md Sadre Alam wrote:
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
> Two weeks ago you received reports that your code does not build
> properly. So no, it is not fine. Please respond to the reports and/or
> send corrected code.
   Sorry I missed it, will fix and post next revision.
> 
> Best regards,
> Krzysztof
> 

