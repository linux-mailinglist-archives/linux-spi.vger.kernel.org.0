Return-Path: <linux-spi+bounces-7608-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB26EA8B186
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 09:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE633A8D30
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACE3221572;
	Wed, 16 Apr 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OSAENeAP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66E15B546;
	Wed, 16 Apr 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787016; cv=none; b=np+MlD0dCrqbVKC9w08XvtF7DVzyOt49XdRiVhxpZN0Qkt8v6BOdfKDvnEJvZZERuOSdNDVw2PN91CPKzUV99uEG178kZowPspAknGsJQzYEfbhGz5AyS/JI7/WoL4dzJ8iY/510e9wEEa9VQZG3H8N8aP/l5kU67Sv2DfvzX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787016; c=relaxed/simple;
	bh=d7t3L/caqB1pt1UwFaFY/ssl+0gr4B7q23mO9m2NFbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jjXQAGbXFqHNOHojXrTNnqCpDQNU9AJPJDxxMalw8HQx6FA3VsipNRsrcma9nlkg7NQv0UuV67iossrIeB08va92ZsDS2nGfiNeXwZGYlg3Gs2AUd7PQYENL8i8f2jGXjeakUTwbmQoqYOKF/xltsVqLB3j6W4cgtUD6QnAPf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OSAENeAP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G6mMch011887;
	Wed, 16 Apr 2025 07:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qYkJ4A+q4rNkjssG5BOHFKwtap1/YDvQTq39pEJ34aY=; b=OSAENeAPL26wwKod
	j5zGl1+Og9FFjEa/ZSfa5PGrPjZ9NW+hx5MAFCd9THRdbBRKJRsM4skecA+T1+wF
	WY7hXN/7LApoZaj3SMeeRLbWEzdjGVmDNhintskHLoRYZVeniruR5NFJYTvIvVml
	sIg95eX9cc5Z1VMOWs2dUe7a1/5Sw2r21xFWekq+Lk6GNoYW+9zWzYnFETTJEsVS
	EwUPnRRKZy2NoNktAY9tiRpsz9LeTLQEwgeDGwtgJ7K7wJjxXazk0AlNJe0JCf5b
	Fim6WGtuf3Wdx3s4aBUghXGd61JDfaoxO8c9yOQwe6dS+fomzz8yn8uzsLoNklA0
	PMGR/w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvjasrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 07:03:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53G73T2O002643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 07:03:29 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Apr
 2025 00:03:27 -0700
Message-ID: <db36c119-c6f6-42e9-b8a0-f09e9e5a2585@quicinc.com>
Date: Wed, 16 Apr 2025 12:33:24 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: Add spi_bpw_to_bytes() helper and use it
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown
	<broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: David Lechner <dlechner@baylibre.com>
References: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
 <20250416062013.1826421-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250416062013.1826421-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=67ff5641 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QyXUC8HyAAAA:8 a=4D89g91-iFHQ57AWMqkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tpya_sjQjFOk-Cw2YS5gvrS36axSPP_H
X-Proofpoint-ORIG-GUID: tpya_sjQjFOk-Cw2YS5gvrS36axSPP_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_02,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160056



On 4/16/2025 11:46 AM, Andy Shevchenko wrote:
> This helper converts the given bits per word to bytes. The result
> will always be power-of-two (e.g. for 37 bits it returns 8 bytes)
> or 0 for 0 input.
> 
> There are a couple of cases in SPI that are using the same approach
> and at least one more (in IIO) would benefit of it. Add a helper
> for everyone.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi.c       |  2 +-
>   include/linux/spi/spi.h | 15 +++++++++++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b0e7702951fe..1bc0fdbb1bd7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -3800,7 +3800,7 @@ int spi_split_transfers_maxwords(struct spi_controller *ctlr,
>   		size_t maxsize;
>   		int ret;
>   
> -		maxsize = maxwords * roundup_pow_of_two(BITS_TO_BYTES(xfer->bits_per_word));
> +		maxsize = maxwords * spi_bpw_to_bytes(xfer->bits_per_word);
>   		if (xfer->len > maxsize) {
>   			ret = __spi_split_transfer_maxsize(ctlr, msg, &xfer,
>   							   maxsize);
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 834a09bd8ccc..abfc7f5e19e4 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1340,6 +1340,21 @@ static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
>   	return false;
>   }
>   
> +/**
> + * spi_bpw_to_bytes - Covert bits per word to bytes
> + * @bpw: Bits per word
> + *
> + * This function converts the given @bpw to bytes. The result is always
> + * power-of-two (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
Would it be good to say in 4 byte aligned /Multiples ?
> + *
> + * Returns:
> + * Bytes for the given @bpw.
Returns: Bytes for the given @bpw.
Good to keep in one line.
 > + */> +static inline u32 spi_bpw_to_bytes(u32 bpw)
u8 bpw ?

struct spi_device {
u8 bits_per_word;
}
so arg should be u8.
> +{
> +	return roundup_pow_of_two(BITS_TO_BYTES(bpw));
> +}
> +
>   /**
>    * spi_controller_xfer_timeout - Compute a suitable timeout value
>    * @ctlr: SPI device


