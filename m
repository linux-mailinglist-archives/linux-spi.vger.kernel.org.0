Return-Path: <linux-spi+bounces-11618-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D7FC8DCBC
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4B34F5BF
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A5432ABCF;
	Thu, 27 Nov 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SlN24uah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gLJKlkuq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0632AAD8
	for <linux-spi@vger.kernel.org>; Thu, 27 Nov 2025 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239732; cv=none; b=XVqrFFxZhBLt2hCI/XKNkbmFK8KAPjLxACK/c+NCN9FMgOeymXTmpzgRelJsW39VSC9XdRXS2kwW3ZnXIpfVCOQwlcYVFjy2ZOilAJA3H0QRr+ov6SCoWcpQAbrizbERgsJcW1x3DHgjzO4rua9sJkrL+OpmgjP/Wnxd/mMmKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239732; c=relaxed/simple;
	bh=IZmOkOUQbvF51UgDQA2iegvPseiOnRU6qrfwOaGYGDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXjIxeJTTJxLyY6rcrT5T7zudGPodlZFjZue7exPWbTvfL3z2/h7CwukP61buP9DF+xe7ZHFoiv8NyYCwvcYfzLdSgTni8BeykUQmUgdhKSVgwL7pnHenLA0UGWjGg0fubAJe7WiAmVS+fsOhyQxVT9XxGm8XEHUZQ/9qAU6nAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SlN24uah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gLJKlkuq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARAQFgd288404
	for <linux-spi@vger.kernel.org>; Thu, 27 Nov 2025 10:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CQ5CZ5lkuQSkTy1eBTndhJ3KeWKax61oz52wB8xUhs8=; b=SlN24uahbwtlyyV4
	oaalvLUI4v/QdrgbpdAm38rwcIDbx2jPQRnVV2U5jULC0iGLSkfEWaaV6kMlaUT9
	BIRiif7RMNtXgTy8Y6AVR8sOnZ5xsdmSi7Hdk8Wt+oCJF2OsulYRQtboMZFyIh4S
	rXvuP19226cg5J7y1cJnyDPEe/LucFfehGob0qMAmAgKGh7nnT0lqLm2NMjBbYHN
	Eo3vATvAQIZ+MhELASQ1g11Jq3P9mVsiri+BfsZXkUynTpYGtGvYZhpmocH+Awu0
	rA8o09Pb51afzMywmDzCZz0cobFdNjNMdAbb5EijEnRtCwsFsTkzuQtIzv1rRAol
	kavICA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apmvxg0ve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 27 Nov 2025 10:35:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ede0bd2154so2190221cf.1
        for <linux-spi@vger.kernel.org>; Thu, 27 Nov 2025 02:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764239729; x=1764844529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQ5CZ5lkuQSkTy1eBTndhJ3KeWKax61oz52wB8xUhs8=;
        b=gLJKlkuq+T6vNFtfHQiB8aIi0XbJxlUaS6bhGDd/TJfMGy0Opjo4WSEjF/3L9kYzXw
         WSduWapphgjNgIvGnc0pIQqsmJv0d11Dw0C30qBxkUdrYyB45reDvA1r1vk6vhBLK+Nd
         /TfusY+tb1Cm76sIuWApzPZ2Ym+pX2o3nj5dSR3LDJ2XoLFkMEmMbA/98CqVgksTW2hV
         1SQ08ss/HbDnyOF2pCAw2BSoVKCh0RxGwOJhMP5TrtLue4+A25kupPqBXSWyzWhsZ8Jx
         PykbVdwkB7mju4lRNUGLpJpfjXEZdOeb9XtdmK9dNlOGJJ8ugRDY0q8A+1YUevSX7olA
         awPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239729; x=1764844529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQ5CZ5lkuQSkTy1eBTndhJ3KeWKax61oz52wB8xUhs8=;
        b=TavOsmH/DoYqdLaMFx0axNB9yITPMG0SW0RC8jQBDhmCayC3WfSzPhBnOkUgqliCRR
         ZINtb0xiRKqN4vyD7cmlsH+BAItqCk75o+HGuhmeyOltD5jH0uUx2mLyKkpd1SZ3pI/7
         v4nSf3tDLMbNMN/3JIDVWInUjZ1bVCU9Zl6soJZ6kMGiIxfx+s7eShSR9p54R1Lfs+8D
         4ZNKWbVsaFOWULvRtD59l3kTu5P7kQLmWeAsihI+cXoLdRcHQIohImC04qLOXdLNHc5r
         Nd4+7r641LjS6F/TvP0Mq8SC1IxYU8la/8mCLoCQva7HPup5Ex7gyfiKA+Za/hjhP1ev
         z23w==
X-Forwarded-Encrypted: i=1; AJvYcCUSn5INsJHDTFNK/KAM15fZ0nElpE+ANXBR+6/vChBbaQB6V++Yu+kqOJIVwPiYpQ914C/3t/kdXCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyick8kRKyGYare572hjg4ER+7hCXuCryGC6Hhxmc5PRNf4h6+p
	QpnJOyIe5g9bHYzc8QTRNgf3K+UcFJHcZe91zrhoPMUmV72sA5T72VVMHk8ZKa479XrfNZHy5r8
	139RZ86Me2UA5d8f+f0AxeVO6BA5NsyJFO3L0DcHjoUBohhS7z6VAvKT5qNpN8cU=
X-Gm-Gg: ASbGncuN8FgWJ6Fj1uZ6zchbHwAurxg7yN6CvNCntROG03ZjeA2R3Z+vlUHoYiA1Ds+
	sKsb47VP6XzhBtL0blAPTWBYHMU5rr7lRrWU7GFE8neL406IQ7JalEeOI7c6zmTiyZi8zwm2q7O
	XzcnenRIuHyKW9+ONBdXMVCNd7YOBvYfVVDmhfD3ATeiAYGRA0kWg+ys53eNWTBJUusP7fZ39DB
	S5lMYAs39F64hnvOKdDDxXtHbEHyuL9ktG5xWYfP7S4xH4gaZ5iWl0dh7px7XRZjcvlxHPc4fnL
	sfNGzR8VoK+Z+1qxh/Ugf5LWJ5aoOh5n4xlqjssrIIkrxGKffJwgkzbhuOFqvnjxHZ7OfHiPbPR
	CPLRbz8EQ9zOVn6oSRGnnRENJNkdAtd2yTBUusboTvOTOjZ87oKjsaA0HiG2hWc+JSLQ=
X-Received: by 2002:a05:622a:1349:b0:4ed:7f85:225c with SMTP id d75a77b69052e-4ee58941ff1mr231590801cf.10.1764239728933;
        Thu, 27 Nov 2025 02:35:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlXaY7uUqM1LyPWltTG04p98f76EvrzQJwc+84Bz/HUgMBrU8eYzDS1q0IVPkNXaZGOdc38g==
X-Received: by 2002:a05:622a:1349:b0:4ed:7f85:225c with SMTP id d75a77b69052e-4ee58941ff1mr231590631cf.10.1764239728453;
        Thu, 27 Nov 2025 02:35:28 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6ea36sm1204454a12.2.2025.11.27.02.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 02:35:27 -0800 (PST)
Message-ID: <1b6342be-bdd6-44da-a279-28b55f7167d9@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 11:35:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: qrb2210: add dts for Arduino
 unoq
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Riccardo Mereu Linux Kernel <r.mereu.kernel@arduino.cc>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
        linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, m.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
 <20251120155825.121483-7-r.mereu.kernel@arduino.cc>
 <45329a9f-545b-4425-9667-26bceca67982@oss.qualcomm.com>
 <CAKA1Jha7HuEC-KgGktmuiG-U0ZVbKnmLU4bXTwLg+paoLpQ=kQ@mail.gmail.com>
 <CAFEp6-0kHtbXKQRtaLUB1bqRV5s_c_bcoAWPdTOH3JvV69rUqQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-0kHtbXKQRtaLUB1bqRV5s_c_bcoAWPdTOH3JvV69rUqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vtguwu2n c=1 sm=1 tr=0 ts=69282971 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6pAWIAOP_nUCoUPfe-IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: PmsOSLk2HRrDu_RhdfHh14H3Sk8kbR9V
X-Proofpoint-ORIG-GUID: PmsOSLk2HRrDu_RhdfHh14H3Sk8kbR9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NyBTYWx0ZWRfX8IsZSr1vSjsa
 D6xlUTU11UdECWUx/D/9/XAyHoPvt4QX6+J7UeavbtX9f79WXfQ7kIpCN3FxwsiaSY7PDP64YJo
 dIjoql4JU6ZOvBi2YFhMBI0KidaznRX982x2Zxp6prvXi9xH9ZiqxxApRN8as2/OxVUjAB0puDm
 eZbvk+qcbr1w9VRQCkHJNraSge0FzhaardGZs8j45hC+l+E3myjzKue/XECnyGVk9kJuzaxkSty
 2QG4/VeD1VbkC0Ty95fzLNHO0dq/IYjvPfe92DUPXV7bkQiLGzEGceUsXQT8VtuGxx7nBtFnKSt
 4i4bfREYq+3EuLOWM0lPW8VDOuH6dWrczaqC/v/e6g1yWAkk8PbzTrNTHOU+Fp56tNme7Zd6cYu
 JrKBdCGW5fKtjeAcmi9MDqt4VLhKig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270077

On 11/26/25 3:03 PM, Loic Poulain wrote:
> On Wed, Nov 26, 2025 at 10:28 AM Riccardo Mereu Linux Kernel
> <r.mereu.kernel@arduino.cc> wrote:
>>
>> On Mon, Nov 24, 2025 at 12:44 PM Konrad Dybcio
>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>
>>> On 11/20/25 4:58 PM, Riccardo Mereu wrote:
>>>> From: Riccardo Mereu <r.mereu@arduino.cc>
>>>>
>>>> Arduino UnoQ is a single-board computer combining Qualcomm
>>>> Dragonwing™ QRB2210 microprocessor with STMicroelectronics STM32U585
>>>> microcontroller.
>>>> Support to a simply boot to shell environment includes:
>>>> - UART, I2C, SPI
>>>> - onboard LEDS
>>>> - eMMC
>>>> - WLAN and BT
>>>>
>>>> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
>>>> ---
>>>
>>> [...]
>>>
>>>> +&wifi {
>>>> +     vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>>>> +     vdd-1.8-xo-supply = <&pm4125_l13>;
>>>> +     vdd-1.3-rfa-supply = <&pm4125_l10>;
>>>> +     vdd-3.3-ch0-supply = <&pm4125_l22>;
>>>> +     qcom,ath10k-calibration-variant = "ArduinoImola";
>>>> +     firmware-name = "qcm2290";
>>>
>>> I'm not sure about this line but otherwise this lgtm
>>
>> This should be fine, I'll gently ask Loic (added in CC) to confirm that.
> 
> Yes we need to use the firmware APi file under WCN3990/hw1.0/qcm2290
> as it has the correct configuration for the QCM2290 platform.
> From log: The wlanmdsp for QCM2290 / QRB4210 platforms requires
> single-chan-info-per-channe feature bit to be set.

Thanks for confirming folks

Konrad

