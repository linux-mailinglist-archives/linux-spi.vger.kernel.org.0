Return-Path: <linux-spi+bounces-2139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF38939CD
	for <lists+linux-spi@lfdr.de>; Mon,  1 Apr 2024 11:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0548AB21B75
	for <lists+linux-spi@lfdr.de>; Mon,  1 Apr 2024 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0088610A12;
	Mon,  1 Apr 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmarJCKa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F5101C5
	for <linux-spi@vger.kernel.org>; Mon,  1 Apr 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965208; cv=none; b=Hj+LSATh30fb31svNtOXGaT+JzHvXsFLAd5eGQEX4DUznzMDaTaMOZ+SvE/1E0LeK62yV6wS7xAcK3vYGrHVlvDU34QTHxIJfkBD0dvOSk9lbV+0DxaMOP1Aff19I5cltttwsUjn+/vd5dO1wd5cxI3nt4O/X5aOtWejdUDZgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965208; c=relaxed/simple;
	bh=wSeSHSkxSv9BKdY7p7/IgD++XClDcXUT1bBvWMVGO38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRFZ53ZF/KJEkz6zP1uHuTScYjSyZbjmT+28qZJb5NXWb7JEvA8a5xK2n9P0LHYUYc3Okc6iK0PJV7oninopY+rasIam/6Qe7Go8mxXuuW6le8aG4BFFpi5GutGjJBcRHLlBtUg2TxjLn4ib70QSXsyh1JBBL4SZsDWhpmlcn6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmarJCKa; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a387ff7acso457995166b.2
        for <linux-spi@vger.kernel.org>; Mon, 01 Apr 2024 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711965205; x=1712570005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vJLSReGupxbDND1LJRyaZWMTkBhBt3K2g1xwcsN8FhE=;
        b=AmarJCKaWNK6ZaSUfLJ4K24cpzFH/MZJbRbdgc4rTwFvG0JYX1VfYp52fZFTIrNUTM
         TZU52ViZO/Bd1xkmGS2uP++JDWTBLLMamtvR0yELz3OKhSoqzEr2n0i3hr6l2Mz6tAXC
         lEuG8ndR4XiguJVIuX65YDWL6oG0GO/yZ+vkYvMH/LbpB+JRYTzkRqA/XqMb9FwXG2+y
         /p9Go+j1B4ZrFFGqXKUPRzlkE0KCGgjsv8/0icuVrg51EauG2wDjz7Cx8iX/BJlvMEFI
         4hAgV47gPJYbr6FPV0+dUxiJXMo+HeQ0NN6z0cuTx8/3NO1lAiLQnzPyAUWcDtGyEXRk
         9TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711965205; x=1712570005;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJLSReGupxbDND1LJRyaZWMTkBhBt3K2g1xwcsN8FhE=;
        b=cuGUphJkSG3/kpgrrEutftsBwg9nB3TwShCrPbeTINN5KMfi6UQ0B5Kb+15AAQomqG
         67xsaHDJCTqz7uSi938NVQXq9vLWC08Z76AN9+GotMy2w5XVy1MljoLJKmAiNjvBWYcg
         HubYepgoRAE93+CU3lLjWgCc32XkhzmxuEbgeIwJFQHLUheLy3YvsReqQt96doROGKit
         nIg9qQhAflVeHhVAc3qTOMZsAd1+4l+69ffoxQSVXfPRJ5Wluo3U6X+OoRe8XvSw3Y/b
         kxxJCZacOBVh4X/UuEeMWuydcopksEzi1MwmokCM6dkxPKvz40HByc9snGuteEQknvNX
         OVQw==
X-Forwarded-Encrypted: i=1; AJvYcCVyU0AQe+9QgFNS4OHy9Unf+UvtbuvZWvriGnmKvMArEf5F1/dMGz1TPKdDGhkTN8OesQ9SmUtgU9jzjdZgFr8jvryOOgO/n4vc
X-Gm-Message-State: AOJu0Yz5td4Rn0zAkbITEQPY5XUtgbuDBOFqip522/rGe5CZln9VpyBB
	xn6S9M8gkw+yPvaOEyF57ozEk2zji4YiQFZE+jWGL8nt9LH4rZHOu6ZjwES+st4=
X-Google-Smtp-Source: AGHT+IGlxvnPlf1UH1BJckd0vZiim7UTtYPcuL+ImBTiKtID4vuz/fJ7QgvzVi6FU4o6qJBrqYu+tQ==
X-Received: by 2002:a17:906:751:b0:a47:533b:10 with SMTP id z17-20020a170906075100b00a47533b0010mr5339129ejb.62.1711965205410;
        Mon, 01 Apr 2024 02:53:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906339200b00a4df78425dbsm5065880eja.36.2024.04.01.02.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 02:53:24 -0700 (PDT)
Message-ID: <7d344878-867f-4a03-90b7-a61c3fff0fce@linaro.org>
Date: Mon, 1 Apr 2024 11:53:23 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] spi: dt-bindings: add Siflower Quad SPI
 controller
To: Qingfang Deng <dqfext@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Qingfang Deng <qingfang.deng@siflower.com.cn>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329015147.1481349-1-dqfext@gmail.com>
 <261f2995-b279-48bc-b9d4-023a8a705857@linaro.org>
 <CALW65jZoU8ChPg+e-5T4+ZmS2=g8O3wL96mjaRAPbomHJhg4gg@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CALW65jZoU8ChPg+e-5T4+ZmS2=g8O3wL96mjaRAPbomHJhg4gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2024 05:36, Qingfang Deng wrote:
> Hi Krzysztof,
> 
> On Sun, Mar 31, 2024 at 1:42 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 29/03/2024 02:51, Qingfang Deng wrote:
>>> Add YAML devicetree bindings for Siflower Quad SPI controller.
>>
>> Describe the hardware. What is this Siflower?
> 
> It's a new RISC-V SoC which hasn't been upstreamed yet.
> 
>>> +properties:
>>> +  compatible:
>>> +    const: siflower,qspi
>>
>> Except that this was not tested, aren't you adding it for some SoC? If
>> so, then you miss here SoC part.
> 
> I should add the "siflower" prefix to
> Documentation/devicetree/bindings/vendor-prefixes.yaml, right?

Isn't it already there? Then obvious you must, but that was not the
point. Please read writing-bindings document. Compatibles should be SoC
specific, not generic. "qspi" is generic.

Best regards,
Krzysztof


