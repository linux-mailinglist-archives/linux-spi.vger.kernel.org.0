Return-Path: <linux-spi+bounces-8223-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197CABEB54
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 07:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D4817EA7E
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 05:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295EE22FAF4;
	Wed, 21 May 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WoGqUnhT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828679CF;
	Wed, 21 May 2025 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747805919; cv=none; b=EfkiiPMHVs/sJCxf3i7eAtZ02kL5h3suZZuHORCIBIXbAGcTJvyxqzJ7rYX2YXsNcQ5F7M5w+APECNZGqgmnA6RGxe5tk7236stYnsJf+On3FRquC6mHYQ9dWjaQczSFum7Ixq8IxFjQYT0wDXeIsBkiDF1erWE2y08B3JTpmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747805919; c=relaxed/simple;
	bh=WNvqHXW/Xhth82LmBEiT1VEhzAKX6LRM8ItCgjIPwGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FVx9v9oTmKDzIkXkz6/fTGDPWibmwyZm9JqXuJ1tSCrukXETcijxJ7dHgWNaAtAQs/BKKe3XWMMn/ZvPSQnj09uTLNca3W5jMSlVqAi4eeqaOoov32RbnycndXkZCW82JABUM++W0LJdnJ+IE1L5tQl/Ifr2SVuaNaaNCG5qVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WoGqUnhT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L5JAia019165;
	Wed, 21 May 2025 05:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1rIXHTD4csw6kw4kJQD3SUf479s6VR/JxiTwReVlOHY=; b=WoGqUnhTryWGHLFf
	7RC/X9H8XXL09zf+tY5lcWWfS5qEo2Jcj0fSPz+wbzryEc4yflTWeGXqCg5omNfm
	B4S5Gni0I2vy4GtnaQU9n7+URF+Ae9Rep5/SP6aXsLKqc/QF+TpOGXs9leyuBY40
	YfvDOTCPg5RQk8Vy9/HQMfZ4NyyLEC96A+2C+QyTLO2HNmkU5l1PrxRCU4Kz/M4M
	dgkWK/G+70BIWq6zjMvD7/ybCRla3HLM2YDRbQFW6Ud4JAssdU0aw7A8/Bgz0B25
	CZizA6dq4OD7RtZ5nposlOGOmi2pJVb/7JHfc3289JccKt2BMTjQbpba5ko40QNd
	+i2WuQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwh59mj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 05:38:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L5cGTs020104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 05:38:16 GMT
Received: from [10.50.1.151] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 May
 2025 22:38:13 -0700
Message-ID: <e9f460c3-a575-1014-cca7-27f1d79024e2@quicinc.com>
Date: Wed, 21 May 2025 11:08:02 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH next 2/2] spi: spi-qpic-snand: add support for 8 bits ECC
 strength
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
 <20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
 <8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
 <c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com> <878qn2nsa0.fsf@bootlin.com>
 <16195524-1f31-4968-a3fd-f3d24f1c4223@gmail.com> <87msbhezjf.fsf@bootlin.com>
 <007881c9-e03c-1473-d8eb-53fbad8c6a8e@quicinc.com>
 <87frh4ej87.fsf@bootlin.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <87frh4ej87.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA1MyBTYWx0ZWRfX/2G/PLeDfvwU
 AKDm/VEWgRmm5Je2fSjPQEqzqALTfgMTpAntgbAb9Qil9EbPOZPB47MqPUfSBwIyjOw402nNeoC
 JN5/jJIMo0OI4Y2R5CS8FDIgk4pOf45DCzfaPbByPMQGQVKKaOte9lq8CuvaycC3XH0h7VFXMAX
 oKXiGtDnVtRGenKiI9wj1RyO7kOMfdQ7kEPsV89z2kmWv0upEbiNXjYoQty9iJeTgQVq6+J2Ggl
 w5M6FcozbEN8U1gEs7stzj3axjfhzbKd2E2Z51tIVtsIpWFy8r4IJErsCEowo5+XVp141BfEYvJ
 WaH0pWvY2nO70BQOEYEHfS0pszW30XjFQFh3M5GSs4DT6KbPJk1l0/tteABD1GCLXTDDnOwEHKZ
 XqJXCd8Z1RWT3zZ2Hf7YN4LupesNQC+y7VvsPNFvdIbT6SVaDA5C3naxxzqZXa2YIIDlL4MD
X-Authority-Analysis: v=2.4 cv=XeWJzJ55 c=1 sm=1 tr=0 ts=682d66c9 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=1P9lDc0nu8lX0kGsQioA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lX6Lf87Bh5Z_R65mhOqeVWWz-ecQjf5h
X-Proofpoint-ORIG-GUID: lX6Lf87Bh5Z_R65mhOqeVWWz-ecQjf5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=831 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210053

Hi,

On 5/16/2025 7:44 PM, Miquel Raynal wrote:
> 
>>>> Interestingly enough, it reports the correct number of bit errors now.
>>>> For me it seems, that the hardware reports the number of the corrected
>>>> *bytes* instead of the corrected *bits*.
>>> I doubt that, nobody counts bytes of errors.
>>> You results are surprising. I initially though in favour of a software
>>> bug, but then it looks even weirder than that. Alam?
>> I have checked with HW team , the QPIC ECC HW engine reports the bit
>> error byte wise not bit wise.
>>
>> e.g
>>      Byte0 --> 2-bitflips --> QPIC ECC counts 1 only
>>      Byte1 --> 3-bitflips --> QPIC ECC counts 1 only
>>      Byte2 --> 1-bitflips --> QPIC ECC counts 1 only
>>      Byte3 --> 4-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>>      Byte4 --> 6-bitflips --> QPIC ECC counts 1 only (in 8-bit ecc)
>>
>> Hope this can clearify the things now.
> 
> o_O ????
> 
> How is that even useful? This basically means UBI will never refresh the
> data because we will constantly underestimate the number of bitflips! We
> need to know the actual number, this averaging does not make any sense
> for Linux. Is there another way to get the raw number of bitflips?
I have re-checked with HW team, unfortunately currently there is no 
register fields available to get the raw number of bit flips. But
for newer chipset they have fixed this issue. But currently the QPIC
QPIC_NANDC_BUFFER_STATUS | 0x79B0018 register bit-8 will get set if 
there is uncorrectable bitflips happened.

For 4-bit ECC if 5-bit raw bit flips happened then bit-8 will get set in
QPIC_NANDC_BUFFER_STATUS.

similar for 8-bit ECC if 9-bit raw bit flips happened then bit-8 will 
get set in QPIC_NANDC_BUFFER_STATUS.

Thanks,
Alam.

