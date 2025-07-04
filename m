Return-Path: <linux-spi+bounces-9039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187FAF8854
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 08:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6700B4A3849
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE734264A77;
	Fri,  4 Jul 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hn1gtQce"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB0264615;
	Fri,  4 Jul 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612067; cv=none; b=INwqgWHiIrAgwojvyA0n3qgu+UBCigIMmbXjepWq5CO02YNbUAnap/Pcn0ZhIO5PmEyvf33V/loqDlfayl4s43awgXKlsu9TUDu5DamjtXh93Xtd4grEiHLyydwTK1NvqEgnl+OO+3u17Fb8V7gFvbEd7gRu6Z2KyehnVK6C2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612067; c=relaxed/simple;
	bh=z6tGLWoV40fbJyXLNAI+FtkufrSO5BqpPKdSK3iZ0Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CRXjQKEg+RTftKqx4ddsp1baQa3uEUQuyxLNVYR6M725M9YjtpGOac0mV0AQvoBgPacTaSdELp+W5qebhjKoyQ8EAkwcJJ9mCKLYZeDiR1FLGKnb1fiP7N+wYtkNvZPo9ssvFAmsHcakeVNMUVIXwIfYSuqn/9d1mQPewVqLiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hn1gtQce; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563GCl1F007067;
	Fri, 4 Jul 2025 06:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wZEI3ggObilLEiLudoV157ZQ5GVhwPZ91BoxAzz6WAY=; b=hn1gtQceJN9YIoOA
	fO/OmfNrN/vdwIWIrmkHgF/410Xy2uZ69CLDrgSK+MjFEL3CkrVVoJWMPm1dvCUI
	YjW5cTCzC640Ry8AgOMaIXvfgAIKV8GIb/Isg0WwWekzjbo3f6dDt68hynlx2XSQ
	5W+XWSoQ7pggT6M/LIMxtDU5KrM+qM5reDVKWt+T29zVLl97FWc4//UzYwvSIbJM
	bLN2t6zOc4tFkoHV9nLSZsQCvN633ti2JlW0wmKI217r6l20L9SYbX4ag5jxgkac
	q68HMsGk99v33QsAvoJfFfarJeI9Q1S8i31kWBdgb8NRXFwD+zd9c9jz7tQZCT1L
	O1H4Jw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jqb2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 06:54:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5646sDV1015451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Jul 2025 06:54:13 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 3 Jul
 2025 23:54:11 -0700
Message-ID: <80b54138-b5ae-49db-8e94-42de6de05bf8@quicinc.com>
Date: Fri, 4 Jul 2025 14:54:08 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/3] virtio-spi: Add virtio-spi.h
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250620041230.731504-1-quic_haixcui@quicinc.com>
 <20250620041230.731504-3-quic_haixcui@quicinc.com>
 <1382320e-e5ae-47c4-be82-ab438032eac4@quicinc.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <1382320e-e5ae-47c4-be82-ab438032eac4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=68677a96 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=QJtq3Um7bvPkYqldaawA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LRGiIWRl6RSwnRe6sGI1M5mStYhnzrHw
X-Proofpoint-GUID: LRGiIWRl6RSwnRe6sGI1M5mStYhnzrHw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA1MiBTYWx0ZWRfX+27AnD4Hs7qw
 oxzDNY/YdRd8mMZoMUgTdFYZ+6bey6MAhN28Wk5l9q9BQCIRm5ghlHPDIxP9xAtzsaYyF0uz5MZ
 VlFUZztGOqZ2zhojDb/pX6tKLEHA48EPm17501PxKJ1H0dNk9KNEhiQCmJtTfLcMUi01J6ZsC+T
 y9wYercuJy4GYQ+LvgVrxcmwvzqukDl27ZHf+R3akd+/E+R5Ypy1hdPBPem8BONQZImBefbhtmg
 sUyhS5u7VsIyTSWNcWGk+j86qXdGl+M+wZ93DwiiEXAbhCU6/6c8znxVk7uj/5aG/b9foJXqIVQ
 a2z8OWsudenJXx7qAohrCFjRYSfZCZlKnrNG5t98TH0aHMrhH7NmcVk5FR+vindaQkq/YtqzxlH
 zVK2cstkutfbn5IGBHh49ofaUBp0OK4BYEOEgMLAnq9qxifu4dD801UNyEbEuMSAnhvq8zcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=818 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040052



On 6/30/2025 2:59 PM, Mukesh Kumar Savaliya wrote:
> 
> 
> On 6/20/2025 9:42 AM, Haixu Cui wrote:
>> Add virtio-spi.h header for virtio SPI.
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> ---
>>   include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>>   1 file changed, 185 insertions(+)
>>   create mode 100644 include/uapi/linux/virtio_spi.h

>> + * @max_cs_setup_ns: the maximum delay supported after chipselect is 
>> asserted,
> And before clock start. may also sound good, if we can write "delay 
> between CS assert to clock start"

I follow the existing comment in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/spi/spi.h?h=v6.16-rc4#n166, 
where the cs_setup is described only in terms of the delay after CS is 
asserted, without explicitly referencing the clock signal.
To maintain consistency, I kept the comment focused on the relationship 
between the delay and the CS signal alone.



