Return-Path: <linux-spi+bounces-8444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7CAD4F7E
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 11:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFA43A07E0
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7589256C7C;
	Wed, 11 Jun 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJIjGO1l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C86255F5C
	for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633181; cv=none; b=pgRjYQgS4MVMbvJfxiFjcgvMBtUaM1Xiwi4VaedMXgInrQnE+rOntj/VJwDUCNqBEhcdtpxYKUC8bpeXB2n6QG7NmlYme5UL1xu9zWTYxjfNUs0afmQVRqD9urz1NdiCW0RWoCkV81U5wS8krGjAOt/S2iwwN5sUbfilnvNId/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633181; c=relaxed/simple;
	bh=26cUrdOcAuBXKmX7HJ2RoGTESx1cYCvg3/jc7ibH4rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Myn8xE25NJ2nKrFCMmMv6fn4vPrRzF/W1EHL27ncJKRZsA5BoTaZUsVPYio3xBI4dGshg0wLp5vuv4UhOme7f8rIaGqRJ7dZEvABhgKtY+3UqZehQuYtJGFjU+Dweh5EXeq2OBn5mMy2ZunIM+dqMBZSv5BCVAwdbdytfoqwe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJIjGO1l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so3716945e9.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749633178; x=1750237978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJDjyWcLMUVeDZk1xviHhZGZWgDlmwilJftnaWCxOuE=;
        b=aJIjGO1lDN1Nbam66LReCsWknV/M1StKDqUk70RDpGYFZd9mW5xuGnavrWDlC34f7G
         UAfXPbayPtDm3w+SOjBbZn5MatibDmwLwJwAcQr/dAx3/pYVdhBViFERlUp18eKsjI6T
         2tAD1gDySPBsfiIokJCBy2NWLzvzaKhh6ZGSjTBHeKDme5OhVlFtnnOa7fM5jUZ7/zQE
         hAWK7ObzluCjSlmv/ybK9Xg1bGEaKKUFQhFDY+V/ejQadN0RBTmaKKz8aZE4e0uXi2MW
         FQ8qMztOjSp8WvdThwUUwxbvu4byklLvl1ncn4pkL2JegBR5vgwpzavfCLUyz1BZWJhK
         vZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749633178; x=1750237978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJDjyWcLMUVeDZk1xviHhZGZWgDlmwilJftnaWCxOuE=;
        b=heBwGHTJHuGye6YQtDZ8wY1ifyozQEaMyzMrTZOZiW8StsPKFQSPHpH9KLSQOIAjg9
         0lW8kJf42s8n+Urnz2oqTnderkCLqMYuGjL/WrPBMHkdbuxwE2E7QMrrTW3RVh96O3MG
         /gcA0bqAuKoUP24gy0NfWGH9zAXcGK6yhOzhx4SE85H15W+QDDvf9e27bfQAy/YWwjo3
         9CikVzukCV1B5VlaspzBSA7vBseJ/oPCYBtbRdB3jtQQPOVXgB9431yZBbdODCyFOfBw
         jaQqQqWJlIGEqF1XVI8H8DYAdSMuURmnpWPiK56S9m4YPUS6Wh7+zIdw5OxO7vZl9SWy
         P3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIZQqPJZNAarKO/+fYftU6vop6OGMQF4ls8kRfzy66HMjcFu1Fp0s6LOsjzGDM17jopqePrXlp5bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMTnCnebjW85z0lY59csRFlL9I3OtUEmEeOPTVd9g/+j3xIfc
	5u24w5Q8nSeLRrzH9J0JAahBCHql1j2JzqoSgbKvNtvH+ePIATv88DeBPd/R3apOIF0=
X-Gm-Gg: ASbGncsfX8CWmTd0CNr8UHdPj+ckaeN9gGEXVYk5Y0THDEdzOocfySvIQOSxzm+8c2j
	l+ZNMY0MRZALvl9u78z9mRduujHpd6ZL85+AH5r7NxkyvkV88+lKoi4rNk2dqDIATN799gRzL9f
	56hGPlZNoE5CWHMpUXFpu/p9ehjITlgMbQtae/LQL6+0ZC+CdxMpXVD+p1z+EvQfYwUsMUoDvzB
	G2Dcx8a229rBAHv62M73iKky9iWmxWYO6gXqRmAtp8yhVQNEOdWQ4XnLjJ5vSB1z1WIUiyPv8aZ
	ZP0ZOX/71FIQAEKI6tWsAXxiJwARSRDoaegnyKiRIBv0PqoHGEfvogNqPPTXKQOePGs=
X-Google-Smtp-Source: AGHT+IEDwPTZL6SoNXK5j+8T0mDQYtHiStwAj5EYJu2ANbxjMsZXyHidUhVjCqsEU3llM45+EIcuyg==
X-Received: by 2002:a05:600c:858d:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-453241f8a38mr16098165e9.10.1749633178213;
        Wed, 11 Jun 2025 02:12:58 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532463ed4sm14755118f8f.94.2025.06.11.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 02:12:57 -0700 (PDT)
Message-ID: <95e216c6-e71b-4330-aa4a-aff74a207eea@linaro.org>
Date: Wed, 11 Jun 2025 10:12:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-1-2b831e714be2@linaro.org>
 <20250610113423.zztoyabv4qzsaawt@skbuf>
 <9852a22a-1a09-4559-9775-2ccbb44c43c0@linaro.org>
 <20250610210147.kwuwwjtcl36hrxjc@skbuf>
 <20250610213120.ib5tkbh4xu7af4jr@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250610213120.ib5tkbh4xu7af4jr@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2025 10:31 pm, Vladimir Oltean wrote:
> On Wed, Jun 11, 2025 at 12:01:47AM +0300, Vladimir Oltean wrote:
>> On Tue, Jun 10, 2025 at 04:41:04PM +0100, James Clark wrote:
>>> On 10/06/2025 12:34 pm, Vladimir Oltean wrote:
>>>> On Mon, Jun 09, 2025 at 04:32:38PM +0100, James Clark wrote:
>>>>> In target mode, extra interrupts can be received between the end of a
>>>>> transfer and halting the module if the host continues sending more data.
>>>>
>>>> Presumably you mean not just any extra interrupts can be received, but
>>>> specifically CMDTCF, since that triggers the complete(&dspi->xfer_done)
>>>> call. Other interrupt sources are masked in XSPI mode and should be
>>>> irrelevant.
>>>
>>> Yes complete(&dspi->xfer_done) is called so CMDTCF is set. For example in
>>> one case of underflow I get SPI_SR = 0xca8b0450, which is these flags:
>>>
>>>    TCF, TXRXS, TFUF, TFFF, CMDTCF, RFOF, RFDF, CMDFFF
>>>
>>> Compared to a successful transfer I get 0xc2830330:
>>>
>>>    TCF, TXRXS,       TFFF, CMDTCF,       RFDF, CMDFFF
>>
>> Ok, so my new question would be: if CMDTCF is set, presumably it means a
>> command was transferred. What command was transferred, and who put data
>> in the FIFO for it?
>>
>> Because the answer to the above is AFAIU "no one", I guess the driver
>> should ignore CMDTCF when TFUF (TX FIFO underflow) is set; I consider
>> that to be the logic bug. You are also doing that in patch 4/4, except
>> you still call complete() for some reason. If you don't call complete(),
>> there is no reason to fend against spurious completions.
>>
>> I think I would prefer seeing more deliberate decisions in the driver,
>> it helps if things don't just work by coincidence.
> 
> After thinking some more, I think I agree with your decision.
> 
> If there's a TX FIFO underflow in target mode, presumably there are 2
> cases to handle.
> 
> 1. The underflow occurred in the middle of a large-ish SPI message
>     prepared by the driver, where the driver couldn't refill the TX FIFO
>     fast enough in dspi_interrupt().
> 
> 2. The underflow occurred because the driver had absolutely no SPI
>     message prepared, and yet the host wanted something.
> 
> What changed my mind is that if you don't call complete() on SPI_SR_TFUF
> (like I suggested), then case #1 above will hang. Your proposal is to
> call complete() anyway, but to discard any previous completions,
> associated with case #2, when there's a new message to prepare.
> 
> But I would like you to introduce a comment above the earlier
> reinit_completion() explaining why it is there.

Ok I can do that. I was going to say that a call to complete() would be 
required, sometimes you only get a single interrupt with both CMDTCF and 
TFUF set, rather than two. So it can't be ignored but it seems like 
we've come to the same conclusion.

I did try a few other approaches. One was disabling SPI in the interrupt 
handler on the first completion, but that didn't work because you need 
to wait for stop mode which might hang, and I was still struggling to 
stop the interrupt handler from firing again but I gave up before 
exploring it fully because it didn't feel right.


