Return-Path: <linux-spi+bounces-8780-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8AAE99BE
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57BB3A7C2E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516D29A331;
	Thu, 26 Jun 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uftq761a"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14342294A15
	for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929303; cv=none; b=lU8tFVPghRkGYlJYJmvzxoSmufRiKl+qXgP8SdCQELPcKbFqVwekKrY2MhNmildT3QHTvs1H/t0VkrxHjuSENP0NzXORwJySA8/iLgY0eFziCvFLhrffXAgGHIgX4BhNb7b+qpGgEOfk+3PmjZgpb9+cDUjk+Ekc8mRkqxDE530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929303; c=relaxed/simple;
	bh=TXuQPqAg7S5oOsB/2JdDGDJQ7ANNmURcZvFDfmnEIH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyBjs45aKU3K+pFiZyWuhtvDTmcB4eZqetJj86UHx+3+9VdB/f1jxmIASk2oiDHJNWXMTsORlMITB2r660aPmo3hyZyWzJEvHx6uDcbrvjMHc65rp84CNUt5S8xd/5W+/f+IWOjttk9/L2v/RxZQWFovrgSdankLjXWWG8xi6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uftq761a; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453643020bdso6079295e9.1
        for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750929300; x=1751534100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6HELOLH5t63t0lxWsM9sFc0qk5UYWyQgDUSTkLl0Kg=;
        b=Uftq761anopkAEHofrwinkUqaPo973/UtjH573OugAj7dPYCz+N+pNxhR2Ebs63UQO
         w55fEWkT3yEv1mmsVfP5fzVPs1smOrVlG1o4/YuCRFCbHCRyjsNNCX6Sskdr0atFjz+N
         xDKUOJ0XhmnTpCr48KIytrLTei6A/RrnOU4nnlgVenCVLL3ZWlUGFfJWYos+qS7RmPcn
         u2GJakQV5gLJUU3Y3lVd6Ma4Hg7QVQz2DIAkzjJrmEI0Z2tVmXJYnaq/QiUr1UUu1y7b
         +bXWijkBGKyH1qtr8XVoa16qk8/zQuBQZMBdx3w59KjPVS6X6c+iC6NTLBUUCA1fGNWq
         +G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750929300; x=1751534100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6HELOLH5t63t0lxWsM9sFc0qk5UYWyQgDUSTkLl0Kg=;
        b=PRK3hPDlUIXboPPiBUrVkjJQ1byJhfoOXWdofsA3XzREc6QVkJ1GHHcWHbd9jsAVYg
         LPd/Ab9mjZRDqvgD7gDJ7GdOIoIryhUuH1zG46KjCvWYYlw5CAk+p6PnWMpSQUSg/MSy
         urtAW/KxeEViEJp5b+ftBUBfLWTTTkTQ5oFgTc405jbZoFnAtI503+SZ1Xmof7ZR09gT
         /zU54oY1s/ZcZDheMdP+1cinXClpq1ybX6ilNlnoGVYZwvGs8dX6ONfxnFT42Je8yotO
         5AI3gMd9qsie4fmMtZWXbFCdjMF9tQ+ah/SI0V5ixNcxkz8vpsFJGAC/oj9yrQuLO0tD
         K6lw==
X-Forwarded-Encrypted: i=1; AJvYcCWeUAX05CzMTS6DHUBgxeER30Y8Tmiz/TX78OG6B54jxLZbfpE0Ubr4RDklZudcIpMdBk81vDW1Fng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEw4V1+2OGjHEijQNIUm+pjsMYGANm2KjxHs24OmdRRe0FhapS
	fJla9Hdgf6cGbm3mR5ulSR6J71Fhq79m3DeAsHIWB9LvbA39NNcPBccLlgE7hEWA7Lg=
X-Gm-Gg: ASbGncvqzQSRk3eRb4w6pToEAy9yeJeY3AKEr2L6+Vaf4AXv2X+KwOszZ20jRiFSWj4
	kCVCYq7TVnofx70oh55R1JIQGnymbrBuKx9GAd9Dy/rfsKXa7OBc/X4HmY1RsJUbZGBnM2jioJZ
	B5vYDTh2ZMbOkqrBj9HFwmH9qPptxkTFhr8Y5P/7i4kF3vZ8sICf49QLSyzjIV/+OLEhA5D9cJv
	uiieXX83jRML/Q/x2+t8ZnBROxMXR3Ne1qMD1ylSQH7pAvX0aZrRBzWTMyO4M+5SnfmUQJNdrL6
	yJtvOS78M79p1ZjLiBCUfNyqef3e4l4P3Alj1a+GSu/NPxkkZsogIhnbMU3q/tUNH6E=
X-Google-Smtp-Source: AGHT+IGu1qpUTz8c4jWhNCy48sK61OzHT2aoxKhnMhoAC1djW2eREuQnj2r7lzI78n8bzCS1SF6OaQ==
X-Received: by 2002:a05:600c:c16d:b0:441:ac58:ead5 with SMTP id 5b1f17b1804b1-45381af23bfmr65504065e9.31.1750929300374;
        Thu, 26 Jun 2025 02:15:00 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm43399545e9.3.2025.06.26.02.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:14:59 -0700 (PDT)
Message-ID: <6fe9eebc-b050-4b12-a28b-e2f0bcc707e2@linaro.org>
Date: Thu, 26 Jun 2025 10:14:59 +0100
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
 <228fc6f7-52c2-48a8-af7e-6f2cfa7b9168@linaro.org>
 <aFwQCL0tQh9peb7x@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aFwQCL0tQh9peb7x@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/06/2025 4:04 pm, Frank Li wrote:
> On Wed, Jun 25, 2025 at 10:00:41AM +0100, James Clark wrote:
>>
>>
>> On 24/06/2025 5:39 pm, Frank Li wrote:
>>> On Tue, Jun 24, 2025 at 11:35:34AM +0100, James Clark wrote:
>>>> Using coherent memory here isn't functionally necessary. Because the
>>>> change to use non-coherent memory isn't overly complex and only a few
>>>> synchronization points are required, we might as well do it while fixing
>>>> up some other DMA issues.
>>>>
>>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>
>>> In https://lore.kernel.org/imx/c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org/
>>>
>>> look like less performance, why need this patch.
>>>
>>> In https://lore.kernel.org/imx/ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org/
>>> look like better.
>>>
>>> Any conclusion?
>>>
>>> Need performance gain here if it is better.
>>>
>>> Frank
>>>
>>
>> Hi Frank,
>>
>> The performance figures for this set are in the cover letter. It's either
>> the same or faster, there is no evidence of worse performance. The one you
>> linked was a bad result from not testing it in DMA mode, but it's corrected
>> later in that thread.
> 
> Okay! you need mention why need this change, why non-coherent better than
> coherent at your case.
> 
> You descript what you already done, but not descript why need it.
> 
> for example:
> 
> "fixing up some other DMA issues", what issues exactly?

I can remove that line, it might be more appropriate to add in the cover 
letter as it's relating to other commits in this set.

> 
> some benefit, like memcpy from/to non-coherent is faster then from/to
> coherenct memory ...
> 

Yes I can mention that it's expected to be and was measured to be 
faster. That should help people running git log in the future to see why 
we did it.

> of put test data here will be appreciated.
> 
> The cover letter will be lost after patch merge. When someone run git log
> after some year later, they need know why need this change , what purpose ...
> 
> Frank
> 

I somewhat disagree with this. Usually maintainers add a 'Link:' to the 
mailing list when applying patches, so the cover letter shouldn't be 
lost. And these particular performance test results are short lived, in 
several years time other things may have changed. The performance is 
related to a specific device and the state of the rest of the kernel at 
this time. Additionally, I mentioned that it's the combination of two 
commits. In order to put figures on this commit message I would have to 
run another set of tests with only this commit and not the one to 
increase the buffer size which comes after. I did consider reversing the 
order of them to do this, but it wasn't straightforward, and I really 
didn't think it was worth the effort when I can just put the figures on 
the cover letter.

We only need the figures to judge whether to merge it right now, readers 
in the future will want to read the commit message to see what was done 
and why. I'm sure that they can trust that we measured some improvement 
if for some reason the cover letter is lost.

It's very common in the kernel to put figures relating to an entire 
patchset on the cover letter of it, rather than on the last commit message.

> 
>>
>> The reason the figures aren't in this commit is because it requires this
>> change and the one to increase the size of the buffer.
> 
> 
>>
>> Thanks
>> James
>>


