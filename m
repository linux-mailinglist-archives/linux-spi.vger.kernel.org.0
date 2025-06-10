Return-Path: <linux-spi+bounces-8429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D83CAD3DAF
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE08165098
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2F22A4CC;
	Tue, 10 Jun 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrR5F2nQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F9EEAA
	for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570068; cv=none; b=F0tAI0WxYlMlNnUJtVI/clAGeUAAd1Jp7kH2CCz7sEgnGPHvonhBWQDy9k0uTYNlUYWUdlJiAi+s4tY/a2665xmxsP9JCRRKmsQL85wnxq166hz6kFpjLq43n06JNfkh+jAnR0sUakMHFftNHVGwTo6wbyDUapiN63dS7pYNaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570068; c=relaxed/simple;
	bh=AtvJGadDdNn2deN/jM5ACKLSrWLu0JL74f9Qzw/g/es=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ttr1uXRsvpRRlxwl4k7mTpwxnvWL9dawfdWVU5oKOFAJSEBJ1g43Ip1fujxUEX3jhePrd8Z8ggSL/4NrUzy55y6xj3XA3p9J776aTtAJKntX85Ni84oxyGAsZG5S/9PfrL3op0RZagYvhc1yZdamDcuUB9xXqduZ91pgGiRAE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GrR5F2nQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so39376705e9.0
        for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749570065; x=1750174865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NueDFP08WvW+DK8xODEP+iBtJMi/d11N9xPcU6ggTQE=;
        b=GrR5F2nQmmCUBoB8VHMASx9bhK4i8+xMUeNjG59vNtuqnQJn++1s0e8WHg+j1Iui3I
         lBVKuXiAqawKR5WHOiGcW2gcEFuHWemQf8CDQbRlHutX8XqttfHT043r/8SgjGSCfqoQ
         VWm04OEt8ajTG+cy0Jxvm40LsRCk4DRPkz8ziVCndbCh3v+q/AnnrrSlsoZoM2YkD9YR
         8spYCyNiapspFxYs5LzlzXMZR4hyMv4wU7SWNoVsIhaLGFpaVSRHG+nou4ALSlTa86kE
         4cMKjRgXCIw4cTeHaAsWnzbEkkDH2+xnrGVJem63ygCqUBxIBXmurUZwfZ/ePjoXKR2/
         QbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749570065; x=1750174865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NueDFP08WvW+DK8xODEP+iBtJMi/d11N9xPcU6ggTQE=;
        b=jacMJ7MO+lhZNBA6CU1wEJsbZVNKkLJkgcOA9vRiTLkJzu0EVJ6uVanwnqJ1CfcGNN
         n/bNI1r5Sf3npEQfB6theWfj0ZkkYq3ytYVrmmhbAKwiu96OL4FK2nIW5vrS7GB6FLyw
         5d+MD9xc2d2xrAHIvYqcL8jIkTMVgSD619iFQRH4PAQ/6jGW2eJsURVh/gcG55dcreUE
         iYz3c5vAr0ol1Lqhu9byev4+ePq3Q8dEwwEYC73sWPq5Ufy9i01XqOG7xDrgmFcwxUhm
         n7zZjJDXsIHDj62RvrTYDd3KX6XJjL7rwABqCi/DVWDhCDrPOPd9YPW8l+TrPBvSTe4v
         SsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlRPUvd1nO0AltZjGaVUVW36NnnoYsr5udDInLL7wZu9/3BBrx5n4Hw17XA+Op//bE3/0VshRdRpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaR9PX4LmDMAfo6+03gBKBvCcWj5Jl/Lt/bnH2RsCwCVVYNa1D
	on3qZ4ehLcc2jRL16jg1J4IbCXfOl9be7hjh4smS6HhF7pyB3VnRmNxtpoKfHTueExvrdjdaceQ
	PG7uD6c0=
X-Gm-Gg: ASbGncthU+eheSiB+sd9HVa+jF6ZpZbsXzn4CUJcYPGZrf0AjyGs703ZPJARXOFxbnq
	Z1GWUT3SisURPk0O6AyD5vCJN29+8N02RjMxDGlv53anfh9jCSkh6kw8xGkFFsp165wyzur/VXx
	jHEbT1qAF57W0aEUMghHeob4mHQwlYpxE1XnQrXa4j0tSbQnwJH5MTgZZUaVLWNoZ4dAmJptitO
	Uuh21KAYg8cLnORvFiVfVWE+ecNreOH/2HafJc98g7PwZSZ4bn7VUgIFrgrw0WxIseuNuiS4Oy6
	GhfXoQ/Bdgs5Q3kMLlrrMiUjWDu3TkjtwsqsiEj8s1GCiDQp6HH2qJpUo2mjaQUN1WE=
X-Google-Smtp-Source: AGHT+IE8vZWJXPJwa+gVU82KDy8mY6qQldYKeCEubTj2bvtmDCPRe0/J0ElfWijiPtS/DHNqS1NHVQ==
X-Received: by 2002:a05:600c:3b8f:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4531ddeac16mr32168275e9.6.1749570065317;
        Tue, 10 Jun 2025 08:41:05 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5322ab413sm12488670f8f.23.2025.06.10.08.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:41:04 -0700 (PDT)
Message-ID: <9852a22a-1a09-4559-9775-2ccbb44c43c0@linaro.org>
Date: Tue, 10 Jun 2025 16:41:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 1/4] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-1-2b831e714be2@linaro.org>
 <20250610113423.zztoyabv4qzsaawt@skbuf>
Content-Language: en-US
In-Reply-To: <20250610113423.zztoyabv4qzsaawt@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2025 12:34 pm, Vladimir Oltean wrote:
> On Mon, Jun 09, 2025 at 04:32:38PM +0100, James Clark wrote:
>> In target mode, extra interrupts can be received between the end of a
>> transfer and halting the module if the host continues sending more data.
> 
> Presumably you mean not just any extra interrupts can be received, but
> specifically CMDTCF, since that triggers the complete(&dspi->xfer_done)
> call. Other interrupt sources are masked in XSPI mode and should be
> irrelevant.
> 

Yes complete(&dspi->xfer_done) is called so CMDTCF is set. For example 
in one case of underflow I get SPI_SR = 0xca8b0450, which is these flags:

   TCF, TXRXS, TFUF, TFFF, CMDTCF, RFOF, RFDF, CMDFFF

Compared to a successful transfer I get 0xc2830330:

   TCF, TXRXS,       TFFF, CMDTCF,       RFDF, CMDFFF

>> If the interrupt from this occurs after the reinit_completion() then the
>> completion counter is left at a non-zero value. The next unrelated
>> transfer initiated by userspace will then complete immediately without
>> waiting for the interrupt or writing to the RX buffer.
>>
>> Fix it by resetting the counter before the transfer so that lingering
>> values are cleared. This is done after clearing the FIFOs and the
>> status register but before the transfer is initiated, so no interrupts
>> should be received at this point resulting in other race conditions.
> 
> Sorry, I don't have a lot of experience with the target mode, and when I
> introduced the XSPI FIFO mode, I didn't take target mode into consideration.
> 
> The question is, does the module support XSPI FIFO writes in target
> mode? In the LS1028A reference manual, I see PUSHR_SLAVE has the upper
> 16 bits (for the command) hidden, specifically there is no CTAS field
> there that would point to one of the CTARE0/CTARE1 registers.
> Cross-checking with the S32G3 RM, I see nothing fundamentally different.
> 
> I am surprised, given this fact, that the CMDTCF interrupt would fire at
> all in target mode.
> 


It's working in my testing where I've forced it to XSPI mode instead of 
DMA mode on S32G3. I assume the command is blank because in target mode 
CTAR0 (aka CTAR0_SLAVE) is always used regardless of the frame.

CTARE0 isn't explicitly relabeled like CTAR0, but this paragraph states 
that CTARE0 is used:

   50.4.3.2 Slave mode

   ... The SPI Slave mode transfer attributes are configured in the CTAR0
   and CTARE0 registers ...

Any transfers smaller than the FIFO are working in interrupt mode, 
although larger ones are problematic because there isn't enough time to 
reload the FIFOs while the host is still sending (hence the error I 
added in patch 4).

Polling mode isn't working at all because it has a timeout which gets 
hit and returns -ETIMEDOUT before the host sends anything. Although I 
added the check there for consistency and for catching host mode errors.

>>
>> Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
> 
> To be clear, if you ran 'git bisect' to track down this issue, it
> wouldn't have pointed you to this commit, would it?

I didn't test it no, but I did assume that the wake_up_interruptible() 
that got replaced wasn't vulnerable to this same issue. Because the 
spurious wake_up_interruptible() would be "lost", and a fresh one from 
the next transfer would have been required to proceed past the 
wait_event_interruptible().

Whereas wait_for_completion() is just a counter so it has the memory 
problem explained in the commit message.


