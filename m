Return-Path: <linux-spi+bounces-6826-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48629A35739
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 07:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056FD16E380
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9E820103A;
	Fri, 14 Feb 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpQ3el9J"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39217E
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515150; cv=none; b=UGBzgOg9qas/Erv/QroRLIdKqlX9YDqgWVkHPPoiUf3tpZazXAIpWdcwlTzSEd9udkO8pPIP0HkY/gPdySX+D1nSjhcfbJMttkMOifhtqiw5esNZBOzI3VQ3cBcyxtSIBulKAa5bs7UYa+bTgYMVnmny03j0cYcT4aWYZfh0myY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515150; c=relaxed/simple;
	bh=wM4tKt7wnAjL5plOI4BRiyB+09XoZe0tKNq0DJSi+xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UErYUsN5vojO/CBs0McrIgUg7bocwlADDczzoy3DFV4m25JJpbBNpWy966mVBtAYzvve7jEP+M6a9RSqlazsIDjlmLepFVBZmM6AntsJXoIPOXkI+SPKPGBGL3U4o1DHS/9RU1srYNwhuZNUrv9AQ1ndHPqGfE/Q4K7+nPXNIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YpQ3el9J; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so260088466b.1
        for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 22:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739515147; x=1740119947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0sU8UuAz6zX29kmBzzz54CB+mIZrBU5m5rlPw1QPe4=;
        b=YpQ3el9JyDtytDF1ggQ59bMI/wJQEtgyGxBm3ugSRebGJwOkMKScLcV/ZPTLNdfGKZ
         X4HhcHT3UXlhmo6XJUAiAz5tu5Jvnc754r781IrG7fQEHRkNJ+pf833Awa7TCZetbO1n
         WnWKWI6Q/OMDO+toSnncco1gCpHsfSwbAtCZra3BGDF/yS9c1gCPxmdON0fQ7aBIXjFZ
         eS6u4h8pTNHBp4qKoNWRrEsClILIytW9miaBkEyyhaRdcxBYZVl/RFSf06Ras5CYs8QR
         b4I1rOP7WvCA8uoI3dqm1j6LZUMI7mG86gwsoukeXcrqQcRTeL18ijBiwO6057QgcH85
         TzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515147; x=1740119947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0sU8UuAz6zX29kmBzzz54CB+mIZrBU5m5rlPw1QPe4=;
        b=BRMqRiVTiDKK3WQ8t2UCR1LFdkz9KLR5mrOQ/VP0SfGCA6B/O8ndoUtZyXNP5zyWvC
         jVUIxJ6514doAkcLIxKG9+oYmAI93DwHW8cQQpwXINKEVIHcnQMukB1YtL3UUMbrdD+A
         +/tW1dDk0ZzsfgVKr9070JWayHFwUaE2yEKOUJvtiP6fuoJ7JPhsnLDsdBrWGl+rLloG
         VA7YZ+GP75xrp9JbWf4YZnuDTsFpIkheIC/IeYPEj17eTExdV0a1UkzfQQWDWa4aGyKR
         ViKQwXrXMwHnMDWvO/KU0Orz/I4xexqZJrV1T3fu9JHsd03NmAUklqzeGU0+vHeN1FGk
         PflA==
X-Forwarded-Encrypted: i=1; AJvYcCUqJe5QR/ze3KQ0eFonRlSVLpoWl8ELngtBSZhlTXuBvufXfXlil/GHIB5HTqvGtH7TWz7COVXE7bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pHShEZwEChVafizz7d4Eh3vE8vCFeAI5z3EflQjGWh0/lbW0
	RgA5sHIMlXGsNywW4x8lIA3MxaIvuDSlbdpyfS3iRwllrwra8cS21f1iIcN0KKM=
X-Gm-Gg: ASbGncu6MhfMJgiW8UFEOh7R5pChtJYy+2tsGL7G+EPlrX3k3YT0y18IHVU7r9iWNsu
	Eo6judDMiTyV3gP07X5EoHBmpfSzskUSUWRRlJFuL1DOQuEpxDX2JXqx6O4AJ4O0p1EMfEE3B08
	UNxOK3SXtcqdMN/Mm6tSBRsCh3Zb3D7Vb0AhkvIc/SsvJIab6L/AaaLeqg7K/l3xTPhUHlF5B1K
	7ZJuxwNsNbYFvGU0Su4R3OzPLV73Yebig2Cmdr4vluL357EpdGJTB8Z1QDFQurZhruBw4h3w2WP
	DcOG2/a5yu8deYcyqhJNZBOF
X-Google-Smtp-Source: AGHT+IF1d6cYVnJi5xW59uL3+6NvNiwx8uIujRV1yuXHWDc54Fra2mr4R1Bhi8JKR7ZMNqzyULR9og==
X-Received: by 2002:a17:907:d26:b0:ab7:da56:af95 with SMTP id a640c23a62f3a-ab7f336e7b4mr907392566b.2.1739515146641;
        Thu, 13 Feb 2025 22:39:06 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231f36sm276066166b.33.2025.02.13.22.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:39:06 -0800 (PST)
Message-ID: <cf0a5ab5-265f-4429-8c11-8b669f00bc70@linaro.org>
Date: Fri, 14 Feb 2025 06:39:04 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: andi.shyti@kernel.org, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250213204044.660-1-wachiturroxd150@gmail.com>
 <20250213204044.660-3-wachiturroxd150@gmail.com>
 <CAPLW+4nJVf0raJ-O3u6uUteBi--N5xGwvzXp7cHqbkdMJ8gCSQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4nJVf0raJ-O3u6uUteBi--N5xGwvzXp7cHqbkdMJ8gCSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Sam,

On 2/14/25 12:08 AM, Sam Protsenko wrote:
> On Thu, Feb 13, 2025 at 2:41 PM Denzeel Oliva <wachiturroxd150@gmail.com> wrote:
>>
>> Exynos990 uses the same version of USI SPI (v2.1) as the GS101.
>> Removed fifo_lvl_mask and rx_lvl_offset, and changed to the new data
>> configuration port.
>>
>> The difference from other new port configuration data is that fifo_depth
>> is only specified in fifo-depth in DT.
>>
> 
> In the code below I can see this bit:
> 
>     /* If not specified in DT, defaults to 64 */
>     .fifo_depth     = 64,
> 
> Is that intentional or is it some leftover that was meant to be
> removed before the submission? From s3c64xx_spi_probe() it looks like
> the "fifo-depth" DT property is ignored if .fifo_depth is set in the
> port_config:

fifo-depth in port config is intended for IPs where all their instances
use the same FIFO depth. fifo-depth from DT is ignored because the
compatible knows better than what developers may in DT in this case, it
is intentional.

> 
>     if (sdd->port_conf->fifo_depth)
>         sdd->fifo_depth = sdd->port_conf->fifo_depth;
>     else if (of_property_read_u32(pdev->dev.of_node, "fifo-depth",
> &sdd->fifo_depth))
>         sdd->fifo_depth = FIFO_DEPTH(sdd);
> 
> Btw, wouldn't it be reasonable to flip this probe() code the other way

No, please. IPs that have instances with different FIFO depths shall
rely only on DT to specify their FIFO depths.

Cheers,
ta

