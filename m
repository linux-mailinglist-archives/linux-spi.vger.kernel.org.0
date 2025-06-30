Return-Path: <linux-spi+bounces-8873-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4ABAED515
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1400166594
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C4C1DE4EC;
	Mon, 30 Jun 2025 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BS8ZQ6Zm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACC1DE3BA;
	Mon, 30 Jun 2025 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266782; cv=none; b=T9ESYB6hT/bWp7jHc23qWPZ3c19sxtSwLSp4H2ZiRxELO2sYtrwTXkcmyY+3GBw0dL+4k0nQrnlBldbqW8630Vg4cFzH0t+iTysENc7+YrjlOizDm9VbZgYxwOecJIThMCUGTrFxrVl+VESSQEFE4pUgeASGusAW6szrxp9aZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266782; c=relaxed/simple;
	bh=tilNS8Pm/XVR9WiXiow4NByoxt7NK9CXKyS2+0Ea1Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uRiidPFtOeIxxaHOr4XWhSxYURVVxrqQuefphKS1teqM2ifwxXj3kctfbvBMTgjjN5d5RtFrWLH3RSexzBI4YEXQr+kHHUzLeOvPySOJ2yt7AAWuy2wRXTpEsH+M6UzR8uLZKliqKKMg7uykKdVXXLwehccgVfvSGzWvoD9ILrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BS8ZQ6Zm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4phsu015659;
	Mon, 30 Jun 2025 06:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RjSLa6tZeEHjkk+ST8wtwkNek3lK86a1+3qiExb/SbQ=; b=BS8ZQ6ZmH44Fz32b
	2Rhz7jdAV0T08R0xZT5Mb5yqaGqy/gM+EeHjcpgJvKqP/qNt/YCEq2AhxbtmJHtK
	f7+56ZksiJuRoR6tSlRpZID6AtvqYj4kO8unkwknIK/3zcBdhO7h49HK9mouCSLt
	fdHd5OgIJ+yroyjqGevrTtrf8S0OT8XHCE+D7aqVcdt+EEX86u88aZ7JIBcbEdEC
	OrNWJzA/2gyN8+fbyTe6zRNxgpHnGXuMQ+K7w/Isq49qVdOVxJec/b0Gbhv38/QK
	F/nW7jmo8On2dVM4nINf3iiGWnSe8ZDIVZAS1N85gHV5+l4VaiYWmS36rllDJxpq
	xDUvyg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kkwrr95a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:59:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U6xVYQ027050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:59:31 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 29 Jun
 2025 23:59:28 -0700
Message-ID: <1382320e-e5ae-47c4-be82-ab438032eac4@quicinc.com>
Date: Mon, 30 Jun 2025 12:29:25 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/3] virtio-spi: Add virtio-spi.h
To: Haixu Cui <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250620041230.731504-1-quic_haixcui@quicinc.com>
 <20250620041230.731504-3-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20250620041230.731504-3-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=XeCJzJ55 c=1 sm=1 tr=0 ts=686235d3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=ULdJV8SEFFz07Y6q3E8A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NiBTYWx0ZWRfX3UcRJ/bjXs1w
 12+CIh8Uuss/UrHPe+svZWGsrz7X7n1HB8F5AOW+4GtTo9/Who5+ies/vsHNk8oS0jx7DwiaQLk
 6VoZlukUKrTF/LtbdTvpduC8KTdJ1tG94r/Am/zoXibRIpkMdC0e+v+D8TAmRoMPgGO46ftVvol
 ZZoVaSDhL49mdCvHlTihJNjCPTS+JlomMYrXHhopnD6KYQrlJL8LKfYmwwyOp8Td3MuyMiS9A8H
 TCR+UGVzpCrfGMNxEaU21AjLkPF6LxgbhACzV0HCIsg9fjlXkDwqg/+IAcB6dXgFpxFDCDphi6W
 1zPwSgfTUtJg/rmyr4ZSAoqQKTb5xMVfJ9YlyPcU9SJ2uZDn7JffkR7SGqTfzIKNOPfKva3JmJX
 rXUEtqPS8xE3NNHUuYfugum9w7skZzsow/YQSA2E75QQxptIjGUsj9jZhMq0UNDofj6zb2ff
X-Proofpoint-GUID: Ybxod_97YigMQqBDyAvlfCOK-dcKmGIS
X-Proofpoint-ORIG-GUID: Ybxod_97YigMQqBDyAvlfCOK-dcKmGIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=694
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300056



On 6/20/2025 9:42 AM, Haixu Cui wrote:
> Add virtio-spi.h header for virtio SPI.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>   include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>   1 file changed, 185 insertions(+)
>   create mode 100644 include/uapi/linux/virtio_spi.h
> 

[...]

> + * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
And before clock start. may also sound good, if we can write "delay 
between CS assert to clock start"
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   asserted.
> + * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce before chipselect
> + *   is deasserted.
> + * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   deasserted.
> + */


