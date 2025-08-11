Return-Path: <linux-spi+bounces-9339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7114B20A2B
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB062A4BF3
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287E2DE71B;
	Mon, 11 Aug 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d6lqIoz8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF92DE719;
	Mon, 11 Aug 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918781; cv=none; b=VDVUylVxbWRIM6ubMWTQzKiGWCCI3rgmnyyKZB1gEjbctU7uZ6sq+udpK8rMPyH7rgKpOCH+ruMqBtOHNMdF32KMbAQNycIp8bDHQUB7DGjZW3CF+eHYJZPvUeFIgy5MB+vOLl7Cz1O+J+4Jx6JQsw0IHNfHFZ8D9U791EtSXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918781; c=relaxed/simple;
	bh=UvZzRLb2kJ4JP5rAze0Gg/5rYXZ7BfuPSOtgg7OUmPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ruOUEjgQw+qddpEpOCEJnDEalIKGlyqn1wxdDjk5hPrC0wyIdDoFbOfaO7Z1cCdUvE6RogWY4NiBtYwMqaotAYusZE+kzJ++Pfj+VjLChAKcefAJoqwZon9VG4mFfzJjHZJaHiX0Rpc22eOOIHZlekiLiRByBva0pLEqPIAFA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d6lqIoz8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCYg029237;
	Mon, 11 Aug 2025 13:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h+wDq+fb2WHbgGGhmjribLcUA1pN87HNFyWJvShYjzk=; b=d6lqIoz8BlpvXM/4
	q0sdkyyKwbIf8Q0Y1jPSgLjRm6lUYkqJXm6koS1ucfAZQ78cSE4DZqEVhVRUD5W7
	dPU1gEiIhIcdgXAU4JcP6zbuk+cccqy3POvc+G83659Yd3UfKwW+fPTT54nwHH9B
	pC5wQzBw2sEiJJK+RaIlZaOMk+btiCT1RqNqgCx8lR+1rM2Hio2bYE1MyUgdrfre
	syloybf1BncGnkjoo6Q+VocMw9W7pXxgx3DnlMIsQkU/GauEPWeUslmzYbqTBdYQ
	gh7iH9DMelsjBFAKP6S9vqBtzA53E5wImQm+Sj+909dZokYlD901/6B0KMAa/Pvo
	vkUH8Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmch0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 13:26:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57BDQ5GJ008167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 13:26:05 GMT
Received: from [10.253.78.95] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 11 Aug
 2025 06:26:01 -0700
Message-ID: <bdc543d1-9851-4b04-a287-f7763aca7ace@quicinc.com>
Date: Mon, 11 Aug 2025 21:25:59 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/3] virtio-spi: Add virtio-spi.h
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.oasis-open.org>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-3-quic_haixcui@quicinc.com>
 <ff409d4e-9e1e-4649-8895-25d9ffc495d2@quicinc.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <ff409d4e-9e1e-4649-8895-25d9ffc495d2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXxu6y1ShkpB5m
 kqGzOHJMwmeKLsSaGq2ACBWuPT1Mcuq1ZezRNpdKaJFm8eA/znQ2UrznX8XkOcsSyJnitZhbIQX
 fX0CFy2qL8PeccKQHaZ+UK0wCeDuEUqQtJiFkOtjCFzKD9R3AUajHhPj4zXLTo774WJ5Kp0oakQ
 77eZr2AleNVPT60cIbmcgw6OigB4o7raVed4i+2N7cW+Zj0Y5eCVFZV+++qDvGMiO+0YUp7eEL2
 NA+liP7DfZXs/Ol4EBxDPgliiNK9AAbEwuq0pCaIv/4JUBif/GMGv+NYSI92TBXU48GiMkMBm2z
 68L3EnaX9reiW57A9R0FWom/U/aJcffjh7m3U+oXr/6mh2Df30s23QkHUZg499N6wLA/3o8G5ka
 wK/c+FvR
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899ef6e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=yuDjC0XFS9RB4ZKM4EwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-GUID: qyiT86Mau4oNk6_9M8QxXXnTHx7xb13O
X-Proofpoint-ORIG-GUID: qyiT86Mau4oNk6_9M8QxXXnTHx7xb13O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

Hi Joythi,

     Thanks for your feedback, please refer to my below response.
> Instead of adding "Note:", can we update it like this?
> 
> @max_word_delay_ns: Maximum word delay supported, in nanoseconds.
>      A value of 0 indicates that word delay is unsupported.
>      Each transfer may consist of a sequence of words.
> 
Yes, will update as you suggestion.

>> + *
>> + * @tx_nbits: bus width for write transfer.
>> + *     0,1: bus width is 1, also known as SINGLE
> Do you mean to say that a value of 0 defaults to SINGLE?> + *     2  : 
> bus width is 2, also known as DUAL
Yes, a value of 0 or 1 both indicate single-line transfer.


Regards
Haixu Cui

