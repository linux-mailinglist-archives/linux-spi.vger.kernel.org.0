Return-Path: <linux-spi+bounces-8888-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CD0AEDA3B
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D2518977C8
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5A20E032;
	Mon, 30 Jun 2025 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QS2cHGEF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB16126BF7
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280405; cv=none; b=DEGYOYJQDDkQvIgSYqqteB8TkB6RUJ2Vl6+qZ+HDVPlYJ0I/oOWRv3QFjSaq8giZZkvtHMCfrfCaZhEl9z0zUGs7gGobNiyPLx2MnzfRkCxnkQgatkdnelO6FkFasACPuoZZoIKmgfNiKkCFP4bEJ7N239EgFQwTKX0h+AmEQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280405; c=relaxed/simple;
	bh=gvyprsey8lBq/cwWETIidXRcGflIGW0KiZP0ucqQnYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOzXPTWQRCN26fPsVcXhJ6rDkW2VglfzsDjOTbovIrLYiGHTuLIB9fiYW9+0fQs7eOgdC+R9UaNhfd3wskTGt+ye39hvmMZhhq8pUDIgRXV83kw4Tt++4G7ytm9KaxNP7/NmIL1KLdxKrrRVX7CH1v8YYXo7MZ2fSDPWkodQqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QS2cHGEF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so27977535e9.1
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751280401; x=1751885201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFNukEVeOuH7fRtCazTP0zdNBYQLRBbJSaq5WQ9/jSE=;
        b=QS2cHGEF0LCLKtTg56W65PZeV1MqSaN02Tm+mgecpDqNuc5cIe35Kih5HZjpMTYC5N
         GkfIam99sy2VzrR8JlhMvB2VqlTLJoNmd8b+8U4Ec1kYnRYcBek/TGw1jEHxUPmww03M
         dhICwFjJU3J5sLY4MpSCWuTpdJqjhtlctrQ0OoLmWZ3dwN8o2jXWnuJRwN6JP5p1f4zE
         bBQFhSgO1WbHWqCTajzN1jiS4llT7SIrVOYVv3Lv1K5k7nJo3LhBRtuaumeZGfBzz9tk
         2j8bIOY7iLGblJDSgk9IziJXg4soNEhkCb673xARi3emBk0USPAbHjuOcB3KbafIFiLh
         +1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751280401; x=1751885201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFNukEVeOuH7fRtCazTP0zdNBYQLRBbJSaq5WQ9/jSE=;
        b=kjaDCZLSWr+pW6mvQL1biVhjceNOZPMS8F6bUAFC2q1PteGqyobQWLkqwwrL8BHssV
         ZJyOreTuwcQgtIVXRqB1DEaD1OuAicI8V4nKd+0OSccMKZzdmoLN7dojQqk/DjYQgfYv
         N3lkZzt5fsFOPJKU0CZv/lNSlceL7iJ6iwBHtYxWcFuf6cyZZkq8UB8Aat14QbOXJg5J
         4ARSUjD8nlFQ4U8zgrXYSjns55lVoUYeM7TzchgRSr6fZ9WymM3lhEPh1DTE0huS2M18
         +JiEkq3o+z30xXTH6GKbrx1CB35z3FEHwHWLiaYVb/tZjNsHDCAvwrxpBJhJQfeTwxg8
         R+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVOMGFtbYdyvr0OfPUeZtbrw99wyP6JBzs1q5rsShYU66+EiezIrtSDVg+FcV95swkhi6XylMMtfXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPiDUNk2MM9KYGUai5btQrLtWPRcKhrTkzHL7GEzIaniDZxhJ
	icm3BGumHobYMxx5Uj+XG5G8YlCY4fQuptGfAnrT8IeEhLkHcbtF7tYnyWZmzZ0UacI=
X-Gm-Gg: ASbGncuVD8Bj0wl6yx2kHEW9wXe9tqohF2h4PfqhcIDuvQObnTb8w/0LmDJJtahbPRL
	5YX7xhJ6PijclWn8dtEk6a7G2XJbAyzd97e1d57rGp2rBUg/lTdWjcr/7RPHbBatr+adW2qWx2d
	stz3zI/RgUbd6gEpztx3s4e6LmiHaAka6ujN9yYYVXnUsS4FVTNM45u0E1OGaNPybySJy96iIj7
	Cw/PTLHIaysR94/WvQdep0gLW28Vebe8w1Up+ATCsZF5klLALNfl9zd5MTgkeofc+kTpV9oDtZQ
	8uYReCVFaRzfkXwMD5mImTLoc1gLjE3D4VQAUsLPYv7hxpUQ1zXh230kltlesRzqq2c=
X-Google-Smtp-Source: AGHT+IELSI+nHvc6/8x9c+zD3eFzVE2pjiOsqeuYSJZ1xJs78DtrT3WanbqFwCoHNk3vMxHy8BC9hg==
X-Received: by 2002:a05:6000:2013:b0:3a4:f7dc:8a62 with SMTP id ffacd0b85a97d-3a8f2f34f7cmr10696844f8f.0.1751280401373;
        Mon, 30 Jun 2025 03:46:41 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453814ae64fsm106803355e9.1.2025.06.30.03.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 03:46:41 -0700 (PDT)
Message-ID: <f4616741-9763-4221-b385-74c6d332b092@linaro.org>
Date: Mon, 30 Jun 2025 11:46:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
To: Mark Brown <broonie@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-6-178dba20c120@linaro.org>
 <aF73e/ggeycsYiaD@lizhi-Precision-Tower-5810>
 <22d69113-fec0-4405-872d-af76bd038c09@sirena.org.uk>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <22d69113-fec0-4405-872d-af76bd038c09@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/06/2025 10:41 pm, Mark Brown wrote:
> On Fri, Jun 27, 2025 at 03:56:43PM -0400, Frank Li wrote:
>> On Fri, Jun 27, 2025 at 11:21:42AM +0100, James Clark wrote:
> 
>>> In target mode, the host sending more data than can be consumed would be
>>> a common problem for any message exceeding the FIFO or DMA buffer size.
>>> Cancel the whole message as soon as this condition is hit as the message
>>> will be corrupted.
> 
>>> Only do this for target mode in a DMA transfer, it's not likely these
>>> flags will be set in host mode
> 
>> "not likely", I think SPI controller should stop CLK if FIFO empty and full.
>> It should be "never" happen.
> 
>> Only check FIFO error flags at target mode because it never happen at host mode.
> 
>> You can remove below whole paragram.
> 
> I agree it *should* never happen in host mode but it can be good
> practice to look in case something gets messed up.  That said extra
> device accesses in the hot path are probably going to be noticable so
> likely not worth it, but in the dspi_poll() case:
> 

Yeah the point was to be defensive. Even though it shouldn't happen I 
don't see an issue with checking error flags.

We could add a condition to only do it in target mode, but it doesn't 
make the code more readable, and it wouldn't be any faster than just 
checking the flags. So I'm not sure what problem we're trying to solve 
by removing it.

>> @@ -1067,6 +1080,9 @@ static void dspi_poll(struct fsl_dspi *dspi)
>>                          regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>>                          regmap_write(dspi->regmap, SPI_SR, spi_sr);
>>
>> +                       dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
>> +                       if (dspi->cur_msg->status)
>> +                               return;
> 
> we're reading the register anyway so the overhead is much lower.

In both poll and interrupt mode we're already reading it. Only DMA mode 
didn't have a read and I didn't add a check for error flags there anyway.


