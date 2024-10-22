Return-Path: <linux-spi+bounces-5292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95949A97F9
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 06:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540BA1F23EF1
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 04:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9B126BE2;
	Tue, 22 Oct 2024 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OQQ4nnyB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7B811EB;
	Tue, 22 Oct 2024 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729572003; cv=none; b=CpAd+cpYo4LOmYxmcVw3nCAzMG6osbfXhJOY/eKjeoHU7UT1vB92ajI+3ZnI9s0G/wTc3uFSBvzAY1nze0uP9iresTSslYdNsE9pYKZZEGHsTFPHTKIJBmdDwuHbwKZ7451DZYCPzCxQn+8I3XPRICMw4vwmVxsimyGuVlvceTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729572003; c=relaxed/simple;
	bh=zZcSs9LEMsjftqsO8zJH6e/5d9NYY/akuamUM8cOyZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pPVhOveRxgtsnrH5i9yGs7JahTqYgznt+YRvF/dEK1wmjGXLZegSm5QaKmF0s13yAyBgjZIe9j9Bj/Z9v7yzWQ32rKjTmhCKbBWfpenRBJcyQ9AnNFYhKkivGsd42ZUDsmWRhgLE1nCpsiqBR1ZWib2hmqaXsTQ5DmxRU8WmvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OQQ4nnyB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LF7vdw009626;
	Tue, 22 Oct 2024 04:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r6QzmzQaHek9p4OE1LFO1rZiLxLngWirJKOlqZoBv+Q=; b=OQQ4nnyB06FSfWL+
	aEuLCZLrBx2FhPl8wlnYNl05ErIqZKaDyxmyoB0KjwFFMBXws7Avu458bfvRr3ww
	Gco2i/PK+yfkjPQ5tf2pQCdG3uGpia3Njs12cb+sJK6VE96Q+Nc/wF7etchEHVJB
	hvbiTFltOMSkn7Cs7yWoLkDnCHTPm4z9HyCoDt7htLwZFJpjnGQQzsxTmoFG4We4
	gmFpXjqpEHCu41nlg4kmOzkUqh075h+2Ll1HMA+9ep/6GJtLooSirhhHkEw+P6Df
	fcVF57QgO8bjhM0zo1qRZDrkF/cs06V90sczMa2dNrGIVYxrx6y1h9IQlerC7ST3
	zWDa8A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkbt35xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 04:39:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49M4dngR026627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 04:39:49 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 21:39:43 -0700
Message-ID: <4c239c07-799c-b910-c6e0-ff717202ceb0@quicinc.com>
Date: Tue, 22 Oct 2024 10:09:34 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v12 4/8] mtd: nand: Add qpic_common API file
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
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <41db541a-4de1-409b-bfec-7b9456fc200f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B7wAcqzBYy_1DaTih_1VAdrhkXLM0nYO
X-Proofpoint-GUID: B7wAcqzBYy_1DaTih_1VAdrhkXLM0nYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410220029



On 10/21/2024 11:49 PM, Jeff Johnson wrote:
> On 10/21/24 04:56, Md Sadre Alam wrote:
> ...
>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>> new file mode 100644
>> index 000000000000..570ab59ca12b
>> --- /dev/null
>> +++ b/drivers/mtd/nand/qpic_common.c
>> @@ -0,0 +1,757 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> 
> I'm surprised you aren't adding a 2024 Qualcomm Innovation Center copyright
qpic_common.c file is derived from drivers/mtd/nand/raw/qcom_nandc.c file
so I am retaining the Copyright from the drivers/mtd/nand/raw/qcom_nandc.c file
> ...
>> +MODULE_LICENSE("GPL");
> 
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning when built with make W=1. Recently, multiple
> developers have been eradicating these warnings treewide, and very few
> (if any) are left, so please don't introduce a new one :)
> 
> Please add the missing MODULE_DESCRIPTION()
Sorry I missed it. Will add in next revision.

> 

