Return-Path: <linux-spi+bounces-7870-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FEAA805F
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A460983013
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7A1E7C1C;
	Sat,  3 May 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pAG4AY+F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500E78F59
	for <linux-spi@vger.kernel.org>; Sat,  3 May 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746271068; cv=none; b=bI+ENU80E0RLopZ7/yMFTiDsBX5Ig93CuS6ZmF/XWkuqxDKz9W+GLOnq/8m1978SnP1xGzqNXi3SN//mJx7QFTrKnHDZLWMuwsgZuokKuv0Qdsbmn0hrfYa1zshZpoPAa6iUxTgVpesVxACXCisylHV+EZqkuOdzPjmhJJT4AZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746271068; c=relaxed/simple;
	bh=osPDfcecZqVOsBKtOG/9K12hOUEbQ3zRaBPBK4271XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rO6Covas+LCDVUFsAykXDsO2M2292CnFrWL9AKqYXIzDdcGT27hGDuGohAA4flpIdIjOgEkh7J4dB4G+S3V4sc0QztG3F5V3EZYV93tcAMD0rF3G9qixPRfKze2Zqq8zsAUbK8SXVWcBr+1nYHhJEV08LQQt2sT0AcZiOaA4JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pAG4AY+F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5434eG4J004905
	for <linux-spi@vger.kernel.org>; Sat, 3 May 2025 11:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyCrKhEc3d77syMYDxLeKe5vR94keERW1gwgMtjT8+Q=; b=pAG4AY+FuNhNdA6F
	hAXgDOJwRW6pD8F9mWi8SqhV0bW4f0SZA1GnbxWMyjaoUky4PkcaPm1Kmu+1eJ+c
	gRQv2lgFjXWBVH/pQOvbXu3vOp9dZglbOUTx9vDTzWIjbigFSnqeTL14AUVPNbOL
	2s7hU7kNpwPowHiQnRJh2eUqVegJUaCIeS0hkyB6OUiwFLVv3Rswk+O0KJKVskjd
	1IH6qtijqeJfZjVruXBnng5KlMrIWE5OQnG9zqdHJNYOxbGV8/QH3KH6qabkSNSr
	8ng9iSmaLmaBVA7x0PzYzR3enCtHa6j3Xl1CAOzePuNc+JCe0ZVBjEK6TgmFoUHS
	LaQIMw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dcakgec0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 03 May 2025 11:17:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476695e930bso7212571cf.2
        for <linux-spi@vger.kernel.org>; Sat, 03 May 2025 04:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746271049; x=1746875849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyCrKhEc3d77syMYDxLeKe5vR94keERW1gwgMtjT8+Q=;
        b=u5Onp0U7UNxQxAKKazauRHY5YQZpfhDKords2DV3642diQ4q/EttyulSNftCkKS7/m
         C2u1xJmAf2JZnPznBqxcBXz8z6x86o7vR+lJdD/kK+z5bPr5+pG+15QP0WjOIPaIyA13
         nntmfw+oIlRkaKtGOgEbNLAuUJQSD9b0OAfFaD0l2tdE3DhqwO3kicuWs2jwLQmaiVWc
         raJfWXrI/eVTP+MfhzoLnPvIoNp6WxCnER3eyEnMk2PaUY92ZFR4ARw4RpzVVpKgR2zi
         bWrRumGEEmA8QZbunhBSMf8eJIJexIsjHi+TnPiDvnrRJfMVcBJDKwnYPBeuJcb9VLgw
         s2vA==
X-Forwarded-Encrypted: i=1; AJvYcCXOfaLgXefsmCZk+gpBuN0Dk39OFAa03ONeYmmgjbCq71bsKB+Etwqv7joL78svp1+P/HOLX/w65yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmogsgojU2J+PpXFPtWKnN3odDIK/zUSZdWnSLOE4ud4GqX4Q
	Uyg5O0Tgmrq7db46h1ww0vuk4sG6Pdmf0jWJqVKKiHgDVRbPpkqA5LhvNKYShZ05TnvuRp1cSLJ
	tsTn7vn8n9OybaV62wTZyRBKjnvhuPbzuEmviwCaL3KbsjzQbl+zA3U6/OJo=
X-Gm-Gg: ASbGnct0sa6sFymJ6pd3Y8nh6Q+DM9w73QUegIG3Ql0UBVdbeG3r7BF3nYHd3lKnOQ5
	9E/K5YJAisz2r0zc2Y63cbE7l7VpWfy2ZNHj45y1M1aeR4JkfpHw19cyPhThl54Ge0S3tDhvtSx
	vPFqDQ2/jDk72Z8bDQ3cpej1vAE+XvUpkG6Y27MmPyL4fwovJCnvAvUYZSdP5VCp69CmACAEyFs
	f0SzZOzFnoPBT8Ptfp3Sae64Ay0b+EhSZ9cZKYmP3ZgcXBspdVieFMXuBUYm2EHjOF61TqR/fVS
	FJieftY1cpqkAxdqtZdFEFLjol500CPrW7TwVKI/Tr6vqgYtvsKAzdwAaSnRG36FH2s=
X-Received: by 2002:a05:622a:2cd:b0:474:efa8:3607 with SMTP id d75a77b69052e-48c30d83db9mr29110281cf.1.1746271049026;
        Sat, 03 May 2025 04:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsRcL4YTCQDoV6ZBGi3Z/iVL1bqcsqXiphj3Oul4isaynD9De8sYSJHbL7Ynpk4VynGPsXYQ==
X-Received: by 2002:a05:622a:2cd:b0:474:efa8:3607 with SMTP id d75a77b69052e-48c30d83db9mr29110181cf.1.1746271048650;
        Sat, 03 May 2025 04:17:28 -0700 (PDT)
Received: from [192.168.65.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c024asm178441566b.117.2025.05.03.04.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 04:17:28 -0700 (PDT)
Message-ID: <c55d718f-00fa-442a-b67b-9a678556a2a7@oss.qualcomm.com>
Date: Sat, 3 May 2025 13:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] soc: qcom: geni-se: Add support to load QUP SE
 Firmware via Linux subsystem
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        broonie@kernel.or, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20250303124349.3474185-1-quic_vdadhani@quicinc.com>
 <20250303124349.3474185-7-quic_vdadhani@quicinc.com>
 <2kmnhxj3je366livo67btpbmjiyeyx4q23of42ng4co6xngemj@kitsdtqepgce>
 <e0916f4b-d2be-46a7-889f-2eebd12b74d0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e0916f4b-d2be-46a7-889f-2eebd12b74d0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDEwMSBTYWx0ZWRfX3jKzjTwYkJDi
 nXFevA6aUtMJJIuTAS7MUqtZlmIITLeaa71WLahnu6NJ5gG9FXVOY/EEqX5DaRsfwFNhfZgYpiC
 afgqvN8ecZ9JgWRlsVSh4D9IxIwBJL6QPGVBP0uhttf9hxsQbi6uOsd8+d/7ShOjo/WrVmtvglQ
 aSjhlSRfTwUHISqN9L7Asfp0E0HNtUaS3BGpu1InSOhJ3WM20v62DJDzkSU2uUHUlMfLZKeYf5w
 DgzjX6m+Y8Rf4LItCjQGZ+sF4Dbm0klCsjfFGIcpXyYJPXvYMF8h/Rk97irwNMvphq9EgkMYFzA
 4TKSwfrwDZIiVamD69Qy9Q5/aIKrcpvsfdog2NZ493YHtN8Op8DUKJT8LUawTtngmwikT+tQfvD
 bh3y5SBtz9Jn67VdD8E13QYCr8OrBu9PwEtsnCGkPOVLZkip3M0Lqo8pXndvZX+kk1vTxbBO
X-Proofpoint-ORIG-GUID: 4v5sn-8Ynw41_R9yJd3DhGZppTBN9Q4j
X-Authority-Analysis: v=2.4 cv=JtvxrN4C c=1 sm=1 tr=0 ts=6815fb59 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=dnXBaztP67eYbQVX14EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 4v5sn-8Ynw41_R9yJd3DhGZppTBN9Q4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505030101

On 5/3/25 1:11 PM, Viken Dadhaniya wrote:
> 
> 
> On 3/6/2025 4:57 AM, Bjorn Andersson wrote:
>> On Mon, Mar 03, 2025 at 06:13:46PM +0530, Viken Dadhaniya wrote:
>>> Load the firmware to QUP SE based on the 'firmware-name' property specified

[...]

>>> +    u32 magic;
>>
>> What endian is that u32? Please be specific.
> 
> I didn't understand your comment. Could you please help me understand what is required here?

External data can be of different endianness than the running OS.
This should either be __le32 or __be32.

Konrad

