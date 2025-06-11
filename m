Return-Path: <linux-spi+bounces-8455-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7BEAD5976
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 17:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A803A6344
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491AEA95C;
	Wed, 11 Jun 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fi0LKFUK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54C15E97
	for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654044; cv=none; b=bGPwHlt1NJbJf41MXpp4Vwc3QIPvzmZ1osj3U9n3RmmxRdcTSL/2v8nuu9vTa4YR2UF+F+FkpyNfLRqIo+d2tsgOYfL6HCFijJ+LJytXXF18nQJIsDFkciKD+7aUcoy9nprTWiDFfKnGVXCxH0MBUFRnz/wLN5NCjLoeNVv5hxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654044; c=relaxed/simple;
	bh=ya+nEh00fQFy2gMFSp7ZKYL/qH5nwJRnW3gq9p3hfHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gb3/2RcvxQkQNOzIwXAkhZ01efcHf9v+3dhTt4xDWRlnccFypGGNEZxNCbqZnkaQi7FtYxDkSRNLYfsp1PJAFZg2NtMGo1HgXOroTjdCh6mwIyGOGGPao3/Wc2SkMl8yqwR1NmN3U9szxPHfSzDlKpmpB3/hh4IIOxr8nI0azC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fi0LKFUK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so741514f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749654040; x=1750258840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edmPMFPNCGBbcUfHWPuxKmJMbMtdOOjJESV7iS8XvxY=;
        b=Fi0LKFUKB5XBOgG/oHpVl+1vOwc3p6LT2ai8cghDi5BWvs4GzUOmOYz3o3j1jKEEo7
         myYI/pTYE/e6t+nWvcF+p4Yma7CouO4/yEe1Vel5OQgZXihIaYdjyJCvlcJL3Yuz5DSg
         djnc+7LLoDQQWIj8kuZmFq+IxH+/o7MGv5wTf4n69M6hRpiSv9qq3C2HsNw29369AJql
         X+6uUjGieK1I1mfv8JB8QW8HxlR7liXoB99DIi/0QsIiPrgoaiWWZa0t769qSyW65WMr
         wbz2hRKKxMC+pzAXV7OZASXlvTtLxFOWQ+ffGjjjPvGL93fLnDpl3ZenseKLGXw9Nour
         sG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654040; x=1750258840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edmPMFPNCGBbcUfHWPuxKmJMbMtdOOjJESV7iS8XvxY=;
        b=q3VcRHGx8sJkLq/fRlkj6+BQN2s3IUtGOuQT1+n+8y17INwxGs6UOApL3JZgIPBWTN
         TQjIVlcQ/6cGzuUH3vkv6S/iuDjQQtjo+FTaUrWuagYtohw0wOEOyvPHxsWnnpWVtEd6
         vAD8canIzmv7ifVstD0pC84MuXpW2xgWpnjv0JNwshkTNap0Ec1HwPZQsSEFs4pb86TW
         MIkYrYyy8yNwHMv6BtQkz0bDNeQDZqWKmLSeKcj22dszTyVC8myCpqx9ZI4rWxl5NM9Y
         7dGtyX89+CBxcVmiVWG6EUFqGY2SYpQ9fAE3TGLAA8BSE/mpDkNN8hF5SIz57w/2JI6y
         UGag==
X-Forwarded-Encrypted: i=1; AJvYcCUMvP3Ke+BeIHPJCWZCjbK8NFv/dOmC0dhr9BdzZOPZf94YwDJBxLHc/O8eM/z+W8jrwuDpKOtk/vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrUjvS/VX7jTGyUt+KjEoI9GK9d+IbQ2nJQE6YDpx6K6NIy/5
	5GLKBE/WO9OQRmtvTxAU17xLTMOvSph3QizJbThkOWC82gWB/Rj4WbCdir1ogEe5inw=
X-Gm-Gg: ASbGncvqaN7MTzK2cZT1KPxghzuhtNbQu/V5l4/JW/yU+lSqI7SAs8qUzpdXTpP+iVY
	zoSU5YHZGi15td16/QDlytEKKmKaUUlsBLsT+sAv2n9UcNXlJ5Dj8OwnfILTcTkq8kfnQFejays
	FbWDs4JcGcUT0vOytU9PoWNWnIzPYrea31XH0FyJHF7PfSjDZHWpZtSPHrTC139f8kwDeWJ9Oyq
	EV6Ist6OQPZLLCxzosWIHQfDR1xRlm0CzQKnbkLTkn+8gEAhRqUrhG5eLGdTWjdDRB1czkYRHfx
	Nv0Fx2xPqw4H4xk8KS7EPDXS7g9OAWzqHHFDnZ7NEeuFpW0SeuHBfGgL6NCE3p/2ZvY=
X-Google-Smtp-Source: AGHT+IEzzhcppUbW1+BdtVXwBwJBi0yjHM3LGcXgg4DBHtCKKJdkIrDeqab0FDLQ5lwfVDcVY6scNA==
X-Received: by 2002:a05:6000:18ac:b0:3a4:f70e:bc25 with SMTP id ffacd0b85a97d-3a55825d69dmr3535626f8f.27.1749654040196;
        Wed, 11 Jun 2025 08:00:40 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464e3csm15804587f8f.99.2025.06.11.08.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:00:39 -0700 (PDT)
Message-ID: <472a47da-e442-4335-92f3-9a0263107fc8@linaro.org>
Date: Wed, 11 Jun 2025 16:00:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] spi: spi-fsl-dspi: Report FIFO overflows as errors
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-4-2b831e714be2@linaro.org>
 <20250610215233.35ikv4sslkyukgwr@skbuf>
 <d95fbd83-995e-48ca-bf23-147caa80b9e1@linaro.org>
 <20250611145634.ncbzl6wwwxlidjl7@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250611145634.ncbzl6wwwxlidjl7@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2025 3:56 pm, Vladimir Oltean wrote:
> On Wed, Jun 11, 2025 at 03:40:40PM +0100, James Clark wrote:
>>> Also, could there be individual error messages for TFUF and for RFOF?
>>> If you are concerned about the penalty for the error-free case, make the
>>> check two-level. First for all errors, then for individual errors.
>>>
>>
>> If I was going to split them I would probably let the compiler optimize it
>> whichever way was best. The real reason for combining them is because
>> usually you get them both together. As long as the message and fifos are
>> configured correctly you'd always get TFUF and RFOF at the same time and I
>> wanted to avoid printing twice for one event.
> 
> In that case, why not:
> 	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
> 		dev_err_ratelimited(dev, "FIFO errors:%s%s\n",
> 				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
> 				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
> 		}
> 	}

Yep that looks good, will do that


