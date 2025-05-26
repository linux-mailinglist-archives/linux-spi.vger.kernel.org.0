Return-Path: <linux-spi+bounces-8290-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600A5AC394E
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 07:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF2D16C44A
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2254111BF;
	Mon, 26 May 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ir8d8f7c"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211D19D880;
	Mon, 26 May 2025 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237751; cv=none; b=cYUpNy/wo+UwoiibqqimISieT4Rxc1wJ8VSsrhuRC+nFTnCK42Yz+HYRKfhWt0pNBZIITkhlgHZM8N4Y6J2vUj8LwPFomjInO25YSdc+Pkgc+zjMk5tyoVSp3ZtRo4ChP8BV74hVKSrs/BAZwhPbkx6q4e7Z1Gd/Cy1r96kgq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237751; c=relaxed/simple;
	bh=BuRWnb3cuhbj4vQVIyISoqjQkh79be9NQ73UrJ/GVfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DZ2XhJqnRHJq6wMCSz0rTuUwZQ3CojTZQ5puvtXow3qKOHScy9hQYN1DZpDWESNdY1Tey0ZSFQrEmjlhqTmORwHFuwDFD7XWHNMww0jHi9hTzYGB29qLL8BBlHHfRhxw3SEq3RdxUAy1j5eqpJi9lwfUOodyFcMb5Bn1+3YlUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ir8d8f7c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PNFIiK004485;
	Mon, 26 May 2025 05:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uzLUVXXayimdmrDZtlg5c2L5SZ46QViuJixjKXrRq1M=; b=ir8d8f7cftwLovYX
	+MikWJcfg820+33u4Vd5LVq6desP0ikI6B/1p1V7GjNxjaUUA6HdNv96selJx8n7
	qzlHFzOVxBURlW8h5nVWXW4tYpn2rbsttBYIar9JaDaukWt9zFqVhotA6pyg1Lx1
	Hw5Ajxf5kdn6c2BXiKvDaeaJSEQuf2x+bDDIOt1DnLKNrkAoN45ISXhtlFHdWbr3
	AezROUzbdXOWXCpSVW9mNt1kBZT/+pjZJs7NIcPeuc7VTIeKleeNkDNkySwPpp5N
	HNRu1s62WcCyMNGw4d574oy3PGzDt2r5F00jgL+U2iTpnUkLh/9fOAC7XROReXU4
	BKKOcw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g8u1uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 05:35:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54Q5Zjmt006177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 05:35:45 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 25 May
 2025 22:35:42 -0700
Message-ID: <d859183f-d9dc-1db4-e6a6-7db1cbdbaab7@quicinc.com>
Date: Mon, 26 May 2025 11:05:39 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] spi: spi-qpic-snand: use NANDC_STEP_SIZE consistently
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        <linux-spi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250525-qpic-snand-nandc_step_size-v1-1-6039e9bfe1c6@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250525-qpic-snand-nandc_step_size-v1-1-6039e9bfe1c6@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6833fdb2 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=COk6AnOGAAAA:8 a=YikZN-sOpGJawurdiwoA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DyuXlRWRfyNK0KXyMH50zPgZ7eF8zNCw
X-Proofpoint-GUID: DyuXlRWRfyNK0KXyMH50zPgZ7eF8zNCw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA0NCBTYWx0ZWRfX2vZOAhu5aaDm
 9tk3CqQTSEPNXyOSfdfrp5VewhrnPg1riU231jy3k/tdSMBRrKvE0YdYJStl0dSL/UckTjFzN9T
 e/WHi4bVspEbOS/w2q1OGsDt/5qP+xivE/ebP+hHHUZeoQ2mHH9FvyzJxXXrPUBfpryMg9ZIiAn
 7PhdjOCQv53OmWgyDaNx9jDHOxzEPn/647Se4rUKSVOAAeSFuKhUpMNS3v4L57QuzJm3vXQyKSZ
 hYWxX7KyPZUq3oiGNWPq8tPvVqeWlcuGsNh4yRn/HxXtmnjghBDfo+ilikMEKyNRiN90DX51ntH
 pf9A1u7Ke9mXHSXzRruNyDzVNeW1oAKmHf4BXMNoemDtuuiUTg4LdiGQT/AUKeMM47IrHoUPQ+m
 PXaH1rA+DR1/a6Kh50wsipWolmMULSE321hwNtLLvBfTFDibnv2HY2KG4bztA07v94ZdGKLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=905
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260044

Hi,

On 5/25/2025 7:45 PM, Gabor Juhos wrote:
> Change the qcom_spi_read_page_ecc() function to use NANDC_STEP_SIZE
> instead of a magic number while calculating the data size to keep it
> consistent with other functions like qcom_spi_program_{raw,ecc,oob}
> and qcom_spi_read_cw_{raw,page_oob}.
> 
> No functional changes.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/spi/spi-qpic-snand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index fd129650434f0129e24d3bdac7e7c4d5542627e6..037178d6576e82c3f19c3cc2c6c78f056dc488af 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -821,7 +821,7 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
>   		int data_size, oob_size;
>   
>   		if (i == (num_cw - 1)) {
> -			data_size = 512 - ((num_cw - 1) << 2);
> +			data_size = NANDC_STEP_SIZE - ((num_cw - 1) << 2);
>   			oob_size = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
>   				    ecc_cfg->spare_bytes;
>   		} else {
> 
> ---
> base-commit: b00d6864a4c948529dc6ddd2df76bf175bf27c63
> change-id: 20250525-qpic-snand-nandc_step_size-5606f4aaeda0
> 
> Best regards,

Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>

