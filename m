Return-Path: <linux-spi+bounces-7705-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C3A95C8B
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 05:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330491755B2
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 03:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC419E968;
	Tue, 22 Apr 2025 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JBET6x0f"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACA19DF4D;
	Tue, 22 Apr 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291695; cv=none; b=ONxX/tKrZE9CtwlQzwIX8CIqNwwlLnyNic+UiOxzgYYqo/tce7hjIr53tgKDwtW+NlTsY1a1bP7V/hnS0egDkVvs6wOViJSegwfAoa7o00FjJMZLLcIOi/drt9S6ugORJaOFOBjMndcq5IzSBW/gGz6fF7DdVHO/JOwXRfVPCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291695; c=relaxed/simple;
	bh=lK5biqKMYAdqszmtq7NBHhUO7oUinOQMtfjFDY93G6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JqDSQ0BK6kUscTlqK76XX8/sWK++TaeIU22HaA1uUIbT/zVW9GAVTBOBRUlmJR/SgSBZvZfqtpYOiwVLiYRwpjtodl6TerYBliBNuAMxCSBgo0i8Y2fOcRpv2Zm1LGtbyqoHMAdpEyn8/Ec24v7VB97LZ9kMQdPrn921X1cVk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JBET6x0f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LMV5o7027414;
	Tue, 22 Apr 2025 03:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5xgDtiQ2YRo/ZSiQau9oNEfYUgUQg2jk/w2WewtwlYs=; b=JBET6x0f69wn/sVM
	EQJoB2vH4/U/rbeSMQuk0Qemhq6BDIl6Xu5RkCfnhBIpE4XDyZh5b/PRNc+Fi6r0
	/Z0bH72pqJFKN51y6xnTfPZ50ys7DZGm6c+DvGxpsMdjo7+UNJeiQ4xFV6btNH2I
	QuklbDWlxjXIpZd69RAcohTJP7cGM0KaOU9Hd4f+ElSNdt3FoPMmVZsNC2GxQ5nn
	KRZll+vd9pjxEfe7t4ZxhOdLluqJ+vQSNninrlYBzAqOza4CY9biALSghd58zTxw
	FPTgiseM3C2iV0fp8dO/xqHA1ogoNmjr5TB9q9O5Ws2ooJ/A0XcFiWa5ICKFhTRQ
	MRoc7Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642sve0gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 03:14:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M3EhFv011677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 03:14:43 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Apr
 2025 20:14:40 -0700
Message-ID: <3f4be207-478f-463a-8eb3-fdc78b5df031@quicinc.com>
Date: Tue, 22 Apr 2025 11:14:37 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/3] Virtio SPI Linux driver
To: <broonie@kernel.org>, <virtio-dev@lists.oasis-open.org>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _0fR-dhsu16WA9N1vUin7UjFpPSDj3CJ
X-Proofpoint-ORIG-GUID: _0fR-dhsu16WA9N1vUin7UjFpPSDj3CJ
X-Authority-Analysis: v=2.4 cv=QLJoRhLL c=1 sm=1 tr=0 ts=680709a3 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=UDcBipxUyodt8s_jST4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220023

Dear Linux Kernel Developers,

The patch addresses virtio SPI driver and it has been validated
on Linux 6.12 with Qualcomm target hardware.

I kindly request community members with expertise in SPI and virtio 
subsystems or related areas to review the patch. Your expertise and 
feedback would be invaluable in ensuring the quality and effectiveness 
of this contribution.

Thank you very much for your time and consideration.


Best Regrads
Haixu Cui


On 4/1/2025 11:36 AM, Haixu Cui wrote:
> This is the 4th RFC version of a virtio SPI Linux driver which is
> intended to be compliant with the upcoming virtio specification
> version 1.4. The specification can be found in repository
> https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.
>   
> Changes between 3rd and 4th virtio SPI driver RFC:
> - Remove the logic code for statically creating SPI devices through
>    the spi_new_device function.
> - Add ACPI support.
> - According to Hillf Danton's comment, use init_completion instead of
> reinit_completion in virtio_spi_transfer_one function.
>   
> Changes between 2nd and 3rd virtio SPI driver RFC:
> - Order header inclusion alphabetically.
> - Add Viresh Kumar's "signed-off" to the header files.
> - Rework virtio_spi_one_transfer
>    - Rework the delays according to Haixu Cui's advise. Delays are now
>      handled in a new sub-function virtio_spi_set_delays.
>    - Minor change: Re-formulate arguments of sg_init_one.
> - Rework virtio_spi_probe
>    - Replace some goto in error paths by return.
>    - Add spi_unregister_controller to an error path. Abstained from
>      using devm_spi_register_controller to keep order of
>      de-initialization in virtio_spi_remove.
>    - Add deletion of vqueue to all error paths taken after the virtqueues
>      have been initialized.
>   
> Changes between 1st and 2nd virtio SPI driver RFC:
> - Update from virtio SPI draft specification V4 to V10.
> - Incorporate review comments gotten from the community.
> - A proposal for a performance enhancement having more than only one SPI
> message in flight had to be kept out. The more complicated code would
> have caused an unacceptable project risk now.
>   
> The virtio SPI driver was smoke tested on qemu using Qualcomm's
> target hardware providing a physical SPI backend device, based on
> vhost-user protocol. Take vhost-device-spi as the vhost-user backend
> and qemu integrated with vhost-user-spi implementation as the vhost-user
> frontend. The Linux version used for testing is 6.12.
> 
> 


