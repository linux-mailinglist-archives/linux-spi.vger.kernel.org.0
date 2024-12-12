Return-Path: <linux-spi+bounces-6043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F6F9EEE6C
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 16:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603942869AD
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA4222D43;
	Thu, 12 Dec 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GhBa2UBz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDE2210CA
	for <linux-spi@vger.kernel.org>; Thu, 12 Dec 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018999; cv=none; b=s/6ICO6Vh/6QX3ZNmExnC2WQHeBFh52n79jNsAwFZDqmNM6oC9/tjileF8NQxXUvpH6gGX/gA2+BWDWt4qQALin/fcTki60/9uVk9b89bahlZZXrveaVR77PXCoI70fUTYOir1CMqMuWcaKzAUUAlHnKt2yd+F2yeb6N2oA+QQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018999; c=relaxed/simple;
	bh=3C4Yt5oeNRaxZqqS6cTEgAB9qT5fjNpBMGuaoHcL2gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA0/4Zf1jJ+1mXzYCs7L3F1ddumLjmB1mJBJx3zfPAp/VoEwj+sltgb5QFiyWnmdAq5dTmkGk7KFoafRrHIPKEIXuxnx5QypRLqPz9spJQRW2z1Gyl9bEOkG7CMRHUu7v0uj4PMx3g4PMR/6Dezu6PDr2PuHMAcDMaY/4dalBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GhBa2UBz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7eW3w027149
	for <linux-spi@vger.kernel.org>; Thu, 12 Dec 2024 15:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n3nqq3ds2PAwM46hFlxa1nrVPoI1aem45H25wLz0YZc=; b=GhBa2UBzDWDC9qNH
	PyDoEL6SJBJmonT+danyYZyzmWIv2g9+Oo/nj1/YYmW+uI7BYqeFfTRuWP7DFLNu
	1EeUurdeptMgCP4rArd/ZC9NK1R3thQS2F7WMjA/H4bYAw2641wGvHo8cydmoozp
	nVd/x4kOVwncwO+7CMBvy01BGo41AegqEcvXR4eYTusFPCxILVOaHW1IkEVdsJOi
	lTyYV63/7AWiovZ1aKIuD5AxSIOwyYPklN24lKrjuBmx8ZG4j79g6vwbaXW1Imox
	jHv17FXzLoE+0bSt3YcyH9GiENQmlsZRsXdPWXsbXl/BSztn82I0IcZs+Nxm7h+2
	QrcEDw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43etn8xrsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 12 Dec 2024 15:56:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46792962c90so1235261cf.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Dec 2024 07:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018995; x=1734623795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3nqq3ds2PAwM46hFlxa1nrVPoI1aem45H25wLz0YZc=;
        b=YzIkD/v41OABuBsiFw9QzeJZcdEn65H411twvkiw58nVD048qWic8x7OCoAZCNBsN4
         HmYOzNMtzJI245X+aMeQPUPNJvxSwiWxGT1tsdUbPOTnCWCpgPT1UO5RN9DqyOrKpYjU
         FAx6HyzOPdhz/8nt6K6ox8ImUl3RB8fxKR1cfqP2RBr51sR9Ho4gMS3AGI8UeKBvanmB
         pjpHlEqpUL5oFqUaVK75nHSaL00An4nNR51VU7RXDKjflllHh2mj9oJfIRmymU327SFl
         x9nDA2odEOD0WrohtvQyt9l6QWJdWttTNPY1NGnlsCbC5Cv15dLAcemfEVdmzjzAKfLS
         NlYA==
X-Forwarded-Encrypted: i=1; AJvYcCWxERjUNIGFWQ97syX0Syehx6Et+Q0JOQT3wimbengG2qu+X1FPW6WIVLCh5svNQlGSlZ/tFpdtUNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIok5Ozg52uEfmMz2xbpvA7tWQHG643JR+zfrBPdTBgkEWwJf
	sbFVBJXtSeFiI/vOFB50MpOb4RlmS41wb0WOOq7OawK+IjsE8A4oAshk7poU41bPvC+8K1O1LtP
	oC1bgw5WSqD2crubyLv1ks1QkX30CnyTEWnHzVZ83QUT+uIcKeMGum7KVCcs=
X-Gm-Gg: ASbGncuicQUx90pU9L8fIH1pO3LRzliaNxuMFb3MA97IY7C2iwqBbYzuOo/YeOA9u+V
	6GjbEaDR2eTO5URvNMklHxAy2u7X+nfARGbmjsnoONahSC80D+pCLWgxnQ081Bm6M5/LF69U6Ox
	cQ9bWpoSESdxKuOSEnfWFttOwjGsF8fA++JM23ZKVz1jz2O3FnYQ/H5xWQU5F0ECV+YPVTHPHNk
	TfBv/Qysq4yMw4LbBxP71nkhWMNZyvRdCiMtglwgSpKQt3fayfXoZLU5tnb9yXjfmAdpl9vhad0
	ufNVoJz9d1hmZMIYgmWErnkHLypfZGF6Ns0G+A==
X-Received: by 2002:a05:622a:199a:b0:467:5462:4a18 with SMTP id d75a77b69052e-467a13dbb86mr5797611cf.0.1734018994480;
        Thu, 12 Dec 2024 07:56:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrTTXRfbuepculS9NtXEOABh5da5aY3tMlxBBBwXa+/U6qTkKw/SXlHeil5FX0OuqtidmsCw==
X-Received: by 2002:a05:622a:199a:b0:467:5462:4a18 with SMTP id d75a77b69052e-467a13dbb86mr5797071cf.0.1734018993424;
        Thu, 12 Dec 2024 07:56:33 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683f9a8fbsm626885266b.37.2024.12.12.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:56:32 -0800 (PST)
Message-ID: <8ad1db59-9326-461a-ba8e-52891922eb3b@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 16:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Add support to load QUP SE firmware from
To: neil.armstrong@linaro.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,
        Viken Dadhaniya
 <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: =quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <9d5e5b8b-aeaf-4ec8-b34a-8edeaec20037@oss.qualcomm.com>
 <42b1c187-e924-4690-8338-4c694f3e16d9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42b1c187-e924-4690-8338-4c694f3e16d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: INfrFonFDG0PTFTfLQJdfxZEz3nOWBJM
X-Proofpoint-GUID: INfrFonFDG0PTFTfLQJdfxZEz3nOWBJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120115

On 9.12.2024 3:45 PM, neil.armstrong@linaro.org wrote:
> On 05/12/2024 16:59, Konrad Dybcio wrote:
>> On 4.12.2024 4:03 PM, Viken Dadhaniya wrote:
>>> In Qualcomm SoCs, firmware loading for Serial Engines (SE) in the QUP
>>> hardware has traditionally been managed by TrustZone (TZ). This setup
>>> handled Serial Engines(SE) assignments and access control permissions,
>>> ensuring a high level of security but limiting flexibility and
>>> accessibility.
>>>   This limitation poses a significant challenge for developers who need more
>>> flexibility to enable any protocol on any of the SEs within the QUP
>>> hardware.
>>>   To address this, we are introducing a change that opens the firmware
>>> loading mechanism to the Linux environment. This enhancement increases
>>> flexibility and allows for more streamlined and efficient management. We
>>> can now handle SE assignments and access control permissions directly
>>> within Linux, eliminating the dependency on TZ.
>>>   We propose an alternative method for firmware loading and SE
>>> ownership/transfer mode configuration based on device tree configuration.
>>> This method does not rely on other execution environments, making it
>>> accessible to all developers.
>>>   For SEs used prior to the kernel, their firmware will be loaded by the
>>> respective image drivers (e.g., Debug UART, Secure or trusted SE).
>>> Additionally, the GSI firmware, which is common to all SEs per QUPV3 core,
>>> will not be loaded by Linux driver but TZ only. At the kernel level, only
>>> the SE protocol driver should load the respective protocol firmware.
>>
>> I think this is a great opportunity to rethink the SE node in general.
>>
>> Currently, for each supported protocol, we create a new node that
>> differs in (possibly) interconnects and pinctrl states. These are really
>> defined per-SE however and we can programmatically determine which ones
>> are relevant.
>>
>> With the growing number of protocols supported, we would have to add
>> 20+ nodes in some cases for each one of them. I think a good one would
>> look like:
>>
>> geni_se10: serial-engine@abcdef {
>>     compatible = "qcom,geni-se";
>>
>>     reg
>>     clocks
>>     power-domains
>>     interconnects
>>     ...
>>
>>     status
>>
>>     geni_se10_i2c: i2c {
>>         // i2c-controller.yaml
>>     };
>>
>>     geni_se10_spi: spi {
>>         // spi-controller.yaml
>>     };
>>
>>     ...
>> }
>>
>> Or maybe even get rid of the subnodes and restrict that to a single
>> se-protocol = <SE_PROTOCOL_xyz> property, if the bindings folks agree.
>>
>> We could extend the DMA APIs to dynamically determine the protocol
>> ID and get rid of hardcoding it.
>>
>> And then we could spawn an instance of the spi, i2c, etc. driver from
>> the GENI SE driver.
> 
> How/where would you add the peripheral subnodes ? A Serial Engine can only be a
> single type on a board, but I agree we could have a "generic" serial engine node
> that would be differenciated in the board DT with the protocol, and use the bindings
> yaml checked to properly check the subnodes/properties depending on the protocol
> property.
> 
> But we would still need all the serial nodes in the SoC DT.

Correct, but NUM_PROTOCOLS times less. NUM_PROTOCOLS is 3 upstream as
of right now, but it's much higher in general (which will trickle
upstream one day or another).

> 
> This may make the software support harder, meaning we would either need to
> have the same compatible probed in sequence from the i2c/spi/uart driver until
> one matches the protocol, or have the qup driver spawn an auxiliary device.

No, just read back the protocol id from hardware (if the SE is running), or
from some DT property (if we need to load the FW ourselves).

Then, based on that, we can call

platform_device_register_data(dev, "geni_i2c", ...) 

(or similar)

> Honestly, not sure it would be much simpler...

Not sure if I'm happy to maintain NUM_QUPs * NUM_SEs * NUM_PROTOCOLS DT nodes,
per each platform separately..

Konrad

