Return-Path: <linux-spi+bounces-8759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A7AE7B32
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1765A326A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AF61DFD86;
	Wed, 25 Jun 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/XqyW8+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314142820A7
	for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842045; cv=none; b=sn9mJdHN24IBCx+dCX9D8qBGYYtot4Xt5L8ss/dDTG2wCc9zxAN3tRqv5OIlYutyUgFxpZrRAkBSVm3d3Woluh9H7mXBQQr2QqJHZ9Ocp0TznxeoaxkVA9tv0X2ScP98e+pBlzA4BulzZ2FKl8XsKXpoyO7QVZRl20qA+BWi/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842045; c=relaxed/simple;
	bh=k6H7pwR+nMUj5KnUuh/03FFNHh50oWg7WEJQvNlPz9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjjaLouukZ1N7qzZKE66tf0Sx8Ma9TNPpyJDsiHeku5G5ndNTa1U6672nDnmyO/voIKpe8eMprMmJvXD4qNF1KTYIqJtm79TpPXxUiwR/4W0qF0CLEIoRVedy7NwnHyn/WLOQwik4J+CGLanVG2U0HU5OaH92fzUE55JTuar55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/XqyW8+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d6ade159so47120305e9.1
        for <linux-spi@vger.kernel.org>; Wed, 25 Jun 2025 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750842042; x=1751446842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ot7b9ErTkUK0Fj2KHvqM8J01nkmxPY1lP+gz/TagS8M=;
        b=p/XqyW8+aETmmqpRplLCcZdbTYoRqO9ynGcVbwNl1yvRw1+kaDCTVYL9y6z/noY1j7
         nX8GEpbmk7Trqa4DmdhvzeKG5Kns1IEUA98+80rT1yR3WrzWmkesUAXrFeBjDQCofEzT
         6nxGmkRIXvdQoYbfOboCN5qpovVKjkTPFZKtQBGdBCry5/OiWJXEAkSct1TMsSrgZoYE
         YIjZ5DcumuDR4Zq94amACX/pKfSMu15MQOvvhIvofWYEtrszA4qhZyMW1v2Zlf3EB7qv
         sKy+/BdAJ1b+TRQHRV4RpA62WCXZHgLgikJ86Y/GBYosLQPUR4JA9ExapGdZw/h8Hf6W
         Ej4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842042; x=1751446842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot7b9ErTkUK0Fj2KHvqM8J01nkmxPY1lP+gz/TagS8M=;
        b=valJQNsuTk9YJtoWiuHzNwcwBcrAm51Rd+zoOGacN851fJUjT7to2thVN7IM0fXcD1
         cq5QA+x0CKHjR50wMBGO9ZxSnMuwVqteiLgmSvGxFiwxK+VL1yzJXUPE/bAzT0GgsXFv
         AS0zf2h4qNaxzGrjV9h+vVk90VQRsuWdMI8Zkcop8HHzuX3UF5LndpCUsD6hVFvCNsbF
         LloC6M8x8vYNY3vM/muvpQdh31ug9cfVDCUrN2ygfry1BUvkMekOMlwwue0c3bfJsXXt
         SZAq1PmoiEapI8Zm8UQ2vGLlU9br9cZEAPjP1skor35xgyhi6k8+Ks+uBSneIaOUTvrP
         cdoA==
X-Forwarded-Encrypted: i=1; AJvYcCUYsJHd0Q3e2ymev9G6QCOflGj/e+930Wk2C8ECvJQhtEENZYxZOuDNsXiMFs5IpKNlwuD2TWw1qfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5slIEpHOQmEUl1eDdS9aKYfZr8bcJJ9zJ/aUAW2evqMm4CYr
	oMCo4RcJYwPmrkbr82TiZgLdNT7ZYbKM82U5yR2PC8y8P8gLRZPwZbMKo81NT9ol8ho=
X-Gm-Gg: ASbGnctPW8XvI6VyBVuju4LzDfhsay7EWXxLuYifUMq02G2yQUDw6kXzEYhh4wa5qQL
	m2ZdC6IvBgIcocaVfev50gMLEQlnh6YVuTuUxodbWrQmKA/dZX72Pz/gB1utwra3xAcouaDFU9W
	ufLYjV7o1BKg8bX6uZUEpH0gum79YWhLFmoJDl0xQWQiXaj5kaB0t78CttjRuExc/dDCLmPhBnf
	/l1Y9Aq60SydQpZScURNjBa8VUwxFbfThEDg8GiBiB8qCz76c1BSzE1vHfZ1qHEbpqzTPw+wxEJ
	gIHJdHewqlcn/XnxMMhaPnln/H+J4yVBAm00thiy3NXcEd03nCwkAYiHg3Ozmc1GM4U=
X-Google-Smtp-Source: AGHT+IFqGmOeAo+r0qrrLle282Rq2mdNx8SfBQVv9o5JsGQYYGmqzMjOzIO0MEBF2wayeOF8rShFiQ==
X-Received: by 2002:a05:600c:1d16:b0:453:8042:ba47 with SMTP id 5b1f17b1804b1-45381b0aa8bmr17801875e9.19.1750842042500;
        Wed, 25 Jun 2025 02:00:42 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805d1e2sm3997701f8f.24.2025.06.25.02.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 02:00:41 -0700 (PDT)
Message-ID: <228fc6f7-52c2-48a8-af7e-6f2cfa7b9168@linaro.org>
Date: Wed, 25 Jun 2025 10:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-4-e7d574f5f62c@linaro.org>
 <aFrUqW0ijRt7CJzw@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aFrUqW0ijRt7CJzw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2025 5:39 pm, Frank Li wrote:
> On Tue, Jun 24, 2025 at 11:35:34AM +0100, James Clark wrote:
>> Using coherent memory here isn't functionally necessary. Because the
>> change to use non-coherent memory isn't overly complex and only a few
>> synchronization points are required, we might as well do it while fixing
>> up some other DMA issues.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> In https://lore.kernel.org/imx/c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org/
> 
> look like less performance, why need this patch.
> 
> In https://lore.kernel.org/imx/ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org/
> look like better.
> 
> Any conclusion?
> 
> Need performance gain here if it is better.
> 
> Frank
> 

Hi Frank,

The performance figures for this set are in the cover letter. It's 
either the same or faster, there is no evidence of worse performance. 
The one you linked was a bad result from not testing it in DMA mode, but 
it's corrected later in that thread.

The reason the figures aren't in this commit is because it requires this 
change and the one to increase the size of the buffer.

Thanks
James


