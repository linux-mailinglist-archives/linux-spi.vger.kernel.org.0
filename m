Return-Path: <linux-spi+bounces-9880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC8B42249
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C981B21AE7
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5330EF61;
	Wed,  3 Sep 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UH1qtGH0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998730DD1A
	for <linux-spi@vger.kernel.org>; Wed,  3 Sep 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907016; cv=none; b=DTyu22rhOODBtcEcZv7gu0xHLV71R+R6JBT0prwZCfddBAfh2Saw4BJmMpSOOkx1IAUWyEnq9RNqDx4XjOUIqrgtZBClOtR/mz58i7SZY9LFZPQ7YzF2A6Jft5ZmwxPxcDh2sXYcmwD2A7kYoI6mMfANffWb9y2Lqhgp3/x65xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907016; c=relaxed/simple;
	bh=J2saHSevTBJMdQGQ/k91nD+umoYJ0UhFnd6gQFsyAaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxZ4Nkb/gaIdvz0HCfQm0iTN/qDzwU28AgM6xtT8B7kS5hHbPJAIeEWk7j+W54Fx72SIZj4Mr5/Gx8dmjrJkfbKRroUyc8EuJJzMyKs6kVGKYePJ5KimUGHqHZIKTvIQxwSusr7OrtXI9kI5FnluowrB+ppG8hvAuNKPkifIH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UH1qtGH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEtoF009720
	for <linux-spi@vger.kernel.org>; Wed, 3 Sep 2025 13:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NhAEVb6Y680w1OtPE9Ykdv0IK3xbZmfs2ASBVN73JdY=; b=UH1qtGH06F5VANyt
	SwvNUMngVUmItbvUX8SL9y+hu362Pwrcw+SUtieT+429RsloOLjAVd2akdLzqQOo
	iP1mPbKYoX502uz5pRx3YdugHFLOFNt3j19T/ru9nHQ70AI9v1UZPFKqli0mpK5H
	kmB6vHBq7A1iEnhja5cm+j7e+A4Cks59rW2EbdsWV/+H0blYVR3ElttLP4ZRzek9
	ptkTlctmEy95uyZ4SBXg1WBM7vfzECknh028d7FxTNqpE4EurBnLdPe6gY/JAJH4
	cZhqxxuETUnwg3U7hxALCgMRGmQgt8mKa05h/hz0/o2c5OaUw0QQEipPih8JSJ96
	HHVZ8A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8usq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 03 Sep 2025 13:43:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b33e296278so4827071cf.0
        for <linux-spi@vger.kernel.org>; Wed, 03 Sep 2025 06:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907013; x=1757511813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhAEVb6Y680w1OtPE9Ykdv0IK3xbZmfs2ASBVN73JdY=;
        b=IkRY0k2gp15PiQTLSHz+4lRizdaAo8TK4tokoxrkia6s3rXPJ/UG5LQ4NkXM+Lb2JF
         nxF4e63Vhq3s16+aKIrLLYzHVSiEa5sg6FdXD1sZ1An+4IlNVJSh9Z3cS9c/jbCU1bWR
         LvtnKWAcTD8HQkpSvEsFH2YYNSQ9vF+PTFYQBFWF+NlTYE6vmyWgeGjb88sNtfwNPkH6
         85thKFdoMj4P02HR3s9gfUMn2Uautmqqtc9xfCWt91eixTx3uU6wbxkFQjYhaxMvdnMz
         lkq1BRC7quOXIYZBf+YLx9o0Z7I0nD799NLsu7+Ps+AqKyDbqFDuCbK4/EI1r77eA2ui
         O73g==
X-Gm-Message-State: AOJu0YxS2pyTYqJo/34pPXm0zqL+rsWVCLctBAP45kWfTjEnrRuac5fj
	2I5MUhGpkSG6CF5uxEXC/ZfnJ5nKaTvRwTujAAy+iC3ArU+xPZyBTQM5UHNAlUUaa0gepoIfnNp
	iXq1+e2ZL5DPkRBl7E6p7bEvKBT90i4S5CygI5zX4bJPI7+MnMHswhs8qFh5gBKE=
X-Gm-Gg: ASbGnctdu+zuRA1jybShigUMsPTe6/gXQS3vT7aG3AM3I7Mx5UyRkm7fDuCMnJlrQAN
	q3DC6MIJaylyllVgPgHCwBtOJiVMWSLMl6Q0QLR/Mrn9ivJ4mqbLZRKlvjdwM3MJu9/d74zZGzn
	mEMLA+JMX9gEsMQmKcCfrQVLCsoVwc+pGdA2kcLKwp7M/msCX6VYTye0AYqGi+zkxUjmyVGPtXk
	MljC4wiQP9Ac0HE1AHNPYVTbDhMOTkQ+pPYh1GkRl4UH6BUyx9jWKmEwuwwhh68ugbAsBQy/MAt
	SU8dB+pPJBEet6w054i8970btaB5C98L9zyaDfHseRUeAqJy5PlWgVvYA7umu8Af+jwN9Xm5kdt
	+/e+hKBQ51RCNB4v024kt0Q==
X-Received: by 2002:a05:622a:1b92:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4b313dd0270mr155416931cf.3.1756907012991;
        Wed, 03 Sep 2025 06:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF56Xam6gZtEwPzJFWPQ1ApnzKwNAHz4Gphd/ZewfD8xSeb5FB3EyFo/YQ8Z02OaDwf9p54/g==
X-Received: by 2002:a05:622a:1b92:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4b313dd0270mr155416621cf.3.1756907012428;
        Wed, 03 Sep 2025 06:43:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046eb335f5sm107990666b.28.2025.09.03.06.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:43:31 -0700 (PDT)
Message-ID: <7a43753d-a0a3-4b9a-829b-5a997ce46625@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: unregister ECC engine on probe error
 and device remove
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Dr3hWCUr9BtkBKPskbfuxGPujZ52aXqo
X-Proofpoint-GUID: Dr3hWCUr9BtkBKPskbfuxGPujZ52aXqo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXyL3BVZU2Aynm
 5oPr0TpBlHPnHvmtKhqGSU5gm4db5wE9gbFSX/aa+Yw7/5dOWOaLxWJenLwNaeKQsO/WsJvc9CD
 s74XEHEEma5m4zqgEtKT9DljpT8J4If/PQaXh0okGQP15d8Khh+pq1u9NzQAi9dLp6+DT+s/W/J
 r0JDo1G6ivExACrEtEsJpZXw6rR2fTSjB+Cajd7DIOdoXa+V33zi4chuweohLg5xACezlfDLqZm
 28lFPdbGLrGGcNG9TjAYWBlndu/D7cCp/9fdVJrDZUYM/dkzbNDc/L5jDpRCpIQvbi+y2hU0M81
 PexI784YVZ5vnETdGtQ91mMyfXkbSa0TwrqHEnXIBWt64a1BmRzh2AcZbh/OX0Ctu5E8r1xZr0s
 j59G8iQY
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b84606 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=MVN0ImEU2R9ubr7hOacA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/3/25 1:56 PM, Gabor Juhos wrote:
> The on-host hardware ECC engine remains registered both when
> the spi_register_controller() function returns with an error
> and also on device removal.
> 
> Change the qcom_spi_probe() function to unregister the engine
> on the error path, and add the missing unregistering call to
> qcom_spi_remove() to avoid possible use-after-free issues.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

