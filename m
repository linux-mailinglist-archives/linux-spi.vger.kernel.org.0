Return-Path: <linux-spi+bounces-11226-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E79DC5F41F
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA31B34323A
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3930A347BC6;
	Fri, 14 Nov 2025 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Q38ab+ga"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED53469E3
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152635; cv=none; b=YciWEfFF/MmbmL0EX6jKn83Fu1Yv3xqB7kyloik35eh2DMfmaIQn+F8tmEVmCYIF6UODxmf9NuLW+3KMNaHi7efnu51mtrrPNuM9LzsElcqq4+v1WsRUp2ZYG0cBNJf8d+XzJmHzUAz9/i/q/6tVzCysElLj9rdq+OwYKcEHgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152635; c=relaxed/simple;
	bh=GGyKMqTOrRRlYEJYyUkHW1qKj7v6NPI6LFAqWJU/hiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0PSrsHf2H/A0OKsMrFzmEQlJPLZo6CIFOEtUZWrz6C0Dgowe6u2fpNAg3ry8O5jZtqswibY/TXELiABUEPTdgH9cWPeqrhZITmMDi2yMaZqw0t63zFuTgZr0R3aMhjj2TfEc+xszDdNMqrd7SXRTMJGG9TfNYLbdVupUaxo9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Q38ab+ga; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4330ef18daeso9673265ab.3
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1763152631; x=1763757431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2N7A4sphnOSNn2VwNdf5jHhtrwzomqOxdOIMs+gXosY=;
        b=Q38ab+gavCU15c+Fxvmt18MiM1RenCxHmu0VbqCNvEHQ8Tj6N15WEVC9hD5Ia/eihU
         v4H533qEPSeOxurIPJswVHtJx02kHM6EEZjoRrlnbfv073Gn1AoifVvvtDHgYRE+18zT
         QPqFXTbR1y62clTZWZc25Iaxll3kGNaueVcgm1a5anC5nVtucsR6YQI2bebsY/TfUPBn
         7YFEMGjxOjS6DwF2wroruYAoN83fNCmhgctQOX1ipq6jyeYrMJkBGXmK3nzxydNH9C+5
         2ALAcu7y4z28jolb4fac8dzxDET6KL+cQIOODmKir3VYw5V9bmj/bk7nN7yOo00lb7Cw
         PAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763152631; x=1763757431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N7A4sphnOSNn2VwNdf5jHhtrwzomqOxdOIMs+gXosY=;
        b=LMgZATV7e5FxgGJtSsXZa122glB/KNeS6ITCZGKqq8ebSklq7kTcj4bZDnw3gZQWIt
         wVnCvQLwe15Ojeewbzfx7DsYpyyf20B/9N2oEvqRGrhASyPK8tirtNe2+cNSXg6NTC38
         3I7/fAua+ziq3HwLcd8updYiigQKLGS/eqKh0orUaekND2ciBKvHOSAxdcFGogSVrd6n
         8cZfo56DbHOkBoLSCkFMnh5KjxkxQO3VHBYwWJTSrAI1akSrYZ1WwTvzqMBYw9CSRtvJ
         MIHZ2Clt9FBo7TwK7ldv+4dPa6xNEKM6BUt5iOb0Ht3/NQU9TrYyaflhOlIJXi5cOwYK
         8SFg==
X-Forwarded-Encrypted: i=1; AJvYcCX95DwdS32MjGPjuOzoityWJ4iBduqSG/Tikmbe724f0M0T+hE72wHU/Kvc9RfJdZ+iNKbhGeYTNUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOzmcnI6J3CYjPNShw5/NbreZIJGvco0C/SuakRrXffCx6Q7E
	u2XJrTKaNanyIzXIzcjPfWMsX8w8AXhWMTdcn/CeJX2pMr5ptKju4IAP9X/fHj7A46M=
X-Gm-Gg: ASbGncsohZaX3LwYUPn+ANp7CifJpP/m6MpHUJ86RRXcSg5yd95Ol+t/9xVciXJRyOq
	bvzM2IdQ0oHFpg3Z3+GW7JiH37uitVmcCbxsW2Jk3YXAskwnQLtavCgWgBOdfysC+NFiSqeIWrM
	RbJ9MceNZrp5mlvs5vtkwJulmBQThSY2ibLUUJceD4Qlbx4yuuVCLjF01CK4Jpnz7Qx/6bnq49k
	21MFTgEErC5MVvXUHCDOOoNsFiQmdC4DlAMvHAZ9a0rg427qI+r/7HqjSlfn7q1gjjPUuY4uX+m
	FhsDKnxwW4xAjWTxZwTaaZ4mEnfbeEq/IhUZwgooASbAG9pvchzc0rlurF/w9tEHudFOg7NWucL
	LjxRjmBOKMHe9l4e8oxsaUXZsD8Wm47/jUGUONKccNuNAklrzBH+wDn8P+gayArb9ng3Pdtmkhn
	4Mzeb1U7BiSnEbsq+/h3QOulcmzuWNzDjzqaD38a+3IzcLuZ1eHpapHJY+YEww
X-Google-Smtp-Source: AGHT+IEsFHp9+KTrH36IfqMNkMBqKDdgRHUJrYhyOx128Vw+1DZKY9oKj4WLZvRXlvy/+FFiqg/IEg==
X-Received: by 2002:a05:6e02:3c88:b0:433:767e:8f47 with SMTP id e9e14a558f8ab-4348c954ba8mr72409145ab.29.1763152631499;
        Fri, 14 Nov 2025 12:37:11 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833c5eeasm33471855ab.5.2025.11.14.12.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:37:11 -0800 (PST)
Message-ID: <939d76d0-a535-4d7d-bc3b-9d92be9b782a@riscstar.com>
Date: Fri, 14 Nov 2025 14:37:09 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, broonie@kernel.org,
 dlan@gentoo.org
Cc: p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251027125504.297033-1-elder@riscstar.com>
 <20251027125504.297033-3-elder@riscstar.com>
 <FFC4D2691116C9D4+aQAgeeG28SpSI7YR@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <FFC4D2691116C9D4+aQAgeeG28SpSI7YR@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 8:46 PM, Troy Mitchell wrote:
> On Mon, Oct 27, 2025 at 07:55:02AM -0500, Alex Elder wrote:
>> This patch introduces the driver for the SPI controller found in the
>> SpacemiT K1 SoC.  Currently the driver supports master mode only.
>> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
>> supports both PIO and DMA mode transfers.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/Kconfig           |   9 +
>>   drivers/spi/Makefile          |   1 +
>>   drivers/spi/spi-spacemit-k1.c | 965 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 975 insertions(+)
>>   create mode 100644 drivers/spi/spi-spacemit-k1.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 4d8f00c850c14..2e933edab1718 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -1071,6 +1071,15 @@ config SPI_SG2044_NOR
>>   	  also supporting 3Byte address devices and 4Byte address
>>   	  devices.
>>   
>> +config SPI_SPACEMIT_K1
>> +	tristate "K1 SPI Controller"
>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on OF
>> +	imply MMP_PDMA if ARCH_SPACEMIT
>> +	default ARCH_SPACEMIT
> SPI needs to be a built-in feature?
> if not, how about:
> default m if ARCH_SPACEMIT

I finally implemented this today and while testing I found a
bug in the module removal code.  It's been more than two weeks
since I got any feedback on this series, and although I've been
holding back on posting I think it's time to send a new version.

In addition to this suggestion, I have two bug fixes plus your
Ack on patch 1, so I just posted v7.

					-Alex

