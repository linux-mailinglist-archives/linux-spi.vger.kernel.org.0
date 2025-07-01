Return-Path: <linux-spi+bounces-8937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE1AEF470
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 12:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3860C481D55
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E426CE09;
	Tue,  1 Jul 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhJDHr5t"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C525D212
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364143; cv=none; b=DidIE51JT+U7M/dcHZVbIXZt/D6u87MP8NXLMxGgugY+sxHZlWeGFu8lORcyzwbxyDkDuK477AS32TRmS5zzQPexarE6QMetNyaqnKGmDOb7r14f2Eb7veK78qUQiYFXjecw4Ew68iPhFTPc2ck754IdzeixneerGmz8Jjy63vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364143; c=relaxed/simple;
	bh=cpyqTOGVeYqY3XRnRs+oIY5hjGnfsVsVIR9fqCXXKXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHymJBDaabjcEOBiGxNP9eHznWs5lYxHCYH76yiqf59M07o1/SM3+d3SzcQLFMu5g4ekpxRxMCe9hZL2FDPsBqXgmkeSkPOmg8ylVGPXXW9/un3p3Dgear8cj8LWqc0PVjy/nfcl0MPbaEvnxTV/ni9IBkqdg3rfRGmjRopXbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhJDHr5t; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453634d8609so38202215e9.3
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751364140; x=1751968940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZhhFhh6zreoch3UvbvFqYL168bvoOK/hSQ4W4s5kf0=;
        b=lhJDHr5txAdpTrGyuqWJjb8HOxSeO/pVGJLSKNvpVfRRXaggDjT8qrUg6WdfxJQKgu
         /Wraf0k6eYmeO9T1cZ4cecOria1X/5sWJuadmHL3J3NlLsJQoFMFKy9DCsJnTqS/wey6
         1rtJZurjDlfOPLHCbii3EusCu2QU167w6ZsoTezzkgMbIhrUtTM9sz9opkA3VBnunadi
         8x9gQDWk5T0aMpvly5zZxdAl3cuWXej4KnFXVjm3pRPSEay72cf9VtQDRxmoYYBQ17Ul
         2k+ZOeMT3j4cM/GEqqJ4lXUrjWROqxPJXu/7Pou0xq6fLm7pELB/icX4vcMC5fhjop/u
         vmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364140; x=1751968940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZhhFhh6zreoch3UvbvFqYL168bvoOK/hSQ4W4s5kf0=;
        b=FOD6ph3/nUmT0+8EPx0UprP4qoVQhIpNbSSkPLi84+I4lwxu0CGRrlPntMLbzzC3Wb
         FTkExe64F8xBVMQrwQ2WE0BVtkb5/lyuQc7SqBKRg4SdMb2oYw4gzcDOybyOEjEMt2zm
         nGGnnlOv9sT//0XK1pumh09HQOhSswgaxKeXSHpT6Khbtg+168mJcNloVAKlXHGCUr7N
         diIQlOAq9kOogX2MLklYchC7Xpvf24B2jbjKD3n+vmOVhbYg7VhQbQVBp7OVZRbICFiz
         +bH9PaKPVyn85pH46pD6zWRdjoby9sN8+h9G6FoU+5Mi3o028jHpGy3yiWNKCqr26SHa
         GHSg==
X-Forwarded-Encrypted: i=1; AJvYcCXsL/bjsAIqPYfcjP/o86NQ2OpefYLeXwzkCokYpDCa1UJEGP/+R1yMnAcf9+3eRRm0HEl4sUlOS2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXmG03ZMau25cUyQQz73/JynSKOVIahCFpufI6jFpLh+Dr/wC
	CMcWS2YdUFRmgZs4TdWd+QjSKHZ8BRlxzWre7tMwcdqzB0zD4pIoAyGXvSa3vb7aH0Q=
X-Gm-Gg: ASbGncu7abzhFD/kJQ+nSnCSCXXc6m+CeCA27HXaUzss9EECnKny0cFcLfsev2Py0qT
	1poc2E3pC4rHkuPPIkI+zo8kqrRDF9nccIpnBWqvRmNS2toO5JG2peq8yNi7Gbw8eGOMEOTz00M
	fYn+nKe429lyuepJZxXFWrIYKtLPMCxrZGRqstsuwlHhoJvISDxFgsWqwXu7BJB6L7qyKAnY8DI
	PU4fkj7Ry9HDy9aILyCWkIZ+/bm1zf/et9ydJUNKt0LelFmc5Yipi9Vgrq8fAr2qB1CCsOZBfRJ
	vUc0mq432xjlI8kRieeOik4IPrsA52CN7jqMmCW6YHghnSswNmvUDUT+dwAqfsZQIGs=
X-Google-Smtp-Source: AGHT+IHBCQlP9/nR2LptdOeK1mMuPMiYt+Xt6KQSAcgiyQshNwB07NsvhgJqGsj1NDftDmY49jePgw==
X-Received: by 2002:a5d:4d8f:0:b0:3a5:8a68:b82d with SMTP id ffacd0b85a97d-3a90038b70amr12122291f8f.43.1751364140010;
        Tue, 01 Jul 2025 03:02:20 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad0f3sm194486775e9.19.2025.07.01.03.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 03:02:19 -0700 (PDT)
Message-ID: <8eedf34e-b870-4a73-b966-e9745809dff3@linaro.org>
Date: Tue, 1 Jul 2025 11:02:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>,
 Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
 <20250627213041.vp6yfcgf4xysdklf@skbuf>
 <423f101a-0826-4b7c-ace7-f5e7f4790c4c@linaro.org>
 <20250630204135.gzffv33j3pk3bgx6@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250630204135.gzffv33j3pk3bgx6@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/06/2025 9:41 pm, Vladimir Oltean wrote:
> On Mon, Jun 30, 2025 at 01:54:11PM +0100, James Clark wrote:
>> On 27/06/2025 10:30 pm, Vladimir Oltean wrote:
>>> On Fri, Jun 27, 2025 at 11:21:38AM +0100, James Clark wrote:
>>>> This will allow us to return a status from the interrupt handler in a
>>>> later commit and avoids copying it at the end of
>>>> dspi_transfer_one_message(). For consistency make polling and DMA modes
>>>> use the same mechanism.
>>>>
>>>> Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
>>>> this isn't actually a status that was ever returned to the core layer
>>>> but some internal state. Wherever that was used we can look at dspi->len
>>>> instead.
>>>>
>>>> No functional changes intended.
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>
>>> This commit doesn't work, please do not merge this patch.
>>>
>>> You are changing the logic in DMA mode, interrupt-based FIFO and PIO all
>>> in one go, in a commit whose title and primary purpose is unrelated to
>>> that. Just a mention of the type "while at it, also do that". And in
>>> that process, that bundled refactoring introduces a subtle, but severe bug.
>>>
>>> No, that is discouraged. Make one patch per logical change, where only
>>> one thing is happening and which is obviously correct. It helps you and
>>> it helps the reviewer.
>>>
>>> Please find attached a set of 3 patches that represent a broken down and
>>> corrected variant of this one. First 2 should be squashed together in
>>> your next submission, they are just to illustrate the bug that you've
>>> introduced (which can be reproduced on any SoC in XSPI mode).
>>>
>>
>> Thanks for the debugging, yes it looks like the patches could be broken down
>> a bit.
>>
>> Just for clarity, is this bug affecting host+polling mode? I can see the
>> logic bug in dspi_poll() which I must have tested less thoroughly, but I
>> can't actually see any difference in dspi_interrupt().
> 
> It should affect both, I tested your patches unmodified, i.e. interrupt
> based XSPI FIFO mode (in master mode).
> 
> Assume (not real numbers, just for explanation's sake) dspi->len is 2
> (2 FIFO sizes worth of 32-bit words, but let's assume for simplicity
> that each dspi_pop_tx() call simply decrements the len by 1).
> 
> The correct behavior would be this:
> 
> dspi_transfer_one_message()
> -> dspi->len = 2
> -> dspi_fifo_write()
>     -> dspi_xspi_fifo_write()
>        -> dspi_pop_tx()
>           -> dspi->len = 1
> -> wait_for_completion(&dspi->xfer_done)
>                                             <IRQ>
>                                             dspi_interrupt()
>                                             -> dspi_rxtx()
>                                                -> dspi_fifo_read()
>                                                -> dspi_fifo_write()
>                                                   -> dspi_xspi_fifo_write()
>                                                      -> dspi_pop_tx()
>                                                         -> dspi->len = 0
>                                             <IRQ>
>                                             dspi_interrupt()
>                                             -> dspi_rxtx()
>                                                -> dspi_fifo_read()
>                                             -> complete(&dspi->xfer_done)
> -> reinit_completion(&dspi->xfer_done)
> 
> but the behavior with your proposed logic is this:
> 
> dspi_transfer_one_message()
> -> dspi->len = 2
> -> dspi_fifo_write()
>     -> dspi_xspi_fifo_write()
>        -> dspi_pop_tx()
>           -> dspi->len = 1
> -> wait_for_completion(&dspi->xfer_done)
>                                             <IRQ>
>                                             dspi_interrupt()
>                                             -> dspi_rxtx()
>                                                -> dspi_fifo_read()
>                                                -> dspi_fifo_write()
>                                                   -> dspi_xspi_fifo_write()
>                                                      -> dspi_pop_tx()
>                                                         -> dspi->len = 0
>                                             -> complete(&dspi->xfer_done)
> -> reinit_completion(&dspi->xfer_done)
>                                             <IRQ>
>                                             dspi_interrupt()
>                                             -> Second interrupt is spurious at
>                                                this point, since the process
>                                                context may have proceeded
>                                                to change pointers in
>                                                dspi->cur_transfer, etc.
> 
> Clearer now? Essentially the complete() call is premature, it needs to
> be not after the dspi_fifo_write() call, but after its subsequent
> dspi_fifo_read(), which comes after yet another IRQ, in the IRQ-triggered
> path.
> 

Much clearer, thanks. Not sure how I missed that, maybe a confusion 
about whether it was dspi_fifo_read() or dspi_fifo_write() that modifies 
  dspi->len.

> Not sure why you are not able to reproduce this, maybe luck had it that
> the complete() call never woke up the process context earlier than the
> second IRQ in the above case triggered?
> 
> I'm not doing anything special in particular, just booted a board with a
> SPI device driver (sja1105). This transfers some sequences of relatively
> large buffers (256 bytes) at probe time, maybe that exercises the
> controller driver more than the average peripheral driver.

It's strange because I was stressing it quite a lot, especially with the 
performance testing.


