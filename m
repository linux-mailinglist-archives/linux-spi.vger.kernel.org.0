Return-Path: <linux-spi+bounces-7797-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B113AA085A
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC24612F1
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827129DB6C;
	Tue, 29 Apr 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQ9JAecL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954E1DF73C;
	Tue, 29 Apr 2025 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922064; cv=none; b=PVqxIZVW8DX8bD3SUpEyruiLTuPu/KxVMOKNV/CY1HNhKGS5t2RJCB0NOjcSftxe3DU84Rk6+EtjylKevaMpEJDftsa/7RaPKXAPkS3NcjUGTBpLx3lH+0P5DVaT29DLqAtGsTyx0/U3zMEy0Ssm3gMqIGphlhsZa9VovRtPI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922064; c=relaxed/simple;
	bh=uR6VaioCimeVIQ8bNRlrgSUX6z+R8FlO4/2NaftC328=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i8/7j1y+xf8/SO5zhP391qbyGGnAZGxi0/tdqzRhjpl6G1FPbXCC62ODs6R0Nzdkckamz1m748oaSSf4ldsr83TmC2Z9WlyVzxLPcuNyLrLZ3VSOapz0fuKqnqAVwpvkDut7PA2UO/+eA2rjRNWtGRH+PQzwI5T17E/fS9iAWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQ9JAecL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T9rPq3015584;
	Tue, 29 Apr 2025 10:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EIbRRhBoADcI+1rAWz3pn4vq2fzm9cFIBshsTy1XdCw=; b=dQ9JAecLAzkwoqc9
	q7DDZNAH3aXnJXTq0Wws6gnWoDqsVzo3JMIDQkdr2mMzg8yi9/DxCK4bqgU5QPYA
	x+3454539bvNAVxXTC37HpX95gpu7LdBuFdrUTCCZFvbOPlvIbI07A0l/0XjqL/R
	oMkMtVslfxTBc2/xqQpEL8K5Ywb8g4Wc4F7F34OhSFn2uBzeShi2w6yHbdzP9n/Y
	R5JZCyF8CBCgSYleKqu25XXvmTWschb802jsZkpmZstQkyDHeT+hF7ck4mMGa6YY
	ROZs53EU0zNEq+Kyr9yL2n514wqNq0pkIqFhMifFAYmBSo5XTbqYNuMlM9QgCBb7
	g1tAtg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qjwv4kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 10:20:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53TAKbHT026640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 10:20:37 GMT
Received: from [10.151.36.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Apr
 2025 03:20:34 -0700
Message-ID: <ab24fa96-8c2a-8be3-bcb2-f31e9e6f1ec6@quicinc.com>
Date: Tue, 29 Apr 2025 15:50:31 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] spi: spi-qpic-snand: fix NAND_READ_LOCATION_2 register
 handling
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>
CC: <linux-spi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250428-qpic-snand-readloc2-fix-v1-1-50ce0877ff72@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250428-qpic-snand-readloc2-fix-v1-1-50ce0877ff72@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cheBpp22EDXEz9QtfgNkn56uxQHyxvKc
X-Proofpoint-GUID: cheBpp22EDXEz9QtfgNkn56uxQHyxvKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3NyBTYWx0ZWRfX3RVWVafmDu3r aiVKwtepLBdc4DmaFd1072webve7JoHqsJolLlzIj0+M9wu9uHNwimZ4LOtrNU7OSMq4V04CIqS pPiXV9fv52MDG5A11domMkWxenTTj2j+kFBJ/ZUeNibFyhySO34l+ojWpYGkeuwb5VGelHSXz7f
 YGcZ5UjXHRwPtSM8X3tp0F7FehEAc3JLUxJd2pfdI1dvSUhGn0KtUoSWqYiNXt2y1H4/TLqqCmb YbWBXDB9jy/kVURRSNquO1IUNvVBhfoCNKbloJBdTpQ8Bnt1/BDs80O7GpMFwR4J8Amk6KUOHy3 7jIaJrnP8ADYFSIMtb2jQpdFFylfVF9BlqFeb0Re/rLbYlx1NhnM9Rwm3LVAUYIcyV+2pDWnYVw
 TrIRhD1ZRelo9FZmbgI1G09Tz6D9sWRODhSjSKALusW7vff/S7iAyPd1eYy/mddiwWTHWfAQ
X-Authority-Analysis: v=2.4 cv=c/urQQ9l c=1 sm=1 tr=0 ts=6810a802 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=2CvQLFO0oMS28NyxHQUA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=995
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290077



On 4/28/2025 1:00 PM, Gabor Juhos wrote:
> The precomputed value for the NAND_READ_LOCATION_2 register should be
> stored in 'snandc->regs->read_location2'.
> 
> Fix the qcom_spi_set_read_loc_first() function accordingly.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/spi/spi-qpic-snand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index ae32c452d0bcf852b69b76e595f3588ea7e1a670..94948c8781e83f30650e5fbac56897daf5eb3c2c 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -142,7 +142,7 @@ static void qcom_spi_set_read_loc_first(struct qcom_nand_controller *snandc,
>   	else if (reg == NAND_READ_LOCATION_1)
>   		snandc->regs->read_location1 = locreg_val;
>   	else if (reg == NAND_READ_LOCATION_2)
> -		snandc->regs->read_location1 = locreg_val;
> +		snandc->regs->read_location2 = locreg_val;
>   	else if (reg == NAND_READ_LOCATION_3)
>   		snandc->regs->read_location3 = locreg_val;
>   }
> 
> ---
> base-commit: 15cfe55ec58ace931a73e19e5367598734ceb074
> change-id: 20250428-qpic-snand-readloc2-fix-bccd07cf26d3

Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>

> 
> Best regards,

