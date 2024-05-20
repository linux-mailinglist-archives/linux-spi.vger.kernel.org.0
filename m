Return-Path: <linux-spi+bounces-2953-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 523718C9AC0
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4EE282035
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEAF47A7A;
	Mon, 20 May 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ktDKSq+W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094DA47779;
	Mon, 20 May 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198700; cv=none; b=mE+HlusSgwTf+1CREDYb7Q+UxD1nXcasYX10UfTU1OHAfbbNzNcqD3y1ZgJ4+Rz2dp9fFHoOb58Ave5SyuSibngAF1bFf3f3EIfc41Z0eddbrhxZ3YdaqHn0WnSZ+OyawrcxZqbcp0g21ohDRcsGH2eaj1FpIPHGZ+/HCsFlESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198700; c=relaxed/simple;
	bh=XRgWOtcIoHqLBtXGmoLLWNbN1o7CmTKZka71BkWzrMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X9chdF/rmBQd5075LTRH/jdcrUnn649G9vjKdJuma/hzRbejr4edlr0g/OHnu0ErMSxOX6qbsAb1FaV+2NHbdv9DRVQcnCONQ1oxO8CES4hdJVHTEdwOmmWq0PSoMz9g+YNIzfQzSUl3GaR1LV2qvJ/kYuINETrcDkLEs4R5EHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ktDKSq+W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K0Hoxb025938;
	Mon, 20 May 2024 09:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SLkGXQQ/Q4Is1uX4318tZb1aH/Kcs5rkYvuM2oRuifI=; b=kt
	DKSq+WnfbehDvoQJQnbL+nhH8hFh2oxLmWBg8qKoNe7aSfZ2Qid16SmdWZVNbNQg
	IVpmK6rH0is8/3k1pAOBVcotjeH5DXfng4/N40+cRj90L2t42krAdEBR9rNyRtJ/
	gM+hFhqzHcXteRfwX/TKNAZmnbPcgoC8CSvJhNjVey08HklFUYZLdHcfFULav2fu
	TjLjJhTid5CdDFroWK5Mb/tEvq8te8HCyIkCdXcomehEdPp5YgFOQTqAujTz11OP
	M8hupB3sbxeYWufKx1AT1/zYmozhddUW4UwZVy2wNJCv1QDdQJXYs49wK8Zisjm9
	vLaK1wwABmx8TD2oC9kw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6psnatm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 09:51:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K9pIES010746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 09:51:18 GMT
Received: from [10.216.4.5] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 02:51:12 -0700
Message-ID: <349190aa-9569-f3cc-ef3c-d8561ddf0a51@quicinc.com>
Date: Mon, 20 May 2024 15:21:00 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 4/7] drivers: mtd: nand: Add qpic_common API file
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
 <20240508083637.3744003-5-quic_mdalam@quicinc.com>
 <20240516143748.2aa6de80@xps-13>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240516143748.2aa6de80@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7PiPCh_Xeb0pAiPh_uzfqDxrBeHKIP4c
X-Proofpoint-ORIG-GUID: 7PiPCh_Xeb0pAiPh_uzfqDxrBeHKIP4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200081



On 5/16/2024 6:07 PM, Miquel Raynal wrote:
> Hello,
> 
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -61,6 +61,14 @@ config MTD_NAND_ECC_MEDIATEK
>>   	help
>>   	  This enables support for the hardware ECC engine from Mediatek.
>>   
>> +config QPIC_COMMON
>> +	tristate "QPIC common api file"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  This enables support for common api for qpic nand controller.
>> +	  common apis will be used by both raw nand driver and serial nand
>> +	  driver.
> 
> This should probably not be a standalone selectable item. Make it
> automatically selected by the users including the common header.
  Ok.
> 
>> +
>>   endmenu
>>   
>>   endmenu
>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
>> index 19e1291ac4d5..c0c1f8bd0220 100644
>> --- a/drivers/mtd/nand/Makefile
>> +++ b/drivers/mtd/nand/Makefile
>> @@ -3,6 +3,7 @@
>>   nandcore-objs := core.o bbt.o
>>   obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>>   obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
>> +obj-$(CONFIG_QPIC_COMMON) += qpic_common.o
>>   
>>   obj-y	+= onenand/
>>   obj-y	+= raw/
>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>> new file mode 100644
>> index 000000000000..d48892141365
>> --- /dev/null
>> +++ b/drivers/mtd/nand/qpic_common.c
>> @@ -0,0 +1,741 @@
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
>> +#include <linux/mtd/rawnand.h>
> 
> No raw NAND include in the common file. If there is something raw NAND
> specific, it should not be here.
Ok , will fix in next patch
> 
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/mtd/nand-qpic-common.h>
> 
> Thanks,
> Miquèl

