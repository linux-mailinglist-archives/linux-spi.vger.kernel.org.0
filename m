Return-Path: <linux-spi+bounces-10776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F8BFCC03
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 17:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BE61A60E07
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354DA34C15E;
	Wed, 22 Oct 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNHqvOYJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506615A85A
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145325; cv=none; b=S1Oo1aVBG3Js0xiKtsdz9g970nes6MaORzMhNvlMK/wTT55ZV7ZatMRBqLzeKJdTip8CPIqvkZL+8PX0/4ML4VLpgBM450R6PVjlMN8iuOXkN0XA5nCMFo4Lgwun/qs6DcrQGDeUGCJ2MdgkHH1HvBkqua/bLIWaCTWYMHlpo1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145325; c=relaxed/simple;
	bh=AS6GTchDJiG/VSv415eyoTU4UvcWXjnpLTn/xX286zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqsSAtPKyPOoLMuhuGkM5kxOxC2cm9/gQ9H2027+KgPtOIPV2Wlf/2B214WSEZB4JJEfA+Je5SrxBHHslDJ6OARL5Ffxv6/ty9qHaggMAuULhRKBapIKJiJJbjdWcMH44M+LpDmm4+9CbAoT23B/tn5RMqSuqsSdkub3P0Z/+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNHqvOYJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBW0aC027617
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WVhUC5KfCy052S9d2cEakHXZ3DpmiRO1eWkjBgLlKao=; b=ZNHqvOYJ5BbO4Dbc
	Xtu+XaBVfr47/MXPRQCupdjpSjx62/yERh6mbpW2O8yd4yIaaWW8qWnMniDLruQK
	wK2m75UquT3XJ07ANajsdglGzqF8O/TZHOelLz3IouGK15T+JcSRqm/vo8eGVwYd
	PsksKp3F30DyhpZt9KbhYkXIiBcJ7ToJOJiLZm98X3C87q2f1bvKdMXiaNT1Iiq8
	aS67Fswl/uIIoiWN+ne4Fem1eYUOX3Njlt2VzrOvCu0kP7VOPmYA8tZwJkBLPYaR
	hxfSqhVw6yQ99FgVMmXn6vvUgiXQ4dKfnzQ4NplpIx9D4wdIfmg5ZLj16g2CF2uz
	sbaNWg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j4ywj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:02:02 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5db05410a79so309857137.1
        for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 08:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145322; x=1761750122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVhUC5KfCy052S9d2cEakHXZ3DpmiRO1eWkjBgLlKao=;
        b=P4MFu54S1FeyLjT7i9FAv68f5jvJ26ii7bcD/E9/c3nEPvP3uG0N5ypZaeS5RweMPd
         HOWUkRXK+Z62duTfEAcBp7ZMSINwx/3geLx9+rinqptd4dNE3nJWh2AvFZAgiOQEC55c
         1h6NVuZnXp+KNJywOXmXWR23bmR1eW7zl5hEOXPLBOGRmrC2YeuY3UANezUNgBGhNvcd
         UQpXp5loh/AL7Qymz5ZYy+7WLY2v7Hnzfp94FwbOaM2ygYEBQO/EmwH9ofFOUl68HmKu
         HmiuWRYNBVQ+qTwj1Avnt5k3xsKwu1gPPS/TcwVM8VFggt6PTGFroaowdBoUToZCjS6w
         hN0A==
X-Forwarded-Encrypted: i=1; AJvYcCWTB0w1LF6rtnLZD4dcE4yME1NJGn+/6D/kIJqfcJ5eplvRZpc+Fm8OY2N3Nptraje7X9ndvJzE0i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUutSJwST9p7lNwYXr/ntsCo6xY+BdsXT8dkAzR2FzuinU2aw
	BT6d8dfXoZpuW21XuOmOPzV+7ZgTwuAQBO37GA3gWkI/WRI4k19Zt9F6vqJ64tXy3HTHLN6UoKA
	MVt+GTQOHebGFSuBzRIjvfz9cyS1tKbMw+FB2L/bJCCoNjWMi5km90XKPqSe6Me4=
X-Gm-Gg: ASbGnctEolhKFRmcxlCZoLUJhoQCR2XK4gi9vwoTiG6a364YGX6ERzpHOvnDSLputAS
	IlmTp8vW8Xlc0wE0/og65Re9/SewveYXrdM2BJAtjnicx7aZlSLAdGYaN7mnV/KeL/ImAOz2rR5
	9NF5WsRCVcWYV5iHT23Dy/2UPi6NHzke0IwUwXPkmc95bVwHBWJ4uE/vV1f/PcLfny//XZ4NEvQ
	BFHX858GNyg8By2+VFc2QENOSVjf3Ex5jAoCY6GAlUh62nk3+HESt0s+Gi2qFdTrFj/rmBNYtBW
	4eZezUhMSH+tk0GkS+eIrVY8qUiupQzhQYWR3Igk1KWupdt37lGTqsVg6HlxdsXXjPWDZvmmyvO
	DtNboHpaCkDAW9f34VO5Ff/LmSzy4o/cTJKPdPkdR3S8nKgMgRNbZAJ/b
X-Received: by 2002:a05:6122:15a:b0:556:8b02:f82b with SMTP id 71dfb90a1353d-5568b02feffmr660204e0c.0.1761145319395;
        Wed, 22 Oct 2025 08:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5zhFY1onskFYnO+4Fv5ggq4wyPuFkBT13ek6QdXSAtiXahagt25PhXd78pcdYze/hqeLzg==
X-Received: by 2002:a05:6122:15a:b0:556:8b02:f82b with SMTP id 71dfb90a1353d-5568b02feffmr659951e0c.0.1761145316876;
        Wed, 22 Oct 2025 08:01:56 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1354965566b.68.2025.10.22.08.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:01:55 -0700 (PDT)
Message-ID: <c56d48ad-425e-4e7e-9489-b3c926e4d617@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:01:53 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] arm64: dts: qcom: ipq5332: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-6-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014110534.480518-6-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX0NK8LrqD3E2q
 6iVYmypNxdxDqFbqe+y/iXHbli3T+dX8zpmyiqYjvTqQrmLfCzYFzfBaj4IcUXqGd1x2iRQ4Hdu
 K3PsFSPje/y6WAIWhbzy3NF7Mm0UDtQYPHdS7xfxQns6aZ/XTYlFSZPKyquY0dMuxmUP729anpD
 /ZI2Ga1wivJy0SI12WhmHs5zC7dvJb/ZNafR+2aoMMl9Rglj0W2tuOSgEHQfF+WZmVXcpamMwIC
 9SJDH5q4xwAZpbEr9zMHMelg7b77iAFPJJS5e0CXbGXupZqOvekbfyr7NXRMscn7qbhFJdDnM3b
 6DLjzj3ITQ9KjKeT7uB1b2VlHmvULP/9J7GT1YzH83M7Mfz2BFIDjPdsRgnlFVDDW6obEtEHj2+
 wlBDU8+t8SF+qfLQsX6sklrqLWJ4TQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f8f1ea cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eg2IErnvy-Z71prtMQkA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=ODZdjJIeia2B_SHc_B0f:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ldTTQONQjRV9gbZXMupSsSVITCOI_p1D
X-Proofpoint-ORIG-GUID: ldTTQONQjRV9gbZXMupSsSVITCOI_p1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 10/14/25 1:05 PM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5332 SoC.
> 
> The IPQ5332 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

