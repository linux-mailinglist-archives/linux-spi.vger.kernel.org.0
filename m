Return-Path: <linux-spi+bounces-7883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169C8AA9194
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 13:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552743AFAD7
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2D1FBEAC;
	Mon,  5 May 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1xHXyNs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811F3596A;
	Mon,  5 May 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443325; cv=none; b=nY7w2woCUPqsGSVBTuCXowebuPFsB0zY+dzbbWO8JFLlx136iBmSWS71K+fL7nuZvVQxOtvBqP9b9Df8Xun8JcU4k8yrHEGLallQIxjSiVjlm/v5zwJBJhQc97O3w2mI4wLC0+43o8u4SpIovTWAJoORd/84ZZn84bDRRIVgsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443325; c=relaxed/simple;
	bh=+BUvlPruL1JlY4IggkE6XFzDtAQrYQkQFafiJUZalJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BoaExTMYzUWCk8k6zTOQ8i2LnW+pLzmY+ffmP71MF+BRQDh00jMJH3sa9gUxKTxTkLZZz3Y32ZRXsTSUzB8BMS3VHm30pl/I4Q/EssU5W4GVx+HX3jaLagBZlfrB6+cuq7MxLk431Ih7GUU1pq1QAZXwU2EYajQAX+6ycQwmepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R1xHXyNs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544NNPvs009423;
	Mon, 5 May 2025 11:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bZkVhAqO8qCE7yRgy0cF6WJynf8bvvtI8A/M97HwEFs=; b=R1xHXyNs3+szGF18
	hJWpPVg4gY5BYbwdf9d2cAbANvsHlrB5AZTvKf+5u4i/uD4ADDYOZvJmbP+6m6T4
	wRw1lnU7J+ptzKnfxfs+q1dWR15TWesJ3+WYewtRap5LYBouruLLfhyi5w8LcyDW
	bMEFLE+680uqlQF2MCQrt6ynF03do4i6DFphIRZzZmg5URXymOZKePczw9Q9t6xK
	h4hxHA03jklgQnhsD+PJjsTzoONJsrxmuwHGkcJf2XrDti5DQAPlauo80DL06uEV
	apoLgtQaX6yjbclGRXWlEBt2f4Mm/3pDXFyaD3SaGuTUZCao0EbLm5TCRVp/kCus
	dzlL5A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbc5bv9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:08:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 545B8Mg9013636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 11:08:23 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 May 2025
 04:08:18 -0700
Message-ID: <82e52a38-56fa-d286-babb-4891189e43ed@quicinc.com>
Date: Mon, 5 May 2025 16:38:06 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH next 1/2] mtd: nand: qpic-common: add defines for ECC_MODE
 values
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Miquel Raynal
	<miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
 <20250502-qpic-snand-8bit-ecc-v1-1-95f3cd08bbc5@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250502-qpic-snand-8bit-ecc-v1-1-95f3cd08bbc5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DgaoopOc3f8J-pNcK7ag10MH2J25OG75
X-Authority-Analysis: v=2.4 cv=O7Y5vA9W c=1 sm=1 tr=0 ts=68189c27 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=COk6AnOGAAAA:8 a=hzUmz7RbO9NCeILv9bEA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DgaoopOc3f8J-pNcK7ag10MH2J25OG75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEwNCBTYWx0ZWRfXwcBdqF4qAmYr
 5r/V5qR24VsmVnrKFT5DjQKeMnwUDgmSDtfCy8DzqGKiQEkCxgevHee4Dv0q5qsSguA3Ju2qbqM
 d9ASnBVGUEE3sq6RgxLCUoEjETZquv4qfltVivEmxt68VtjhzFvU5/2P9BLLnXKXb2/x/3nO7M0
 zsfAQtnwIWw/qUJUpM09WkQASnjddHW2CSJ4olQJDiZ1Al3l959n1bmXbB4iAMb9NDAcfsd2hCg
 962aqPfRk1sFT/9voE3glFHK31TTzRnJGC3YyvKhEWZXLbZDhL0ZfvamdMvdbPulook0SbueBtT
 1Abj0F/prdSVa+fbgr7l7u4fwC/QMJB9wmXgoru5a+Kz/72NtsLLIbEIJqaBRvSdUd/I7it/08Q
 mhy0aol79yoefm8aXUwWikeDWkRRUqhAOF6oG37LYaiCMf3qJxSU/SX5Dhh1sKOVSyOzvkfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050104



On 5/3/2025 1:01 AM, Gabor Juhos wrote:
> Add defines for the values of the ECC_MODE field of the NAND_DEV0_ECC_CFG
> register and change both the 'qcom-nandc' and 'spi-qpic-snand' drivers to
> use those instead of magic numbers.
> 
> No functional changes. This is in preparation for adding 8 bit ECC strength
> support for the 'spi-qpic-snand' driver.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/mtd/nand/raw/qcom_nandc.c    | 6 +++---
>   drivers/spi/spi-qpic-snand.c         | 2 +-
>   include/linux/mtd/nand-qpic-common.h | 2 ++
>   3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 5eaa0be367cdb847d48dbed6f8326a75a5922347..67641ce28bd6435fffda3ffe5e38c777f4708cf8 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1379,7 +1379,7 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>   	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>   	int cwperpage, bad_block_byte, ret;
>   	bool wide_bus;
> -	int ecc_mode = 1;
> +	int ecc_mode = ECC_MODE_8BIT;
>   
>   	/* controller only supports 512 bytes data steps */
>   	ecc->size = NANDC_STEP_SIZE;
> @@ -1400,7 +1400,7 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>   	if (ecc->strength >= 8) {
>   		/* 8 bit ECC defaults to BCH ECC on all platforms */
>   		host->bch_enabled = true;
> -		ecc_mode = 1;
> +		ecc_mode = ECC_MODE_8BIT;
>   
>   		if (wide_bus) {
>   			host->ecc_bytes_hw = 14;
> @@ -1420,7 +1420,7 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>   		if (nandc->props->ecc_modes & ECC_BCH_4BIT) {
>   			/* BCH */
>   			host->bch_enabled = true;
> -			ecc_mode = 0;
> +			ecc_mode = ECC_MODE_4BIT;
>   
>   			if (wide_bus) {
>   				host->ecc_bytes_hw = 8;
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 88f8fa98687fa292861d46648872135aa7fad80f..dfc8cc5d97624fe741121228b97d2b3562cc5cc4 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -349,7 +349,7 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
>   			       FIELD_PREP(ECC_SW_RESET, 0) |
>   			       FIELD_PREP(ECC_NUM_DATA_BYTES_MASK, ecc_cfg->cw_data) |
>   			       FIELD_PREP(ECC_FORCE_CLK_OPEN, 1) |
> -			       FIELD_PREP(ECC_MODE_MASK, 0) |
> +			       FIELD_PREP(ECC_MODE_MASK, ECC_MODE_4BIT) |
>   			       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
>   
>   	ecc_cfg->ecc_buf_cfg = 0x203 << NUM_STEPS;
> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
> index cd7172e6c1bbffeee0363a14044980a72ea17723..a070af4593754384d9df4f6206a24665e2040aad 100644
> --- a/include/linux/mtd/nand-qpic-common.h
> +++ b/include/linux/mtd/nand-qpic-common.h
> @@ -101,6 +101,8 @@
>   #define	ECC_SW_RESET			BIT(1)
>   #define	ECC_MODE			4
>   #define	ECC_MODE_MASK			GENMASK(5, 4)
> +#define	ECC_MODE_4BIT			0
> +#define	ECC_MODE_8BIT			1
>   #define	ECC_PARITY_SIZE_BYTES_BCH	8
>   #define	ECC_PARITY_SIZE_BYTES_BCH_MASK	GENMASK(12, 8)
>   #define	ECC_NUM_DATA_BYTES		16
> 

Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>

