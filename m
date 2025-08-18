Return-Path: <linux-spi+bounces-9504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C6B2AB49
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862985A2CFA
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78533EAE0;
	Mon, 18 Aug 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwX8zWfI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9E340DB2
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526951; cv=none; b=g+ue+8y9hNvkKlZHE585/ChoSQmmE22yjDyroDfu8GfGWgDQBbO8kWI3RuPfPn/FWmeIQigoy3yMD/xtjlRASaCQdXGjnYgJ341OUKIqpSAobvLvb7lCkVXP266BbuJD0TSgLQ+Wr76iTefcJ6kPZkL0QxcszErkGi8jyRb2XB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526951; c=relaxed/simple;
	bh=Ld4BTbysJvvmlTmsob/shBMtAaRTdrmxmv8v8XzejBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDzCGZG6bkHRnK6Cx2UIB4o4a0P6dNjeLO0A5hHA7oiZEUlR8YWbv2RtlwraoDJTJBfGF3/HFltRdqLLqPvQec4+/KrMs+sGiPQhLc0n2ikAADCYaoZsO5AKgtml9xhYeGRJBBw/OZLt1jbeh3qq+0WcG7Z/4BaH9qwthnkgUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwX8zWfI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e414252dso1990960f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755526948; x=1756131748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFT7EYdl/U8S17HmCa7RikHeUwhOUF2kdHWiG5vKuDQ=;
        b=UwX8zWfI9Y9O0JWLzyJIfhLp4KSd5m0AY7K6K3LctpX/JPE0C6s7xd3Cwfv7cTYF7b
         y97C3ez/IjG1UIuMHk9urbb8Piojo3BxIBJ1HXzzrZdwHoWY8woeQVeOOSor2tnXtMr4
         P0HJwk1hfqz7ZEE8zOa3Budbp94NwevxazEmQfpQTyeFS+5tQzsAKCi8jn1hJ5sACE5Q
         3o3CrwC5IfnPSuoz1H2EzhELR+nLlBCVLnIRw2xJqRO+jmfIAzp3OgIzrwzpkL1L3AAx
         JZFlZnfR1Gc720z7Iyg+XnBevYFp/wSEZ2Zi9+uKeBW9r7qTnnAM2PD9FuakbW6U9q+I
         dR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526948; x=1756131748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFT7EYdl/U8S17HmCa7RikHeUwhOUF2kdHWiG5vKuDQ=;
        b=WOs4Ivfbznl54E2W4yOWC9XgjRbwy5kL1c8e4Z0X8myUwUvZ8gDU1Vf8Z0E5HvbF4Q
         N+d2O9FPbqwMbLwfaeP+Cx9Pra02xD+aPgbG1IVao/jPvyi1/BGlAhv1JHiZnPaY6d7Y
         Vkjgp31k9YvNIKdhWF2clfNbcx3lR6xJkMzLV8/wGh5YEJ7F4yCpkSsX5uUWbxOBxAbv
         O716Vb2063kyhpoz7xmPr6YqxJ/1c/VZRThPs8ABut6TELHotTvFhb0wPMejkjkdFuH+
         i6DvzKbFVUx5n/K6vmkZJBbGXlvSK2bnJQfbiwAjW22NiEuiFSvIutDFck8dbA+e4VyS
         ygwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEuwtDMjUwolK3oCG4sMzAIhF8XbcGol5hCHxqofPjUEmvqE6sMZ5JzdxIMigYSSAq1WyD62mXWkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0N+IJZ063F606ZipbE7wmKMciwSLZlfKe/pqM6YXpyEjJGT3f
	m8EAiWxj3IbLdNUIpAE4E5joncc0j5abik9jZr5fjbMKrLLKym7s5aomfYRV/K7hPYI=
X-Gm-Gg: ASbGncvIdAeaaxIiJkCVOYzHzxZ/N6Ea6Yyt/CKjW14tlIjGAkIVCKC8gFuxuKUURG2
	ysUNbudO31Kx9zbRmkPTUjP8CdH7A22iiN4pocwzkO5UuAfM4PdKYfeFxdPIk3fqr92pAviqOEo
	zvPsRBKj+bWjSskEBY/MOUHOyyhWC6IJuEo2ushoKCuWUvdmaJqc9p9RuZLcV2IvWoirPxhdtbK
	jPP1Rd9+QYo6JRXmUuWvpPfqobIKN0anGRK1K3YmvrSaR9cm9ZKVAbpFeIS20mWITjfQWNwmjXx
	aBJ2v+TbYKE0LBmG2yADY+AvieJ5oatv4kRj1Nzp5Mb7k5iTxhomoBeTkCn9rIqm5nV40FLH+6t
	kbbM19oYmlXZxGdptisOY5OVOf0s=
X-Google-Smtp-Source: AGHT+IHXXBqcG5WtLIRqk/YWgEdHVWCYOOUWvQEUiJZ9gf9C/DO/NkLfo+uNFk8MgEI2qKitz8FZdg==
X-Received: by 2002:a05:6000:2c09:b0:3b7:882c:790 with SMTP id ffacd0b85a97d-3bb68a1644bmr9651163f8f.37.1755526947830;
        Mon, 18 Aug 2025 07:22:27 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm106540185e9.1.2025.08.18.07.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:22:27 -0700 (PDT)
Message-ID: <14fd2e7a-0fe6-4f00-b826-7f3971dd09ae@linaro.org>
Date: Mon, 18 Aug 2025 15:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] spi: spi-fsl-lpspi: Parameterize reading num-cs
 from hardware
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-9-9586d7815d14@linaro.org>
 <aJ4rmLgTm+A2hDA0@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4rmLgTm+A2hDA0@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:31 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:49PM +0100, James Clark wrote:
>> To avoid adding more string matching here for every new device, move
>> this property into devtype data.
> 
> Add query_hw_for_num_cs in devtype to avoid directly check compatible
> "fsl,imx93-spi".
> 
> No functionaltiy change.
> 
> Frank

Ack

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index 1013d5c994e9..6d0138b27785 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -97,6 +97,7 @@ static const char * const pincfgs[] = {
>>
>>   struct fsl_lpspi_devtype_data {
>>   	bool prescale_err : 1;
>> +	bool query_hw_for_num_cs : 1;
>>   };
>>
>>   struct lpspi_config {
>> @@ -150,10 +151,12 @@ struct fsl_lpspi_data {
>>    */
>>   static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>>   	.prescale_err = true,
>> +	.query_hw_for_num_cs = true,
>>   };
>>
>>   static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>>   	.prescale_err = false,
>> +	.query_hw_for_num_cs = false,
>>   };
>>
>>   static const struct of_device_id fsl_lpspi_dt_ids[] = {
>> @@ -960,7 +963,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>>   	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
>>   	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
>>   				 &num_cs)) {
>> -		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
>> +		if (devtype_data->query_hw_for_num_cs)
>>   			num_cs = ((temp >> 16) & 0xf);
>>   		else
>>   			num_cs = 1;
>>
>> --
>> 2.34.1
>>


