Return-Path: <linux-spi+bounces-10469-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0BCBC4D37
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F5219E255C
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236423F424;
	Wed,  8 Oct 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OwWibGsX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91E243956
	for <linux-spi@vger.kernel.org>; Wed,  8 Oct 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926798; cv=none; b=cXcRdZW2PbYBqNQqTzFQF6LF7GF1TCaS+fofVFapCBeMi7RwH1BxnFhB4pwB0fZHoCtZLFyseSGdfzIJxi/qGdMov6SaPxN+xsnM83X+Euze4oYM0n6IoBDupeOHNdGXZqWIR6SH6pA4IisTt53YiK5ZWEsOs0LzhGkWy4Lpc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926798; c=relaxed/simple;
	bh=//8t1NhDDv3aZbpcl1yQGBSqtJZBajxd+nNDjr8+aZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA8cZ27fAp9k5PXfJNTyF2Yr0Z6uBWe139V4Fj4qSOPDqoYyxpe4uNKs02/CeRclywUiahYGuhlMitxvbtQzqTKNjfsWy3C+dy2jCIR4UoL93iyp8V4AzUy5fTk0d5tpDugsZvDxmyK/BUc3Em0ddJYNoBZyEGkDfTHzqLLynMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OwWibGsX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890PlA015824
	for <linux-spi@vger.kernel.org>; Wed, 8 Oct 2025 12:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6wfZSf95CHgtI1KREXLOgXa2xinD3Ro5IOxdVOqt1o=; b=OwWibGsXastOCWwr
	cudCgCHYC3kFVxy/+gifKXtSuRoJA12pH6krQQ/9vpIXomveUt8DRhn4APEXzvLk
	/PjS8JG/Y9rHRb6Zo2AKnO3FStOc4wtM0hk0LkczeluGOkwKBc83qJ3F4OC0y1Sw
	1wZBz9HejLtzAyp72fBgzF3kbYFBH2BlLevmJgdfXH3KhIdU0K7+EUGkDr1ZlNro
	qgZXCpyGb3RenY1eURE67+op9heoga2pHXrtJkaBPj07IanynFy4Ofc0i9ILfbKU
	uJDL42//AcZJx77rVT7ISV9NAJbQSVnZurZSkzSSihW3XPF71TIaGRZ+DZvwejfo
	2XnlAA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk72g6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 12:33:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8703ba5a635so225406985a.2
        for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 05:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926794; x=1760531594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6wfZSf95CHgtI1KREXLOgXa2xinD3Ro5IOxdVOqt1o=;
        b=bwXrQFzWUG6U8kSwMbQJ3qnwlk5OyFMASQ3u28Z+ymluflsgu7F9wqFyjx858oWZpR
         w3FDaAQRsHSOSwJIkas/xU73Vkv6D9W3GDLwXWcActoOdmg3qzRsaqyZDVK6NpLnoanI
         n0n4UvsjJCdgRLUSHYOAD8jWpX1KNmzpz+rl8VIRl6O7GZFfUAuC8s4i+H+YsHc6f7Gj
         bHasj7ZMZowO079HEgIjyrjsjh/jt+n1txmntz43Cy2RD1ycRWPJlaI4Hy8IIlQf/U4Q
         H6ABrCVNp9DiENUd/eLpz5jdzSk6riV6LfQqLLUC+/eaEyj1sA6TXJmrr0YCWL1c/1zW
         jFSw==
X-Forwarded-Encrypted: i=1; AJvYcCVbu2uyZugx8ktN6SpouXQyh3X8XoyFr1D0ti2w6bSNjzAV5fFmVRd24g/w8IwCIX5oxmKirs/uhD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTUxi3QpQ0+iBXR2ajiLrsRTbIZBBs6s4zZUOnDId1miImsps
	K74StawVzX7QXbflPT170yTk7TkSmhx8MMTlnFCyNAB07esEDHj+OJPPyHDiHAZ5H4z0WTsZwRY
	aBhW8N0mroBB8i/XoGLBX99kQDecpXNCM1wc5cfnudCIulK2PfeCTqzsO+4lecEE=
X-Gm-Gg: ASbGnculuAiivMQTZ3Z7v7kt7HckYaTNi/DNBCquTWQDVjh+HEDLPEYhJ0ka7dr8oDL
	bLO1UciAnTR92Nm/Td9wQekIk9N70BVDdQ2D7LpCtK7q7SrM7wPJ/mrWmhfPPZLxBdU/IAv7CgA
	Gw/OljXftK4sWPb/A8IEdehXqCtghViGRbMPWDWxaSfref7GTEKZc67PMIn3nxIYVYRIf+rbE7C
	HgZQRAuEht7BtYKKK9ULrS4qDf6AXUVv/+qBIT6hxQYlhcAv8SGG7SpS7IO9XIZ1BnL69XE0Fk5
	/6Q2XIHv8AcNOXJVQI/7fspd4DEw2m0SBL0tlIDdEyIe2sxV9vc2ZuWszUILSc5CgHh32Jbme9/
	oVxb1TgiW8Fp+F8Tbxng0mvHnF2Q=
X-Received: by 2002:a05:620a:4456:b0:85e:429b:b5ae with SMTP id af79cd13be357-88354304602mr338466885a.12.1759926793829;
        Wed, 08 Oct 2025 05:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAq5uquGqZ+wqlPlamUADJJRHAYrFogaML2CeN1PWbZyjBahtgdInWklh6rUXYPttev4j0qQ==
X-Received: by 2002:a05:620a:4456:b0:85e:429b:b5ae with SMTP id af79cd13be357-88354304602mr338458985a.12.1759926792743;
        Wed, 08 Oct 2025 05:33:12 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b57f0asm1648527866b.77.2025.10.08.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:33:12 -0700 (PDT)
Message-ID: <24544f3e-f9c3-4650-a300-a786ef589be5@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-8-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-8-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX/a7RzhijMB88
 UZcfvMA1Tyby009PPEFdJSouAH3j/EPKjJEdPGWW8kdSUgbZddIPBqckZ++/UIMOTL+QLyu2djz
 8z/897zYcvq5Y69N+8PZG74J4vTegozmGdmtXRfzdihvK60O80Z31bL1cviIMcBlDkkpOucJems
 CwjkEaBQ7LT58BSgHpRU2Y2Pfpk2lxVtPXqXA3vw1mFi6BJJOLvFVep/MPN1Pda8w+hQC6iPSuP
 jHLEVH+fT+nuyzltsqEuumYBvK7d+XwdPMFtC97AWMICGsJDHOVIC/XeQYqRci8RNA8+thfmcQC
 u+k8sJSWTa8K1HKhk2f4GJx3cZRSwGBt9ZAi981Oh/3H5ceKtpjv2crbYAUhgpnzABek4k0UO0m
 7fhMxWVBvwJN2JcZydPAOIbj+4xvhg==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e65a0a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Swz0U_bwno74A2bXjT8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 75TBx_ZX__YWu8LwwOCy8fV_1ggM4VSi
X-Proofpoint-ORIG-GUID: 75TBx_ZX__YWu8LwwOCy8fV_1ggM4VSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
> design platform.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

subject: ipq5332 -> ipq5332-rdp-common:

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

