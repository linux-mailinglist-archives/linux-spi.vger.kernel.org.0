Return-Path: <linux-spi+bounces-5945-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C529E7B61
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455841887C36
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0766322C6F4;
	Fri,  6 Dec 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BPMacl72"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271861B87D6
	for <linux-spi@vger.kernel.org>; Fri,  6 Dec 2024 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522684; cv=none; b=I1dO07zktGr/gzK+Yyc3vhw6SbIz5JPcWyMZJ1yOytZa/CFIPe3oishoQXevTIXVvEXEk4M1HeMm8SE4kcXDaPldK4dDRmh9Th+sCEpUBOgTq8HRa8410XhchMQVr85Za0/6SqiAneaGMbJS9BJR5slS1dvvNOC6+4mlyBMxFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522684; c=relaxed/simple;
	bh=X6L57zD2DnepAMNNeErTtgxtV19S6C3yjS3la8x/PBE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ohJGn3fk1B7Kn7uOkAIlS3v+tyxwTVRuScj4+zB3OWMGyKwEWOQ6DEqEbPIFRvPL1gMTIIlQXIqJW0poZQnOYeCndZdBVibAtgi9+0grp8IRiXMokpELXD/Bcm3/B0oBa8mYhDEY4OUxBiShnyGyEEYyqneWasYSmxFFQHYe8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BPMacl72; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f1d2487b95so1008622eaf.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Dec 2024 14:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733522681; x=1734127481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HhPTP3mLUFs0b4KyXIJG/kRypJVEZYMjZF4cvng/bMM=;
        b=BPMacl722pwDymm9O9Vu+JAltLaWUA/24yH2B0J8Ke4iRUXlCFDe++Mh5x0eOk+41j
         cbABQB7sts9Xa01bV9KobBkYblFxTC/rrTfJHANXRTeGNrNpB6AEeFw0FcLSc8tbmay1
         PwW+U+nnh3BcV/+kDZvVF5tCpCGeTLUjAo6LaaHhxrvie78Wz+fRAP4prlsmPhWigSXn
         O8JtoWBHsEAIvQSrITPr4Yd2Bm1t4Taskr9ZSh+Ao56PTw1vlexwtZeNiBsgBDFUIS6l
         95ybsKm+MCdkE4DsOnqeJ7Wjz1GfVFaYSX9Vmx3+dA9RDOehm4XpZT5aU9n3n/9YPnrY
         aA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733522681; x=1734127481;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhPTP3mLUFs0b4KyXIJG/kRypJVEZYMjZF4cvng/bMM=;
        b=QaLtZjQlVgH0nY8ZHCF/9920+IIuBc+qomE6kJCPAQOpqRQ+9Plk/Ff8DnwmtQ0XzP
         M+s1yrUDCFZAuCkBfhXV5hv4X78+IVKgacNLG3XzMXTZ3WmHZC6JcMWN0yFRHrmtYXBa
         F75Zv4MWL0bAIp68MsveBth+e7VM7D7+L2FPOBsn9Qnc2QnZzraBj9QbuSsWBMHbRHpr
         qNMamMKiKvwSg3nctGo/rmjg9BQaq2WO3rVYK8wVD/05bqI9zDd/gzdxBtCR3KyoAFnm
         00jCoBySH2k8bXNZ5JgKmwBFsQIIr6+tg8GlJdBPUwOp97VM10moYT4qRddI7J9XFxrS
         icwg==
X-Forwarded-Encrypted: i=1; AJvYcCXLpJOn0Gmlm7IW7Lq6iE6q2Lc+NU2JdbLrC+7q1+pNyh3T/aIat5V6g/kSS5xTRBbv5qdXQsk1JuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1Lh595QnOv4Kekp1TXV/0lNhfcjXG/wwJjQkHzFnVghdq3su
	/Uj2/I4QAnCCr/GDsye80HvrSTu3q2maZ6KKmBgF4Ic2adBmFWmNALf58qXF1so=
X-Gm-Gg: ASbGncsH2c/jo3mK6om9CzWxTEOSxjc2baaJzQhCkMZDibE0bB7yUcgW+2OnXag225M
	WnxZuSp+DvR8PeBGeeZ0FooHThW/F33c//bKkT4KazuIXszCU5CLZ/G1nbSNPr0soIXfwizV4+w
	rWksBtfWgRGJoj7r4bdgavXvlo66RsS6wtEa4Bqm4FZsWWn6/fkBHeOWWFry5iqnqiUkIKiUzk5
	FLh6mUoS1ojtJG0e4PkCwH+zdTC6ZvwglALxrWkFSH224okw9zKtMxtYxzfN9Uefw/38HKUZNxE
	ivQ7IZGUTKI=
X-Google-Smtp-Source: AGHT+IGJenaygINw2DLeDO+NUkwlrl8ROmHjE7GyUlhBOpNZ+bTO/GkfxRTtD0gXZ5q8Gu+9iig8XQ==
X-Received: by 2002:a4a:ec43:0:b0:5f2:37de:5817 with SMTP id 006d021491bc7-5f2870761d0mr2872491eaf.3.1733522681294;
        Fri, 06 Dec 2024 14:04:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc4a236cfsm935156a34.67.2024.12.06.14.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 14:04:40 -0800 (PST)
Message-ID: <21d2e190-4cb9-4090-9dfd-2bb250ba186e@baylibre.com>
Date: Fri, 6 Dec 2024 16:04:40 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/16] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-10-bea815bd5ea5@baylibre.com>
 <20241124171609.50c6c3a8@jic23-huawei>
 <08ccc3fd-a53c-4d0e-8659-92204d2c27a8@baylibre.com>
Content-Language: en-US
In-Reply-To: <08ccc3fd-a53c-4d0e-8659-92204d2c27a8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 3:36 PM, David Lechner wrote:
> On 11/24/24 11:16 AM, Jonathan Cameron wrote:
>> On Fri, 15 Nov 2024 14:18:49 -0600
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
>>> cases where the DMA channel is managed by the caller rather than being
>>> requested and released by the iio_dmaengine module.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Fresh read and I'm wondering if the lifetimes in here can be managed
>> more simply either by pushing the DMA channel get down, or dragging
>> the release up.   Basically I'd like to see them at the same level
>> of nesting in the code.  If it ends up being necessary to duplicate
>> more code that is fine if it makes this easier to reason about.
>>
> 
> One option could be instead of introducing a 2nd function, change

Oops. The new function is devm_ so would still need a 2nd function
but changing iio_dmaengine_buffer_setup_ext() to have basically
the same signature would still avoid the asymmetry.

> the existing iio_dmaengine_buffer_setup_ext() to use the signature
> of the proposed devm_iio_dmaengine_buffer_setup_ext2(). There are
> only two users of these functions. So we could move the dma chan
> request/release out to the drivers for those.
> 
> Otherwise, we can't completely get rid of the owns_chan bit.
> 

