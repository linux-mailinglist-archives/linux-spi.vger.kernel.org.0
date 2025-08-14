Return-Path: <linux-spi+bounces-9447-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA3B270AC
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 648594E1860
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840A2DF68;
	Thu, 14 Aug 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bQYXtUgw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EF319876
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206270; cv=none; b=Gti6dgVbf02tFJqSCFHlfBVEEESuYk2giMY9Hfb5MYWSgFMo7UQAQqDgwZDOL4kFAqA0ltrbYq19C99yzYl3LNnlF/QL6xH/ffHUvBMIX+9s0N+uXcErY9pCl5sU6RFCe9BNTMYxVtAa6UQOpfEIGtEv4ncAyvKoI26AQsX/l2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206270; c=relaxed/simple;
	bh=DCZK9o5mP8yYL2GAfmlgCA7k2kYEuHkoYqzOvAh/Pec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDA4wjaaOaFMDbN0bV15WdBw24yCyatIiVGcGe0Kp24W1szDCk/AY3/OZai9UXlDj84jiJaSmoF4UszgrRg9SlYokEAu+UWjl6UZCk4l+PCS7aW9iRMnLXxBb5dmeJiV7fIp1o6X00dOfr23Ne5nYfDJ4XDDi5FVlngasSBL5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bQYXtUgw; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-435de7c9b6eso486201b6e.2
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755206267; x=1755811067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyCLhoYy7jyy9fXZUW6l5VbrMofMsKhJtElwy0Ukqwk=;
        b=bQYXtUgwGemBfSQyjy8PgeegDRVwqWHxMuMXRbL4li0udsnR2o+s/dC6mGPY8BezqK
         9QQWC9vz5fs1ZoXBjpqcnY/UiAiweBtairu34ADSDswO1GM6wIn8MspAoFvg2LjLfZvO
         7MMoaki+FRjUNFdl4O1EqUaRovga3B9Dt8UIZOKX+tHBbZOWVof4xNv2/oEsuAqM2g1z
         a0g6mqvS9O0yi0ZXngvg9ks2KOwFh14MOftthElsLCFngLrGS+jQ4VYteuF0PcAAFiEY
         n+c2Oqrw+bPc5oI2w4vMIGfklu/uUAzXZMnUp8jnOwE7YMrcCtGVROZdMDQdPMqFR5DX
         9/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206267; x=1755811067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyCLhoYy7jyy9fXZUW6l5VbrMofMsKhJtElwy0Ukqwk=;
        b=e7qXanNLdaUnqIMY5RKZfGaSRpGJtux2LoEfP/EBG/e7n/rOPVUwqXNsQNXZx4yJi8
         cU5zQlubhygLPrh/lRAZE0PP+tNsmpDtvciJ28cuuhU+h6wix1wMqHoo7oEn0jioy6G/
         rZxzyybqQ8/mCHQaEtVcfToAN0fFuqJ6rVH6fPB2bmmvXM65sC02XvnHLVYSa+tgqp4y
         6jApjQXjQQbXyMynAVdX8Qpcc1gX0Y4MpDcoH5A5yBYif0Hpq/12xaBi4FhRjK6rGNJW
         hTRUz/9tINDQjKGHdJJ7s2fTvbJu2RFmAHsbrxYJUK20O80Uvfy+gXtepS8eVQ9yFBbj
         lFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqS/NaLdyaWoQcgCI+R/U2146w9cN9tpzW1qqOkfrgJJcnqQdIRBIIR6uswPNzeMlTl6T6W3Jjavw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/T6m9RW1fRAWEDRe6BSfsVG+Zi6oNdRIHocC/Fs27yny3O6S
	qgKAvovKjHH/wzFluCobXM69y6HCbS7W5wqZOWhckFzK0bQguFLXwojOkkLFxFjMwMM=
X-Gm-Gg: ASbGncsCBcwF5HlAbeiEViqocMK0RzTRGiBJXOTfV+lSIjIV6Fqx0++eTzUMeW0s2vV
	HwvBSFqKd+gkQ7PM4pxeVExRjsCI9w6rRp6wZUexTO7tH1LbhZ1jWt105gw0Qm5ZSo1oMENXkK7
	isLdqILrHjRy7Rt10/4hf+A5EyNSRhaSWpR8FoV0A6FVwqIJ3GClIyQxnhF+CE2fof65KglD0H5
	byzImIeZEpXZn0fL6afjZ9Oqcs/gTFGEa4QKW2Tmqjnb6YQaCY6J8gucCAg5xsfIlBPdNWHllAT
	ZLw20qJgtBG2KDs83SiNzr8t7khYtGl8j8d1k1uB0iSdL7L4hLY19g4yWlaxT8a5TrIxKWBG5rW
	Z482rs1hxqu5wNSLeJYyv/WnN30fFqtjKbUemCOYsuxf63yR+GXnTJc9kzuxoFOQABdy3mChZ29
	Q=
X-Google-Smtp-Source: AGHT+IHLwc3eKl5bHyawwGLuUnTbJjGRZty13s2Nm04iMLIbVVsuSQ73l1ycimhqcR9RpsB41KxtMQ==
X-Received: by 2002:a05:6808:4f24:b0:41c:95a3:8180 with SMTP id 5614622812f47-435df7caeabmr3019825b6e.20.1755206266927;
        Thu, 14 Aug 2025 14:17:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce6fe528sm1217497b6e.7.2025.08.14.14.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 14:17:46 -0700 (PDT)
Message-ID: <5bbdddaf-4ff1-4cff-a933-143160896717@baylibre.com>
Date: Thu, 14 Aug 2025 16:17:45 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
 <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 4:15 PM, Sean Anderson wrote:
> On 8/14/25 16:55, David Lechner wrote:
>> On 6/16/25 5:00 PM, Sean Anderson wrote:
>>> From: David Lechner <dlechner@baylibre.com>
>>>
>>> Add a spi-buses property to the spi-peripheral-props binding to allow
>>> specifying the SPI bus or buses that a peripheral is connected to in
>>> cases where the SPI controller has more than one physical SPI bus.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>> FYI, Mark's filters won't pick up `dt-bindings: spi:`, we need to change
>> the subject line to `spi: dt-bindings:` on the next revision.
>>
> 
> Sounds like he should fix his filter then.
> 
> --Sean

No, this is a documented expectation for contributors. [1] says that SPI and
a few other subsystems want the subsystem first in the subject.

[1]: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html



