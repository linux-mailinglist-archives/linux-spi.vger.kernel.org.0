Return-Path: <linux-spi+bounces-7306-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C7A71383
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2351177F5E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB01A8407;
	Wed, 26 Mar 2025 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hVXejaUn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E582899;
	Wed, 26 Mar 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980943; cv=none; b=TwZNA8s/9uu7nOmB7cciAvmnnK/UcOqS5CeyIpFuYJbXt0Y1D68WxVkxDq9N+/Zq3Ko5V1aRTBbCV/xGttisJ1XGkhxOVohfj0ixuhR6UMNF80+HVItMIpXZK/K4P3tAFRvgrPFhKy2t0nJsn/e/7akpvg76W0ZflFtuKwIXjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980943; c=relaxed/simple;
	bh=ifjrUgBMvCPdU9uYYIxEFb1Qss2ti5YBogaC/ebiHBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tqgfz38ZAFovNTQjIQMO/hY9ufwsZIKsBbV7h2pYoY5K7h72wUBICpnmNZWgFbA7G1nau/i10GEjEgLjHBQU8lJMApOYCirrEJheltOwJly3J0aPbMJZL1BXJWdu/wzDXFQA35YauveArCQ5cPtZAZZ9LGcPW8mKclTuzHWFPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hVXejaUn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73DoQ029695;
	Wed, 26 Mar 2025 09:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EA3j9M95MlqEI3cqhH8tO5tsSeuux2yhz6KNKshafe8=; b=hVXejaUnxoIMYlG9
	+7HAENZ5Op31jTVC7FQfdkoS9BhKi0sVs5dBtO280SuK6J/KktCEgoXCY+GCV2HN
	0cFlhH3wdSNo89ap4SPsLqh/6eTU9kktK6p7fqfNlG7BM50U3R9I2CPc0+C+S97e
	s3bVgFkLvRdAYagr1iEadssLNoPz73ot4tlBQbddMY+JZ5ZGGWx2fiaxhqXIjur6
	nM6WdBhyjBEQXoIaq2uUY0Qowv5IAQD0gShJwKGC50mrma4o6gN1//4kPzlMT57Q
	wU4KI2bTTjo1wJwU5aWJtchIKMd7o2UPDm3W0/FUPvR9pwTTlvj4yiZAdydL5P/u
	5gZldQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktenb75k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 09:22:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q9MGbS021674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 09:22:16 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Mar
 2025 02:22:13 -0700
Message-ID: <d6210c5e-339e-4feb-ad4b-fad456ec5710@quicinc.com>
Date: Wed, 26 Mar 2025 14:51:45 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e3c748 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Rl0fcNsOjOMeeL4djQkA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JsqmwWz4k0I77RJnXR81TpEdxlfPBmUb
X-Proofpoint-ORIG-GUID: JsqmwWz4k0I77RJnXR81TpEdxlfPBmUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_02,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260056

Tested-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>

On 3/26/2025 2:09 PM, Mukesh Kumar Savaliya wrote:
> There is no support for protocol drivers to specify whether a transfer
> should use single or dual transfer mode. As a result, the SPI controller
> has no way to determine this information from the user, leading to
> potential limitations in transfer capabilities.
> 
> This change introduces a new field `dtr_mode` in the `spi_transfer`
> structure. The `dtr_mode` field allows protocol drivers to indicate if
> Double Transfer Rate (DTR) mode is supported for a given transfer. When
> `dtr_mode` is set to true, the SPI controller will use DTR mode
> otherwise, it will default to single transfer mode.
> 
> The QSPI controller driver uses this flag and configures single or double
> transfer rate using the controller register.
> 
> The existing spi-mem driver helps configure the DTR mode but is limited
> to memory devices. There is no support available to set DTR mode for
> non-memory devices, e.g., touch or any generic SPI sensor. This change
> is backward compatible and doesn't break existing SPI or QSPI drivers.
> 
> Changes include:
> - Addition of `dtr_mode` field in `spi_transfer` structure.
> - Documentation updates to reflect the new `dtr_mode` field.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
>   include/linux/spi/spi.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 0ba5e49bace4..4e1152de82cd 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -998,6 +998,7 @@ struct spi_res {
>    *	processed the word, i.e. the "pre" timestamp should be taken before
>    *	transmitting the "pre" word, and the "post" timestamp after receiving
>    *	transmit confirmation from the controller for the "post" word.
> + * @dtr_mode: true if supports double transfer rate.
>    * @timestamped: true if the transfer has been timestamped
>    * @error: Error status logged by SPI controller driver.
>    *
> @@ -1049,6 +1050,9 @@ struct spi_res {
>    * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
>    * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
>    *
> + * User may also set dtr_mode to true to use dual transfer mode if desired. if
> + * not, default considered as single transfer mode.
> + *
>    * The code that submits an spi_message (and its spi_transfers)
>    * to the lower layers is responsible for managing its memory.
>    * Zero-initialize every field you don't set up explicitly, to
> @@ -1083,6 +1087,7 @@ struct spi_transfer {
>   	unsigned	tx_nbits:4;
>   	unsigned	rx_nbits:4;
>   	unsigned	timestamped:1;
> +	bool		dtr_mode;
>   #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */
>   #define	SPI_NBITS_DUAL		0x02 /* 2-bit transfer */
>   #define	SPI_NBITS_QUAD		0x04 /* 4-bit transfer */


