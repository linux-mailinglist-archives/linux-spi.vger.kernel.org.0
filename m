Return-Path: <linux-spi+bounces-9512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B3B2ACB7
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06D65E1B74
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB4256C6F;
	Mon, 18 Aug 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ArY4HTC0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D019007D
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530567; cv=none; b=cKZSH9jaDKqZeW377ebydcbUHTGXfBE6asHLwFmr/ivDWvMxVucnndOJPk50DbPpjSnst+NTx4GvdWSTLgr/VZVX7yMSkePri7pquv0dwxqEiTs83pes5oVqSke0ORD0S13owb1ksgCtFhVeQUHofz9LzgYeVjnu6a2Ks7WHaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530567; c=relaxed/simple;
	bh=cL/BkRePawzT6v72IhLPr6FG3t3IqCKEZ0g1meuYxH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txL0cfsMeu3AdSPdHQ5ycEWJQvsUMBXi3I0GsYalcsJp8FfcqeVG5YhUO3pcrrNf5FzrxvIX0NYRNollewPVMUgLUJn62fcW5ShpWeqNzFarTMWZHtehhSDQB8zx1gYjxyDQfXRfF1HxdkINlIKLoyG3M0Cs+q2cwpvGOaCDQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ArY4HTC0; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74381fa6b15so2484250a34.2
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755530564; x=1756135364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTxGCx4zj4KRJ8B1DI2WEkLZlXQbTwcBBSMe4+Qh/hw=;
        b=ArY4HTC0Vs+Qzk4A7RbeiR0uhQcLYIQQJmOsiUPAvKYaIAtEquqJC9OPdJ6YEQVArt
         DTgXLZa5UfY74Fd+lXPMf2MDLctEQ0ft3DmRhetxd/gaXFxQdljYa9ksyCyQOmAsSJEQ
         GMMD6gyLbzbr1WtC9i3kwffESu05EiQO+MmFJN/3uXV4i4mERcP99LcQsdErx2OTLG56
         vmjBNiTBVOVE4srAE66n5FUyM2HlRZTQcsIT90vLzoeXM4cFPP6BOafp6icDWnxZ6UBo
         WtwRb90kWxsSMTO+nOpIj/z7CvhmBQAZfhz5e7X88yMIBjnXXFZXf0lKIXIR4pEkDJM5
         o89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530564; x=1756135364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTxGCx4zj4KRJ8B1DI2WEkLZlXQbTwcBBSMe4+Qh/hw=;
        b=aEkhji4bkBoe/2Go62JvsSNG9Ntat08mr4s7vIcRgcS6rd9d7iHEh9PlXD9KfQxbxd
         VmgM89q5bn9QjJDJ9i1NhD1TJ5WBhem1NAdqSE7l73zadakdYj/7zzevFTIksBYhER5d
         lhIOBVvHTMNeDRtGas+nDaVB+GYxAEqsTsPCjJyADpSuFN3QAx9hBW8aEu52GwBvLFGG
         j0xOjQFz0nlcQj+3FDvREgf6PXZMq1bj/2s0YBEnUSyHwCFpOr5sqiuBGRwVlZBTJcN7
         TboUFLCfgLEycxipHmWD/1uq1cr7PXu62f9c4alLLBj/vy+oTrjS1XEWedLSIfBDlrWD
         Je4A==
X-Forwarded-Encrypted: i=1; AJvYcCXcXmSyuUpX3lLMGc5g9BySk1l1/4p+s31R3ww6i1mv54gOYfOzG5xZ8IoqvQ6QpbPqbUUPBtPWHOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1oUk99pmqnhOtNOd5aWpTtthqjw1arX9cI9lkvpIb60MjGA0
	YRGQZolkIclYZPP7sGUufs247B7e41aYTsjzzcdM3sOElYEibJ94lOz+neEN7Z4a+P8=
X-Gm-Gg: ASbGncudqoD6QuI1hpZOC+F9rGKiqNK38LXETK+bgfvGOimhz4R7F7jrDvZUrJnkLqW
	dR1AGEzu4r4nf1wnA0UiPm7p4SGHIlQcuI/Chdaiezg6lkUyGOgyoSllXZl4/gNYZjXHg2L/IXp
	mV32TUcjl6yx+tThqtc6ZgAXXTYmABIOFzixLCHVEM0Sf7i6aJDDOUNLz1r4mrUuH/6lWCbq1we
	M7/uqfYcWs80wZKt1RKKAQ1iofArEW3c7eeDPtqN9+c9o/t5mVUjYeCjvfo69GH7knyscJr7GWi
	72MOkjOZC+5DF+U98t6P+1pgkPMZI+wzm6aX4VIClyNgpPKClVLI73aqLxFsf1+La5DJD7gsJR2
	pxOWa6i6Cj0sPwxR5OkDnrC4lF2KA5XWSIOPeyoMbQzrzhxj2kbYnw90y3JkrQACyT+jZwdQ/F1
	w=
X-Google-Smtp-Source: AGHT+IGPBTHW30IdobikaWZYenZffvlRVfNOQG0PIn6NtUluKl6ZS29TrtJlRc5HqzQnb05egqYH2g==
X-Received: by 2002:a05:6808:50a0:b0:433:fdfa:913c with SMTP id 5614622812f47-435ec4c9ad7mr6463423b6e.30.1755530563885;
        Mon, 18 Aug 2025 08:22:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1bfb0bsm1759838b6e.22.2025.08.18.08.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:22:43 -0700 (PDT)
Message-ID: <0b9a3b8b-11d5-4722-a7ea-e80d893bc209@baylibre.com>
Date: Mon, 18 Aug 2025 10:22:41 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
 <87frdp119x.fsf@bootlin.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <87frdp119x.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/25 3:28 AM, Miquel Raynal wrote:
> Hello,
> 
>>> +  spi-buses:
>>> +    description:
>>> +      Array of bus numbers that describes which SPI buses of the controller are
>>> +      connected to the peripheral. This only applies to peripherals connected
>>> +      to specialized SPI controllers that have multiple SPI buses on a single
>>> +      controller.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    minItems: 1
> 
>>
>> Finally have some hardware to test this series with using 2 or 4 buses.
> 
> Out of curiosity, what is the practical use case and intended benefit?
> Maybe an example of such device and an explanation of how useful this is
> would be welcome, as it does not seem to fit the initial spi idea
> (which has been greatly "improved", not saying it is bad, just unusual).
> 
> Thanks,
> Miquèl

From my side, I am working on supporting complex analog-digital converters.
There are many of these that contain multiple converters in a single chip
and have multiple serial data lines so that the data from each converter
can be read on a separate serial line to speed up throughput. And in some
cases multiple chips are also used in parallel to the same effect. I.e.
all chips share the same conversion trigger and we want to read back the
data from all chips at the same time to get max throughput.


