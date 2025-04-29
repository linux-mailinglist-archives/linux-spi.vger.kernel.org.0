Return-Path: <linux-spi+bounces-7792-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C213AA01EC
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 07:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F72E1893B7C
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713E2741D6;
	Tue, 29 Apr 2025 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iLsLiJRf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB672741C2;
	Tue, 29 Apr 2025 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905331; cv=none; b=fHM1e/lGg4C05iS3eBF0NJlK+rFPj7QSBH8PCnakajKVvKk025HVFxTtrarmEQiTNb+DYp0PQRssfcRjFffxUOmEgOnzh33MptBaMXYzYevWDj6gpjA+J+exi5QpDK5FLhIdIPtEIVsqytQrN4knj8LhgZWGSOOMBA8H9AyCEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905331; c=relaxed/simple;
	bh=DLOitkgSZvQeteEV7vswzOSxYAHHO9ynIKrHuD7EL88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WJVfDP47dj2TmWQRqNOHEnQQRNgYIPklx9sdfuh9zGogwvQ9wgBFgc0fPk3uv0iwa+/yxLG3xxTt5ZlFoLXkdpJjMmBQpmUh7S93QR9SZVWDSIEcYUpfuFCJwtI8vNu4a5cLWgCtN4bvNO6wQnlcgjy+J4kwjLnvHqUyFDGIq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iLsLiJRf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNq1oD003855;
	Tue, 29 Apr 2025 05:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EGQVTctIEjaRvzIG4gnnPlx1SdC7Ce357BzPTTQxWAI=; b=iLsLiJRf96r9u7Yx
	9dwtHjQuxB1SQe9heTM5XoUGvea7BgYfYgteH92yqVkO+0obe/s3L9MIXygD6wgI
	aVmLZtpp07s0ilubzg+8oGODEF9kLJP4BEK1iHC8GrRWLxeJ65Vmkg/PilzurTfZ
	1aNGQMuhTvH//fFHe7cY6quNlpQL6mVvMNW61xPSEW++QDVmuyGf1q2aA+H7j9Xs
	dmRHDnVitZOJZel8v42RPU7Knxw32KxHTAPnLNaVU6Ern9UIUNw9Yn0sdQhKV5St
	0P/rxUdqzNeBKUu41/prqp2OG3rGnEBlIh3RQE6gdWeXEugADVmhkeIu/tqZXrsa
	jalTkw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rsbabek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 05:41:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T5f66E009620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 05:41:07 GMT
Received: from [10.151.36.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 22:41:02 -0700
Message-ID: <3fb46918-7ad2-a720-0cc9-6a63c925936c@quicinc.com>
Date: Tue, 29 Apr 2025 11:10:51 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/3] mtd: rawnand: qcom: Pass 18 bit offset from NANDc
 base to BAM base
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <absahu@codeaurora.org>, <bbrezillon@kernel.org>,
        <architt@codeaurora.org>, <quic_srichara@quicinc.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>
References: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
 <20250410100019.2872271-2-quic_mdalam@quicinc.com>
 <bsj6kvqjo3pfbsakex5quamk5tkrtigxdcoyu5bj3nt37zsgc5@7h7zidzbcs7p>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <bsj6kvqjo3pfbsakex5quamk5tkrtigxdcoyu5bj3nt37zsgc5@7h7zidzbcs7p>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA0MSBTYWx0ZWRfX1X2DItrMteCT pPUOS1gV6rTwarn0O6JYA/LFWDTleubnOy5c7a0va4jVszyTS/jwnW0jt/AcLcPmf6c06Xaq/mI lpOqlD5R/t/d/b8FEfk5lmqZWj/4tnbX4T+CpwJ764JyGZedDr50sfvmsJqgJYFcZ9VQpd2Sn7j
 mytZpC/R3VtE785Q+nZTYC47ZylFd8IhRbMfpPCSovNPcFqNT8yiIlfP3n5RhRJSLIDNHjQgdPQ uFWpbq75sVnAUJtW2dDy1pPQGzQELKLqBfb1ho3s0FxmENqeQLH2E/oTIjMdvzTOMSrEGspn76i Cs4mjLqIMuwZys/ce6ibBQA36kPZ351iUqnub/6uhNtp+IvvbTDz7tHL3WrBnu2OFjc4FtM6hS3
 qW1SZ/vZjqzgDbOGKGEIVQS/+aQBOkJXIgU5MlylQEBPoDhyMDwf72dlgvPALg9xWzz49d2J
X-Proofpoint-GUID: mqpHxRpb0nNJPwFk7TFWsvuItKPRGvNe
X-Proofpoint-ORIG-GUID: mqpHxRpb0nNJPwFk7TFWsvuItKPRGvNe
X-Authority-Analysis: v=2.4 cv=I8ZlRMgg c=1 sm=1 tr=0 ts=68106674 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=mOH42xogWxsjzwT06YoA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290041



On 4/25/2025 1:17 PM, Manivannan Sadhasivam wrote:
> On Thu, Apr 10, 2025 at 03:30:17PM +0530, Md Sadre Alam wrote:
>> The BAM command descriptor provides only 18 bits to specify the NAND
>> register offset.
> 
> s/NAND register offset/BAM register offset
Ok
> 
>> Additionally, in the BAM command descriptor, the NAND
>> register offset is supposed to be specified as "(NANDc base - BAM base)
> 
> Same here.
Ok
> 
>> + reg_off". Since, the BAM controller expecting the value in the form of
>> "NANDc base - BAM base", so that added a new field 'bam_offset' in the NAND
>> properties structure and use it while preparing the command descriptor.
>>
>> Previously, the driver was specifying the NANDc base address in the BAM
>> command descriptor.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
>> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
>> ---
>>   drivers/mtd/nand/qpic_common.c       | 8 ++++----
>>   drivers/mtd/nand/raw/qcom_nandc.c    | 4 ++++
>>   drivers/spi/spi-qpic-snand.c         | 1 +
>>   include/linux/mtd/nand-qpic-common.h | 4 +---
>>   4 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>> index e0ed25b5afea..4dc4d65e7d32 100644
>> --- a/drivers/mtd/nand/qpic_common.c
>> +++ b/drivers/mtd/nand/qpic_common.c
>> @@ -236,21 +236,21 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
>>   	int i, ret;
>>   	struct bam_cmd_element *bam_ce_buffer;
>>   	struct bam_transaction *bam_txn = nandc->bam_txn;
>> +	u32 offset;
>>   
>>   	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
>>   
>>   	/* fill the command desc */
>>   	for (i = 0; i < size; i++) {
>> +		offset = nandc->props->bam_offset + reg_off + 4 * i;
>>   		if (read)
>>   			bam_prep_ce(&bam_ce_buffer[i],
>> -				    nandc_reg_phys(nandc, reg_off + 4 * i),
>> -				    BAM_READ_COMMAND,
>> +				    offset, BAM_READ_COMMAND,
>>   				    reg_buf_dma_addr(nandc,
>>   						     (__le32 *)vaddr + i));
>>   		else
>>   			bam_prep_ce_le32(&bam_ce_buffer[i],
>> -					 nandc_reg_phys(nandc, reg_off + 4 * i),
>> -					 BAM_WRITE_COMMAND,
>> +					 offset, BAM_WRITE_COMMAND,
>>   					 *((__le32 *)vaddr + i));
>>   	}
>>   
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 5eaa0be367cd..ef2dd158ca34 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -2360,6 +2360,7 @@ static const struct qcom_nandc_props ipq806x_nandc_props = {
>>   	.supports_bam = false,
>>   	.use_codeword_fixup = true,
>>   	.dev_cmd_reg_start = 0x0,
>> +	.bam_offset = 0x30000,
>>   };
>>   
>>   static const struct qcom_nandc_props ipq4019_nandc_props = {
>> @@ -2367,6 +2368,7 @@ static const struct qcom_nandc_props ipq4019_nandc_props = {
>>   	.supports_bam = true,
>>   	.nandc_part_of_qpic = true,
>>   	.dev_cmd_reg_start = 0x0,
>> +	.bam_offset = 0x30000,
>>   };
>>   
>>   static const struct qcom_nandc_props ipq8074_nandc_props = {
>> @@ -2374,6 +2376,7 @@ static const struct qcom_nandc_props ipq8074_nandc_props = {
>>   	.supports_bam = true,
>>   	.nandc_part_of_qpic = true,
>>   	.dev_cmd_reg_start = 0x7000,
>> +	.bam_offset = 0x30000,
>>   };
>>   
>>   static const struct qcom_nandc_props sdx55_nandc_props = {
>> @@ -2382,6 +2385,7 @@ static const struct qcom_nandc_props sdx55_nandc_props = {
>>   	.nandc_part_of_qpic = true,
>>   	.qpic_version2 = true,
>>   	.dev_cmd_reg_start = 0x7000,
>> +	.bam_offset = 0x30000,
>>   };
>>   
>>   /*
>> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
>> index a2af731049d4..89c774bf85a6 100644
>> --- a/drivers/spi/spi-qpic-snand.c
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -1605,6 +1605,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
>>   
>>   static const struct qcom_nandc_props ipq9574_snandc_props = {
>>   	.dev_cmd_reg_start = 0x7000,
>> +	.bam_offset = 0x30000,
>>   	.supports_bam = true,
>>   };
>>   
>> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
>> index cd7172e6c1bb..e8462deda6db 100644
>> --- a/include/linux/mtd/nand-qpic-common.h
>> +++ b/include/linux/mtd/nand-qpic-common.h
>> @@ -199,9 +199,6 @@
>>    */
>>   #define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
>>   
>> -/* Returns the NAND register physical address */
>> -#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
>> -
>>   /* Returns the dma address for reg read buffer */
>>   #define reg_buf_dma_addr(chip, vaddr) \
>>   	((chip)->reg_read_dma + \
>> @@ -454,6 +451,7 @@ struct qcom_nand_controller {
>>   struct qcom_nandc_props {
>>   	u32 ecc_modes;
>>   	u32 dev_cmd_reg_start;
>> +	u32 bam_offset;
>>   	bool supports_bam;
>>   	bool nandc_part_of_qpic;
>>   	bool qpic_version2;
>> -- 
>> 2.34.1
>>
> 

