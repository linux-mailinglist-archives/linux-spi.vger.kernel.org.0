Return-Path: <linux-spi+bounces-10116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11008B84AC3
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717E21C0497B
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB088304BBC;
	Thu, 18 Sep 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K05nXNNE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E954302CBD
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199807; cv=none; b=s0VFXmtX0GX49ItQR7ut13SEPkvWtN5hgO2+T0fADQ9/GBaJayTA7+IBJO8xq2Vo6ovntb6s31DyCg1KvVsqSag9DUUhvPCI3GrEm0oocaBsV6EPhUMozZU1mT6y5wera8dQWpYLuQOBKRQIl3QNNe4dnzNW+gy32uLWieAH9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199807; c=relaxed/simple;
	bh=8bH3fVLln3J48TzTAJv9MI99+H7ir7k5BxpHk2Gk6hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4qmLTfkUubu1dSKPXiCpEYiHc3ur8FrjWQE1aPBkRD+IrrvUG5Ff3XXP/kuQWAgW1mQOUv5KP5nAnsKxU/NkkgQN+nwa4/IJfl7tFHby5pr6bZwWMd1doA4ISOmjuIwkn1nhmwqZuNIjtdbBW+OsP5LT2lpt4RfVfLtXvRvqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K05nXNNE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAPIHq019548
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ilz57mVIC+jhE/ORoZ8hQRAKB7gQfBSabaTReYEY6MU=; b=K05nXNNETfHhuJ4v
	wa/I0oDvbqWlMeCP+vY5ux7NaDAFMv1k28gJU/CbITklUAda5GryNVJ/DyqYmfZO
	+RSkscaURw1X3k4eeokphNHkITzd++PpJ0f0tTnabq2pkSb+mxoB7sCQ0F/KIJj4
	C6Ib/DviH0RDetuLVkjDgmg4c8BE5AgExO6nO80pw5u3kF4cLm0bJzfP26dAvrES
	QYoW5UKPe9kQGx5JRCAF6MORbaZLvoxu4khstolRwLoHvPxNxyMSMZ/XVRPud2P5
	5UVomkBMlqOOqpAqP7RVSatm+ZrGPKVSc/Oml/b4J/RNjI/908x25prW44nCKC/3
	i+HNEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1xfs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:50:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b77da4b375so2483721cf.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199804; x=1758804604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilz57mVIC+jhE/ORoZ8hQRAKB7gQfBSabaTReYEY6MU=;
        b=AHiWsBjwnugIBeaHVy9mFCOLCdGp0TzpxRy3YeY9CBhwHGlHHKIHZTi33SyF6iJzie
         HeNNsOiYjQKHG0wEQFvfCMww6NLpQiYlnLYCcBk6Om2iBFB1vdmNgBpwdDbzp8YR2ZX6
         4kldUVU+vrmMCUDzoJi6Kw2Q2cothc9PEFuGngnSkP28/D+eOkek6xOWShC0CiBUzaGM
         fhJuZpoY5By131Y1V3w83UwmqUiSj7JoQLRvRVCQ+dvPTPXyZUKBXBKsfrj79HZQFqBt
         KcpE7hpBZL/qF4Gi25srgg8TCcUXglpFo+JX0z5gl7KEMPrTCzAykOvA0h+7DpnbFJ2Z
         scow==
X-Forwarded-Encrypted: i=1; AJvYcCUSGX/jQPVb0obIftvB/twn2f7dpm4vm1if9D9G8GcZMTuU5Viw9007XFcPPTfvFw64NuDIBWQTrNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzORxNA2H9aFLaUfHx4oICkTfMV4CKB7BLleg+kawSO5+XwaIII
	k+tTB5g6eCYvbsLpdS0vFloqwNXS5ygPkcb6ctoavZM66p88x9Za7YCp8B++YWTaIV62RzWpYq/
	fmLoVF1xXJXcIAeZA8xmLllrw3+hWdOPHf0iweEVaVPsf9P/TML2c3uT8Y6jXtlmh9YYMtcM=
X-Gm-Gg: ASbGncuNiiulZ7hxJXpN1QxUGi6H7Tuy5FUXAGizX7KAireiMrmCDiTqu/LQuI8URUf
	vOhCGrI8TGFbfFj/TyLjjIOdzjJQeN7K6qNWblDSONZPn891GVsxHjWr1DsldKf5apmZRLIXaSE
	8Sl32AaO8n1c1GqnWASBhxNYLI9rgSYe9VC2yLQT8PECC+C6vv2xTOLHAHD+OGRShsYX2VDtG6y
	ANKJgrvPW7B0a3KF1CFNWCkklDUOeD85kM4xhstyPkHATiPLbDqsIt08Qwa6YfmFvesT7rYVrjm
	oZDMQSZAeU4e7Ojtjbm18je1p/BO28TNqYxMtZf2Z+CnUlV9lea9SGtawe7q
X-Received: by 2002:ac8:7f4a:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4ba68be3203mr44152801cf.7.1758199804032;
        Thu, 18 Sep 2025 05:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRNHFzJzTMA3xkK272o1+K9461PXaGcz8hNcpg8txtT51Al8DimN2qgY98Hx45Cq2m8Q94tw==
X-Received: by 2002:ac8:7f4a:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4ba68be3203mr44152451cf.7.1758199803340;
        Thu, 18 Sep 2025 05:50:03 -0700 (PDT)
Received: from [192.168.149.223] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44fb5sm189444566b.16.2025.09.18.05.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:50:02 -0700 (PDT)
Message-ID: <824004f9-538e-42e1-b40e-dda22e081c4e@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:49:56 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-8-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-8-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SkM6Feyf6CA7NVctZa_3DQwgnsVEx-4q
X-Proofpoint-ORIG-GUID: SkM6Feyf6CA7NVctZa_3DQwgnsVEx-4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzF2BlfbRmQMq
 EsDtim6hUWdBA1WhqXDO0T3TZ3ywcGZEMPIOKjhargPJGnQl9tEqDYwWGD4OqpQzzLt+lJfrLeX
 N7+kKGG2vVxPb74EkTEOxA8ysyOJtof7EbhIo0ICLu4XvOtlW/wLDQ2NNnKjCwMHKW2NkBymgX9
 hmwYKYhdp7u1eNt6FsO0i4VjcN6KB5JAPTxLh7KhWHy9QVWtxnHdKmpeTei4PMZvReSQGDXSH/l
 qMVqEGRcGDj52jqBj6TmYGRZUOW2U60yKpowDE2qZCnVicmis/MarWRRKoJsMqEYfn+ZTEzLRFn
 kh9x6vtE3pNWWaRloZ3JudPw41oF/0DQkwiNq63dCfaBY8L/67HivCbef9B9IIJ3kpUwHXJviLT
 f0yp6EfZ
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cbfffd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=t3lpBGeAFA5ev54tvH4A:9 a=QEXdDO2ut3YA:10 a=VXQMaQTvCj8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
> design platform.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

