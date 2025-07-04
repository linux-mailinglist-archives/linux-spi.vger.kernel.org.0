Return-Path: <linux-spi+bounces-9040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C32AF89E2
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 09:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC403A715F
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3582283FCB;
	Fri,  4 Jul 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m+30w6o6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD21DF246;
	Fri,  4 Jul 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615189; cv=none; b=JrmvQRAac8lmo8qWrLq1mJWjMP7Lde4t0KpqCC62R9AegqJs+oLPlI0mqNvhP/X+9Q9Pk1OumWxhWmogC93eI+OeucVJOLB+1grgEPceE6Pwrtj7jEOQQxxEt3PDLekMRLu/j23I/3j75G1TWwL5aFcvFBaMB3FIilRNe+VSfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615189; c=relaxed/simple;
	bh=+uQeYyAF0Rv5FPzwSKaZvjkt6+uke6CjVYhfq5mPwi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TazHbX/Rxl3E4+EBjdCyznqkx9Lx9nBoY6Q5hJ4Om1Xgf1aKkwNgEmT4M2ljuTRm/zYYGQ288PbUIXKFI91XOSLrlpg2F/gN2toerVvupAx9gdqAR0O02+Pnr2v3u42K1QMbg6u0glgPXh7/tAi6qWKTsc1N57ZCgvLjygwvR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m+30w6o6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5641U0kC020529;
	Fri, 4 Jul 2025 07:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j3eemu9w9CFQtsyEWTL5rnHCjpDYNOGd60WYH6zP9c0=; b=m+30w6o6YSDtCcF5
	F2yutAi56QGSdLN9Q/k/UitKepY5D+nB3xEa5GyWn6Ep9M68VQddBgIMRSz5vA3N
	hnIdb+6G2aVh2Ms0sLOoWwcvXpVFgAWmpoUIEgVYz76fDfEgccjgXCiv981zJg7U
	p1mMotelq5SbZpmPxsEUVVY6yJxZ4iyc/+qwwmLetuQZr1Lr+ZpYFVQtvVorxGJq
	T6Da+NQLkCWdUcYzKGYKTvBhpndZ5ueD+xVF+/NynMVUQtnSDu7xDLkivMPUFVw8
	0CRvXL6vmhRkVM2b8dvRJJRA8kMyRCszpoX6seaCH6kl+NYcvbEek3vmOcJY1sl2
	H8yl+w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mhxn9m2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 07:46:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5647kDO7023201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Jul 2025 07:46:13 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 4 Jul
 2025 00:46:11 -0700
Message-ID: <e61e6d6a-90e8-4ea8-beca-ab441f0eea34@quicinc.com>
Date: Fri, 4 Jul 2025 15:46:07 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/3] SPI: Add virtio SPI driver.
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250620041230.731504-1-quic_haixcui@quicinc.com>
 <20250620041230.731504-4-quic_haixcui@quicinc.com>
 <be751d7b-9216-4564-ad21-2df6a19477fa@quicinc.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <be751d7b-9216-4564-ad21-2df6a19477fa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA2MCBTYWx0ZWRfX7vBUgPs+tJqu
 GKErqzu0ERzobWwLChOnxNmdKHwyS8yEnHAkTKRaXJ2fBhNPe/T5V4e9kqhLwm/LjixbdHtw48j
 04MIAi35fA7BB3ZC7kxmP5VBzPjr37LfUzNFOjVdCwanoEVxSIg2sb1YFwd5Cz3jL4NpaSXGax4
 grlmWrY52byBNpnFEaCRAuG2ptjwC3N07H4T5nyp3xJ24uSnMazc/E4G6L6jYwr9ScdKTK0O40o
 bGSzkQO2TXcxb+mS6HxoKr6NVMlPKfWmcB++4Bc1flESYP8f0AfOuzOa7xETjgeY1H2EAL+f32G
 8Z6IMgckmkCXuJuEB5BgPkeXMS3mU9rok8D5SaQK7AWgBaflIwb4hn2rbuQEIf707askT2ohB/t
 hLGG67DdhOrvRXQdiF8sDgG8/Wi67br2oE+ex9hcb/8jR4/4UI4R8GN1FfmT6VSqQh/vUbN1
X-Authority-Analysis: v=2.4 cv=EbvIQOmC c=1 sm=1 tr=0 ts=686786c7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=PtJzcVZEaGJKxAWVt5cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EhNRYjCfvG1EAjZZuCcZaIEFpvzisDn5
X-Proofpoint-GUID: EhNRYjCfvG1EAjZZuCcZaIEFpvzisDn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040060

Hi Mukesh,

Thank you for reviewing the patch and providing your feedback. Really
appreciate your detailed suggestions.

On 6/30/2025 2:54 PM, Mukesh Kumar Savaliya wrote:
> Hi, Haixu, Thanks !
> 
> On 6/20/2025 9:42 AM, Haixu Cui wrote:
>> This is the virtio SPI Linux kernel driver.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> ---
>>   MAINTAINERS              |   6 +
>>   drivers/spi/Kconfig      |  11 +
>>   drivers/spi/Makefile     |   1 +
>>   drivers/spi/spi-virtio.c | 444 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 462 insertions(+)
>>   create mode 100644 drivers/spi/spi-virtio.c
>>

>> + * So the corresponding relationship:
>> + * A   <===> cs_setup_ns (after CS asserted)
> And "before clock start" ? to be added in bracket as comment.

Here I refer to the cs_setup definition in include/linux/spi/spi.h,
where the cs_setup is described only in terms of delay after CS is
asserted, without referencing the clock signal.

> 
>> +
>> +static int virtio_spi_transfer_one(struct spi_controller *ctrl,
>> +                   struct spi_device *spi,
>> +                   struct spi_transfer *xfer)
>> +{
> 
> [...]
> 
>> +    wait_for_completion(&priv->spi_req.completion);
>> +
> I see init_completion(spi_req.completion) is called during probe() but 
> successive transfer doent have reinit_completion(spi_req.completion). 
> wondering how is this working for back to back transfers.

In current implementation, each SPI transfer uses the same spi_req
instance, which is a member of struct virtio_spi_priv.

I'm considering removing spi_req from the virtio_spi_priv structure,
instead dynamically allocation a new spi_req for each transfer. This
way, each transfer would have its own completion object, so we could
simply call init_completion() without worrying about reinitializing a
shared one. I believe this would make the design cleaner and avoid
potential issues.

Is this approach okay with you? If so I will update the patch
accordingly in the next revision.

>> +    /* Read result from message and translate return code */
>> +    switch (priv->spi_req.result.result) {
>> +    case VIRTIO_SPI_TRANS_OK:
>> +        /* ret is 0 */
>> +        break;
>> +    case VIRTIO_SPI_PARAM_ERR:
>> +        ret = -EINVAL;
>> +        break;
>> +    case VIRTIO_SPI_TRANS_ERR:
>> +        ret = -EIO;
>> +        break;
>> +    default: /* Protocol violation */
> Comment in new line ? following same method across.

This comment seems not particularly helpful. I’ll remove it to keep
the code clean.

>> +static void virtio_spi_remove(struct virtio_device *vdev)
>> +{
>> +    struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
>> +
>> +    /* Order: 1.) unregister controller, 2.) remove virtqueue */
> Is this a specific flow for virtio OR generic ? if its generic, we can 
> remove the comments.

This is generic actually, I will remove it to keep code clean.
>> +    spi_unregister_controller(ctrl);
>> +    virtio_spi_del_vq(vdev);
>> +}
>> +

Thanks
Haixu Cui



