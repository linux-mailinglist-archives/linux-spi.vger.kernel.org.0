Return-Path: <linux-spi+bounces-9259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9165B18159
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18101166FAE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFC1E9B0B;
	Fri,  1 Aug 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p9IN4Dd3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6B1E5711
	for <linux-spi@vger.kernel.org>; Fri,  1 Aug 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049387; cv=none; b=c9tLl3mh0QYWHjNEwso8qzzqRal4xUKwzwwCJV77c2PWDjGSm1Vc+QIDs31sH+GwtEJpRJ1wj4hEQhAHM84kufsq1083AvLWt2Tx9SpBtkgvF1eB0GIKisEtWMI+NneYhnQi85TmxvbXXqHKG+btq+r0a9j1/bgbkin+MP+4kW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049387; c=relaxed/simple;
	bh=6guj5SGYecgvd+Diof6vhKa1p/zkTKq5X83WawiuHg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIOcKAfhXmum3yy4+zZcwHQs7QObMQCWG73CwvoJiyUL3tjbDV3k/L0o/WFXQ9ce9ruiV0s3MF8u/mSUkRxSzHXNifHujt2cxpyJb7XlBzJ3UH35Vk/ipoIMqeEKN86dmpEhFiMv46SCSXkyOB2ILuf5nTXPjjkvXqyr3f/3Vs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p9IN4Dd3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718t1mY024719
	for <linux-spi@vger.kernel.org>; Fri, 1 Aug 2025 11:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zndqvOkOtBLPZgcibFTCnMvRTtpty67nrf8mHn7tQxk=; b=p9IN4Dd3lbFcTTye
	K+bXpdj2dG96CxiXbECJgun+DGtRDE8rlOyp6Ql1CJxvYR1fbvriulvHrDviZLon
	S3q0IPjExlZdre1IfSHMVcwInjl4mTnfRUJS+Rb1RGKYf7tYaBU/GK94jJWy5DRd
	8EE2uDN4p+bhK7ErBOtFh4UZEb08AH100Gynv5P7iIX5vbblqMFa8RQz8JpYYagD
	hpbgxwLP66N18MFQG2aDS5TcGMWZS5NrZ60UKobFIupPisnWSlY+u5i62k+HPDDO
	rQcE9M7THk+S3BukBuosfQ/0CXy85ViHMY8fgjCdMszRkt0iltJKciXh243RAuOC
	/q0Fag==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48887g45ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 01 Aug 2025 11:56:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707428e0cd2so2447826d6.3
        for <linux-spi@vger.kernel.org>; Fri, 01 Aug 2025 04:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754049384; x=1754654184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zndqvOkOtBLPZgcibFTCnMvRTtpty67nrf8mHn7tQxk=;
        b=TK9v6DWnDmI8z6olGxVlU53EgCplHcDLztEHRumoguTwBIYv9z3jJDcoqcVs9l6Wmy
         iHUllh85zJhvRoAs6VnXuIepfnFgacbn0wfdDsDuuRx0QEIoqk7lqnIWWP/r6hS97wky
         hnceVINMUlfDtTj/aP6KYCCfPW8sugfA2snxwmqrw7b9ExBMVAoElUfQxKhb/2WXpJwY
         4/tqoyBGgLfznl4Mr45jaTcvmuEWJpu1STMi7mmmxLtmX4T31+pnKfZHgoe5efjBy7pS
         g0Pz0yhNtyX8HXHngpxA/8vtabEn/un8IbjTtNCCQJtGk8BHEqfjkVkX+KIHi4W21Spe
         zinA==
X-Gm-Message-State: AOJu0YzHBEVcYNBJ2JYjvb3TL2QCyximl8ZLXtJXqOtwJ4k54+his4EJ
	c9L7A+Y5F37kMeajU4juDSkV9u1F8AOWk/3JLqDT7CrOjRNhzBucw9NNfd2iwT4ypn7TTZnJxWL
	J4LXbq9CZ9m6Ac7ky4xkE0YRB3wyJuU2dq+aAO402dBhGFZjKjoEW+Wr9bNOXjKY=
X-Gm-Gg: ASbGncuk9h0wN7NUS6Nqo8GM3kWLWMqb7enNJBbZ++J9oLtK6pRz6yenuxDGF9/ffxD
	tJWOcx40t7BrQGp2Mrok3lZf7aHG+WAXD3SiFcaukRUYdvyydv7ebu+u8ioLMWDodcaLK9dua+z
	LD+B8I4Bn3biCcliJwhVwJKa3Jm6O1LioBIV1rDfN0+YZ+GHMa5QEC0O/w1x6hZ5TWg42pXWmPQ
	4i+j4+F3ocz7q+cqkf9zW4gmU53xFGF9zqZ3khRuE+yKT/SHL2gJ6tzjZnxcqyzONc5Cf6KqxeZ
	ca4GZizW3a6SLeQief3d0tdMntf4cJf/lchzOusRkMonXNswAjc7JahiNq225uJdQ+Sa+46iFeM
	ngvuru8wGOp8aisztDA==
X-Received: by 2002:a05:622a:311:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4aedb9a1268mr83455791cf.2.1754049383860;
        Fri, 01 Aug 2025 04:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJrDwZ4CqsLIhFn16pVJy0wpKGA9BP8YTsdrizbhvNE1Pr9Ax5WAkfuilF6IXeAquepVZw3g==
X-Received: by 2002:a05:622a:311:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4aedb9a1268mr83455581cf.2.1754049383412;
        Fri, 01 Aug 2025 04:56:23 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a313esm277885066b.32.2025.08.01.04.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:56:22 -0700 (PDT)
Message-ID: <72d5f805-1637-4c82-af25-e78b978c5799@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: fix calculating of ECC OOB regions'
 properties
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vdn3PEp9 c=1 sm=1 tr=0 ts=688cab69 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=KpljTfsc1uQhhnHPe74A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: xcOv4qeq2BJ6zZWQnSZTAUTGvhn9tmrE
X-Proofpoint-GUID: xcOv4qeq2BJ6zZWQnSZTAUTGvhn9tmrE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4NyBTYWx0ZWRfX10kIfT0L6D4J
 AJjeFJ1xglO53GXdF9y/d9v3HpFh+C8jGiq8TnfyLVlankOXoKMvNX5VqDJ5Zgo4jzBHpyikD/C
 P7bg3hthIZcCBt7YXDKXFP2g5DWKHqYKFpXEBubVmyCYx+RpzxifLyyMw7UdCcCJRb8V26zMuXg
 qJRQIKhQhw9DyZoaBTzLxLwOID2SeYIMZ9tKJhu/rbitYB1j7xLRq19J1Uqf8D+i6IqUYV2yXvw
 dGZZXLoqNDUURuP0Sj1oIFiq0sMuS6FxocqmIuR1qDudxne0SYbo/+/Nbfx39g6oKU25HORZDV/
 KPwEH8gbHLz88SsSxIPCnhrmCGv6FUBQ3XgQY1N2c1CUHpEKJAzyS4cz0m5ckVcJcrYdPoaQofH
 E4aX5zqpORTAmNuuRlRIA2GIjgXr0LFKsXup/f1WKGouqo4FNxQU4h66nVMdxptzIYNwGn2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010087

On 7/31/25 8:11 PM, Gabor Juhos wrote:
> The OOB layout used by the driver has two distinct regions which contains
> hardware specific ECC data, yet the qcom_spi_ooblayout_ecc() function sets
> the same offset and length values for both regions which is clearly wrong.
> 
> Change the code to calculate the correct values for both regions.
> 
> For reference, the following table shows the computed offset and length
> values for various OOB size/ECC strength configurations:
> 
>                               +-----------------+-----------------+
>                               |before the change| after the change|
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  OOB  |   ECC    | region | region | region | region | region |
>   |  size | strength | index  | offset | length | offset | length |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  128  |     8    |    0   |   113  |   15   |    0   |   49   |
>   |       |          |    1   |   113  |   15   |   65   |   63   |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  128  |     4    |    0   |   117  |   11   |    0   |   37   |
>   |       |          |    1   |   117  |   11   |   53   |   75   |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |   64  |     4    |    0   |    53  |   11   |    0   |   37   |
>   |       |          |    1   |    53  |   11   |   53   |   11   |
>   +-------+----------+--------+--------+--------+--------+--------+
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/spi/spi-qpic-snand.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..37ddc48d2c17264499f821d235835c4ff5982873 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -213,8 +213,16 @@ static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
>  	if (section > 1)
>  		return -ERANGE;
>  
> -	oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
> -	oobregion->offset = mtd->oobsize - oobregion->length;
> +	if (!section) {
> +		oobregion->offset = 0;
> +		oobregion->length = qecc->bytes * (qecc->steps - 1) +
> +				    qecc->bbm_size;
> +	} else {
> +		oobregion->offset = qecc->bytes * (qecc->steps - 1) +
> +				    qecc->bbm_size +
> +				    qecc->steps * 4;
> +		oobregion->length = mtd->oobsize - oobregion->offset;
> +	}

How about

if (section == 0) {
} else if (section == 1) {
} else { return -ERANGE }

?

FWIW the values match qcom_spi_ooblayout_free(), so the commit seems
sane

Konrad

