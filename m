Return-Path: <linux-spi+bounces-11095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE1C3C710
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 604AF3501E1
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B534BA21;
	Thu,  6 Nov 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+pna2tc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B7OKnQ5b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA434A3A2
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446596; cv=none; b=cQKre1hyD/zMGjFTzijKzjNI9LxeoG56+tthFkZfvH2KDPfUfi9TECbQWaud1xMn3KeqPRAMRQmQfyVRUuu7rr4v6Wmn8/cXtMcq1UxuBftzb1JNFTxxfVW0rsEBU8MTChx2D3JweAgjmKQBgoKqEthYluAKcdNTdxVXsaFByJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446596; c=relaxed/simple;
	bh=VzaCR7H9TvLPBQ9CB5Z3dGT3hJnO4fASZTntV/6fnQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAg7M0NtHmoWv9kQdouLnIu62A6vB5D38lR5a+d6heSZWJzcxoatCkfFlXJLJtY9PtGVKWt/uK+afhqyU8lHXDJd0WqZtY6D1HwIJ6jsOG+yjJ+6doZdcLCR6cITSAKf8iIn8F4EeYaoxEUzGBfH3aw2/A81hQY1225wM6ZcVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+pna2tc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B7OKnQ5b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6Bl9od4131318
	for <linux-spi@vger.kernel.org>; Thu, 6 Nov 2025 16:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WgmN4NxVV9M82DvCj9Jb02Y2HdGbR+gEIO/NMxbQG2c=; b=n+pna2tcBKKGun8+
	JzSqkJXPMRjIBF6qXOcKmQiubQBM6XujHappE5+x3+jLCALbEyBBN5LGeymXYwOx
	OOhX2EiLEoxRqr32SzZGRR73sFJCwHpnh0/64k8lxP+ofNmuC2cpmCGUetZs43Jm
	Z2KsmZvdAqYC2rQ0OSAoREsz70vbSDK37yh1/MI5RO/1v1xHyqfEDOCT/wKibL40
	3ENESVruLu3ChY8rKJk4TtBo5A1wn3ub7LKiw3ebJ/a6L9lvmvFfJxkUlCkuRQcS
	pWUVl7bSW7Suu3so/1zx4B9Q7x/i1Vgyhq1qlhoFmmGmM8FwGmjMl8ptCYGxqszh
	LRwE1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x0vhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 16:29:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6317be8cso1837961cf.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 08:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762446592; x=1763051392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgmN4NxVV9M82DvCj9Jb02Y2HdGbR+gEIO/NMxbQG2c=;
        b=B7OKnQ5bRC/v+aNm8cYnQK3BOknlp6i/HyiOuDPYfxWJRi5/6bZo3TzPB8HTkpbMIE
         vv3/012RR0nf9MjqbpvDCoWeab1zWIGSueXyG45yhj48OC4dmCHgk8tFVt4z9Zj2LODb
         YFwK6MP9mugDfZFEvfZq6lCKE76jOimc9JitePtSqSY2xLrLH83XwCNZ8YjTK2FxtFQZ
         SAmUADIhkwO9ukkWrs5FDxDFW209YoUpdrUk9uagKGLJibqWenRGtXXEEjBQS4WrMI73
         J7UswYEsSsuyAgMZ2Ja1lOb8uxmtp0nggz3RJ4L/WDhzUHyjgY+oxYeNJa7YKboeov2B
         w9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446592; x=1763051392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgmN4NxVV9M82DvCj9Jb02Y2HdGbR+gEIO/NMxbQG2c=;
        b=fh0oxlvbp/0Jwo+adGeuiHSKqOSPohV9U7v//PmIwbMFCWfnBpUX81/7dEYtXcdYE2
         cUrhXyC+YLIs6vPLJqVZWGHJVjT2v+ZZLW8JLC8efUvDM2gwrEUs0l3O0GUBuRwJFcDX
         69hAixYdax18IIGuiytg4J91ARH3rNiaUNj7CuTX0lMBL3ezMc9amJEsHUmC03TIndCe
         h0XCj88uZ8m8bn+mrPb3T83S9fm2cPUtuy0BWqObHE2SYloAf0bkwYpEC9y5El6PRc21
         KS/8kTq1AGT1q9IKmyKCZJPq4ekHdmNdcBhhlAbp5brGd9tsqjNTi9JfkujFoTJvityA
         +Qyg==
X-Forwarded-Encrypted: i=1; AJvYcCUdy0JWG+nRiiutgEHaoyMhxXm2vZK933dk4Mkw5b0RuI4oyrQU6mfx+YP/R/EZX5kKQ9cTk7YnLCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl5gZqGdfY0hq5fiY6odNqlDNM3Jy3i6E5kCR34+WWLtTdayBl
	8AnIpvouYzmcKNyT+0+W6O37cXTCBnykjQ2kSPFRsLBmeYMQksUxwhMiX144Jg/lGJPLtjxYzou
	EV7gQNqtx7h4EVSsumrDg3MHcIJJsYFKt26QAbBLBg49KPKaoUJczKMBMpbxbfkA=
X-Gm-Gg: ASbGncvA7C3apy7Z2kDvl9xWgiocjvthlvmiUGCwDL1Euia1mF15JOD7RyzRlZEw9mG
	jgBSnKJPq9gT7M9VIy2Z8GeMQec6fvVMxidDLbhza1IZDQCB0Br3HMl9hcG2qyVzB7P2V8eCxgL
	O2JsReFYI3MmsFLAjOSs0r2VWjh7EfAwyPda5ARjwQ+0eDIcX9Cbupn+OlRjiF7l0lsT39PImW3
	bi82JI61JSg9Vi7/myqUZ1zFjsytE2c+Snv23E6g2xc1tbdGOtdNJy3qRK7rE5ruKZiYmUBmZad
	7ZMvVfiOx3+vSppV/r/6inCgdDYgAlxB3RIASRqZ4ST1lA3fyqGHiYWi7Ak+35lQOw6fuS2n89n
	vysMQscdp95HTn8eubztjPrU6FqlGFqmmfLgwZK2r1D5yWizqlemvfX9+
X-Received: by 2002:ac8:598c:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4ed7233c5acmr59986351cf.4.1762446591906;
        Thu, 06 Nov 2025 08:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZxjYZc8rxsuvOHdd3txcVs2PoTli39CB2wIhCv+eMHSJx/cwSSBEXCcPzDCkWvSvQ6pH8rg==
X-Received: by 2002:ac8:598c:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4ed7233c5acmr59985991cf.4.1762446591404;
        Thu, 06 Nov 2025 08:29:51 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289684873sm246890766b.58.2025.11.06.08.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:29:50 -0800 (PST)
Message-ID: <f20fd593-0173-424d-9951-e0f2ad33b4cd@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 17:29:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: unoq: add dts for arduino unoq
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, broonie@kernel.org
Cc: linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mm.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-6-r.mereu@arduino.cc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106153119.266840-6-r.mereu@arduino.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzMSBTYWx0ZWRfX3xNVP8+cBlDS
 AgpgRAewjdHE8hq9DHvXgpKTV+cwESBWBAIcADj0L+Z/udtYx+TrZIlugKZRGyb8t1M9mUgoaTF
 Tyi6+B7r3g6uhgF463HHhu6G0H4CEfpFfDYMDJdL+jwju9a+7XI257O8h3/pdhPs7Ey20aTY884
 gkL7Gi1a/WltR5j+SYBBunTF4ecYiSR8KadtK05+ID7SMKk4XqaJeIWq5FFRYLuI/jdSzvVOqVz
 pI17U0c+HKjZ8Rp4GYetD8NQqoKHn411A0m28wvTDfZCD5dnf0Rsg4FPiN9Gc/SDgevs3hBj0Pq
 AqgnOZSJEmUr02VhVvTcsCqrx9K1FqGquWb1NZywwxBoD241Nxyl/stfj2SZX1Xya6itMp64zXr
 tzR2VXlvFj2UsQ6AxVAzwwNdJ6BkUg==
X-Proofpoint-ORIG-GUID: c5O7xHMH0YD6_lHpmvQPjL2tOPOF0MTA
X-Proofpoint-GUID: c5O7xHMH0YD6_lHpmvQPjL2tOPOF0MTA
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690ccd00 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1Br4yamZUyoIW7x64XAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060131

On 11/6/25 4:31 PM, Riccardo Mereu wrote:
> From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
> 
> Arduino UnoQ is a single-board computer combining Qualcomm
> Dragonwing™ QRB2210 microprocessor with STMicroelectronics STM32U585
> microcontroller.
> Support to a simply boot to shell environment includes:
> - UART, I2C, SPI
> - onboard LEDS
> - eMMC
> - WLAN and BT
> 
> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> ---

[...]

> +        leds: leds {
> +                compatible = "gpio-leds";
> +
> +                ledpanic: led-panic {
> +                        label = "red:panic";
> +                        function = LED_FUNCTION_INDICATOR;
> +                        color = <LED_COLOR_ID_RED>;
> +                        gpios = <&tlmm 39 GPIO_ACTIVE_HIGH>;
> +                        linux,default-trigger = "none";
> +                        default-state = "off";
> +                        panic-indicator;
> +                };
> +
> +                ledwlan: led-wlan {
> +                        label = "green:wlan";
> +                        function = LED_FUNCTION_WLAN;
> +                        color = <LED_COLOR_ID_GREEN>;
> +                        gpios = <&tlmm 40 GPIO_ACTIVE_HIGH>;
> +                        linux,default-trigger = "phy0tx";
> +                        default-state = "off";
> +                };
> +
> +                ledbt: led-bt {

The labels (label: node-name@unit-addr {}) for the above 3 LEDs and
the group are not used, please drop them

Looks good otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


