Return-Path: <linux-spi+bounces-7239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC2CA69FA0
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 06:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8AB46376F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 05:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4091E0E00;
	Thu, 20 Mar 2025 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfd/H9w/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5D17A2E2;
	Thu, 20 Mar 2025 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742450361; cv=none; b=Zvgtfgi6P9FjvV2Wza/ieo/R8/M4wC+oxVIwh6/Td/IsfwVP+jHIxKZ3Cs4cC2Ncb+9wlQIynH3J5Ybz2KfS5qudXLPQr+0T8pJQ4UVRnsa1E8TBUbRXkdfZ/GcoA7DT40O5dGJBBxlyXGd518xDVIvrYWMXsmh4ThV2tksAE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742450361; c=relaxed/simple;
	bh=6wOHqHyaAYl2OOgUVQ27dvXcl/fHn1Ol0duojZbcTJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ky7pnry6hoEq8oERsYv84zXZJo+8rqW45jOY2dCM/+trmmg1Vl3hARjDyWxUTFYiYZEP/hZUcq/TkuztIiOfcdenSb+qypMIb9t5V7qIOOgIue6sJEXe8s/RKlgZVd+OWVWYn+VeB90imjDOC/yYPuVjBAIT+Zq83/5F2sIob8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cfd/H9w/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K4rwmg021621;
	Thu, 20 Mar 2025 05:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nfn6s62Sd9gS4WebcWOa6jAcwo0r94FJpZpiVn1PjJc=; b=cfd/H9w/peEOcRei
	04ovvzupazBivy7743WQTyqW1C3ocy3uXtiigvx4k033vTUJwnx0PoBhhh1/9l59
	GJ6Lp3/d7zueNURUrFXLDFT2U3YLZbWJ93XjFcFXDld56YJr7AVWM4mCg7XGXq2+
	AljET6wPiFrCs/0o3QX4KK8cGQkUBRG11JHxUZu7yXg6b/lQOX+qsLZ/81FnW7qA
	mtTCMXuJ7OgYD4P6+d1ZLKnebjieEoGXBvQhK837TmHcBrFCuDF/rqDZk5Ldi3Wr
	ktoKnYoyA9Ysnn5OnaKWE011sMT0aHIEdSE70K64uxbS4ivkCxYAPfDHcdUHpylP
	mCMXJw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gcd18460-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 05:59:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52K5x8U2001272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 05:59:08 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 22:59:04 -0700
Message-ID: <abe02188-9cb8-aa4b-9723-372000e08110@quicinc.com>
Date: Thu, 20 Mar 2025 11:29:01 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/4] mtd: rawnand: qcom: Pass 18 bit offset from QPIC
 base address to BAM
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-2-quic_mdalam@quicinc.com>
 <32785a6a-3f30-4d77-b32d-ee70c459de1b@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <32785a6a-3f30-4d77-b32d-ee70c459de1b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=bfFrUPPB c=1 sm=1 tr=0 ts=67dbaead cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=fSq50Qp5J-9m2WgZyFwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YqL-auvLiDSNqCt_67f9tQJVRmp9iRzP
X-Proofpoint-ORIG-GUID: YqL-auvLiDSNqCt_67f9tQJVRmp9iRzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200036



On 3/18/2025 8:22 PM, Gabor Juhos wrote:
> 2025. 03. 10. 13:09 keltezéssel, Md Sadre Alam írta:
>> Currently we are configuring lower 24 bits of address in descriptor
>> whereas QPIC design expects 18 bit register offset from QPIC base
>> address to be configured in cmd descriptors. This is leading to a
>> different address actually being used in HW, leading to wrong value
>> read.
>>
>> the actual issue is that the NANDc base address is different from the
>> QPIC base address. But the driver doesn't take it into account and just
>> used the QPIC base as the NANDc base. This used to work as the NANDc IP
>> only considers the lower 18 bits of the address passed by the driver to
>> derive the register offset. Since the base address of QPIC used to contain
>> all 0 for lower 18 bits (like 0x07980000), the driver ended up passing the
>> actual register offset in it and NANDc worked properly. But on newer SoCs
>> like SDX75, the QPIC base address doesn't contain all 0 for lower 18 bits
>> (like 0x01C98000). So NANDc sees wrong offset as per the current logic
>>
>> The address should be passed to BAM 0x30000 + offset. In older targets
>> the lower 18-bits are zero so that correct address being paased. But
>> in newer targets the lower 18-bits are non-zero in QPIC base so that
>> 0x300000 + offset giving the wrong value.
>>
>> SDX75 : QPIC_QPIC | 0x01C98000 (Lower 18 bits are non zero)
>> SDX55 : QPIC_QPIC | 0x1B00000 (Lower 18 bits are zero) Same for
>> older targets.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
>> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> <...>
> 
>>   /*
>> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
>> index cd7172e6c1bb..6268f08b9d19 100644
>> --- a/include/linux/mtd/nand-qpic-common.h
>> +++ b/include/linux/mtd/nand-qpic-common.h
>> @@ -200,7 +200,7 @@
>>   #define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
>>   
>>   /* Returns the NAND register physical address */
>> -#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
>> +#define nandc_reg_phys(chip, offset)  ((nandc)->props->nandc_offset + (offset))
> 
> The macro has no parameter named 'nandc', so this works only when there is an
> identifier with that name in the code where the macro is used.
> 
> Additionally, the macro will no longer return the physical address of a register
> after the change, so both the comment before the macro and the name of the macro
> will be misleading.
> 
> Since the macro is used only in the qcom_prep_bam_dma_desc_cmd() function to
> compute the 'addr' parameter for the bam_prep_ce{_le32}() functions, maybe it
> would be better to get rid of it completely, and do the computation directly in
> the function instead.
Ok, Will handle in next revision.
> 
> Regards,
> Gabor

