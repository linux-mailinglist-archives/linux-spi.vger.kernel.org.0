Return-Path: <linux-spi+bounces-5285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7799A722F
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 20:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8502B217D5
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFC1F8936;
	Mon, 21 Oct 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hRo1sqyS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230781C3F04;
	Mon, 21 Oct 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534812; cv=none; b=cNZ4yqnOfpUD3Z59zCJ97J5yPPhBOc6HnQGKVEWK9TqXtiqrA91o5U+tAKRsnzdksAZo/6DdaqCVF3vKFenQ7m5gASjxUeeReX7RQAAQ2P2sSdfLsuIXgszoKj+X/IlTJWXNhBxthLEWzjwr8igi6K95irocYXwZGImnkW5+8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534812; c=relaxed/simple;
	bh=GlPX+KtWJH8I2hdfrLtHvDpj0eL7bZVupSjgXXp60UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tN60JtpKZjMyAyWN/F0Z8zlSytPZJjv806mapNRj87Myqm4mC5lJO0I9cjJTAjRByC/phswIOSPeV1xoqRj7rsWf4Kwa+S1BaQBP3Mu0Qfy4uvXm6NzbFPUz2PP5Miwc856ptS+ukNBrl8qFiSyoeyWDJDxZl7vD9oWt9D/+lD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hRo1sqyS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LAlHxI012350;
	Mon, 21 Oct 2024 18:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SBA+LZg+3ZcEFM0R25WL7du5150FkxKzdf/CXN7CqTw=; b=hRo1sqySidl/ke6w
	iyVKvIz0X/kv2WlSF6PhnbYa6s3PzZZp0iLrwpvN5JmcUuaMQjAxD9hA8X7IW9n8
	NVUuTENN4q5t+TeyhR8CDazj4q6txde2xen6+IJivYPIhHbtWPgOKq6l0WvlpuMN
	vqq7Ro5egzaUyyHIJMUUh82HdwwHPDgKhd9ji5VivL3vJbYGK9Ma5QHDb/hMCCD6
	O7IeBGdCCeePxxQr4Wg3i2Mc0N0gVjpWWhBZbBnYHmGZcp3xJausw734lWL4+ZVa
	SZRYyy491JDshNmnP+SKHj5ac7Hni0xG6s/OQn6DUQcjLXzSF/AuhpQ3rpjvA8ts
	jfNXlA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6tsnm7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 18:19:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LIJZxQ012413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 18:19:35 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 11:19:35 -0700
Message-ID: <41db541a-4de1-409b-bfec-7b9456fc200f@quicinc.com>
Date: Mon, 21 Oct 2024 11:19:34 -0700
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
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241021115620.1616617-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SD8HV_K6uhAb3197RF7-KumeTaXLtH8X
X-Proofpoint-ORIG-GUID: SD8HV_K6uhAb3197RF7-KumeTaXLtH8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=977 phishscore=0 adultscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210132

On 10/21/24 04:56, Md Sadre Alam wrote:
...
> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
> new file mode 100644
> index 000000000000..570ab59ca12b
> --- /dev/null
> +++ b/drivers/mtd/nand/qpic_common.c
> @@ -0,0 +1,757 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.

I'm surprised you aren't adding a 2024 Qualcomm Innovation Center copyright 
...
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
(if any) are left, so please don't introduce a new one :)

Please add the missing MODULE_DESCRIPTION()


