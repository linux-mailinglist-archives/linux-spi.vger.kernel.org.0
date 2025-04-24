Return-Path: <linux-spi+bounces-7739-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DBDA9ABD5
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D2F4A4E5E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451B223DEE;
	Thu, 24 Apr 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H9dUZ6k3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D692139D2;
	Thu, 24 Apr 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494313; cv=none; b=hvVSQfZQ7YwfpQTRj0xOiraDQi8uNNvP9Y4MlvXodTxUbI47IDO4qhKZybvLwbKbXsZmfSfDCTOSQU5SVkxAIeuvyu75r95WyV5WdkHgWOqRf7o650YQYbYqDBXWFeWzUWj9p5APc8ONwPDQ3z4MjPl2npalcEsAlZLalCJuS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494313; c=relaxed/simple;
	bh=NFS6UKm7HQreTosvHCs0Sx+4GGkbBSJ044M7ldfZ3f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hhoCckTkVMKKd8Wm7+uWuuoVK0bIF81Ubv4EFmeue4iO8hEBNHbl4CVSpCU33jmUwZSfYAynMLBP0073PXKw9AarDKWMM5dlnxAd+45D5KCtET1TxDrCH42yKEQP5/fGlkxWYKexfqGZDTPT0fjLaOwVMS4WYEbAL3LtMAushlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H9dUZ6k3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OA7hIU031170;
	Thu, 24 Apr 2025 11:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	phE46890agfRLDRFzI4kRMIfJJ+UiUB12tGt+ATd+Yc=; b=H9dUZ6k3cGtYN/gz
	K6coqSAa7v/PsezKqP+QvhsEUuHUFYGMdTvophdRmfxoK6x8O1HBBW05j1AoOZzi
	4Qy2WxT+Aqfmfsv6szX1wtoxeQUk7BM8vdx8zegtTtwCFTSfePfAuSsSgw8MlbSH
	4POExew4ARfkUMxjXfq5kapO4bNVK/RXgmCY5UNSRXzMqUeNg68jqk+fDyFfJhAN
	E5R20aBcuCMf/gv3SDwEOBahLW6xi4LvgnJAQWUF1WvaMWiwz/xOObKv+VNVbS2h
	3Ednm0QUzbwNNu/dqwyjK318+TFVLQwF8er3P4m3H7ukNRgsn2k7fj2AS8V3p7fr
	OF6mEQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5dcm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:31:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OBVdlq022044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:31:39 GMT
Received: from [10.50.10.37] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 04:31:36 -0700
Message-ID: <5c860a06-48ff-554b-824b-51fdf4d51f4e@quicinc.com>
Date: Thu, 24 Apr 2025 17:01:25 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] spi: spi-qpic-snand: propagate errors from
 qcom_spi_block_erase()
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>
CC: <linux-spi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3NyBTYWx0ZWRfXzG44nQxQGakF WjL9HTamLrEiJEqzGuo0t5pL3NlpLIWTVrHYECqMEay9r1Bu5nZ1yijdjgokicpwvaR0EmrxEaU 5vY9wbGLwBkfaWgIS3he6DwRWZwnyFwEReNVap4HyjZBr1AkKNb6LngSaFpearFSJM97XBQ34ld
 0qv+yYB50rsO+HaKeGJBDKKm3jx3HmDgxt0zqN5p3K+ZHADwbDAr5tsCs+8Twf+hlvn4Qhkew6c kR8HFOssftN0WaAHe58b/UQlAlEGd31Ob5WLXMVAjJ+KNhaAUG1Bu93gx9oGttaIP3v2f2BhlEP RgTpmNzbGi300NKQRNzx5AEI5o+Xf34YonuuDGnHdE28x4Jg3z57b3mNP8cb13ZERPx7chdVGXE
 Ro/ScWZaaNUvIPWJHeCb4lxiICRG8TSjkDEIwEF8U3LSTcTobv1yMNszlOimUf6WaGFG7d0S
X-Proofpoint-GUID: 9d7JXDfoIfw0xaWkzl9jImmRYSLf9iZ-
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=680a211c cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=5uVZKOckcYlA3JQ-cpIA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9d7JXDfoIfw0xaWkzl9jImmRYSLf9iZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240077



On 4/24/2025 1:01 AM, Gabor Juhos wrote:
> The qcom_spi_block_erase() function returns with error in case of
> failure. Change the qcom_spi_send_cmdaddr() function to propagate
> these errors to the callers instead of returning with success.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/spi/spi-qpic-snand.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 17eb67e19132612c4c1a84848fa6f7432b1130a8..ae32c452d0bcf852b69b76e595f3588ea7e1a670 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -1307,8 +1307,7 @@ static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
>   		snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg << 16);
>   		snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
>   		snandc->qspi->cmd = cpu_to_le32(cmd);
> -		qcom_spi_block_erase(snandc);
> -		return 0;
> +		return qcom_spi_block_erase(snandc);
>   	default:
>   		break;
>   	}
> 
> ---
> base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
> change-id: 20250422-qpic-snand-propagate-error-9c95811ab811

Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>

> Best regards,

