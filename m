Return-Path: <linux-spi+bounces-10775-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B353BFCBFD
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B901A60B7F
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C534C804;
	Wed, 22 Oct 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBnRqMYI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC434C155
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145317; cv=none; b=PVR8KCZabEbhjMneWeAkppcd6btWAy7BN2iV+bBvwUnlWaGzzy0uL9CRkZo6WWZEotCnXJ/cJsHpcUlFtCymBmCl6is6E0iVnWqoZZzv4oGsCTxDjpL1mRUJJdJVPLhIksqO3wdRikoO4/7br/fCGT/DgoG8k+Br9sK4JHjWrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145317; c=relaxed/simple;
	bh=wBgS1XQbHKjwCZWH331tMpBjONLIz9oIPI0AY2nrSCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DN/gr/HzIJ1EB8qievLKdpQ7fzk7FlY9sOu47ywQtWkV1W8Hp0MWsLxp9Wru2zFGqpNgalP6TXSSwUbU7s1Mso59PJd2FKG5O4X4GToGULQSY2HK/xOLq6mGdTLlMFG+dquungMNAgLnYcG6nAX+3yYOL2GYiuikUHQ5ihcNF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBnRqMYI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAC4Ow020555
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMIllqxAxPDQ728CwihRb+R8lpaZm1CZIGmWcY9cBDc=; b=lBnRqMYI2x4D59hv
	/oK3jFg1Yf8tBQxIJZALIjvUWvQ0RQiQAd83EHATeCV1CU3BGhIehXeyyFci7sip
	+sUlxiB/+l1rPikTXswpa1qe9i7w1SpIOHNclXa5Kr4NebCJldQlfETqotG+oUo8
	eiY4bt6fEIdFbaFv4RdagdUjr43M//PD9tDC1BagJz0pPHZyViRPe6Tm7AyQ5BdZ
	IoHcaFz42fUIDpQS3o+aXwT+kD03kQKyRXvbynvCWJMLf6kJ0EEGpKTcSQQnSG34
	AXnoDoi1zsnb/VdwPcpRW22B9Xx5EB0v7okxoVISDtlB18/H0ClRNeAcxDUmwY54
	6xwKAg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3445323-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 15:01:55 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5523156ee62so58417e0c.1
        for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 08:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145313; x=1761750113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMIllqxAxPDQ728CwihRb+R8lpaZm1CZIGmWcY9cBDc=;
        b=PN1kFKdkQ52C6PHw4ZLzh9APhcpVyJMWiSHpbMwvUBI7xF2wYT2NWG3mhrh40IFkmt
         VEoZFeFnhBcnFkVyFLARa7bu2161J0zgiuE2TCD6ZLoOvrvTt1ppNwiR85gMkeDeveTX
         EfRCGOIaK6/e+wUY4vzmlKqVbWE96luy533zxILC4gUikzAf73xaH6zckvLmglFh9OUP
         IlmGprfcPmoOPp0WJ/a4eN51dWCWwy20QdqgwVKfKgo2MRLj3ZYDYtWn0UBg77/Rs2c4
         7earJ0Zmw4HBV3u7vEigXaCCp0PfvyZV+xwKUfhzU/lxehVIkyxRK79rFKwl8I1IlV4r
         pbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoNOamkAKYZeKZcM+EUUmffuNPowaahOQiijchq9RtZIhgmwJQsETsPb4lX49qW2vzJrqWyISnnCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOH3dCm8WfazaOHu5Lrole4uJkvPjgAQiGfOhweggxcuYhZ4mg
	sJF49U76e716e10j9S9tZciZlIg6e6QzwNPlY7BfQSBsPpPsw3p4wYsI95+IaG4CqE2a6rvXyVJ
	sqqCpeUleXPhpwBh4pBAiKDUNzlOj4vdJtxXxDpNPtYc7em/elw3QQxi6ihrSvbg=
X-Gm-Gg: ASbGnctf+K8JjvdZ06MUEtzRl2dlPNU07cTPYaAyVRVjMxJlmiQuNNxOySJwo/dzkQH
	aGlDLVU55uPVQPbkdn0cjrmLoA3l+1u5IQY+YvSvIA6n7/undIwN1qwNc6MkjFoXCNcntK+n9Hg
	u3ZSndk49DCNuAWLX/mQyFFyyfVi7WWlvMdEl94l4AQW0T6EoWzJYCcv9kTmzI0LFYxh1PAWjba
	jixaz1tS1BT1y+Oldw1JFUSYnB/ROn8cNVAwRAfxe6MYy1T1NRgIyFt+iXK9FKt90uHZyK8fyje
	vIZDbdkVIuy8nf1Y9b6SgqW9BakhzmTEkHlUI6s3G3sSzTRrFS/vcoW+J+wjlKKuewXl/iHCBH7
	P9fsiSUMpxQgb0tNQoG8U9lcnNAyvjAUpBaDe4v5IEwfBFRF/rbRnpcRC
X-Received: by 2002:a05:6122:8891:b0:557:594c:54bb with SMTP id 71dfb90a1353d-557594c61b3mr67742e0c.3.1761145311472;
        Wed, 22 Oct 2025 08:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfgRrt5iXa7DFomRJIQGJ8VDhlVThbjhKqjcQAvv0iCP92sfGzYuCXXxlj2xPk/Du2wJYrKg==
X-Received: by 2002:a05:6122:8891:b0:557:594c:54bb with SMTP id 71dfb90a1353d-557594c61b3mr67646e0c.3.1761145309915;
        Wed, 22 Oct 2025 08:01:49 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1354965566b.68.2025.10.22.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:01:48 -0700 (PDT)
Message-ID: <295c775e-852c-436b-84eb-1084e549598b@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:01:45 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-5-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014110534.480518-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: B30d8TKg2ur1EuJFl8jHYVHtPAeTEl2h
X-Proofpoint-ORIG-GUID: B30d8TKg2ur1EuJFl8jHYVHtPAeTEl2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX48wieEkA/tr8
 0IojmtnulVnpAoKk5ONMQYxpyaFafoR2kAi0++u3tCvXFw0vTj78Bm4TO5VtNkFuQbBb9WQhiHu
 B+NdrZP1HDvav3lx+Dz5CUOh6BZAYa2wQcSGEWnayQTgy4WgXwR1knILeTJ8SLDG7BRLH9P/hxR
 Q2MU9E/9+pJ5qtjLFefkMoeVviUuK9goACTMhH2GIKo8u3HcCIZJLR7V/UlCzykhqv5CfVvVHb8
 ouAxW3tEbz/nTvKmMgxT1IYacj3nxXFdo/e55unHktCC1ZYzYC8Nryl3Br9XE0lAdJcgR3M4/9v
 V0hNF8/jLhOEg1HH+jPFdgMLl0y2TywKCtzdNDiGV9lzH1r17HeK2c0Pjw6Vy2JVCuUOCHXh/4w
 7Y6Mvo1DbXYI7YDNptBuP+q5bmxeNA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f8f1e3 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eg2IErnvy-Z71prtMQkA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On 10/14/25 1:05 PM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5424 SoC.
> 
> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

