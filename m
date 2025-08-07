Return-Path: <linux-spi+bounces-9311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839BCB1D49D
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 11:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEDD3B4DBB
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99802AD00;
	Thu,  7 Aug 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D6Aab23q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827324B29;
	Thu,  7 Aug 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558198; cv=none; b=d2Ont/Pt3u0ZpgXQiOvhfB7KiLytYEJS/Hj+1sNdOq4IFPGqcH/TtASDbhw/4W+tvCCKWdugv+ND5tL6QOnRDa3KtrlkLzFQlJscGk9MR8AM5/K65VJE2Eq9qSUem6N4CtHJAzvC8EJTaBGi4trGkVHFlFAtAOUa5DCmsMcfrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558198; c=relaxed/simple;
	bh=6iqrnOYYLyzkebV0B++6wAFa+s7dj//oSdXPQIZYi44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=im2y+MZHoyUFGFCqcP4BOQcGUqz6PA12nYggmvUSi04w46jaU6BiekWlIUI7aGjMnsO5ioYMY/d6zNJX98a2Wo3INWLIHMSgz5pew67kZqpVYZcZvASReUcF7mhXGhmfrMTaIKjQfeVX60FaiAruDppEzSf+r25bYA4sfN3Faos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D6Aab23q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779CtYY011664;
	Thu, 7 Aug 2025 09:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cpP2hSi7/Vhx0v9dxSjlQoY4/hYRFnUAC1G1O8b+8yE=; b=D6Aab23q2LHDnHgq
	vOfCf3FlxoYZke+09LECx/aGqV1s/sQ/OiUCYsWnpf2TZPPvM7wqW8pTy+DDHwQH
	lkN3Z5wm8Iq01o8s7bXvgYAlF318fr7s8VJdpZtFgFb8O5O4buMQsdXbpnn9S3tZ
	Z4l1EivIO3CoaNm7+a8Cehe0jPUZBVmnddUbw+7dTSQQiNJep3vP6wfAAxP/hj/V
	v1IhJ2jNJvG7Ec9lpV3JpIh4hn9SJkb44VoSM1BYf28XGlHARFbkpF8etBINgFNA
	lxfJj0f/kgcttx0iTUGfgBO4Ywcad/meNRHDWTtAgZvlne0Dyf5ymoPERu4geLfF
	ajqmTw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy0fyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:16:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5779GO1L016072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 09:16:24 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 7 Aug
 2025 02:16:21 -0700
Message-ID: <436fc0d5-2959-4364-93b4-7a14d8e2cb99@quicinc.com>
Date: Thu, 7 Aug 2025 17:16:19 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/3] virtio-spi: Add virtio-spi.h
To: Harald Mommer <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>, <matti@qti.qualcomm.com>
References: <20250724092746.1297608-1-quic_haixcui@quicinc.com>
 <20250724092746.1297608-3-quic_haixcui@quicinc.com>
 <d962ed41-2566-432d-975d-9bab8d844c70@oss.qualcomm.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <d962ed41-2566-432d-975d-9bab8d844c70@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=68946ee9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=7kKVInmZTBA3fObjQNwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HPfRBmeH8rVQ3EcCbs9kAurqh1G0Fra1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfXwcOe3Gf6kyCe
 zn3oD/H757SFdJiCTaEGRII0/UtWY4r9HLrhX5t6cKwQS7bbs5yr7JlMlEN8/SNxdFxan4rigHB
 cD8DBwMkbbcBUK+iUxDtsJGuh7D4REp8Eu1uhl6rCV08A9sr2h6f65vxokSvf4B8NvChg5eorDb
 D4UsiNtlwm2KFG5gRVvr3xp+s8FE8XGvWCkjDyd5Wz2/gqR+094EJP8Fy/wHoFCkRuddjperpmO
 dBc6fQF5zR4jAOZwOK69rJL5lDzyjSpvefoSyt7NHK5+knGI1GY7EI7coYmVPR6YQnU+VrWIIPf
 h+TKUCcG9RrWba2LQ/7KhRQ4SrpK0p4rXFPIcQurm60/mo4cv4+7wGLTJm45SBRAnuJwCgGWbvu
 u9EJ66J5
X-Proofpoint-ORIG-GUID: HPfRBmeH8rVQ3EcCbs9kAurqh1G0Fra1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046



On 7/30/2025 8:31 PM, Harald Mommer wrote:

> 
> Policy was to keep the old OpenSynergy copyright notice when up-streaming started when up-streaming started in OpenSynergy times. This is also the case here with those files.
> 
> The old "Copyright (C) 2023 OpenSynergy GmbH" still present in V3 must probably be kept on top of the Qualcomm copyright line.
> 
> Re-checked this in virtio_rtc_driver.c from my colleague who also transitioned from OpenSynergy to Qualcomm. Virtio RTC has landed in the meantime in the mainline kernel.
> 
> What's for sure is that this has not started in 2025.

Hi Harald,
     I've restored the "Copyright (C) 2023 OpenSynergy GmbH" in latest 
patch v8, please check, thanks.

Haixu Cui

