Return-Path: <linux-spi+bounces-11478-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02365C803F7
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 12:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCA33A7322
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D32FD69B;
	Mon, 24 Nov 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuG32zNT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H2URRrqP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046C248F48
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984673; cv=none; b=uiMzqr+664uwsYxFEBdzhV4NVdRKl/vXpG6L8iNu8s++8+dPdiAQG9Ity8zzhCZl3RlqnkFg1Y2KofFecGPEbWOjYPxJL1DkPqFgza1WH+d4eI4mH6PJ243wyRmLbY5bv7fZZPJGAyh0nc7jg3ZkbIXoA4/ZIgcSi4IfWrMpg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984673; c=relaxed/simple;
	bh=HPZYSddiKmAouGZQW6FPuYgBIvT/zG+pnZIIMEdZP0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev0bgUEAt4Eogxy2qchRNiJgkHfDie2tTQCvNU1yM3Izha4uJZZl55H1hMcyoZ75Jl5d1IHcNC/1DjU33kdVTPiNAR3nRLBcYsXnkjw8M07DgR6XeCiAW5Al6UY4NZ4XNgCo0BWxnzJQ4Zjvjxdi4QxMy+85q3cuo44tYrm4gSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuG32zNT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H2URRrqP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOB32BM3884670
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 11:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FP7EIukVk9LiwmzjdapL74dwM4ChT0wr4IXeF9Khs44=; b=KuG32zNTzNI5Ri1s
	8JQyCuOk25rnlU1fWtUVH6HgoV9i57xi/n8Iq5PFyST9MpE7FbwzNULShqjdT7Az
	QcSvqDHBtL+zFwjHPCKhlS0s+5iW5WwsRdRcGkl9ZkPWANoMzwur+GoGbyL6xplQ
	xhsDpSQHBb1YG6Dj8UWdtiWz/jbwP7F+tDCIlFJpy/CiwHAWWtlGfvzxDXy32jw8
	zPiBsMZOhmgEQe6FxUdQauNzvvP2k68bn5eiRsyXscaTVDvbVqeZj7OH4E0w5PK7
	7O93YuivxifHwag+fNmVVMmTmeKqK8SsiBBkOJOEOyfLarcsca8iAZ28xLRpK1qG
	Gh+WFw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amp5683gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 11:44:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee409f1880so9483921cf.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 03:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763984670; x=1764589470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FP7EIukVk9LiwmzjdapL74dwM4ChT0wr4IXeF9Khs44=;
        b=H2URRrqPyUvAILe9IJBkS9BozNeLwf/F98aoNgNhtq4GimlYks444M7j8Aoi037Jyg
         diUcNx8ucAqxY+YzAP7wXITDcOih50oYZrdayr4NChsu8my6GjohDEEHv4cirW5ZXIyK
         YSAmNCS+UBZxls7v4FUOBJbSWBG3ac67+gzq/Ob7lhM05NLa8cTvAoAoqva0Utr12HVS
         8BkuTRThYGzbebewvyrcVDmzgOtlSJ+anEMrE9E7PPAXyvHB6O4EmK52DZEv+BYxf0QY
         BhepU9xYigErDItoab69/X/E3qts7ClyoQnQqtjuVv9I2GtU0mNPxV+DIz0C/ZlKL2AT
         JcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763984670; x=1764589470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP7EIukVk9LiwmzjdapL74dwM4ChT0wr4IXeF9Khs44=;
        b=ISx9XDP4h3SB+TeeVWQmcAEB2xVApm+FjXOgPor3Hux0jqtkMJtt4PJjvDJSxzIdGl
         SjEQeNZoKBYbitsNNYu204G03Xn4B5UEgH8BxebSzJPPNDDZFLtRfpLAz0SV+usIfPuY
         Fs/u8HSElw7dhxPmkDHWDVBoop5233j/G1ZIbcUg/lEi3P6ktFDbh+QnfDa3l31b0CnB
         YsZEwxmjxvman6ZvIkq8jYRAdEcdW9dROx4DWn7jbXsM9DpkuC3IatQtTReblB9BfpY1
         C7aHGQsw+eOv4ltdPnLNTTbLMJBwTleV+naLfASsluBMwIzjWjly9t20WdRVhg5IBGSl
         UVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJHv/8Rxfzu0UHtFGzTbB4BroN/CIMit5uF68Lx/oT56gKW/+RxJ0AGv3doUsTLNbgfyZpCAx4G7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLG9l2egF0VU1Eh5UNBdlAu72TseuZdJ8cYGeN4GWMnUODN6PI
	sJtnK2MJqqyab6KzyKRFqSF9G6tqfuXDfM813PcQC9UTiPgeKgRy8t3H1u0+2hJZMX97jKHZRrr
	oNLG0LndIi+5MKg+SSDD8YfOmnF6FqDRwcGglhfdBscuID9FStsyx+3wj4FCuC1E=
X-Gm-Gg: ASbGncuG59z/HUCd+C7iTp53L7GVXAq3ERHiaosYnHoAIKFl2LM62j5e5xBlUowtO4v
	2GKaz3wHuUnCb0xnn6AHBF43Cs6H2OIjB7kCnlmqI8ASUDn2HZjb5AlTnrRYIszpjchVJOXioar
	BGUIMjfFiXqiIhn1bmgQPH3BlSnihAedA5uu2Qf3Wbh3bjucAealJNeSuvNHI3XXEOU/fI5KrxY
	ZvY/WCWwC92q7TcxB3VhGaufFNS9y8HdZFoRxEKiIOkldYywXAZ8eyBNVSOo/t5NNdN8xE3OaKF
	uMKnqxFXDHgek5Gp18Z6v/oJF264gwZnSfGkNULooD3qIK2xwGtg3Nxw7Pvk4LskiDQufMAvzRr
	kSverF3QzNsG4zyRdj6y0J8dYAtG9BCIX0Bjfp7IiT+gKpjqHd+lOdfyGapeXp02WvnY=
X-Received: by 2002:a05:622a:1184:b0:4ed:afb4:5e30 with SMTP id d75a77b69052e-4ee5895624cmr113977321cf.11.1763984670228;
        Mon, 24 Nov 2025 03:44:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5zRrHv3TL6vmb65bd865WCJkq4dxhfstIXRKPXS0zKo1N9bb80wt9FchnhVQvMUL4gQ1Hdw==
X-Received: by 2002:a05:622a:1184:b0:4ed:afb4:5e30 with SMTP id d75a77b69052e-4ee5895624cmr113977091cf.11.1763984669815;
        Mon, 24 Nov 2025 03:44:29 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cbebsm1278306666b.29.2025.11.24.03.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:44:29 -0800 (PST)
Message-ID: <45329a9f-545b-4425-9667-26bceca67982@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 12:44:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: qrb2210: add dts for Arduino
 unoq
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, broonie@kernel.org
Cc: linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, m.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
 <20251120155825.121483-7-r.mereu.kernel@arduino.cc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251120155825.121483-7-r.mereu.kernel@arduino.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qsgF0xyF9rSfd8-I3D5bgA50aWuhSuP5
X-Proofpoint-ORIG-GUID: qsgF0xyF9rSfd8-I3D5bgA50aWuhSuP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEwMyBTYWx0ZWRfX4xE5vZb8ZTZH
 H2feBTnhfxYduulW4Nj9DTpkpt8NUAW8vbkYnlW+0s1EEUebOv+AujiTxXqWoNjTlapYkDdxhE/
 JYBt+nzUhvzATRhn0v0B8mwXuylhWXavuaJb+EBwLTp4lm9i6+1tWk4XGBoORi691539ng/4spp
 nbQvwVEFC2C7Xf6lnR4ZM+cGl7sVHCmjL4QNCGh5MoyLRPVMeu7LmIOgxE+KC8HZ4FU6aQ5+hT1
 qftItZg1w2Mb8S5fhPzU0bcWO19hYTqtHaX4Q43PHkdwvhewshQPj5ahenYGP+y2zGgR35ERp0N
 ywmh/64iHSfT0DTYElAh49bSVfp6UyZoi2q71YrPKNRQDpowhHvj37NckY5MosBAy7SKhKpxaCr
 XokXU5CtRjRRB0nMhoznUJLU0802oQ==
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=6924451f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bas-LT_GC8gd1oFTr-AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240103

On 11/20/25 4:58 PM, Riccardo Mereu wrote:
> From: Riccardo Mereu <r.mereu@arduino.cc>
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

> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +	vdd-1.8-xo-supply = <&pm4125_l13>;
> +	vdd-1.3-rfa-supply = <&pm4125_l10>;
> +	vdd-3.3-ch0-supply = <&pm4125_l22>;
> +	qcom,ath10k-calibration-variant = "ArduinoImola";
> +	firmware-name = "qcm2290";

I'm not sure about this line but otherwise this lgtm

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


