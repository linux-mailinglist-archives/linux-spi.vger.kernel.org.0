Return-Path: <linux-spi+bounces-11757-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CE4CA36BE
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 12:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14865314EFEE
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B05332EA2;
	Thu,  4 Dec 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKSYdNdr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8422229B36
	for <linux-spi@vger.kernel.org>; Thu,  4 Dec 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847307; cv=none; b=s4oDvH1c7fiH9F4zKenVR1Jqa3+w9C1UfHteDMTHYua2cYkzreuWAN5QI6U944vf3E8a9sUdh2Iop8bhCGv51adE5A/5BHCa8ssJej6GJOFO3kQ7fZHimxaR5c8vpK9vcVK02ZL+GDlQLMu55dnCVX6bGwusMfX1JuuTkyRB1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847307; c=relaxed/simple;
	bh=sa2/rwfPU/3AWe2gcmw+J611RZJxXkFCln1XxUj6HfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8SC8Go5sQz+Z03LCPXstChdTdIeLm5j/k0Vp4z2y7gkkc94+hDOPSsRbqvmWIP++VN1yxGZY0DlGlznvqdw0wEgwc/grI6auMH7b2EEUge/ZBRIJcmX7nD+fjSTyISkLNj7dGkZSF9ouZLADoI9SXsV+wqHV2Rmoi9U768hSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKSYdNdr; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so7059225e9.2
        for <linux-spi@vger.kernel.org>; Thu, 04 Dec 2025 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764847304; x=1765452104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCeemqjPzYHYloJnabZFEtDRR32WJAjkgl70eCbv6ZY=;
        b=QKSYdNdrsD0eBvZOgEeG7YYQxkierAyXZts/buIdVc6kTcDqx+XMLvvOKl5BGCNd4K
         1CEr8r5Cgiq0j9WN7BNmS4P5DAfOBs3dJR7ekHYwpLiA84aKpNxXeVk6d2nXODw1x1k/
         8gKGnLoCS2WZctrHx6KZqrEcoZBzVBwyZIuxne5WpkZX0o/BecO0aUUgEpiWANk6kNkh
         lenavRNI0iqjc4gjBp+Ofwr+klkTSXZtTcJGkQOv8tW3emJ2I/Q7OZlQloKaWBn4y5GP
         QGJ/qSrSGViPbuSF6acrdGFV2G3FpJyu6tCaySDYL8lZjm/A/5ZGv8/q3dXr9fytJU4C
         raNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764847304; x=1765452104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCeemqjPzYHYloJnabZFEtDRR32WJAjkgl70eCbv6ZY=;
        b=byv1usUrBeE/4AY2dDK3FKVCguW6wCulz9IEgxUz+YMqaFvbvzRAh/mDKo2yz3O4ss
         03MNgEO9YWCpw1y/o9O+jYYZZCHvCux0xEaGUhwWvlpY0DRY/lRmiy6rWdc9ZDx5kcgV
         XdS8/QrUKxevlYmeJigTMG4xU8atmUy6BUZzN/7Dt24JXrwX722yyZ+ddMJj7YEyHJpf
         sZjGl9/YFdb4Rl1ISLARAyfJljdBTVAo5C7H3qRbH1ctiBI7FAQ9Knppmj1rJ92ezWo1
         wnL0LxFcW3ihvyMZdUJA1fjTINGaP9B8UxRmmnnJvRW5gpv3OWarnAc4rBjTx2eZ2PB5
         6EQw==
X-Forwarded-Encrypted: i=1; AJvYcCUevzWD7ItOleRhPzL9AAPGbxf1CaO8Mhofi9oBCSTHXLBlY11CZj2+M1xe1uK0mPRNGFFO0byUmQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysABU3hCbtGrnGDXFQWgDNgv/48Y0eU3jw/detlMglwANia3k+
	UGTtrvgIFDnijallb0kkRwhyZP9/ho59ax7h6CTVJc2fGLnpa/t1gzvOIKylhzd+
X-Gm-Gg: ASbGnctyjJFTDcB93WlHUQQrUgJGOUygZmfWcGS4jdz+VPax+OhVt2JbCg9gAA9byiZ
	VA63uJ4GGz14N3d+IXzPowqfMdtE0KoZDyuVB4hht6/5ytfOZJ/c2wI2E6zvWnIkmv3KwEMD6R/
	hUW0fdP7HPiHovTX3yizBBW8acx+qPuB6uYuRvfWOFPvLCWwInVdkTNbVgtcsX7ctq8qKsOx1T4
	+w5xNUZIzJZ7f2NoHrPsooSsHgJUlqy0MjPPY3Yov3jMiAqvf/lfi66BPDFA6q94Ewr9pBVgcrN
	zdVDmBE/BxFe/VKoiLg6ABeJAwn+FFIGngwQceuZHdXSKYErHUYB7jii8C4YNLxo2o2eEo9nnwX
	+v7PhiXCiZgcmfpdZHcaGg1MoJz/ApK37dwhZflCEwkJCTgIH9xEg6bIA3k5XHfDk7P3DVpG7uS
	uHlJf1rCysA6F2LFSRAAlbVNY=
X-Google-Smtp-Source: AGHT+IGxmFRNJ8vn/Q2VqFXfGRioN7Ju+TJs2Elh9XqUj6Bh3lwZ7KYSxHy4ZyqIZ1rZ/qGb/V57CQ==
X-Received: by 2002:a05:600c:c490:b0:477:7479:f081 with SMTP id 5b1f17b1804b1-4792f25a030mr31401535e9.12.1764847303826;
        Thu, 04 Dec 2025 03:21:43 -0800 (PST)
Received: from [192.168.101.7] ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930ca15adsm28420305e9.13.2025.12.04.03.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 03:21:43 -0800 (PST)
Message-ID: <27c926bf-f889-4e54-83c7-28134ca84899@gmail.com>
Date: Thu, 4 Dec 2025 16:21:40 +0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-qspi: Fix runtime PM imbalance in probe
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, khairul.anuar.romli@altera.com,
 adrianhoyin.ng@altera.com, nirav.rabara@altera.com,
 matthew.gerlach@altera.com
References: <20251130091251.12120-1-alitariq45892@gmail.com>
 <aS9RKnScH2DVXW-I@black.igk.intel.com>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <aS9RKnScH2DVXW-I@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the merge. Recently, there was a patch which removed the
redundant pm_runtime_mark_last_busy() call:

https://lore.kernel.org/linux-kernel/20251203181921.97171-1-akifejaz40@gmail.com/

The patch removes pm_runtime_mark_last_busy() from the probe function,
as pm_runtime_put_autosuspend() already handles this internally.

Best Regards,
Ali

On 12/3/25 1:50 AM, Andy Shevchenko wrote:
> On Sun, Nov 30, 2025 at 09:12:51AM +0000, Ali Tariq wrote:
>> The probe function incorrectly calls pm_runtime_put_autosuspend()
>> twice in succession at the end of successful probe, dropping two
>> runtime PM references while only one was acquired earlier with
>> pm_runtime_get_sync(). This causes a usage count underflow:
>>
>>      cadence-qspi 13010000.spi: Runtime PM usage count underflow!
>>
>> Remove the first redundant pm_runtime_put_autosuspend() call to
>> balance the reference count.
>>
>> Tested on StarFive VisionFive 2 v1.2A board.
> 
> ...
> 
>>   	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
>> -		pm_runtime_put_autosuspend(dev);
>>   		pm_runtime_mark_last_busy(dev);
> 
> This one — pm_runtime_mark_last_busy() — also may be removed as it's integrated
> into the _put_auutosuspend().
> 
>>   		pm_runtime_put_autosuspend(dev);
>>   	}
> 


