Return-Path: <linux-spi+bounces-10599-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47DDBD1FCE
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAF1898CB7
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF52F3C16;
	Mon, 13 Oct 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V6L3jrBT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97762F39C6
	for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343551; cv=none; b=NBHl0ybRoTNcPU6gFpNOFRPLHKh7Wjv2OBx1/QfJmNMOcs0nGSgHaPB7+U5x4/wfl2KUbG6B7wH9QrdY33cOIo5gP2PYbonp2hJZ+sUCM8eICGHtS3R3c/cMBbWCx6p8KnTpIbpk0Rhy8nHDEbDj3vvCzljuf5q8nEOIq8nalUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343551; c=relaxed/simple;
	bh=l71zOi8Iii2rT5j9IBt2SrlxYshazF9y0u6uvVNTzAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZAAhUfAA6KhMhY+lLHPrfecCgaI1nP0ewU1lV1l3d5lqGOmqVeFAt54TRUeEKglc5UKbqM4CLvF45p3icw2xOtzHhvWUDu6hfyepOp3MR9GIhSazcrH1gbVz8Y+5t60w0ew+SfEdHBYOL6tnkCLe4SZ0ivIGLirABCezFpCTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V6L3jrBT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D7Q20A012540
	for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 08:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CnjUTiX3FGPPzQybFpvUaFsk3SaXgmCmOsQbRYEOBOo=; b=V6L3jrBTbTvHHEKo
	qD5U4eFHTxnbpsqXc4cOpzkuMCTQ5epNY9DjJjkGLJL1qr6r0S4OFd5EdlW4yKCJ
	WAgbjSG5zqOQzCbAlZaLfx2fgKrZnyWU+pe1FW+xPMm7zYUVcOgdInhv2VqIb1YE
	/8spKAq0l2LlOD9R/8xSGLcz+mrsa40WnUDOPuUFFaQf3Ot9tdR7CKRQMlJm9mEn
	F1LJmDAFnsYKeaU2FFa4xBj5MdtSGdU9dDsVNnLbD8CdNcWqDqVuiSzP0gCs0uuZ
	bJhuaktE8ndnYcXHi0xu6Klfu6NXf7VeX39SjgEj+cfOzKXJfxzJcj7ggFw+6AUZ
	TM5Rlg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1a84gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 08:19:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85d43cd080eso248752385a.3
        for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 01:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343547; x=1760948347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnjUTiX3FGPPzQybFpvUaFsk3SaXgmCmOsQbRYEOBOo=;
        b=HjSDBvoIn6xuPt4p3d/PJo57aNHPPwmtCtTD66NE3VZ5TIIXGzAVW2seP+JYwzjuZ2
         SSvB7EfDSAfddv8Kd2UFZ/3R3AbdGRCunceUbRHEt1dCjvlibywJojhZFg2nERD7SU/+
         GA6Zpcu8j0EYiNvp+MhhrmMR5TBwB6PxgqhnEJBYZgUkLX1lDA09VwcREvrmBejqEyBh
         W36OAnB18P40UUA4ijLnDAoL5rEFNuzlgY6RGym5DzOYzVCdw5yqG1VmakUGYZS355f5
         KniV8QdjHIMy2ECS43lYEDcnZJnd6opXmAMBwMZMlB39+Q1qDyplOijq/4aAfawZXzxJ
         Cakg==
X-Forwarded-Encrypted: i=1; AJvYcCVQupT61aD4CmSFz8dRLtv7spY7CasoK622RUPhi71zby+5Fxt9E0w7EG41Y006nJBTCDlGStp9MQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxifKXJ6clhSqydpKY2g8m4YdTnwc8pZSo7kpulU1+0/Zz8YZAO
	/mEX73m6JmP9nQ8j5yDKUIMPWnZAiFwcNDheuULIM+qqeFLpJ4kiOiCIIZ7WAv7FoCda9D+EBJI
	qw/JqHm5Et3jVWfuOETsX0Z7PRGVgL/BKiN53c/hOU4md+9AByeGc+EFHorBy2EIc3W5PDL0=
X-Gm-Gg: ASbGncsIfKUCKPvEULucb4Tjy3zzDRqX1FLdKAh1+LV0CFEr6QIIT7jcVUpkyvw1/NH
	Pql4RdY23h2BsRKW7rDf4LaG2hY23UNWb9AA/MPTRYegWe6vqybUePBcUMiW2BZeITieDVLIad3
	zSmiBCihqvcFjIdMuhl346EXIcgjxlLmqexAZeY87ClSud7yC7+lclr5AZ9yPrFDtPoi0VGALdU
	CGHVmF+P2cq/ggUUZmIllwwCKy/r+WhkwuOjwc9dWi+dNURtxuFSyLFx4CB0QOxGV0NMT3MFyE2
	LptF5VgSWsJb1DJsUHbxzmSmu0TmPkZcGNlgXA6v0i9Go1qYC1mQ8oQS+wHVI3LsePhhu+0KQZY
	7xWqeA+Qgm3PfJaRg0UQ7hA==
X-Received: by 2002:a05:620a:711c:b0:85f:a278:78bf with SMTP id af79cd13be357-8834ff909f1mr2008314285a.3.1760343547287;
        Mon, 13 Oct 2025 01:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4znKrO6qzvVeWk9uZKKfQVBsm8qhDDyjnyj9kOQFewTkZRDPaivS5qv0Ack9eGJHz4piu7Q==
X-Received: by 2002:a05:620a:711c:b0:85f:a278:78bf with SMTP id af79cd13be357-8834ff909f1mr2008311885a.3.1760343546780;
        Mon, 13 Oct 2025 01:19:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d5c2bsm873147966b.37.2025.10.13.01.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:19:06 -0700 (PDT)
Message-ID: <01122bf2-7f8c-4d93-9557-c625b4eac631@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 10:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-5-quic_mdalam@quicinc.com>
 <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
 <911ee444-25a9-a645-d14f-72fc239e5eb7@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <911ee444-25a9-a645-d14f-72fc239e5eb7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ecb5fc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=OlpJZY4RW8OWQeam8GsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8Wej-39z1Pa9SdN3gYpISfHrtVbFZxLV
X-Proofpoint-ORIG-GUID: 8Wej-39z1Pa9SdN3gYpISfHrtVbFZxLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX9SK3qaVy7KYQ
 6ZKOUN6vQECOBpErt14qrVVN1e6OSFCj+4UWXFchwUsIJ385Ibm1Mfu4U8KDcje7FOI8mNcFMoW
 p9Fph1J03CCqUxqEjjXkE75hBeRblWjSME1xFOI/nWACRTp73c/OQuEjCvmTxwa5ekZedVIzXpL
 44eak7jxn4MS8xTuePR5aAcnVvm057dmipl2y6IGOf00wzW8864FuZEn5EFMq3wU+O4n0TXXqa9
 XUy4+JXubPY5ixl3VK5RupsYI6D1gU3K5K4DNWBjN5VBmETWYmHkHsKOwidujvTUUZsGGOmxFJl
 0UTQJraWHF7/tHt15gfZ5fjFmuYxr9EZx2yU5Pajbd18NUvL7Sa2eLP0IjtgnmN8OSGKSni8hws
 RxFE1N0s+hFIxXiESKJgBy7u62Y6+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On 10/13/25 8:10 AM, Md Sadre Alam wrote:
> 
> 
> On 10/8/2025 6:00 PM, Konrad Dybcio wrote:
>> On 10/8/25 11:04 AM, Md Sadre Alam wrote:
>>> Add device tree nodes for QPIC SPI NAND flash controller support
>>> on IPQ5424 SoC.
>>>
>>> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
>>> devices with hardware ECC capabilities and DMA support through BAM
>>> (Bus Access Manager).
>>>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---

[...]

>>
>>> +            dmas = <&qpic_bam 0>,
>>> +                   <&qpic_bam 1>,
>>> +                   <&qpic_bam 2>;
>>> +            dma-names = "tx", "rx", "cmd";
>>> +            status = "disabled";
>>
>> Is there anything preventing us from enabling both these nodes by
>> default on all boards (maybe secure configuration or required
>> regulators)?
> We can't enable NAND by default in the common DTSI because the GPIOs are shared between eMMC and NAND.The decision to enable NAND must be made at the board-specific level, depending on the flash type used on that
> particular board or RDP.Enabling it globally could lead to conflicts on platforms where eMMC is present.

Right, thanks

Konrad

