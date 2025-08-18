Return-Path: <linux-spi+bounces-9513-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFDB2ACC2
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24825E05E2
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7A2571DC;
	Mon, 18 Aug 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a4P+wIjo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153F024A063
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530792; cv=none; b=hy/3lR+3zGrVQRALTidX2g4HOAOgqibz7CKVnklf9p9CqldPvD499Jj4QQUHzZE7NnfucfotTORfbzGX5o8yKpbXW/h0TFrXc95M2rMSdeB1egAvzLA85lmkYwOIW0MR+TG7xTrWjJ3p0wDRm19vxSntm9LFgo7OdlEjFg/09Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530792; c=relaxed/simple;
	bh=9yWCsTnE4xplQu+fdzJDVznRu1TCK8n0PjiryUSeKjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wpk54P27Udw3pbHDw2ijpgLDT64AV56+EFthlV9ishlkQnki8DdSdN9TLLgMQ8tGxYscxMZaNqj8M2kdRUpgvK80ToJnCCF7dhuANvaoktyPWftAOmTERFZvfaCTfjnMjrOs0ucvqHm24dog27ctI5nOjmLX5vaiQR/LYYVZcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a4P+wIjo; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce923bc2so1969033fac.1
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755530789; x=1756135589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5PKKDWSujsQQD/ZWb/LSNZsX1wV9B1TZv7vRfE49q4=;
        b=a4P+wIjoljpwWqRpVBrnQjjp+/jyg8tMwfcTt4FizxiEqqHvMPo/yG7JetDbKWEJi/
         pNp5zNsX5O72NB8OA4O7GqNBcfV1v3BX/KhDHpbZl582P75x6rurVkrRoB3r6NaPUX52
         KRJXou+OjmkQ/AuatuR+USKoMMuj2NS78CLM4AqTK56WVllsKRw9oVhbSQ2wr6iH5Bll
         j+x/8ln3Fpdiw1USz/6/JqaUV52ux2si38+DjaZmPa2chzQ0vhhcDPxO+cWhV7HcAZyt
         J1R4UCZKU32gXk7FMlk6cJfsFdp+TEs+jGiMuFuREh+tBJRD5m88S+JKQdxOsTS50lJM
         jbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530789; x=1756135589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5PKKDWSujsQQD/ZWb/LSNZsX1wV9B1TZv7vRfE49q4=;
        b=cb5j/oZu9dU6aANdyASgGKq7SJzaWBCK0Aoxnplcj/NsYJumeVJDZKHtczcgbq7l2k
         83Bcmgj8TstTIwvruK/7WNSoPerJTbMNHGG4Qz55bki3chyLlvcSOwobnzaiBMYmpfY7
         af/oXMueT5BtJfgh1DXR68BND0jCBvTqL1n8h2cxHO/bcwKCXdspcYRm9Xk9SAHlpp91
         f0UIsMSRcDdUg0efH6qki2eSq9VgTfQktwm6HJBbMfx8cmVg2fuWhJ+PDewmNme+SAND
         /npq8JVL/T4O5HzjYU+PaApWAYi+cRoxzdykaGN3g6xqbznvKfftZL5wrVovqefaZBNU
         azlA==
X-Forwarded-Encrypted: i=1; AJvYcCVNpViiQWX73X861l+SrwuuLrOrylZiOxOEsgc719Jn0TkrVuAjfp5qC7C5uPUHkV5JXGUm1FjY9tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjsbV8vM0OmCU6oLmZEeugKIGuohsr64tK9UxOFyUMFhxrEYq
	qYnWerOw082ed9cLuC3o3+KmZ5o5WKyJEZ2DNRx8SLSss8Fr93ny9JJXPPYj+U45N0zCq8z68eI
	oINQP
X-Gm-Gg: ASbGncsq5O6vcR/rP4kFOwdTUplEtb5rUG/SfZbR/202zVjAY2vO5T1dUo55voBrCxe
	++RBOx7kDH+hD+hjW9qE7KhPCn0p2w+h/6MiaANTIUzDbS+O6gEP50ZIhLV/sMeMEf6sIlIDHd1
	MiTw9yLNNuOFueT9vkC/8YT9IHqqN3UayLdllHRE474Dvf154Ql/rOFWuMAe5185+BGQvAIPTjk
	yc4ElILLvLFftJ18TZjCZ2n9zptI+8zcpi8DcrZPowPr9bIvpZH0dOOvkk6hBDb0/ptfYEEfzMU
	4/w6paXs5C7hFACYQvKAXpRbu8HNqGNKCj+jfAsK9o2o2hKN+YFHCNIfVPe51XZhihfK+FPvW3P
	3YfSd2G8NCKv9ETD7eRtisSxRD38BWezY+J1b95zcbxz3iVyIKn/MgHnc7eLOVWHI5Kr8/8yycF
	U=
X-Google-Smtp-Source: AGHT+IFi/cSOB5tF/taIVc9lB6VMcKGQulO1RAaOqvo83CjeGYWHvjFUzL4pihQB+kHoyN+pQ++BZw==
X-Received: by 2002:a05:6871:7283:b0:30b:c9ed:7f91 with SMTP id 586e51a60fabf-310aaf7bd7bmr7722267fac.31.1755530788952;
        Mon, 18 Aug 2025 08:26:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310ab953af1sm2652680fac.16.2025.08.18.08.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:26:28 -0700 (PDT)
Message-ID: <95b6d60e-4709-403f-8127-c50d40c7d8c4@baylibre.com>
Date: Mon, 18 Aug 2025 10:26:27 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
 <0a3b69b8-e868-49c8-a0ca-c448ee3cd488@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0a3b69b8-e868-49c8-a0ca-c448ee3cd488@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 9:56 AM, Sean Anderson wrote:
> On 8/15/25 11:49, David Lechner wrote:
>> On 6/16/25 5:00 PM, Sean Anderson wrote:
>>> From: David Lechner <dlechner@baylibre.com>
>>>
>>> Add a spi-buses property to the spi-peripheral-props binding to allow
>>> specifying the SPI bus or buses that a peripheral is connected to in
>>> cases where the SPI controller has more than one physical SPI bus.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>> Changes in v2:
>>> - New
>>>
>>>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> index 8fc17e16efb2..cfdb55071a08 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> @@ -89,6 +89,16 @@ properties:
>>>      description:
>>>        Delay, in microseconds, after a write transfer.
>>>  
>>> +  spi-buses:
>>> +    description:
>>> +      Array of bus numbers that describes which SPI buses of the controller are
>>> +      connected to the peripheral. This only applies to peripherals connected
>>> +      to specialized SPI controllers that have multiple SPI buses on a single
>>> +      controller.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    minItems: 1
>>
>> Finally have some hardware to test this series with using 2 or 4 buses.
>> I found that we also need an absolute max here to make the bindings checker
>> happy. 8 seems sensible since I haven't seen more than that on a peripheral.
>> We can always increase it if we find hardware that requires more buses.
>>
>> 	maxItems: 8
> 
> What is the error you get without this?
> 
> --Sean
> 

I don't have the terminal output anymore, but it was something along the lines
that there were too many items in the array. Like it had an implicit maxItems: 1.

Overriding in a separate file didn't help as the checker seems to consider
each binding file separately. I.e. sometimes I saw the same error twice.

