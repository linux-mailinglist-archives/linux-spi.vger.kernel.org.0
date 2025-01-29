Return-Path: <linux-spi+bounces-6567-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6437A21DDA
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D147A1E3B
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3ED481CD;
	Wed, 29 Jan 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sbv7ZFm7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBCB661;
	Wed, 29 Jan 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157265; cv=none; b=YzoQai8J6TZ2tk1H//H8TPdrbu1Q9N6hSb7NBOHhlYPA6PzoJaHMbN0bTZEPQidz/IUO5qnBh81VL55NAXfZyA4mrZPfS/auiLdwTQbzMuWRHosWK4roqfFA7w8iPBN8FlLY8nKs8X12kL1o76OG2NBKzj1r3fhgbojct0AxMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157265; c=relaxed/simple;
	bh=YAw90nP5pcCtcTNaoC+a9ncjf/xabU+Ci+duExlPmTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aH+0PliU0i2yyUMfJo9JftT8wPRENY6JvvvI7zZk+cHFDi4ffOG54++UBVm15PKlXYOvqyW7Y9LYDKQ7k/gDoqMM/dFjnjwsVoGwt8Ca/MgGowO8tQmqR/scAUvCvzZMX1LMM79ceqOT4Fj2hYNdIgBD+uMsuuIdYndbPQLoEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sbv7ZFm7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6Puf9008447;
	Wed, 29 Jan 2025 13:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jycu/BkhEj+iNFaJ39eTq4ky8+iSVcfgm7DSoR9muPA=; b=Sbv7ZFm72zZtL3xD
	lN2ubFcM5pDKuRS30vAIfRTKIe2xKTG2JmZPGENupJOYafoWDJhqWVOZ1aooRL3H
	CSedmgdN2eyATKMv2ERTUcqC5EnikW2TLXaUi+1ACzPGwpL8dUevDrcj7pbQqpTr
	Gl2IzHTILKBegpr8dDaaylPAqeSrU0wOsN0eDk0fWkUUlaS17sgFihoUQaTQ5gvu
	joH/PIsOHWU121kwqcs0mHr1xhp0UGZi/7IxlsbdfNJNFf/v/nxRy3KCC7MQAoSn
	ahsLG4mrZhriIsMfM8yUj3zndsT3kxZpY6h4MmSyrjqK7ioYWUSSM4CAw8XbOiw+
	P+VC4Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ff1q0pmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 13:27:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TDRd6e011500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 13:27:39 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 05:27:37 -0800
Message-ID: <3e8c08fb-ec3a-4d00-a3e9-43c299dcf942@quicinc.com>
Date: Wed, 29 Jan 2025 18:57:34 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: microchip-core: prevent RX overflows when transmit
 size > FIFO size
To: Conor Dooley <conor@kernel.org>, <linux-spi@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, <stable@vger.kernel.org>,
        Daire
 McNamara <daire.mcnamara@microchip.com>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250114-easiness-pregame-d1d2d4b57e7b@spud>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250114-easiness-pregame-d1d2d4b57e7b@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jpVjl9zEq5diqYx5SiPsRL4J3sdsJwOW
X-Proofpoint-ORIG-GUID: jpVjl9zEq5diqYx5SiPsRL4J3sdsJwOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=417
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501290109



On 1/14/2025 10:43 PM, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
Not sure why this "From:" is coming here, should be not coming.
> 
> When the size of a transfer exceeds the size of the FIFO (32 bytes), RX
> overflows will be generated and receive data will be corrupted and
> warnings will be produced. For example, here's an error generated by a
> transfer of 36 bytes:
> 
why warning on RX generated when TZ size is > 32 bytes ?
Also you should be taking 32 bytes in a one go and then send remaining 4 
bytes. I am thinking if your TX is faster than the RX receiving ?
>    spi_master spi0: mchp_corespi_interrupt: RX OVERFLOW: rxlen: 4, txlen: 0
> 
> I am not entirely sure how this happens, as rxlen being 4 means that 32
> of 36 bytes have been read from the RX FIFO so there should be
> sufficient room for 4 more bytes but timing is likely a factor as simply
> adding a delay in the transmit path is enough to avoid the overflows.
I suggest to try to chunk in 32 bytes size.
> 
> CC: stable@vger.kernel.org
> Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Been sitting on this one for a bit, original reporter claims the problem
> isn't fixed, but it fixed the issue on my setup so I am sending the patch
> as it's an improvement on the status quo at the very least.
> 
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: linux-spi@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>   drivers/spi/spi-microchip-core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
> index 5b6af55855ef..3582fe8d3fc4 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -221,6 +221,13 @@ static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
>   	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_TXFIFO_FULL)) {
>   		u32 word;
>   
> +		/*
> +		 * If the transfer is larger than FIFO_DEPTH, spin until space
> +		 * is made in the RX FIFO to avoid losing data to RX overflows
> +		 */
what if you transfer first 32 bytes and then remaining ?
> +		while (mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_FULL)
> +			;
> +
>   		if (spi->n_bytes == 4)
>   			word = spi->tx_buf ? *((u32 *)spi->tx_buf) : 0xaa;
>   		else if (spi->n_bytes == 2)


