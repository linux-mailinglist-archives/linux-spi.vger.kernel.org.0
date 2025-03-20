Return-Path: <linux-spi+bounces-7240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A83A69FAD
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 07:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326EF188EA81
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4751DF75A;
	Thu, 20 Mar 2025 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fxv0Z96L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A71DE3C8;
	Thu, 20 Mar 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742451045; cv=none; b=ju1ZsoMY9KAhbscA9s3dcS8AmAfl1C83TOMyGWfZEuSG8ob2EmUa6dPmWuyl1rCKhVQ54WghLYewwo198RlwyoldzzupetsnGyOOO01pRoVnUf5tm4lYEi15a9G7f/obnAfjWU/n4klplsQebIcUG7AbzPZsEFNdOehAKAVNvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742451045; c=relaxed/simple;
	bh=cRvXadQhTIbI/HCZTrRb2irH8HzK+S9QjjRBXGbrNho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AvaY18njRwZF9Md4dYTENJ7BUb5X4EpwppFxDi9bVpa2YqKn/WbsZpdaruJXdKwYQQHhm++3f6CludxW4a3/Z0+K68jFzhWk6UMBmC2Ro1MswE3Me8opwWEt/kaqC9vuOs6kvcRfhLL1DSeGB9NV8nWnpQHOS8PUR23NSyBJ+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fxv0Z96L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JG7ScR031123;
	Thu, 20 Mar 2025 06:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dhvEbu/B7DlqECBAv+uD+Fcyi6AFMHzfPm0rMbXagJ4=; b=Fxv0Z96LCoP9szKQ
	0XyJeFpDVRBBQvO4w+PdFwZNaskhMpLuW//0KdgTLAWjYhjQeTeO+FvjXAx1kl6A
	Lv4mNmmwTT0dHaDcXb4k6n6aCcGmzf27YaHRROGD3QJEOCHSdcjNjU/VLgYlol/O
	rp5xDU6wzzMOJ65BbjWXvHH9L1BQFP1LiYSjYPKzyFDy1Ajs02u1Si2LVEq3kPc7
	Wa+3B+TqbZdSv5l/wgT3Hco/Qnlmn/+RT/1f2IraSMxZi1/uvBN5K/3Hl0REYpPJ
	pmNIllqm315GtuiuAD5lai0vyxT4EHlaSbWLsJgcHYFKAuwcgzrvDKORAplbEHvM
	1NRbTg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y1sy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 06:10:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52K6AVHf027244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 06:10:31 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 23:10:27 -0700
Message-ID: <22ebf40e-a9ff-32ef-2d45-8077c915d2e8@quicinc.com>
Date: Thu, 20 Mar 2025 11:40:23 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/4] spi: spi-qpic-snand: set nandc_offset for ipq9574
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-5-quic_mdalam@quicinc.com>
 <a72f0db0-fd49-4cff-bffe-671fc757a219@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <a72f0db0-fd49-4cff-bffe-671fc757a219@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h-yF-uVW3wrLsLZDyljNUNKUnWF8Klm5
X-Proofpoint-ORIG-GUID: h-yF-uVW3wrLsLZDyljNUNKUnWF8Klm5
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67dbb158 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=YrGrCH_7GMspvEpCFK4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200037



On 3/18/2025 8:28 PM, Gabor Juhos wrote:
> 2025. 03. 10. 13:09 keltezéssel, Md Sadre Alam írta:
>> The BAM block expects NAND register addresses to be computed based on
>> the NAND register offset from QPIC base. This value is 0x30000 for
>> ipq9574. Update the 'nandc_offset' value in the qcom_nandc_props
>> appropriately.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v3]
>>
>> * Added nand_offset for proper address calculation
>>    for newer Socs
>>
>> Change in [v2]
>>
>> * This patch was not part of v2
>>
>> Change in [v1]
>>
>> * This patch was not part of v1
>>
>>   drivers/spi/spi-qpic-snand.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
>> index 8c413a6a5152..85a742e21cf9 100644
>> --- a/drivers/spi/spi-qpic-snand.c
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -1604,6 +1604,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
>>   static const struct qcom_nandc_props ipq9574_snandc_props = {
>>   	.dev_cmd_reg_start = 0x7000,
>>   	.supports_bam = true,
>> +	.nandc_offset = 0x30000,
>>   };
> 
> Applying the first patch alone results in the following error on IPQ9574:
> 
> [    3.596403] qcom_snand 79b0000.spi: failure in submitting cmd descriptor
> [    3.596490] spi-nand spi0.0: probe with driver spi-nand failed with error -110
> 
> So this change should be integrated into the first patch. Otherwise, SPI NAND
> support would be broken on IPQ9574 temporarily between the first and the
> current patch.
Ok, will integrate this in first patch in next revision.
> 
> Regards,
> Gabor

