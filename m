Return-Path: <linux-spi+bounces-10096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADDB82B21
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C58E1C2111F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FC23D7E9;
	Thu, 18 Sep 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="T5TydTDM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1022D7A1
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164381; cv=none; b=LW1gvtbJLtzMn230pqz//WKxjojBABnPg7YTUKKq9TvHJGU/7sR3eNzmuNi2LUd/lX2iqcU9fJII+D+TbJLdAL7SlWfxHSvboMjxjHEN1D4Vt5duji64z8v/fb93FHUqqmGWRLYrxaEgmXhItKPU1FExFpu1CtkwooASLcIoKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164381; c=relaxed/simple;
	bh=hWH39yoGDCQ7N2R4TtE9DDb6608lJvIpDKnTkeelSlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAgx2og119/tnp6odnua3yUAgbAdfTGy4Tom8dsQ+4+x54hpo2jedurdnATk6JvaNm1eQlNBqLRvAH9NagdGQNTFPmgsk2g7EQk9O9ltVJ0W3AQW8O+CWrfPevUZztlra7dsSzH4S48ayz8YUp/7yUrMereiPdyAtjhrszzUJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=T5TydTDM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-89336854730so21720439f.1
        for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758164377; x=1758769177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5szgNDrrDfA9r/y/UulQg5Y7n0+PRvqIyjOb+dac47k=;
        b=T5TydTDMrhsOPSG/u+vKp+cSnK6vxqI3uUVQ3kg6kKSxl9PQK4MbdCWaC0eCexID2N
         Bvh3pkhIlo1/QQASAAweajfelnt3AbtAFlb81TSuzn/yRkvIk+1kw+VuPwPDqMyWl0SX
         GbvPJtfkK5BDX8Kxw9OqgJpDv7XP6x1d3eOkTx0B+wEQPLmqIu+dkG2KPJudCL3R63x6
         T+T72qMn7J5N+kvTa30d0tMKcWOXYjq/7pIIKo3sTTvVWj9cZRPF8hvTTjd/Jkj14wmv
         dKNcFfpocLqBuJyC/AhJ5XdNiLNFQN2rk8tuky0AUXu35x8OL0GTe/B5gVd5zeERffW9
         jkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758164377; x=1758769177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5szgNDrrDfA9r/y/UulQg5Y7n0+PRvqIyjOb+dac47k=;
        b=c7izh/O+QmH+rdAJYFxYn6gKmjOwNTDza2bDbAfx3F8aHLWRXJHmC9jqAs/RR/jMgZ
         mMR8TL0wH/crxNHLHoJeIsSGZLpV6RO2jy2NO9li9u4kiJ4NkG+iex6I1Qj0UDsEjHyd
         xZM8LLRdb3S7fM9KNtpQVdfTa5+YIbFMYWFvFHR63agbLdBsmT8EgXXjUFCBFX8IK5+e
         GqSsq4gnNmLUK6nM0CxzE7vqgdFagt+ZeBd9qgSVl6ynvib4JjqCIaAytNZ/3W5gWKMD
         B1JrLRUJZIHZivd7v0MerE0DhqEEfZuLLV/LczYsCV0oobb4R7AQZwHARehULuCFdXpD
         MRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmVy3tr/tGEFWLpXDSI2+aJqZfAenodpduUZkfnKIPgcovlV+ktfkvTr4sWGgc3Sqgr+o/r8fq+To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5a6S7fxqMWKMwv3ehkHLY4ZzJIvNIJXZ5UkxRxv2sfNkwOJK
	9OKDCqNCkKBnV4U2drEFdxTpwH+CHtn45Oa1/Fv3Fh65LyTRT/oSIxmgFPM3HaBljrg=
X-Gm-Gg: ASbGnct9gQGMaiUq3vIKmqYKa0ttdfcDuIgloBKOfXxR+0axnkRZBt9A/CAW0PBnizq
	cg5P3hfWHNOTM+l5J8KBBmxWPxH9V40OBVEbFSOieN4wHW77Q4KtBQvTCaDKs5qlEdLWAvlZvZy
	hc6gxU9c9/1u+Q7J73XEFF64E3SUei13QUKYFs1CV1nN3nk9RfTr2W9UnhPEFYVLtF/LsKrLFB5
	l0hkIBZvH45LDruP7yH4giVeV6McrkldPuX65eNMkFIpsOsZSpcLTMRqaqok7g5lVZiB3oGi1eV
	1Q/TLCYCKvQK3HOhqv9KVETiRmZUxndDUa09vYGi7P2AekemcqhRwVp08YLaL6/jRNd4TX0x9Yg
	R02p9NyBIsvnV4QkesfawVchXgOD0bepxHqiRFLlouQW5Ajrg1qA5egffMpjaEBuoOF11WPtnqW
	/mMy2V
X-Google-Smtp-Source: AGHT+IEQLSK+9pHMwlUU8ixZlncSUSA8tIOFByfMAjDBZy5wDSD6GkAsXBMax/RAtzqwjY2ctqPlRA==
X-Received: by 2002:a05:6e02:380e:b0:423:fdc4:4e39 with SMTP id e9e14a558f8ab-4241a5784damr64016625ab.27.1758164377462;
        Wed, 17 Sep 2025 19:59:37 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3b017664sm448915173.17.2025.09.17.19.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 19:59:36 -0700 (PDT)
Message-ID: <f7e12797-ea17-4e92-bd25-cc562c66d2a7@riscstar.com>
Date: Wed, 17 Sep 2025 21:59:35 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
 <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
 <20250918001632-GYA1270371@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918001632-GYA1270371@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 7:16 PM, Yixun Lan wrote:
> Hi Alex,
> 
> On 18:40 Wed 17 Sep     , Alex Elder wrote:
>> On 9/17/25 6:15 PM, Yixun Lan wrote:
>>> Hi Alex,
>>>
>>> On 17:07 Wed 17 Sep     , Alex Elder wrote:
>>>> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
>>>>
>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>> ---
>>>>    .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
>>>>    1 file changed, 94 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>>>> new file mode 100644
>>>> index 0000000000000..5abd4fe268da9
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> ..
>>>> +
>>>> +  spacemit,k1-ssp-id:
>>>> +    description: SPI controller number
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> could you explain a little bit why this vendor specific property should
>>> be introduced? I took a look at the code, and didn't get the reason
>>> behind.. or what's the problem of simply using "pdev->id"?
>>
>> This property was carried over from the vendor code.  It is
> inherit from vendor code isn't a valid reason
> 
>> optional, and if it isn't specified, the platform device ID (-1)
>> will be used.  It's just intended to provide a well-defined ID
>> for a particular SPI controller.
>>
> while looking at the code, it seems you can use alias to map specific id
> to the spi controller, it even can do non-linear map, something like
> 	spi0 = &spi3;
I've never used this before, but yes, it looks like it's exactly
what I want.  I'll just get rid of the "spacemit,k1-ssp-id" DT
property entirely.  Easy.

> plese check of_alias_get_id()
> 
> note, I haven't actually verified on board, just look through the code
> 
>>> we should really be careful to introduce vendor specific property..
>>
>> If there were a standard way of doing this I'd love to use it.

Looks like you have told me the standard way of doing this.

Thank you.

					-Alex

>>
>> And if it isn't necessary, please just explain to me why.  I
>> have no problem removing it.
>>
> on the opposite, please have explicit good reason to introduce vendor
> speifici property, and if there is generic way, then we shouldn't do it
> 


