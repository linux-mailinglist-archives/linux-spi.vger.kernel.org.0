Return-Path: <linux-spi+bounces-6525-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811FA209E2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 12:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945BF3A8828
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 11:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82861A0B08;
	Tue, 28 Jan 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hG/u7FyW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5619F111
	for <linux-spi@vger.kernel.org>; Tue, 28 Jan 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064463; cv=none; b=afxVvCluGusGvklrdwaDnDAzkvLdMMEH/62nmpy0Htzeo4SnTT9zjM0Z+OkII5lSrmk292DBf9EietVM94nMAUVllkd9Q0UIlQ8wDn1NdpbyZSQQLvAw5Erm0n8NjQZxQBLvcXFXsDjeZLRZ2+MtzEL9mawge0WQz64w+GG3JC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064463; c=relaxed/simple;
	bh=0iFCwS6n5V7IzcqYwsDRIIklZJjISlLC21qyBkhEvZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mj1rhgKCfkx2z4sAblQfXvke7iHYwBDupfoT6mf7kmrHfxrILayNZIuaWYIfaI2fcd/ba+XQkS3iBvtoqaS91KJEdxim8AZLeg02z3bcRNst0lXJat7RlVLk9lyUaukvyJLwA6KnnXUCsSlOVBySCSduWnQalApLoOJjjmCL+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hG/u7FyW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S5qwmn029328
	for <linux-spi@vger.kernel.org>; Tue, 28 Jan 2025 11:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJQJVddmQT/TZOOgF6MQNyU12sRZZbRBhEd91lNoK9U=; b=hG/u7FyWx2CFBvlQ
	Ca6zkPK6sq448AYrrvx2jeph76JXeMWpRyJLJRJhwu96L2skyWMTbwQ0mBbz/ekE
	+i5hiSKTnoMxEudoNOQeYy88XvKy4BVnkbv/MhHF9dRh86SuOZ8VEBf7dcA317EO
	P45Nu5XIlkRN0kadwcKX0AWL79YB1l/GsESFU4+fwEphDQ2aK6B5js7kUMHlghid
	YbHdCZyhLhUq1oxb3dCGFkZGH2B+R6BGRZ/XocDirDU5qCiMIzrsii0gcWdLFxtS
	cgyGrSZ80fUH9a4IODU94Su6FO4GgXHLICGTteB4kSee5WQDMuiX0oyaoXUoGqqU
	HmCBag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44esfq0tsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 28 Jan 2025 11:40:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46e78a271d3so4743841cf.3
        for <linux-spi@vger.kernel.org>; Tue, 28 Jan 2025 03:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738064458; x=1738669258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJQJVddmQT/TZOOgF6MQNyU12sRZZbRBhEd91lNoK9U=;
        b=DvvUhez1O8P10YkBz6xLGL9T0kG69h93ZjqtiJzMPwGK4DV/InHIuyOuvoz2tmSKza
         IgFDWwKafWXl7UFK1X+hVu5PXXWyDZI2aRyPP+f/sQWu5mnWJzf9cThp/+yKb5IgI9OD
         pVv2DAzQyV/K5TAOpcCOvcVxF8k3NLF19aPzN2QgMMEBZTiyBHzD2c4++iIHvp7bFJ67
         guyOe8zAlvyuIQLeOvVL54pvkpGi0ubcDxY7s7KjFFbRJgDGe67zOtSd7oRyrQ/3Ifj3
         xkakmsbaKE8fX/9P3F7/cBHcJ801g+/UaOI4+1wvVmZ7OpinvZCJJxfnnMJMbh96si+k
         OsuA==
X-Forwarded-Encrypted: i=1; AJvYcCUJmpu25XctInBJmlJoa8Dhx7/bUjOXv8lVZsW/xqjKNOXs0pqeOsfPot+HbY9cuxQYw/5WMwXcdtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn3Y1dxvmxo1jMN22JPLoRz6IZOEL8uojLgwWZ0YznhqB+IhhW
	KZcgzzrZYuhPlw8p2SyQ8vDct9NmKI2xHhBkvsMI+0KgdVrM0lMArj11F+qNaDZakI1AgydzXrF
	d9nuShjvwMCv63kDjfCBOLYVHIqbP4p4vf4CuktRy/TIlB+t0m3VCvWr69Mo=
X-Gm-Gg: ASbGncuBU3zvU1HAB1fUBG2ybLgSw/sP0zNDfaV3vwsYyULcxo3mCGbCBA5P6SfnXzJ
	N2gtRg84dBX2nElnnl9sJNTtWaPKECAdiWE9fi5chhSpHlBUclDMnvUtjnS5qFGt4jQ/5sbjDJy
	2wS6N5XXrdGQFV0HJ+DrrP/v85EaNwLPYkI8VP6RRGUjY5E0VZHq4GK3ikZosi0/XjZ+GBgsk+g
	x9srDrAr34Y8VTFYVOiOZycJXi33gNh9S+PX4zC+vlcEvSAfPf3VEfIwbsOdd9aaaJjFx2r5Bn9
	OD23/hlsUm/LSbIFQPImK5iCXLB+oGdRpShW1C7mF4F/kF+PAZ5Wsad1Z2c=
X-Received: by 2002:a05:622a:453:b0:467:95c2:d8a3 with SMTP id d75a77b69052e-46e12a55c9cmr230730511cf.6.1738064458480;
        Tue, 28 Jan 2025 03:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR5VS1dWzO4khznGgpsO/jMCtdkvK6pJci/0akamEvgGIS4WWmuYIykOhh6oJd4q5RY4Go+Q==
X-Received: by 2002:a05:622a:453:b0:467:95c2:d8a3 with SMTP id d75a77b69052e-46e12a55c9cmr230730351cf.6.1738064458131;
        Tue, 28 Jan 2025 03:40:58 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6c4b0af38sm84689166b.149.2025.01.28.03.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 03:40:57 -0800 (PST)
Message-ID: <23a9b13c-0bb8-4145-8e1b-4624d13538c4@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 12:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: serial: Add support for selecting
 data transfer mode
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-5-quic_vdadhani@quicinc.com>
 <10060d39-87a4-4565-a2a6-80c93ac2266a@kernel.org>
 <dudqd2y42wy6iq2k73aphd5ol4mtq7z4c54zhd27rl745rrw5x@p3oummf2jke7>
 <374e16d6-46aa-4bdf-85e9-bc2e33c38057@kernel.org>
 <65a880ba-f721-4720-81f7-6891c335f7aa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <65a880ba-f721-4720-81f7-6891c335f7aa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Lb7RTdQuhbSObAUqO_x09v-BfXUcmqoC
X-Proofpoint-ORIG-GUID: Lb7RTdQuhbSObAUqO_x09v-BfXUcmqoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280090

On 27.01.2025 6:50 PM, Konrad Dybcio wrote:
> On 27.01.2025 5:24 PM, Krzysztof Kozlowski wrote:
>> On 27/01/2025 15:27, Dmitry Baryshkov wrote:
>>> On Mon, Jan 27, 2025 at 08:02:12AM +0100, Krzysztof Kozlowski wrote:
>>>> On 24/01/2025 11:53, Viken Dadhaniya wrote:
>>>>> Data transfer mode is fixed by TrustZone (TZ), which currently restricts
>>>>> developers from modifying the transfer mode from the APPS side.
>>>>>
>>>>> Document the 'qcom,xfer-mode' properties to select the data transfer mode,
>>>>> either GPI DMA (Generic Packet Interface) or non-GPI mode (PIO/CPU DMA).
>>>>>
>>>>> UART controller can operate in one of two modes based on the
>>>>> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
>>>>>
>>>>> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>>>>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>>>>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>>>>> ---
>>>>>
>>>>> v1 -> v2:
>>>>>
>>>>> - Drop 'qcom,load-firmware' property and add 'firmware-name' property in
>>>>>   qup common driver.
>>>>> - Update commit log.
>>>>>
>>>>> v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-4-quic_vdadhani@quicinc.com/
>>>>> ---
>>>>> ---
>>>>>  .../devicetree/bindings/serial/qcom,serial-geni-qcom.yaml | 8 ++++++++
>>>>>  1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
>>>>> index dd33794b3534..383773b32e47 100644
>>>>> --- a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
>>>>> +++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
>>>>> @@ -56,6 +56,13 @@ properties:
>>>>>    reg:
>>>>>      maxItems: 1
>>>>>  
>>>>> +  qcom,xfer-mode:
>>>>> +    description: Set the value to 1 for non-GPI (FIFO/CPU DMA) mode and 3 for GPI DMA mode.
>>>>> +      The default mode is FIFO.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [1, 3]
>>>>> +
>>>>> +
>>>>
>>>> Just one blank line, but anyway, this property should not be in three
>>>> places. Do you really expect that each of serial engines within one
>>>> GeniQUP will be configured differently by TZ?
>>>
>>> Yes, each SE is configured separately and it's quite frequent when
>>> different SEs have different DMA configuration.
>>
>> Well, I checked at sm8550 and sm8650 and each pair of SE - which shares
>> resources - has the same DMAs, so I would not call it frequent. Care to
>> bring an example where same serial engines have different DMAs and
>> different TZ? We do not talk about single QUP.
>>
>> Anyway, if you need property per node, this has to be shared schema.
> 
> I'd rather ask a different question.. Is there *any* reason to not use
> DMA for protocols that support it?

If not, we can simplify this to:

xfer_mode = protocol == PROTOCOL_UART ? XFER_FIFO : XFER_DMA

Konrad

