Return-Path: <linux-spi+bounces-7315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE07A716F5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE751173C09
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEAA1A83E6;
	Wed, 26 Mar 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/ebEhV7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C0158A09
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993734; cv=none; b=OYIbEBVH6sZJq7d9/V34+ZGfOSumXtMlgdt2ksAqbkmL4tL4Ev1w+BBzGW5U/P07dPr2oAHH6WkqFCWBfsSDN9I2na4ustWtMup3wxPvmW/mYbX/3OT6tlOTDBfRZBV2W7PlToqhzA2CFjqmCvNzSFQsYF5gx/HtkQDZVwPrfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993734; c=relaxed/simple;
	bh=Hlpcqk5lqaENv3KqC4F73OEnJFQv5GOY/52c173rl4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwZdkQqFnuQRilkr4RsASUXqr3F6OyBw0Emp1ZE+TFHRaG89qt3JO/FL2egzz0aiSkDTScUWPGHSQM27E4/YcozeJeqYITw+tzqrWm/h6VcFtNhimmjNoE3nwwau2VRJdCEynWUBPODOkMDLtSaxnFRnE2QSTa/md4LcE4E8smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l/ebEhV7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q739x8014432
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 12:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hlpcqk5lqaENv3KqC4F73OEnJFQv5GOY/52c173rl4w=; b=l/ebEhV76SQj544f
	+Y9r1ooTACuPTCY63Yqe56Nqli39mCMsLBfhIwNpvnuSkj3yOVipyx0k8/Bd2GUA
	odTtkngLscm0xc5KyIbSwBzZ03m/9Oe0UyQF9sWlt8QNqmMbWi9L3Hc5Qo2twtjp
	qZuEPh/13Z9ajYyXJNLsbjABFpEEA0SSW2kShMdzSdQUq9IHSBylS1ieI3jB938k
	0dPGaPBj7tQCeUQrRAKCnkMhUXm1tPK3crHcfynVoflTZswRKFa9IWO7Al28g+nE
	DKJeuDjYII7JnYL7mcz94MJyWKQPnquiXS0XJiqT+RcoFcUdqqoOSJyKN9tQD44n
	xovTvw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9ms9ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 12:55:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c552802e9fso204878285a.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 05:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993730; x=1743598530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlpcqk5lqaENv3KqC4F73OEnJFQv5GOY/52c173rl4w=;
        b=RByyUaOQtcqSNwK57cByVi3uDoxFfHozxC+BqTGkNjh9LGo70oXjXM3OKzbFUdQtt/
         jEHAxdo9+vigpfhVMxoo/2/FdgkIaoOdN7RnqYKJoKgv/BsLFh4/S4w87t4Ece3eNFld
         15kAi9GPqs32hY3r+aY1JXmjFyb4Bzgro9gXpYB6O95psM9shHRwp/9cphEa/UbG+WzR
         K2qVLBvQT+Pb/KU7e4BPpofrdOngMvUZZD5hGFM4uLZBlbskpetzeXvWbo1xGRRdwWgN
         BbdfkMQUyUEhdJA/08kCmrlbSBrSnSeuLqMTT5iIILM81xeFVkltevNAQCj7dAF6nY1K
         3iow==
X-Forwarded-Encrypted: i=1; AJvYcCUEbX60/0C3Qbd53588KMPkTGzsZ4HlFfAIyO9+lQg4wABzbR4+8SWlUxX8ocpzxDi34QeUdU4jkdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3v5VSyN0YXKO2qr92uHkEGAhtq9zAWmYuUqxMbovrnanzHV8C
	/LLf1J1UYE52AJspo+vn7yPWZZ/jacaLbEk5r0JER7gRV3tTx7anZyGSUn5NMVF4kGwa8LYkQgn
	l2Y63pIJIpb+XjCfb5GTQizHAX4lGhXiv9uKQ615Y11vvjD7CXuOELiun7FA=
X-Gm-Gg: ASbGncs1zisKXb4dnYbV0LpF31q6Ra8jTPlz7kBn62ESMvBZalilX8oEyPkzkVBIzds
	vCNB/wZs1EdJqj2hrbcmMsk8Q3Mk2SMnj2/iAIWA9wyc3kvx6rLH4CK8BnszGoOfv9liHWwURui
	WtI73B70HQ+S8V7MZLp8c5PMGWQpaA9N5bQdE3ihfZc31my4nysXMBTCRMvtYM2c7n6yI/dTyFR
	15x/33NfJRs3NAqCAJ11Xi/EGKyjcrgBQn5A9gw/8IY/+jQBbM1eGf1ZEGXuad9pl52PqNAMV31
	XPixchOx+ggM2tEVWif+wIRJwdrTFVGSCoBvtaokqzOCtGIMkC5P4+NGq6TmW+I4h6VcwA==
X-Received: by 2002:a05:620a:bcd:b0:7c3:c814:591d with SMTP id af79cd13be357-7c5ba12db8fmr1183628185a.1.1742993730499;
        Wed, 26 Mar 2025 05:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWjYJmUaR2pS0MBM+C9tZ4PgAEjRTIBh+2Os/3Hu9gB8kQ2ZslbY19JmbOXtqnWcm0svpCcw==
X-Received: by 2002:a05:620a:bcd:b0:7c3:c814:591d with SMTP id af79cd13be357-7c5ba12db8fmr1183626085a.1.1742993729994;
        Wed, 26 Mar 2025 05:55:29 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0b99fc4sm51757966b.85.2025.03.26.05.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 05:55:29 -0700 (PDT)
Message-ID: <b1f16d67-b61c-44ef-9e96-869aad0e17c8@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 13:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <d6210c5e-339e-4feb-ad4b-fad456ec5710@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d6210c5e-339e-4feb-ad4b-fad456ec5710@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e3f943 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=qToX29ahzgIKO7lzqbIA:9 a=QEXdDO2ut3YA:10 a=ibwWHe-yqzEA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9gXB4Q5-h5TVTLD_LYbjW9nTDcT4Lr8u
X-Proofpoint-ORIG-GUID: 9gXB4Q5-h5TVTLD_LYbjW9nTDcT4Lr8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_04,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=823 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260078

On 3/26/25 10:21 AM, Jyothi Kumar Seerapu wrote:
> Tested-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>

It doesn't look like there's much to test here, you may want to
leave an a-b or r-b instead

Konrad

