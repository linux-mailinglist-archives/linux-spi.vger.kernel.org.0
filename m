Return-Path: <linux-spi+bounces-8479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE5AD740A
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5703A5467
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058324A07C;
	Thu, 12 Jun 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEZu2LeR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6A24A06E
	for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738914; cv=none; b=qtI4YmCEKZhL5cHvmCyhI875/LBmFcyN50gIacKtT8kmvkmPfVuiVA0eCSp+6dyIucaJdMO6eVzUOac4LAORJ2d5hrmTmZHH5JSjhcfYvC0EuB/9MggrTI3F5DO9Z3pwu4uFJ/WB/oroe93QP67O2aN0qG01zvMyfoTwOT0xI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738914; c=relaxed/simple;
	bh=jNAynF8yzo2MaHHQ97XS4c/zX3UfIyeqvS8JmkGhBDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgW1CBHDuWmsAs0HwDLIPFauHOm9EAFmNiX4VMWxCFfXKBCsK1ngp1apkiKGjc3HDaM+VX1n5sksaCHmQlzXawyvdlxLpCibhD5DjtfnV3TVeh8+glhCNu0qTig4gQ/dYHj1eeX8rPeV17CoOVffDNYNDa+solMKRvSDKK+XOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEZu2LeR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so954925f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749738911; x=1750343711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Islg/EqCEkW8m6OOg2kXY87sZ2v1kaNiGQHTKgHcYDM=;
        b=sEZu2LeRk/3OF2LKi+x8o0dk2L2Aw0LlAHF8YhXt7qPgv/0lF7NM1uVmA8SIcvPXhB
         vyAr2F2U6FbzXU9fTDp8mYyALml6GSKko8yck1k18PrEzCgFZp36Fl7+C2skyAxb/Kvg
         IRco6d3ZT1uOjTeCvL6MYeoOFGZ/CwIPBAG+cYec8mx8TDXsc01ai9NrVgwJNxna4inF
         PWvIkm9NnhUaqYyOjoPs2oaLfXdn1FvxP7jB+bin7i5eI/gSfOaT2p9N/WDfEtwmDwQx
         0ZvGZry4jxNXxiZ1r0WByqFdGxXEkM1tR/71H2kRNMLIQa3mam9ZnSNPNrHGUctSwNNy
         3PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749738911; x=1750343711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Islg/EqCEkW8m6OOg2kXY87sZ2v1kaNiGQHTKgHcYDM=;
        b=cLZvjjdaTeWA0Z/SodiF/3BmF35O4rBYf6180ncwRC5GZ4MidHnYtGpO0DsxBQE273
         c6WFskmrU5ptqAypGb+l0rnAA1vK+Z5vPPe+KYzYw/cIpRYlvZpCqmiuZmW/6yX3uLXl
         dPPnHFRqatR3Mbnlq5wOM7BMzhDv5YLZGae3z/Y55E7P+j4g8ys7jEIKraOH4b7gtj8H
         yg2K4HJjsEvTdOcPzFVa/ImqBkFFl+Z/sQwCjsClvO9oSloIu5F+ybXHmpvzDaSTSSXq
         Qiidw6fyUejuuq/x1ERTGYHr5EDd3DHy9QvDTILFuekgu0z0DQgkDoQnJoPNMwuJ5o1j
         8JBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4CXFT7X8GgyjgKpSG7RT27sHMTgv/yJLPR/faSdMvYiSlM6/MfA5YXiGlasYnzMh4mjYA6+uz/7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/z4HaZ9+Q24SBd8WhN+IGbVWLDsWhoUzebGx5IYXWmk1H8iA
	+LjXb3AdYrYBNqSjH4WbFDKkov7pAnAAEP8y1Tdgg7b3tseI7748EtCErsW5e1oSKMc=
X-Gm-Gg: ASbGncsjym/nQocJQopc0375C/Z4g4fjh1o0+c+fogkdYMbWUpFuWNCKiUKWewDV5nE
	HoL4Lo6T85Jpyt78R1+mc08JkllNtO4T34VznYdKqAXV9BOrrl5SZ2YNh/C2yNE5PkstbNJ1jTw
	QeIt+ntRSonnqoMIIc8SNI18LWo8XAg9Y2fR7aX7me4aPaissv9Hcz/CcXpjHZC45eh/yaZInBq
	IMnj6PgiF9MHM8TjfNS6XOuZ06z+KfJGLTbKRqkcmtjigJJhTn8nvL7s4Aghls4ZZZJaVSgSuTk
	oUKJa5R8yz9SaXQmQDMO403EnOU98f4jukevkW2Tk7ICW+oW0VM3lWNJLHBqccrqWho=
X-Google-Smtp-Source: AGHT+IHGD+FKI853WgGp5aiNF/V4TxjRvLR3P42qPzeJbmR1YHKdgcN+H9zGrdpu4QQZKKNMIaFVqg==
X-Received: by 2002:a05:6000:4313:b0:3a5:1471:d885 with SMTP id ffacd0b85a97d-3a567a2b4camr116503f8f.56.1749738911096;
        Thu, 12 Jun 2025 07:35:11 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561a3ce55sm2162802f8f.65.2025.06.12.07.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:35:10 -0700 (PDT)
Message-ID: <31a16580-e3ce-4cc8-8310-04a0dd292df5@linaro.org>
Date: Thu, 12 Jun 2025 15:35:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
 <20250612142306.3c3dl46z326xvcud@skbuf>
 <5b21c4c9-0ef7-41e5-a3bb-5a48a0c73644@linaro.org>
 <20250612143157.bu4vayvhieohdtbu@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250612143157.bu4vayvhieohdtbu@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2025 3:31 pm, Vladimir Oltean wrote:
> On Thu, Jun 12, 2025 at 03:28:37PM +0100, James Clark wrote:
>>
>>
>> On 12/06/2025 3:23 pm, Vladimir Oltean wrote:
>>> On Thu, Jun 12, 2025 at 03:14:32PM +0100, James Clark wrote:
>>>>> That's why I don't like the DMA mode in DSPI, it's still CPU-bound,
>>>>> because the DMA buffers are very small (you can only provide one TX FIFO
>>>>> worth of data per DMA transfer, rather than the whole buffer).
>>>>
>>>> Is that right? The FIFO size isn't used in any of the DMA codepaths, it
>>>> looks like the whole DMA buffer is filled before initiating the transfer.
>>>> And we increase the buffer to 4k in this patchset to fully use the existing
>>>> allocation.
>>>
>>> Uhm, yeah, no?
>>>
>>> dspi_dma_xfer():
>>>
>>> 	while (dspi->len) {
>>> 		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
>>> 		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
>>> 			dspi->words_in_flight = dspi->devtype_data->fifo_size;
>>> 		dspi_next_xfer_dma_submit();
>>> 	}
>>
>> Right but that's before the change in this patchset to use the whole page
>> that was allocated, hence the next bit:
>>
>>> And we increase the buffer to 4k in this patchset to fully use the
>>    existing allocation.
>>
>> We were allocating for the size of the FIFO (multiplied by two to hold the
>> control words), but dma_alloc_coherent() will be backed by a whole page
>> anyway, even if you only ask for a few bytes.
>>
>> After changing that to make use of the full allocation the FIFO length is no
>> longer involved.
> 
> Ok, I haven't walked through patch 3 yet, I didn't realize it would be
> changing that. I will want to test it on LS1028A.

Yeah testing it somewhere else would be good. Maybe there is some 
limitation there about the max size of the DMA transfer, but I didn't 
see it.

I realise the tense in my original message may have been a bit 
confusing. I was mixing up the existing code and proposed changes...


