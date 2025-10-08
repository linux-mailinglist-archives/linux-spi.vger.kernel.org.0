Return-Path: <linux-spi+bounces-10467-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C80BC4CC6
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4B5189A14C
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03862246BB2;
	Wed,  8 Oct 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8wzapt9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5323ED5E
	for <linux-spi@vger.kernel.org>; Wed,  8 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926684; cv=none; b=CS+jc3E0ZtcKf6b9pYTg/jouJWWpOeVVp6Zzj0cFIgI8Mwlww9hI5ZcDVNCtcp0hYA19azklYiV4iKZo1KrRxMnA2aHF6o0BkiI5qPJ0fXq6CyrICJ81Ud26OnkkHVVs/zXNP4VK3PeNE/qyMAA/9eo09mud5Vcm05TDN7Jxj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926684; c=relaxed/simple;
	bh=NBUAGxB/tBXvLkcWyZOr1Q4qRMURG2fiZWYNgPUworQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nay6dBiGdGqT6az0/PF7rmy38+QfG1BYV+dUwiQev4gUot8GW0Ck5XBdTGmluzrrTEXl/jqti4wUe2NePX9JpIGb27SvRdpwzZXd+f7HN7zEEUTOejfo1992Fu8Fmcb99P255AXpcpi29Vqt+V015C1utPWHUXZkZockkqKNbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8wzapt9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Odd011606
	for <linux-spi@vger.kernel.org>; Wed, 8 Oct 2025 12:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x6QmyeNzk2DWtq/5un0rKTrn3/g/0gZ7LHuSs6FDi+Q=; b=l8wzapt9DQeNUk38
	umAl/VcnvDBK5n3FOf3BIKAPQ+KdxaePFfsJ8Wr750zDZ/b9/2e8nRdNtRSL2vHK
	ilu0uyJCvdptf/b0F/XOoAeJ6xiFDSUAmD37jLxBrDCzHjKiM5D8+Dyw1Tm6mxUe
	eP00gzUg+DDXKtCjwrrU2Qy8v0n2uLUUI+zlcXDo0bTZyytMPdkJzIfY0NpRUWnh
	AeRLdUX9BVaqHyOAupU+dvvckN/zUWo8tr2H5HLTNBGvOjE15+N3Jdf3MGTurhbk
	oe3hF/s/VuRt/vHO7YdDa74GShsJRt6exp6kpbMKpS5Q5YSB5JbA9anC3qqq9UvF
	fHYe+A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpwanu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 12:31:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e0f9bedf1aso22871961cf.0
        for <linux-spi@vger.kernel.org>; Wed, 08 Oct 2025 05:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926681; x=1760531481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6QmyeNzk2DWtq/5un0rKTrn3/g/0gZ7LHuSs6FDi+Q=;
        b=HIV7WyMeHpBIP6ZzgAbKEMwAWtTCoan46SMPy2k3Xo5z6nZ+zYd4ZstnYOWNOZ0WKT
         PR+9Q0I7W35ALqS5oCeEk+SQDR1Kvl6zv892HA8nkw3x67tST14ku7ltZ5dcU5ovgD3E
         S90Fib5TFsH9dKYIsFabBbbEQayGglCmoOi5vqD9m4hHidS4wnp/RaIlHAu7sugwfx1m
         TziWMWQpdc649qd9OJbHSgCLj3uh1lYhNyvuZjR3FyoeWV87m8GJNhWD2ATEgxpAyEIh
         SvlNA3icsYKaCHlVEJ31nXZDwugr9E6MXaIlNV9KZOjlX61texnLPbd2VOhDpVBynsPa
         F9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU/89DGReTLIYxCvhD9WFEoxHk38MZuj+g1GnBwxuW5bim2iqIdZqrz2WalZ3Ad9Hloz4Dbf7SfVp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAc4McHKJn0k1zXSun3iFxJz/FvtNtICG8nEXD3K6K1h61OTt+
	snohNDhz7qD1ald1Xr6h9fwA+M9w/CeyeBv3zvjT09tSXjx++HVGJgeKkwdWkOVAG05hTPELPhT
	eETKGdqLm2b2tsDzJwB2qjUL7+AK4K9Wdc5LnIcJSfzupk1kqwSdNZp10gBJHefQ=
X-Gm-Gg: ASbGnctQ/tFvs2Xx1FZIG5H5QIQ3dFcoszwUe0lBFlGm7opz/AkOYzoKdntJ2l0vGhC
	+HsDL3JQ9ImxTG241t7VUZehYnilcY9QOFdH4Z8xhDdBfEyVJ6yzHOsvI33oh8DTAIhhr5Low6J
	RDS16fIP6MMS5SuLTMjLvyqtO3VGq4N0nd6f4ktIgdIFm6eSZ1f+6BM3DOWfAnOyThcW4cVfifR
	57nPGSYwTIBcDZbj8tMwiUy0kpnqF1OCSfuKdzagbZ+36DsAjcEhG74Z6vwe7d7VL2oCNPgnqgG
	OVgjZPcOvgzxAkku+d8ZHJ3ByHmY3KGpdbqKbBufkQfwpIYQ+qp4a/ZheOS7EiR8HT+9mgOahMA
	V7WbG723NNDVGeOf9LYB73/meAlc=
X-Received: by 2002:a05:622a:1391:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4e6eaf1f297mr27572771cf.2.1759926681048;
        Wed, 08 Oct 2025 05:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pwI1MduX8smavHYwiDb2mslV760+0IPE3g2CfsrQdd9P6KG/JHQdrqd0yDzYls3wRPT0LA==
X-Received: by 2002:a05:622a:1391:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4e6eaf1f297mr27572141cf.2.1759926680377;
        Wed, 08 Oct 2025 05:31:20 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f93esm1660139866b.83.2025.10.08.05.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:31:19 -0700 (PDT)
Message-ID: <eddbe8c5-56ab-4007-8df2-87927696bda8@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq5424-rdp466: Remove eMMC
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f0gt29DJkum0BLr2f0TBqBGBTIsRw5Hj
X-Proofpoint-ORIG-GUID: f0gt29DJkum0BLr2f0TBqBGBTIsRw5Hj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX9LdKwP8IK3Dw
 Jybf+9+5wNKw6zHi3HGld1tZSq4QDj9C8a6ZsSJQQhOWIih0QNXRJlszTSuvm69XLEOpm/eRmq0
 p5asGPKZ/z5lw2lwG4akaMPm4f+ARtRzOaBeCnzN4JXAtEkwc3lFh4vagkKdsDxGLGauEp9R4pd
 jOJ4KXR+pKwDgqKvZN0Ltr7G2+TMwk/H4rt7F/SIG8Jg8lS0MYRrkkfnXwJ852r64ZSiMkHiO6O
 25jmuzhDsxguSP6f0xhfzqXLVv+EHluiTli3zT5GIWxQMvExTKGYsJtMfQX2U5p5EPFyneNEnCV
 fWWIPA/K2uqhpc5VPYnI7fFxnycq3g//aHBMgLcuHca+UIdKtXsYkVGapPaRL07KRtHyuhJa+gh
 5Dy+EIcg8Zv/qu6vnQKFb6B5BSQ/7g==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e6599a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=be57XhxKj-X5Z9eHZJAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Remove eMMC support from the IPQ5424 RDP466 board configuration to
> resolve GPIO pin conflicts with SPI NAND interface.
> 
> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
> mode configuration. The eMMC controller and SPI NAND controller share
> the same GPIO pins, creating a hardware conflict:
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

