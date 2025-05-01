Return-Path: <linux-spi+bounces-7812-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5324EAA5D26
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 12:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DA7461208
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9B21C9EF;
	Thu,  1 May 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KTtSNLeq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84E2AE7F
	for <linux-spi@vger.kernel.org>; Thu,  1 May 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746094763; cv=none; b=OvUHE17npgy4FDf1VwgUeV/5WYdV17/KymZwi8eaMlHzZZEtOJCIxbZPyr7RF1u1dj4kTIyq+8pD2/X1KA2Ah6MaLYgwM78KlM2QTqydY+E8KTVvRp3y6qHCuCJLC3bm3X1wVFLGRCelk1iYNCTGbWhQk1OHXX7yFg4KxOfbLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746094763; c=relaxed/simple;
	bh=qcDUFQxHUyNZknUCKfm3IojNc+trsUyfhy/vChwE97g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRBTG54+SNaRA9ngMU2/s0oe6yydouNTFai9CRlKK9fPcukG7yWQIWirYqURm7/bZG/+rRQYeP95ipJY5ajQD9Lui2xVTCXCAvE4sZNkviFY1qk/UF7gL2e1UEAsNNBOKl3Z9e9GRvolozl21zo51dfp4CMcB+b0zgobdghIwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KTtSNLeq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5419DIdD012275
	for <linux-spi@vger.kernel.org>; Thu, 1 May 2025 10:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fZ1XuECjDv+ed95P9xYwiZkwgD//IqgLjrzUycy5GAI=; b=KTtSNLeqef+7whTn
	2+3csjoE9lhUngLbSlY5MOsyzEf7/gPM0TIK3i2dSIM2WH8QW+DniuAPcMhoab0Z
	VwTuxXVxEHwDr+wn+prio/LhZoDJc05vezciKpIQ2+F3dXrJQgbCZjOZH/mdhCRW
	otqSwKhvum5BbcGI3rWbDSs/8j4J46yBdIok2OQJ43cpRt/RNdu8Rq1vmCB65+hU
	GL4mE0uqMHNeD2vuiRIsjbp1Hgelj1tjg4dLN9qCEq4qcDYN4AYyWjWukswzymlK
	O4cYEOgAj2WpDyKWV9hf3aT813eplkwgS+Ril6EPo3CB/j8sc8ACog5HmJiYsTnr
	69B/EQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u3vx24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 01 May 2025 10:19:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f3766737so2395096d6.1
        for <linux-spi@vger.kernel.org>; Thu, 01 May 2025 03:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746094759; x=1746699559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ1XuECjDv+ed95P9xYwiZkwgD//IqgLjrzUycy5GAI=;
        b=QJU27/o+KG62bmHVII52ZAmHOcSbZqxRgCkbO8Y8NVl2e/sgc8Iz2rQLzRhs4vP0/h
         QIYbvDbFymaByrwYzFnNcpy84POrD7CKq9UW9uF8RyYL2xEtGa82VpwQdTv9MxHBCapR
         QSCZKJMergOUaoqzEbBuK824F9WK3/5uGHD3tesjkBVUBl098blamlB/EPExQXqdulkB
         jwCRWfGqNUa1PBzcbstK94boygJLnYi9LNH7TIIxqZjUYCjzTU9SbxYnFoewXLzhqHPo
         w45GVK/yKDuq9NsLcNkvjd+OVJHlJ/rIwRzDZMEt7iJwPe7AOXHzcenyvmDj98xOt62U
         UZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVuCn9BoC7ime4mN/L4nD7BL1Oo0ObflGzdSu6RNVVo+JS9hjRyIjV6iLQF/LGo9pXuCyKd7LNg7/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWoLTb/A7Zhhe3yaDk068qh15TeO2ELh0iYx3xNbk6aG9QP4mn
	WGaNBXa4u0Gwh8URuEZEBj20hLrJEpgIv7JtcCzBOd8yvi2vcXUOPmcrWtEJo0fc/bu7lMUV6/w
	x61t0h5cLwenmfoAa9cbwX28aM9TlvNNiWUjcH298deokOjA7Wz0s6eGRZpY=
X-Gm-Gg: ASbGncs2FA7rblzJfiRLlZSi2TPMCCQyC6weT2GnnbvyNfMTF5TF8s+jFjBWpuGGnnA
	oynIBFKWy0vLIo777UF3O9S2T+WE45U3pZCNG+wRg0JOGQPOrJ5kUwY3RFvFVrHURlFsFUWF9Sn
	OlNbEQlvYyox3S+gM+7sfRiZRArMzkpVZBEutyE0yangHxiIOky9iE5n4BAptx8KoQpS5Y3EOcw
	MFQYfQ7aWOZghoZ6IzWSu7t+uTrWKyxZijaQvy5OzWmw1IrNFcwZCPPk+03YK5BahD+wcgJb0MG
	Ds4tuJdKPhAI3+yeoUw6D1SbkfjSlDHu/W3XJluWHE4OaasY9werT9NZSSTeLj5qLGs=
X-Received: by 2002:ad4:4eef:0:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6f4ff62b7a2mr29343276d6.9.1746094759403;
        Thu, 01 May 2025 03:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnWkkppAR1J5LwLt/+BiVd+PZ/zdfpyrTEdEjDFy+FAitwdWPxbK35SmvLa0AFubP84Ny+MA==
X-Received: by 2002:ad4:4eef:0:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6f4ff62b7a2mr29343166d6.9.1746094759120;
        Thu, 01 May 2025 03:19:19 -0700 (PDT)
Received: from [192.168.65.219] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad0da516a92sm19952366b.103.2025.05.01.03.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 03:19:17 -0700 (PDT)
Message-ID: <cd8c674e-2036-4fae-bff1-cbd3537b7bce@oss.qualcomm.com>
Date: Thu, 1 May 2025 12:19:15 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: Add SPI nand support
To: george.moussalem@outlook.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        sadre Alam <quic_mdalam@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
 <20250501-ipq5018-spi-qpic-snand-v1-2-31e01fbb606f@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250501-ipq5018-spi-qpic-snand-v1-2-31e01fbb606f@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Bv6dwZX5 c=1 sm=1 tr=0 ts=68134aa8 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=w5towEkYDENzPYN5PyUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: Dr4kyQ-02DMofob8tnc3p9fSydLgaHPB
X-Proofpoint-ORIG-GUID: Dr4kyQ-02DMofob8tnc3p9fSydLgaHPB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3OCBTYWx0ZWRfX66VpFYVv1096 w8TWYZb/qgu/W7CJqxlniaNOICKWkKLTaH2XsdMp11ytDIGADGK9XAjuOmjmy4aEjAO9OZ0QP33 DkOBIWZ8M06mSLFvQ3/xxA0u6b518ZaeN6bPgsHtcwC/AZVoFGtOvEr/RiC2em+jCGIzFdcv67W
 hrfxvRMNhEJ5S+VBqSrgLHBO5FSC8u0z9Fl//gaLQszT3dcqsiQ7h5g9iCLXzZiLKOqu4BkkvUq cwvAazQjgGJxMzOjKm53ZFMNL/inUoXr/LtOYYd9yNglmEDIArmMZJ/qmTu7Qj462rTb2qXRbNz zkrqs/5aVC5h4A8SYPfmpBfLlRllFsyaXCd2q288y2ETuhJoDHMzJoQLFB2K6Wauh5rzM4SBv0h
 kap4oC2agkPb5xWlDOuUIXTmHhxOQnFsddk0rx2JwGxJB1l6Smc9x+oOJdoCasGWLOh9ziL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=721 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010078

On 5/1/25 11:20 AM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add QPIC SPI NAND support for IPQ5018 SoC.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

