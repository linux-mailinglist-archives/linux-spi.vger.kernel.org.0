Return-Path: <linux-spi+bounces-8872-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A580AED4FA
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 08:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCDC7A788D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 06:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E11FDE02;
	Mon, 30 Jun 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oKgH7KOC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169481E32A3;
	Mon, 30 Jun 2025 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266510; cv=none; b=jXNQvz07lO9lhXA6fpNAPsiOrgrSvR00qeWtoybrFRCWO0ZqAuGMt6csSHtCdW+015+b2XJQ2OtgCKnUKPPvicxEiLMG+fL9M1kafh+IEi3Hx3yd+0iT+6fvfUKR7Efj2KdChcvwZYNWpwpH9bAcQYoRgie41u85BUxGYXDioSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266510; c=relaxed/simple;
	bh=KUxKFurlKFsNM2mppY621IFrTmXqdnoQH3I4dV6w9hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z2AqD8G66aHijRZdp8XL5Qik7FwahdP0nSBSvT9VuyR0JmXA+Y3HPnrwcPG/PAG7nxFCvGerwDcWvJm6qfe0QQ9SQ09VfSWh72BH2uX8rvuk91nG4/hICdc5QNyIqbxLZf+gK0OVZoVpPHUxiDYz7H0w+T4rHPJNDeg6oHQ/8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oKgH7KOC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U6GTQK002603;
	Mon, 30 Jun 2025 06:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MZYOwvxv2hKfe6jAzA+YOBKsVoqOdAIyhTkeDyeR8ZI=; b=oKgH7KOC3rQmhf5h
	24X1EuhRrGZgrNQN8PnM+jmZy0zalU1AzzlsACzooxDUlOHGI7pp92rQNOAMFm6W
	GVAN9qhJ3UTrmOue4AtD5L+YE64H+Y1yuH9LwrXNcoAG/H8BjQKkGyrecZGGB6hy
	TLNGF61OMsA+2iQEw6nxks8vya34HUSrAIPpZd8i0kDtLEgnb4t/hxFXIgjzt2Xe
	zPKv8V01YSudgBU3/AHK1Zx5vL8mapcLt9i3/QEJu5F0gW26KhIJ60gNoKMsuaXf
	rdOFbPPxz/60VHoRm6o2gJloXTJFLwna3pAzUhlLLfJN/INpnTjaXQbUZlT44axH
	4u5R3w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5j82wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:54:57 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U6svfD004625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:54:57 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 29 Jun
 2025 23:54:54 -0700
Message-ID: <be751d7b-9216-4564-ad21-2df6a19477fa@quicinc.com>
Date: Mon, 30 Jun 2025 12:24:51 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/3] SPI: Add virtio SPI driver.
To: Haixu Cui <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250620041230.731504-1-quic_haixcui@quicinc.com>
 <20250620041230.731504-4-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250620041230.731504-4-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=686234c1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=uBtOIxTJ7MnckNxzp6gA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9egaJJ7Ni2o2eKeiacU3hQyaoYK2rNv3
X-Proofpoint-GUID: 9egaJJ7Ni2o2eKeiacU3hQyaoYK2rNv3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NiBTYWx0ZWRfX74/iWbfsflDy
 g4tCJZh/YGVUFBXnH0xYZJhtJwFw1OsDsRgL7QMTr8tmWsITr9Br1p6hjKWQdKHYJRPMYpW6xnk
 hBDAO6zUuSf1Yev/OnpllC61Idnejwn7iWZMWIkAhWZIxnyQbNmWsnqrn/38gFFb3UcQV2/iphR
 USV8J0KQo2G5OWBoEcahGEeQGgaStOIdMIVyoEmN1mAMBj1vy9RCrf6FbNPNtepYEGYbLRhcv76
 3izd5Fhf7t8FbCJgoEOjI4nqJC4XkA8+bscn25Eh6xnYf+iyEDAU2u1DiyK+DHUHVTO15ji2b5q
 zDcqdBWUxIEXo9Z7RojV8ozYoPUGMMmjR7BCi3XJSnO1wOjuev/xuIDx19axJ2mCqBMeonEwh7i
 UZY+4+Fc/PA5bmoBhYgApJk+yWTy6F322ZQ2XVsyAG/0qIoAONY9VaUxd9WaPb0fCVbKawRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300056

Hi, Haixu, Thanks !

On 6/20/2025 9:42 AM, Haixu Cui wrote:
> This is the virtio SPI Linux kernel driver.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>   MAINTAINERS              |   6 +
>   drivers/spi/Kconfig      |  11 +
>   drivers/spi/Makefile     |   1 +
>   drivers/spi/spi-virtio.c | 444 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 462 insertions(+)
>   create mode 100644 drivers/spi/spi-virtio.c
> 

[...]

> + * So the corresponding relationship:
> + * A   <===> cs_setup_ns (after CS asserted)
And "before clock start" ? to be added in bracket as comment.
> + * B   <===> word_delay_ns (delay between adjacent words within a transfer)
> + * C+D <===> cs_delay_hold_ns (before CS deasserted)
> + * E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two
> + * values are also recommended in the Linux driver to be added up)
> + */

> +
> +static int virtio_spi_transfer_one(struct spi_controller *ctrl,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *xfer)
> +{

[...]

> +	wait_for_completion(&priv->spi_req.completion);
> +
I see init_completion(spi_req.completion) is called during probe() but 
successive transfer doent have reinit_completion(spi_req.completion). 
wondering how is this working for back to back transfers.
> +	/* Read result from message and translate return code */
> +	switch (priv->spi_req.result.result) {
> +	case VIRTIO_SPI_TRANS_OK:
> +		/* ret is 0 */
> +		break;
> +	case VIRTIO_SPI_PARAM_ERR:
> +		ret = -EINVAL;
> +		break;
> +	case VIRTIO_SPI_TRANS_ERR:
> +		ret = -EIO;
> +		break;
> +	default: /* Protocol violation */
Comment in new line ? following same method across.
> +		ret = -EIO;
> +		break;
> +	}

[...]

> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +
> +	/* Order: 1.) unregister controller, 2.) remove virtqueue */
Is this a specific flow for virtio OR generic ? if its generic, we can 
remove the comments.
> +	spi_unregister_controller(ctrl);
> +	virtio_spi_del_vq(vdev);
> +}
> +



