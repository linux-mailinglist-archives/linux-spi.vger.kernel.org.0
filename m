Return-Path: <linux-spi+bounces-8030-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4788AB1230
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73EB3B0E4C
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236D228F942;
	Fri,  9 May 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sr3WYoKc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B328ECC8
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789987; cv=none; b=MGi9phf1W6nYPi5URm49Qi4Ko4RKTkDTLj+TvF9b5oWmhU/C/RepFC44alUh7Eq4ACffWEZhxiH3+t9LQbCaXeXcR2woQsUDvBGVxGiQvND+uD3cZv4vR90keOewxcJEO/2Buh+Q9anb0h++H35wrm8qb78KIbNjUj89g1p0WLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789987; c=relaxed/simple;
	bh=MHHca0equBuNB6LxXbIoeLvc+sprxjrgB/yI56MtObA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEOWLiYGStfG6bBiQ+FPhb+o5aTe4INnuomW4gN7OwwmG1pjerJVCe/kxHg4SUJibLW0IAhSs6Q6v6Nc0iAfDIc+8xrn2NHs5To9HR0tWYSwTB1Jlo4SqZczNbo+nP2yVgKBobCpQaPYQ54iwBN5Enlea35VxvgvnxOgnVBFW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sr3WYoKc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a064a3e143so1110391f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746789983; x=1747394783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lz2WGV5DsARe2ef6xf9hB2gw824v2BlYjF+3OFaRa+Y=;
        b=Sr3WYoKcehU0lLwLrOtxRAuHIEAqg24DGVpv9de9EsmP3orYOKGLENqSYn+hsSjCZM
         JEbbuTuNoU+QqhzzkJQD0m7DERk7Fz2/6WnyJyf0/Uia1X+WsABSk6QbSdTKHxmuzWZK
         gQZrKYCFfk4DH/aLcvQxJddji9hD4xHs2XOH33SxVJFXUHRgN95E6kCnh77e4n4yJ9rj
         BZwLm0ws032l3wxmNoJu4aAdlKG0xUkolYFTZRZpO+3CKTPbsKy96Zqa0Z4uCODfWqF9
         RdqZPifpgiC02HzPAt8z6l21aw7bAi68QdRyPcfpf6cUzWLEomewtkRXoUZF1kJ0pIfd
         jvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789983; x=1747394783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz2WGV5DsARe2ef6xf9hB2gw824v2BlYjF+3OFaRa+Y=;
        b=Rh/ICoao2KKkq+Kru00c75UsecpCk5IgNMthci9PvjXkjeXF1bkxwdWunYxatVlypO
         vbSHBy+PuvPwDM7HAJQ57tIRbsy3E1WfxmCZpqRMs2JfQIn/Y7A3AFuXEgfd+rvz69PL
         tMCS7RP66V3LkD61VcVriO2ZIZDdruc+z+y69LbtK/ZJoQachejJaJhkIPXUF6cIpedo
         t2YbZIJLnzAK88hZ1rlRobw5qkJ5HmDW2l155QvmE5L/35GadgxlYdUzbYQFweqUUrcR
         imlWRJo/s4hIPgGagRvZEsS1woWCLafi0xpuq4uFEHzj6CYDiCrv+cdPsaVc4nmjfXTu
         wb/A==
X-Gm-Message-State: AOJu0YziQwGc95GHs2GyiXZQF6ZliYyv5szlEgjb0N3GPkhqybZpQD6t
	/L2MyFvqjrvadrH0biVznGMfsVSWbYvMLQKpBS7TSPZB7QmSbu7TvXJBiH1B8QA=
X-Gm-Gg: ASbGncvpro2nkm9vADLVUBDZMRXU88fLIc4ehOdRoyMO4Lcfx08sO0J9PO2oEVfcrZV
	KNpOmdUH9yAPY7PMZJfp0LJ9wLTUxUR+l7j5ryd176VLSHkL99DrTNys1rngVDIw3A/fagt4Hvg
	QsMpEEtl7ILlEeIRXPQr1PHW5Mus+gYZcAfXqOlfj0tgQdlBwbv7+FZaOUt6f8gCifqcwEtkCYw
	tQoKuJT1Ar0NQU0Js4OyohAzC4RFA6YSSS/M4WUkgf592SgxqRHSHFjXedhVL/secOkBdqZK6SI
	wur1NSGkunLlK/PTXuoE3hGKExfE+xZPmrHa0A5iyOM=
X-Google-Smtp-Source: AGHT+IF1DqZRXwnqEDJC6RoEDZ05/IxWbN0y1MNMAHjLg08+G1rqNk/P8xMlNeorPMh/z66y3/jqUw==
X-Received: by 2002:a5d:4fc7:0:b0:39c:1257:dbaa with SMTP id ffacd0b85a97d-3a1f64b5a66mr2078868f8f.58.1746789982795;
        Fri, 09 May 2025 04:26:22 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c7a5sm2992122f8f.98.2025.05.09.04.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 04:26:22 -0700 (PDT)
Message-ID: <4dbe2a87-2c03-4565-a486-41d4116892ae@linaro.org>
Date: Fri, 9 May 2025 12:26:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] dt-bindings: spi: dspi: Add S32G support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org,
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-12-32bfcd2fea11@linaro.org>
 <af92e978-e6f1-43db-8a84-334e7dd0d43d@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <af92e978-e6f1-43db-8a84-334e7dd0d43d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/05/2025 12:14 pm, Krzysztof Kozlowski wrote:
> On 09/05/2025 13:05, James Clark wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
>>
>> Document S32G compatible strings. 's32g2' and 's32g3' use the same
>> driver so 's32g2' must follow 's32g3'.
>>
>> The SPI controller node in dts can define both host and target pinctrl.
>> The selection between them will be done based on pinctrl-names. The
>> default pinctrl will be loaded first and will be used by the host. If
>> the controller is configured as target (spi-slave property is added in
>> the dts node), the driver will look for the "slave" pinctrl and apply it
>> if found.
> 
> 
> I do not see any changes in the binding related to above paragraph, so I
> do not understand why are you explaining driver?
> 

Yes it's probably a bit verbose, it's just a standard SPI binding that 
also supports target mode. I can reduce it.

I'm also not even sure the "slave" pinctrl part is correct as I was 
testing it in target mode without any special naming. I will double 
check that too.

>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/spi/fsl,dspi.yaml | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
>> index 7ca8fceda717..b5fac0bb142a 100644
>> --- a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
>> @@ -23,6 +23,7 @@ properties:
>>             - fsl,ls2080a-dspi
>>             - fsl,ls2085a-dspi
>>             - fsl,lx2160a-dspi
>> +          - nxp,s32g2-dspi
>>         - items:
>>             - enum:
>>                 - fsl,ls1012a-dspi
>> @@ -37,6 +38,9 @@ properties:
>>         - items:
>>             - const: fsl,lx2160a-dspi
>>             - const: fsl,ls2085a-dspi
>> +      - items:
>> +          - const: nxp,s32g3-dspi
>> +          - const: nxp,s32g2-dspi
>>   
>>     reg:
>>       maxItems: 1
>> @@ -114,3 +118,17 @@ examples:
>>                   spi-cs-hold-delay-ns = <50>;
>>           };
>>       };
>> +  # S32G3 in target mode
>> +  - |
>> +    spi0: spi@401d4000 {
> 
> Drop unused label.
> 

Will do.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

Thanks for the review.

James


