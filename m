Return-Path: <linux-spi+bounces-1268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5790850D81
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 07:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CAD1C21E9E
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60833149E12;
	Mon, 12 Feb 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2CKwP9p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB126FBE
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707718643; cv=none; b=EvVetKSwqcCwiPX8JpWDgqVyb8s3W3p+dPvBYO+XAyzpyrjyiPzWFtjgDx4uqaDZb9zPdaLjqibr9uCxjFHxuERIP6wjAJmbVyOoXnuTGFwjJBXj3iZJvU9+IDV0d6WXnpU8uDaqsONE6hL1RrMNXGk7kBL6kDsOWMkTiwqkKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707718643; c=relaxed/simple;
	bh=wC4Rk/S2bZqAswL5Eum62/awDJqfLo6FVUpkq2UC/Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEtZAWGcm/rcnIplTHEpc2PB/UoNNbCmo9zTbZbK05y46uQn4bU2b0iaJT21EUCwv6Gfm1eFWuyQvIT8YjheMjNgVMJGO0yYkOknfkIlpXGK2Rcqn4D+8/im29Shvfc19hpgQhCodgjZKeGZ6gCxysXrtEym6x7raM8RXIjRRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O2CKwP9p; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-410ee8ed663so580645e9.3
        for <linux-spi@vger.kernel.org>; Sun, 11 Feb 2024 22:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707718639; x=1708323439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+WNd/f9UKS2JvJprk002/RUuWpEUM6bLJ0kQf3agDo=;
        b=O2CKwP9pRrYeyjeIlG3uGQrQqmNUaKhMJtePHr/jX2qaOSNJFlnhvC1Pf+HkURNBxB
         Q/14nVF2Wk6T3mXx/PwUNfLwaXD1MwvdUXrNNwszaT606GzWRjn/V4yByHB+lI9mPdFn
         dMHNtraDGYqVeRx1/E/rI1+XUB0syRIJxOHd6JnhvjRGgrajUzB4UiukUKouFS7QPy8O
         GfgaYdqUhvQ7yCFfEAoE3UW2v8bPdSduDxxjn0/l2H4ds/WpjqODaXL/uaBl0Npejhkw
         cR7g8aB4CLKTipnuEHrkV6lx1kluXcoUL0QA2DJcSwMEq/jVmUHK4gyEOmrLZxLJsKWL
         grLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707718639; x=1708323439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+WNd/f9UKS2JvJprk002/RUuWpEUM6bLJ0kQf3agDo=;
        b=pjKy7bhCMC043Gw5Lp1jo4b+WEn2tnpj8C6TD6wiXBVp4+nBpC+Q0n6l7O1x1pqF5h
         W9tu8ebxFmbdLxg4R4KfB1hZd96/qmGSJe+qW4Cq4q02Klqqg84Ex5L6rFg1sBBNR2wR
         4x1vJPJozAehwxq2rCpX6pJ1B91arv+S/av9wDbze38/s0pltXrOxH9MrLHudb15uPBy
         oaXf7eaeYB90RaBBiQQ5qgJnY6q68GsUQtiO5SaTU3jqiA4AMzqHC72kD4aStCs80wpP
         zTEV1/KKm20WevB0J0p8gZD2DGkIrkSipi9cssBEt2hAkxCBR7qfftYPIC1oRmRD7+/r
         f6xw==
X-Forwarded-Encrypted: i=1; AJvYcCVo0IwaHYrT/4i/H2ma4mAM6ZyARC/OyI45U4OrSio4uQdX8IMsM+NGQPLxHYeMpiin53lK9gf5ITXBVlehwMw7CE1a4SEmtD7I
X-Gm-Message-State: AOJu0YzbOhpna7hTxAEiXDIu7mo6clPoG2+GZj7t7dk7MiPSgUDO/acn
	sfBkieNOgpIg2xlpX33wXqsRGyQUBXvexzJxWGQNxWraAKQTs7wlUIvTcwQeolQ=
X-Google-Smtp-Source: AGHT+IENgctBzjxpmoVSMXEFhr5XLSDpWz9NezLUaPU2O7kQn9asFgyTyqv7IH7E5ZTn1yurJe5d9g==
X-Received: by 2002:a05:600c:3150:b0:410:e95c:9490 with SMTP id h16-20020a05600c315000b00410e95c9490mr411370wmo.0.1707718638843;
        Sun, 11 Feb 2024 22:17:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRD2NhVgORBiVkh5cz8qgqWl0sLqW/Lw2609YICdpQgMjYF3eEnbQZ2lsvH57C6ODcuBuozJhSd23gGxcFkHxDT7Gb8GlptwjteD9BJx/xtjYhERaLGJp9MIqS6PK9G+KcTBihhEc1DJeMsNPzjazS6rVn4VWC7zKcY3FYZ4knrHFbzMFjjfSRg9WDkX4lh7fEOEgVNpeW8fORd9eighunRiWFp+VGs+IZLIr97cmN6fiG0fFBtGkIAk8ZNyAMsdAmT0vTfbRikgISDCLneRLtB2uBCf0zdSihZSEeyqdFHE6LvpAPgiTCUxTTQAGijxa0cmRH+aNTl9AlkAWJ7ZHGRHdVj0evj9MkiVrFBeYgFKOTQ2FepEjnOn1bVZiw1CwGtwRrsPbAxe8WrNLbjiy73SnJjNg2+q1pmbKUO/8W2wwhb5b0pq8rQ9nqSMEpluQiMYw7x88cndzD4mZ4d3fbkvZLB175MM1eKgZ5Yi07d84f8BZHBGyZE7D7iJacwuKcetj3JH7e+dxlAUvGe3rc123ofOArNkUpmb5Z7RkqNGVjqz9Gq5zWXzMo9QHMjV7jS0z3nBuTJR6L0xN4xZPud1hwIjTDSDpq+rsRo+D27+NsthLX6OGI/lDF4gRzDq179lOcfA1FBlyA3mkfiWguou+HpmifkUKH2SEcee62TgDniL81DvY8eAZlboki
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b0040fe0bb761dsm7515815wme.16.2024.02.11.22.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 22:17:17 -0800 (PST)
Message-ID: <828d9947-ee96-4c2f-b856-0fac3640c863@linaro.org>
Date: Mon, 12 Feb 2024 06:17:14 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth``
 property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 arnd@arndb.de, Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org>
 <CAMuHMdU_Hx9PLmHf2Xm1KKTy_OF-TeCv7SzmA5CZWz+PLkbAGA@mail.gmail.com>
 <be84e32e-e11d-47fe-ad56-da8b0dec5007@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <be84e32e-e11d-47fe-ad56-da8b0dec5007@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Hi, Geert, Krzysztof,

On 2/11/24 13:49, Krzysztof Kozlowski wrote:> On 09/02/2024 18:13, Geert
Uytterhoeven wrote:
>> Hi Tudor,
>>
>> On Thu, Feb 8, 2024 at 2:51 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>> There are instances of the same IP that are configured by the integrator
>>> with different FIFO depths. Introduce the fifo-depth property to allow
>>> such nodes to specify their FIFO depth.
>>>
>>> We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
>>> introduce a single property.
>>
>> Ha...
>>
>> Current documentation for the Clock-Synchronized Serial Interface with
>> FIFO (MSIOF) on e.g. R-Car Gen2 and later states:
>>
>>     FIFO capacity: 32 bits × 64 stages for transmission and 32 bits ×
>> 256 stages for reception
>>
>> Initially (many years ago), there was some doubt about the validity
>> of these values (older variants on SH supported 64/64), hence
>> drivers/spi/spi-sh-msiof.c still has
>>
>>     .tx_fifo_size = 64,
>>     .rx_fifo_size = 64,
>>
>> Probably we should test and revisit this...
>>
>>> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
>>> @@ -69,6 +69,11 @@ properties:
>>>           Should be generally avoided and be replaced by
>>>           spi-cs-high + ACTIVE_HIGH.
>>>
>>> +  fifo-depth:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Size of the data FIFO in bytes.
>>
>> I think it is prudent to consider the asymmetric case, too.
>> Whether that should be just two properties ("rx-fifo-depth" and
>> "tx-fifo-depth"), or also a third "fifo-depth", I defer to the DT
>> maintainers...

Thanks, Geert for the insight!
> 
> Since most of the cases FIFO depth tx=rx, we could go with three
> properties and:
> 
> allOf:
>  - not:
>      required:
>        - fifo-depth
>        - tx-fifo-depth
>  - not:
>      required:
>        - fifo-depth
>        - rx-fifo-depth
> 
> and probably dependencies between rx and tx (see example-schema).
> 
Great. Thanks, Krzysztof! I'll give it a try.
Cheers,
ta

