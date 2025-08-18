Return-Path: <linux-spi+bounces-9497-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE40B2A3CC
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5557E563E1E
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BF31E0E6;
	Mon, 18 Aug 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txS1dG3I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0430F7F8
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522322; cv=none; b=teVM1NlMt5c0Vvd2t9XSMtPgaxNunLgGRVMGyel8/BBVhiZbRV7xlgZlXJKsW0w5AHOdAFHAIEOEZK+VjZwkG8XknwheDsVt+8qdLqMzAIiqmZYw3dAPyNYG03SFRf4MTsQXR3yfvekw030khBZ6B8ndXh3TWaYapUn7TreuVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522322; c=relaxed/simple;
	bh=RpAhxP2uLqbqjInuTE70JRXrQca1fdqD+vDq2S1ckfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iM5w+ZLFa9i9drgT+OXuBlfAC2hnHd7sxMMXzvHFLODKLU2SD1sXEzHnLNXms/1Obki3tCjsOzx76j3FaejlVwSTZTgUBfPe+WUSQFj19nu3bqXTQounu5oeJ/XrdQaXPFbUypkm6vsGxHft78qytnIi24cekNgSSYC4ETWjS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=txS1dG3I; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so3619790f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755522319; x=1756127119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86BJmrJXeETeW2kp8meE7Uq7AvyYwzMOqYpCJJXyfLs=;
        b=txS1dG3IyrSDBriMFeWWgHeQgrwquh8uAPpEcdMV0g79noALWuVRWDccj7GLJ7S74Y
         xkcSjVV0TP3EUphTRiqj2wd00Nv2vZtKKlt1+cDQk7vHlDVDZWqNg6CFHB5jtR2pYed4
         KYa/OM2BVxixE02a5tGd5K80r8nMYfogIWCMXiAMVqBbLFZxIJP4MTmZ/M/xq0ln6npN
         bJFKbOMdXwvy5iqAHXiX3HMH8XHxU0VRsE89AMD/mE/GT0+6VlT+0LoB7/CsNA3TtOoN
         0FmczBnNwrvZHas8ZQEyissCYVIzhwnGkBJyR0OlpcvH/LtbFw05tsOL04Z7JnJuRv7X
         6fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522319; x=1756127119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86BJmrJXeETeW2kp8meE7Uq7AvyYwzMOqYpCJJXyfLs=;
        b=OE0eYjzSsPDYC+Gg8bR5hxJZNG0A51gWD0HDxc6YWgVWvFVuWiAB3Coxc/5oeJPJs+
         JMAJr0S7/suCum6/om52JJaGdzZl1+WMCPtqLq629wwsvQLU8kXLF30CvBByWkEVnNeL
         vwHs2jD2iau6PbhBb6SgY77W/ZqmBmd5KMLFQ07WE6orC+Tcv0Qpvt77JBDGl5jFpn2D
         XPEE6r12CDt8r6zG3tR9xaTTqniljIQZAPvGhJbIS/UwFnJwUQpVpyar+FzrbtTIm3Ok
         2JBDd7GXFs0FAuTUWJv5J6eza2EYfhewvrmd9MogWAvbLai7KnBqWlLM5eJRRRBQ2bPy
         OG+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3E02hx8uhanwvk4b2tP0H2D+ag5JxQ65IZGgvZdRrXOL768dKJQ10RqOaiDein5Kxx59aRg77Xe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuO7GFaE4ZPEGU3AmmhkdLqektUUm2YieiczoQ+hmQ7DhaD7Vo
	MMcopCnpZMFiqi+u7kXqMJ4dEjN62usSWmwYhBut42cYfrFQoiJe7eKhj4Hrxg6dS0c=
X-Gm-Gg: ASbGncu3BCKrgbl4xWCn+FPs//P/5JfY1pKBanK2F23x3cv0rG4fxwG0/ezbO1ni8/u
	MalDvRJzj5+DUZ4UawbRmBJ0mPwlEls5JZnhFmhfd5T6VizWtwSVuEf5VNy3KHYKFTt4JlxrZBD
	SBK1PJ/0XuW19EpbaBRa9r+2FrRnxLQ8LEGzXEGblhRORu9ShascAYkMgYJ8kkErFYK5XWMyiY8
	NTariaxmumSd7OFNMw/5jtqELFwPIJLB79lI/6qEooHwHjW2lo94F3ajoMAC2fgx9nBWWSSrB3R
	G99qyMh7lSw+JMcpMOKW9yIv6UYjBhcZznyd0ltFKOX8fMK9b86XJGsn4g9oIEistSoiwUU1Cpf
	rcy65KwI1DdxfLg7cvq9ViWYqEjLD5gv7m9NB4g==
X-Google-Smtp-Source: AGHT+IHcwykrBK8tXrdhApeeaxgZhKOjTfFirzDPuKeFi7nfZYLL6OLNQGBRz5fJTm0ZvXzAmYWt9A==
X-Received: by 2002:a05:6000:1788:b0:3b8:d493:31ed with SMTP id ffacd0b85a97d-3bb690d3800mr10683315f8f.47.1755522318746;
        Mon, 18 Aug 2025 06:05:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758d1csm13236548f8f.8.2025.08.18.06.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:05:17 -0700 (PDT)
Message-ID: <90d40899-c9b8-4628-a0b5-06ee0aa497be@linaro.org>
Date: Mon, 18 Aug 2025 14:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select
 polarity bit
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
 <aJ4TkKdkIPiJhhF4@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4TkKdkIPiJhhF4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 5:49 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:42PM +0100, James Clark wrote:
>> From: Larisa Grigore <larisa.grigore@nxp.com>
>>
>> The driver currently supports multiple chip-selects, but only sets the
>> polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
>> the desired chip-select.
>>
>> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index d44a23f7d6c1..c65eb6d31ee7 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -70,7 +70,7 @@
>>   #define DER_TDDE	BIT(0)
>>   #define CFGR1_PCSCFG	BIT(27)
>>   #define CFGR1_PINCFG	(BIT(24)|BIT(25))
>> -#define CFGR1_PCSPOL	BIT(8)
>> +#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
>>   #define CFGR1_NOSTALL	BIT(3)
>>   #define CFGR1_HOST	BIT(0)
>>   #define FSR_TXCOUNT	(0xFF)
>> @@ -425,7 +425,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>>   	else
>>   		temp = CFGR1_PINCFG;
>>   	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
>> -		temp |= CFGR1_PCSPOL;
>> +		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
>> +				   BIT(fsl_lpspi->config.chip_select));
>> +
> 
> Feel like FILED_PREP(..., BIT()) is stranged.
> 
> I suggest #define CFGR1_PCSPOL(x) BIT((x) + 8)
> 
> Frank

It's using an existing macro that everyone knows though and I found 65 
instances of exactly this. It can be read as "set bit X and put it into 
the PCSPOL field without any further investigation.

If we make a new macro, first the reader will have to jump to it, then 
it still doesn't immediately explain what the "+ 8" part is. Using 
FIELD_PREP() also has the potential to use autogenerated field masks 
from a machine readable version of the reference manual. You can't 
statically check your macro to see if + 8 is correct or not, and it also 
doesn't catch overflow errors like FIELD_PREP() does.

There might be an argument to add a new global macro like 
FIELD_BIT(mask, bit). But it's not very flexible (can't set multiple 
bits) and you can already accomplish the same thing by adding BIT() to 
the existing one.

Thanks
James

> 
>>   	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
>>
>>   	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
>>
>> --
>> 2.34.1
>>


