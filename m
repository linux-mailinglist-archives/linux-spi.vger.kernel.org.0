Return-Path: <linux-spi+bounces-10115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D037FB84AAB
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C904A6933
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A35302761;
	Thu, 18 Sep 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S4vd72lU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BD29D29C
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199782; cv=none; b=NgUeHjWlIZ7boe8PEplQqBBX+pHStcR9JaxQJ4jjiZDKnjjFPZS3GNhJr//3bObMgh6Z6QF8xRvHs+Xk1pRSho4mA6WB2wyQEiDgLa5BlQLoJBizjaCeRkWhNb+0QwbCUwKb00i0Wc7CwH8iptv/9Dlt2hAx80/GaC0F+q4ywBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199782; c=relaxed/simple;
	bh=T1g8wHxLM9v5baLJeX1hctgeaaXQryX52U4/5MjiOx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPj7j73/I+CerPnJPaHV6EX4gGxepWnVl2wAuuRCgFHynTLS8ym7pVP1T6bx0zPMXs3rr4KBr4kYoLdIhJ/AXs+LeM7KW5BhzmCpFeppvFs0iRQgAQqa5IEiIKfNvL5OaNp2Z8JFGz35EuyXLvaFRfbt7LWCGXduJQVb8pEemcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S4vd72lU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IC1Z7k017946
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9uvbAUaZJ/mM5qLA1wvd5EkiZnnOCTie1nM1T+8w90U=; b=S4vd72lUuT76G3sS
	Rg8qlJhfc15z0IaPwnZkEG4fFJ/pSzfBuKwoOsR+Mu3Nd23+GxmkhsiaCncgAqTb
	8OEPOP0306KKqFZeM2fX+h1Rxffx0ELM2Mb+1K3f8Tca7qmQHoT+x7W/FOraKM7a
	RSLgaKD+BKGAz0h0lEYsjBEzTS4HG446XWHzVAzHPlIOhGhatEOBd5YUUNONqpun
	V8f9haVjCCIGaWvl9PhZGqc4R+JpfIMd5HPmdT6RRqY6GUARifZvMvUkBpPzkAGW
	j31mwM1mEp+9kv8UifiM07/bb2SvY87hZwSiJn1tJXRGG8x4nrZHH6Srnx/pcXB3
	xMz8DA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982deawdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:49:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-828f8db42c9so15734085a.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 05:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199779; x=1758804579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uvbAUaZJ/mM5qLA1wvd5EkiZnnOCTie1nM1T+8w90U=;
        b=UDufoFJt/SlUj9skDPXjcUVjij7x+fT6bssOoMvWBkd6dPeaFCNG/GVMbpTajJPRyl
         eXEQob3PfXOjbRI6R2n3UMghmw+SES1pVNVRQzUy3Q/QklwQvub9ZtmvjMXxMX7i9FgT
         L445c2df0qHY9kIKfwBpQqGEX4LNdjk9+pyNCASw2GZb0FPzOnOHHYav2Gg4xXNB/rvd
         M41RsMKF4I79NhB3WNagU4hxv2/RFSnAASV6W6vDxI7iJdyzq/ZnN7Pns+EMfh07mhup
         FhEh8BVl4t1oBt9yu08v+KSSeurp3pUjq7u4AiqOPOpjWqsOmg1BFkg5qXDTuxDSpMSi
         zzcg==
X-Forwarded-Encrypted: i=1; AJvYcCVUPXk4NJ+6c/S/xzO7PxCPRhKkTP5YvsKiOIoiJA+sESBuldd9/PMah9HmlweTduNxdM9V9EhYIwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHwWse3JD3+X2BUQ7aLER24xzFc7Hd1M1Drl5kRHaHZxlwy3q
	sLuO464/RLDkiYq6jLGEv3YZ4WnuJMRTjWLflhsZbLqNnyH0qq7d0bPxQ+jFDcIj4nZofY8nxBo
	uI0v/ZIZTEkkcAgVsnvhJsBUM5H4UVQq97CSAF9XGw/4vhkwE4bewemcz/7p0NWI=
X-Gm-Gg: ASbGncsCaQQFsK8njIUv9tCcNv1o/QgbWecLNmt8PaZeFFr+Blkr5IDp2M5jR3xykpa
	b82WPf8Tb1twgG5DjS+9SmoI5CYn0ffXu41cxnUEQXlzE9Ocpu9N8SlCBgFSFpSPOqH9WmQLtCJ
	/G8BkPc5P/5XPlJMvso/jX5sD+B/9PJkVjziidyhk7TFxqqAU+9rfr+5R7QP4A20oqHaUTWQCIJ
	ZI3eAg/+Fpx88tBn6T4rK6lQW/NSR5Z5bdcIYOE++avAAoBn4BQb1MRRPf/X3PLjxeuaTjvupWh
	jppNmGZm3giBzOk9OL2PqNyi57NPO2ptr4MvF/VsVTKmMZo1NTyaTmoLD1Fa
X-Received: by 2002:a05:622a:110:b0:4b7:a1e7:25e5 with SMTP id d75a77b69052e-4ba671e4784mr41499141cf.6.1758199779251;
        Thu, 18 Sep 2025 05:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyasYH/VJkP3eENPsuUbGcbWP9AhujaqRkp4Ye74eRiaQ7tYwTMHWC/sWrG+J6Ac53C7TSTQ==
X-Received: by 2002:a05:622a:110:b0:4b7:a1e7:25e5 with SMTP id d75a77b69052e-4ba671e4784mr41498881cf.6.1758199778719;
        Thu, 18 Sep 2025 05:49:38 -0700 (PDT)
Received: from [192.168.149.223] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88894sm186909566b.63.2025.09.18.05.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:49:38 -0700 (PDT)
Message-ID: <8b02e7e6-4ae9-4e6b-8ae6-9688d29d477c@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: ipq5424: Remove eMMC support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-9-quic_mdalam@quicinc.com>
 <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cbffe4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=AmzfQV_qY4rmN1R1o4MA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rQyZrr3Gk9BhnXDqQVfRTaNhNiPiPew1
X-Proofpoint-ORIG-GUID: rQyZrr3Gk9BhnXDqQVfRTaNhNiPiPew1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfXzErIb9fDOFic
 EfSXAEDETtrFIl++vbDV8vHbdmjh/ZiuFIYZlJLs/WuBQlBvyH6FpzlidkYJVEUv+rIZkeKHVwV
 olU/hmKE4f7kHkbIxkBYLgxEts3413GwQFHtf59NLGmMH8cyXA+5jjFqoFkdBiilvtnvloo6gaA
 kAGqyc37uVaXcCZSyN1um4+TXeybmS+8/7mLr9XEhKeGXxDfrrDsOJAhGr5vWisI+6jhDaMk6xi
 TGfSq8FgBwtHrBokDf7J7rjKAuR3hESE6qEdpTxjpoWEg4IiONixGevZbWKVs7noVwXD5vqjzp2
 aFj3oNkgcP/85h/6jFNqSb8TjilnV/lkV7n+tGJ7zUjyz15bstVpQRC2wFiW8S+mTG+ufhiev21
 tuRRqIOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

On 9/18/25 2:46 PM, Konrad Dybcio wrote:
> On 9/18/25 11:40 AM, Md Sadre Alam wrote:
>> Remove eMMC support from the IPQ5424 RDP466 board configuration to
>> resolve GPIO pin conflicts with SPI NAND interface.
>>
>> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
>> mode configuration. The eMMC controller and SPI NAND controller share
>> the same GPIO pins, creating a hardware conflict:
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> The subject should contain the board name, i.e.:
> 
> arm64: dts: qcom: ipq5424-rdp466: xxx
> 
> same for patch 9

(and for patches 6-7)

Konrad

