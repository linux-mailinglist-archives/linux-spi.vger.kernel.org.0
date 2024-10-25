Return-Path: <linux-spi+bounces-5499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0E9B0D46
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 20:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6464B250DD
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C7E21441C;
	Fri, 25 Oct 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ccnyI1/p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBDB20BB5A;
	Fri, 25 Oct 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880893; cv=none; b=FEUWuYwuNkEFUHJrZdVQfiyYJzmUgUQf7r4Cd77ZP2QFutowmnyXK3Atxlq9xFGLoqkNmoUQe5wsPTH/dBWo79hhUxUhfyyCqNcwtQg7nhES6TJBLVig4pVZ5koXPM6Zo2H+u0CJNBqdZLitUH6DQfHgJkJ3nqIjMbGEDgZxeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880893; c=relaxed/simple;
	bh=ETXMGUI5eB1KH5XNFeYeE4GITMkh3IF+X6s9NRMijaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LL33lZs4Qq8Y9+uJYyy+Ii/Df++AzhOS1usZnC65GukXBLmiuwrWJIqJY5/PU7q0hUfxxLjEfTYuIirwX5P9vmcpZDHn2WWK+lxKd3s+RO5mVnN/DxyxnDFxEhxH4jzq/7gKlM/nEC4CUwpG2PsgsqJppIwzywb04mP7lLzvWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ccnyI1/p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAoKw8006951;
	Fri, 25 Oct 2024 18:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aeiIjuiCiGELOTopIbo//bFGGETMmV3/7Vt9PUQCGes=; b=ccnyI1/pESHfxTj4
	rE6uXuGv6QJh7vDzeWCAAWpgG4NwA9BM/xR1AHNbGYf/zgYVfZ4YWyameaCJsQak
	ZKsq8SldZDHOR7+D5lcZQD3nzxlfPNzukq7ShECkaB4XjrcNIhcmqh+YrXlR4B90
	okW/dvrE0yHVySq7Snza/XR+GdnzwaoqZN5FOFuXK/KgqjYMqXYohXSH+BKpwkY5
	JFsrmpFl8y7WXzG6OwPxOHqpgZnAeGhMWzX89dxBHdtV6SrLtVHJEfxmcuv4rdel
	WaZOdwL6mAb8aA1v6nklThvvuO6SUChjmd7HP64mlT6Nf9vdJC7YLUxJViRQ2TUr
	kqftHQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g9x6hdgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 18:27:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PIRmIl000467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 18:27:48 GMT
Received: from [10.48.242.80] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 11:27:47 -0700
Message-ID: <dcdd870b-c4b8-4bb8-9c08-82474cc4d872@quicinc.com>
Date: Fri, 25 Oct 2024 11:27:46 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/8] mtd: nand: Add qpic_common API file
To: Md Sadre Alam <quic_mdalam@quicinc.com>, <broonie@kernel.org>,
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
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <4c239c07-799c-b910-c6e0-ff717202ceb0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5w8o4jkyHpExRaVzhFBXGbmxhFScf2MC
X-Proofpoint-ORIG-GUID: 5w8o4jkyHpExRaVzhFBXGbmxhFScf2MC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=885 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250141

On 10/21/2024 9:39 PM, Md Sadre Alam wrote:
> 
> 
> On 10/21/2024 11:49 PM, Jeff Johnson wrote:
>> On 10/21/24 04:56, Md Sadre Alam wrote:
>> ...
>>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>>> new file mode 100644
>>> index 000000000000..570ab59ca12b
>>> --- /dev/null
>>> +++ b/drivers/mtd/nand/qpic_common.c
>>> @@ -0,0 +1,757 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
>>
>> I'm surprised you aren't adding a 2024 Qualcomm Innovation Center copyright
> qpic_common.c file is derived from drivers/mtd/nand/raw/qcom_nandc.c file
> so I am retaining the Copyright from the drivers/mtd/nand/raw/qcom_nandc.c file

If you have a derived file then you should retain the copyright of the
original but then also add current copyright for all changes made on top of
the original file.


