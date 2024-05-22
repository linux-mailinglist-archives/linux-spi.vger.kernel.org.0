Return-Path: <linux-spi+bounces-2988-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB3D8CBAF8
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 08:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE7B21542
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 06:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BB7580A;
	Wed, 22 May 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VfcFxf9c"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FF1C6B4;
	Wed, 22 May 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358167; cv=none; b=KGWyssh+xrx/zpx2FOj9yLJAzS12kTEOY1FMjuY1uSud8VAqvTfg8xzuxwnaKzN4OYCZ8Ykhiw8yZxeqJVaOvWYrKPvJxyIwS2wsGFGv3nfkSXj8D5E7gEZHgoHf550YnP94ASm051b2qsQnSKOGzKH3WGlc5+N/RXeUt034V2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358167; c=relaxed/simple;
	bh=RHJzBZKBYDregnPcMEAoO1XuZcME3KtgeKMDPxPVhZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iiImxYZ64UhYfBWuwh3SoiasYGo0Qn+OloElUwO3+yJtcu1UiK3i43yoVGwA7lrIoJpBy/+RXbd4OBndUOLcbTzfs7PDqq41UCMKW6rZSc4K/xmNJJmxTZKYOfvDZKyddKrRju6MYOASGCl1sydyvT9tpUNYeCOQoblwj31G0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VfcFxf9c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LNaRHs019181;
	Wed, 22 May 2024 06:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=76X18h8ZdxGj97syQ3G8X16mJAi6U8JWctpGW0mNnGM=; b=Vf
	cFxf9cRRjiPYJwdfkeRQkRxSwgXWdNCY0Wwdh+iQhCGEXlUEdMXe6DNkBTRLEGFw
	GLqAKJed9gNHi7Jlqn+rWm2qu70L955pYwSaNK7E7w1+Gn5Kc/IkC9fNO0XRxeZ7
	cFFeQ5SXKQD+23ibg0D8s3UJR0QcCYlgRM+lg3PqAB1Wl9UF4MO0LedTYPDv6E/k
	GWVDc0DUsrtFCLqf0s9Uv7tS8Q7wzQUNN6omCr9LVPF4lr14F7oIdyg4hYLHrAqL
	7/mh/8Co35rimFPifRFmpjU355JYMVG4OH5glBdq1ByV5eGIuadp2UppMVGmmTfb
	4K+yiTfP5GBLaYbh2NlA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gfyeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 06:08:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44M68rYs023009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 06:08:53 GMT
Received: from [10.216.52.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 23:08:48 -0700
Message-ID: <1eaa6f78-07d8-25e7-2e00-1284dd37f761@quicinc.com>
Date: Wed, 22 May 2024 11:38:37 +0530
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
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
 <20240521105532.1537845-5-quic_mdalam@quicinc.com>
 <20240521145140.5cb49946@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240521145140.5cb49946@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aUN5v4k1sl7V4N9StjvzU3eaRECy46JR
X-Proofpoint-ORIG-GUID: aUN5v4k1sl7V4N9StjvzU3eaRECy46JR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_02,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220043



On 5/21/2024 6:21 PM, Miquel Raynal wrote:
> Hi,
> 
>>   drivers/mtd/nand/Makefile            |    4 +-
>>   drivers/mtd/nand/qpic_common.c       |  740 +++++++++++++++++
>>   drivers/mtd/nand/raw/qcom_nandc.c    | 1090 +-------------------------
>>   include/linux/mtd/nand-qpic-common.h |  467 +++++++++++
>>   4 files changed, 1222 insertions(+), 1079 deletions(-)
>>   create mode 100644 drivers/mtd/nand/qpic_common.c
>>   create mode 100644 include/linux/mtd/nand-qpic-common.h
>>
>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
>> index 19e1291ac4d5..e59106e0a3af 100644
>> --- a/drivers/mtd/nand/Makefile
>> +++ b/drivers/mtd/nand/Makefile
>> @@ -3,7 +3,9 @@
>>   nandcore-objs := core.o bbt.o
>>   obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>>   obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
>> -
>> +ifeq ($(CONFIG_MTD_NAND_QCOM),y)
>> +obj-y	+= qpic_common.o
>> +endif
> 
> Breaks if you set CONFIG_MTD_NAND_QCOM = m
  Ok , will fix in next patch.
> 
>>   obj-y	+= onenand/
>>   obj-y	+= raw/
>>   obj-y	+= spi/
>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>> new file mode 100644
>> index 000000000000..dfbbb5f626b6
>> --- /dev/null
>> +++ b/drivers/mtd/nand/qpic_common.c
>> @@ -0,0 +1,740 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
>> + */
>> +#include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dma/qcom_adm.h>
>> +#include <linux/dma/qcom_bam_dma.h>
>> +#include <linux/module.h>
>> +#include <linux/mtd/partitions.h>
> 
> Didn't you say you would remove that include?
  Sorry, missed it , will fix in next patch.
> 
> Thanks,
> Miquèl

